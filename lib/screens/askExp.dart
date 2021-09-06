import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askAmountPaid.dart';
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
  @override
  Widget build(BuildContext context) {
    Expenses cExp = context.watch<Glist>().cExp;
    Group cGrp = context.read<Glist>().cGrp;

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        titleExp(context),
        SizedBox(height: 20),
        amountExp(context, cExp),
        SizedBox(height: 20),
        whoPaid(context, cExp, cGrp),
        SizedBox(height: 30),
        submitButton(cExp, context),
      ],
    );
  }

  Row whoPaid(BuildContext context, Expenses cExp, Group cGrp) {
    var txt = Text(
      "Who Paid ?",
      style: GoogleFonts.kreon(fontSize: 24),
    );
    var popUp = PopupMenuButton(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.teal,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
      offset: Offset(100, 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (Contacts a) {
        showDialog(
            context: context,
            builder: (context) {
              return AskAmountPaid(name: a);
            });
      },
      onCanceled: () {
        print("Selecting who paid cancelled\n");
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
              value: e,
            );
          },
        ).toList();
      },
    );

    if (cExp.whoPaid.length == 0) {
      return Row(
        children: [txt, SizedBox(width: 30), popUp],
      );
    }
    var keys = cExp.whoPaid.keys.toList();
    var cList = Container(
      height: 200,
      width: 150,
      child: ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.teal,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    keys[index].name,
                    style: GoogleFonts.kreon(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    cExp.whoPaid[keys[index]] ?? "",
                    style: GoogleFonts.kreon(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [txt, cList, popUp],
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
        context.read<Glist>().setAmount = a;
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
