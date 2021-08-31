import 'package:bill1/screens/grpList.dart';
import 'package:flutter/material.dart';
import 'package:bill1/screens/grpCreate.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/grpList',
      routes: {
        '/grpCreate': (context) {
          return GrpCreate();
        },
        '/grpList': (context) {
          return GrpList();
        }
      },
      title: 'Bill App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
