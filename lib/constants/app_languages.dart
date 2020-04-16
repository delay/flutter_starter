import 'package:flutter_starter/models/models.dart';

//List of languages that are supported.  Used in selector.
//Follow this plugin for translating a google sheet to languages
//https://github.com/aloisdeniel/flutter_sheet_localization
//Flutter App translations google sheet
//https://docs.google.com/spreadsheets/d/1oS7iJ6ocrZBA53SxRfKF0CG9HAaXeKtzvsTBhgG4Zzk/edit?usp=sharing

class AppLanguages {
  AppLanguages._();

  static final List<LanguageModel> languageOptions = [
    LanguageModel(key: "中文", value: "zh"), //Chinese
    LanguageModel(key: "Deutsche", value: "de"), //German
    LanguageModel(key: "English", value: "en"), //English
    LanguageModel(key: "Español", value: "es"), //Spanish
    LanguageModel(key: "Français", value: "fr"), //French
    LanguageModel(key: "हिन्दी", value: "hi"), //Hindi
    LanguageModel(key: "日本語", value: "ja"), //Japanese
    LanguageModel(key: "Português", value: "pt"), //Portuguese
    LanguageModel(key: "русский", value: "ru"), //Russian
  ];
}
