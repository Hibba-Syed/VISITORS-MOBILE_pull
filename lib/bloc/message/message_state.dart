part of 'message_cubit.dart';

class MessageState {
  final bool isLoading;
  final bool isSendMessageLoading;
  final bool loadMore;
  final int page;
  List<MessageModel>? messageModel;
  MessageState({
    this.isLoading = false,
    this.messageModel,
    this.isSendMessageLoading = false,
    this.loadMore = false,
    this.page = 1,
  });
  MessageState copyWith({
    bool? isLoading,
    List<MessageModel>? messageModel,
    bool? isSendMessageLoading,
    bool? loadMore,
    int? page,
  }) {
    return MessageState(
        isLoading: isLoading ?? this.isLoading,
        messageModel: messageModel ?? this.messageModel,
        isSendMessageLoading: isSendMessageLoading ?? this.isSendMessageLoading,
        page: page ?? this.page,
      loadMore: loadMore ?? this.loadMore
    );
  }
}
