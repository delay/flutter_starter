import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:flutter_starter/ui/ui.dart';
//import 'dart:js' as js;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LanguageProvider().setInitialLocalLanguage();
  //found bug https://github.com/flutter/flutter/issues/55892
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {
  runApp(
    MultiProvider(
      providers: [
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
  /* });*/
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final labels = AppLocalizations.of(context);
    // js.context.callMethod("alert", <String>["Your debug message"]);
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
                  navigatorObservers: [
                    FirebaseAnalyticsObserver(analytics: FirebaseAnalytics()),
                  ],
                  debugShowCheckedModeBanner: false,
                  //title: labels.app.title,
                  routes: Routes.routes,
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: themeProviderRef.isDarkModeOn
                      ? ThemeMode.dark
                      : ThemeMode.light,
                  home:
                      (userSnapshot?.data?.uid != null) ? HomeUI() : SignInUI(),
                );
              },
            );
          },
        );
      },
    );
  }
}
