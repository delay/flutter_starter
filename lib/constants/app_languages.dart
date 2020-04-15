import 'package:flutter_starter/models/models.dart';

class AppLanguages {
  //AppLanguages._();
  static final List<LanguageModel> languageOptions = [
    LanguageModel(key: "Blank", value: ""),
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
