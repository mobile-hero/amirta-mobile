import 'package:amirta_mobile/my_material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final EdgeInsets padding;
  final bool isEnabled;

  const ImageButton(
    this.onPressed,
    this.child, {
    this.padding = buttonDefaultPadding,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: buttonDefaultHeight,
        child: TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return darkerGrey;
              }
              return white;
            }),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonRadius),
              color: isEnabled ? null : inputDisabledColor,
              gradient: isEnabled == false
                  ? null
                  : LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        gradientTop,
                        gradientBottom,
                      ],
                    ),
            ),
            child: Container(
              height: buttonDefaultHeight,
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
