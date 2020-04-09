import 'package:flutter/material.dart';
/*
LabelButton(
                labelText: 'Some Text',
                onPressed: () => print('implement me'),
              ),
*/

class LabelButton extends StatelessWidget {
  LabelButton({this.labelText, this.onPressed});
  final String labelText;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        labelText,
      ),
      onPressed: onPressed,
    );
  }
}
