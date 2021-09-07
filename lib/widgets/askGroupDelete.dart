import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
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
          name,
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
                context.read<Glist>().deleteGrp(name);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.done_outline,
                size: Globals.appBarIconSize,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                // context.read<Glist>().deleteGrp(name);
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.cancel,
                size: Globals.appBarIconSize,
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