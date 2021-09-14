import 'dart:io';

import 'package:bill1/models/group.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfGen {
  static Future<File> generate(Group grp) {
    final pdf = Document();
    var contactId = grp.grpContacts.keys.toList();
    var contactName = grp.grpContacts.values.toList();
    var grpExpenses = grp.grpExpenses.values.toList();
    Map<int, double> whoPaid = {};
    Map<int, double> whoBought = {};
    double total = 0;
    for (int i = 0; i < contactId.length; i++) {
      int id = contactId[i];
      for (int j = 0; j < grpExpenses.length; j++) {
        whoPaid[id] = (whoPaid[id] ?? 0) + (grpExpenses[j].whoPaid[id] ?? 0);
        whoBought[id] =
            (whoBought[id] ?? 0) + (grpExpenses[j].whoBought[id] ?? 0);
        total += whoPaid[i] ?? 0;
      }
    }

    pdf.addPage(
      MultiPage(
        build: (context) {
          List<Widget> a = [
            Center(
              child: Text(
                grp.grpName,
                style: TextStyle(
                  fontSize: 30,
                  color: PdfColors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
                child: Text(
              "Expenditure: " + total.toStringAsFixed(2),
              style: TextStyle(fontSize: 30),
            )),
            // Divider(thickness: 20, color: PdfColors.grey300),
            SizedBox(height: 50),
            Table.fromTextArray(
              border: null,
              cellAlignment: Alignment.center,
              cellStyle: TextStyle(fontSize: 20),
              headerStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              headerAlignment: Alignment.center,
              headerDecoration: BoxDecoration(
                color: PdfColors.grey300,
              ),
              headers: [
                "Name",
                "Purchase",
                "Expenditure",
                "Net",
              ],
              data: contactId.map((id) {
                double whoPaidVal = whoPaid[id] ?? 0.0;
                double whoBoughtVal = whoBought[id] ?? 0.0;
                double total = whoPaidVal - whoBoughtVal;
                String name = grp.grpContacts[id]?.name ?? "NA";

                return [
                  name,
                  whoBoughtVal.toStringAsFixed(1),
                  whoPaidVal.toStringAsFixed(1),
                  total.toStringAsFixed(1),
                ];
              }).toList(),
            ),
          ];
          return a;
        },
      ),
    );

    return saveDocument(name: grp.grpName + ".pdf", pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);

    return file;
  }
}
