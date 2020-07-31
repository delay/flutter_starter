import 'package:flutter/material.dart';
import 'package:flutter_starter/controllers/controllers.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();
  final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
    if (themeController.isDarkModeOn == true) {
      _imageLogo = 'assets/images/defaultDark.png';
    }
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              _imageLogo,
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
