part of 'message_cubit.dart';

class MessageState {
  final bool isLoading;
  final bool isSendMessageLoading;
  final bool loadMore;
  final int page;
  List<MessageModel>? messages;
  MessageState({
    this.isLoading = false,
    this.messages,
    this.isSendMessageLoading = false,
    this.loadMore = false,
    this.page = 1,
  });
  MessageState copyWith({
    bool? isLoading,
    List<MessageModel>? messages,
    bool? isSendMessageLoading,
    bool? loadMore,
    int? page,
  }) {
    return MessageState(
        isLoading: isLoading ?? this.isLoading,
        messages: messages ?? this.messages,
        isSendMessageLoading: isSendMessageLoading ?? this.isSendMessageLoading,
        page: page ?? this.page,
        loadMore: loadMore ?? this.loadMore);
  }
}
