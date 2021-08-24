import 'package:amirta_mobile/my_material.dart';

extension TextThemeHelper on BuildContext {
  TextStyle get styleCaption {
    return Theme.of(this).textTheme.caption!;
  }

  TextStyle get styleOverline {
    return Theme.of(this).textTheme.overline!;
  }

  TextStyle get styleButton {
    return Theme.of(this).textTheme.button!;
  }

  TextStyle get styleBody1 {
    return Theme.of(this).textTheme.bodyText1!;
  }

  TextStyle get styleBody2 {
    return Theme.of(this).textTheme.bodyText2!;
  }

  TextStyle get styleSubtitle1 {
    return Theme.of(this).textTheme.subtitle1!;
  }

  TextStyle get styleSubtitle2 {
    return Theme.of(this).textTheme.subtitle2!;
  }

  TextStyle get styleHeadline6 {
    return Theme.of(this).textTheme.headline6!;
  }

  TextStyle get styleHeadline5 {
    return Theme.of(this).textTheme.headline5!;
  }
  
  TextStyle get styleHeadline4 {
    return Theme.of(this).textTheme.headline4!;
  }
  
  TextStyle get styleHeadline1 {
    return Theme.of(this).textTheme.headline1!;
  }
}
