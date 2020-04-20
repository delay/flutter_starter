import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/services/helpers/helpers.dart';
import 'package:flutter_starter/services/services.dart';

class UpdateProfileUI extends StatefulWidget {
  _UpdateProfileUIState createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = new TextEditingController();
  final TextEditingController _email = new TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSuccess = false;
  bool _loading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //  final AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Update Profile')),
        body: LoadingScreen(
            child: updateProfileForm(context), inAsyncCall: _loading));
  }
  //_loading = true;
  /* return Scaffold(
        key: _scaffoldKey,
        body: LoadingScreen(
            child: StreamBuilder(
                stream: authProvider.user,
                builder: (context, snapshot) {
                  if ((snapshot.data != null)) {}
                  FirebaseUserAuthModel user = snapshot.data;
                  _name.text = user.displayName;
                  _email.text = user.email;
                  return updateProfileForm(context, user.email);
                }),
            inAsyncCall: _loading));
  }*/

  updateProfileForm(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    _name.text = user.name;
    _email.text = user.email;
    final labels = AppLocalizations.of(context);
    return Form(
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
                  labelText: labels.auth.nameFormField,
                  validator: Validator.name,
                  onChanged: (value) => null,
                  onSaved: (value) => _name.text = value,
                ),
                FormVerticalSpace(),
                FormInputFieldWithIcon(
                  controller: _email,
                  iconPrefix: CustomIcon.mail,
                  labelText: labels.auth.emailFormField,
                  validator: Validator.email,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => null,
                  onSaved: (value) => _email.text = value,
                ),
                FormVerticalSpace(),
                PrimaryButton(
                    labelText: labels.auth.updateUser,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        try {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          // dawait _toggleLoadingVisible();
                          setState(() {
                            _loading = true;
                          });
                          _updateUserConfirm(context, _name.text, _email.text)
                              .then((value) {
                            if (isSuccess) {
                              //  Navigator.pushNamed(context, Routes.setting);
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content:
                                      Text(labels.auth.updateUserSuccessNotice),
                                ),
                              );
                              setState(() {
                                _loading = false;
                              });
                            } else {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content:
                                      Text(labels.auth.updateUserFailNotice),
                                ),
                              );
                              setState(() {
                                _loading = false;
                              });
                            }
                          });
                        } catch (e) {
                          _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content: Text(labels.auth.updateUserFailNotice),
                          ));
                          setState(() {
                            _loading = false;
                          });
                        }
                      }
                    }),
                FormVerticalSpace(),
                LabelButton(
                    labelText: labels.auth.changePasswordLabelButton,
                    onPressed: () => Navigator.pushNamed(
                        context, Routes.forgotPassword,
                        arguments: user.email)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _updateUserConfirm(
      BuildContext context, String displayName, String email) async {
    final labels = AppLocalizations.of(context);
    final AuthProvider _auth =
        Provider.of<AuthProvider>(context, listen: false);
    final FirebaseUser _user = await _auth.getUser;

    final TextEditingController _password = new TextEditingController();
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
              controller: _password,
              iconPrefix: CustomIcon.lock,
              labelText: labels.auth.passwordFormField,
              validator: Validator.password,
              obscureText: true,
              onChanged: (value) => null,
              onSaved: (value) => _password.text = value,
              maxLines: 1,
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(labels.auth.cancel.toUpperCase()),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    isSuccess = false;
                  });
                },
              ),
              new FlatButton(
                child: new Text(labels.auth.submit.toUpperCase()),
                onPressed: () async {
                  await _auth
                      .updateUser(
                          displayName, _user.email, email, _password.text)
                      .then((value) {
                    Navigator.of(context).pop();
                    setState(() {
                      isSuccess = value;
                    });
                    //return isSuccess;
                  });
                },
              )
            ],
          );
        });
  }
}
