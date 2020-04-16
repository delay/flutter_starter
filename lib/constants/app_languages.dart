import 'package:flutter_starter/models/models.dart';

//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing

class AppLanguages {
  AppLanguages._();

  static final List<MenuOptionsModel> languageOptions = [
    MenuOptionsModel(key: "中文", value: "zh"), //Chinese
    MenuOptionsModel(key: "Deutsche", value: "de"), //German
    MenuOptionsModel(key: "English", value: "en"), //English
    MenuOptionsModel(key: "Español", value: "es"), //Spanish
    MenuOptionsModel(key: "Français", value: "fr"), //French
    MenuOptionsModel(key: "हिन्दी", value: "hi"), //Hindi
    MenuOptionsModel(key: "日本語", value: "ja"), //Japanese
    MenuOptionsModel(key: "Português", value: "pt"), //Portuguese
    MenuOptionsModel(key: "русский", value: "ru"), //Russian
  ];
}
