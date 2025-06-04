import 'dart:developer';
import 'dart:io';
// import 'package:chunked_stream/chunked_stream.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../url/url.dart';
import '../Printer/ShowPrintPdf.dart';

class SubGroupSalesPdfReportAPi {
  static String? slpCode;
  static String? fromDate;
  static String? toDate;
  static String? methodName;
  static String? cardCode;
  static String? path;

  static Future<int> getGlobalData() async {
    try {
      log(
        'SubGroupSalesPdfReportAPi::${URL.reportUrl}$methodName/$slpCode,$fromDate,$toDate,$cardCode',
      );
      final response = await http.get(
        Uri.parse(
          '${URL.reportUrl}$methodName/$slpCode,$fromDate,$toDate,$cardCode', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('SubGroupSalesPdf statusCode::${response.statusCode}');

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final tempDir = await Directory('/storage/emulated/0/Download');

        log("direc: " + tempDir.path.toString());
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

        final file = await File('${tempDir.path}/YTDGrowthSLP-${timestamp}.pdf')
            .create();
        file.writeAsBytesSync(bytes);
        log('tempDir111:::${tempDir.path}/YTDGrowthSLP-${timestamp}.pdf');
        path = '${tempDir.path}/YTDGrowthSLP-${timestamp}.pdf';
        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = timestamp;
        ShowPdfs.title = 'YTDGrowthSLP';
        await Get.toNamed<dynamic>(ConstantRoutes.showPdf);

        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      log(e.toString());

      return 500;
    }
  }
}
