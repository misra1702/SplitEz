import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/screens/askExp.dart';
import 'package:bill1/screens/expDetail.dart';
import 'package:bill1/screens/expList.dart';
import 'package:bill1/screens/grpList.dart';
import 'package:bill1/screens/showReceipt.dart';
import 'package:bill1/themes/themeLight.dart';
import 'package:flutter/material.dart';
import 'package:bill1/screens/grpCreate.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bill1/screens/groupInfo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(ContactsAdapter());
  Hive.registerAdapter(ExpensesAdapter());

  await Hive.openBox<Group>('GrpDb');
  // var box = Hive.box<Group>('GrpDb');
  // box.clear();
  // box.deleteFromDisk();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return CNGroup();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/grpList',
        routes: {
          '/grpCreate': (context) {
            return GrpCreate();
          },
          '/grpList': (context) {
            return GrpList();
          },
          '/expList': (context) {
            return ExpList();
          },
          '/askExp': (context) {
            return AskExp();
          },
          '/grpInfo': (context) {
            return GrpInfo();
          },
          '/expDetail': (context) {
            return ExpDetail();
          },
          '/showReceipt': (context) {
            return ShowReceipt();
          }
        },
        title: 'Bill App',
        theme: ThemeLight.theme1,
      ),
    );
  }
}
