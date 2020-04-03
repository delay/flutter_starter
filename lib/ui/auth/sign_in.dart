import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';

import '../../services/services.dart';
import '../../services/helpers/helpers.dart';
import '../../screens/partials/partials.dart';

class SignInScreen extends StatefulWidget {
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthService auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  //bool isLoading = false;
  bool _autoValidate = false;
  bool _loadingVisible = false;
  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryBackgroundColor,
      body: LoadingScreen(
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      UserGraphicHeader(),
                      SizedBox(height: 48.0),
                      FormInputFieldWithIcon(
                        controller: _email,
                        iconPrefix: CustomIcon.mail,
                        labelText: 'Email',
                        validator: Validator.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => null,
                        onSaved: (value) => _email.text = value,
                      ),
                      FormVerticalSpace(),
                      FormInputFieldWithIcon(
                        controller: _password,
                        iconPrefix: CustomIcon.lock,
                        labelText: 'Password',
                        validator: Validator.password,
                        obscureText: true,
                        onChanged: (value) => null,
                        onSaved: (value) => _password.text = value,
                        maxLines: 1,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: 'SIGN IN',
                          onPressed: () {
                            _emailLogin(
                                email: _email.text,
                                password: _password.text,
                                context: context);
                          }),
                      FormVerticalSpace(),
                      LabelButton(
                        labelText: 'Forgot password?',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot-password'),
                      ),
                      LabelButton(
                        labelText: 'Create an Account',
                        onPressed: () =>
                            Navigator.pushNamed(context, '/signup'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }

  Future<void> _toggleLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  void _emailLogin(
      {String email, String password, BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _toggleLoadingVisible();
        //need await so it has chance to go through error if found.
        // await StateWidget.of(context).logInUser(email, password);
        FirebaseUser user = await auth.signIn(email, password);
        if (user != null) {
          //await _toggleLoadingVisible();
          await Navigator.pushReplacementNamed(context, '/home');
        }
        //await Navigator.pushNamed(context, '/');
      } catch (e) {
        _toggleLoadingVisible();
        //print("Sign In Error: $e");
        String exception = auth.getExceptionText(e);
        Flushbar(
          title: "Sign In Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}
