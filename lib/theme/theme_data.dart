import 'package:flutter/material.dart';

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class AppTheme {
  AppTheme._();
  static const primaryColor = Color(0xFF2697FF);
  static const secondaryColor = Color(0xFF2A2D3E);
  static const bgColor = Color(0xFF212332);

  static const defaultPadding = 16.0;

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5: headline,
    headline6: title,
    subtitle2: subtitle,
    bodyText2: body2,
    bodyText1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

class AppIcon {
  AppIcon._();

  static const _kFontFam = 'TwitterIcon';
  static const IconData fabTweet = IconData(0xf029, fontFamily: _kFontFam);
  static const IconData messageEmpty = IconData(0xf187, fontFamily: _kFontFam);
  static const IconData messageFill = IconData(0xf554, fontFamily: _kFontFam);
  static const IconData search = IconData(0xf058, fontFamily: _kFontFam);
  static const IconData searchFill = IconData(0xf558, fontFamily: _kFontFam);
  static const IconData notification = IconData(0xf055, fontFamily: _kFontFam);
  static const IconData notificationFill =
      IconData(0xf019, fontFamily: _kFontFam);
  static const IconData messageFab = IconData(0xf053, fontFamily: _kFontFam);
  static const IconData home = IconData(0xf053, fontFamily: _kFontFam);
  static const IconData homeFill = IconData(0xF553, fontFamily: _kFontFam);
  static const IconData heartEmpty = IconData(0xf148, fontFamily: _kFontFam);
  static const IconData heartFill = IconData(0xf015, fontFamily: _kFontFam);

  static const IconData settings = IconData(0xf059, fontFamily: _kFontFam);
  static const IconData adTheRate = IconData(0xf064, fontFamily: _kFontFam);
  static const IconData reply = IconData(0xf151, fontFamily: _kFontFam);
  static const IconData retweet = IconData(0xf152, fontFamily: _kFontFam);
  static const IconData image = IconData(0xf109, fontFamily: _kFontFam);
  static const IconData camera = IconData(0xf110, fontFamily: _kFontFam);
  static const IconData arrowDown = IconData(0xf196, fontFamily: _kFontFam);
  static const IconData blueTick = IconData(0xf099, fontFamily: _kFontFam);

  static const IconData link = IconData(0xf098, fontFamily: _kFontFam);
  static const IconData unFollow = IconData(0xf097, fontFamily: _kFontFam);
  static const IconData mute = IconData(0xf101, fontFamily: _kFontFam);
  static const IconData viewHidden = IconData(0xf156, fontFamily: _kFontFam);
  static const IconData block = IconData(0xe609, fontFamily: _kFontFam);
  static const IconData report = IconData(0xf038, fontFamily: _kFontFam);
  static const IconData pin = IconData(0xf088, fontFamily: _kFontFam);
  static const IconData delete = IconData(0xf154, fontFamily: _kFontFam);

  static const IconData profile = IconData(0xf056, fontFamily: _kFontFam);
  static const IconData lists = IconData(0xf094, fontFamily: _kFontFam);
  static const IconData bookmark = IconData(0xf155, fontFamily: _kFontFam);
  static const IconData moments = IconData(0xf160, fontFamily: _kFontFam);
  static const IconData twitterAds = IconData(0xf504, fontFamily: _kFontFam);
  static const IconData bulb = IconData(0xf567, fontFamily: _kFontFam);
  static const IconData newMessage = IconData(0xf035, fontFamily: _kFontFam);

  static const IconData sadFace = IconData(0xf430, fontFamily: _kFontFam);
  static const IconData bulbOn = IconData(0xf066, fontFamily: _kFontFam);
  static const IconData bulbOff = IconData(0xf567, fontFamily: _kFontFam);
  static const IconData follow = IconData(0xf175, fontFamily: _kFontFam);
  static const IconData thumbpinFill = IconData(0xf003, fontFamily: _kFontFam);
  static const IconData calender = IconData(0xf203, fontFamily: _kFontFam);
  static const IconData locationPin = IconData(0xf031, fontFamily: _kFontFam);
  static const IconData edit = IconData(0xf112, fontFamily: _kFontFam);
}
