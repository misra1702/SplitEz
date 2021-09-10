import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askName.dart';
import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class GrpCreate extends StatefulWidget {
  GrpCreate({Key? key}) : super(key: key);

  @override
  _GrpCreateState createState() => _GrpCreateState();
}

class _GrpCreateState extends State<GrpCreate> {
  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<Glist>().cGrp;
    print("Inside grpCreate");
    print("Grpname : $cGrp.grpName");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Globals.appBarIconSize,
          ),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/grpList'),
            );
          },
        ),
        title: Text(
          cGrp.grpName,
          style: Globals.appBarTextStyle,
        ),
        elevation: 30,
        centerTitle: true,
      ),
      body: GrpCreateBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Glist>().addGrp(cGrp);
          Navigator.of(context).pushNamed('/expList', arguments: cGrp.grpName);
        },
        child: Icon(
          Icons.check,
          size: Globals.appBarIconSize,
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
    var status = await Permission.contacts.status;
    print(status);
    if (status.isDenied) {
      SnackBar e =
          SnackBar(content: Text("Permission for contacts is not provided"));
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(e);
      print(status);
      return;
    }
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
      context.read<Glist>().addContact = (nCon);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(
                  "Add from contact",
                  style: Globals.appBarTextStyle,
                ),
                onPressed: chooseContact,
                style: Globals.btnst,
              ),
              ElevatedButton(
                child: Text(
                  "Add",
                  style: Globals.appBarTextStyle,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AskName();
                    },
                  );
                },
                style: Globals.btnst,
              ),
            ],
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
                        context.read<Glist>().deleteContact = (con);
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
