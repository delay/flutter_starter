import 'package:flutter/material.dart';
//import 'package:flutter_starter/ui/auth/sign_in_screen.dart';
import 'package:flutter_starter/ui/setting/setting_screen.dart';
import 'package:flutter_starter/ui/splash/splash_screen.dart';
import 'package:flutter_starter/ui/todo/create_edit_todo_screen.dart';
import 'package:flutter_starter/ui/todo/todos_screen.dart';
import 'package:flutter_starter/ui/auth/auth.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String splash = '/splash';
  static const String signin = '/signin';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String setting = '/setting';
  static const String forgotPassword = '/forgot-password';
  static const String updateProfile = '/update-profile';
  static const String create_edit_todo = '/create_edit_todo';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    signin: (BuildContext context) => SignInUI(),
    signup: (BuildContext context) => SignUpUI(),
    home: (BuildContext context) => TodosScreen(),
    setting: (BuildContext context) => SettingScreen(),
    forgotPassword: (BuildContext context) => ForgotPasswordUI(),
    updateProfile: (BuildContext context) => UpdateProfileUI(),
    create_edit_todo: (BuildContext context) => CreateEditTodoScreen(),
  };
}
