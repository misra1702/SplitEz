import 'package:bill1/models/group.dart';
import 'package:bill1/screens/askExp.dart';
import 'package:bill1/screens/expList.dart';
import 'package:bill1/screens/grpList.dart';
import 'package:flutter/material.dart';
import 'package:bill1/screens/grpCreate.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GroupAdapter());
  Hive.registerAdapter(ContactsAdapter());
  await Hive.openBox<Group>('GrpDb');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return Glist();
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
          }
        },
        title: 'Bill App',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
      ),
    );
  }
}

class Glist extends ChangeNotifier {
  var box = Hive.box<Group>('GrpDb');
  late Group cGrp;
  Expenses cExp = Expenses();

  set openGrp(Group grp) {
    cGrp = grp;
  }

  set addGrp(Group grp) {
    box.put(grp.grpName, grp);
    notifyListeners();
  }

  set deleteGrp(Group grp) {
    box.delete(grp.grpName);
    notifyListeners();
  }

  set addContact(Contacts con) {
    cGrp.grpContacts.add(con);
    notifyListeners();
  }

  set deleteContact(Contacts con) {
    cGrp.grpContacts.remove(con);
    notifyListeners();
  }

  void setTitle(String title) {
    cExp.title = title;
    notifyListeners();
  }

  set setAmount(String amount) {
    cExp.amount = amount;
    notifyListeners();
  }

  void openNewExpense() {
    cExp = Expenses();
  }

  void addWhoPaid(Contacts a, String amount) {
    cExp.whoPaid[a] = amount;
    notifyListeners();
  }
}
