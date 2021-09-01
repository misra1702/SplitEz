import 'package:bill1/models/group.dart';
import 'package:bill1/screens/grpList.dart';
import 'package:flutter/material.dart';
import 'package:bill1/screens/grpCreate.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GroupAdapter());
  await Hive.openBox<Group>('grplist');
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
