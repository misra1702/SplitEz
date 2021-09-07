import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:provider/provider.dart';

class GrpInfo extends StatefulWidget {
  GrpInfo({Key? key}) : super(key: key);

  @override
  _GrpInfoState createState() => _GrpInfoState();
}

class _GrpInfoState extends State<GrpInfo> {
  @override
  Widget build(BuildContext context) {
    final Group grp = ModalRoute.of(context)?.settings.arguments as Group;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Globals.appBarIconSize,
          ),
          onPressed: () {
            Navigator.popUntil(
              context,
              ModalRoute.withName('/expList'),
            );
          },
        ),
        title: Text(
          grp.grpName,
          style: Globals.appBarTextStyle,
        ),
        elevation: 30,
      ),
      body: GrpInfoBody(grp: grp),
    );
  }
}

class GrpInfoBody extends StatefulWidget {
  GrpInfoBody({Key? key, required this.grp}) : super(key: key);
  final Group grp;

  @override
  _GrpInfoBodyState createState() => _GrpInfoBodyState();
}

class _GrpInfoBodyState extends State<GrpInfoBody> {
  List<double> whoPaid = [];
  List<double> whoBought = [];
  double totalExp = 0;

  void func() {
    int cnt = widget.grp.expense.length;
    int n = widget.grp.grpContacts.length;
    whoPaid = List<double>.filled(n, 0);
    whoBought = List<double>.filled(n, 0);
    for (int i = 0; i < cnt; i++) {
      for (int j = 0; j < n; j++) {
        whoPaid[j] += widget.grp.expense[i].whoPaid[j];
        totalExp += widget.grp.expense[i].whoPaid[j];
        whoBought[j] += widget.grp.expense[i].whoBought[j];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    func();
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Text(
            totalExp.toString(),
            style: Globals.numHeadingTextStyle,
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: widget.grp.grpContacts.length,
              itemBuilder: (BuildContext context, int index) {
                Contacts con = widget.grp.grpContacts[index];
                return Card(
                  child: ListTile(
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
                    trailing: Column(
                      children: [
                        Text(
                          whoPaid[index].toString(),
                          style: Globals.numPaidTextStyle,
                        ),
                        Text(
                          whoBought[index].toString(),
                          style: Globals.numBoughtTextStyle,
                        ),
                      ],
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
