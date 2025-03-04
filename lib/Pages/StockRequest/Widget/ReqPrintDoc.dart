import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:flutter/material.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../Constant/Configuration.dart';

class ReqPrintLayout extends StatelessWidget {
  ReqPrintLayout({super.key});
  static Invoice? iinvoicee;
  Configure config = Configure();
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static double discountval = 0;
  static double discountper = 0;
  static double carryoverval = 0;

  static double subtotal = 0;
  static int pageindex = 0;
  static int pagecount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Printing Document")),
      body: PdfPreview(
        build: (format) => ordCreatePdfFile(),
      ),
    );
  }

  Future<Uint8List> ordCreatePdfFile() {
    var pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
      maxPages: 100,
      margin: const pw.EdgeInsets.all(10),
      orientation: pw.PageOrientation.portrait,
      pageFormat: const PdfPageFormat(
          21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm,
          marginAll: 2.0 * PdfPageFormat.cm),
      header: (context) {
        pageindex = context.pageNumber;
        pagecount = context.pagesCount;

        return pw.Header(
          outlineStyle: PdfOutlineStyle.normal,
          outlineColor: PdfColors.white,
          level: 2,
          child: headerContainer(),
        );
      },
      build: (pw.Context context) {
        return <pw.Widget>[
          buildContainer(),
          // carryover(),
        ];
      },
      // footer: (context) {
      //   // return footerContainer();
      // }
    ));

    return pdf.save();
  }

  static buildContainer() {
    Configure config = Configure();

    return pw.Container(
        child: pw.Column(children: [
      pw.Table(
          border: const pw.TableBorder(
              bottom: pw.BorderSide(
                  width: 0.5,
                  color: PdfColors.black,
                  style: pw.BorderStyle.solid),
              horizontalInside: pw.BorderSide(
                  width: 0.5,
                  color: PdfColors.black,
                  style: pw.BorderStyle.solid)),
          columnWidths: {
            0: const pw.FlexColumnWidth(0.8),
            1: const pw.FlexColumnWidth(1.8),
            2: const pw.FlexColumnWidth(4.5),
            3: const pw.FlexColumnWidth(1.5),
          },
          children: [
            pw.TableRow(children: [
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                // color: PdfColors.blue100,
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                child: pw.Text(
                  "S.No",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                    // color: PdfColors.blue100,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Container(
                width: 3 * PdfPageFormat.cm,
                alignment: pw.Alignment.center,
                // color: PdfColors.blue100,
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                child: pw.Text(
                  "Item Code",
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.center,
                // color: PdfColors.blue100,
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
                child: pw.Text(
                  "Item Description",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.centerRight,

                // color: PdfColors.blue100,
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                child: pw.Text(
                  "Req.Quantity",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 8,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ]),
            for (int i = 0; i < iinvoicee!.items!.length; i++)
              pw.TableRow(children: [
                pw.Padding(
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: pw.Container(
                    height: 0.3 * PdfPageFormat.cm,
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      "${i + 1}",
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                pw.Padding(
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                  child: pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Text(iinvoicee!.items![i].itemcode.toString(),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 8,
                        )),
                  ),
                ),
                pw.Padding(
                    padding:
                        pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
                    child: pw.Container(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(iinvoicee!.items![i].descripton.toString(),
                          style: const pw.TextStyle(
                            fontSize: 8,
                          )),
                    )),
                pw.Padding(
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: pw.Container(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      iinvoicee!.items![i].quantity.toString(),
                      textAlign: pw.TextAlign.right,
                      style: pw.TextStyle(
                        fontSize: 8,
                        // fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ]),
          ]),
      pw.Container(
        height: 0.5 * PdfPageFormat.cm,
      ),
      pw.Container(
          child: pw.Row(children: [
        pw.Text(
          'Remarks',
          style: pw.TextStyle(
            fontSize: 9,
            // fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.Container(
          width: 1 * PdfPageFormat.cm,
        ),
        pw.Container(
            decoration: pw.BoxDecoration(
                border: pw.Border.all(width: 0.5, color: PdfColors.black)),
            height: 1 * PdfPageFormat.cm,
            width: 10 * PdfPageFormat.cm,
            child: pw.Text(''))
      ])),
      pw.Container(
        height: 1 * PdfPageFormat.cm,
      ),
      pw.Container(
          // width: 10 * PdfPageFormat.cm,
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
            pw.Container(
              width: 3 * PdfPageFormat.cm,
              alignment: pw.Alignment.center,
              child: pw.Text('Prepared by',
                  style: pw.TextStyle(
                    fontSize: 8,
                  )),
            ),
            pw.Text('_____________'),
            pw.Container(
              width: 3 * PdfPageFormat.cm,
              alignment: pw.Alignment.center,
              child: pw.Text('Issued by',
                  style: pw.TextStyle(
                    fontSize: 8,
                  )),
            ),
            pw.Text('_____________'),
            pw.Container(
              width: 3 * PdfPageFormat.cm,
              alignment: pw.Alignment.center,
              child: pw.Text('Recvd by',
                  style: pw.TextStyle(
                    fontSize: 8,
                  )),
            ),
            pw.Text('_____________')
          ])),
      pw.Container(
        height: 0.2 * PdfPageFormat.cm,
      ),
    ]));
  }

  static headerContainer() {
    return pw.Container(
        padding: pw.EdgeInsets.all(5),
        decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.black, width: 0.5)),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                  width: 18.5 * PdfPageFormat.cm,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('Insignia Limited',
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.SizedBox(
                          height: 0.2 * PdfPageFormat.cm,
                        ),
                        pw.Container(
                            width: 8 * PdfPageFormat.cm,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Insignia Limited',
                                      style: pw.TextStyle(
                                          fontSize: 10,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.Text('PO Box 71449',
                                      style: pw.TextStyle(
                                        fontSize: 8,
                                      ))
                                ])),
                        pw.Container(
                            child: pw.Column(children: [
                          pw.Text('Inventory Transfer',
                              style: pw.TextStyle(
                                  fontSize: 10,
                                  fontWeight: pw.FontWeight.bold)),
                          pw.Text('Request',
                              style: pw.TextStyle(
                                  fontSize: 10, fontWeight: pw.FontWeight.bold))
                        ])),
                      ])),
              pw.SizedBox(
                height: 0.5 * PdfPageFormat.cm,
              ),
              pw.Container(
                  padding: pw.EdgeInsets.only(
                    left: 5.85 * PdfPageFormat.cm,
                  ),
                  alignment: pw.Alignment.center,
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('${iinvoicee!.invoiceMiddle!.address}',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  )),
                            ])
                      ])),
              pw.SizedBox(
                height: 0.5 * PdfPageFormat.cm,
              ),
              pw.Container(
                  width: 16.5 * PdfPageFormat.cm,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                                child: pw.Column(children: [
                              pw.Text('Requested Raised From',
                                  style: pw.TextStyle(
                                      decoration: pw.TextDecoration.underline,
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(' ${iinvoicee!.headerinfo!.reqFrom}',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  )),
                            ])),
                            pw.SizedBox(
                              height: 1.5 * PdfPageFormat.cm,
                            ),
                            pw.Container(
                                child: pw.Column(children: [
                              pw.Text('Requested Raised To',
                                  style: pw.TextStyle(
                                      decoration: pw.TextDecoration.underline,
                                      fontSize: 9,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text(' ${iinvoicee!.headerinfo!.reqTo}',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  )),
                            ]))
                          ],
                        )),
                        pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Column(children: [
                              pw.BarcodeWidget(
                                  data:
                                      " ${iinvoicee!.headerinfo!.docEntry}-1250000001",
                                  // ${iinvoicee!.headerinfo!.docEntry}-17",
                                  barcode: pw.Barcode.qrCode(),
                                  width: 80,
                                  height: 65),
                              pw.SizedBox(
                                height: 0.3 * PdfPageFormat.cm,
                              ),
                              pw.Text(
                                  ' ${iinvoicee!.headerinfo!.docEntry}-1250000001',
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  ))
                            ])),
                        pw.Container(
                            child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Container(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                  pw.Text(
                                      'Doc Num:      ${iinvoicee!.headerinfo!.salesOrder}',
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                      )),
                                  pw.Text(
                                      'Doc Date:      ${iinvoicee!.headerinfo!.invDate}',
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                      )),
                                ])),
                            pw.SizedBox(
                              height: 1.5 * PdfPageFormat.cm,
                            ),
                            pw.Container(
                                child: pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                  pw.Text('Batch No',
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                      )),
                                  pw.Text(
                                      'Mfg. Date       ${iinvoicee!.headerinfo!.invDate}',
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                      )),
                                  pw.Text('Expiry Date',
                                      style: pw.TextStyle(
                                        fontSize: 9,
                                      )),
                                ]))
                          ],
                        )),
                      ]))
            ]));
  }

  static footerContainer() {
    return pw.Container(
        child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'CEO:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Tax Official:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(width: 2.5 * PdfPageFormat.cm, child: pw.Text('')),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Headquarters:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('100-230-844',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Website:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('www.insignia.co.tz',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            )
          ],
        )),
        pw.SizedBox(width: 1 * PdfPageFormat.cm),
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Phone No:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('255-22-2104149',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Fax:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(
                    width: 3.5 * PdfPageFormat.cm,
                    child: pw.Text(
                      '255-22-2861420',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('E-Mail:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('sapadmin@insigniatz.com',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Tax No:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('34043',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Tax ID No:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            )
          ],
        )),
        pw.SizedBox(width: 1 * PdfPageFormat.cm),
        pw.Container(
            child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Bank Name:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('NBC TZS',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                    width: 2.7 * PdfPageFormat.cm,
                    child: pw.Text(
                      'Bank Account:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
                pw.Container(
                    width: 3.5 * PdfPageFormat.cm,
                    child: pw.Text(
                      '011103003423',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500),
                    )),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('bank Code:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('NBC TZS',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('Swift/BIC Code:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 3.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            ),
            pw.Row(
              children: [
                pw.Container(
                  width: 2.7 * PdfPageFormat.cm,
                  child: pw.Text('IBAN:',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
                pw.Container(
                  width: 2.5 * PdfPageFormat.cm,
                  child: pw.Text('',
                      style: const pw.TextStyle(
                          fontSize: 8, color: PdfColors.grey500)),
                ),
              ],
            )
          ],
        )),
      ],
    ));
  }
}
