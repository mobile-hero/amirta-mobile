import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/data/upload/upload_export.dart';
import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class UploadImageRepository extends BaseRepository {
  UploadImageRepository(Dio dio, RepositoryConfig config) : super(dio, config);
  
  Future<ProfileResponse> uploadPhotoProfile(String imageBase64);
  
  Future<UploadImageResponse> uploadImageFile(String imageBase64);
}
