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
        return <pw.Widget>[
          buildHeader(font, Calibrifont, Calibrifontbold, config, contextt),
        ];
      },
    ));

    return pdf.save();
  }

  static buildHeader(TtfFont font, TtfFont Calibrifont, TtfFont Calibrifontbold,
      Configure config, BuildContext contextt) {
    return pw.Container(
      decoration: pw.BoxDecoration(),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            height: 18,
            width: Screens.width(contextt) * 0.79,
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

  static buildFooter(
    context,
    Configure config,
  ) =>
      pw.Container();
}
