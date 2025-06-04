// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:intl/intl.dart';

import '../../url/url.dart';
import '../Printer/ShowPrintPdf.dart';

class ApprovalReqApi {
  static String? path;

  static Future<int> getGlobalData(
    String? custCode,
  ) async {
    try {
      log(URL.reportUrl + 'ApprovalReqApi/$custCode');
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'ApprovalRequest/$custCode', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final tempDir = await Directory('/storage/emulated/0/Download');

        log("direc: " + tempDir.path.toString());
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

        final file =
            await File('${tempDir.path}/ApprovalRequest-${timestamp}.pdf')
                .create();
        file.writeAsBytesSync(bytes);
        log('ApprovalReqApi:::${tempDir.path}/ApprovalRequest-${timestamp}.pdf');
        path = '${tempDir.path}/ApprovalRequest-${timestamp}.pdf';
        final doc = await PDFDocument.fromFile(file);

        ShowPdfs.document = doc;
        ShowPdfs.docNO = timestamp;
        ShowPdfs.title = 'ApprovalRequest';
        await Get.toNamed<dynamic>(ConstantRoutes.showPdf);
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      print(e);
      return 500;
    }
  }
}
