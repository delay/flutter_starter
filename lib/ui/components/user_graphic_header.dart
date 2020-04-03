import 'package:flutter/material.dart';

class UserGraphicHeader extends StatelessWidget {
  UserGraphicHeader();

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
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
