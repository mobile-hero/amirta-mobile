import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class UploadImageRepository extends BaseRepository {
  UploadImageRepository(Dio dio, RepositoryConfig config) : super(dio, config);
  
  Future<dynamic> uploadPhotoProfile(String imageBase64);
  
  Future<dynamic> uploadImageFile(String imageBase64);
}
