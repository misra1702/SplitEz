import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AskExp extends StatefulWidget {
  const AskExp({Key? key}) : super(key: key);

  @override
  _AskExpState createState() => _AskExpState();
}

class _AskExpState extends State<AskExp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Add Expense",
            style: Globals.appBarTextStyle,
          ),
          centerTitle: true,
        ),
        body: ExpensesBody(),
      ),
    );
  }
}

class ExpensesBody extends StatefulWidget {
  const ExpensesBody({Key? key}) : super(key: key);

  @override
  _ExpensesBodyState createState() => _ExpensesBodyState();
}

class _ExpensesBodyState extends State<ExpensesBody> {
  String whoPaid = "No One";
  void func(String a) {
    setState(() {
      whoPaid = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    Expenses cExp = context.watch<Glist>().cExp;
    Group cGrp = context.read<Glist>().cGrp;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(20),
      children: [
        titleExp(context),
        SizedBox(height: 20),
        amountExp(context, cExp),
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              "Who Paid ?",
              style: GoogleFonts.kreon(fontSize: 24),
            ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: cExp.whoPaid.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container();
            //     },
            //   ),
            // ),
            SizedBox(
              width: 30,
            ),
            PopupMenuButton(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              offset: Offset(100, 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onSelected: (a) {
                func(a.toString());
              },
              onCanceled: () {
                print("No one");
              },
              color: Colors.teal,
              itemBuilder: (context) {
                return cGrp.grpContacts.map(
                  (e) {
                    return PopupMenuItem(
                      child: Text(e.name),
                      textStyle: GoogleFonts.kreon(
                        fontSize: 22,
                      ),
                      value: e.name,
                    );
                  },
                ).toList();
              },
            ),
          ],
        ),
        submitButton(cExp, context),
      ],
    );
  }

  ElevatedButton submitButton(Expenses cExp, BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Submit",
        style: GoogleFonts.kreon(fontSize: 30),
      ),
      style: Globals.btnst,
      onPressed: () {
        if (double.tryParse(cExp.amount) == null || cExp.amount == "") {
          SnackBar e = SnackBar(
            content: Text('Amount should be a number'),
          );
          ScaffoldMessenger.of(context).showSnackBar(e);
        }
      },
    );
  }

  TextField amountExp(BuildContext context, Expenses cExp) {
    return TextField(
      cursorColor: Colors.teal,
      decoration: InputDecoration(
        labelText: 'Amount',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.teal,
            width: 4,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onChanged: (a) {
        context.read<Glist>().setAmount(a);
        print(cExp.amount);
      },
      style: GoogleFonts.kreon(fontSize: 24),
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    );
  }

  TextField titleExp(BuildContext context) {
    return TextField(
      key: GlobalKey(),
      autocorrect: false,
      cursorColor: Colors.teal,
      style: GoogleFonts.kreon(
        fontSize: 24,
      ),
      decoration: InputDecoration(
        labelText: 'Title',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.teal,
            width: 4,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      ),
      onChanged: (a) {
        context.read<Glist>().setTitle(a);
      },
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
    );
  }
}
