import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: false,
      ),
    );
  }

  static Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
    int? id,
  }) async {
    dio.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token ?? '',
    };
    return await dio.get(
      url,
      queryParameters: query ?? null,
    );
  }

  static Map<String, dynamic> getHeaders(lang, token) => {
        'lang': lang,
        'Authorization': token ?? '',
        'Content-Type': 'application/json',
      };

  static Future<dynamic> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = getHeaders(lang, token);
    return dio
        .post(url, queryParameters: query, data: data)
        .catchError((error) {
      print('DIO CLASS ERROR: $error');
    });
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) async {
    dio.options.headers = getHeaders(lang, token);
    return dio
        .put(
      url,
      data: data,
    )
        .catchError((error) {
      print("DIO ERROR $error");
    });
  }

  static Future<Response> deleteData(
      {required String url, String lang = 'en', String? token}) async {
    dio.options.headers = {
      'lang': '$lang',
      'Content-Type': 'application/json',
      'Authorization': '$token'
    };
    return await dio.delete(url);
  }
}
