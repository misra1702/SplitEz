import 'dart:math';

import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpDetail extends StatefulWidget {
  const ExpDetail({Key? key}) : super(key: key);

  @override
  _ExpDetailState createState() => _ExpDetailState();
}

class _ExpDetailState extends State<ExpDetail> {
  @override
  Widget build(BuildContext context) {
    print("Inside ExpDetail");
    String name = context.read<Glist>().cExp.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: Globals.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ExpDetailBody(),
    );
  }
}

class ExpDetailBody extends StatefulWidget {
  const ExpDetailBody({Key? key}) : super(key: key);

  @override
  _ExpDetailBodyState createState() => _ExpDetailBodyState();
}

class _ExpDetailBodyState extends State<ExpDetailBody> {
  @override
  Widget build(BuildContext context) {
    Expenses cExp = context.read<Glist>().cExp;
    Group cGrp = context.read<Glist>().cGrp;
    List<int> indices = [];
    for (int i = 0; i < cGrp.grpContacts.length; i++) {
      if (cExp.whoPaid[i] > 0 || cExp.whoBought[i] > 0) {
        indices.add(i);
      }
    }
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
                style: Globals.bodyLargeTextStyle.copyWith(fontSize: 35),
              ),
              Text(
                cExp.amount.toString(),
                style: Globals.numHeadingTextStyle,
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: indices.length,
              itemBuilder: (BuildContext context, int index) {
                Contacts con = cGrp.grpContacts[indices[index]];
                MaterialColor netAmountColor = Colors.teal;
                double netAmount = cExp.whoPaid[indices[index]] -
                    cExp.whoBought[indices[index]];
                if (netAmount < 0) netAmountColor = Colors.red;
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
                    trailing: Column(
                      children: [
                        Text(
                          cExp.whoPaid[indices[index]].toStringAsFixed(2),
                          style: Globals.numPaidTextStyle,
                        ),
                        Text(
                          cExp.whoBought[indices[index]].toStringAsFixed(2),
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
