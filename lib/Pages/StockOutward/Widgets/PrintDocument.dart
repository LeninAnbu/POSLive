import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:printing/printing.dart';

class PDFOutwardpi extends StatelessWidget {
  PDFOutwardpi({super.key});
  static Invoice? iinvoicee;
  Configure config = Configure();
  // final String title;
  // final ThemeData theme;
  static double exclTxTotal = 0;
  static double vatTx = 0;
  static double inclTxTotal = 0;
  static int? pails = 0;
  static int? cartons = 0;
  static double? looseTins = 0;
  static double? tonnage = 0;
  static double? amount = 0;

  static double totalPack = 0;
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
          createTableHeader(),
          createTable(),
          // calclationWork(),
        ];
      },
      // footer: (context) {
      //   pageindex = context.pageNumber;
      //   pagecount = context.pagesCount;

      //   return footerContainer();
      // }
    ));

    return pdf.save();
  }

  static headerContainer() {
    return pw.Container(
        child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.Container(
            alignment: pw.Alignment.bottomCenter,
            height: 1 * PdfPageFormat.cm,
            child: pw.Text(
              "Insignia Limited",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 15.0),
            )),
        pw.SizedBox(height: 1 * PdfPageFormat.cm),
        pw.Text(
          'Manufacturers of Coral and Galaxy Paints',
          style: pw.TextStyle(fontSize: 8.0),
        ),
        pw.Text(
          'An ISO 9001:2008 Certified Company',
          style: pw.TextStyle(fontSize: 8.0),
        ),
        pw.Text(
          "Mbozi Road, Chang'ombe Industrial Area, P.O.Box 71449, Dar es Salaam, Tanzania",
          style: pw.TextStyle(fontSize: 8.0),
        ),
        pw.Text(
          ' Tel: +255 22 2864049, 2863893, 2863824, Email: info@insigniatz.com',
          style: pw.TextStyle(fontSize: 8.0),
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

  // calclationWork() {
  //   return pw.Container(
  //       child: pw
  //           .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
  //     pw.SizedBox(height: 1 * PdfPageFormat.cm),
  //     pw.Container(
  //         child: pw.Row(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children: [
  //           pw.Container(
  //               width: 9 * PdfPageFormat.cm,
  //               child: pw.Column(children: [
  //                 pw.Row(
  //                     crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       pw.Text('Payment Term',
  //                           style: const pw.TextStyle(
  //                             fontSize: 8,
  //                           )),
  //                       pw.Text('Cash Advance',
  //                           style: const pw.TextStyle(
  //                             fontSize: 8,
  //                           )),
  //                     ]),
  //                 pw.Divider(color: PdfColors.blue)
  //               ])),
  //           pw.Container(
  //               width: 9 * PdfPageFormat.cm,
  //               child: pw.Column(children: [
  //                 pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       pw.Container(
  //                           child: pw.Text('Quotation SubTotal:',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               ))),
  //                       pw.Container(
  //                           child: pw.Text(
  //                               config.splitValues(
  //                                   pdfSubtotal.toStringAsFixed(2)),
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )))
  //                     ]),
  //                 pw.Text(
  //                     '...........................................................................',
  //                     style: const pw.TextStyle(color: PdfColors.blue100)),
  //                 pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       pw.Container(
  //                           child: pw.Text('Total Before Tax:',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               ))),
  //                       pw.Container(
  //                           child: pw.Text(
  //                               config.splitValues(
  //                                   pdfSubtotal.toStringAsFixed(2)),
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )))
  //                     ]),
  //                 pw.Text(
  //                     '...........................................................................',
  //                     style: const pw.TextStyle(color: PdfColors.blue100)),
  //                 pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       pw.Container(
  //                           child: pw.Text('Total Tax Amount:',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               ))),
  //                       pw.Container(
  //                           child: pw.Text(
  //                               config.splitValues(vatTx.toStringAsFixed(2)),
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )))
  //                     ]),
  //                 pw.Text(
  //                     '...........................................................................',
  //                     style: const pw.TextStyle(color: PdfColors.blue100)),
  //                 pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       pw.Container(
  //                           child: pw.Text('Total Amount:',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               ))),
  //                       pw.Container(
  //                           child: pw.Text(
  //                               config.splitValues(
  //                                   inclTxTotal.toStringAsFixed(2)),
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )))
  //                     ]),
  //                 pw.Divider(color: PdfColors.blue),
  //               ])),
  //         ])),
  //     pw.SizedBox(height: 0.5 * PdfPageFormat.cm),
  //     pw.Container(
  //         child: pw.Text('Quotation Valid Until: 08/12/2023',
  //             style: const pw.TextStyle(
  //               fontSize: 8,
  //             ))),
  //     pw.Text(
  //         '............................................................................................................................................................................',
  //         style: const pw.TextStyle(color: PdfColors.blue100)),
  //     pw.Container(
  //         child: pw.Text(
  //             'Payment can be made through TT/Swift to our Bankers as Follows :',
  //             style: const pw.TextStyle(
  //               fontSize: 8,
  //             ))),
  //     pw.SizedBox(
  //       height: 0.3 * PdfPageFormat.cm,
  //     ),
  //     pw.Container(
  //         width: 15 * PdfPageFormat.cm,
  //         child: pw.Row(
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children: [
  //               pw.Container(
  //                   width: 7 * PdfPageFormat.cm,
  //                   child: pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         pw.Container(
  //                             child: pw.Column(
  //                                 mainAxisAlignment:
  //                                     pw.MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment:
  //                                     pw.CrossAxisAlignment.start,
  //                                 children: [
  //                               pw.Text('CRDB Bank Plc',
  //                                   style: const pw.TextStyle(
  //                                     fontSize: 8,
  //                                   )),
  //                               pw.Text('NBC Ltd',
  //                                   style: const pw.TextStyle(
  //                                     fontSize: 8,
  //                                   )),
  //                             ])),
  //                         pw.Container(
  //                             child: pw.Column(
  //                                 crossAxisAlignment:
  //                                     pw.CrossAxisAlignment.start,
  //                                 mainAxisAlignment:
  //                                     pw.MainAxisAlignment.spaceBetween,
  //                                 children: [
  //                               pw.Text('A/C No TZS - 0150460410600',
  //                                   style: const pw.TextStyle(
  //                                     fontSize: 8,
  //                                   )),
  //                               pw.Text('A/C No TZS - 011103003423',
  //                                   style: const pw.TextStyle(
  //                                     fontSize: 8,
  //                                   )),
  //                             ])),
  //                       ])),
  //               pw.Container(
  //                   width: 4.5 * PdfPageFormat.cm,
  //                   child: pw.Column(children: [
  //                     pw.Row(
  //                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           pw.Text('Swift Code',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )),
  //                           pw.Text('CORUTZTZ',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )),
  //                         ]),
  //                     pw.Row(
  //                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           pw.Text('Swift Code',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )),
  //                           pw.Text('NLCBTZTX',
  //                               style: const pw.TextStyle(
  //                                 fontSize: 8,
  //                               )),
  //                         ]),
  //                   ])),
  //             ])),
  //     pw.Text(
  //         '.............................................................................................................................................................................',
  //         style: const pw.TextStyle(color: PdfColors.blue100)),
  //   ]));
  // }

  static createTableHeader() {
    return pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
          pw.Container(height: 1 * PdfPageFormat.cm),
          pw.Text(
            'TRANSFER INVOICE',
            style: pw.TextStyle(fontSize: 8.0, fontWeight: pw.FontWeight.bold),
          ),
          pw.Container(
            height: 0.5 * PdfPageFormat.cm,
          ),
          pw.Container(
              padding: pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: 0.1, color: PdfColors.black)),
              // width: 15 * PdfPageFormat.cm,
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                      // color: PdfColors.red,
                      width: 7.5 * PdfPageFormat.cm,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            '${iinvoicee!.invoiceMiddle!.customerName.toString()}',
                            style: pw.TextStyle(fontSize: 8.0),
                          ),
                          pw.Text(
                            '${iinvoicee!.invoiceMiddle!.address ?? ''}',
                            style: pw.TextStyle(fontSize: 8.0),
                          ),
                        ],
                      )),
                  pw.Container(
                      // color: PdfColors.red,
                      width: 7.5 * PdfPageFormat.cm,
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                                width: 5 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Transfer Invoice',
                                  style: pw.TextStyle(fontSize: 8.0),
                                )),
                            pw.Text(
                              '${iinvoicee!.headerinfo!.salesOrder}',
                              style: pw.TextStyle(fontSize: 8.0),
                            ),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                                width: 5 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Date',
                                  style: pw.TextStyle(fontSize: 8.0),
                                )),
                            pw.Text(
                              '${iinvoicee!.headerinfo!.invDate}',
                              style: pw.TextStyle(fontSize: 8.0),
                            ),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                                width: 5 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Vehicle No',
                                  style: pw.TextStyle(fontSize: 8.0),
                                )),
                            pw.Text(''),
                          ]),
                          pw.Row(children: [
                            pw.Container(
                                child: pw.Text(
                              'Driver Name',
                              style: pw.TextStyle(fontSize: 8.0),
                            )),
                            pw.Text(''),
                          ]),
                        ],
                      )),
                ],
              ))
        ]));
  }

  static createTable() {
    return pw.Container(
        child: pw.Column(
      children: [
        pw.Table(
            border: const pw.TableBorder(
                top: pw.BorderSide(
                    width: 0.1,
                    color: PdfColors.black,
                    style: pw.BorderStyle.solid),
                bottom: pw.BorderSide(
                    width: 0.1,
                    color: PdfColors.black,
                    style: pw.BorderStyle.solid),
                horizontalInside: pw.BorderSide(
                    width: 0.1,
                    color: PdfColors.black,
                    style: pw.BorderStyle.solid)),
            columnWidths: {
              0: const pw.FlexColumnWidth(1),
              1: const pw.FlexColumnWidth(1.5),
              2: const pw.FlexColumnWidth(4.5),
              3: const pw.FlexColumnWidth(2),
              4: const pw.FlexColumnWidth(2.5),
            },
            children: [
              pw.TableRow(children: [
                pw.Container(
                  alignment: pw.Alignment.centerLeft,

                  // color: PdfColors.blue100,
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 1),
                  child: pw.Text(
                    "No.",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 8,
                      // color: PdfColors.blue100,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  child: pw.Text(
                    "Qty.",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 8,
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
                    "Description of goods",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 8,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.center,
                  // color: PdfColors.blue100,
                  padding: const pw.EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 3,
                  ),
                  child: pw.Text(
                    "Unit Price",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.normal,
                      fontSize: 8,
                    ),
                    textAlign: pw.TextAlign.center,
                  ),
                ),
                pw.Container(
                  alignment: pw.Alignment.centerRight,
                  // color: PdfColors.blue100,
                  padding:
                      const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  child: pw.Text(
                    "Amount (TZS)",
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
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 5),
                    child: pw.Container(
                      // color: PdfColors.blue100,

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
                      padding: const pw.EdgeInsets.symmetric(
                          vertical: 5, horizontal: 4),
                      child: pw.Container(
                        // color: PdfColors.blue100,
                        alignment: pw.Alignment.centerRight,
                        width: 7 * PdfPageFormat.cm,
                        child: pw.Text(
                          '${iinvoicee!.items![i].quantity}',
                          // iinvoicee!.items![i].descripton.toString(),
                          textAlign: pw.TextAlign.left,
                          style: pw.TextStyle(
                            fontSize: 8,
                            // fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      )),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 4),
                    child: pw.Container(
                      width: 1.8 * PdfPageFormat.cm,
                      alignment: pw.Alignment.center,
                      child: pw.Text(
                        '${iinvoicee!.items![i].descripton}',

                        // iinvoicee!.items![i].quantity.toString(),
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(
                          fontSize: 8,
                          // fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 4),
                    child: pw.Container(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        '${iinvoicee!.items![i].unitPrice}',
                        // config.splitValues(
                        //     iinvoicee!.items![i].unitPrice!.toStringAsFixed(2)),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 8,
                          // fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(
                        vertical: 4, horizontal: 4),
                    child: pw.Container(
                      width: 5 * PdfPageFormat.cm,
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        '${iinvoicee!.items![i].basic!.toStringAsFixed(4)}',
                        // config.splitValues(
                        //     iinvoicee!.items![i].netTotal!.toStringAsFixed(2)),
                        textAlign: pw.TextAlign.left,
                        style: pw.TextStyle(
                          fontSize: 8,
                          // fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ])
            ]),
        pw.SizedBox(
          height: 0.2 * PdfPageFormat.cm,
        ),
        pw.Container(
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        width: 4 * PdfPageFormat.cm,
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                padding: pw.EdgeInsets.only(
                                  left: 1 * PdfPageFormat.cm,
                                ),
                                width: 2 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Pails',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    // fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  child: pw.Text(
                                "$pails ",
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  // fontWeight: pw.FontWeight.bold,
                                ),
                              )),
                            ])),
                    pw.Container(
                        width: 7 * PdfPageFormat.cm,
                        child: pw.Row(children: [
                          pw.Container(
                            width: 3 * PdfPageFormat.cm,
                            child: pw.Text(
                              'Total Packs',
                              style: pw.TextStyle(
                                fontSize: 8,
                                // fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Container(
                              child: pw.Text(
                            '$totalPack',
                            style: pw.TextStyle(
                              fontSize: 8,
                              // fontWeight: pw.FontWeight.bold,
                            ),
                          )),
                        ])),
                    pw.Container(
                        width: 4 * PdfPageFormat.cm,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [pw.Text('--------------------')]))
                  ]),
              pw.Container(
                  alignment: pw.Alignment.centerRight,
                  // width: 6 * PdfPageFormat.cm,
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Container(
                            // color: PdfColors.red,
                            width: 14 * PdfPageFormat.cm,
                            child: pw.Text(
                              '',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            )),
                        pw.Container(
                            width: 2 * PdfPageFormat.cm,
                            child: pw.Text(
                              'Invoice Total',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            )),
                        pw.Container(
                            alignment: pw.Alignment.centerRight,
                            width: 3 * PdfPageFormat.cm,
                            child: pw.Text('${exclTxTotal.toStringAsFixed(4)}',
                                style: pw.TextStyle(fontSize: 8)))
                      ])),
              pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                        // color: PdfColors.green,
                        width: 4 * PdfPageFormat.cm,
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                // width: 2.5 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Net Weight',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    // fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  // width: 2.5 * PdfPageFormat.cm,
                                  child: pw.Text(
                                '0',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  // fontWeight: pw.FontWeight.bold,
                                ),
                              )),
                            ])),
                    pw.Container(
                        width: 4.5 * PdfPageFormat.cm,
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                // width: 3 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Cross Weight',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    // fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  // width: 2 * PdfPageFormat.cm,
                                  child: pw.Text(
                                '0',
                                style: pw.TextStyle(
                                  fontSize: 8,
                                  // fontWeight: pw.FontWeight.bold,
                                ),
                              )),
                            ])),
                    pw.Container(
                        width: 5 * PdfPageFormat.cm,
                        child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              pw.Container(
                                width: 2.5 * PdfPageFormat.cm,
                                child: pw.Text(
                                  'Tonnage',
                                  style: pw.TextStyle(
                                    fontSize: 8,
                                    // fontWeight: pw.FontWeight.bold,
                                  ),
                                ),
                              ),
                              pw.Container(
                                  width: 2 * PdfPageFormat.cm,
                                  child: pw.Text(
                                    '$tonnage',
                                    style: pw.TextStyle(
                                      fontSize: 8,
                                      // fontWeight: pw.FontWeight.bold,
                                    ),
                                  )),
                            ])),
                    pw.Container(
                        width: 4 * PdfPageFormat.cm,
                        child: pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.end,
                            children: [pw.Text('--------------------')]))
                  ]),
              pw.Container(
                height: 0.4 * PdfPageFormat.cm,
              ),
              pw.Container(
                  width: 10 * PdfPageFormat.cm,
                  child: pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text('_____________'),
                        pw.Text('_____________'),
                        pw.Text('_____________')
                      ])),
              pw.Container(
                height: 0.2 * PdfPageFormat.cm,
              ),
              pw.Container(
                  width: 10 * PdfPageFormat.cm,
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
                        pw.Container(
                          width: 3 * PdfPageFormat.cm,
                          alignment: pw.Alignment.center,
                          child: pw.Text('Checked by',
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        ),
                        pw.Container(
                          width: 3 * PdfPageFormat.cm,
                          alignment: pw.Alignment.center,
                          child: pw.Text('Approved by',
                              style: pw.TextStyle(
                                fontSize: 8,
                              )),
                        )
                      ]))
            ])),
        pw.Container(
          height: 0.5 * PdfPageFormat.cm,
        ),
        pw.Container(
            alignment: pw.Alignment.centerLeft,
            child: pw.Text(
                'Declaration: This is an Internal Transfer of goods from one location to another l',
                style: pw.TextStyle(fontSize: 9, color: PdfColors.grey)))
      ],
    ));
  }
}
