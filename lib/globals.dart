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
  static ButtonStyle btnstGrpList = TextButton.styleFrom(
    shape: CircleBorder(),
    backgroundColor: Colors.teal,
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
  );
  static TextStyle appBarTextStyle = GoogleFonts.kreon(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
}
