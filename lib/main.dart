import 'package:bill1/models/group.dart';
import 'package:bill1/screens/askExp.dart';
import 'package:bill1/screens/expDetail.dart';
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
    // SystemChrome.setEnabledSystemUIOverlays([]);
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
          },
          '/expDetail': (context) {
            return ExpDetail();
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
  Group cGrp = Group(grpName: "");
  Expenses cExp = Expenses();

  //Group Functions here
  void openGrp(String grpName) {
    cGrp = box.get(grpName)!;
    print("cGrp is set to " + cGrp.grpName);
  }

  void cGrpName(String grpName) {
    cGrp = Group(grpName: grpName);
  }

  void addGrp(Group grp) {
    print('adding grp ' + grp.grpName);
    box.put(grp.grpName, grp);
    notifyListeners();
  }

  void deleteGrp(String name) {
    print('deleting grp ' + name);
    box.delete(name);
    notifyListeners();
  }

  set addContact(Contacts con) {
    print("Adding contact " + con.name);
    cGrp.grpContacts.add(con);
    notifyListeners();
  }

  set deleteContact(Contacts con) {
    print('Deleting contact ' + con.name);
    cGrp.grpContacts.remove(con);
    notifyListeners();
  }

  void addExpense() {
    cGrp.expense.add(cExp);
    box.put(cGrp.grpName, cGrp);
    notifyListeners();
  }

  void delExpense(int index) {
    cGrp.expense.removeAt(index);
    box.put(cGrp.grpName, cGrp);
    notifyListeners();
  }

  void setExpense(Expenses exp) {
    print("Setting cExp to ${exp.title} and amount ${exp.amount}");
    cExp = exp;
  }

  void openNewExpense() {
    cExp = Expenses();
    int length = cGrp.grpContacts.length;
    cExp.whoBought = List<double>.filled(length, 0);
    cExp.whoPaid = List<double>.filled(length, 0);
    print('cExp of size ' + cGrp.grpContacts.length.toString() + "is created");
  }

  //Expense functions here
  void setAmount(double amount) {
    cExp.amount = amount;
    print("setting expense amount: " + cExp.amount.toString());
  }

  void setExpenseTitle(String title) {
    cExp.title = title;
    print("setting expense title:" + cExp.title);
    notifyListeners();
  }

  void addWhoPaid(int index, double amount) {
    cExp.whoPaid[index] = amount;
    print("Adding whoPaid " +
        cExp.whoPaid[index].toString() +
        " index " +
        index.toString());
    notifyListeners();
  }

  void deleteWhoPaid(int index) {
    cExp.whoPaid[index] = 0;
    print("Deleting whoPaid " + index.toString());
    notifyListeners();
  }

  void deleteWhoBought(int index) {
    cExp.whoBought[index] = 0;
    print("Deleting whoBought " + index.toString());
    notifyListeners();
  }

  void addWhoBought(int index, double amount) {
    cExp.whoBought[index] = amount;
    print("Adding whoBought " +
        cExp.whoBought[index].toString() +
        " index " +
        index.toString());
    notifyListeners();
  }
}
