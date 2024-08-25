import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Color
Color primaryColor = const Color.fromRGBO(254, 175, 48, 1);
Color disabledColor = const Color.fromRGBO(142, 142, 147, 1);

//Main Theme for the app
ThemeData theme() {
  return ThemeData(
    primaryColor: primaryColor,
    disabledColor: disabledColor,
    textTheme: GoogleFonts.kanitTextTheme(),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: disabledColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(primaryColor),
        overlayColor: WidgetStatePropertyAll(primaryColor.withOpacity(0.1)),
      ),
    ),
  );
}
