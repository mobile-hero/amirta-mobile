import 'package:flutter/material.dart';
import 'package:amirta_mobile/res/resources.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets padding;
  final bool isEnabled;

  const PrimaryButton(
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
            shape: MaterialStateProperty.all(StadiumBorder()),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return grey;
              }
              return red;
            }),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.disabled)) {
                return darkerGrey;
              }
              return white;
            }),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: white,
                  letterSpacing: buttonTextLetterSpacing,
                ),
          ),
        ),
      ),
    );
  }
}
