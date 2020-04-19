import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/services/services.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    String _imageLogo = 'assets/images/default.png';
    if (themeProvider.isDarkModeOn == true) {
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
