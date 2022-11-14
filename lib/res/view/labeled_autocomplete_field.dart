import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:amirta_mobile/res/resources.dart';

class LabeledAutocompleteField<T> extends StatelessWidget {
  final TextEditingController _controller;
  final EdgeInsets padding;
  final String? hint;
  final String label;
  final String? error;
  final bool isPassword;
  final TextInputType inputType;
  final bool isEnabled;
  final Widget? prefix;
  final int? maxLength;
  final double textSize;
  final TextStyle? style;
  final TextAlign textAlign;
  final int minLines;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final ItemBuilder<T> itemBuilder;
  final SuggestionSelectionCallback<T> onSuggestionSelected;
  final SuggestionsCallback<T> suggestionsCallback;
  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? noItemsFoundBuilder;
  final ErrorBuilder? errorBuilder;

  const LabeledAutocompleteField(
    this._controller, {
    this.padding = const EdgeInsets.symmetric(vertical: spaceSmall),
    required this.label,
    this.hint,
    this.error,
    this.isPassword = false,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
    this.prefix,
    this.maxLength,
    this.minLines = 1,
    this.textSize = textSizeBody1,
    this.style,
    this.textAlign = TextAlign.left,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    required this.itemBuilder,
    required this.onSuggestionSelected,
    required this.suggestionsCallback,
    this.loadingBuilder,
    this.noItemsFoundBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(spaceBig, 0, spaceBig, spaceSmall),
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).brightness == Brightness.dark ? white : textContentColor),
            ),
          ),
          TypeAheadField<T>(
              textFieldConfiguration: TextFieldConfiguration(
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
                focusNode: focusNode,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: spaceBig),
                  counter: SizedBox(),
                  prefix: prefix,
                  filled: true,
                  fillColor: inputColor,
                  enabled: isEnabled,
                  hintText: hint,
                  errorText: error,
                  border: createBorder(transparent),
                  enabledBorder: createBorder(transparent),
                  focusedBorder: createBorder(red),
                  errorBorder: createBorder(red),
                ),
              ),
              debounceDuration: Duration(milliseconds: 300),
              direction: AxisDirection.up,
              suggestionsCallback: suggestionsCallback,
              itemBuilder: itemBuilder,
              onSuggestionSelected: onSuggestionSelected),
        ],
      ),
    );
  }

  OutlineInputBorder createBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color), borderRadius: const BorderRadius.all(Radius.circular(30)));
  }
}
