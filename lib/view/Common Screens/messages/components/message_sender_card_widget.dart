import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/model/attachment_model.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageSenderCardWidget extends StatelessWidget {
  const MessageSenderCardWidget({
    super.key,
    this.message,
    this.date,
    this.attachments,
  });
  final String? message;
  final String? date;
  final List<AttachmentModel>? attachments;


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth:
            //(MediaQuery.of(context).size.shortestSide>=600)? 85 : -80,
            MediaQuery.of(context).size.width - 85,
      ),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft: Radius.circular(8),
          ),
        ),
        color: AppColors.primary,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                message?.toString() ?? "--",
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 7.0, bottom: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  DateTimeUtil.getFormattedDateTime(date?.toString() ?? "--"),
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Column(
                children: (attachments?.isNotEmpty ?? false) ?List.generate(
                  attachments?.length ?? 0,
                      (index) => InkWell(
                    overlayColor: const WidgetStatePropertyAll(
                        Colors.transparent),
                    onTap: () {
                      launchUrl(Uri.parse(attachments?[index]
                          .fileUrl
                          ?.toString() ??
                          ""));
                    },
                    child: Container(
                      height: 30,
                      margin: EdgeInsets.symmetric(vertical: 3),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.gray,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Row(
                        children: [
                          Icon(
                              CupertinoIcons.doc_text_fill,
                              color: AppColors.primary,
                              size: 18,
                            ),
                          const Gap(5),
                          Expanded(
                            child: Text(
                              (attachments?[index].name?.split('/').last)?.toString() ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.style12DarkGrey600
                            ),
                          ),
                        ],
                      ),
                    ) ,
                  ),
                ) : []
              ),
            ),
          ],
        ),
      ),
    );
  }
}
