import 'package:flutter_starter/models/models.dart';

//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing

class AppLanguages {
  AppLanguages._();

  static final List<KeyValueModel> languageOptions = [
    KeyValueModel(key: "中文", value: "zh"), //Chinese
    KeyValueModel(key: "Deutsche", value: "de"), //German
    KeyValueModel(key: "English", value: "en"), //English
    KeyValueModel(key: "Español", value: "es"), //Spanish
    KeyValueModel(key: "Français", value: "fr"), //French
    KeyValueModel(key: "हिन्दी", value: "hi"), //Hindi
    KeyValueModel(key: "日本語", value: "ja"), //Japanese
    KeyValueModel(key: "Português", value: "pt"), //Portuguese
    KeyValueModel(key: "русский", value: "ru"), //Russian
  ];
}
