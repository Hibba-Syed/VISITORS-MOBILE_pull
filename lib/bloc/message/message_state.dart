part of 'message_cubit.dart';

class MessageState {
  final bool isLoading;
  List<MessageModel>? messageModel;
  MessageState({
    this.isLoading = false,
    this.messageModel,
  });
  MessageState copyWith({
    bool? isLoading,
    List<MessageModel>? messageModel,
  }) {
    return MessageState(
        isLoading: isLoading ?? this.isLoading,
        messageModel: messageModel ?? this.messageModel);
  }
}
