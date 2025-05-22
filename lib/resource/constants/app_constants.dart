import '../../view/Common Screens/Components/drawer_item_model.dart';
import '../constants/images.dart';

class AppConstants {
  static const int dashboardIndex = 0;
  static const int checkInsIndex = 1;
  static const int eServicesIndex = 2;
  static const int workOrderRfpIndex = 3;
  static const int messagesIndex = 4;
  static const int checkOutsIndex = 5;
  static const int directoryIndex = 6;
  static const int logoutIndex = 7;

  static const double horizontalPadding = 10;
  static const double verticalPadding = 10;

  static const double tabletScreen = 600;
  static const double mobileScreen = 360;

  static final List<DrawerItemModel> drawerItems = [
    DrawerItemModel(index: dashboardIndex, title: 'Dashboard', iconPath: AppImages.dashboard, onTap: () {  }),
    DrawerItemModel(index: checkInsIndex, title: 'Check-Ins', iconPath: AppImages.menuCheckIn, onTap: () {  }),
    DrawerItemModel(index: eServicesIndex, title: 'E-Services', iconPath: AppImages.menuEservices, onTap: () {  }),
    DrawerItemModel(index: workOrderRfpIndex, title: 'Work Order / RFPs', iconPath: AppImages.menuRFPs, onTap: () {  }),
    DrawerItemModel(index: messagesIndex, title: 'Messages', iconPath: AppImages.menuMsg, onTap: () {  }),
    DrawerItemModel(index: checkOutsIndex, title: 'Check-Outs', iconPath: AppImages.menuCheckout, onTap: () {  }),
    DrawerItemModel(index: directoryIndex, title: 'Directory', iconPath: AppImages.directory, onTap: () {  }),
    DrawerItemModel(index: logoutIndex, title: 'Logout', iconPath: AppImages.logout, onTap: () {  }),
  ];
}
