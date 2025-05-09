import '../../model/message/message_response_model.dart';

abstract class MessageRepo {
Future<MessagesResponseModel?> getMessages({
  int? page,
  int? limit,
}
);
}