import 'package:http/http.dart' as http;

abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getAuthGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data);

  Future<dynamic> getAuthPostApiResponse(String url, dynamic data);
  Future<dynamic> getAuthPutApiResponse(String url, {dynamic data});
  Future<dynamic> getAuthDeleteApiResponse(String url,{dynamic data});

  Future<dynamic> getPostApiMultipartResponse(
    String url,
    Map<String, dynamic>? data,
    List<http.MultipartFile> files,
  );
  Future getAuthPostApiMultipartResponse(
    String url,
    Map<String, dynamic>? data,
    List<http.MultipartFile> files,
  );
  Future getAuthPutApiMultipartResponse(
      String url,
      Map<String, dynamic>? data,
      List<http.MultipartFile> files,
      );
}
