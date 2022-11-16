
import 'package:amirta_mobile/my_material.dart';

String numFormat(num? number) {
  return NumberFormat('###,###,###', 'id_ID').format(number ?? 0);
}