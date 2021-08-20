import 'package:amirta_mobile/res/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledInputField<T> extends StatelessWidget {
  final TextEditingController _controller;
  final EdgeInsets padding;
  final String? hint;
  final String label;
  final String? error;
  final bool isPassword;
  final TextInputType inputType;
  final bool isEnabled;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLength;
  final double textSize;
  final TextStyle? style;
  final TextAlign textAlign;
  final int minLines;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool showOptionalLabel;
  final FocusNode? focusNode;

  const LabeledInputField(
    this._controller, {
    this.padding = const EdgeInsets.symmetric(vertical: spaceSmall),
    required this.label,
    this.hint,
    this.error,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
    this.prefix,
    this.suffix,
    this.maxLength,
    this.minLines = 1,
    this.textSize = textSizeBody1,
    this.style,
    this.textAlign = TextAlign.left,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = false,
    this.showOptionalLabel = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              spaceBig,
              0,
              spaceBig,
              spaceSmall,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? white
                        : textContentColor,
                  ),
                ),
                SizedBox(
                  width: spaceSmall,
                ),
                showOptionalLabel
                    ? Text(
                        "txt_optional".tr(),
                        style: TextStyle(
                            fontSize: textSizeCaption,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? white
                                    : borderColor),
                      )
                    : SizedBox(),
              ],
            ),
          ),
          TextField(
            controller: _controller,
            obscureText: isPassword,
            keyboardType: inputType,
            maxLength: maxLength,
            minLines: minLines,
            maxLines: minLines,
            style: style ?? TextStyle(color: textContentColor),
            textAlign: textAlign,
            textInputAction: textInputAction,
            textCapitalization: textCapitalization,
            autocorrect: autocorrect,
            focusNode: focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: spaceBig),
              counter: SizedBox(),
              prefix: prefix,
              suffixIcon: suffix,
              filled: true,
              fillColor: inputColor,
              enabled: isEnabled,
              labelText: label,
              hintText: hint,
              hintMaxLines: 4,
              errorText: error,
              errorMaxLines: 4,
              border: createBorder(transparent),
              enabledBorder: createBorder(transparent),
              focusedBorder: createBorder(grease),
              errorBorder: createBorder(red),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder createBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );
  }
}
