import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double borderRadius = 15.0;
const double spacing = 24;
const double subSpacing = 16;
const double superSubSpacing = 12;
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
