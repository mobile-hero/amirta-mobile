import 'package:amirta_mobile/my_material.dart';

class ShadowedContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color? shadowColor;
  final Offset shadowOffset;
  final double shadowBlur;
  final double shadowSpread;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BoxBorder? border;
  final double borderRadius;
  final BorderRadius? borderRadiusObject;
  final double? height;
  final double? width;
  final bool hideShadow;

  const ShadowedContainer({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
    this.shadowColor,
    this.shadowOffset = Offset.zero,
    this.shadowBlur = 3,
    this.shadowSpread = 0.0,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.border,
    this.borderRadius = 0,
    this.borderRadiusObject,
    this.height,
    this.width,
    this.hideShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadiusObject ?? BorderRadius.circular(borderRadius),
        color: backgroundColor,
        boxShadow: hideShadow
            ? []
            : [
                BoxShadow(
                  color: shadowColor ?? shadowBoxColor,
                  offset: shadowOffset,
                  blurRadius: shadowBlur,
                  spreadRadius: shadowSpread,
                )
              ],
      ),
      child: child,
    );
  }
}
