// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, omit_local_variable_types, prefer_final_in_for_each, unused_import

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:excel/excel.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import 'package:url_launcher/url_launcher.dart';

import '../../url/url.dart';

class AgeingExcelAPi {
  static String? slpCode;
  static String? date;
  static String? custCode;

// /http://102.69.167.106:84/api/CrmAgingExcel/D1999,20240410
  static Future<int> getGlobalData() async {
    try {
      log(
        "CrmAgingExcel" + URL.reportUrl + 'CrmAgingExcel/$custCode,$date',
      );
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'CrmAgingExcel/$custCode,$date', //866   $docEntry
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log("bodysts: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/CrmAgingExcel-$slpCode.xlsx').create();
        file.writeAsBytesSync(bytes);
        await OpenFile.open(file.path);

        // SReportsState.isLoading = false;
        return 200;
      } else {
        return 400;
      }
    } catch (e) {
      log(e.toString());

      return 500;
    }
  }

//   static Future<void> mainss() async {
//     // Open README.md as a byte stream
//     final fileStream = File('README.md').openRead();

//     // Read all bytes from the stream
//     final bytes = await readByteStream(fileStream);
//     print(bytes);
//     // Convert content to string using utf8 codec from dart:convert and print
//     print(utf8.decode(bytes));
//   }
}

Future<void> launchUrlInBrowser(String url) async {
  if (!await launchUrl(Uri.file(url), mode: LaunchMode.externalApplication)) {
    throw 'Could not launch $url';
  }
}

List<String> rowdetail = [];

_importFromExcel(File path) async {
  if (await path.exists()) {
    final bytes = await path.readAsBytes();
    final excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      final sheet = excel.tables[table]!;
      print(sheet.maxColumns);
      print(sheet.maxRows);

      for (var row in sheet.rows) {
        print('$row');
      }
    }
  } else {
    print('Excel file does not exist.');
  }
}
