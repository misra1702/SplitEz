import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpList extends StatefulWidget {
  const ExpList({Key? key}) : super(key: key);

  @override
  _ExpListState createState() => _ExpListState();
}

class _ExpListState extends State<ExpList> {
  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<CNGroup>().cGrp;
    print("Inside expList and grpName is : ${cGrp.grpName}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Globals.appBarIconSize,
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/grpList'));
          },
        ),
        title: Text(
          cGrp.grpName,
          style: Globals.appBarTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.info_outline,
              size: Globals.appBarIconSize,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/grpInfo', arguments: cGrp.grpName);
            },
          ),
        ],
      ),
      body: ExpListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CNGroup>().openNewExpense();
          Navigator.of(context).pushNamed('/askExp');
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

class ExpListBody extends StatefulWidget {
  const ExpListBody({Key? key}) : super(key: key);
  @override
  _ExpListBodyState createState() => _ExpListBodyState();
}

class _ExpListBodyState extends State<ExpListBody> {
  @override
  Widget build(BuildContext context) {
    var exp = context.watch<CNGroup>().cGrp.grpExpenses.entries.toList();

    if (exp.isEmpty) {
      return Center(
        child: Text("Click + to add new expense."),
      );
    }
    print("Expenses length is:" + exp.length.toString());

    return ListView.builder(
      itemCount: exp.length,
      itemBuilder: (BuildContext context, int index) {
        int id = exp[index].key;
        String name = exp[index].value.title;
        String amount = exp[index].value.amount.toString();
        double t = 10, b = 10, l = 10, r = 10;
        if (name == "") name = "No title";
        if (index == 0) t = 30;
        return Card(
          elevation: 10,
          margin: EdgeInsets.fromLTRB(l, t, r, b),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: Colors.yellow,
              width: 2,
            ),
          ),
          shadowColor: Theme.of(context).primaryColor,
          child: ListTile(
            onTap: () {
              context.read<CNGroup>().setcExp(exp[index].value);
              Navigator.of(context).pushNamed('/expDetail');
            },
            title: Text(
              name,
              style: Globals.cardTextStyle,
            ),
            subtitle: Text(
              amount,
              style: Globals.numHeadingTextStyle.copyWith(
                color: Colors.yellow,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: Globals.appBarIconSize,
              ),
              onPressed: () {
                context.read<CNGroup>().delExpense(id);
              },
            ),
          ),
        );
      },
    );
  }
}
