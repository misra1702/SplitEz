import 'package:bill1/globals.dart';
import 'package:flutter/material.dart';

class AskExp extends StatefulWidget {
  const AskExp({Key? key}) : super(key: key);

  @override
  _AskExpState createState() => _AskExpState();
}

class _AskExpState extends State<AskExp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Add Expense", style: Globals.appBarTextStyle),
        centerTitle: true,
      ),
    );
  }
}
