import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/model/message/message_model.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/view/Common%20Screens/messages/components/attachment_card_widget.dart';
import 'package:visitors/view/Common%20Screens/messages/components/chat_bottom_row_widget.dart';
import 'package:visitors/view/Common%20Screens/messages/components/message_sender_card_widget.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/message/message_cubit.dart';
import '../../../resource/constants/app_colors.dart';
import 'components/message_receiver_card_widget.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> attachmentsList = [];
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<MessageCubit>().getMoreMessage(
        );
      }
    });
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
                    vertical: AppConstants.verticalPadding),
                child: Column(
                  children: [
                     state.isLoading
                         ? LoaderWidget()
                         : state.messageModel?.isEmpty ?? true
                         ? EmptyWidget(
                       text: 'No data available',
                     )
                         : Expanded(
                           child: RefreshIndicator(
                                                  onRefresh: () async {
                           context.read<MessageCubit>().getMessages();
                                                  },
                                                  child: ListView.separated(
                           physics: AlwaysScrollableScrollPhysics(),
                           controller: _scrollController,
                           shrinkWrap: true,
                           primary: false,
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
                                 message?.by == 'user'
                                     ?
                                 MessageReceiverCardWidget(
                                   message: message?.message ?? "",
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
                                 MessageSenderCardWidget(
                                   message: message?.message ?? "",
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
                                 padding:
                                 EdgeInsets.symmetric(vertical: 5));
                           },
                                                  ),
                                                ),
                         ),
                     if (state.loadMore) const LoaderWidget(),
                    if (attachmentsList.isNotEmpty) _buildAttachmentSection(),
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
            onSend: () {
              if (messageController.text.isEmpty) {
                Fluttertoast.showToast(msg: "Please type a message first");
                return;
              }
              context.read<MessageCubit>().sendMessage(
                    context,
                    data: {'message': messageController.text},
                    filesPaths: attachmentsList,
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
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 250),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: SingleChildScrollView(
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
}
// class SendMessageImageModel {
//   int? id;
//   String? filePath;
//   String? url;
//   SendMessageImageModel({
//     this.id,
//     this.filePath,
//     this.url,
//   });
// }
