import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:glamworl_it_income_expenditure/model/income_expense_model.dart';
import 'package:glamworl_it_income_expenditure/screens/view_pdf.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SavePdf {
  final pdf = pw.Document();

  void writeOnPdf(
      List<IncomeExpenseModel> incomeDataList,
      List<IncomeExpenseModel> expenseDataList,
      double totalIncome,
      double totalExpense,
      double balance) async {
    var data = await rootBundle.load("fonts/kalpurush.ttf");
    var myFont = pw.Font.ttf(data);
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            pw.Header(
                level: 0,
                child: pw.Text('Invoice',
                    style: pw.TextStyle(
                      color: PdfColor.fromHex('6a93cb'),
                      fontSize: 36,
                      fontWeight: pw.FontWeight.bold,
                    )),
                outlineColor: PdfColor.fromHex('6a93cb'),
                margin: const pw.EdgeInsets.only(bottom: 10)),
            pw.Paragraph(
                text: 'Income Details',
                style: const pw.TextStyle(
                  fontSize: 24,
                )),
            pw.Column(children: [
              pw.Container(
                color: PdfColor.fromHex('BEBEBE'),
                padding: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Date',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              )))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Description',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              )))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Amount',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ))))
                ]),
              ),
              pw.SizedBox(height: 4.0),
              pw.ListView.builder(
                  itemBuilder: (context, index) {
                    DateTime miliDate = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(incomeDataList[index].date));
                    var format = DateFormat("yMMMd").add_jm();
                    String finalDate = format.format(miliDate);
                    return pw.Column(children: [
                      pw.Row(children: [
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(finalDate,
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(
                                      fontSize: 16,
                                    )))),
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    incomeDataList[index].description,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 16, font: myFont)))),
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(incomeDataList[index].amount,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 16, font: myFont))))
                      ]),
                      pw.SizedBox(height: 4.0),
                    ]);
                  },
                  itemCount: incomeDataList.length),
            ]),
            pw.SizedBox(height: 5.0),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  padding:
                      const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  color: PdfColor.fromHex('BEBEBE'),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Total income: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 16),
                      ),
                      pw.Text(
                        '$totalIncome Tk.',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 15.0),
            pw.Paragraph(
                text: 'Total Expense',
                style: const pw.TextStyle(
                  fontSize: 24,
                )),
            pw.Column(children: [
              pw.Container(
                color: PdfColor.fromHex('BEBEBE'),
                padding: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Row(children: [
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Date',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              )))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Description',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              )))),
                  pw.Expanded(
                      child: pw.Container(
                          alignment: pw.Alignment.center,
                          child: pw.Text('Amount',
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 16,
                              ))))
                ]),
              ),
              pw.SizedBox(height: 4.0),
              pw.ListView.builder(
                  itemBuilder: (context, index) {
                    DateTime miliDate = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(expenseDataList[index].date));
                    var format = DateFormat("yMMMd").add_jm();
                    String finalDate = format.format(miliDate);
                    return pw.Column(children: [
                      pw.Row(children: [
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(finalDate,
                                    textAlign: pw.TextAlign.center,
                                    style: const pw.TextStyle(
                                      fontSize: 16,
                                    )))),
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(
                                    expenseDataList[index].description,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 16, font: myFont)))),
                        pw.Expanded(
                            child: pw.Container(
                                alignment: pw.Alignment.center,
                                child: pw.Text(expenseDataList[index].amount,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        fontSize: 16, font: myFont))))
                      ]),
                      pw.SizedBox(height: 4.0),
                    ]);
                  },
                  itemCount: expenseDataList.length),
            ]),
            pw.SizedBox(height: 5.0),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Container(
                  padding:
                  const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  color: PdfColor.fromHex('BEBEBE'),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Total Expense: ',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 16),
                      ),
                      pw.Text(
                        '$totalExpense Tk.',
                        style: const pw.TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            pw.SizedBox(height: 20.0),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Balance: ',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 16),
                ),
                pw.Text(
                  '$balance Tk.',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 16),
                )
              ]
            )
          ];
        }));
  }

  Future savePdf(
      List<IncomeExpenseModel> dataList,
      List<IncomeExpenseModel> expenseDataList,
      double totalIncome,
      double totalExpense,
      double balance) async {
    writeOnPdf(dataList, expenseDataList, totalIncome, totalExpense, balance);
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File('$documentPath/demo_pdf.pdf');
    // ignore: avoid_print
    print('pdf path = $documentPath/demo_pdf.pdf');
    file.writeAsBytes(await pdf.save()).then((value) {
      Get.to(() => ViewPdf(
            path: '$documentPath/demo_pdf.pdf',
          ));
    });
  }
}
