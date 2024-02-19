import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://newsapi.org/",
        // baseUrl: "https://newsdata.io/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

// final dio = Dio();
//                 final response = await dio.get('https://pub.dev');
//                 print(response.data);

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    // required dynamic query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
}
