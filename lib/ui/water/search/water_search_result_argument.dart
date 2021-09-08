import 'package:amirta_mobile/data/rusun/rusun_export.dart';

class WaterSearchResultArgument {
  final Rusun rusun;
  final RusunBlok blok;
  final int? lantai;
  final String? number;
  final int? month;
  final int? year;

  WaterSearchResultArgument(
    this.rusun,
    this.blok,
    this.lantai,
    this.number,
    this.month,
    this.year,
  );
}
