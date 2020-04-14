import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/constants/app_strings.dart';
import 'package:flutter_starter/providers/providers.dart';
import 'package:flutter_starter/services/services.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(labels.settings.title),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(AppStrings.settingThemeListTitle),
          subtitle: Text(AppStrings.settingThemeListSubTitle),
          trailing: Switch.adaptive(
            activeColor: Theme.of(context).appBarTheme.color,
            activeTrackColor: Theme.of(context).textTheme.headline1.color,
            value: Provider.of<ThemeProvider>(context).isDarkModeOn,
            onChanged: (booleanValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(booleanValue);
            },
          ),
        ),
        ListTile(
          title: Text('Language'),
          subtitle: Text('Select your language'),
          trailing: _languageDropdown(context),
        ),
        ListTile(
          title: Text(AppStrings.settingLogoutListTitle),
          subtitle: Text(AppStrings.settingLogoutListSubTitle),
          trailing: RaisedButton(
              onPressed: () {
                _confirmSignOut(context);
              },
              child: Text(AppStrings.settingLogoutButton)),
        )
      ],
    );
  }

  _languageDrop(BuildContext context) {
    ValueChanged<Locale> onLocaleChanged;
    return DropdownButton<Locale>(
      key: Key("Picker"),
      value: AppLocalizations.languages.keys.first,
      items: AppLocalizations.languages.keys.map((locale) {
        return DropdownMenuItem<Locale>(
          value: locale,
          child: Text(
            locale.toString(),
          ),
        );
      }).toList(),
      onChanged: onLocaleChanged,
    );
  }

  _languageDropdown(BuildContext context) {
    return DropdownButton<String>(
        items: [
          DropdownMenuItem(
            value: "en",
            child: Text(
              "English",
            ),
          ),
          DropdownMenuItem(
            value: "es",
            child: Text(
              "Spanish",
            ),
          ),
          DropdownMenuItem(
            value: "fr",
            child: Text(
              "French",
            ),
          ),
        ],
        value: Provider.of<LanguageProvider>(context).currentLanguage,
        onChanged: (value) {
          Provider.of<LanguageProvider>(context, listen: false)
              .updateLanguage(value);
        });
  }

  _confirmSignOut(BuildContext context) {
    showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              android: (_) => MaterialAlertDialogData(
                  backgroundColor: Theme.of(context).appBarTheme.color),
              title: Text(AppStrings.alertDialogTitle),
              content: Text(AppStrings.alertDialogMessage),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText(AppStrings.alertDialogCancelBtn),
                  onPressed: () => Navigator.pop(context),
                ),
                PlatformDialogAction(
                  child: PlatformText(AppStrings.alertDialogYesBtn),
                  onPressed: () {
                    final authProvider =
                        Provider.of<AuthProvider>(context, listen: false);

                    authProvider.signOut();

                    Navigator.pop(context);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.signin, ModalRoute.withName(Routes.signin));
                  },
                )
              ],
            ));
  }
}
