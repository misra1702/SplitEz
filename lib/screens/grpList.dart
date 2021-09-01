import 'package:bill1/globals.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askGrpName.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';

class GrpList extends StatefulWidget {
  const GrpList({Key? key}) : super(key: key);

  @override
  _GrpListState createState() => _GrpListState();
}

class _GrpListState extends State<GrpList> {
  void askPermission() async {
    var status = await Permission.contacts.status;
    print(status);
    if (status.isDenied) {
      status = await Permission.contacts.request();
      print(status);
    }
    if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Bill Splitter",
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AskGrpName();
              });
        },
        child: Icon(
          Icons.add,
        ),
      ),
      body: GrpListBody(),
    );
  }
}

class GrpListBody extends StatefulWidget {
  const GrpListBody({Key? key}) : super(key: key);

  @override
  _GrpListBodyState createState() => _GrpListBodyState();
}

class _GrpListBodyState extends State<GrpListBody> {
  var box = Hive.box<Group>('grplist');
  @override
  Widget build(BuildContext context) {
    if (box.isEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: Text(
            "Create a new Group!!",
            style: GoogleFonts.kreon(
              fontSize: 30,
            ),
          ),
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(color: Colors.black),
          ),
        ),
      );
    }
    return ListView.separated(
      itemCount: box.length,
      itemBuilder: (BuildContext context, int index) {
        return MakeCards(
          grp: box.getAt(index) as Group,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}

class MakeCards extends StatefulWidget {
  const MakeCards({Key? key, required this.grp}) : super(key: key);
  final Group grp;
  @override
  _MakeCardsState createState() => _MakeCardsState();
}

class _MakeCardsState extends State<MakeCards> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box<Group>('grpList');
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      color: Colors.teal,
      child: ListTile(
        leading: CircleAvatar(),
        trailing: IconButton(
          onPressed: () {
              box.delete(widget.grp.grpName);
          },
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        title: Text(
          widget.grp.grpName,
          style: GoogleFonts.kreon(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
