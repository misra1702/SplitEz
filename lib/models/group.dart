import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  String grpName;

  @HiveField(1)
  List<Contacts> grpContacts = [];

  @HiveField(2)
  List<List<double>> expense = [];

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
  @HiveField(0)
  String? title;

  @HiveField(1)
  double amount = 0.0;

  @HiveField(2)
  Map<Contacts, double> whoPaid = {};

  @HiveField(3)
  Map<Contacts, double> whoBought = {};

  Expenses({required this.amount});
}
