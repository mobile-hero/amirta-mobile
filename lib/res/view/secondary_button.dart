import 'package:amirta_mobile/my_material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final bool isEnabled;
  final bool isLoading;

  const SecondaryButton(
    this.onPressed,
    this.text, {
    Key? key,
    this.padding = buttonDefaultPadding,
    this.isEnabled = true,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: buttonDefaultHeight,
        child: Builder(builder: (context) {
          if (isLoading) {
            return const MyProgressIndicator();
          }
          return TextButton(
            onPressed: isEnabled ? onPressed : null,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
            ),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(buttonRadius),
                border: Border.all(
                  color: isEnabled ? egyptian : inputDisabledColor,
                ),
                color: transparent,
              ),
              child: SizedBox(
                width: double.infinity,
                height: buttonDefaultHeight,
                child: Center(
                  child: Text(
                    text,
                    style: context.styleButton.copyWith(
                      color: egyptian,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
