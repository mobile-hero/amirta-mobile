import 'package:amirta_mobile/repository/fcm_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

class FcmRepositoryImpl extends FcmRepository {
  FcmRepositoryImpl(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<dynamic> registerFcmId(String fcmId) async {
    final response = await post("/fcm", {"fcmregid": fcmId});
    return response;
  }
}
