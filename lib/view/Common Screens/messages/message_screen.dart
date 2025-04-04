import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/Common%20Screens/messages/components/attachment_card_widget.dart';
import 'package:visitors/view/Common%20Screens/messages/components/chat_bottom_row_widget.dart';
import 'package:visitors/view/Common%20Screens/messages/components/message_card_widget.dart';


class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  XFile? file;
  final List<Map<String, dynamic>> messages = [
    {
      "text": "Hello!",
      "isSender": true,
      "time": "10:30 AM",
      "date": "july 11 2025"
    },
    {
      "text": "Hi, how are you?",
      "isSender": false,
      "time": "10:32 AM",
      "date": "july 11 2025"
    },
    {
      "text": "I am fine",
      "isSender": true,
      "time": "10:30 AM",
      "date": "july 11 2025"
    },
    {
      "text": "What you wanna ask?",
      "isSender": false,
      "time": "10:32 AM",
      "date": "july 11 2025"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.verticalPadding),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: _scrollController,
                    shrinkWrap: true,
                    primary: false,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Row(
                        mainAxisAlignment: message['isSender']
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          message['isSender']
                              ? MessageAssigneeCardWidget(
                                  message: message['text'],
                                  time: "${message['date']} ${message['time']}",
                                  userName: "Olivia",
                                  profileImage:
                                      "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                )
                              : MessageVisitorCardWidget(
                                  message: message['text'],
                                  time: "${message['date']} ${message['time']}",
                                ),
                        ],
                      );
                    }, separatorBuilder: (BuildContext context, int index) {
                      return const Padding(padding: EdgeInsets.symmetric(vertical: 5));
                },),
              ),
              if (file?.path.isNotEmpty ?? false)
                Container(
                    alignment: Alignment.centerLeft,
                    height: 100,
                    width: double.infinity,
                    child: AttachmentCardWidget(
                      filePath: file?.path ?? "",
                      onDeletePressed: () {
                        setState(() {
                          file = null;
                        });

                      },
                    )),
            ],
          ),
        ),
        bottomNavigationBar: ChatBottomRowWidget(
          messageController: messageController,
          onAttach: () async {
            await ImagePicker()
                .pickImage(source: ImageSource.gallery)
                .then((XFile? value) {
              setState(() {
                file = value;
              });
            });
          },
          onSend: () {},
        ),
      ),
    );
  }
}
