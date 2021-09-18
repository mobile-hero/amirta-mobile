import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class PengaduanRepository extends BaseRepository {
  PengaduanRepository(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<PengaduanResponse> getList(int type, int status, int page, int limit);

  Future<PengaduanDetailResponse> detail(int pengaduanId);
  
  Future<PengaduanDetailResponse> detailExamination(int pengaduanId);

  Future<SimpleResponse> acceptRejectPanic(int id, int status);

  Future<SimpleResponse> postExamination(
    int id,
    int status,
    String notes,
    List<String> photos,
  );
}
