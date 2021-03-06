import 'dart:io';

import 'package:alga/data/const.dart';
import 'package:alga/utils/app_box.dart';
import 'package:dio/dio.dart';

class BaseRepo {
  final dio = Dio(BaseOptions(baseUrl: Const.API_BASE_URL));

  Future<void> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    await dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }

  BaseRepo() {
    initDio();
  }

  void initDio() {
    final _interceptor = InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (AppBox.token.access != null) {
          options.headers[HttpHeaders.authorizationHeader] =
              'Bearer ${AppBox.token.access}';
        }

        return handler.next(options);
      },
      onError: (error, handler) async {
        try {
          print('${error.requestOptions.path} error ${error.error}');
          final statusCode = error.response?.statusCode;
          if ((statusCode == 403 || statusCode == 401) && AppBox.isLogin) {
            await _retry(error.requestOptions);
          } else {
            handler.next(error);
          }
        } catch (e) {
          handler.next(error);
        }
      },
    );
    dio.interceptors.add(_interceptor);
  }

  String getUrlWithArguments(String url,
      {Map<String, dynamic> args = const {}}) {
    String sep = '?';
    args.forEach((key, value) {
      if (value != null) {
        url += '$sep$key=$value';
        sep = '&';
      }
    });
    return url;
  }

  bool isOk(Response response) =>
      response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 204;

  Future<Response<T>> get<T>(String url,
      {Map<String, dynamic>? params, Options? options}) {
    return dio.get<T>(url, queryParameters: params, options: options);
  }

  Future<Response<T>> post<T>(String url, {data, Options? options}) {
    return dio.post(url, data: data, options: options);
  }

  Future<Response<T>> put<T>(String url, {data, Options? options}) {
    return dio.put<T>(url, data: data, options: options);
  }

  Future<Response<T>> patch<T>(String url, {data, Options? options}) {
    return dio.patch<T>(url, data: data, options: options);
  }

  Future<Response<T>> delete<T>(String url, {data, Options? options}) {
    return dio.delete<T>(url, data: data, options: options);
  }
}
