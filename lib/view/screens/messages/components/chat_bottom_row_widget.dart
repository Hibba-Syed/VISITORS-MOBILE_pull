import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:remove_emoji_input_formatter/remove_emoji_input_formatter.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/screens/messages/components/send_chat_button_contrainer_widget.dart';

import '../../../../bloc/message/message_cubit.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../widgets/loader/loader_widget.dart';

class ChatBottomRowWidget extends StatefulWidget {
  final VoidCallback onAttach;
  final Future<void> Function() onSend;
  final TextEditingController messageController;
  const ChatBottomRowWidget({
    super.key,
    required this.onAttach,
    required this.onSend,
    required this.messageController,

  });

  @override
  State<ChatBottomRowWidget> createState() => _ChatBottomRowWidgetState();
}

class _ChatBottomRowWidgetState extends State<ChatBottomRowWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10, top: 0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 170,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Form(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          controller: widget.messageController,
                          inputFormatters: [RemoveEmojiInputFormatter()],
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: AppUtils.languageTranslate('typeAMessage'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: widget.onAttach,
                          icon: Transform.rotate(
                            angle: context.locale.languageCode == 'en' ? 70 : 15,
                            child: const Icon(
                              Icons.attach_file,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(6),
            BlocBuilder<MessageCubit, MessageState>(
              builder: (context, state) {
                return state.isSendMessageLoading
                    ? const SizedBox(
                    height: 50,
                    child: Center(child: LoaderWidget()))
                    : SendChatButtonContainerWidget(
                    onPressed: widget.onSend);
              },
            ),

          ],
        ),
      ),
    );
  }
}
