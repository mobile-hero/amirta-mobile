import 'package:amirta_mobile/data/rusun/rusun_export.dart';

class WaterSearchResultArgument {
  final int month;
  final int year;
  final Rusun rusun;
  final RusunBlok blok;
  final int? lantai;
  final String? number;

  WaterSearchResultArgument(
    this.month,
    this.year,
    this.rusun,
    this.blok,
    this.lantai,
    this.number,
  );
}
