import 'package:amirta_mobile/data/rusun/rusun_export.dart';
import 'package:amirta_mobile/data/simple_response.dart';
import 'package:amirta_mobile/repository/base_repository.dart';
import 'package:amirta_mobile/repository/repository_config.dart';
import 'package:dio/dio.dart';

abstract class RusunRepository extends BaseRepository {
  RusunRepository(Dio dio, RepositoryConfig config) : super(dio, config);

  Future<RusunResponse> getRusunawa();

  Future<RusunBlokResponse> getBlok(int rusunId);

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
  });

  Future<RusunUnitDetailResponse> getUnitInfoById(
    int id,
    int? meterType,
    int? month,
    int? year,
  );

  Future<RusunUnitDetailResponse> getUnitInfoByPLN(
    String plnNumber,
    int? meterType,
    int? month,
    int? year,
  );

  Future<RusunUnitDetailResponse> getUnitInfoByPDAM(
    String pdamNumber,
    int? meterType,
    int? month,
    int? year,
  );
  
  Future<SimpleResponse> addMeterData(MeterDataWrite dataWrite);
  
  Future<SimpleResponse> changeMeterStatus(MeterStatusWrite statusWrite);
}
