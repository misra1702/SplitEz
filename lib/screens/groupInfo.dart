import 'dart:math';

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
    print("Inside groupInfo");
    final String grpName = ModalRoute.of(context)?.settings.arguments as String;
    context.read<Glist>().openGrp(grpName);
    Group cGrp = context.watch<Glist>().cGrp;
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
          cGrp.grpName,
          style: Globals.appBarTextStyle,
        ),
        elevation: 30,
      ),
      body: GrpInfoBody(),
    );
  }
}

class GrpInfoBody extends StatefulWidget {
  GrpInfoBody({Key? key}) : super(key: key);

  @override
  _GrpInfoBodyState createState() => _GrpInfoBodyState();
}

class _GrpInfoBodyState extends State<GrpInfoBody> {
  List<double> whoPaid = [];
  List<double> whoBought = [];
  double totalExp = 0;

  void func(Group grp) {
    int cnt = grp.expense.length;
    int n = grp.grpContacts.length;
    totalExp = 0;
    whoPaid = List<double>.filled(n, 0);
    whoBought = List<double>.filled(n, 0);
    for (int i = 0; i < cnt; i++) {
      for (int j = 0; j < n; j++) {
        whoPaid[j] += grp.expense[i].whoPaid[j];
        totalExp += grp.expense[i].whoPaid[j];
        whoBought[j] += grp.expense[i].whoBought[j];
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<Glist>().cGrp;
    func(cGrp);
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Expense = ",
                style: Globals.bodyLargeTextStyle.copyWith(
                  fontSize: 35,
                ),
              ),
              Text(
                totalExp.toString(),
                style: Globals.numHeadingTextStyle,
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: cGrp.grpContacts.length,
              itemBuilder: (BuildContext context, int index) {
                MaterialColor netAmountColor = Colors.teal;
                double netAmount = whoPaid[index] - whoBought[index];
                if (netAmount < 0) netAmountColor = Colors.red;
                Contacts con = cGrp.grpContacts[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.yellow,
                      width: 2,
                    ),
                  ),
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      "${con.name}",
                      style: Globals.st,
                    ),
                    subtitle: Text(
                      netAmount.toStringAsFixed(2),
                      style: TextStyle(
                        color: netAmountColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      style: TextButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor:
                            Colors.primaries[Random().nextInt(index + 5)],
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          whoPaid[index].toStringAsFixed(2),
                          style: Globals.numPaidTextStyle,
                        ),
                        Text(
                          whoBought[index].toStringAsFixed(2),
                          style: Globals.numBoughtTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
