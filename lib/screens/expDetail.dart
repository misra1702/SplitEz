import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
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
    String name = context.read<CNGroup>().cExp.title;
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
    Expenses cExp = context.read<CNGroup>().cExp;
    Group cGrp = context.read<CNGroup>().cGrp;
    List<int> idVal = [];
    var temp = cExp.whoPaid.keys.toSet();
    temp.addAll(cExp.whoBought.keys);
    idVal = temp.toList();
    print(idVal);
    var cList = cGrp.grpContacts.entries.toList();

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
              itemCount: idVal.length,
              itemBuilder: (BuildContext context, int index) {
                int id = cList[idVal[index]].key;
                Contacts con = cList[id].value;
                double paidVal = cExp.whoPaid[id] ?? 0;
                double boughtVal = cExp.whoBought[id] ?? 0;
                int colorId = (id * 17) % Colors.primaries.length;

                MaterialColor netAmountColor = Colors.teal;
                double netAmount = paidVal - boughtVal;
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
                        backgroundColor: Colors.primaries[colorId],
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
                          paidVal.toStringAsFixed(2),
                          style: Globals.numPaidTextStyle,
                        ),
                        Text(
                          boughtVal.toStringAsFixed(2),
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
