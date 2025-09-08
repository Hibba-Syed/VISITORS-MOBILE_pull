import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:url_launcher/url_launcher.dart';
import 'package:visitors/resource/styles/styles.dart';

import '../../../../resource/constants/app_colors.dart';

class ServicesDocumentsCardWidget extends StatelessWidget {
  final String? name;
  final String url;
  const ServicesDocumentsCardWidget({
    super.key,
    this.name,
    required this.url,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: () {
        url.isNotEmpty ? launchUrl(Uri.parse(url)) : launchUrl(Uri.parse(url));
      },
      child: Row(
        children: [
          Icon(
            CupertinoIcons.doc_text_fill,
            color: AppColors.primary,
            size: 20,
          ),
          Gap(5),
          Expanded(
              child: Text(
            name ?? "",
            style: AppTextStyles.style12Black600,
          )),
        ],
      ),
    );
  }
}
