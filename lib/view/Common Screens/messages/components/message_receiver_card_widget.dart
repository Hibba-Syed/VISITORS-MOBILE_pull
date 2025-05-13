import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../model/attachment_model.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../utils/date_time.dart';
import '../../../widgets/network_image_widget.dart';

class MessageReceiverCardWidget extends StatelessWidget {
  const MessageReceiverCardWidget({
    super.key,
    this.message,
    this.date,
    this.profileImage,
    this.userName,
    this.attachments,
  });
  final String? message;
  final String? date;
  final String? profileImage;
  final String? userName;
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
            topRight: Radius.circular(8),
          ),
        ),
        color: AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8, left: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.gray,
                    radius: 15,
                    backgroundImage: NetworkImage(profileImage ?? ""),
                  ),
                  const Gap(8),
                  Flexible(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      userName ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5
                    ),
                    child: Column(
                      children: List.generate(
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
                                Flexible(
                                  child: Text(
                                      (attachments?[index].name?.split('/').last)?.toString() ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.style12DarkGrey600
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                message?.toString() ?? "--",
                style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.black,
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
                    color: AppColors.darkGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}