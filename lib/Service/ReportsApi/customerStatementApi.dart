// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';

// import 'package:chunked_stream/chunked_stream.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../Constant/ConstantRoutes.dart';
import '../../url/url.dart';
import '../Printer/ShowPrintPdf.dart';

class CustomerStatementApi {
  static Future<int> getGlobalData(
      String? custCode, String? fromDate, String? toDate) async {
    try {
      log(URL.reportUrl + 'NetPOrder/$custCode,$fromDate,$toDate');
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'NetPOrder/$custCode,$fromDate,$toDate',
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await Directory('/storage/emulated/0/Download');

        print("direc: " + tempDir.path);
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

        final file =
            await File('${tempDir.path}/Customer Statement-$timestamp.pdf')
                .create();
        print('${tempDir.path}/Customer Statement-$timestamp.pdf');
        file.writeAsBytesSync(bytes);
        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        ShowPdfs.docNO = timestamp;
        ShowPdfs.title = 'Customer Statement';
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
