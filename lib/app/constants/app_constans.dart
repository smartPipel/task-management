import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double borderRadius = 15.0;
const double mainSpacing = 24;
const double bigSpacing = 16;
const double mediumSpacing = 12;
const double smallSpacing = 6;
const String illustrationAssets = 'assets/illustrations/';

height(BuildContext context) => MediaQuery.of(context).size.height;
width(BuildContext context) => MediaQuery.of(context).size.width;

TextStyle defaultFontsStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) =>
    GoogleFonts.poppins(
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black,
      fontSize: fontSize ?? 14,
    );
