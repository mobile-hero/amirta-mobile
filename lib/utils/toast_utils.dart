import 'package:amirta_mobile/my_material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

enum CustomToastType { success, error }

extension ToastUtils on BuildContext {
  ToastFuture showCustomToast({
    required CustomToastType type,
    required String message,
  }) {
    return showToastWidget(
      Container(
        padding: const EdgeInsets.all(spaceSmall),
        margin: const EdgeInsets.symmetric(horizontal: spaceMedium),
        decoration: BoxDecoration(
          color: type == CustomToastType.success ? waterfall : scarlet,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(spaceTiny),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type == CustomToastType.success
                    ? waterfallDark
                    : scarletDark,
              ),
              child: Icon(
                type == CustomToastType.success ? Icons.check : Icons.close,
                color: white,
              ),
            ),
            const SizedBox(
              width: spaceSmall,
            ),
            Flexible(
              child: Text(
                message,
                style: styleBody1.copyWith(
                      color: white,
                    ),
              ),
            ),
          ],
        ),
      ),
      context: this,
      isHideKeyboard: true,
      position: StyledToastPosition.bottom,
      animation: StyledToastAnimation.fade,
      reverseAnimation: StyledToastAnimation.fade,
    );
  }
}
