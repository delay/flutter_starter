import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/providers/providers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';

class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
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
                        controller: _email,
                        iconPrefix: CustomIcon.mail,
                        labelText: 'Email',
                        validator: Validator.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) =>
                            setState(() => _isButtonDisabled = false),
                        onSaved: (value) => _email.text = value,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: 'FORGOT PASSWORD',
                          onPressed: _isButtonDisabled
                              ? null
                              : () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() =>
                                        _isButtonDisabled = !_isButtonDisabled);

                                    await authProvider
                                        .sendPasswordResetEmail(_email.text);

                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'Check your email and follow the instructions to reset your password.'),
                                    ));
                                  }
                                }),
                      FormVerticalSpace(),
                      LabelButton(
                        labelText: 'Sign In',
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
