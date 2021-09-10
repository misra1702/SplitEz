import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class AskWhoPaidAmount extends StatefulWidget {
  const AskWhoPaidAmount({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  _AskWhoPaidAmountState createState() => _AskWhoPaidAmountState();
}

class _AskWhoPaidAmountState extends State<AskWhoPaidAmount> {
  final TextEditingController _grpName = TextEditingController();
  String amount = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.only(bottom: 10),
      elevation: 10,
      title: Center(
        child: Text(
          "Amount Paid",
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      content: TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value) {
          this.amount = value;
        },
        maxLength: Globals.textFieldLength,
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
      backgroundColor: Colors.teal,
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              this.amount = this.amount.trim();
              if (this.amount == "") {
                SnackBar e = SnackBar(
                  content: Text(
                    "Amount cannot be empty",
                    style: Globals.askExpenseSt,
                  ),
                  duration: Globals.snackbarDuration,
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              } else if (double.tryParse(this.amount) == null) {
                SnackBar e = SnackBar(
                  content: Text(
                    "Enter a numerical value",
                    style: Globals.askExpenseSt,
                  ),
                  duration: Globals.snackbarDuration,
                );
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              }
              context.read<Glist>().addWhoPaid(
                    widget.index,
                    double.parse(amount),
                  );
              print(widget.index.toString() + " " + amount);
              print(context.read<Glist>().cExp.whoPaid.length);
              Navigator.pop(context);
              return;
            },
            child: Text(
              "SUBMIT",
              style: GoogleFonts.kreon(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            style: Globals.btnst,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
