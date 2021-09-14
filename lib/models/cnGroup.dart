import 'dart:io';

import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CNGroup extends ChangeNotifier {
  var box = Hive.box<Group>('GrpDb');
  Group cGrp = Group(grpName: "");
  Expenses cExp = Expenses();
  File? cPdf;

  void setcPdf(File pdf) {
    cPdf = pdf;
  }

  //Group Functions here
  void openGrp(String grpName) {
    if (box.containsKey(grpName) == false) {
      print("Cannot find key of group in the box");
      return;
    }
    cGrp = box.get(grpName)!;
    print("cGrp is set to " + cGrp.grpName);
    notifyListeners();
  }

  void openNewGroup() {
    cGrp = Group(grpName: "");
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

  void cGrpName(String grpName) {
    print("Setting cGrp name to $grpName");
    cGrp.grpName = grpName;
    notifyListeners();
  }
  //all these functions performed on current open group.

  void openNewExpense() {
    print("cExp set to empty Expense");
    cExp = Expenses();
    notifyListeners();
  }

  void setcExp(Expenses exp) {
    print("cExp set to ${exp.title}");
    cExp = exp;
    notifyListeners();
  }

  void addContact(Contacts con) {
    int id = cGrp.contactsId;
    print(
        "Adding contact with id: $id and name: ${con.name} to grp: ${cGrp.grpName}");
    cGrp.grpContacts[id] = con;
    cGrp.contactsId++;
    notifyListeners();
  }

  void deleteContact(int id) {
    print('Deleting contact with id: $id');
    cGrp.grpContacts.remove(id);
    notifyListeners();
  }

  void addExpense(Expenses a) {
    int id = cGrp.expensesId;
    cGrp.grpExpenses[id] = a;
    cGrp.expensesId++;
    box.put(cGrp.grpName, cGrp);
    notifyListeners();
  }

  void delExpense(int id) {
    cGrp.grpExpenses.remove(id);
    box.put(cGrp.grpName, cGrp);
    notifyListeners();
  }

  //Expense functions here
  void setAmount(double amount) {
    cExp.amount = amount;
    print("setting expense amount: " + cExp.amount.toString());
    notifyListeners();
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
        " to index " +
        index.toString());
    notifyListeners();
  }

  void deleteWhoPaid(int index) {
    cExp.whoPaid.remove(index);
    print("Deleting whoPaid " + index.toString());
    notifyListeners();
  }

  void deleteWhoBought(int index) {
    print("Deleting whoBought index: $index");
    cExp.whoBought.remove(index);
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
