import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:intl/intl.dart' show DateFormat;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/check%20outs/components/check_outs_card_widget.dart';
import 'package:visitors/view/Common%20Screens/check%20outs/components/check_outs_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
import 'package:visitors/view/widgets/button/action_button.dart';
import 'package:visitors/view/widgets/text%20field/search_text_field.dart';

import '../../../resource/constants/images.dart';
class CheckOutsScreen extends StatelessWidget {
  const CheckOutsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        child: Column(
          children: [
           const  Gap(10),
            Row(
              children: [
                const Flexible(child: SearchTextField()),
                const Gap(6),
                FilterContainerWidget(
                  onPressed: () {
                    _checkOutFilterBottomSheet(context);
                  },
                )
              ],
            ),
            const Gap(10),
            Align(
              alignment: Alignment.bottomRight,
              child: ActionButton(
                text: 'Export',
                // image: AppImages.export,
                imageColor: AppColors.white,
                backgroundColor: AppColors.primary,
                buttonWidth: 110,
                onPressed: () {},
              ),
            ),
            const Gap(5),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return CheckOutsCardWidget(
                    visitorCount: 10,
                      typeText: "45678",
                      name: 'MUHAMMAD AHMED MOHAMMED ',
                      profileImageUrl:
                      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                      type: 'Guest',
                      checkInDate: DateTimeUtil.getFormattedDateTime('2025-04-04T05:33:36.000000Z'),
                      checkOutDate: DateTimeUtil.getFormattedDateTime('2025-04-04T05:33:36.000000Z'),
                      phone: '34567890098',
                      checkInGateValue: "The W Residences Reception",
                      checkOutGateValue: "The W Residences Reception",
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _checkOutFilterBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const CheckOutsFilterBottomSheet();
      },
    );
  }
}
