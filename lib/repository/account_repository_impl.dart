import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/account_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

class AccountRepositoryImpl extends AccountRepository {
  AccountRepositoryImpl(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<ProfileResponse> login(LoginWrite login) async {
    final response = await post("/signin", login.toJson());
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }

  Future<dynamic> logout() async {
    final response = await post("/signout", {});
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }

  Future<ProfileResponse> getProfile() async {
    final response = await get("/myprofile");
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }

  Future<SimpleResponse> forgotPassword(String email) async {
    final query = {"email_address": email};
    final response = await get("/reset_passwd", query: query);
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  Future<SimpleResponse> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final body = {"old_passwd": oldPassword, "passwd": newPassword};
    final response = await post("/change_passwd", body);
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  Future<ProfileResponse> editProfile(EditProfile edit) async {
    final response = await post("/setup_account", edit.toJson());
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }
}
