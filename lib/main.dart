import 'package:bill1/models/group.dart';
import 'package:bill1/screens/askExp.dart';
import 'package:bill1/screens/expList.dart';
import 'package:bill1/screens/grpList.dart';
import 'package:bill1/themes/themeLight.dart';
import 'package:flutter/material.dart';
import 'package:bill1/screens/grpCreate.dart';
import 'package:flutter/services.dart';
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
          },
          '/grpInfo': (context) {
            return GrpInfo();
          }
        },
        title: 'Bill App',
        theme: ThemeLight.theme1,
      ),
    );
  }
}

class Glist extends ChangeNotifier {
  var box = Hive.box<Group>('GrpDb');
  late Group cGrp;
  Expenses cExp = Expenses();

  //Group Functions here
  set openGrp(Group grp) {
    cGrp = grp;
  }

  set addGrp(Group grp) {
    box.put(grp.grpName, grp);
    notifyListeners();
  }

  void deleteGrp(String name) {
    box.delete(name);
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

  void openNewExpense() {
    cExp = Expenses();
    int length = cGrp.grpContacts.length;
    cExp.whoBought = List<double>.filled(length, 0);
    cExp.whoPaid = List<double>.filled(length, 0);
  }
  //Expense functions here

  void setExpenseTitle(String title) {
    cExp.title = title;
    notifyListeners();
  }

  void addWhoPaid(int index, double amount) {
    cExp.whoPaid[index] += amount;
    notifyListeners();
  }

  void addWhoBought(int index, double amount) {
    cExp.whoBought[index] += amount;
    notifyListeners();
  }

  void addExpense() {
    cGrp.expense.add(cExp);
    notifyListeners();
  }
}
