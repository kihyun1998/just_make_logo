import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getFontStyle(String fontName, double fontSize, Color color) {
  switch (fontName) {
    case 'Jersey 20':
      return GoogleFonts.jersey20(fontSize: fontSize, color: color);
    case 'Noto Serif':
      return GoogleFonts.notoSerif(fontSize: fontSize, color: color);
    case 'Bebas Neue':
      return GoogleFonts.bebasNeue(fontSize: fontSize, color: color);
    case 'Pacifico':
      return GoogleFonts.pacifico(fontSize: fontSize, color: color);
    case 'Lobster':
      return GoogleFonts.lobster(fontSize: fontSize, color: color);
    case 'Raleway':
      return GoogleFonts.raleway(fontSize: fontSize, color: color);
    case 'Permanent Marker':
      return GoogleFonts.permanentMarker(fontSize: fontSize, color: color);
    case 'Black Han Sans':
      return GoogleFonts.blackHanSans(fontSize: fontSize, color: color);
    case 'Noto Sans KR':
      return GoogleFonts.notoSansKr(fontSize: fontSize, color: color);
    case 'Workbench':
    default:
      return GoogleFonts.workbench(fontSize: fontSize, color: color);
  }
}
