/* Not currently used alternative signin options, google, apple, anonymous, etc*/
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/services.dart';
//import 'package:apple_sign_in/apple_sign_in.dart';

class SignInOptionsUI extends StatefulWidget {
  createState() => SignInOptionsUIState();
}

class SignInOptionsUIState extends State<SignInOptionsUI> {
  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
    auth.getUser.then(
      (user) {
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/topics');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoGraphicHeader(),
              SizedBox(height: 48.0),
              FormVerticalSpace(),
              /*     GoogleSignInButton(
                darkMode: true,
                onPressed: () async {
                  auth.googleSignIn();
                },
              ),
              FormVerticalSpace(),
              FutureBuilder<Object>(
                future: auth.appleSignInAvailable,
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return AppleSignInButton(
                      style: AppleButtonStyle.black,
                      onPressed: () async {
                        FirebaseUser user = await auth.appleSignIn();
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              FormVerticalSpace(),*/
              PrimaryButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, '/signin');
                  },
                  labelText: 'Sign In with Email & Password'),
              FormVerticalSpace(),
              /*  PrimaryButton(
                  onPressed: () async {
                    auth.googleSignIn();
                  },
                  labelText: 'Sign In Anonymously'),*/
            ],
          ),
        ),
      ),
    );
  }
}
