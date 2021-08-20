import 'package:amirta_mobile/my_material.dart';

Future<T?> showMyModalBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
}) {
  final brightnessLight = Theme.of(context).brightness == Brightness.light;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    builder: builder,
    enableDrag: false,
    isDismissible: false,
    elevation: 20,
    backgroundColor: brightnessLight ? white : darkBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(spaceMedium),
      ),
    ),
  );
}
