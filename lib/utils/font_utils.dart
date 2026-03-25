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
    case 'Montserrat':
      return GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Poppins':
      return GoogleFonts.poppins(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w600);
    case 'Inter':
      return GoogleFonts.inter(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Space Grotesk':
      return GoogleFonts.spaceGrotesk(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Rubik':
      return GoogleFonts.rubik(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Outfit':
      return GoogleFonts.outfit(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Oswald':
      return GoogleFonts.oswald(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w600);
    case 'Anton':
      return GoogleFonts.anton(fontSize: fontSize, color: color);
    case 'Righteous':
      return GoogleFonts.righteous(fontSize: fontSize, color: color);
    case 'Russo One':
      return GoogleFonts.russoOne(fontSize: fontSize, color: color);
    case 'Orbitron':
      return GoogleFonts.orbitron(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Audiowide':
      return GoogleFonts.audiowide(fontSize: fontSize, color: color);
    case 'Bungee':
      return GoogleFonts.bungee(fontSize: fontSize, color: color);
    case 'Fredoka':
      return GoogleFonts.fredoka(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w600);
    case 'Lexend':
      return GoogleFonts.lexend(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Nunito':
      return GoogleFonts.nunito(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w800);
    case 'Quicksand':
      return GoogleFonts.quicksand(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Comfortaa':
      return GoogleFonts.comfortaa(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Rajdhani':
      return GoogleFonts.rajdhani(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Chakra Petch':
      return GoogleFonts.chakraPetch(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Michroma':
      return GoogleFonts.michroma(fontSize: fontSize, color: color);
    case 'Megrim':
      return GoogleFonts.megrim(fontSize: fontSize, color: color);
    case 'Poiret One':
      return GoogleFonts.poiretOne(fontSize: fontSize, color: color);
    case 'Gruppo':
      return GoogleFonts.gruppo(fontSize: fontSize, color: color);
    case 'Syncopate':
      return GoogleFonts.syncopate(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Zen Dots':
      return GoogleFonts.zenDots(fontSize: fontSize, color: color);
    case 'Teko':
      return GoogleFonts.teko(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w600);
    case 'Electrolize':
      return GoogleFonts.electrolize(fontSize: fontSize, color: color);
    case 'Exo 2':
      return GoogleFonts.exo2(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
    case 'Workbench':
    default:
      return GoogleFonts.workbench(fontSize: fontSize, color: color);
  }
}
