import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:amirta_mobile/repository/rusun_repository.dart';
import 'package:dio/dio.dart';

class RusunRepositoryImpl extends RusunRepository {
  RusunRepositoryImpl(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<RusunResponse> getRusunawa() async {
    final response = await get("/flats");
    return (isResult(response)) ? RusunResponse.fromJson(response) : response;
  }

  Future<RusunBlokResponse> getBlok(int rusunId) async {
    final query = {"rusun_id": rusunId};
    final response = await get("/buildings", query: query);
    return (isResult(response))
        ? RusunBlokResponse.fromJson(response)
        : response;
  }

  Future<RusunUnitResponse> getUnit({
    required int rusunId,
    int? buildingId,
    int? floor,
    int? meterType,
    int? month,
    int? year,
    bool? isReported,
    required int page,
    required int limit,
  }) async {
    final Map<String, dynamic> query = {
      "rusun_id": rusunId,
      "building_id": buildingId,
      "floor": floor,
      "page": page,
      "limit": limit,
    }..addAll(meterType == null
        ? {}
        : {
            "meter_type": meterType,
            "month": month,
            "year": year,
          });
    final response = await get("/units", query: query);
    return (isResult(response))
        ? RusunUnitResponse.fromJson(response)
        : response;
  }

  Future<RusunUnitDetailResponse> getUnitInfoById(
    int id,
    int? meterType,
    int? month,
    int? year,
  ) async {
    final Map<String, dynamic> query = {
      "id": id,
    }..addAll(meterType == null
        ? {}
        : {
            "meter_type": meterType,
            "month": month,
            "year": year,
          });
    final response = await get("/unit_info", query: query);
    return (isResult(response))
        ? RusunUnitDetailResponse.fromJson(response)
        : response;
  }

  Future<RusunUnitDetailResponse> getUnitInfoByPLN(
    String plnNumber,
    int? meterType,
    int? month,
    int? year,
  ) async {
    final Map<String, dynamic> query = {
      "pln_number": plnNumber,
    }..addAll(meterType == null
        ? {}
        : {
            "meter_type": meterType,
            "month": month,
            "year": year,
          });
    final response = await get("/unit_info", query: query);
    return (isResult(response))
        ? RusunUnitDetailResponse.fromJson(response)
        : response;
  }

  Future<RusunUnitDetailResponse> getUnitInfoByPDAM(
    String pdamNumber,
    int? meterType,
    int? month,
    int? year,
  ) async {
    final Map<String, dynamic> query = {
      "pdam_number": pdamNumber,
    }..addAll(meterType == null
        ? {}
        : {
            "meter_type": meterType,
            "month": month,
            "year": year,
          });
    final response = await get("/unit_info", query: query);
    return (isResult(response))
        ? RusunUnitDetailResponse.fromJson(response)
        : response;
  }

  Future<SimpleResponse> addMeterData(MeterDataWrite dataWrite) async {
    final response = await post("/pln_pdam_meter", dataWrite.toJson());
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }

  Future<SimpleResponse> changeMeterStatus(MeterStatusWrite statusWrite) async {
    final response =
        await post("/change_pln_pdam_meter_status", statusWrite.toJson());
    return (isResult(response)) ? SimpleResponse.fromJson(response) : response;
  }
}
