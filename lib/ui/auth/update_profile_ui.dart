import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/helpers/helpers.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/auth/auth.dart';

class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Rx<UserModel> user = UserModel().obs;

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    //print('user.name: ' + user?.value?.name);
    authController.nameController.text =
        authController?.fireStoreUser?.value?.name;
    authController.emailController.text =
        authController?.fireStoreUser?.value?.email;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: labels.auth.nameFormField,
                    validator: Validator(labels).name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.nameController.text = value,
                  ),
                  FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: labels?.auth?.emailFormField,
                    validator: Validator(labels).email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: labels?.auth?.updateUser,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          authController.signInWithEmailAndPassword(context);
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: user?.value?.uid,
                              name: authController.nameController.text,
                              email: authController.emailController.text,
                              photoUrl: user?.value?.photoUrl);
                          _updateUserConfirm(
                              context, _updatedUser, user?.value?.email);
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: labels?.auth?.resetPasswordLabelButton,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final labels = AppLocalizations.of(context);
    final AuthController authController = AuthController.to;
    //AuthService _auth = AuthService();
    //final TextEditingController _password = new TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            title: Text(
              labels.auth.enterPassword,
            ),
            content: FormInputFieldWithIcon(
              controller: authController.passwordController,
              iconPrefix: Icons.lock,
              labelText: labels.auth.passwordFormField,
              validator: Validator(labels).password,
              obscureText: true,
              onChanged: (value) => null,
              onSaved: (value) =>
                  authController.passwordController.text = value,
              maxLines: 1,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(labels.auth.cancel.toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                  /*setState(() {
                    _loading = false;
                  });*/
                },
              ),
              new FlatButton(
                child: new Text(labels.auth.submit.toUpperCase()),
                onPressed: () async {
                  /* setState(() {
                    _loading = true;
                  });*/
                  Navigator.of(context).pop();
                  try {
                    await authController
                        .updateUser(updatedUser, oldEmail,
                            authController.passwordController.text)
                        .then((result) {
                      /* setState(() {
                        _loading = false;
                      });*/

                      /*if (result == true) {
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(labels.auth.updateUserSuccessNotice),
                          ),
                        );
                      }*/
                    });
                  } on PlatformException catch (error) {
                    //List<String> errors = error.toString().split(',');
                    // print("Error: " + errors[1]);
                    print(error.code);
                    String authError;
                    switch (error.code) {
                      case 'ERROR_WRONG_PASSWORD':
                        authError = labels.auth.wrongPasswordNotice;
                        break;
                      default:
                        authError = labels.auth.unknownError;
                        break;
                    }
                    /*_scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(authError),
                    ));
                    setState(() {
                      _loading = false;
                    });*/
                  }
                },
              )
            ],
          );
        });
  }
}
