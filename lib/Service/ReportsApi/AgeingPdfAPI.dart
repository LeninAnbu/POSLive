// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:posproject/Constant/ConstantRoutes.dart';

import '../../url/url.dart';
import '../Printer/ShowPrintPdf.dart';

class AgeingAPi {
  static String? slpCode;
  static String? date;
  static String? custCode;
  static String? path;
  static Future<int> getGlobalData() async {
    try {
// http://102.69.167.106:84/api/CrmAgingExcel/D1999,20240410

      log("CrmAging::" + URL.reportUrl + 'CrmAging/$custCode,$date');
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'CrmAging/$custCode,$date', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('response.statusCode::${response.statusCode}');
      // log("bodyBytes: " + response.bodyBytes.toString());

      if (response.statusCode == 200) {
        //  print("streamm: "+ json.fuse() response.body);
        //  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        final bytes = response.bodyBytes;

        final tempDir = await Directory('/storage/emulated/0/Download');
        // await getTemporaryDirectory();
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

  // static Future<void> mainss() async {
  //   // Open README.md as a byte stream
  //   final fileStream = File('README.md').openRead();

  //   // Read all bytes from the stream
  //   final bytes = await readByteStream(fileStream);
  //   print(bytes);
  //   // Convert content to string using utf8 codec from dart:convert and print
  //   print(utf8.decode(bytes));
  // }
}
