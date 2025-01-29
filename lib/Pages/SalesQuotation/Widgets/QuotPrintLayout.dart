import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:printing/printing.dart';

class PDFQuoApi extends StatelessWidget {
  PDFQuoApi({super.key});
  static Invoice? iinvoicee;
  Configure config = Configure();
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static int pageindex = 0;
  static int pagecount = 0;
  static double pdfSubtotal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Printing Document")),
      body: PdfPreview(
        build: (format) => createPdfFile(),
      ),
    );
  }

  Future<Uint8List> createPdfFile() {
    var pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        maxPages: 100,
        margin: const pw.EdgeInsets.all(10),
        pageFormat: const PdfPageFormat(
            21.0 * PdfPageFormat.cm, 29.7 * PdfPageFormat.cm,
            marginAll: 2.0 * PdfPageFormat.cm),
        build: (pw.Context context) {
          return <pw.Widget>[
            headerContainer(),
            createTable(),
            calclationWork(),
          ];
        },
        footer: (context) {
          pageindex = context.pageNumber;
          pagecount = context.pagesCount;

          return footerContainer();
        }));

    return pdf.save();
  }

  static headerContainer() {
    return pw.Container(
        child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
            alignment: pw.Alignment.bottomCenter,
            height: 1 * PdfPageFormat.cm,
            child: pw.Text(
              "Insignia Ltd.",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15.0),
            )),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Container(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
              pw.Container(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                    pw.Text(
                      iinvoicee!.invoiceMiddle!.customerName.toString(),
                      style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 12.0),
                    ),
                    pw.Text(
                      iinvoicee!.invoiceMiddle!.address.toString(),
                      style: const pw.TextStyle(fontSize: 8.0),
                    ),
                    pw.Text(
                      iinvoicee!.invoiceMiddle!.city.toString(),
                      style: const pw.TextStyle(fontSize: 8.0),
                    ),
                  ])),
              pw.Container(
                  width: 10 * PdfPageFormat.cm,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Container(
                            width: 10.1 * PdfPageFormat.cm,
                            child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                children: [
                                  pw.Container(
                                      height: 0.3 * PdfPageFormat.cm,
                                      child: pw.VerticalDivider(
                                        color: PdfColors.orange,
                                        thickness: 3,
                                      )),
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.5 * PdfPageFormat.cm,
                                      ),
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        "PROFORMA INVOICE",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 12.0,
                                        ),
                                      )),
                                ])),
                        pw.Text(
                            '....................................................................................',
                            style:
                                const pw.TextStyle(color: PdfColors.blue100)),
                        pw.Container(
                          padding: const pw.EdgeInsets.only(
                            right: 0.3 * PdfPageFormat.cm,
                          ),
                          width: 9.3 * PdfPageFormat.cm,
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "Document Number",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.normal,
                                        color: PdfColors.grey500),
                                  ),
                                  pw.Text(
                                    "Document Date",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                        fontSize: 8,
                                        color: PdfColors.grey500),
                                  ),
                                  pw.Text(
                                    "Page",
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.normal,
                                        fontSize: 8,
                                        color: PdfColors.grey500),
                                  ),
                                ],
                              ),
                              pw.Container(
                                  child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.2 * PdfPageFormat.cm,
                                      ),
                                      width: 2.5 * PdfPageFormat.cm,
                                      alignment: pw.Alignment.centerRight,
                                      child: pw.Text(
                                        iinvoicee!.headerinfo!.invNum
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      )),
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.2 * PdfPageFormat.cm,
                                      ),
                                      alignment: pw.Alignment.centerRight,
                                      width: 2.5 * PdfPageFormat.cm,
                                      child: pw.Text(
                                        iinvoicee!.headerinfo!.invDate
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      )),
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.1 * PdfPageFormat.cm,
                                      ),
                                      alignment: pw.Alignment.centerRight,
                                      width: 1.2 * PdfPageFormat.cm,
                                      child: pw.Text(
                                        '$pageindex / $pagecount',
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      )),
                                ],
                              )),
                            ],
                          ),
                        ),
                        pw.Text(
                            '....................................................................................',
                            style:
                                const pw.TextStyle(color: PdfColors.blue100)),
                        pw.Container(
                          width: 9.3 * PdfPageFormat.cm,
                          child: pw.Column(
                            children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                      width: 3.2 * PdfPageFormat.cm,
                                      child: pw.Text(
                                        "Your Reference",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.normal,
                                            fontSize: 8,
                                            color: PdfColors.grey500),
                                      )),
                                  pw.Container(
                                      width: 5 * PdfPageFormat.cm,
                                      child: pw.Text(
                                        "Vat Number-Business Partner",
                                        style: pw.TextStyle(
                                            fontWeight: pw.FontWeight.normal,
                                            fontSize: 8,
                                            color: PdfColors.grey500),
                                      )),
                                ],
                              ),
                              pw.Container(
                                  child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.2 * PdfPageFormat.cm,
                                      ),
                                      width: 3.2 * PdfPageFormat.cm,
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Text(
                                        iinvoicee!.headerinfo!.ordReference
                                            .toString(),
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      )),
                                  pw.Container(
                                      padding: const pw.EdgeInsets.only(
                                        right: 0.2 * PdfPageFormat.cm,
                                      ),
                                      alignment: pw.Alignment.centerLeft,
                                      width: 5 * PdfPageFormat.cm,
                                      child: pw.Text(
                                        "${iinvoicee!.headerinfo!.vatNo}",
                                        style: pw.TextStyle(
                                          fontWeight: pw.FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      )),
                                ],
                              )),
                            ],
                          ),
                        ),
                        pw.SizedBox(
                          height: 0.2 * PdfPageFormat.cm,
                        ),
                        pw.Text(
                            '....................................................................................',
                            style:
                                const pw.TextStyle(color: PdfColors.blue100)),
                        pw.Container(
                            width: 3.2 * PdfPageFormat.cm,
                            child: pw.Text(
                              "Your Contact",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.normal,
                                  fontSize: 8,
                                  color: PdfColors.grey500),
                            )),
                        pw.Text(
                          "${iinvoicee!.headerinfo!.ordReference}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 8,
                          ),
                        ),
                        pw.SizedBox(
                          height: 0.5 * PdfPageFormat.cm,
                        ),
                        pw.Container(
                            width: 3.2 * PdfPageFormat.cm,
                            child: pw.Text(
                              "DIRECT SALES",
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 8,
                              ),
                            )),
                      ])),
            ])),
        pw.Text(
            '.............................................................................................................................................................................',
            style: const pw.TextStyle(color: PdfColors.blue100)),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  "Currency:",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 9,
                      color: PdfColors.grey500),
                ),
                pw.Text(
                  "TZS",
                  style: pw.TextStyle(
                    fontSize: 9,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ]),
        ),
        pw.SizedBox(
          height: 0.5 * PdfPageFormat.cm,
        ),
      ],
    ));
  }

  static footerContainer() {
    return pw.Container(
        alignment: pw.Alignment.center,
        child: pw.Column(
          children: [
            pw.Divider(color: PdfColors.blue),
            pw.Container(
                width: 11.5 * PdfPageFormat.cm,
                child: pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.center,
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                          width: 4 * PdfPageFormat.cm,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                    child: pw.Text('TIN No:',
                                        style:
                                            const pw.TextStyle(fontSize: 9))),
                                pw.Container(
                                    child: pw.Text(
                                        '${iinvoicee!.invoiceMiddle!.tinNo}',
                                        style:
                                            const pw.TextStyle(fontSize: 9))),
                              ])),
                      pw.Container(
                          width: 5 * PdfPageFormat.cm,
                          child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                    width: 2.5 * PdfPageFormat.cm,
                                    child: pw.Text('VAT REGN No:',
                                        style:
                                            const pw.TextStyle(fontSize: 9))),
                                pw.Container(
                                  child: pw.Text(
                                      '${iinvoicee!.invoiceMiddle!.vatNo}',
                                      style: const pw.TextStyle(fontSize: 9)),
                                ),
                              ])),
                    ])),
            pw.Text(
                '................................................................................',
                style: const pw.TextStyle(color: PdfColors.blue100)),
            pw.Text('Manufacturers of Coral and Galaxy Paints',
                style:
                    pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
            pw.Text("Mbozi Road, Chang'ombe Industrial Area",
                style: const pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('P.O. Box 71449, Dar es Salaam,Tanzania',
                style: const pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('Tel: +255-22-2864049,2863893,2863824',
                style: const pw.TextStyle(
                  fontSize: 8,
                )),
            pw.Text('Fax: +255-22-2864762, Email: info@insigniatz.com',
                style: const pw.TextStyle(
                  fontSize: 8,
                )),
            pw.SizedBox(height: 0.3 * PdfPageFormat.cm),
            pw.Text('An ISO 9001:2008 Certified Company',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 8,
                )),
            pw.Text(
                '................................................................................',
                style: const pw.TextStyle(color: PdfColors.blue100)),
          ],
        ));
  }

  calclationWork() {
    return pw.Container(
        child: pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      pw.SizedBox(height: 1 * PdfPageFormat.cm),
      pw.Container(
          child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
            pw.Container(
                width: 9 * PdfPageFormat.cm,
                child: pw.Column(children: [
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('Payment Term',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            )),
                        pw.Text('Cash Advance',
                            style: const pw.TextStyle(
                              fontSize: 8,
                            )),
                      ]),
                  pw.Divider(color: PdfColors.blue)
                ])),
            pw.Container(
                width: 9 * PdfPageFormat.cm,
                child: pw.Column(children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Text('Quotation SubTotal:',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                ))),
                        pw.Container(
                            child: pw.Text(
                                config.splitValues(
                                    pdfSubtotal.toStringAsFixed(2)),
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )))
                      ]),
                  pw.Text(
                      '...........................................................................',
                      style: const pw.TextStyle(color: PdfColors.blue100)),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Text('Total Before Tax:',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                ))),
                        pw.Container(
                            child: pw.Text(
                                config.splitValues(
                                    pdfSubtotal.toStringAsFixed(2)),
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )))
                      ]),
                  pw.Text(
                      '...........................................................................',
                      style: const pw.TextStyle(color: PdfColors.blue100)),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Text('Total Tax Amount:',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                ))),
                        pw.Container(
                            child: pw.Text(
                                config.splitValues(vatTx.toStringAsFixed(2)),
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )))
                      ]),
                  pw.Text(
                      '...........................................................................',
                      style: const pw.TextStyle(color: PdfColors.blue100)),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            child: pw.Text('Total Amount:',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                ))),
                        pw.Container(
                            child: pw.Text(
                                config.splitValues(
                                    inclTxTotal.toStringAsFixed(2)),
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )))
                      ]),
                  pw.Divider(color: PdfColors.blue),
                ])),
          ])),
      pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
      pw.Container(
          child: pw.Text('Quotation Valid Until: 08/12/2023',
              style: const pw.TextStyle(
                fontSize: 8,
              ))),
      pw.Text(
          '............................................................................................................................................................................',
          style: const pw.TextStyle(color: PdfColors.blue100)),
      pw.Container(
          child: pw.Text(
              'Payment can be made through TT/Swift to our Bankers as Follows :',
              style: const pw.TextStyle(
                fontSize: 8,
              ))),
      pw.SizedBox(
        height: 0.3 * PdfPageFormat.cm,
      ),
      pw.Container(
          width: 15 * PdfPageFormat.cm,
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Container(
                    width: 7 * PdfPageFormat.cm,
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
                                pw.Text('CRDB Bank Plc',
                                    style: const pw.TextStyle(
                                      fontSize: 8,
                                    )),
                                pw.Text('NBC Ltd',
                                    style: const pw.TextStyle(
                                      fontSize: 8,
                                    )),
                              ])),
                          pw.Container(
                              child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  children: [
                                pw.Text('A/C No TZS - 0150460410600',
                                    style: const pw.TextStyle(
                                      fontSize: 8,
                                    )),
                                pw.Text('A/C No TZS - 011103003423',
                                    style: const pw.TextStyle(
                                      fontSize: 8,
                                    )),
                              ])),
                        ])),
                pw.Container(
                    width: 4.5 * PdfPageFormat.cm,
                    child: pw.Column(children: [
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Swift Code',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )),
                            pw.Text('CORUTZTZ',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )),
                          ]),
                      pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Swift Code',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )),
                            pw.Text('NLCBTZTX',
                                style: const pw.TextStyle(
                                  fontSize: 8,
                                )),
                          ]),
                    ])),
              ])),
      pw.Text(
          '.............................................................................................................................................................................',
          style: const pw.TextStyle(color: PdfColors.blue100)),
    ]));
  }

  static createTable() {
    Configure config = Configure();

    return pw.Table(
        border: const pw.TableBorder(
            bottom: pw.BorderSide(
                width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid),
            horizontalInside: pw.BorderSide(
                width: 1, color: PdfColors.blue, style: pw.BorderStyle.solid)),
        columnWidths: {
          0: const pw.FlexColumnWidth(0.8),
          1: const pw.FlexColumnWidth(4.5),
          2: const pw.FlexColumnWidth(1.2),
          3: const pw.FlexColumnWidth(1.8),
          4: const pw.FlexColumnWidth(2),
        },
        children: [
          pw.TableRow(children: [
            pw.Container(
              color: PdfColors.blue100,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
              child: pw.Text(
                "S.No",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 8,
                  color: PdfColors.blue100,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              color: PdfColors.blue100,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              child: pw.Text(
                "Description",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 8,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              color: PdfColors.blue100,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 3),
              child: pw.Text(
                "Quantity",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 8,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              alignment: pw.Alignment.center,
              color: PdfColors.blue100,
              padding: const pw.EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 3,
              ),
              child: pw.Text(
                "Price",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
                  fontSize: 8,
                ),
                textAlign: pw.TextAlign.center,
              ),
            ),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              color: PdfColors.blue100,
              padding:
                  const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              child: pw.Text(
                "Total",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.normal,
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
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: pw.Container(
                  height: 0.3 * PdfPageFormat.cm,
                  alignment: pw.Alignment.centerRight,
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
                    width: 7 * PdfPageFormat.cm,
                    child: pw.Text(
                      iinvoicee!.items![i].descripton.toString(),
                      textAlign: pw.TextAlign.left,
                      style: pw.TextStyle(
                        fontSize: 8,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  )),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: pw.Container(
                  width: 1.8 * PdfPageFormat.cm,
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    iinvoicee!.items![i].quantity.toString(),
                    textAlign: pw.TextAlign.right,
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Padding(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: pw.Container(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    config.splitValues(
                        iinvoicee!.items![i].unitPrice!.toStringAsFixed(2)),
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
                    const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                child: pw.Container(
                  width: 5 * PdfPageFormat.cm,
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    config.splitValues(
                        iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
                    textAlign: pw.TextAlign.left,
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ])
        ]);
  }
}
