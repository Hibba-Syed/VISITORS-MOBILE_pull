import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/model/message/message_model.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/message/message_cubit.dart';
import '../../../resource/constants/app_colors.dart';
import 'components/attachment_card_widget.dart';
import 'components/chat_bottom_row_widget.dart';
import 'components/message_receiver_card_widget.dart';
import 'components/message_sender_card_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> attachmentsList = [];
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_scrollListener);
    });
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 100) {
      if (!context.read<MessageCubit>().state.loadMore) {
        context.read<MessageCubit>().getMoreMessage();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
        context
            .read<DeviceDeciderCubit>()
            .onChangeSelectedIndex(AppConstants.dashboardIndex);
      },
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<MessageCubit, MessageState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding,
                ),
                child: Column(
                  children: [
                     if (state.loadMore) const LoaderWidget(),
                    Expanded(
                        child: state.isLoading
                            ? Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                              MediaQuery.of(context).size.height / 3),
                          child: LoaderWidget(),
                        )
                            : state.messageModel?.isEmpty ?? true
                            ? EmptyWidget(
                          text: 'No data available',
                        )
                            :
                        ListView.separated(
                              reverse: true,
                              padding: EdgeInsets.only(top: 10,bottom: 10),
                              physics: AlwaysScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: state.messageModel?.length ?? 0,
                              itemBuilder: (context, index) {
                                MessageModel? message =
                                state.messageModel?[index];
                                return
                                  Row(
                                  mainAxisAlignment: message?.by == 'user'
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                                  children: [
                                    message?.by == 'user' ?
                                         MessageReceiverCardWidget(
                                      message:
                                      message?.message ?? "",
                                      date: message?.createdAt
                                          .toString(),
                                      userName:
                                      message?.user?.fullName ??
                                          "",
                                      profileImage: message?.user
                                          ?.profileImageUrl ??
                                          "",
                                      attachments:
                                      message?.attachments,
                                    )
                                        :
                                 // Text('hibba'):
                                    MessageSenderCardWidget(
                                      message:
                                      message?.message ?? "",
                                      date: message?.createdAt
                                          .toString(),
                                      attachments:
                                      message?.attachments,
                                    ),
                                  ],
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5));
                              },
                            ),
                    ),

                    attachmentsList.isNotEmpty?
                    Align(
                      alignment: Alignment.topLeft,
                        child: _buildAttachmentSection()) : SizedBox.shrink(),
                    const Gap(10),

                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: ChatBottomRowWidget(
            messageController: messageController,
            onAttach: () async {
              final result = await FilePicker.platform.pickFiles();
              if (result != null && result.files.isNotEmpty) {
                attachmentsList.addAll(
                    result.files.map((file) => file.path ?? "").toList());
                setState(() {});
              }
            },
            onSend: ()async {
              if (messageController.text.isEmpty) {
                Fluttertoast.showToast(msg: "Please type a message first");
                return;
              }
              context.read<MessageCubit>().sendMessage(
                    context,
                    data: {'message': messageController.text},
                    filesPaths: attachmentsList.isNotEmpty ? attachmentsList : null,
                  );
              messageController.clear();
              attachmentsList.clear();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAttachmentSection() {
    print("code print${attachmentsList.length}");
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...attachmentsList.map((String? e) => AttachmentCardWidget(
                    filePath: e?.toString() ?? "",
                    onDeletePressed: () {
                      attachmentsList.removeWhere((item) => item == e);
                      setState(() {});
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
