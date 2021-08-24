import 'package:amirta_mobile/my_material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final AppLogoSize logoSize;

  AppLogo({this.logoSize = AppLogoSize.medium});

  @override
  Widget build(BuildContext context) {
    final isBig = logoSize == AppLogoSize.big;
    final isMedium = logoSize == AppLogoSize.medium;
    final double size = isBig
        ? 200
        : isMedium
            ? 126
            : 35;
    final double padding = isBig
        ? spaceBig
        : isMedium
            ? spaceMedium
            : spaceSmall;
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(padding),
      child: SvgPicture.asset(
        imageRes('logo_amirta_alt.svg'),
        color: white,
      ),
    );
  }
}

enum AppLogoSize { big, medium, small }
