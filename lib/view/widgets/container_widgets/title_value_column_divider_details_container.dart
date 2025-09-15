import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleValueColumnDividerDetailsContainerWidget extends StatelessWidget {
  final String title;
  final String? value;
  final Color? textColor;
  final Color? valueColor;
  final IconData? valueIcon;
  final bool isLast;
  final String? url;

  const TitleValueColumnDividerDetailsContainerWidget({
    super.key,
    required this.title,
    this.value,
    this.textColor,
    this.valueColor,
    this.isLast = false,
    this.valueIcon,
    this.url,
  });

  Future<void> _launchUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
      );
    } else {
      Fluttertoast.showToast(msg: 'Could not launch URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final textStyle = (AppUtils.isTablet(context)
    //     ? AppTextStyles.style15DarkGrey600
    //     : AppTextStyles.style13DarkGrey600)
    //     .copyWith(color: valueColor);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppUtils.isTablet(context)
                  ? AppTextStyles.style15Black600
                  : AppTextStyles.style13Black600,
            ),
            valueIcon != null
                ? Icon(
                    valueIcon,
                    color: valueColor ?? AppColors.red,
                    size: AppUtils.isTablet(context) ? 20 : 16,
                  )
                : url != null
                    ? InkWell(
                        onTap: () => _launchUrl(url!),
                        child: Row(
                          children: [
                            Icon(
                              Icons.save_alt,
                              color: Colors.blue,
                              size: 16,
                            ),
                            Gap(5),
                            Text(
                              AppUtils.languageTranslate('file'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: textColor ?? AppColors.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: AppUtils.isTablet(context) ? 15 : 13,
                                //AppTextStyles.style10Black400
                              ),
                            ),
                          ],
                        ),
                      )
                    : ReadMoreText(
                        value ?? "",
                        style: TextStyle(
                          color: textColor ?? AppColors.darkGrey,
                          fontWeight: FontWeight.w500,
                          fontSize: AppUtils.isTablet(context) ? 15 : 13,
                          //AppTextStyles.style10Black400
                        ),
                        trimMode: TrimMode.Line,
                        trimLines: 3,
                        colorClickableText: Colors.pink,
                        trimCollapsedText: AppUtils.languageTranslate('showMore'),
                        trimExpandedText: AppUtils.languageTranslate('showLess'),
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      )
          ],
        ),
        if (!isLast)
          const Divider(
            color: AppColors.lightGrey,
          ),
      ],
    );
  }
}
