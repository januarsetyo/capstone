import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color.fromRGBO(51, 148, 212, 1.0);
const Color secondaryColor = Color.fromRGBO(129, 188, 228, 1.0);

final myTextTheme = TextTheme(
  headline1: GoogleFonts.ubuntu(
    fontSize: 98,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.ubuntu(
    fontSize: 61,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
    color: primaryColor,
  ),
  headline3: GoogleFonts.ubuntu(
    fontSize: 49,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.ubuntu(
    fontSize: 35,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.ubuntu(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.ubuntu(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.ubuntu(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.ubuntu(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.ubuntu(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.ubuntu(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.ubuntu(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
    color: Colors.white,
  ),
  caption: GoogleFonts.ubuntu(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.ubuntu(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
);
