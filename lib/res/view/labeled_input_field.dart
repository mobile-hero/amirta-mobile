import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LabeledInputField<T> extends StatefulWidget {
  final TextEditingController _controller;
  final EdgeInsets padding;
  final String? hint;
  final String label;
  final String? error;
  final bool isPassword;
  final TextInputType inputType;
  final bool isEnabled;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
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
  final VoidCallback? onTap;

  const LabeledInputField(
    this._controller, {
    this.padding = const EdgeInsets.symmetric(vertical: spaceSmall),
    required this.label,
    this.hint,
    this.error,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
    this.readOnly = false,
    this.prefix,
    this.suffix,
      this.suffixConstraints,
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
    this.onTap,
  });

  @override
  _LabeledInputFieldState<T> createState() => _LabeledInputFieldState<T>();
}

class _LabeledInputFieldState<T> extends State<LabeledInputField<T>> {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: hasFocus ? grease : borderColor,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.all(spaceSmall),
            child: Transform.translate(
              offset: Offset(0, 5),
              child: TextField(
                controller: widget._controller,
                obscureText: widget.isPassword,
                keyboardType: widget.inputType,
                maxLength: widget.maxLength,
                minLines: widget.minLines,
                maxLines: widget.minLines,
                style: widget.style ?? context.styleBody1.copyWith(
                  color: grease.withOpacity(widget.isEnabled ? 1.0 : 0.7),
                ),
                textAlign: widget.textAlign,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                autocorrect: widget.autocorrect,
                readOnly: widget.readOnly,
                onTap: widget.onTap,
                focusNode: focusNode,
                decoration: InputDecoration(
                  isDense: true,
                  counter: SizedBox(),
                  prefix: widget.prefix,
                  suffixIcon: widget.suffix,
                  enabled: widget.isEnabled,
                  labelText: widget.label,
                  labelStyle: context.styleCaption.copyWith(
                    color: grease.withOpacity(0.5),
                  ),
                  hintText: widget.hint,
                  hintMaxLines: 4,
                  errorText: widget.error,
                  errorMaxLines: 4,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIconConstraints: widget.suffixConstraints
                  // errorBorder: createBorder(red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputBorder createBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
    );
  }
}
