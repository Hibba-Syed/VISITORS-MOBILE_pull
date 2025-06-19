import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/visitor_passes/visitor_pass_cubit.dart';
import '../../../model/visitor_passes/visitor_pass_model.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/strings.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

import 'components/visitor_passes_card_widget.dart';
import 'components/visitor_passes_filter_bottom_sheet.dart';

class VisitorPassesScreen extends StatefulWidget {
  const VisitorPassesScreen({super.key});

  @override
  State<VisitorPassesScreen> createState() => _VisitorPassesScreenState();
}

class _VisitorPassesScreenState extends State<VisitorPassesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<VisitorPassCubit>().getMoreVisitorPasses(
        );
      }
    });
    context.read<VisitorPassCubit>().getUnits();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Visitor Passes',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: BlocBuilder<VisitorPassCubit, VisitorPassState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SearchTextField(
                       controller: _searchController,
                       onClearPressed: () async {
                         _searchController.clear();
                          context
                             .read<VisitorPassCubit>()
                             .onChangeSearchKeyWord('');
                         context.read<VisitorPassCubit>().getVisitorPasses();
                       },
                       onFieldSubmitted: (value) {
                         context
                             .read<VisitorPassCubit>()
                             .onChangeSearchKeyWord(value);
                         context.read<VisitorPassCubit>().getVisitorPasses();
                       },
                      isFilterApplied: (state.selectedUnit != null)
                          ? true
                          : false,
                      onFilterPressed: () {
                        _visitorPassesFilterBottomSheet(context);
                      },
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: state.isLoading ? LoaderWidget() :
                        state.visitorPasses?.isNotEmpty ?? true ?
                    RefreshIndicator(
                      onRefresh: ()async{
                        context.read<VisitorPassCubit>().getVisitorPasses();
                      },
                      child: ListView.separated(
                        controller: _scrollController,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.visitorPasses?.length?? 0,
                        itemBuilder: (context, index) {
                          VisitorPasses? visitorPass = state.visitorPasses?[index];
                          return VisitorPassesCardWidget(
                            unit: visitorPass?.ownerUnit?.unit?.unitNumber?.toString() ?? "--",
                            name: visitorPass?.visitor ?? "--",
                            fromDate: '${DateTimeUtil.getFormattedDate(visitorPass?.startDate)} - ${DateTimeUtil.getFormattedDate(visitorPass?.endDate)}',
                            phone: visitorPass?.mobile ?? "--",
                            email: visitorPass?.email ?? "--",
                            profileImageUrl: '',
                            reference: visitorPass?.reference ?? "--",
                            company: visitorPass?.visitorCompany ?? "--",
                            isActiveCheckins: visitorPass?.activeCheckInsCount == 1 ? true : false,
                            checkInOnPressed: () {
                              Navigator.pushNamed(
                                      context, AppRoutes.guestCheckInScreen);
                            },
                            visitorPassCheckInOnPressed: () {
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedType(
                                  AppUtils.getServiceableType(
                                      Strings.keyVisitorPass));
                              context.read<CheckInsCubit>().onChangeSelectedServiceableId(visitorPass?.id);
                              context.read<CheckInsCubit>().getCheckIns();
                              Navigator.pushNamed(
                                  context, AppRoutes.serviceableCheckInsScreen);
                            },

                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                    ) : EmptyWidget(text: 'No data available'),
                  ),
                  if(state.loadMore) const LoaderWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _visitorPassesFilterBottomSheet(context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const VisitorPassesFilterBottomSheet();
      },
    );
  }
}
