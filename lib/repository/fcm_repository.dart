import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class FcmRepository extends BaseRepository {
  FcmRepository(Dio dio, RepositoryConfig config) : super(dio, config);
  
  Future<dynamic> registerFcmId(String fcmId);
}
