import 'package:flutter/material.dart';
import 'package:flutter_starter/constants/app_strings.dart';

class EmptyContentWidget extends StatelessWidget {
  final String title;
  final String message;

  EmptyContentWidget(
      {Key key,
      this.title = AppStrings.todosEmptyTopMsgDefaultTxt,
      this.message = AppStrings.todosEmptyBottomDefaultMsgTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
          Text(message),
        ],
      ),
    );
  }
}
