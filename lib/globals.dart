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
  static TextStyle textFieldLabelStyle = GoogleFonts.kreon(
    color: Colors.tealAccent,
  );
  static TextStyle textFieldStyle = GoogleFonts.kreon(
    fontSize: 20,
  );
  static InputDecoration textFieldDecoration = InputDecoration(
    labelText: 'Title',
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.teal,
        width: 4,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: Colors.black,
        width: 2,
        style: BorderStyle.solid,
      ),
    ),
  );
  static TextStyle askExpenseSt = GoogleFonts.kreon(
    fontSize: 24,
  );
}
