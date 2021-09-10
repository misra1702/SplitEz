import 'package:bill1/globals.dart';
import 'package:bill1/main.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askWhoBoughtAmount.dart';
import 'package:bill1/widgets/askWhoPaidAmount.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
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
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Expenses cExp = context.watch<Glist>().cExp;
    Group cGrp = context.watch<Glist>().cGrp;

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        titleExp(),
        SizedBox(height: 20),
        amountExp(context),
        SizedBox(height: 20),
        whoPaid(context, cExp, cGrp),
        SizedBox(height: 20),
        whoBought(context, cExp, cGrp),
        SizedBox(height: 30),
        submitButton(cGrp, cExp, context),
      ],
    );
  }

  ElevatedButton submitButton(Group cGrp, Expenses cExp, BuildContext context) {
    return ElevatedButton(
      child: Text(
        "Submit",
        style: GoogleFonts.kreon(fontSize: 30),
      ),
      style: Globals.btnst,
      onPressed: () {
        String st = "";
        double whoPaidVal = 0;
        double whoBoughtVal = 0;
        int infPaid = -1;
        int infBought = -1;
        double amount = 0;
        for (int i = 0; i < cGrp.grpContacts.length; i++) {
          if (cExp.whoPaid[i] != double.infinity) {
            whoPaidVal += cExp.whoPaid[i];
          } else
            infPaid = i;
          if (cExp.whoBought[i] != double.infinity) {
            whoBoughtVal += cExp.whoBought[i];
          } else
            infBought = i;
        }
        if (double.tryParse(_amount.text) == null) {
          st = "Enter valid amount";
        } else if (double.parse(_amount.text) == 0) {
          st = "Amount cann't be 0";
        }
        if (st != "") {
          SnackBar e = SnackBar(content: Text(st));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(e);
          return;
        }
        amount = double.parse(_amount.text);
        double leftPaidAmount = amount - whoPaidVal;
        if (leftPaidAmount < 0) {
          st = "Paid value can't be greater than total amount";
        } else if (leftPaidAmount > 0 && infPaid == -1) {
          st = "Total amount can't be greater than paid value";
        }
        if (st != "") {
          SnackBar e = SnackBar(content: Text(st));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(e);
          return;
        }
        double leftBoughtAmount = amount - whoBoughtVal;
        if (leftBoughtAmount < 0) {
          st = "Bought value can't be greater than total amount";
        } else if (leftBoughtAmount > 0 &&
            infBought == -1 &&
            whoBoughtVal != 0) {
          st = "Total amount can't be greater than bought value";
        }
        if (st != "") {
          SnackBar e = SnackBar(content: Text(st));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(e);
          return;
        }

        context.read<Glist>().addWhoPaid(infPaid, leftPaidAmount);
        if (whoBoughtVal == 0) {
          double tempVal = amount / cGrp.grpContacts.length;
          for (int i = 0; i < cGrp.grpContacts.length; i++) {
            context.read<Glist>().addWhoBought(i, tempVal);
          }
        } else {
          context.read<Glist>().addWhoBought(infBought, leftBoughtAmount);
        }
        context.read<Glist>().setAmount(amount);
        context.read<Glist>().setExpenseTitle(_title.text);
        context.read<Glist>().addExpense();
        Navigator.of(context).pop();
      },
    );
  }

  TextField amountExp(BuildContext context) {
    return TextField(
      key: GlobalKey(),
      maxLength: Globals.textFieldLength,
      controller: _amount,
      autocorrect: false,
      cursorColor: Theme.of(context).primaryColor,
      style: Globals.textFieldStyle,
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
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
    );
  }

  TextField titleExp() {
    return TextField(
      controller: _title,
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
      keyboardType: TextInputType.text,
      textAlign: TextAlign.center,
    );
  }

  Row whoPaid(BuildContext context, Expenses cExp, Group cGrp) {
    List<int> indices = [];
    for (int i = 0; i < cExp.whoPaid.length; i++) {
      if (cExp.whoPaid[i] > 0) indices.add(i);
    }
    var txt = Text(
      "Who Paid ?",
      style: Globals.bodyLargeTextStyle,
    );
    var popUp = PopupMenuButton(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: Globals.appBarIconSize,
        ),
      ),
      offset: Offset(100, 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (Contacts a) {
        int index = cGrp.grpContacts.indexOf(a);
        if (indices.length == 0) {
          context.read<Glist>().addWhoPaid(index, double.infinity);
          return;
        }
        showDialog(
            context: context,
            builder: (context) {
              return AskWhoPaidAmount(
                index: index,
              );
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

    if (indices.length == 0) {
      return Row(
        children: [txt, SizedBox(width: 30), popUp],
      );
    }
    print(indices.length.toString());
    var cList = Container(
      height: 200,
      width: 150,
      child: ListView.builder(
        itemCount: indices.length,
        itemBuilder: (context, index) {
          String name = cGrp.grpContacts[indices[index]].name;
          double temp = cExp.whoPaid[indices[index]];
          String amount = temp.toString();
          if (temp == double.infinity) {
            amount = "Left Amount";
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(2),
            shadowColor: Theme.of(context).primaryColor,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.kreon(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    amount,
                    style: GoogleFonts.kreon(
                      fontSize: 20,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [txt, cList, popUp],
    );
  }

  Row whoBought(BuildContext context, Expenses cExp, Group cGrp) {
    List<int> indices = [];
    for (int i = 0; i < cGrp.grpContacts.length; i++) {
      if (cExp.whoBought[i] > 0) indices.add(i);
    }
    var txt = Text(
      "Who Bought?",
      style: Globals.bodyLargeTextStyle,
    );
    var txt2 = Text(
      "Everyone",
      style: Globals.bodyTextStyle,
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
          size: Globals.appBarIconSize,
        ),
      ),
      offset: Offset(100, 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onSelected: (Contacts a) {
        int index = cGrp.grpContacts.indexOf(a);
        if (indices.length == 0) {
          context.read<Glist>().addWhoBought(index, double.infinity);
          return;
        }
        // SnackBar e = SnackBar(
        //   content: Text(
        //     "Add who paid amount first",
        //     style: Globals.askExpenseSt,
        //   );
        // ScaffoldMessenger.of(context).clearSnackBars();
        // ScaffoldMessenger.of(context).showSnackBar(e);
        // return;
        showDialog(
          context: context,
          builder: (context) {
            return AskWhoBoughtAmount(
              index: index,
            );
          },
        );
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

    if (indices.length == 0) {
      return Row(
        children: [txt, SizedBox(width: 30), txt2, SizedBox(width: 30), popUp],
      );
    }
    var cList = Container(
      height: 200,
      width: 150,
      child: ListView.builder(
        itemCount: indices.length,
        itemBuilder: (context, index) {
          String name = cGrp.grpContacts[indices[index]].name;
          double temp = cExp.whoBought[indices[index]];
          String amount = temp.toString();
          if (temp == double.infinity) {
            amount = "Left amount";
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.kreon(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    amount,
                    style: GoogleFonts.kreon(
                      fontSize: 22,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [txt, cList, popUp],
    );
  }
}
