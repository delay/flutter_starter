import 'package:flutter/material.dart';
//import 'package:flutter_starter/constants/app_font_family.dart';

class AppThemes {
  AppThemes._();
  static const Color mayaBlue = Color.fromRGBO(117, 190, 255, 1);
  static const Color dullLavender = Color.fromRGBO(171, 157, 242, 1);
  static const Color turquoiseBlue = Color.fromRGBO(120, 220, 232, 1);
  static const Color feijoa = Color.fromRGBO(169, 220, 118, 1);
  static const Color brinkPink = Color.fromRGBO(255, 97, 136, 1);
  static const Color juneBud = Color.fromRGBO(186, 215, 97, 1);
  static const Color ebonyClay = Color.fromRGBO(40, 42, 58, 1);
  static const Color vulcan = Color.fromRGBO(22, 24, 33, 1);
  static const Color nevada = Color.fromRGBO(105, 109, 119, 1);

  static String font1 = "ProductSans";
  static String font2 = "Roboto";
  //constants color range for light theme
  //main color
  static const Color _lightPrimaryColor = Colors.blue;

  //Background Colors
  static const Color _lightBackgroundColor = Color.fromRGBO(248, 250, 252, 1);
  static const Color _lightBackgroundAppBarColor = _lightPrimaryColor;
  static const Color _lightBackgroundSecondaryColor = Colors.white;
  static const Color _lightBackgroundAlertColor = Colors.black;
  static const Color _lightBackgroundErrorColor =
      Color.fromRGBO(255, 97, 136, 1);
  static const Color _lightBackgroundSuccessColor =
      Color.fromRGBO(186, 215, 97, 1);

  //Text Colors
  static const Color _lightTextColor = Colors.black;
  static const Color _lightAlertTextColor = Colors.black;
  static const Color _lightTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _lightBorderColor = Color.fromRGBO(224, 227, 234, 1);

  //Icon Color
  static const Color _lightIconColor = Color.fromRGBO(224, 227, 234, 1);

  static const Color _lightInputFillColor = _lightBackgroundSecondaryColor;
  static const Color _lightBorderActiveColor = _lightPrimaryColor;
  static const Color _lightBorderErrorColor = brinkPink;

  //text theme for light theme
  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 20.0, color: _lightTextColor);
  static final TextStyle _lightScreenTaskNameTextStyle =
      TextStyle(fontSize: 16.0, color: _lightTextColor);
  static final TextStyle _lightScreenTaskDurationTextStyle =
      TextStyle(fontSize: 14.0, color: Colors.grey);
  static final TextStyle _lightScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _lightTextColor, fontWeight: FontWeight.w500);
  static final TextStyle _lightScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0,
      color: _lightBackgroundAppBarColor,
      fontWeight: FontWeight.w100);

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeadingTextStyle,
    bodyText1: _lightScreenTaskNameTextStyle,
    bodyText2: _lightScreenTaskDurationTextStyle,
    button: _lightScreenButtonTextStyle,
    headline6: _lightScreenTaskNameTextStyle,
    subtitle1: _lightScreenTaskNameTextStyle,
    caption: _lightScreenCaptionTextStyle,
  );

  //constants color range for dark theme
  static const Color _darkPrimaryColor = Colors.blue;

  //Background Colors
  static const Color _darkBackgroundColor = ebonyClay;
  static const Color _darkBackgroundAppBarColor = _darkPrimaryColor;
  static const Color _darkBackgroundSecondaryColor = vulcan;
  static const Color _darkBackgroundAlertColor = Colors.black;
  static const Color _darkBackgroundErrorColor =
      Color.fromRGBO(255, 97, 136, 1);
  static const Color _darkBackgroundSuccessColor =
      Color.fromRGBO(186, 215, 97, 1);

  //Text Colors
  static const Color _darkTextColor = Colors.white;
  static const Color _darkAlertTextColor = Colors.black;
  static const Color _darkTextSecondaryColor = Colors.black;

  //Border Color
  static const Color _darkBorderColor = nevada;

  //Icon Color
  static const Color _darkIconColor = Color.fromRGBO(224, 227, 234, 1);

  static const Color _darkInputFillColor = _darkBackgroundSecondaryColor;
  static const Color _darkBorderActiveColor = _darkPrimaryColor;
  static const Color _darkBorderErrorColor = brinkPink;

  //text theme for dark theme
  static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkTextColor);
  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
  static final TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: 14.0, color: _darkTextColor, fontWeight: FontWeight.w500);
  static final TextStyle _darkScreenCaptionTextStyle = TextStyle(
      fontSize: 12.0,
      color: _darkBackgroundAppBarColor,
      fontWeight: FontWeight.w100);

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeadingTextStyle,
    bodyText1: _darkScreenTaskNameTextStyle,
    bodyText2: _darkScreenTaskDurationTextStyle,
    button: _darkScreenButtonTextStyle,
    headline6: _darkScreenTaskNameTextStyle,
    subtitle1: _darkScreenTaskNameTextStyle,
    caption: _darkScreenCaptionTextStyle,
  );

  //the light theme
  static final ThemeData lightTheme = ThemeData(
    fontFamily: font1,
    scaffoldBackgroundColor: _lightBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _lightPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _lightBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _lightTextColor),
      textTheme: _lightTextTheme,
    ),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightBackgroundColor,
      // secondary: _lightSecondaryColor,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: _lightBackgroundAlertColor),
    iconTheme: IconThemeData(
      color: _lightIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _lightBackgroundAppBarColor),
    textTheme: _lightTextTheme,
    buttonTheme: ButtonThemeData(
        buttonColor: _lightPrimaryColor, textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _lightPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _lightBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _lightBackgroundSecondaryColor,
      //focusColor: _lightBorderActiveColor,
    ),
  );

  //the dark theme
  static final ThemeData darkTheme = ThemeData(
    fontFamily: font1,
    scaffoldBackgroundColor: _darkBackgroundColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _darkPrimaryColor,
    ),
    appBarTheme: AppBarTheme(
      color: _darkBackgroundAppBarColor,
      iconTheme: IconThemeData(color: _darkTextColor),
      textTheme: _darkTextTheme,
    ),
    colorScheme: ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryVariant: _darkBackgroundColor,
      // secondary: _darkSecondaryColor,
    ),
    snackBarTheme:
        SnackBarThemeData(backgroundColor: _darkBackgroundAlertColor),
    iconTheme: IconThemeData(
      color: _darkIconColor,
    ),
    popupMenuTheme: PopupMenuThemeData(color: _darkBackgroundAppBarColor),
    textTheme: _darkTextTheme,
    buttonTheme: ButtonThemeData(
        buttonColor: _darkPrimaryColor, textTheme: ButtonTextTheme.primary),
    unselectedWidgetColor: _darkPrimaryColor,
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: nevada),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          )),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderColor, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderActiveColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: _darkBorderErrorColor),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      fillColor: _darkBackgroundSecondaryColor,
      //focusColor: _darkBorderActiveColor,
    ),
  );
}
