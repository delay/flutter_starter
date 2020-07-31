import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/helpers/helpers.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/auth/auth.dart';

class SignUpUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

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
                    labelText: labels?.auth?.nameFormField,
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
                  FormInputFieldWithIcon(
                    controller: authController.passwordController,
                    iconPrefix: Icons.lock,
                    labelText: labels?.auth?.passwordFormField,
                    validator: Validator(labels).password,
                    obscureText: true,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.passwordController.text = value,
                    maxLines: 1,
                  ),
                  FormVerticalSpace(),
                  PrimaryButton(
                      labelText: labels?.auth?.signUpButton,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          authController.registerWithEmailAndPassword();
                        }
                      }),
                  FormVerticalSpace(),
                  LabelButton(
                    labelText: labels?.auth?.signInLabelButton,
                    onPressed: () => Get.to(SignInUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
