import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();

  @override
  Widget build(BuildContext context) {
    String _imageLogo = 'assets/images/default.png';
    if (Get.isDarkMode == true) {
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
