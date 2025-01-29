// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:developer';
import 'dart:io';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:intl/intl.dart';

import '../../url/url.dart';
import 'ShowPrintPdf.dart';

class SalesInvoicePrintAPi {
  static String? docEntry;
  static String? slpCode;
  static String? path;

  static Future<int> getGlobalData() async {
    try {
      log(
        "SaleInvoice::$slpCode" + URL.reportUrl + 'SaleInvoice/$docEntry',
      );
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'SaleInvoice/$docEntry', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log('Inv response.statusCode::${response.statusCode}');
      if (response.statusCode == 200) {
        //  print("streamm: "+ json.fuse() response.body);
        //  var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        // log("bodyBytes: " + response.bodyBytes.toString());
        final bytes = response.bodyBytes;
        // log("Uint8List bytes: " + bytes.toString());
        final tempDir = await Directory('/storage/emulated/0/Download');
        // await getTemporaryDirectory();
        log("direc: " + tempDir.path.toString());
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

        final file =
            await File('${tempDir.path}/SaleInvoice-${timestamp}.pdf').create();
        file.writeAsBytesSync(bytes);
        log('tempDir111:::${tempDir.path}/SaleInvoice-${timestamp}.pdf');
        path = '${tempDir.path}/SaleInvoice-${DateTime.now()}.pdf';
        // ShowPdfs.files = [];
        final doc = await PDFDocument.fromFile(file);
        ShowPdfs.document = doc;
        // ShowPdfs.files
        //     .add(XFile('${tempDir.path}/SaleInvoice-${DateTime.now()}.pdf'));

        ShowPdfs.docNO = timestamp;
        ShowPdfs.title = 'SaleInvoice';
        // ShowPdfs.paths.add(path!);
        log('tempDir:::${tempDir.path}/SaleInvoice-$docEntry.pdf');

        await Get.toNamed<dynamic>(ConstantRoutes.showPdf);
        // SReportsState.isLoading = false;
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      print('SaleInvoice:$e');

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
