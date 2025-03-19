// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:gap/gap.dart';
//
// import '../../resource/constants/app_colors.dart';
// import '../../resource/constants/images.dart';
// import '../../resource/styles/styles.dart';
//
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});
//
//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }
//
// class _CustomDrawerState extends State<CustomDrawer> {
//
//   @override
//   Widget build(BuildContext context) {
//     int selectedIndex = -1;
//     final List drawerList = [
//       {
//         "name": "Dashboard",
//         "image": AppImages.mdDashboard,
//         "function": () {
//           setState(() {
//             selectedIndex = 1;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "Check-Ins",
//         "image": AppImages.mcheckin,
//         "function": () {
//           setState(() {
//             selectedIndex = 2;
//           });
//           Navigator.pop(context);
//
//         }
//       },
//       {
//         "name": "E-Services",
//         "image": AppImages.mEservices,
//         "function": () {
//           setState(() {
//             selectedIndex = 3;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "Work Order / RFPs",
//         "image": AppImages.mrfps,
//         "function": () {
//           setState(() {
//             selectedIndex = 4;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "messages",
//         "image": AppImages.mmsg,
//         "function": () {
//           setState(() {
//             selectedIndex = 5;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "Check-Outs",
//         "image": AppImages.mCheckout,
//         "function": () {
//           setState(() {
//             selectedIndex = 6;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "directory",
//         "image": AppImages.directory,
//         "function": () {
//           setState(() {
//             selectedIndex = 7;
//           });
//           Navigator.pop(context);
//         }
//       },
//       {
//         "name": "Log Out",
//         "image": AppImages.logouts,
//         "function": () {
//           setState(() {
//             selectedIndex = 8; // Update selected index
//           });
//           Navigator.pop(context);
//         }
//       },
//     ];
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             height: 200,
//             padding: const EdgeInsets.all(20),
//             alignment: Alignment.bottomCenter,
//             decoration: const BoxDecoration(
//               color: AppColors.white,
//               image: DecorationImage(
//                   image: AssetImage(
//                     AppImages.background,
//                   ),
//                   fit: BoxFit.cover),
//             ),
//             child: Column(
//               children: [
//                 const Gap(10),
//                 Image.asset(
//                   AppImages.drawerLogo,
//                   scale: 1,
//                 ),
//                 const Gap(10),
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 10),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: AppColors.primary
//                   ),
//                   child: const Text('VMS APPLICATION',style: AppTextStyles.style10White500,),
//                 ),
//               ],
//             ),
//           ),
//           ListView.separated(
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             itemCount: drawerList.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 10),
//                 padding: const EdgeInsets.only(right: 10),
//                 decoration: const BoxDecoration(
//                     color: AppColors.white
//                 ),
//                 child: ListTile(
//                   dense: true,
//                   minLeadingWidth: 20,
//                   leading:  SvgPicture.asset('${drawerList[index]["image"]}', colorFilter:  ColorFilter.mode(
//                     selectedIndex == index
//                         ? AppColors.primary
//                         : AppColors.steelBlue,
//                     BlendMode.srcIn,
//                   )),
//                   onTap: drawerList[index]["function"],
//                   title: Text(
//                     drawerList[index]["name"],style: TextStyle(
//                     color:  selectedIndex == index
//                         ? AppColors.primary
//                         : AppColors.steelBlue,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                    fontFamily: 'Inter',
//
//                   )
//                   //AppTextStyles.styleDrawerColor400
//                   ),
//                 ),
//               );
//             },
//             separatorBuilder: (BuildContext context, int index) {
//               return Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                 child: Divider(
//                   height: 0,
//                   thickness: 0,
//                   color: Colors.transparent,
//                   indent: MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.14,
//                   // endIndent: MediaQuery.of(context).size.width * 0.07,
//                 ),
//               );
//             },
//           ),
//           const Gap(20),
//         ],
//       ),
//       bottomNavigationBar:
//       Padding(
//         padding:  EdgeInsets.only(bottom: 25,left: MediaQuery.sizeOf(context).width * 0.09),
//         child: Text("© ${DateTime.now().year} ISKAAN TECH - v1.2.0" ,
//           style: AppTextStyles.styleDrawerColor400
//         ),
//       ),
//     );
//   }
// }