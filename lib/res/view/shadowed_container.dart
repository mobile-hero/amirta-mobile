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
    final isDark = context.isDark;
    final _backgroundColor = isDark ? darkBackground : backgroundColor;
    final _shadowColor = isDark ? lightGrey : (shadowColor ?? shadowBoxColor);
    final _shadowOffset = isDark ? const Offset(0, 3) : shadowOffset;
    final _shadowBlur = isDark
        ? shadowBlur > 4.0
            ? 4.0
            : shadowBlur
        : shadowBlur;
    return Container(
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadiusObject ?? BorderRadius.circular(borderRadius),
        color: _backgroundColor,
        boxShadow: hideShadow
            ? null
            : [
                BoxShadow(
                  color: _shadowColor,
                  offset: _shadowOffset,
                  blurRadius: _shadowBlur,
                  spreadRadius: shadowSpread,
                )
              ],
      ),
      child: child,
    );
  }
}
