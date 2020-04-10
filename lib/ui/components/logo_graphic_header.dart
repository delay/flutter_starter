import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'App Logo',
      child: CircleAvatar(
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/default.png',
              fit: BoxFit.cover,
              width: 120.0,
              height: 120.0,
            ),
          )),
    );
  }
}
