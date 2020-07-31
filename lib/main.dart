import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<AuthController>(AuthController());
  Get.put<ThemeController>(ThemeController());
  Get.put<LanguageController>(LanguageController());
  await GetStorage.init();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeController.to.getThemeModeFromStore();
    return GetBuilder<LanguageController>(
        builder: (languageController) => Loading(
              child: GetMaterialApp(
                //begin language translation stuff //https://github.com/aloisdeniel/flutter_sheet_localization
                locale: languageController.getLocale, // <- Current locale
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
                //defaultTransition: Transition.fade,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: ThemeMode.system,
                initialRoute: "/",
                getPages: AppRoutes.routes,
              ),
            ));
  }
}

/*class App extends StatelessWidget {
  //final _auth = AuthService.to;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: GetBuilder<LandingController>(
        init: LandingController(),
        builder: (_) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
*/

/*class LandingController extends GetxController {
  static LandingController get to => Get.find();

  final _auth = AuthController.to;

  final user = UserModel().obs;

  @override
  void onInit() async {
    final _firebaseUser = await _auth.getUser;
   // user.bindStream(_auth.streamFirestoreUser(_firebaseUser));

    ever(user, checkUser);

    super.onInit();
  }*/

/*void checkUser(user) {
    if (user?.uid == null) {
      Get.off(SignInUI());
    } else {
      Get.off(HomeUI());
    }
  }
}*/

/*
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut<ThemeController>(() => ThemeController());
  await GetStorage.init();
  //LanguageProvider().setInitialLocalLanguage();
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
    ThemeController.to.getThemeModeFromStore();
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
                return GetMaterialApp(
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
                  //routes: Routes.routes,
                  initialRoute: '/',

                  getPages: [
                    GetPage(name: '/signin', page: () => SignInUI()),
                    GetPage(name: '/signup', page: () => SignUpUI()),
                    GetPage(name: '/home', page: () => HomeUI()),
                    GetPage(name: '/settings', page: () => SettingsUI()),
                    GetPage(
                        name: '/reset-password', page: () => ResetPasswordUI()),
                    GetPage(
                        name: '/update-profile', page: () => UpdateProfileUI()),
                  ],
                  theme: AppThemes.lightTheme,
                  darkTheme: AppThemes.darkTheme,
                  themeMode: ThemeMode.system,
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
*/
