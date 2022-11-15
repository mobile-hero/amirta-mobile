import 'package:amirta_mobile/my_material.dart';

extension CustomBottomSheet on BuildContext {
  Future<T?> showScrollableBottomSheet<T>({required ScrollableWidgetBuilder builder}) {
    final brightnessLight = Theme.of(this).brightness == Brightness.light;
    final height = MediaQuery.of(this).size.height;
    final top = MediaQuery.of(this).viewPadding.top;
    final fullRatio = ((height - top) - (height / 8)) / height;
    return showModalBottomSheet<T?>(
      context: this,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: fullRatio,
          initialChildSize: fullRatio,
          minChildSize: fullRatio - 0.2,
          builder: builder,
        );
      },
      enableDrag: false,
      isDismissible: false,
      elevation: 20,
      backgroundColor: white,//brightnessLight ? white : darkBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(spaceMedium),
        ),
      ),
    );
  }
}
