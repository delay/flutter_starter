import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:flutter_starter/ui/ui.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider().setInitialLocalLanguage();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
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
        child: Consumer<LanguageProvider>(
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
                      locale: LanguageProvider().getLocale, // <- Current locale
                      localizationsDelegates: [
                        const AppLocalizationsDelegate(), // <- Your custom delegate
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      supportedLocales: AppLocalizations.languages.keys
                          .toList(), // <- Supported locales
                      //end language translation stuff

                      debugShowCheckedModeBanner: false,
                      theme: AppThemes.lightTheme,
                      darkTheme: AppThemes.darkTheme,
                      themeMode: ThemeProvider().isDarkModeOn
                          ? ThemeMode.dark
                          : ThemeMode.light,

                      // Firebase Analytics
                      navigatorObservers: [
                        FirebaseAnalyticsObserver(
                            analytics: FirebaseAnalytics()),
                      ],

                      // Routes
                      routes: {
                        '/home': (context) => HomeUI(),
                        '/signin': (context) => SignInUI(),
                        '/signup': (context) => SignUpUI(),
                        '/reset-password': (context) => ResetPasswordUI(),
                        '/update-profile': (context) => UpdateProfileUI(),
                        '/settings': (context) => SettingsUI(),
                      },

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
        ));
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
