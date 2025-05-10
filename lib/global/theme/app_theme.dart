import 'package:flutter/material.dart';

// Primary colors
const Color primaryColor = Colors.lightBlue;
const Color primaryColor50 = Color(0xFF2F2F2F);
const Color primaryColor100 = Color(0xFFd0f9fd);
const Color primaryColor200 = Color(0xFFa6f3fb);
const Color primaryColor300 = Color(0xFF69e7f7);
const Color primaryColor400 = Color(0xFF25d3eb);
const Color primaryColor500 = Color(0xFF09b6d1);
const Color primaryColor600 = Color(0xFF0a92b0);
const Color primaryColor800 = Color(0xFF165e74);
const Color primaryColor900 = Color(0xFF093443);

// Neutral colors
const Color grey = Color(0xFF555555);
const Color greyInputs = Color(0xFFf4f6f9);
const Color greyLight = Color(0xFFC4C4C4);

// Accent colors
const Color mintAccent = Color(0xFF6dc8c2);
const Color yellowAccent = Color(0xFFffbb45);
const Color redAccent = Color(0xFFf74048);
const Color greenAccent = Color(0xFF71FF7A);
const Color violetAccent = Color(0xFF390D97);
const Color blackAccent = Color(0xFF1B1B1B);

const String appFontFamily = 'Funnel_Display';

class AppTheme {
  static final ThemeData normalTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(primary: primaryColor),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color(0xFF1B1B1B),
    fontFamily: appFontFamily,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      displayMedium: TextStyle(color: Colors.white),
      displaySmall: TextStyle(color: Colors.white),
      headlineLarge: TextStyle(color: Colors.white),
      headlineMedium: TextStyle(color: Colors.white),
      headlineSmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
      labelLarge: TextStyle(color: Colors.white),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Colors.white),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // Color de fondo del AppBar
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0, // Elevación del AppBar
      toolbarHeight: 35,
    ),
    // Customizing the button theme
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    // ElevatedButton themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontFamily: appFontFamily,
            fontWeight: FontWeight.normal,
          ),
        ),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        minimumSize: WidgetStateProperty.all<Size>(const Size(359, 48)),
      ),
    ),
    // Adding InputDecorationTheme
    inputDecorationTheme: const InputDecorationTheme(
      focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(width: 0.7, color: redAccent)),
      focusedBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
      disabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(width: 0.0, style: BorderStyle.none)),
      filled: true,
      // change color of value
    ),
  );

  static ButtonStyle secondaryButton1({Color? color}) {
    return ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      foregroundColor: color ?? primaryColor,
      side: BorderSide(color: color ?? primaryColor, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      minimumSize: const Size(359, 48),
    );
  }

  static final ButtonStyle secondaryButtom2 = ElevatedButton.styleFrom(
    backgroundColor: primaryColor50,
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    minimumSize: const Size(359, 48),
  );
  static final ButtonStyle smallSecondaryButtom = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: primaryColor,
    side: const BorderSide(color: primaryColor, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    minimumSize: const Size(133, 36),
  );
}
