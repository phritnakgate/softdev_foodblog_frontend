import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Color
Color primaryColor = const Color.fromRGBO(254, 175, 48, 1);
Color disabledColor = const Color.fromRGBO(142, 142, 147, 1);

//Main Theme for the app
ThemeData theme() {
  return ThemeData(
    fontFamily: GoogleFonts.kanit().fontFamily,
  );
}

