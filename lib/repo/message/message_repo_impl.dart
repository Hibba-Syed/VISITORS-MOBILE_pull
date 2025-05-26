import 'package:http/http.dart' as http;
import 'package:visitors/model/message/send_response_messages_model.dart';
import 'package:visitors/repo/message/message_repo.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/message/message_response_model.dart';
import '../../resource/constants/api_url.dart';

class MessageImpl implements MessageRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<MessagesResponseModel?> getMessages({
    int? page,
    int? limit,
  }) async {
    try {
      String url =
          '${ApiUrl.messages}?page=${page ?? 1}&limit=${limit ??10}';
      print('message^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return MessagesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
  @override
  Future<SendMessageResponseModel?> sendMessage({
    required Map<String, dynamic> data,
    required List<http.MultipartFile> files,
  }) async {
    try {
      String url = ApiUrl.sendMessage;
      print('send message^^ $url');
      dynamic response = await _apiService.getAuthPostApiMultipartResponse(
        url,
        data,
        files,
      );
      return SendMessageResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

}