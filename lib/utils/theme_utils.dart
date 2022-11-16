import 'package:amirta_mobile/my_material.dart';

extension MyThemeExtension on BuildContext {
  bool get isDark {
    return Theme.of(this).brightness == Brightness.dark;
  }
}
