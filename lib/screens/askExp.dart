import 'package:bill1/globals.dart';
import 'package:bill1/models/cnGroup.dart';
import 'package:bill1/models/group.dart';
import 'package:bill1/widgets/askWhoBoughtAmount.dart';
import 'package:bill1/widgets/askWhoPaidAmount.dart';
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
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Expenses cExp = context.watch<CNGroup>().cExp;
    Group cGrp = context.watch<CNGroup>().cGrp;
    var contactId = cGrp.grpContacts.keys.toList();
    print("Inside askExp and grpName is ${cGrp.grpName}");

    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        titleExp(),
        SizedBox(height: 20),
        amountExp(context),
        SizedBox(height: 20),
        WhoPaidList(
            context: context, cExp: cExp, cGrp: cGrp, contactId: contactId),
        SizedBox(height: 20),
        WhoBoughtList(
            context: context, cExp: cExp, cGrp: cGrp, contactId: contactId),
        SizedBox(height: 30),
        SubmitButton(
            amountController: amountController,
            titleController: titleController,
            cGrp: cGrp,
            cExp: cExp,
            context: context,
            contactId: contactId),
      ],
    );
  }

  TextField amountExp(BuildContext context) {
    return TextField(
      key: GlobalKey(),
      maxLength: Globals.textFieldLength,
      controller: amountController,
      autocorrect: false,
      cursorColor: Theme.of(context).primaryColor,
      style: Globals.textFieldAskStyle,
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
      controller: titleController,
      key: GlobalKey(),
      autocorrect: false,
      cursorColor: Colors.teal,
      style: Globals.textFieldAskStyle,
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
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.amountController,
    required this.titleController,
    required this.cGrp,
    required this.cExp,
    required this.context,
    required this.contactId,
  }) : super(key: key);

  final TextEditingController amountController;
  final TextEditingController titleController;
  final Group cGrp;
  final Expenses cExp;
  final BuildContext context;
  final List<int> contactId;

  @override
  Widget build(BuildContext context) {
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
        var contactId = cGrp.grpContacts.keys.toList();
        for (int i = 0; i < cGrp.grpContacts.length; i++) {
          int id = contactId[i];
          if (cExp.whoPaid[i] != double.infinity) {
            whoPaidVal += cExp.whoPaid[i] ?? 0;
          } else
            infPaid = id;
          if (cExp.whoBought[i] != double.infinity) {
            whoBoughtVal += cExp.whoBought[id] ?? 0;
          } else
            infBought = id;
        }
        if (double.tryParse(amountController.text) == null) {
          st = "Enter valid amount";
        } else if (double.parse(amountController.text) == 0) {
          st = "Amount cann't be 0";
        }
        if (st != "") {
          SnackBar e = SnackBar(content: Text(st));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(e);
          return;
        }

        amount = double.parse(amountController.text);
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
        if (infPaid != -1) {
          context.read<CNGroup>().addWhoPaid(infPaid, leftPaidAmount);
        }
        if (infBought != -1) {
          context.read<CNGroup>().addWhoBought(infBought, leftBoughtAmount);
        } else if (whoBoughtVal == 0) {
          double tempVal = amount / cGrp.grpContacts.length;
          for (int i = 0; i < cGrp.grpContacts.length; i++) {
            int id = contactId[i];
            context.read<CNGroup>().addWhoBought(id, tempVal);
          }
        }
        context.read<CNGroup>().setAmount(amount);
        context.read<CNGroup>().setExpenseTitle(titleController.text);
        context.read<CNGroup>().addExpense(cExp);
        Navigator.of(context).pop();
      },
    );
  }
}

class WhoPaidList extends StatefulWidget {
  const WhoPaidList({
    Key? key,
    required this.context,
    required this.cExp,
    required this.cGrp,
    required this.contactId,
  }) : super(key: key);

  final BuildContext context;
  final Expenses cExp;
  final Group cGrp;
  final List<int> contactId;

  @override
  _WhoPaidListState createState() => _WhoPaidListState();
}

class _WhoPaidListState extends State<WhoPaidList> {
  @override
  Widget build(BuildContext context) {
    var indices = widget.cExp.whoPaid.keys.toList();
    print(indices);
    print("whoPaidList length is ${indices.length}");
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
        onSelected: (int id) {
          if (indices.length == 0) {
            context.read<CNGroup>().addWhoPaid(id, double.infinity);
            return;
          }
          showDialog(
            context: context,
            builder: (context) {
              return AskWhoPaidAmount(
                index: id,
              );
            },
          );
        },
        onCanceled: () {
          print("Selecting who paid cancelled\n");
        },
        color: Colors.teal,
        itemBuilder: (context) {
          return widget.cGrp.grpContacts.entries.toList().map((e) {
            return PopupMenuItem(
              child: Text(e.value.name),
              textStyle: GoogleFonts.kreon(
                fontSize: 22,
              ),
              value: e.key,
            );
          }).toList();
        });

    if (indices.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [txt, SizedBox(width: 30), popUp],
      );
    }
    var cList = Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: indices.length,
        itemBuilder: (context, index) {
          String name = widget.cGrp.grpContacts[indices[index]]?.name ?? "";
          double temp = widget.cExp.whoPaid[indices[index]] ?? 0;
          String amount = temp.toString();
          if (temp == double.infinity) {
            amount = "Left Amount";
          }
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(5),
            shadowColor: Theme.of(context).primaryColor,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                key: ValueKey(index),
                title: Text(
                  name,
                  style: GoogleFonts.kreon(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  amount,
                  style: GoogleFonts.kreon(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    context.read<CNGroup>().deleteWhoPaid(indices[index]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [txt, popUp],
        ),
        cList,
      ],
    );
  }
}

class WhoBoughtList extends StatefulWidget {
  const WhoBoughtList({
    Key? key,
    required this.context,
    required this.cExp,
    required this.cGrp,
    required this.contactId,
  }) : super(key: key);

  final BuildContext context;
  final Expenses cExp;
  final Group cGrp;
  final List<int> contactId;

  @override
  _WhoBoughtListState createState() => _WhoBoughtListState();
}

class _WhoBoughtListState extends State<WhoBoughtList> {
  @override
  Widget build(BuildContext context) {
    List<int> indices = [];
    for (int i = 0; i < widget.cGrp.grpContacts.length; i++) {
      int id = widget.contactId[i];
      double val = widget.cExp.whoBought[id] ?? 0;
      if (val > 0) indices.add(id);
    }
    var txt = Text(
      "Who Bought?",
      style: Globals.bodyLargeTextStyle,
    );
    var txt2 = Text(
      "Everyone?",
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
      onSelected: (int index) {
        if (indices.length == 0) {
          context.read<CNGroup>().addWhoBought(index, double.infinity);
          return;
        }
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
        return widget.cGrp.grpContacts.entries.map(
          (e) {
            return PopupMenuItem(
              child: Text(e.value.name),
              textStyle: GoogleFonts.kreon(
                fontSize: 22,
              ),
              value: e.key,
            );
          },
        ).toList();
      },
    );

    if (indices.length == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [txt, SizedBox(width: 30), txt2, SizedBox(width: 30), popUp],
      );
    }
    var cList = Container(
      height: MediaQuery.of(context).size.height / 4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        itemCount: indices.length,
        itemBuilder: (context, index) {
          String name = widget.cGrp.grpContacts[indices[index]]?.name ?? "";
          double temp = widget.cExp.whoBought[indices[index]] ?? 0;
          String amount = temp.toString();
          if (temp == double.infinity) {
            amount = "Left amount";
          }
          return Card(
            key: ValueKey(index),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: EdgeInsets.all(2),
            child: ListTile(
              title: Text(
                name,
                style: GoogleFonts.kreon(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                amount,
                style: GoogleFonts.kreon(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  context.read<CNGroup>().deleteWhoBought(indices[index]);
                },
              ),
            ),
          );
        },
      ),
    );
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [txt, popUp],
        ),
        cList,
      ],
    );
  }
}
