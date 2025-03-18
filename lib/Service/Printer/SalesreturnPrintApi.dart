import 'dart:developer';
import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:intl/intl.dart';

import '../../url/url.dart';
import 'ShowPrintPdf.dart';

class SalesReturnPrintAPii {
  static String? slpCode;
  static String? path;

  static Future<int> getGlobalData(String? docEntry) async {
    try {
      log(
        "SaleReturn Print::" + URL.reportUrl + 'SaleReturn/$docEntry',
      );
      final response = await http.get(
        Uri.parse("${URL.reportUrl}SaleReturn/$docEntry"),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('SaleOrder response.statusCode::${response.statusCode}');
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await Directory('/storage/emulated/0/Download');
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

        final file =
            await File('${tempDir.path}/SaleOrder-$timestamp.pdf').create();
        path = '${tempDir.path}/SaleOrder-$timestamp.pdf';

        file.writeAsBytesSync(bytes);

        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = timestamp;
        ShowPdfs.title = 'SaleOrder';
        await Get.toNamed<dynamic>(ConstantRoutes.showPdf);
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      print('SaleInvoice:$e');

      return 500;
    }
  }
}
