import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:printing/printing.dart';

class PdfInvoiceApiii extends StatefulWidget {
  PdfInvoiceApiii(this.title, this.theme, {super.key});

  final String title;
  static PosController poscontrollr = PosController();
  final ThemeData theme;
  static Invoice? iinvoicee;
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static int? pails = 0;
  static int? cartons = 0;
  static double? looseTins = 0;
  static double? tonnage = 0;
  static var totalPack;
  @override
  State<PdfInvoiceApiii> createState() => _PdfInvoiceApiiiState();

  static headerContianer() {
    return pw.Container(
      child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          mainAxisSize: pw.MainAxisSize.min,
          children: [
            pw.Container(
                child: pw.Column(
              children: [
                pw.Container(
                    height: 3 * PdfPageFormat.cm,
                    child: pw.Center(
                        child: pw.Text('Tax Invoice',
                            style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 20.0)))),
                pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                          width: 9 * PdfPageFormat.cm,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('Sent To:',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 10.0)),
                                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                                pw.Container(
                                    padding: const pw.EdgeInsets.all(10),
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        width: 1,
                                      ),
                                      shape: pw.BoxShape.rectangle,
                                    ),
                                    child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.spaceBetween,
                                        children: [
                                          pw.Text(
                                              '${iinvoicee!.invoiceMiddle!.customerName}',
                                              style: pw.TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: pw.FontWeight.bold,
                                              )),
                                          pw.SizedBox(
                                              height: 0.2 * PdfPageFormat.cm),
                                          pw.Text(
                                              '${iinvoicee!.headerinfo!.address}',
                                              style: const pw.TextStyle(
                                                fontSize: 10.0,
                                              )),
                                          pw.Container(
                                              child: pw.Row(
                                                  mainAxisAlignment: pw
                                                      .MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                pw.Text('TIN No.:',
                                                    style: const pw.TextStyle(
                                                      fontSize: 10.0,
                                                    )),
                                                pw.Text(
                                                    '${iinvoicee!.headerinfo!.tincode}',
                                                    style: const pw.TextStyle(
                                                      fontSize: 10.0,
                                                    )),
                                              ])),
                                          pw.Row(
                                              mainAxisAlignment: pw
                                                  .MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                pw.Text('VAT Reg. No.:',
                                                    style: const pw.TextStyle(
                                                      fontSize: 10.0,
                                                    )),
                                                pw.Text(
                                                    '${iinvoicee!.headerinfo!.vatNo}',
                                                    style: const pw.TextStyle(
                                                      fontSize: 10.0,
                                                    )),
                                              ]),
                                        ]))
                              ])),
                      pw.Container(
                          width: 7.5 * PdfPageFormat.cm,
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Container(
                                          width: 3.5 * PdfPageFormat.cm,
                                          child: pw.Text('TIN No. :',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 10.0))),
                                      pw.Container(
                                          width: 3.7 * PdfPageFormat.cm,
                                          child: pw.Text(
                                              '${iinvoicee!.invoiceMiddle!.tinNo}',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 10.0)))
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Container(
                                          width: 3.5 * PdfPageFormat.cm,
                                          child: pw.Text('VAT Reg No. :',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 10.0))),
                                      pw.Container(
                                          width: 3.7 * PdfPageFormat.cm,
                                          child: pw.Text(
                                              '${iinvoicee!.invoiceMiddle!.vatNo}',
                                              style: pw.TextStyle(
                                                  fontWeight:
                                                      pw.FontWeight.bold,
                                                  fontSize: 10.0)))
                                    ]),
                                pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Container(
                                          width: 3.5 * PdfPageFormat.cm,
                                          child: pw.Text('Inv. Number',
                                              style: const pw.TextStyle(
                                                fontSize: 10.0,
                                              ))),
                                      pw.Text(": "),
                                      pw.Container(
                                          width: 4 * PdfPageFormat.cm,
                                          child: pw.Text(iinvoicee!
                                              .headerinfo!.invNum
                                              .toString()))
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Container(
                                          width: 3.5 * PdfPageFormat.cm,
                                          child: pw.Text('Inv. Date',
                                              style: const pw.TextStyle(
                                                fontSize: 10.0,
                                              ))),
                                      pw.Text(": "),
                                      pw.Container(
                                          width: 4 * PdfPageFormat.cm,
                                          child: pw.Text(iinvoicee!
                                              .headerinfo!.invDate
                                              .toString()))
                                    ]),
                                pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Container(
                                          width: 3.5 * PdfPageFormat.cm,
                                          child: pw.Text('Sales Order',
                                              style: const pw.TextStyle(
                                                fontSize: 10.0,
                                              ))),
                                      pw.Text(": "),
                                      pw.Container(
                                          width: 4 * PdfPageFormat.cm,
                                          child: pw.Text(iinvoicee!
                                                      .headerinfo!.salesOrder !=
                                                  null
                                              ? iinvoicee!
                                                  .headerinfo!.salesOrder
                                                  .toString()
                                              : ''))
                                    ]),
                                pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
                                pw.Row(children: [
                                  pw.Container(
                                      width: 3.5 * PdfPageFormat.cm,
                                      child: pw.Text('Your Order Ref',
                                          style: const pw.TextStyle(
                                            fontSize: 10.0,
                                          ))),
                                  pw.Text(": "),
                                  pw.Container(
                                      width: 4 * PdfPageFormat.cm,
                                      child: pw.Text(iinvoicee!
                                          .headerinfo!.ordReference
                                          .toString()))
                                ]),
                              ]))
                    ]),
              ],
            )),
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
          ]),
    );
  }

  static footerContainer(
    Invoice invoice,
  ) {
    String base64String = invoice.headerinfo!.U_QRValue!;
    String base64Stringx = base64String.split(',').last;
    Uint8List imageBytes = base64Decode(base64Stringx);

    final image = pw.MemoryImage(imageBytes);

    return pw.Container(
        alignment: pw.Alignment.bottomCenter,
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.SizedBox(height: 2 * PdfPageFormat.cm),
              pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                            width: 3 * PdfPageFormat.cm,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                children: [
                                  pw.Text(
                                      '${invoice.headerinfo!.U_Zno.toString()}',
                                      style: const pw.TextStyle(fontSize: 10)),
                                  pw.Text(
                                      '${invoice.headerinfo!.U_VfdIn.toString()}',
                                      style: const pw.TextStyle(fontSize: 10)),
                                  pw.Text(
                                      '${invoice.headerinfo!.U_rctCde.toString()}',
                                      style: const pw.TextStyle(fontSize: 10)),
                                ])), //0xf00cc qr

                        pw.SizedBox(width: 0.5 * PdfPageFormat.cm),

                        invoice.headerinfo!.U_QRValue!.isNotEmpty ||
                                invoice.headerinfo!.U_QRValue != null
                            ? pw.Container(
                                width: 2 * PdfPageFormat.cm,
                                height: 2 * PdfPageFormat.cm,
                                child: pw.Image(image),
                              )
                            : pw.Container()
                      ])),
              pw.Row(children: [
                pw.Container(
                    alignment: pw.Alignment.bottomCenter,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("TERMS AND CONDITIONS AS STATED OVERLEAF.",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 10.0)),
                          pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
                          pw.Container(
                              child: pw.Row(children: [
                            pw.Text('Print Status : '),
                            pw.Text(' Original',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0,
                                    color: PdfColors.red))
                          ])),
                        ])),
              ])
            ]));
  }

  static calculationWork() {
    Configure config = Configure();

    return pw.Container(
        child: pw.Column(children: [
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Container(
          width: 15 * PdfPageFormat.cm,
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.only(
                    left: 1.5 * PdfPageFormat.cm,
                  ),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Pails:", style: const pw.TextStyle()),
                        pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
                        pw.Text("$pails ", style: const pw.TextStyle()),
                      ]),
                ),
                pw.Container(
                    child: pw.Row(children: [
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text("Cartons:",
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
                        pw.Text("Loose Tins:",
                            style: const pw.TextStyle(fontSize: 10)),
                      ])),
                  pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text("$cartons",
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(height: 0.2 * PdfPageFormat.cm),
                        pw.Text("$looseTins",
                            style: const pw.TextStyle(fontSize: 10)),
                      ]))
                ])),
                pw.Container(
                    child: pw.Row(children: [
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text("Total Pack:",
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
                        pw.Text("Tonnage:",
                            style: const pw.TextStyle(fontSize: 10)),
                      ])),
                  pw.SizedBox(width: 0.3 * PdfPageFormat.cm),
                  pw.Container(
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                        pw.Text("$totalPack",
                            style: const pw.TextStyle(fontSize: 10)),
                        pw.SizedBox(width: 0.2 * PdfPageFormat.cm),
                        pw.Text(config.splitValues(tonnage!.toStringAsFixed(2)),
                            style: const pw.TextStyle(fontSize: 10)),
                      ]))
                ])),
              ])),
      pw.SizedBox(height: 1.5 * PdfPageFormat.cm),
      pw.Container(
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
            pw.Container(
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                  pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
                  pw.Container(
                      width: 8 * PdfPageFormat.cm,
                      child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Container(
                              child: pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Container(
                                        width: 2.4 * PdfPageFormat.cm,
                                        child: pw.Divider(
                                          thickness: 1,
                                        )),
                                    pw.Text("Prepared by",
                                        style:
                                            const pw.TextStyle(fontSize: 10)),
                                  ]),
                            ),
                            pw.Container(
                              child: pw.Column(children: [
                                pw.Container(
                                    width: 2.3 * PdfPageFormat.cm,
                                    child: pw.Divider(
                                      thickness: 1,
                                    )),
                                pw.Text("Checked by",
                                    style: const pw.TextStyle(fontSize: 10)),
                              ]),
                            ),
                            pw.Container(
                              child: pw.Column(children: [
                                pw.Container(
                                    width: 2.3 * PdfPageFormat.cm,
                                    child: pw.Divider(
                                      thickness: 1,
                                    )),
                                pw.Text("Approved by",
                                    style: const pw.TextStyle(fontSize: 10)),
                              ]),
                            ),
                          ])),
                  pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
                  pw.Text('Received in good order and condition',
                      style: const pw.TextStyle(fontSize: 10)),
                  pw.SizedBox(height: 0.1 * PdfPageFormat.cm),
                  pw.Container(
                    child: pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        children: [
                          pw.Container(
                              child: pw.Row(children: [
                            pw.Text("Date",
                                style: const pw.TextStyle(fontSize: 10)),
                            pw.Container(
                                alignment: pw.Alignment.bottomCenter,
                                height: 2.3 * PdfPageFormat.cm,
                                width: 2.3 * PdfPageFormat.cm,
                                child: pw.Divider(
                                  thickness: 1,
                                )),
                          ])),
                          pw.SizedBox(width: 0.1 * PdfPageFormat.cm),
                          pw.Container(
                              child: pw.Row(children: [
                            pw.Text("Signature",
                                style: const pw.TextStyle(fontSize: 10)),
                            pw.Container(
                                alignment: pw.Alignment.bottomCenter,
                                height: 2.3 * PdfPageFormat.cm,
                                width: 2.3 * PdfPageFormat.cm,
                                child: pw.Divider(
                                  thickness: 1,
                                )),
                          ])),
                        ]),
                  ),
                ])),
            pw.Container(
                width: 9 * PdfPageFormat.cm,
                child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                          child: pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                            pw.Text('Total (Excl) Tshs',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0)),
                            pw.Text(
                                config.splitValues(
                                    exclTxTotal.toStringAsFixed(2)),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0)),
                          ])),
                      pw.SizedBox(height: 0.7 * PdfPageFormat.cm),
                      pw.Container(
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                            pw.Text('VAT Tshs',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0)),
                            pw.Text(
                                config.splitValues(vatTx.toStringAsFixed(2)),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0)),
                          ])),
                      pw.SizedBox(height: 0.4 * PdfPageFormat.cm),
                      pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('---------------------------')),
                      pw.Container(
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                            pw.Text('Total (Incl) Tshs',
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0)),
                            pw.Text(
                                config.splitValues(
                                    inclTxTotal.toStringAsFixed(2)),
                                style: pw.TextStyle(
                                    fontWeight: pw.FontWeight.bold,
                                    fontSize: 10.0))
                          ])),
                      pw.Container(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text('---------------------------')),
                    ])),
          ]))
    ]));
  }

  static createTable(
    ThemeData theme,
  ) {
    Configure config = Configure();

    return pw.Container(
        child: pw.Table(
            border: pw.TableBorder.symmetric(
                outside: const pw.BorderSide(
                  color: PdfColors.black,
                ),
                inside: const pw.BorderSide(
                  color: PdfColors.black,
                )),
            columnWidths: {
          0: const pw.FlexColumnWidth(0.8),
          1: const pw.FlexColumnWidth(4.5),
          2: const pw.FlexColumnWidth(1.2),
          3: const pw.FlexColumnWidth(1.5),
          4: const pw.FlexColumnWidth(1.8),
          5: const pw.FlexColumnWidth(2),
        },
            children: [
          pw.TableRow(children: [
            pw.Container(
              child: pw.Text(
                "S.No",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 1),
              child: pw.Text(
                "Description",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              child: pw.Text(
                "Qty",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              child: pw.Text(
                "Disc %",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 1,
              ),
              child: pw.Text(
                "VAT",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 2),
              child: pw.Text(
                "Net Amount",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
          ]), //
          for (int i = 0; i < iinvoicee!.items!.length; i++)
            pw.TableRow(children: [
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: pw.Container(
                  height: 0.3 * PdfPageFormat.cm,
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "${i + 1}",
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                child: pw.Text(
                  iinvoicee!.items![i].descripton.toString(),
                  textAlign: pw.TextAlign.left,
                  style: const pw.TextStyle(fontSize: 10),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    iinvoicee!.items![i].quantity.toString(),
                    textAlign: pw.TextAlign.right,
                    style: const pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    iinvoicee!.items![i].dics.toString(),
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    config.splitValues(
                        iinvoicee!.items![i].vat!.toStringAsFixed(2)),
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    config.splitValues(
                        iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
                    textAlign: pw.TextAlign.left,
                    style: const pw.TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ])
        ]));
  }
}

class _PdfInvoiceApiiiState extends State<PdfInvoiceApiii> {
  Configure config = Configure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: PdfPreview(
        build: (format) => createPdfFile(widget.theme, context),
      ),
    );
  }

  Future<Uint8List> createPdfFile(ThemeData theme, BuildContext context) {
    var pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: const pw.EdgeInsets.all(10),
        pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm,
            marginAll: 2.0 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return <pw.Widget>[
            PdfInvoiceApiii.headerContianer(),
            PdfInvoiceApiii.createTable(
              theme,
            ),
            PdfInvoiceApiii.calculationWork(),
            PdfInvoiceApiii.iinvoicee!.headerinfo!.U_QRValue!.isNotEmpty
                ? PdfInvoiceApiii.footerContainer(PdfInvoiceApiii.iinvoicee!)
                : pw.Container()
          ];
        }));
    return pdf.save();
  }
}

// class Base64Image extends StatelessWidget {
//   final String base64String;

//   const Base64Image({required this.base64String});

//   @override
//   Widget build(BuildContext context) {
//     try {
    
    

    
//     } catch (e) {
//       return Text('Invalid Base64 String');
//     }
//   }
// }
