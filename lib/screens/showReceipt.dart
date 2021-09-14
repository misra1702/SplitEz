import 'dart:io';

import 'package:bill1/api/pdfGen.dart';
import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';
import 'package:provider/provider.dart';

class ShowReceipt extends StatefulWidget {
  const ShowReceipt({Key? key}) : super(key: key);

  @override
  _ShowReceiptState createState() => _ShowReceiptState();
}

class _ShowReceiptState extends State<ShowReceipt> {
  @override
  Widget build(BuildContext context) {
    Group cGrp = context.watch<CNGroup>().cGrp;
    print("Inside showReceipt and grpName is : ${cGrp.grpName}");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: Globals.appBarIconSize,
          ),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/grpInfo'));
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
              Icons.share,
              size: Globals.appBarIconSize,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ShowReceiptBody(),
    );
  }
}

class ShowReceiptBody extends StatefulWidget {
  const ShowReceiptBody({Key? key}) : super(key: key);

  @override
  _ShowReceiptBodyState createState() => _ShowReceiptBodyState();
}

class _ShowReceiptBodyState extends State<ShowReceiptBody> {
  late Group grp;
  Future<Widget> func() async {
    File pdf = await PdfGen.generate(grp);
    print(pdf.path);
    final pdfController =
        PdfController(document: PdfDocument.openFile(pdf.path));
    Widget pdfView = PdfView(
      controller: pdfController,
    );
    return pdfView;
  }

  @override
  Widget build(BuildContext context) {
    grp = context.read<CNGroup>().cGrp;
    func();
    return FutureBuilder(
      future: func(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return snapshot.data as Widget;
        }
        return Container();
      },
    );
  }
}
