import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  static const accentColor = Colors.purple;

  static final _lightColors = ColorScheme.fromSeed(seedColor: accentColor);
  static final _darkColors = ColorScheme.fromSeed(
    seedColor: accentColor,
    brightness: Brightness.dark,
  );

  static ThemeData _getTheme(ColorScheme colors) {
    final typo = Typography.material2021(colorScheme: colors);
    final TextTheme textTheme;
    if (colors.brightness == Brightness.dark) {
      // dark mode specific things
      textTheme = typo.white;
    } else {
      // light mode specific things
      textTheme = typo.black;
    }
    return ThemeData.from(colorScheme: colors, useMaterial3: true).copyWith(
      textTheme: GoogleFonts.senTextTheme(textTheme),
      appBarTheme: AppBarTheme(centerTitle: true),
    );
  }

  static ThemeData get lightTheme => _getTheme(_lightColors);
  static ThemeData get darkTheme => _getTheme(_darkColors);
}

ColorScheme colorSchemeOf(BuildContext context) {
  return Theme.of(context).colorScheme;
}

double scaledSizeOf(BuildContext context, double size) {
  return MediaQuery.of(context).textScaler.scale(size);
}
