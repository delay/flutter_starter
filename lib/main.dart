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
import 'package:flutter_starter/ui/setting/setting_screen.dart';
import 'package:flutter_starter/ui/home/home.dart';

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
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => LanguageProvider(),
        ),
      ],
      child: MaterialApp(
        //begin language translation stuff
        //https://github.com/aloisdeniel/flutter_sheet_localization
        //https://github.com/aloisdeniel/flutter_sheet_localization/tree/master/flutter_sheet_localization_generator/example
        locale: LanguageProvider().getLocale, // <- Current locale
        localizationsDelegates: [
          const AppLocalizationsDelegate(), // <- Your custom delegate
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales:
            AppLocalizations.languages.keys.toList(), // <- Supported locales
        //end language translation stuff

        debugShowCheckedModeBanner: false,
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode:
            ThemeProvider().isDarkModeOn ? ThemeMode.dark : ThemeMode.light,

        // Firebase Analytics
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
        ],

        // Routes
        routes: {
          '/': (context) => SignInUI(),
          '/signup': (context) => SignUpUI(),
          '/reset-password': (context) => ResetPasswordUI(),
          '/update-profile': (context) => UpdateProfileUI(),
          '/settings': (context) => SettingScreen(),
        },
      ),
    );
  }
}
