import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';
class DirectoryScreen extends StatelessWidget {
  const DirectoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding),
        child: Column(
          children: [
            SingleSelectedDropdownWidget<String?>(
                hint: "Select ",
                fillColor: AppColors.white,
                selectedItem: 'Select',
                itemAsString: (type) => type ?? "--",
                compareFn: (p0, p1) => p0 == p1,
                items: ['1','2','3','4'],
                onChanged: (value) {
                }),
            const Gap(10),
            Expanded(
              child:  ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return  Container();
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
