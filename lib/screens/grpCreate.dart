import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:provider/provider.dart';

class GrpCreate extends StatefulWidget {
  GrpCreate({Key? key}) : super(key: key);

  @override
  _GrpCreateState createState() => _GrpCreateState();
}

class _GrpCreateState extends State<GrpCreate> {
  @override
  Widget build(BuildContext context) {
    final Group grp = ModalRoute.of(context)?.settings.arguments as Group;
    context.read<Glist>().openGrp(grp);
    Group cGrp = context.watch<Glist>().cGrp;
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
        title: Text(cGrp.grpName),
        elevation: 30,
      ),
      body: GrpCreateBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Glist>().addGrp(cGrp);
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
  late Group cGrp;

  chooseContact() async {
    FullContact? a;
    try {
      a = await FlutterContactPicker.pickFullContact();
    } catch (e) {
      print(e);
    }
    if (a == null) {
      return;
    } else {
      String name = (a.name?.firstName ?? "") +
          (a.name?.middleName ?? "") +
          (a.name?.lastName ?? " ");
      String? phoneNum = a.phones[0].number;
      Contacts nCon = Contacts(name: name, phone: phoneNum);
      for (int i = 0; i < cGrp.grpContacts.length; i++) {
        if (cGrp.grpContacts[i].name == name) {
          return;
        }
      }
      context.read<Glist>().addContact(nCon);
      print("Done adding to cGrp");
    }
  }

  @override
  Widget build(BuildContext context) {
    cGrp = context.watch<Glist>().cGrp;
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
            onPressed: chooseContact,
            style: Globals.btnst,
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.separated(
              itemCount: cGrp.grpContacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contacts con = cGrp.grpContacts[index];
                return Card(
                  child: ListTile(
                    key: UniqueKey(),
                    title: Text(
                      "${con.name}",
                      style: Globals.st,
                    ),
                    subtitle: Text("${con.phoneNum}"),
                    leading: TextButton(
                      onPressed: () {},
                      child: Text(
                        "${con.name[0]}",
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
                        context.read<Glist>().deleteContact(con);
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
