import 'package:amirta_mobile/data/pengaduan/pengaduan_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/pengaduan_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

class PengaduanRepositoryImpl extends PengaduanRepository {
  PengaduanRepositoryImpl(Dio dio, RepositoryConfig config)
      : super(dio, config);

  Future<PengaduanResponse> getList(String status, int page, int limit) async {
    final query = {"status": status, "page": page, "limit": limit};
    final response = await get("/complaint", query: query);
    return (isResult(response))
        ? PengaduanResponse.fromJson(response)
        : response;
  }

  Future<PengaduanDetailResponse> detail(int pengaduanId) async {
    final query = {"id": pengaduanId};
    final response = await get("/complaint_detail", query: query);
    return (isResult(response))
        ? PengaduanDetailResponse.fromJson(response)
        : response;
  }

  @override
  Future<SimpleResponse> acceptRejectPanic(int id, int status) async {
    final body = {"id": id, "status": status};
    final response = await post("/accept_panic_button", body);
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  @override
  Future<SimpleResponse> postExamination(
    int id,
    int status,
    String notes,
    String fname,
  ) async {
    final body = {"id": id, "status": status, "notes": notes, "fname": fname};
    final response = await post("/complaint_examination", body);
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }
}
