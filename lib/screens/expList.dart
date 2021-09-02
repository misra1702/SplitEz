import 'package:bill1/globals.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          grp.grpName,
          style: Globals.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      body: ExpListBody(
        grp: grp,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
  const ExpListBody({Key? key, required this.grp}) : super(key: key);
  final Group grp;
  @override
  _ExpListBodyState createState() => _ExpListBodyState();
}

class _ExpListBodyState extends State<ExpListBody> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Group>('GrpDb');
    if (widget.grp.expense.isEmpty) {
      return Center(
        child: Text("Click + to add new expense."),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [],
    );
  }
}
