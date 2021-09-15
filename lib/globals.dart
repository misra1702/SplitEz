import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Globals {
  static TextStyle appBarTextStyle = GoogleFonts.kreon(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textFieldLabelStyle = GoogleFonts.kreon(
    color: Colors.tealAccent,
  );
  static TextStyle textFieldAskStyle = GoogleFonts.kreon(
    fontSize: 18,
  );
  static TextStyle st = GoogleFonts.kreon(
    fontSize: 25,
  );
  static TextStyle bodyTextStyle = GoogleFonts.kreon(
    fontSize: 22,
    color: Colors.black,
  );
  static TextStyle bodyLargeTextStyle = GoogleFonts.kreon(
    fontSize: 28,
    color: Colors.black,
  );
  static TextStyle cardTextStyle = GoogleFonts.kreon(
    fontSize: 28,
    color: Colors.white,
  );
  static TextStyle cardAskTextStyle = GoogleFonts.kreon(
    fontSize: 16,
  );
  static TextStyle numHeadingTextStyle = GoogleFonts.kreon(
    fontSize: 35,
    color: Colors.teal,
    fontWeight: FontWeight.bold,
  );

  static TextStyle askExpenseSt = GoogleFonts.kreon(
    fontSize: 24,
  );
  static TextStyle numPaidTextStyle = GoogleFonts.kreon(
    fontSize: 20,
    color: Colors.teal,
  );
  static TextStyle numBoughtTextStyle = GoogleFonts.kreon(
    fontSize: 20,
    color: Colors.red,
  );
  static int textFieldLength = 12;

  static ButtonStyle btnst = ElevatedButton.styleFrom(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
    ),
    padding: EdgeInsets.all(10),
  );
  static ButtonStyle btnstGrpList = TextButton.styleFrom(
    shape: CircleBorder(),
    backgroundColor: Colors.teal,
    alignment: Alignment.center,
    padding: EdgeInsets.all(10),
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

  static Duration snackbarDuration = Duration(milliseconds: 500);
  static double appBarIconSize = 30;
}
