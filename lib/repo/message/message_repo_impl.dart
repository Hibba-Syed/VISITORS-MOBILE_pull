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
          '${ApiUrl.message}?page=${page ?? 1}&limit=${limit ??10}';
      print('message^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return MessagesResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}