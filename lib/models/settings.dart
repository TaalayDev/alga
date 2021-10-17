class AppSettings {
  final String appName;
  final String appShortDescription;

  AppSettings({
    required this.appName,
    required this.appShortDescription,
  });

  factory AppSettings.frommap(map) => AppSettings(
        appName: map['app_name'] ?? '',
        appShortDescription: map['app_short_description'],
      );
}
