import 'package:amirta_mobile/data/error_message.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class BaseRepository {
  final Dio _dio;
  final RepositoryConfig _config;

  BaseRepository(this._dio, this._config);

  bool isResult(dynamic response) => response is! ErrorMessage;

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response =
          await _dio.get(_config.baseUrl + path, queryParameters: query);
      final simple = SimpleResponse.fromJson(response.data);
      if (simple.requestSuccess) {
        return response.data;
      } else {
        return _handleError(response.data);
      }
    } catch (e) {
      print(e);
      return _handleError(e);
    }
  }

  Future<dynamic> post(String path, data) async {
    try {
      final response = await _dio.post(_config.baseUrl + path, data: data);
      final simple = SimpleResponse.fromJson(response.data);
      if (simple.requestSuccess) {
        return response.data;
      } else {
        return _handleError(response.data);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> put(String path, data) async {
    try {
      final response = await _dio.put(_config.baseUrl + path, data: data);
      final simple = SimpleResponse.fromJson(response.data);
      if (simple.requestSuccess) {
        return response.data;
      } else {
        return _handleError(response.data);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> patch(String path, data) async {
    try {
      final response = await _dio.patch(_config.baseUrl + path, data: data);
      final simple = SimpleResponse.fromJson(response.data);
      if (simple.requestSuccess) {
        return response.data;
      } else {
        return _handleError(response.data);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> delete(String path, data) async {
    try {
      final response = await _dio.delete(_config.baseUrl + path, data: data);
      final simple = SimpleResponse.fromJson(response.data);
      if (simple.requestSuccess) {
        return response.data;
      } else {
        return _handleError(response.data);
      }
    } catch (e) {
      return _handleError(e);
    }
  }

  Future _handleError(dynamic error) async {
    if (error is DioError) {
      try {
        final data = SimpleResponse.fromJson(error.response!.data);
        if (data.responsecode == '01' &&
            data.responsemessage == 'Session Expired') {
          return Future.error(const ErrorMessage(
            messages: {},
            shouldRelogin: true,
            errorCode: '01',
          ));
        } else {
          return _handleOtherErrorCodes(data);
        }
      } catch (_) {}
    }

    try {
      final data = SimpleResponse.fromJson(error);
      if (data.responsecode == '01' &&
          data.responsemessage == 'Session Expired') {
        print (data.toJson());
        return Future.error(const ErrorMessage(
          messages: {},
          shouldRelogin: true,
          errorCode: '01',
        ));
      } else {
        return _handleOtherErrorCodes(data);
      }
    } catch (_) {
      return Future.error(ErrorMessage(
        messages: ErrorMessage.defaultMessages,
        shouldRelogin: false,
      ));
    }
  }

  Future _handleOtherErrorCodes(SimpleResponse data) {
    try {
      final messages = {ErrorMessage.keyMessage: data.responsemessage};
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
