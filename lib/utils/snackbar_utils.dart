import 'package:amirta_mobile/my_material.dart';

extension SnackBarUtils on BuildContext {
  void showCustomSnackBar(String message) {
    ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: grease,
          content: Text(
            message,
            style: styleBody1.copyWith(
              color: white,
            ),
          ),
        ),
      );
  }
}
