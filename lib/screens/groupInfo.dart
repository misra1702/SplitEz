import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';
import 'package:provider/provider.dart';

class GrpInfo extends StatefulWidget {
  GrpInfo({Key? key}) : super(key: key);

  @override
  _GrpInfoState createState() => _GrpInfoState();
}

class _GrpInfoState extends State<GrpInfo> {
  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<CNGroup>().cGrp;
    print("Inside groupInfo and grpName is ${cGrp.grpName}");
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
  Map<int, double> whoPaid = {};
  Map<int, double> whoBought = {};
  double totalExp = 0;

  void func(Group grp) {
    int expLen = grp.grpExpenses.length;
    var expList = grp.grpExpenses.values.toList();
    var contactId = grp.grpContacts.keys.toList();
    int conLen = grp.grpContacts.length;
    totalExp = 0;
    whoPaid.clear();
    whoBought.clear();
    print("Expenses count is $expLen and contact count is $conLen");
    for (int i = 0; i < conLen; i++) {
      int id = contactId[i];
      for (int j = 0; j < expLen; j++) {
        whoPaid[id] = (whoPaid[id] ?? 0) + (expList[j].whoPaid[id] ?? 0);
        whoBought[id] = (whoBought[id] ?? 0) + (expList[j].whoBought[id] ?? 0);
      }
      totalExp += (whoPaid[id] ?? 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<CNGroup>().cGrp;
    var contactId = cGrp.grpContacts.keys.toList();
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
                int id = contactId[index];
                Contacts con = cGrp.grpContacts[id]!;
                double whoPaidAmount = whoPaid[id] ?? 0;
                double whoBoughtAmount = whoBought[id] ?? 0;
                MaterialColor netAmountColor = Colors.teal;
                double netAmount = whoPaidAmount - whoBoughtAmount;
                int colorId = (id * 17) % Colors.primaries.length;

                print("Name ${con.name} and amount $netAmount");

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
                        backgroundColor: Colors.primaries[colorId],
                        padding: EdgeInsets.all(10),
                      ),
                    ),
                    trailing: Column(
                      children: [
                        Text(
                          whoPaidAmount.toStringAsFixed(2),
                          style: Globals.numPaidTextStyle,
                        ),
                        Text(
                          whoBoughtAmount.toStringAsFixed(2),
                          style: Globals.numBoughtTextStyle,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              onPressed: () {
                print("Tapped on Create Receipt");
                Navigator.of(context).pushNamed('/showReceipt');
              },
              child: Text(
                "Create Receipt",
                style: Globals.appBarTextStyle,
              ),
              style: Globals.btnst,
            ),
          ),
        ],
      ),
    );
  }
}
