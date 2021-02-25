import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_starter/ui/auth/auth.dart';
import 'package:get/get.dart';
import 'package:flutter_starter/ui/components/segmented_selector.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/controllers/controllers.dart';
import 'package:flutter_starter/ui/components/components.dart';
import 'package:flutter_starter/models/models.dart';
import 'package:flutter_starter/constants/constants.dart';
import 'components/deliveries_data.dart';

class DeliveriesUI extends StatelessWidget {
  //final LanguageController languageController = LanguageController.to;
  //final ThemeController themeController = ThemeController.to;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        //title: Text(labels.settings.title),
        title: Text("Choose Delivery"),
      ),
      body: _buildLayoutSection(context),
    );
  }

  Widget _buildLayoutSection(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return ListView(
      children: <Widget>[
        statsCompletedTitle(context),
        statsMissedTitle(context),
        Divider(
          color: Colors.black38,
          height: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),
        MyStatefulWidget()
        // languageListTile(context),
        // themeListTile(context),
        // ListTile(
        //     title: Text(labels.settings.updateProfile),
        //     trailing: RaisedButton(
        //       onPressed: () async {
        //         Get.to(UpdateProfileUI());
        //       },
        //       child: Text(
        //         labels.settings.updateProfile,
        //       ),
        //     )),
        // ListTile(
        //     title: Text(labels.settings.updateProfile),
        //     trailing: RaisedButton(
        //       onPressed: () async {
        //         Get.to(UpdateProfileUI());
        //       },
        //       child: Text(
        //         labels.settings.updateProfile,
        //       ),
        //     )),
        // ListTile(
        //   title: Text(labels.settings.signOut),
        //   trailing: RaisedButton(
        //     onPressed: () {
        //       AuthController.to.signOut();
        //     },
        //     child: Text(
        //       labels.settings.signOut,
        //     ),
        //   ),
        // )
      ],
    );
  }

  statsCompletedTitle(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        leading: Text("9 Trips Completed"),
        trailing: Text("\$23 Earned Today"),

        // DropdownPicker(
        //   menuOptions: Globals.languageOptions,
        //   selectedOption: controller.currentLanguage,
        //   onChanged: (value) async {
        //     await controller.updateLanguage(value);
        //     Get.forceAppUpdate();
        //   },
        // ),
      ),
    );
  }

  statsMissedTitle(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        leading: Text("9 Trips Missed"),
        trailing: Text("\$12 Lost Today"),

        // DropdownPicker(
        //   menuOptions: Globals.languageOptions,
        //   selectedOption: controller.currentLanguage,
        //   onChanged: (value) async {
        //     await controller.updateLanguage(value);
        //     Get.forceAppUpdate();
        //   },
        // ),
      ),
    );
  }

  languageListTile(BuildContext context) {
    final labels = AppLocalizations.of(context);
    return GetBuilder<LanguageController>(
      builder: (controller) => ListTile(
        title: Text(labels.settings.language),
        trailing: DropdownPicker(
          menuOptions: Globals.languageOptions,
          selectedOption: controller.currentLanguage,
          onChanged: (value) async {
            await controller.updateLanguage(value);
            Get.forceAppUpdate();
          },
        ),
      ),
    );
  }

  themeListTile(BuildContext context) {
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
    return GetBuilder<ThemeController>(
      builder: (controller) => ListTile(
        title: Text(labels.settings.theme),
        trailing: SegmentedSelector(
          selectedOption: controller.currentTheme,
          menuOptions: themeOptions,
          onValueChanged: (value) {
            controller.setThemeMode(value);
          },
        ),
      ),
    );
  }
}
