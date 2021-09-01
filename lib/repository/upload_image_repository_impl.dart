import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:amirta_mobile/repository/upload_image_repository.dart';
import 'package:dio/dio.dart';

class UploadImageRepositoryImpl extends UploadImageRepository {
  UploadImageRepositoryImpl(Dio dio, RepositoryConfig config)
      : super(dio, config);

  Future<dynamic> uploadPhotoProfile(String imageBase64) async {
    final body = {"img": imageBase64};
    final response = await post("/upload_propic", body);
    return response;
  }

  Future<dynamic> uploadImageFile(String imageBase64) async {
    final body = {"img": imageBase64};
    final response = await post("/index.php/upload_image", body);
    return response;
  }
}
