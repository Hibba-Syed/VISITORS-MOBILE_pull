

class DrawerItemModel {
  final int index;
  final String title;
  final String iconPath;
  final Function()? onTap;
  DrawerItemModel({
    required this.index,
    required this.title,
    required this.iconPath,
    this.onTap,
  });
}
