
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:visitors/model/message/message_model.dart';

import '../../model/message/message_response_model.dart';
import '../../model/message/send_response_messages_model.dart';
import '../../repo/message/message_repo.dart';
import '../../repo/message/message_repo_impl.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  MessageCubit() : super(MessageState());
  final MessageRepo _messageRepo = MessageImpl();

  Future<void> getMessages() async {
    emit(state.copyWith(isLoading: true));
    MessagesResponseModel? response = await _messageRepo.getMessages().onError(
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
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching message');
    }
  }
  Future<void> getMoreMessage({
    String? keyword,
  }) async {
    int page = state.page + 1;
    emit(state.copyWith(loadMore: true, isLoading: false, page: page));
    MessagesResponseModel? response = await _messageRepo
        .getMessages(
      page: state.page,
    )
        .onError(
          (error, stackTrace) {
        emit(state.copyWith(loadMore: false));
        Fluttertoast.showToast(
          msg: error.toString(),
        );
        throw error!;
      },
    );
    emit(state.copyWith(loadMore: false));
    if (response != null && response.status == 'success') {
      if (response.record?.isNotEmpty ?? false) {
        List<MessageModel> checkIns = state.messageModel ?? [];
        checkIns.addAll(response.record as Iterable<MessageModel>);
        emit(state.copyWith(messageModel: checkIns));
      } else {
        Fluttertoast.showToast(msg: 'No more message');
        page = state.page - 1;
        emit(state.copyWith(page: page));
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Something went wrong while fetching message');
    }
  }
  Future<bool> sendMessage(
      BuildContext context, {
        required Map<String, dynamic> data,
        List<String>? filesPaths,
      }) async {
    emit(state.copyWith(
      isSendMessageLoading: true,
    ));

    try {
      List<http.MultipartFile> multipartFiles = [];
      if (filesPaths?.isNotEmpty ?? false) {
        for (int i = 0; i < (filesPaths?.length ?? 0); i++) {
          if (filesPaths?[i].isNotEmpty ?? false) {
            multipartFiles.add(
              await http.MultipartFile.fromPath('attachments[]', filesPaths?[i] ?? ""),
            );
          }
        }
      }

      SendMessageResponseModel? response = await _messageRepo
          .sendMessage(
        data: data,
        files: multipartFiles,
      )
          .onError((error, stackTrace) {
        emit(state.copyWith(isSendMessageLoading: false));
        Fluttertoast.showToast(msg: error.toString());
        return null;
      });

      emit(state.copyWith(isSendMessageLoading: false));

      if (response != null && response.status == 'success') {
        Fluttertoast.showToast(msg: 'Message sent successfully');
        getMessages();
        return true;
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong while sending message');
        return false;
      }
    } catch (e) {
      emit(state.copyWith(isSendMessageLoading: false));
      Fluttertoast.showToast(msg: e.toString());
      return false;
    }
  }

}
