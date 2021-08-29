import 'package:dio/dio.dart';

class RepositoryConfig {
  final String baseUrl;
  final Options options = Options(validateStatus: (status) {
    return status != null && status < 500;
  });
  final List<Interceptor> interceptors = [];
  final logInterceptor = LogInterceptor(requestBody: true, responseBody: true);

  RepositoryConfig(this.baseUrl);

  String? token;
  String? pid;
  String? version;
  String? deviceId;

  RepositoryConfig setToken(String token) {
    this.token = token;
    return this;
  }

  RepositoryConfig setPid(String pid) {
    this.pid = pid;
    return this;
  }

  RepositoryConfig setVersion(String version) {
    this.version = version;
    return this;
  }
  
  RepositoryConfig setDeviceId(String deviceId) {
    this.deviceId = deviceId;
    return this;
  }

  setupInterceptor() {
    interceptors.clear();
    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      if (token != null) {
        options.headers["sessid"] = "$token";
      }
      if (pid != null) {
        options.headers["pid"] = pid;
      }
      options.headers["version"] = version;
      handler.next(options);
    }));
    // interceptors.add(logInterceptor);
  }

  static RepositoryConfig staging() =>
      RepositoryConfig("https://amirtadev-sirukim.jakarta.go.id/");

  static RepositoryConfig production() =>
      RepositoryConfig("https://amirta-sirukim.jakarta.go.id/");
}
