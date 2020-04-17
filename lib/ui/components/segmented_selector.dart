import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'dart:io';
/*
SegmentedSelector(
                menuOptions: list of dropdown options in key value pairs,
                selectedOption: menu option string value,
                onChanged: (value) => print('changed'),
              ),
*/

class SegmentedSelector extends StatelessWidget {
  SegmentedSelector(
      {this.menuOptions, this.selectedOption, this.onValueChanged});

  final List<dynamic> menuOptions;
  final String selectedOption;
  final void Function(dynamic) onValueChanged;

  @override
  Widget build(BuildContext context) {
    //if (Platform.isIOS) {}

    return CupertinoSlidingSegmentedControl(
        groupValue: selectedOption,
        children: Map.fromIterable(
          menuOptions,
          key: (option) => option.key,
          value: (option) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(option.icon),
              SizedBox(width: 6),
              Text(option.value),
            ],
          ),
        ),
        onValueChanged: onValueChanged);
  }
}
