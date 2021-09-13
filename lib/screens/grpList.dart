import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askGroupDelete.dart';
import 'package:bill1/widgets/askGrpName.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

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
    // if (status.isPermanentlyDenied) {
    //   openAppSettings();
    // }
  }

  @override
  void initState() {
    super.initState();
    askPermission();
  }

  @override
  void dispose() {
    super.dispose();
    var box = Hive.box<Group>("GrpDb");
    box.close();
  }

  @override
  Widget build(BuildContext context) {
    print("Inside grpList");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bill Splitter",
          style: Globals.appBarTextStyle,
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CNGroup>().openNewGroup();
          showDialog(
            context: context,
            builder: (context) {
              return AskGrpName();
            },
          );
        },
        child: Icon(
          Icons.add,
          size: Globals.appBarIconSize,
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
  @override
  Widget build(BuildContext context) {
    var box = context.watch<CNGroup>().box;
    if (box.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Groups",
              style: GoogleFonts.kreon(
                fontSize: 25,
              ),
            ),
            Text(
              "Click + to add new Group",
              style: GoogleFonts.kreon(
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: box.length,
      itemBuilder: (BuildContext context, int index) {
        Group grp = box.getAt(index)!;
        double t = 10, b = 10, l = 10, r = 10;
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
          key: ValueKey(grp),
          child: ListTile(
            contentPadding: EdgeInsets.all(5),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.list,
                color: Colors.white,
                size: Globals.appBarIconSize,
              ),
            ),
            onTap: () {
              context.read<CNGroup>().openGrp(grp.grpName);
              Navigator.of(context).pushNamed('/expList');
            },
            trailing: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AskGroupDelete(name: grp.grpName);
                  },
                );
              },
              icon: Icon(
                Icons.delete_outline,
                color: Colors.white,
                size: Globals.appBarIconSize,
              ),
            ),
            title: Text(
              grp.grpName,
              style: Globals.cardTextStyle,
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );
  }
}
