import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_starter/ui/components/segmented_selector.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/localizations.dart';
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
          key: "system",
          value: labels.settings.system,
          icon: Icons.brightness_4),
      MenuOptionsModel(
          key: "light",
          value: labels.settings.light,
          icon: Icons.brightness_low),
      MenuOptionsModel(
          key: "dark", value: labels.settings.dark, icon: Icons.brightness_3)
    ];
    return ListView(
      children: <Widget>[
        /*  ListTile(
          title: Text(labels.settings.theme),
          trailing: DropdownPickerWithIcon(
            menuOptions: themeOptions,
            selectedOption: Provider.of<ThemeProvider>(context).getTheme,
            onChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
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
          title: Text(labels.settings.theme),
          trailing: SegmentedSelector(
            selectedOption: Provider.of<ThemeProvider>(context).getTheme,
            menuOptions: themeOptions,
            onValueChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),
        /*    
        ListTile(
          title: Text(labels.settings.theme),
          trailing: CupertinoSlidingSegmentedControl(
            groupValue: Provider.of<ThemeProvider>(context).getTheme,
            children: myTabs,
            onValueChanged: (value) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .updateTheme(value);
            },
          ),
        ),*/
        ListTile(
            title: Text('Update Profile'),
            trailing: RaisedButton(
              onPressed: () async {
                Navigator.of(context).pushNamed(Routes.updateProfile);
              },
              child: Text(
                'Update Profile',
              ),
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
