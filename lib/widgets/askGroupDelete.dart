import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AskGroupDelete extends StatelessWidget {
  const AskGroupDelete({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      elevation: 10,
      title: Center(
        child: Text(
          "Delete " + name,
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                context.read<CNGroup>().deleteGrp(name);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.check_circle,
                size: Globals.appBarIconSize + 5,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel,
                size: Globals.appBarIconSize + 5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
