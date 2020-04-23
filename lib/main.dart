import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:flutter_starter/ui/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider().setInitialLocalLanguage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    runApp(
      /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
      MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(value: Global.userRef.documentStream),
          StreamProvider<FirebaseUser>.value(value: AuthService().user),
          ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider<LanguageProvider>(
            create: (context) => LanguageProvider(),
          ),
          ChangeNotifierProvider<AuthService>(
            create: (context) => AuthService(),
          ),
        ],
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // Expose builders for 3rd party services at the root of the widget tree
  // This is useful when mocking services while testing

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (_, languageProviderRef, __) {
        return Consumer<ThemeProvider>(
          builder: (_, themeProviderRef, __) {
            //{context, data, child}
            return AuthWidgetBuilder(
              builder: (BuildContext context,
                  AsyncSnapshot<FirebaseUser> userSnapshot) {
                return MaterialApp(
                  //begin language translation stuff
                  //https://github.com/aloisdeniel/flutter_sheet_localization
                  //https://github.com/aloisdeniel/flutter_sheet_localization/tree/master/flutter_sheet_localization_generator/example
                  locale: languageProviderRef.getLocale, // <- Current locale
                  localizationsDelegates: [
                    const AppLocalizationsDelegate(), // <- Your custom delegate
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.languages.keys
                      .toList(), // <- Supported locales

                  //end language translation stuff
                  debugShowCheckedModeBanner: false,
                  //title: AppStrings.appName,
                  routes: Routes.routes,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeProviderRef.isDarkModeOn
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home: Consumer<AuthService>(
                    builder: (_, authProviderRef, __) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.active) {
                        return userSnapshot.hasData ? HomeUI() : SignInUI();
                      }

                      return Material(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key: key);
  final Widget Function(BuildContext, AsyncSnapshot<FirebaseUser>) builder;

  @override
  Widget build(BuildContext context) {
    //final authService = Provider.of<AuthService>(context, listen: false);
    return StreamBuilder<FirebaseUser>(
      stream: AuthService().user,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        final FirebaseUser user = snapshot.data;
        if (user != null) {
          /*
          * For any other Provider services that rely on user data can be
          * added to the following MultiProvider list.
          * Once a user has been detected, a re-build will be initiated.
           */
          return MultiProvider(
            providers: [
              Provider<FirebaseUser>.value(value: user),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
