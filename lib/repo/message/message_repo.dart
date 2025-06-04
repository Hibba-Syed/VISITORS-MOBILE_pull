import 'package:http/http.dart' as http;

import '../../model/message/message_response_model.dart';
import '../../model/message/send_response_messages_model.dart';

abstract class MessageRepo {
Future<MessagesResponseModel?> getMessages({
  int? page,
  int? limit,
});
Future<SendMessageResponseModel?> sendMessage({
  required Map<String, dynamic> data,
   List<http.MultipartFile>? files,
});
}