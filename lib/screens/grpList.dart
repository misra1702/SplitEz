import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/grpCreate');
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
