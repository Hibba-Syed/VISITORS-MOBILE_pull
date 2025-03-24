import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/Mobile%20Screens/messages/components/chat_bottom_row_widget.dart';
import 'package:visitors/view/Mobile%20Screens/messages/components/message_card_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> messages = [
    {"text": "Hello!", "isMe": true, "time": "10:30 AM", "date" : "july 11 2025"}, // User's message
    {"text": "Hi, how are you?", "isMe": false, "time": "10:32 AM","date" : "july 11 2025"}, // Received message
  ];

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: AppConstants.verticalPadding),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                 controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: 0),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: messages.length,
                    itemBuilder: (context, index){
                      final message = messages[index];
                      return
                        Row(
                          mainAxisAlignment: message['isMe'] ? MainAxisAlignment.start : MainAxisAlignment.end,
                          children: [
                            MessageCardWidget(
                              backgroundColor: message['isMe'] ? AppColors.white : AppColors.primary,
                              textColor: message['isMe'] ? AppColors.black : AppColors.white,
                              timeColor: message['isMe'] ? AppColors.darkGrey : AppColors.white,
                              message: message['text'],
                              time: "${message['date']} ${ message['time']}",
                              userName: message['isMe'] ? "Ahmed" : "",
                              profileImage: "",
                            ),
                          ],
                        );
                    }
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:  ChatBottomRowWidget(
          messageController: messageController,
          onAttach: ()  {
          }, onCamera: () {  },
        ),
      ),
    );
  }
}
