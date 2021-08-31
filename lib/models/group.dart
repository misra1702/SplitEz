import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hive/hive.dart';

part 'group.g.dart';

@HiveType(typeId: 0)
class Group extends HiveObject {
  @HiveField(0)
  String grpName;

  @HiveField(1)
  List<Contact> grpContacts = [];

  @HiveField(2)
  List<List<Map<String, double>>> expense = [];

  Group({required this.grpName});

  void addContact(Contact a) {
    grpContacts.add(a);
  }

  void removeContact(int index) {
    grpContacts.removeAt(index);
  }

  void addExpense(List<Map<String, double>> a) {
    expense.add(a);
  }

  void removeExpense(int index) {
    expense.removeAt(index);
    
  }
}
