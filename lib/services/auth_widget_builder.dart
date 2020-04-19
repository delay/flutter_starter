import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';

/*
* This class is mainly to help with creating user dependent object that
* need to be available to all downstream widgets.
* Thus, this widget builder is a must to live above [MaterialApp].
* As we rely on uid to decide which main screen to display (eg: Home or Sign In),
* this class will helps to create all providers needed that depends on
* the user logged data uid.
 */
class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder(
      {Key key, @required this.builder, @required this.databaseBuilder})
      : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<FirebaseUserAuthModel>)
      builder;
  final FirestoreDatabase Function(BuildContext context, String uid)
      databaseBuilder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthProvider>(context, listen: false);
    return StreamBuilder<FirebaseUserAuthModel>(
      stream: authService.user,
      builder: (BuildContext context,
          AsyncSnapshot<FirebaseUserAuthModel> snapshot) {
        final FirebaseUserAuthModel user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
           */
          return MultiProvider(
            providers: [
              Provider<FirebaseUserAuthModel>.value(value: user),
              Provider<FirestoreDatabase>(
                create: (context) => databaseBuilder(context, user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
