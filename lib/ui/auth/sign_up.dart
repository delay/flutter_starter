import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/providers/providers.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';

class SignUpScreen extends StatefulWidget {
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
      backgroundColor: Theme.of(context).backgroundColor,
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
                        onPressed: () => Navigator.pushNamed(context, '/'),
                      ),
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
/*void _emailSignUp(
      {String name,
      String email,
      String password,
      BuildContext context}) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _toggleLoadingVisible();
        //need await so it has chance to go through error if found.
        await auth.signUp(email, password).then((uID) {
          print('uID: ' + uID);
          print('email: ' + email);
          auth.updateUserDB(new User(
              id: uID,
              email: email,
              name: name,
              //role: 'user',
              workouts: [],
              workoutExercisesOrder: [],
              showArchive: false,
              useTimers: true,
              useVoiceCount: true,
              voiceCountDuration: 10));
        });
        //now automatically login user too
        //await StateWidget.of(context).logInUser(email, password);
        await auth.signIn(email, password);
        await Navigator.pushReplacementNamed(context, '/home');
        /*Route route =
            MaterialPageRoute(builder: (context) => AuthCheckScreen());
        Navigator.push(context, route);*/
        //await Navigator.pushNamed(context, '/signin');
      } catch (e) {
        _toggleLoadingVisible();
        //print("Sign Up Error: $e");
        String exception = auth.getExceptionText(e);
        Flushbar(
          title: "Sign Up Error",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true);
    }
  }
}*/
