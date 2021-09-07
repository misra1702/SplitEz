import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpList extends StatefulWidget {
  const ExpList({
    Key? key,
  }) : super(key: key);

  @override
  _ExpListState createState() => _ExpListState();
}

class _ExpListState extends State<ExpList> {
  @override
  Widget build(BuildContext context) {
    final Group grp = ModalRoute.of(context)?.settings.arguments as Group;
    context.read<Glist>().openGrp = grp;
    Group cGrp = context.watch<Glist>().cGrp;

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
              Navigator.of(context).pushNamed('/grpInfo', arguments: grp);
            },
          ),
        ],
      ),
      body: ExpListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Glist>().openNewExpense();
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
    var cGrp = context.watch<Glist>().cGrp;
    if (cGrp.expense.isEmpty) {
      return Center(
        child: Text("Click + to add new expense."),
      );
    }
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: cGrp.expense.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(title: Text(cGrp.expense[index].title));
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider();
            },
          ),
        ),
      ],
    );
  }
}
