import 'package:flutter/material.dart';
import 'package:flutter_starter/constants/app_strings.dart';
import 'package:flutter_starter/models/todo_model.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/services/firestore_database.dart';
import 'package:flutter_starter/ui/todo/empty_content.dart';
import 'package:flutter_starter/ui/todo/todos_extra_actions.dart';
import 'package:provider/provider.dart';

class TodosScreen extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final todoDB = Provider.of<TodoDB>(context, listen: false);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: StreamBuilder(
            stream: authProvider.userFirebaseAuth,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(width: 0.0, height: 0.0);
              } else {
                final UserModel user = snapshot.data;
                Widget _photoImage = SizedBox(height: 1);
                if ((user?.photoUrl != null) || (user?.photoUrl != '')) {
                  _photoImage = Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(user?.photoUrl),
                      ),
                    ),
                  );
                }
                return Row(
                  children: <Widget>[
                    _photoImage,
                    SizedBox(width: 20),
                    Text(user != null
                        ? user.name + " - " + user.email
                        : AppStrings.homeAppBarTitle),
                  ],
                );
              }
            }),
        actions: <Widget>[
          StreamBuilder(
              stream: todoDB.todosStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<TodoModel> todos = snapshot.data;
                  return Visibility(
                      visible: todos.isNotEmpty ? true : false,
                      child: TodosExtraActions());
                } else {
                  return Container(
                    width: 0,
                    height: 0,
                  );
                }
              }),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.setting);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(
            Routes.createEditTodo,
          );
        },
      ),
      body: WillPopScope(
          onWillPop: () async => false, child: _buildBodySection(context)),
    );
  }

  Widget _buildBodySection(BuildContext context) {
    final todoDB = Provider.of<TodoDB>(context, listen: false);

    return StreamBuilder(
        stream: todoDB.todosStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TodoModel> todos = snapshot.data;
            if (todos.isNotEmpty) {
              return ListView.separated(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        AppStrings.todosDismissibleMsgTxt,
                        style: TextStyle(color: Theme.of(context).canvasColor),
                      )),
                    ),
                    key: Key(todos[index].id),
                    onDismissed: (direction) {
                      todoDB.deleteTodo(todos[index]);

                      _scaffoldKey.currentState.showSnackBar(SnackBar(
                        backgroundColor: Theme.of(context).appBarTheme.color,
                        content: Text(
                          AppStrings.todosSnackBarContent + todos[index].task,
                          style:
                              TextStyle(color: Theme.of(context).canvasColor),
                        ),
                        duration: Duration(seconds: 3),
                        action: SnackBarAction(
                          label: AppStrings.todosSnackBarActionLbl,
                          textColor: Theme.of(context).canvasColor,
                          onPressed: () {
                            todoDB.setTodo(todos[index]);
                          },
                        ),
                      ));
                    },
                    child: ListTile(
                      leading: Checkbox(
                          value: todos[index].complete,
                          onChanged: (value) {
                            TodoModel todo = TodoModel(
                                id: todos[index].id,
                                task: todos[index].task,
                                extraNote: todos[index].extraNote,
                                complete: value);
                            todoDB.setTodo(todo);
                          }),
                      title: Text(todos[index].task),
                      onTap: () {
                        Navigator.of(context).pushNamed(Routes.createEditTodo,
                            arguments: todos[index]);
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 0.5);
                },
              );
            } else {
              return EmptyContentWidget();
            }
          } else if (snapshot.hasError) {
            return EmptyContentWidget(
              title: AppStrings.todosErrorTopMsgTxt,
              message: AppStrings.todosErrorBottomMsgTxt,
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
