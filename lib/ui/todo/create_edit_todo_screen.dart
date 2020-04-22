import 'package:flutter/material.dart';
import 'package:flutter_starter/constants/app_strings.dart';
import 'package:flutter_starter/models/todo_model.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:provider/provider.dart';

class CreateEditTodoScreen extends StatefulWidget {
  @override
  _CreateEditTodoScreenState createState() => _CreateEditTodoScreenState();
}

class _CreateEditTodoScreenState extends State<CreateEditTodoScreen> {
  TextEditingController _taskController;
  TextEditingController _extraNoteController;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TodoModel _todo;
  bool _checkboxCompleted;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final TodoModel _todoModel = ModalRoute.of(context).settings.arguments;
    if (_todoModel != null) {
      _todo = _todoModel;
    }

    _taskController =
        TextEditingController(text: _todo != null ? _todo.task : "");
    _extraNoteController =
        TextEditingController(text: _todo != null ? _todo.extraNote : "");

    _checkboxCompleted = _todo != null ? _todo.complete : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(_todo != null
            ? AppStrings.todosCreateEditAppBarTitleEditTxt
            : AppStrings.todosCreateEditAppBarTitleNewTxt),
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  FocusScope.of(context).unfocus();

                  final todoDB = Provider.of<TodoDB>(context, listen: false);

                  todoDB.setTodo(TodoModel(
                      id: _todo != null
                          ? _todo.id
                          : documentIdFromCurrentDate(),
                      task: _taskController.text,
                      extraNote: _extraNoteController.text.length > 0
                          ? _extraNoteController.text
                          : "",
                      complete: _checkboxCompleted));

                  Navigator.of(context).pop();
                }
              },
              child: Text("Save"))
        ],
      ),
      body: Center(
        child: _buildForm(context),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    _extraNoteController.dispose();
    super.dispose();
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _taskController,
                style: Theme.of(context).textTheme.bodyText1,
                validator: (value) => value.isEmpty
                    ? AppStrings.todosCreateEditTaskNameValidatorMsg
                    : null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).iconTheme.color, width: 2)),
                  labelText: AppStrings.todosCreateEditTaskNameTxt,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: TextFormField(
                  controller: _extraNoteController,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 15,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).iconTheme.color,
                            width: 2)),
                    labelText: AppStrings.todosCreateEditNotesTxt,
                    alignLabelWithHint: true,
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(AppStrings.todosCreateEditCompletedTxt),
                    Checkbox(
                        value: _checkboxCompleted,
                        onChanged: (value) {
                          setState(() {
                            _checkboxCompleted = value;
                          });
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
