import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class AskGrpName extends StatefulWidget {
  const AskGrpName({Key? key,}) : super(key: key);

  @override
  _AskGrpNameState createState() => _AskGrpNameState();
}

class _AskGrpNameState extends State<AskGrpName> {
  final TextEditingController _grpName = TextEditingController();
  String grpName = "";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
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
        onChanged: (String value) {
          this.grpName = value;
        },
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
              var box = Hive.box<Group>('GrpDb');
              this.grpName = this.grpName.trim();
              if (this.grpName == "") {
                SnackBar e = SnackBar(
                  content: Text("Group Name cannot be empty"),
                );
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              } else if (box.containsKey(grpName)) {
                SnackBar e = SnackBar(
                  content: Text("Group already exists."),
                );
                ScaffoldMessenger.of(context).showSnackBar(e);
                return;
              }
              Navigator.of(context).pushNamed(
                '/grpCreate',
                arguments: Group(grpName: this.grpName),
              );
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
