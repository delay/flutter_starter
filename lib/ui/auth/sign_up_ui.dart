import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/providers/providers.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';
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
    bool _loading = false;
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.status == Status.Authenticating) {
      _loading = true;
    }
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
                        iconPrefix: CustomIcon.user,
                        labelText: 'Name',
                        validator: Validator.name,
                        onChanged: (value) => null,
                        onSaved: (value) => _name.text = value,
                      ),
                      FormVerticalSpace(),
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
                        maxLines: 1,
                        onChanged: (value) => null,
                        onSaved: (value) => _password.text = value,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: 'SIGN UP',
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              SystemChannels.textInput.invokeMethod(
                                  'TextInput.hide'); //to hide the keyboard - if any

                              UserModel userModel = await authProvider
                                  .registerWithEmailAndPassword(
                                      _email.text, _password.text);

                              if (userModel == null) {
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Sign up failed.'),
                                ));
                              }
                            }
                          }),
                      FormVerticalSpace(),
                      LabelButton(
                          labelText: 'Have an Account? Sign In.',
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(Routes.signin)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loading),
    );
  }
}
