import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askGrpName.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          style: Globals.appBarTextStyle,
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
  @override
  Widget build(BuildContext context) {
    var box = context.watch<Glist>().box;
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
        return Card(
          key: ValueKey(grp),
          elevation: 10,
          margin: EdgeInsets.all(10),
          color: Colors.teal,
          child: ListTile(
            leading: Icon(
              Icons.list,
              color: Colors.white,
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/expList', arguments: grp);
            },
            trailing: IconButton(
              onPressed: () {
                context.read<Glist>().deleteGrp(grp);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            title: Text(
              grp.grpName,
              style: GoogleFonts.kreon(
                color: Colors.white,
                fontSize: 24,
              ),
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
