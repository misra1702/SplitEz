import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  String grpName;

  // Id with Contacts
  @HiveField(1)
  Map<int, Contacts> grpContacts = {};

  // Id with expenses
  @HiveField(2)
  Map<int, Expenses> grpExpenses = {};

  @HiveField(3)
  int contactsId = 0;

  @HiveField(4)
  int expensesId = 0;

  Group({required this.grpName});
}

@HiveType(typeId: 1)
class Contacts extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phoneNum = "";

  Contacts({required this.name, String? phone}) {
    phoneNum = phone ?? "";
  }
}

@HiveType(typeId: 2)
class Expenses extends HiveObject {
  ///title: Title of expense
  @HiveField(0)
  String title;

  ///whoPaid: Map of  Contact id  and amount paid
  @HiveField(1)
  Map<int, double> whoPaid = {};

  ///whoBought: Map of Contact id and amount bought
  @HiveField(2)
  Map<int, double> whoBought = {};

  ///amount: Total amount of Expenses
  @HiveField(3)
  double amount = 0;
  Expenses({this.title = ""});
}
