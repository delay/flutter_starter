import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/providers/providers.dart';
import 'package:flutter_starter/services/services.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/constants/constants.dart';

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
    final labels = AppLocalizations.of(context);
    final List<MenuOptionsModel> themeOptions = [
      MenuOptionsModel(
          key: labels.settings.system,
          value: "system",
          icon: Icons.blur_linear),
      MenuOptionsModel(
          key: labels.settings.light, value: "light", icon: Icons.colorize),
      MenuOptionsModel(
          key: labels.settings.dark, value: "dark", icon: Icons.book)
    ];
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(labels.settings.theme),
          trailing: DropdownPickerWithIcon(
            menuOptions: themeOptions,
            selectedOption: Provider.of<ThemeProvider>(context).getTheme,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),
        /*trailing: Switch.adaptive(
            activeColor: Theme.of(context).appBarTheme.color,
            activeTrackColor: Theme.of(context).textTheme.headline1.color,
            value: Provider.of<ThemeProvider>(context).isDarkModeOn,
            onChanged: (booleanValue) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(booleanValue);
            },
          ),*/

        ListTile(
            title: Text(labels.settings.language),
            //trailing: _languageDropdown(context),
            trailing: DropdownPicker(
              menuOptions: AppLanguages.languageOptions,
              selectedOption:
                  Provider.of<LanguageProvider>(context).currentLanguage,
              onChanged: (value) {
                Provider.of<LanguageProvider>(context, listen: false)
                    .updateLanguage(value);
              },
            )),
        ListTile(
            title: Text(labels.settings.signOut),
            trailing: RaisedButton(
              onPressed: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Routes.signin, ModalRoute.withName(Routes.signin));
              },
              child: Text(
                labels.settings.signOut,
              ),
            ))
      ],
    );
  }
}
