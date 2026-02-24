import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getFontStyle(String fontName, double fontSize, Color color) {
  switch (fontName) {
    case 'Jersey 20':
      return GoogleFonts.jersey20(fontSize: fontSize, color: color);
    case 'Noto Serif':
      return GoogleFonts.notoSerif(fontSize: fontSize, color: color);
    case 'Workbench':
    default:
      return GoogleFonts.workbench(fontSize: fontSize, color: color);
  }
}
