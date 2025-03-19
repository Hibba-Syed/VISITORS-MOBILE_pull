import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_padding.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/logout_widget.dart';
import '../check ins/componants/check_in_container_widget.dart';
import '../services/components/services_dashboard_card_widget.dart';
import '../work order/components/work_order_dashboard_card_widget.dart';
class MobileDashboardScreen extends StatelessWidget {

  const MobileDashboardScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final List<Map> categories = [
      {
        "name": "All Check-Ins",
        "count": "10",
        "svg": AppImages.users,
        "onTap": () {
          // Navigator.pushNamed(context, AppRoutes.incoming);
        },
      },
      {
        "name": "Guests",
        "count": "10",
        "svg": AppImages.guests,
        "onTap": () {},
      },
      {
        "name": "E-services",
        "count": "5",
        "svg": AppImages.eServices,
        "onTap": () {},
      },
      {
        "name": "work order / RFPs",
        "count": "0",
        "svg": AppImages.rfps,
        "onTap": () {

        },
      },
      {
        "name": "Guest Check-In",
        "count": "",
        "svg": AppImages.gCheckIn,
        "onTap": () {

        },
      },
      {
        "name": "Message",
        "count": "",
        "svg": AppImages.message,
        "onTap": () {

        },
      },
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppPadding.verticalPadding, horizontal: AppPadding.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                children: [
                 Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text('Welcome,',style: AppTextStyles.style12Grey500,),
                     Text('Apricot Tower (Gate 2)',style: AppTextStyles.style14Primary500,),
                   ],
                 ),
                  Spacer(),
                  IconTextWidget(
                  text: 'VMS Guide',
                    imageColor: AppColors.white,
                    image: AppImages.guide,
                  ),
                ],
              ),
              const Gap(10),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  mainAxisExtent: 100
                ),
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    onTap: categories[index]["onTap"],
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: getContainerColors(categories[index]["name"]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ((categories[index]["svg"] as String)
                                .split(".")
                                .last == "png") ? Image.asset(
                              categories[index]["svg"],
                              color: AppColors.primary,
                              scale: 3,
                            ) : SvgPicture.asset(
                              categories[index]["svg"],
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            const Gap(5),
                            if (categories[index]["count"].toString().isNotEmpty) ...[
                              Text(
                                categories[index]["count"],
                                style: TextStyle(
                                  color: getTextColors(categories[index]["name"]),
                                ),
                              ),
                            ],
                            Text(categories[index]["name"], style: TextStyle(
                              color: getTextColors(categories[index]["name"]),
                            ),
                            ),
                          ]),
                    ),
                  );
                },
              ),
              const Row(
                children: [
                  Text('Check-Ins', style: AppTextStyles.style14Primary500,),
                  Spacer(),
                  IconTextWidget(
                    text: 'Check-Outs',
                    image: AppImages.checkout,
                    imageColor: AppColors.white,
                    containerColor: AppColors.red,
                  ),
                  Gap(10),
                  IconTextWidget(
                    verticalPadding: 6.4,
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    containerColor: AppColors.blue,
                  ),

                ],
              ),
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return CheckInContainerWidget(
                    count: 'visit',
                    title: 'John Henry',
                    image: AppImages.gates,
                    secondTitle: 'Guest',
                    containerText1: 'Jan 7, 2025, 10:40 AM',
                    mobileWidget: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconTextWidget(
                          containerColor: AppColors.lightGrey1,
                          isTextColor: true,
                          text: "Gate: 2",
                          image: AppImages.gate,
                        ),
                        LogoutWidget(
                          containerColor: AppColors.red,
                          image: AppImages.logout,
                        ),
                      ],
                    ),
                    widget: Row(
                      children: [
                        IconTextWidget(
                          containerColor: AppColors.lightGrey1,
                          isTextColor: true,
                          text: DateFormat("MMM dd, yyyy ").format(DateTime.now()),
                          image: AppImages.date,
                        ),
                        const Gap(10),
                        const IconTextWidget(
                          containerColor: AppColors.lightGrey1,
                          isTextColor: true,
                          text: "Visitor Count: 10",
                          image: AppImages.count,
                        ),
                      ],
                    ),
                    // containerImage1: AppImages.date,
                    // containerImage2: AppImages.count,
                    // containerText2: 'Visitor Count: 10',
                    // containerImage3: AppImages.gate,
                    // containerText3: 'Gate: 2',
                  );
                },
              ),
              const Row(
                children: [
                  Text('E-services', style: AppTextStyles.style14Primary500,),
                  Spacer(),
                  IconTextWidget(
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    containerColor: AppColors.blue,
                  ),

                ],
              ),
              const Gap(10),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return const ServicesDashboardCardWidget(
                    count: '1006',
                    title: 'Facility Booking',
                    secondTitle: 'FO202401101791',
                    status: 'Active',
                    widget:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconTextWidget(
                              image:AppImages.services,
                              text:  "Fit Out NOC",
                              containerColor: AppColors.lightGrey1,
                              verticalPadding: 4,
                              horizontalPadding: 6,
                              isTextColor: true,
                            ),
                            Gap(10),
                            IconTextWidget(
                              image:  AppImages.person ,
                              text: 'Syed Suhaan',
                              containerColor: AppColors.lightGrey1,
                              verticalPadding: 4,
                              horizontalPadding: 6,
                              isTextColor: true,
                            ),
                          ],
                        ),
                        LogoutWidget(
                          containerColor: AppColors.green,
                          image: AppImages.logout,
                        ),
                      ],
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const Padding(padding: EdgeInsets.symmetric(vertical: 5));
              },
              ),
               Row(
                children: [
                  const Text('Work Orders / RFPs', style: AppTextStyles.style14Primary500,),
                   const Spacer(),
                  IconTextWidget(
                    onPressed: (){
                      Navigator.pushNamed(context, AppRoutes.workOrderRfpListScreen);
                    },
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    containerColor: AppColors.blue,
                  ),
                ],
              ),
              const Gap(10),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return const WorkOrderDashboardCardWidget(
                    status: 'Active',
                    name: 'Work Order',
                    title: '(2 Months) Services Contract',
                    secondTitle: 'JB001-24-00102',
                    containerText1: 'Onlinist Vendor',
                    containerImage1: AppImages.vendor,
                    containerImage2: AppImages.date,
                    containerText2: 'Jan 7, 2025',
                    image:  AppImages.hammer,
                  );
                }, separatorBuilder: (BuildContext context, int index) {
                  return const Padding(padding: EdgeInsets.symmetric(vertical: 5));
              },

              ),
            ],
          ),
        ),
      ),
    );
  }

  Color getTextColors(String? text) {
    if (text == "All Check-Ins") {
      return AppColors.green;
    }
    if (text == "Guests") {
      return AppColors.yellow;
    }
    if (text == "E-services") {
      return AppColors.cGreen;
    }
    if (text == "work order / RFPs") {
      return AppColors.blue;
    }
    if (text == "Guest Check-In") {
      return AppColors.white;
    }
    if (text == "Message") {
      return AppColors.white;
    }
    return Colors.orange;
  }
  //AspectRatio
  Color getContainerColors(String? text) {
    if (text == "All Check-Ins") {
      return AppColors.white;
    }
    if (text == "Guests") {
      return AppColors.white;
    }
    if (text == "E-services") {
      return AppColors.white;
    }
    if (text == "work order / RFPs") {
      return AppColors.white;
    }
    if (text == "Guest Check-In") {
      return AppColors.green;
    }
    if (text == "Message") {
      return AppColors.blue;
    }
    return AppColors.primary;
  }
}