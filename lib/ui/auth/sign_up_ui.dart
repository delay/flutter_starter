import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/helpers/helpers.dart';
import 'package:flutter_starter/services/services.dart';

class SignUpUI extends StatefulWidget {
  _SignUpUIState createState() => _SignUpUIState();
}

class _SignUpUIState extends State<SignUpUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    bool _loading = false;

    return Scaffold(
      key: _scaffoldKey,
      body: LoadingScreen(
        child: Form(
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
                      controller: _name,
                      iconPrefix: Icons.person,
                      labelText: labels.auth.nameFormField,
                      validator: Validator(labels).name,
                      onChanged: (value) => null,
                      onSaved: (value) => _name.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _email,
                      iconPrefix: Icons.email,
                      labelText: labels.auth.emailFormField,
                      validator: Validator(labels).email,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => null,
                      onSaved: (value) => _email.text = value,
                    ),
                    FormVerticalSpace(),
                    FormInputFieldWithIcon(
                      controller: _password,
                      iconPrefix: Icons.lock,
                      labelText: labels.auth.passwordFormField,
                      validator: Validator(labels).password,
                      obscureText: true,
                      maxLines: 1,
                      onChanged: (value) => null,
                      onSaved: (value) => _password.text = value,
                    ),
                    FormVerticalSpace(),
                    PrimaryButton(
                        labelText: labels.auth.signUpButton,
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            SystemChannels.textInput.invokeMethod(
                                'TextInput.hide'); //to hide the keyboard - if any
                            AuthService _auth = AuthService();
                            bool _isRegisterSucccess =
                                await _auth.registerWithEmailAndPassword(
                                    _name.text, _email.text, _password.text);

                            if (_isRegisterSucccess == false) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: Text(labels.auth.signUpError),
                              ));
                            }
                          }
                        }),
                    FormVerticalSpace(),
                    LabelButton(
                      labelText: labels.auth.signInLabelButton,
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        inAsyncCall: _loading,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
