import 'package:flutter/material.dart';
import 'package:gdg_braynr/global/theme/app_theme.dart';

class AppButtonStyles {
  // Private constructor to prevent instantiation
  AppButtonStyles._();

  // Design tokens - Better to extract these to a separate constants file
  static const double _defaultBorderRadius = 15.0;
  static const double _defaultHeight = 48.0;
  static const double _defaultWidth = 359.0;
  static const double _smallHeight = 36.0;
  static const double _smallWidth = 133.0;

  // Text styles
  static const TextStyle _defaultTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle _smallTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  // Base button style that other styles can extend
  static final ButtonStyle _baseStyle = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_defaultBorderRadius),
      ),
    ),
    padding: WidgetStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(horizontal: 16),
    ),
    elevation: WidgetStateProperty.resolveWith<double>(
      (Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed)) return 2;
        if (states.contains(WidgetState.hovered)) return 1;
        return 0;
      },
    ),
  );

  // Primary button style
  static ButtonStyle get primary => _baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return primaryColor.withOpacity(0.6);
            }
            if (states.contains(WidgetState.pressed)) {
              return primaryColor800;
            }
            return primaryColor;
          },
        ),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(_defaultWidth, _defaultHeight),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(_defaultTextStyle),
      );

  // Secondary button style
  static ButtonStyle secondary({Color? color}) {
    final baseColor = color ?? primaryColor;

    return _baseStyle.copyWith(
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return baseColor.withOpacity(0.1);
          }
          return Colors.white;
        },
      ),
      foregroundColor: WidgetStateProperty.all<Color>(baseColor),
      side: WidgetStateProperty.resolveWith<BorderSide>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(color: baseColor.withOpacity(0.8), width: 1);
          }
          return BorderSide(color: baseColor, width: 1);
        },
      ),
      minimumSize: WidgetStateProperty.all<Size>(
        const Size(_defaultWidth, _defaultHeight),
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(_defaultTextStyle),
    );
  }

  // Small secondary button style
  static ButtonStyle get smallSecondary => secondary().copyWith(
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(_smallWidth, _smallHeight),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(_smallTextStyle),
      );

  // Payment button style with elevation and shadow
  static ButtonStyle get payment => _baseStyle.copyWith(
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.grey[100]!;
            }
            return Colors.white;
          },
        ),
        elevation: WidgetStateProperty.resolveWith<double>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.pressed)) return 2;
            if (states.contains(WidgetState.hovered)) return 4;
            return 3;
          },
        ),
        shadowColor: WidgetStateProperty.all<Color>(
          Colors.grey.withOpacity(0.5),
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(161, _defaultHeight),
        ),
        textStyle: WidgetStateProperty.all<TextStyle>(_defaultTextStyle),
      );
}
