import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:amirta_mobile/res/dimens.dart';
import 'package:amirta_mobile/res/colors.dart';

const TextTheme customTextTheme = TextTheme(
  headline1: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeHeadline1,
    inherit: true,
    color: grease,
  ),
  headline2: TextStyle(
    inherit: true,
    color: grease,
  ),
  headline3: TextStyle(
    inherit: true,
    color: grease,
  ),
  headline4: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeHeadline4,
    inherit: true,
    color: grease,
    height: 1.208,
  ),
  headline5: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeHeadline5,
    inherit: true,
    color: grease,
    height: 1.22,
  ),
  headline6: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: textSizeHeadline6,
    inherit: true,
    color: grease,
    height: 1.444,
  ),
  bodyText1: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: textSizeBody1,
    inherit: true,
    color: grease,
    height: 1.571,
  ),
  bodyText2: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeBody2,
    inherit: true,
    color: grease,
    height: 1.25,
  ),
  subtitle1: TextStyle(
    fontSize: textSizeSubtitle1,
    inherit: true,
    color: grease,
    height: 1.125,
  ),
  subtitle2: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeSubtitle2,
    inherit: true,
    color: grease,
    height: 1.428,
  ),
  caption: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: textSizeCaption,
    color: grease,
    inherit: true,
    height: 1.333,
  ),
  overline: TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: textSizeOverline,
    inherit: true,
    color: grease,
    height: 1.25,
    letterSpacing: 0,
  ),
  button: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: textSizeBody1,
    color: white,
    inherit: true,
    height: 1.25,
    letterSpacing: buttonTextLetterSpacing,
  ),
);
