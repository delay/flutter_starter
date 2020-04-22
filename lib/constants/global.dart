//import 'package:flutter/material.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';

class Global {
  //static String userPath(String uid) => 'users/$uid';
  static final UserData<UserModel> userRef =
      UserData<UserModel>(collection: 'users');
  static final Map models = {
    UserModel: (data) => UserModel.fromMap(data),
  };
}
