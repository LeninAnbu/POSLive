import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Service/NewReportsApi/NewReportQuery2.dart';

import '../../Constant/Configuration.dart';

class CollectionReceiptPdfHelper {
  static String paymode = '';
  static List<newvaluedynamic> valuesddd = [];
  static List<dynamic> keysList = [];
  static double? totalSumOfAp = 0;
  Configure config = Configure();
// int i=0;
//  int pageNumber=i+1;
  // static List<InvoiceData>? dasa = [];
  String? date = '';
  static Future<TtfFont> loadFont() async {
    final ByteData data = await rootBundle.load('assets/Ingeborg-Regular.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future<TtfFont> caliberFont() async {
    final ByteData data = await rootBundle.load('assets/Calibri.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future<TtfFont> caliberFontbold() async {
    final ByteData data = await rootBundle.load('assets/CalibriBold.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

  static Future<TtfFont> dejaVuSans() async {
    final ByteData data = await rootBundle.load('assets/DejaVuSans.ttf');
    final Uint8List bytes = data.buffer.asUint8List();
    return TtfFont(bytes.buffer.asByteData());
  }

//DejaVuSans.ttf
  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }

  static Future<Uint8List> generatePdff(
      PdfPageFormat format, String title, BuildContext contextt) async {
    var pdf = pw.Document();

    Configure config = Configure();
    final TtfFont font = await loadFont();
    final TtfFont Calibrifont = await caliberFont();
    final TtfFont dejaVuSanss = await dejaVuSans();

    final TtfFont Calibrifontbold = await caliberFontbold();
    // final pdff = Document(
    //   pageMode: PdfPageMode.none,
    // );
    pdf.addPage(pw.MultiPage(
      maxPages: 100,
      margin: const pw.EdgeInsets.all(10),
      pageFormat: PdfPageFormat.a4.copyWith(
        marginBottom: 0,
        marginLeft: 0,
        marginRight: PdfPageFormat.a4.width * 0.07,
        marginTop: 0,
        width: PdfPageFormat.a4.width,
        height: PdfPageFormat.a4.height,
      ),
      build: (pw.Context context) {
        // log('context.pageNumber;${context.pageNumber}');
        return <pw.Widget>[
          buildHeader(font, Calibrifont, Calibrifontbold, config, contextt),
        ];
      },
      // footer: (context) {
      //   var pageindex = context.pageNumber;
      //   var pagecount = context.pagesCount;

      //   return buildFooter(
      //     context,
      //     config,
      //   );
      // }
    ));
    // static Future<Uint8List> generatePdf(
    //     PdfPageFormat format, String title, BuildContext contextt) async {
    // final TtfFont font = await loadFont();
    // final TtfFont Calibrifont = await caliberFont();
    // final TtfFont Calibrifontbold = await caliberFontbold();
    // Configure config = Configure();

    // final pdf = Document(
    //   pageMode: PdfPageMode.none,
    // );
    //   pdf.addPage(MultiPage(
    //     maxPages: 500,
    // pageFormat: PdfPageFormat.a4.copyWith(
    //   marginBottom: 0,
    //   marginLeft: 0,
    //   marginRight: PdfPageFormat.a4.width * 0.07,
    //   marginTop: 0,
    //   width: PdfPageFormat.a4.width,
    //   height: PdfPageFormat.a4.height,
    // ),
    //     // header: (context) {
    //     // return buildHeader(
    //     //     font, Calibrifont, config, Calibrifontbold, contextt);
    //     // },
    //     build: (context) => [
    //       buildHeader(font, Calibrifont, Calibrifontbold, config, contextt),
    //       // buildInvoice(data2, font, Calibrifont, config, Calibrifontbold),
    //       // createLineTable(font, Calibrifont, config, Calibrifontbold),

    //       // modeofPayment(font, Calibrifont, config, Calibrifontbold),
    //       // buildcontainer(),
    //     ],
    //     footer: (context) => buildFooter(context, config),
    //   ));

    return pdf.save();
  }

  static buildHeader(TtfFont font, TtfFont Calibrifont, TtfFont Calibrifontbold,
      Configure config, BuildContext contextt) {
    return pw.Container(
      decoration: pw.BoxDecoration(
          // border: pw.Border(
          //   left: pw.BorderSide(
          //     color: PdfColor.fromHex("#750537"),
          //     width: PdfPageFormat.a4.width * 0.07,
          //   ),
          // ),
          ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            height: 18,
            width: Screens.width(contextt) * 0.79,
            // color: PdfColors.grey.,
            child: pw.ListView.builder(
              direction: pw.Axis.horizontal,
              itemCount: keysList.length,
              itemBuilder: (context, index) {
                final theme = pw.Theme.of(context);

                return pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 0),
                  child: pw.Container(
                    color: PdfColors.blue,
                    alignment: pw.Alignment.centerLeft,
                    width: Screens.width(contextt) * 0.032,
                    child: pw.Text(
                      keysList[index],
                      style: pw.TextStyle(color: PdfColors.white, fontSize: 5),
                    ),
                  ),
                );
              },
            ),
          ),
          // pw.Container(
          //   height: 40,
          //   width: Screens.width(contextt) * 0.79,
          //   child: pw.Row(
          //     children: keysList
          //         .map((key) => pw.Padding(
          //               padding: pw.EdgeInsets.symmetric(horizontal: 4),
          //               child: pw.Container(
          //                 alignment: pw.Alignment.center,
          //                 width: Screens.width(contextt) * 0.11,
          //                 child: pw.Text(
          //                   key,
          //                   style: pw.TextStyle(
          //                     fontWeight: pw.FontWeight.bold,
          //                     color: PdfColors.white,
          //                   ),
          //                 ),
          //               ),
          //             ))
          //         .toList(),
          //   ),
          // ),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: valuesddd.map((dataMap) {
              return pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: keysList
                    .map((key) => pw.Padding(
                          padding: pw.EdgeInsets.only(top: 0),
                          child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            width: Screens.width(contextt) * 0.032,
                            child: pw.Text(
                              dataMap.getFieldValue(key)?.toString() ?? '',
                              textAlign: pw.TextAlign.left,
                              style: pw.TextStyle(fontSize: 5),
                            ),
                          ),
                        ))
                    .toList(),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // static buildHeader(TtfFont font, TtfFont Calibrifont, Configure config,
  //     TtfFont Calibrifontbold, BuildContext contextt) {
  //   pw.Container(
  //       decoration: pw.BoxDecoration(
  //           border: pw.Border(
  //               left: pw.BorderSide(
  //                   color: PdfColor.fromHex("#750537"),
  //                   width: PdfPageFormat.a4.width * 0.07))),
  //       child: pw.Expanded(
  //         child: pw.SingleChildScrollView(
  //           scrollDirection: pw.Axis.vertical,
  //           child: pw.Column(
  //             crossAxisAlignment: pw.CrossAxisAlignment.start,
  //             mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //             children: [
  // pw.Container(
  //   height: 40,
  //   width: Screens.width(contextt) * 0.79,
  //   // color: PdfColors.grey.,
  //   child: pw.ListView.builder(
  //     direction: pw.Axis.horizontal,
  //     itemCount:
  //         contextt.watch<ReportController>().keysList.length,
  //     itemBuilder: (context, index) {
  //       final theme = pw.Theme.of(context);

  //       return pw.Padding(
  //         padding: pw.EdgeInsets.symmetric(horizontal: 0),
  //         child: pw.Container(
  //           color: PdfColors.blue,
  //           alignment: pw.Alignment.center,
  //           width: Screens.width(contextt) * 0.11,
  //           child: pw.Text(
  //             contextt.watch<ReportController>().keysList[index],
  //             style: pw.TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: PdfColors.white),
  //           ),
  //         ),
  //       );
  //     },
  //   ),
  // ),
  //               pw.SingleChildScrollView(
  //                 scrollDirection: pw.Axis.horizontal,
  //                 child: pw.Column(
  //                   crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
  //                   children: contextt
  //                       .watch<ReportController>()
  //                       .valuesddd
  //                       .map((dataMap) {
  //                     return pw.Row(
  //                       crossAxisAlignment: pw.CrossAxisAlignment.start,
  //                       children: contextt
  //                           .watch<ReportController>()
  //                           .keysList
  //                           .map((key) {
  //                         return pw.Padding(
  //                           padding: pw.EdgeInsets.all(8.0),
  //                           child: pw.Container(
  //                             width: Screens.width(contextt) * 0.1,
  //                             child: pw.Text(
  //                               dataMap.getFieldValue(key)?.toString() ?? '',
  //                               textAlign: TextAlign.center,
  //                               style: pw.TextStyle(fontSize: 14),
  //                             ),
  //                           ),
  //                         );
  //                       }).toList(),
  //                     );
  //                   }).toList(),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ));
  // }

  static buildFooter(
    context,
    Configure config,
  ) =>
      pw.Container();
}
