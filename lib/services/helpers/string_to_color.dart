import 'package:flutter/material.dart';

Color stringToColor(String value) {
  // https://stackoverflow.com/questions/49835146/how-to-convert-flutter-color-to-string-and-back-to-a-color
  if (value == '' || value == null) {
    return Colors.black;
  }
  String colorString = value.split('(0x')[1].split(')')[0]; // kind of hacky..
  int colorValue = int.parse(colorString, radix: 16);
  return new Color(colorValue);
}
