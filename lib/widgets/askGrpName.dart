import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class AskGrpName extends StatefulWidget {
  const AskGrpName({Key? key}) : super(key: key);

  @override
  _AskGrpNameState createState() => _AskGrpNameState();
}

class _AskGrpNameState extends State<AskGrpName> {
  final TextEditingController _grpName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 10),
      elevation: 10,
      title: Center(
        child: Text(
          "Group Name",
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      content: TextField(
        controller: _grpName,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        style: GoogleFonts.kreon(
          color: Colors.white,
          fontSize: 25,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        Center(
          child: ElevatedButton(
            style: Globals.btnst,
            onPressed: () {
              var box = Hive.box<Group>('GrpDb');
              this._grpName.text = this._grpName.text.trim();
              if (this._grpName.text == "") {
                SnackBar e = SnackBar(
                  content: Text(
                    "Group Name cannot be empty",
                    style: Globals.askExpenseSt,
                  ),
                  duration: Globals.snackbarDuration,
                );
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              } else if (box.containsKey(_grpName.text)) {
                SnackBar e = SnackBar(
                  content: Text(
                    "Group already exists.",
                    style: Globals.askExpenseSt,
                  ),
                  duration: Globals.snackbarDuration,
                );
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              }
              context.read<Glist>().cGrpName(_grpName.text);
              Navigator.of(context).pushNamed('/grpCreate');
            },
            child: Text(
              "SUBMIT",
              style: GoogleFonts.kreon(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
