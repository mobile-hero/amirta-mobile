import 'package:amirta_mobile/my_material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final bool isEnabled;
  final bool isLoading;

  const PrimaryButton(
    this.onPressed,
    this.text, {
    this.padding = buttonDefaultPadding,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: buttonDefaultHeight,
        child: Builder(
          builder: (context) {
            if (isLoading) {
              return MyProgressIndicator();
            }
            return TextButton(
              onPressed: isEnabled ? onPressed : null,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                // shape: MaterialStateProperty.all(
                //   RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(buttonRadius),
                //   ),
                // ),
                // backgroundColor: MaterialStateProperty.resolveWith((states) {
                //   if (states.contains(MaterialState.disabled)) {
                //     return grey;
                //   }
                //   return red;
                // }),
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
                  width: double.infinity,
                  height: buttonDefaultHeight,
                  child: Center(
                    child: Text(
                      text,
                      style: context.styleButton,
                    ),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
