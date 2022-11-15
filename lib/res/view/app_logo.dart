import 'package:amirta_mobile/my_material.dart';

class AppLogo extends StatelessWidget {
  final AppLogoSize logoSize;

  const AppLogo({
    Key? key,
    this.logoSize = AppLogoSize.medium,
  }) : super(key: key);

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
      child: Image.asset(
        imageRes('logo_amirta_alt.png'),
        color: white,
      ),
    );
  }
}

enum AppLogoSize { big, medium, small }
