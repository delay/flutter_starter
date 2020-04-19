import 'package:flutter/material.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';

class Global {
  static final Map models = {
    UserModel: (data) => UserModel.fromMap(data),
  };
  static final UserData<UserModel> userDB =
      UserData<UserModel>(collection: 'users');
}
