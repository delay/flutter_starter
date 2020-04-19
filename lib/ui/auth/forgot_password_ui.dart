import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';
import 'package:flutter_starter/services/services.dart';

class ForgotPasswordUI extends StatefulWidget {
  _ForgotPasswordUIState createState() => _ForgotPasswordUIState();
}

class _ForgotPasswordUIState extends State<ForgotPasswordUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isButtonDisabled = false;
  String email = '';
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
    final labels = AppLocalizations.of(context);
    bool _loading = false;
    email = ModalRoute.of(context).settings.arguments;
    _email.text = email;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
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
                        controller: _email,
                        iconPrefix: CustomIcon.mail,
                        labelText: labels.auth.emailFormField,
                        validator: Validator.email,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) =>
                            setState(() => _isButtonDisabled = false),
                        onSaved: (value) => _email.text = value,
                      ),
                      FormVerticalSpace(),
                      PrimaryButton(
                          labelText: labels.auth.forgotPasswordButton,
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
                                          labels.auth.forgotPasswordNotice),
                                    ));
                                  }
                                }),
                      FormVerticalSpace(),
                      signInLink()
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loading),
    );
  }

  signInLink() {
    final labels = AppLocalizations.of(context);
    if (email == '') {
      return LabelButton(
          labelText: labels.auth.signInonForgotPasswordLabelButton,
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.signin));
    } else {
      return Container(width: 0, height: 0);
    }
  }
}
