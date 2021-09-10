import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AskName extends StatefulWidget {
  const AskName({Key? key}) : super(key: key);

  @override
  _AskNameState createState() => _AskNameState();
}

class _AskNameState extends State<AskName> {
  final TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 10),
      elevation: 10,
      title: Center(
        child: Text(
          "Name",
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      content: TextField(
        controller: _name,
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
              this._name.text = this._name.text.trim();
              if (this._name.text == "") {
                SnackBar e = SnackBar(
                  content: Text(
                    "Name cannot be empty",
                    style: Globals.askExpenseSt,
                  ),
                  duration: Globals.snackbarDuration,
                );
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              }
              Contacts nCon = Contacts(name: this._name.text);
              context.read<Glist>().addContact = (nCon);
              print("Done adding to cGrp");
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
