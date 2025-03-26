import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/view/Mobile%20Screens/messages/components/message_attachment_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageCardWidget extends StatelessWidget {
  const MessageCardWidget(
      {super.key,
        this.message,
        this.time,
        this.profileImage,
        this.userName,
        this.messageAttachments,
        this.backgroundColor,
        this.textColor,
        this.timeColor,

      });
  final String? message;
  final String? time;
  final String? profileImage;
  final String? userName;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? timeColor;

  final List<MessageAttachmentModel>? messageAttachments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 80,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Card(
              elevation: 0,
              shape:  const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8) ,
                   // topLeft:   Radius.circular(8) ,
                ),
                // side: BorderSide(color: Color(0xffFBAF3A)
                // ),
              ),
              color:  backgroundColor ?? AppColors.primary,

              margin: const EdgeInsets.symmetric(vertical: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage:
                          NetworkImage(profileImage ?? ""
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            userName ?? 'User Name',
                            style:  TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: textColor ?? AppColors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.only(bottom: 10, left: 12, right: 12),
                    child: Text(
                      message?.toString() ?? "--",
                      style:  TextStyle(
                        fontSize: 12,
                        color: textColor ?? AppColors.white,
                        fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                    child: Column(
                      children: List.generate(
                        messageAttachments?.length ?? 0,
                            (index) => InkWell(
                          overlayColor:
                          const WidgetStatePropertyAll(Colors.transparent),
                          onTap: () {
                            launchUrl(Uri.parse(messageAttachments?[index]
                                .fileUrl
                                ?.toString() ??
                                ""));
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.attachment_sharp,
                                color: AppColors.primary,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                   messageAttachments?[index]
                                      .name
                                      ?.toString() ??
                                      "--",
                                  // textOverflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7.0, bottom: 5),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        time?.toString() ?? "--",
                        style: TextStyle(
                          fontSize: 10,
                          color: timeColor ?? AppColors.gray,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
