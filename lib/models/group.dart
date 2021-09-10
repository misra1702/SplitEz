import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  String grpName;

  @HiveField(1)
  List<Contacts> grpContacts = [];

  @HiveField(2)
  List<Expenses> expense = [];

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
  String title;

  @HiveField(1)
  List<double> whoPaid = [];

  @HiveField(2)
  List<double> whoBought = [];

  @HiveField(3)
  double amount = 0;
  Expenses({this.title = ""});
}
