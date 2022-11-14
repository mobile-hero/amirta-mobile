import 'package:amirta_mobile/my_material.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final bool isEnabled;

  const LogoutButton(
    this.onPressed,
    this.text, {
    this.padding = buttonDefaultPadding,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        width: double.infinity,
        height: buttonDefaultHeight,
        child: TextButton(
          onPressed: isEnabled ? onPressed : null,
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return darkerGrey;
              }
              return carrot;
            }),
          ),
          child: Center(
            child: Text(
              text,
              style: context.styleButton.copyWith(
                color: carrot,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
