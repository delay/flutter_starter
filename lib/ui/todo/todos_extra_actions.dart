import 'package:flutter/material.dart';
import 'package:flutter_starter/constants/app_strings.dart';
import 'package:flutter_starter/services/firestore_database.dart';
import 'package:provider/provider.dart';

enum TodosActions { toggleAllComplete, clearCompleted }

class TodosExtraActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoDB todoDB = Provider.of(context);

    return PopupMenuButton<TodosActions>(
      icon: Icon(Icons.more_horiz),
      onSelected: (TodosActions result) {
        switch (result) {
          case TodosActions.toggleAllComplete:
            todoDB.setAllTodoComplete();
            break;
          case TodosActions.clearCompleted:
            todoDB.deleteAllTodoWithComplete();
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<TodosActions>>[
        const PopupMenuItem<TodosActions>(
          value: TodosActions.toggleAllComplete,
          child: Text(AppStrings.todosPopUpToggleAllComplete),
        ),
        const PopupMenuItem<TodosActions>(
          value: TodosActions.clearCompleted,
          child: Text(AppStrings.todosPopUpToggleClearCompleted),
        ),
      ],
    );
  }
}
