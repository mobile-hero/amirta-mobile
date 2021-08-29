import 'package:amirta_mobile/data/error_message.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/repository/account_local_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class BaseRepository {
  final Dio _dio;
  final RepositoryConfig _config;

  BaseRepository(this._dio, this._config);

  bool isResult(dynamic response) => !(response is ErrorMessage);

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response =
          await _dio.get(_config.baseUrl + path, queryParameters: query);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> post(String path, data) async {
    try {
      final response = await _dio.post(_config.baseUrl + path, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String path, data) async {
    try {
      final response = await _dio.put(_config.baseUrl + path, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> patch(String path, data) async {
    try {
      final response = await _dio.patch(_config.baseUrl + path, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String path, data) async {
    try {
      final response = await _dio.delete(_config.baseUrl + path, data: data);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future _handleError(dynamic error) async {
    print(error.toString());
    if (error is DioError) {
      try {
        final data = SimpleResponse.fromJson(error.response!.data);
        if (data.responsecode == "01") {
          if (error.requestOptions.path ==
              _config.baseUrl + "/customer/refresh_token") {
            return Future.error(ErrorMessage(
              messages: {ErrorMessage.keyMessage: "msg_session_expired".tr()},
              shouldRelogin: true,
              errorCode: 30002,
            ));
          } else {
            return Future.error(ErrorMessage(
                messages: {}, shouldRelogin: false, errorCode: 30002));
          }
        } else {
          return _handleOtherErrorCodes(data);
        }
      } catch (_) {}
    }

    return Future.error(ErrorMessage(
      messages: ErrorMessage.defaultMessages,
      shouldRelogin: false,
    ));
  }

  Future _handleOtherErrorCodes(SimpleResponse data) {
    try {
      final messages = {
        ErrorMessage.keyMessage: data.responsemessage.toString().tr()
      };
      return Future.error(ErrorMessage(
        response: data,
        messages: messages,
        errorCode: data.responsecode,
      ));
    } catch (e) {
      final messages = {ErrorMessage.keyMessage: data.responsemessage};
      return Future.error(ErrorMessage(
        response: data,
        messages: messages,
        errorCode: data.responsecode,
      ));
    }
  }
}
