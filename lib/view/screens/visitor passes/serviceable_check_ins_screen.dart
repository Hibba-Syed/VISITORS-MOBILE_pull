import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
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
import '../check_ins/componants/check_in_card_widget.dart';


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
                        text: 'Checkout All',
                        height: AppUtils.isTablet(context) ? 43 : 42,
                        width: AppUtils.isTablet(context) ? 200 : 150,
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
                          CheckInModel? checkIn = state.checkInModel?[index];
                          return CheckInCardWidget(
                            isServiceable: true,
                            phone: checkIn?.phone ?? '',
                            count: checkIn?.visitorCount ?? "",
                            reference: checkIn?.purpose ?? "--",
                            typeImage:
                            (checkIn?.type?.toLowerCase() ==
                                'community visit' ||
                                checkIn?.type
                                    ?.toLowerCase() ==
                                    'community service')
                                ? AppImages.community
                                : "",
                            typeText:
                            (checkIn?.type?.toLowerCase() ==
                                'unit visit' ||
                                checkIn?.type
                                    ?.toLowerCase() ==
                                    'unit service')
                                ? checkIn?.unit?.unitNumber
                                : checkIn?.type ?? "--",
                            name: checkIn?.name ?? "--",
                            profileImageUrl: checkIn?.visitor?.imageUrl ?? "",
                            type:  AppUtils.getServiceableType(checkIn?.type).label,
                            createdDate: DateTimeUtil.getFormattedDateTime(checkIn?.createdAt.toString()),
                            purpose: checkIn?.serviceableType == "visitor_passes" ? checkIn?.purpose :
                            checkIn?.description ?? "--",
                            checkOutOnPressed: () {
                              _showCheckoutDialog(context,checkIn);
                            },
                            detailsOnPressed: () {
                              context
                                  .read<CheckInsDetailsCubit>()
                                  .getCheckInDetailsLog(id: checkIn?.id);
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

  void _showCheckoutDialog(BuildContext context,CheckInModel? checkIn) {
    final TextEditingController visitorsNoController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return  CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title: 'Checkout for ${checkIn?.name ?? ""}',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              visitorsCount: checkIn?.visitorCount ?? "",
              controller: visitorsNoController,
              checkOutAllOnPress: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      isCancelButtonDisable: true,
                      confirmButtonColor: AppColors.red,
                      confirmButtonText: 'Checkout All',
                      title: 'Checkout for All Check-Ins',
                      onConfirm: () async {
                        final result = await context
                            .read<CheckInsCubit>()
                            .checkOutVisitors(context, id: checkIn?.id, data: {
                          "checkout_count": visitorsNoController.text.isNotEmpty
                              ? {"checkout_count": visitorsNoController.text}
                              : {}
                        });
                        visitorsNoController.clear();
                        return result;
                      },
                    );
                  },
                );
              },
              checkOutOnPress: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding:
                        const EdgeInsets.symmetric(horizontal: 20),
                        isCancelButtonDisable: true,
                        confirmButtonColor: AppColors.red,
                        confirmButtonText: 'Checkout',
                        title: 'Checkout For Visitors',
                        onConfirm: () async {
                          final result = await context
                              .read<CheckInsCubit>()
                              .checkOutVisitors(context,
                              id: checkIn?.id,
                              data: {
                                "checkout_count": visitorsNoController.text
                              });
                          visitorsNoController.clear();
                          return result;
                        });
                  },
                );
              },
            );
          },
        );

      },
    );
  }
}
