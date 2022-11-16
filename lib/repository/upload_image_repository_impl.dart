import 'package:amirta_mobile/data/account/account_export.dart';
import 'package:amirta_mobile/data/upload/upload_export.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:amirta_mobile/repository/upload_image_repository.dart';
import 'package:dio/dio.dart';

class UploadImageRepositoryImpl extends UploadImageRepository {
  UploadImageRepositoryImpl(Dio dio, RepositoryConfig config)
      : super(dio, config);

  @override
  Future<ProfileResponse> uploadPhotoProfile(String imageBase64) async {
    final body = {'img': imageBase64};
    final response = await post('/upload_propic', body);
    return isResult(response)
        ? ProfileResponse.fromJson(response)
        : response;
  }

  @override
  Future<UploadImageResponse> uploadImageFile(String imageBase64) async {
    final body = {'img': imageBase64};
    final response = await post('/index.php/upload_image', body);
    return isResult(response)
        ? UploadImageResponse.fromJson(response)
        : response;
  }
}
