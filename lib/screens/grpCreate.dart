import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:hive/hive.dart';

class GrpCreate extends StatefulWidget {
  GrpCreate({Key? key}) : super(key: key);
  @override
  _GrpCreateState createState() => _GrpCreateState();
}

class _GrpCreateState extends State<GrpCreate> {
  @override
  Widget build(BuildContext context) {
    final String grpName = ModalRoute.of(context)?.settings.arguments as String;
    var box = Hive.box<Group>('GrpDb');
    setState(() {
      box.put(grpName, Group(grpName: grpName));
    });
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "Drawer",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/grpList'),
            );
          },
        ),
        title: Text(grpName),
        elevation: 30,
      ),
      body: GrpCreateBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popUntil(
            context,
            ModalRoute.withName('/grpList'),
          );
        },
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class GrpCreateBody extends StatefulWidget {
  const GrpCreateBody({Key? key}) : super(key: key);

  @override
  _GrpCreateBodyState createState() => _GrpCreateBodyState();
}

class _GrpCreateBodyState extends State<GrpCreateBody> {
  List<Contact> contactNames = [];
  addContact() async {
    Contact? a;
    try {
      a = await FlutterContactPicker.pickPhoneContact();
    } catch (e) {
      print(e);
    }
    setState(() {
      if (a == null || contactNames.contains(a)) return;
      contactNames.add(a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text(
              "Add new contact",
              style: Globals.st,
            ),
            onPressed: addContact,
            style: Globals.btnst,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: contactNames.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    key: UniqueKey(),
                    title: Text(
                      "${contactNames[index].fullName}",
                      style: Globals.st,
                    ),
                    subtitle: Text("$index"),
                    leading: TextButton(
                      onPressed: () {},
                      child: Text(
                        "${contactNames[index].fullName?[0]}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: Globals.btnstGrpList,
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          contactNames.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}

void addGroup(var box, String grpName) {}
