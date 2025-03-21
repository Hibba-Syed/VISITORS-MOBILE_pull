import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/Mobile%20Screens/messages/components/attacments_card_widget.dart';
import 'package:visitors/view/Mobile%20Screens/messages/components/message_card_widget.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.verticalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 0),
                shrinkWrap: true,
                primary: false,
                itemCount: 7,
                  itemBuilder: (context, index){
                    return   const MessageCardWidget(
                      message: 'Chat Message',
                      time: '11-7-2025',
                      //DateTimeUtil.getFormattedDate(''),
                      userName: 'Ahmed',
                      profileImage: "",
                    );
                  }
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 250),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                            AttachmentCard(
                              filePath: "",
                              onDeletePressed: () {
                              },
                            )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
