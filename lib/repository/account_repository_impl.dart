import 'package:amirta_mobile/data/account/edit_profile.dart';
import 'package:amirta_mobile/data/account/login_write.dart';
import 'package:amirta_mobile/data/account/profile_response.dart';
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
    final response = await post("/myprofile", {});
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }

  Future<SimpleResponse> forgotPassword(String email) async {
    final response = await get(
      "/reset_passwd",
      query: {"email_address": email},
    );
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  Future<SimpleResponse> changePassword(
      String oldPassword, String newPassword) async {
    final response = await post(
      "/change_passwd",
      {"old_passwd": oldPassword, "passwd": newPassword},
    );
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  Future<ProfileResponse> editProfile(EditProfile edit) async {
    final response = await post("/setup_account", edit.toJson());
    return (isResult(response)) ? ProfileResponse.fromJson(response) : response;
  }
}
