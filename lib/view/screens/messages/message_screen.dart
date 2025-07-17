import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:visitors/model/message/message_model.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
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
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<String> _attachmentsList = [];
  Locale? _currentLocale;

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
  void didChangeDependencies() {
    final locale = Localizations.localeOf(context);
    if (locale != _currentLocale) {
      _currentLocale = locale;
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
        context.read<MainDashboardCubit>().onBackButtonPressed();
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
                                  text: AppUtils.languageTranslate(
                                      'noDataAvailable'),
                                )
                              : ListView.separated(
                                  reverse: true,
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  itemCount: state.messageModel?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    MessageModel? message =
                                        state.messageModel?[index];
                                    return Row(
                                      mainAxisAlignment: message?.by == 'user'
                                          ? MainAxisAlignment.start
                                          : MainAxisAlignment.end,
                                      children: [
                                        message?.by == 'user'
                                            ? MessageReceiverCardWidget(
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
                                            : MessageSenderCardWidget(
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
                    _attachmentsList.isNotEmpty
                        ? Align(
                            alignment: Alignment.topLeft,
                            child: _buildAttachmentSection())
                        : SizedBox.shrink(),
                    const Gap(10),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: ChatBottomRowWidget(
            messageController: _messageController,
            onAttach: () async {
              final result =
                  await FilePicker.platform.pickFiles(allowMultiple: true);
              if (result != null && result.files.isNotEmpty) {
                const maxSizeInBytes = 10 * 1024 * 1024;
                final validFiles = result.files.where((file) =>
                    (file.size <= maxSizeInBytes) && file.path != null);

                if (validFiles.length != result.files.length) {
                  Fluttertoast.showToast(
                      msg: AppUtils.languageTranslate(
                          'fileIsTooLargePleaseChooseAFileSmallerThan10MB'));
                }
                _attachmentsList
                    .addAll(validFiles.map((file) => file.path!).toList());
                setState(() {});
              }
            },
            onSend: () async {
              if (_messageController.text.isEmpty) {
                Fluttertoast.showToast(
                    msg: AppUtils.languageTranslate('pleaseTypeMessageFirst'));
                return;
              }
             bool result = await
              context.read<MessageCubit>().sendMessage(
                    context,
                    data: {'message': _messageController.text},
                    filesPaths:
                        _attachmentsList.isNotEmpty ? _attachmentsList : null,
                  );
             if (result) {
                _messageController.clear();
                _attachmentsList.clear();
             }
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
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._attachmentsList.map((String? e) => AttachmentCardWidget(
                    filePath: e?.toString() ?? "",
                    onDeletePressed: () {
                      _attachmentsList.removeWhere((item) => item == e);
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
