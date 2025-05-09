import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';
import 'package:visitors/model/message/message_model.dart';

import '../../model/message/message_response_model.dart';
import '../../repo/message/message_repo.dart';
import '../../repo/message/message_repo_impl.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageState());
  final MessageRepo _messageRepo = MessageImpl();
  Future<void> getMessages(
      ) async {
    emit(state.copyWith(isLoading: true));
    MessagesResponseModel? response =
    await _messageRepo.getMessages(
    ).onError(
          (error, stackTrace) {
        emit(state.copyWith(isLoading: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(isLoading: false));
    if (response != null && response.status == 'success') {
      emit(state.copyWith(messageModel: response.record));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong while fetching message');
    }
  }
}
