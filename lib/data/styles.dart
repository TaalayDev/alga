import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class AppThemeData {
  // Colors
  static Color get background => AppTheme.theme.bgColor;
  static Color get background1 => AppTheme.theme.bgColor1;
  static Color get background2 => AppTheme.theme.bgColor2;
  static Color get primary => AppTheme.theme.primaryColor;
  static Color get onPrimary => AppTheme.theme.onPrimaryColor;
  static Color get primaryTint => AppTheme.theme.primaryTintColor;
  static Color get secondary => AppTheme.theme.secondaryColor;
  static Color get accent => AppTheme.theme.accentColor;
  static Color get onAccent => AppTheme.theme.onAccentColor;
  static Color get focus => AppTheme.theme.focusColor;
  static Color get onFocus => AppTheme.theme.onFocusColor;
  static Color get surface => AppTheme.theme.surface;
  static Color get greyWeak => AppTheme.theme.greyWeakColor;
  static Color get grey => AppTheme.theme.greyColor;
  static Color get greyMedium => AppTheme.theme.greyMediumColor;
  static Color get greyStrong => AppTheme.theme.greyStrongColor;
  static Color get mainTextColor => AppTheme.theme.mainTextColor;
  static Color get secondTextColor => AppTheme.theme.secondTextColor;
  static Color get inverseTextColor => AppTheme.theme.inverseTextColor;
}

// Themes
enum ThemeType {
  LIGHT_BLUE,
  DARK_BLUE,
}

class AppTheme {
  static const ThemeType defaultTheme = ThemeType.LIGHT_BLUE;

  late ThemeType type;
  bool isDark;

  late Color primaryColor;
  late Color onPrimaryColor;
  late Color primaryTintColor;
  late Color secondaryColor;
  late Color accentColor;
  late Color onAccentColor;
  late Color bgColor;
  late Color bgColor1;
  late Color bgColor2;
  late Color focusColor;
  late Color onFocusColor;
  late Color greyWeakColor;
  late Color greyColor;
  late Color greyMediumColor;
  late Color greyStrongColor;
  late Color surface;

  late Color mainTextColor;
  late Color secondTextColor;
  late Color inverseTextColor;

  AppTheme({this.isDark = false}) {
    mainTextColor = isDark ? Colors.white : Color(0xFF425466);
    secondTextColor = Color(0xFF425466);
    inverseTextColor = isDark ? Color(0xFF425466) : Colors.white;
  }

  factory AppTheme.fromType(ThemeType t) {
    switch (t) {
      case ThemeType.LIGHT_BLUE:
        return AppTheme(isDark: false)
          ..type = t
          ..primaryColor = Colors.blue
          ..onPrimaryColor = Color(0xFFFFFFFF)
          ..primaryTintColor = Colors.blue.withOpacity(0.3)
          ..accentColor = Color(0xFFD0103F)
          ..onAccentColor = Color(0xFFFFFFFF)
          ..focusColor = Colors.blue.withOpacity(0.3)
          ..onFocusColor = Color(0xFFFFFFFF)
          ..secondaryColor = Color(0xFF000000)
          ..bgColor = Color(0xFFFFFFFF)
          ..bgColor1 = Color(0xFFdbe5f1)
          ..bgColor2 = Color(0xFFf0f3f8)
          ..surface = Color(0xFFFFFFFF)
          ..greyWeakColor = const Color(0xffeeeeee)
          ..greyColor = const Color(0xff8a8a8a)
          ..greyMediumColor = const Color(0xff747474)
          ..greyStrongColor = const Color(0xff333333);
      case ThemeType.DARK_BLUE:
        return AppTheme(isDark: true)
          ..type = t
          ..primaryColor = Colors.blue
          ..onPrimaryColor = Color(0xFFFFFFFF)
          ..primaryTintColor = Colors.blue.withOpacity(0.3)
          ..accentColor = Color(0xFFD0103F)
          ..onAccentColor = Color(0xFFFFFFFF)
          ..focusColor = Colors.blue.withOpacity(0.3)
          ..onFocusColor = Color(0xFFFFFFFF)
          ..secondaryColor = Color(0xFFFFFFFF)
          ..bgColor = Color(0xFF263236)
          ..bgColor1 = Color(0xFFdbe5f1)
          ..bgColor2 = Color(0xFFf0f3f8)
          ..surface = Color(0xFFFFFFFF)
          ..greyWeakColor = const Color(0xffeeeeee)
          ..greyColor = const Color(0xff8a8a8a)
          ..greyMediumColor = const Color(0xff747474)
          ..greyStrongColor = const Color(0xff333333);
    }

    // return AppTheme.fromType(defaultTheme);
  }

  ThemeData get themeData {
    final textThemeData =
        (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
    var t = ThemeData.from(
      // Use the .dark() and .light() constructors to handle the text themes
      textTheme: GoogleFonts.robotoTextTheme(textThemeData),
      // Use ColorScheme to generate the bulk of the color theme
      colorScheme: ColorScheme(
          brightness: isDark ? Brightness.dark : Brightness.light,
          primary: primaryColor,
          primaryVariant: shift(primaryColor, .1),
          secondary: secondaryColor,
          secondaryVariant: shift(primaryColor, .1),
          background: bgColor,
          surface: surface,
          onBackground: mainTextColor,
          onSurface: mainTextColor,
          onError: mainTextColor,
          onPrimary: inverseTextColor,
          onSecondary: inverseTextColor,
          error: focusColor),
    );
    // Apply additional styling that is missed by ColorScheme
    // All done, return the ThemeData
    return t.copyWith(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionHandleColor: Colors.transparent,
          selectionColor: primaryColor,
        ),
        buttonTheme: ButtonThemeData(
          height: 55,
          buttonColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            minimumSize: Size.fromHeight(65),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
          hintStyle: TextStyle(fontSize: 16, color: greyColor),
          errorStyle: TextStyle(fontSize: 12, color: Colors.redAccent),
        ),
        buttonColor: primaryColor,
        primaryColor: primaryColor,
        highlightColor: shift(Colors.grey, .1),
        toggleableActiveColor: primaryColor);
  }

  Color shift(Color c, double amt) {
    amt *= (isDark ? -1 : 1);
    var hslc = HSLColor.fromColor(c); // Convert to HSL
    double lightness =
        (hslc.lightness + amt).clamp(0, 1.0) as double; // Add/Remove lightness
    return hslc.withLightness(lightness).toColor(); // Convert back to Color
  }

  static changeTheme(ThemeType type) {
    final theme = AppTheme.fromType(type);
    if (theme.isDark) {
      lightTheme = theme;
      Get.changeTheme(ThemeData.light());
    } else {
      darkTheme = theme;
      Get.changeTheme(ThemeData.dark());
    }
  }

  static AppTheme get theme =>
      Get.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme;

  static AppTheme lightTheme = AppTheme.fromType(ThemeType.LIGHT_BLUE);
  static AppTheme darkTheme = AppTheme.fromType(ThemeType.DARK_BLUE);
}
