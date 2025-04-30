import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/date_time.dart';

class MessageAssigneeCardWidget extends StatelessWidget {
  const MessageAssigneeCardWidget(
      {super.key,
        this.message,
        this.date,
        this.profileImage,
        this.userName,

      });
  final String? message;
  final String? date;
  final String? profileImage;
  final String? userName;
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
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topRight: Radius.circular(8) ,
          ),
        ),
        color:  AppColors.white,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8,right: 8,left: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.gray,
                    radius: 15,
                    backgroundImage:
                    NetworkImage(profileImage ?? ""
                    ),
                  ),
                  const Gap(8),
                  Flexible(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      userName ?? '',
                      style:  const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color:  AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding:
              const EdgeInsets.all(8),
              child: Text(
                message?.toString() ?? "--",
                style:  const TextStyle(
                  fontSize: 12,
                  color:  AppColors.black,
                  fontWeight: FontWeight.w400
                ),
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
                    color:  AppColors.darkGrey,
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
class MessageSecurityCardWidget extends StatelessWidget {
  const MessageSecurityCardWidget(
      {super.key,
        this.message,
        this.date,
      });
  final String? message;
  final String? date;

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
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topLeft:   Radius.circular(8) ,
          ),
        ),
        color:  AppColors.primary,
        margin: const EdgeInsets.symmetric(vertical: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
               const EdgeInsets.all(10),
              child: Text(
                message?.toString() ?? "--",
                style:  const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                    fontWeight: FontWeight.w400
                ),
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
          ],
        ),
      ),
    );
  }
}