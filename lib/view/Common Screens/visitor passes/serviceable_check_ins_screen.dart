import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/all_check_out_design_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../model/check_ins/check_in_model.dart';


class ServiceableCheckInsScreen extends StatelessWidget {
  const ServiceableCheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Serviceable Check-Ins',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: BlocBuilder<CheckInsCubit, CheckInsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding
              ),
              child: Column(
                children: [
                  const Gap(10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child:
                    CustomButton(
                        buttonColor: AppColors.red,
                        text: 'Check-Out All',
                        height: AppUtils.isTablet(context) ? 50 : 42,
                        width: AppUtils.isTablet(context) ? 200 : 150,
                        imageHeight: AppUtils.isTablet(context) ? 25 : 18,
                        borderRadius: 6,
                        image: AppImages.logoutCard,
                        onPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialogBox(
                                insetPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                isCancelButtonDisable: true,
                                confirmButtonColor: AppColors.red,
                                confirmButtonText: 'Checkout All',
                                title: 'Checkout for All Check-Ins',
                                onConfirm: ()async{
                                  return context
                                      .read<CheckInsCubit>()
                                      .checkOutAll(context);
                                },
                                contentBuilder: (context, setState) {
                                  return const Align(
                                    alignment: Alignment.center,
                                    child: AllCheckOutDesignWidget(),
                                  );
                                },
                              );
                            },
                          );
                        }),
                  ),
                  const Gap(15),
                  Expanded(
                    child:  state.isLoading ? LoaderWidget() : state.checkInModel?.isNotEmpty ?? false ?
                    RefreshIndicator(
                      onRefresh: ()async{
                     context.read<CheckInsCubit>().getCheckIns();
                      },
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.checkInModel?.length ?? 0,
                        itemBuilder: (context, index) {
                          CheckInModel? checkInModel = state.checkInModel?[index];
                          return CheckInCardWidget(
                            isServiceable: true,
                            count: checkInModel?.visitorCount ?? "",
                            reference: checkInModel?.purpose ?? "",
                            typeImage:
                            (checkInModel?.type?.toLowerCase() ==
                                'community visit' ||
                                checkInModel?.type
                                    ?.toLowerCase() ==
                                    'community service')
                                ? AppImages.community
                                : "",
                            typeText:
                            (checkInModel?.type?.toLowerCase() ==
                                'unit visit' ||
                                checkInModel?.type
                                    ?.toLowerCase() ==
                                    'unit service')
                                ? checkInModel?.unit?.unitNumber
                                : checkInModel?.type ?? "",
                            name: checkInModel?.name ?? "",
                            profileImageUrl: checkInModel?.visitor?.imageUrl ?? "",
                            type:  AppUtils.getServiceableType(checkInModel?.type).label,
                            date: DateTimeUtil.getFormattedDateTime(checkInModel?.createdAt.toString()),
                            purpose: checkInModel?.serviceableType == "visitor_passes" ? checkInModel?.purpose :
                            checkInModel?.description ?? "",
                            checkOutOnPressed: () {
                              _showCheckoutDialog(context);
                            },
                            detailsOnPressed: () {
                              context
                                  .read<CheckInsDetailsCubit>()
                                  .getCheckInDetailsLog(id: checkInModel?.id);
                              Navigator.pushNamed(
                                  context, AppRoutes.checkInDetailsScreen,
                                  arguments: state.checkInModel?[index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                    ) : EmptyWidget(text: 'No data available'),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    final TextEditingController visitorsNoController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title: 'Checkout for Ahmed',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              checkOutAllOnPress: () {},
              // checkOutOnPress: () {},
              controller: visitorsNoController,
              logIsLast: true,
              visitorsCount: '2',
              horizontalPadding: 0,
              logDate: '2025-04-04T05:33:36.000000Z',
              logStatus: 'Check-In',
              logByValue: '',
              logDescription: '6 visitor(s) checked-in from gate ‘The W Residences',
            );
          },
        );
      },
    );
  }
}
