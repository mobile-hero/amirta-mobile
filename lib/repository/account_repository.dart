import 'package:amirta_mobile/data/account/edit_profile.dart';
import 'package:amirta_mobile/data/account/login_write.dart';
import 'package:amirta_mobile/data/account/profile_response.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class AccountRepository extends BaseRepository {
  AccountRepository(Dio dio, RepositoryConfig config)
      : super(dio, config);
  
  Future<ProfileResponse> login(LoginWrite login);

  Future<dynamic> logout();

  Future<ProfileResponse> getProfile();

  Future<SimpleResponse> forgotPassword(String email);

  Future<SimpleResponse> changePassword(String oldPassword, String newPassword);

  Future<ProfileResponse> editProfile(EditProfile edit);
}
