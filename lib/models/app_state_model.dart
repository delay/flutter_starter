//Model to hold general app options
class AppStateModel {
  bool loading;
  String theme;
  String language;

  AppStateModel({this.loading, this.theme, this.language});

  factory AppStateModel.fromMap(Map data) {
    return AppStateModel(
        loading: data['loading'] ?? false,
        theme: data['theme'] ?? 'system',
        language: data['language'] ?? '');
  }

  Map<String, dynamic> toJson() =>
      {"loading": loading, "theme": theme, "language": language};
}
