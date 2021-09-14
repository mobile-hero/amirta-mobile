import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class AccountRepository extends BaseRepository {
  AccountRepository(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<ProfileResponse> login(LoginWrite login);

  Future<dynamic> logout();

  Future<ProfileResponse> getProfile();

  Future<SimpleResponse> forgotPassword(String email);

  Future<SimpleResponse> changePassword(String oldPassword, String newPassword);

  Future<ProfileResponse> editProfile(EditProfile edit);

  Future<DashboardResponse> dashboard();
}
