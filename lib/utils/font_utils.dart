import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle getFontStyle(String fontName, double fontSize, Color color,
    {FontWeight fontWeight = FontWeight.w400}) {
  switch (fontName) {
    case 'Jersey 20':
      return GoogleFonts.jersey20(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Noto Serif':
      return GoogleFonts.notoSerif(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Bebas Neue':
      return GoogleFonts.bebasNeue(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Pacifico':
      return GoogleFonts.pacifico(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Lobster':
      return GoogleFonts.lobster(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Raleway':
      return GoogleFonts.raleway(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Permanent Marker':
      return GoogleFonts.permanentMarker(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Black Han Sans':
      return GoogleFonts.blackHanSans(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Noto Sans KR':
      return GoogleFonts.notoSansKr(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Montserrat':
      return GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Poppins':
      return GoogleFonts.poppins(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Inter':
      return GoogleFonts.inter(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Space Grotesk':
      return GoogleFonts.spaceGrotesk(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Rubik':
      return GoogleFonts.rubik(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Outfit':
      return GoogleFonts.outfit(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Oswald':
      return GoogleFonts.oswald(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Anton':
      return GoogleFonts.anton(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Righteous':
      return GoogleFonts.righteous(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Russo One':
      return GoogleFonts.russoOne(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Orbitron':
      return GoogleFonts.orbitron(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Audiowide':
      return GoogleFonts.audiowide(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Bungee':
      return GoogleFonts.bungee(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Fredoka':
      return GoogleFonts.fredoka(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Lexend':
      return GoogleFonts.lexend(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Nunito':
      return GoogleFonts.nunito(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Quicksand':
      return GoogleFonts.quicksand(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Comfortaa':
      return GoogleFonts.comfortaa(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Rajdhani':
      return GoogleFonts.rajdhani(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Chakra Petch':
      return GoogleFonts.chakraPetch(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Michroma':
      return GoogleFonts.michroma(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Megrim':
      return GoogleFonts.megrim(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Poiret One':
      return GoogleFonts.poiretOne(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Gruppo':
      return GoogleFonts.gruppo(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Syncopate':
      return GoogleFonts.syncopate(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Zen Dots':
      return GoogleFonts.zenDots(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Teko':
      return GoogleFonts.teko(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Electrolize':
      return GoogleFonts.electrolize(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Exo 2':
      return GoogleFonts.exo2(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    case 'Workbench':
    default:
      return GoogleFonts.workbench(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
