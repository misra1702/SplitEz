import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Globals {
  static TextStyle st = GoogleFonts.teko(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static ButtonStyle btnst = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(5),
        bottomLeft: Radius.circular(5),
      ),
    ),
  );
}
