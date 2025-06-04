// ignore_for_file: file_names, prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, omit_local_variable_types, prefer_final_in_for_each, unused_import

import 'dart:developer';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

import '../../url/url.dart';
import 'package:http/http.dart' as http;

class ApprovalReqExcelAPi {
  static Future<int> getGlobalData(String cardCode) async {
    try {
      log(
        "ApprovalRequestExcel::" +
            URL.reportUrl +
            'ApprovalRequestExcel/$cardCode',
      );
      final response = await http.get(
        Uri.parse(
          URL.reportUrl + 'ApprovalRequestExcel/$cardCode',
        ),
        headers: {
          'content-type': 'application/octet-stream',
        },
      );
      log("ApprovalRequestExcelSts: " + response.statusCode.toString());

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final tempDir = await getTemporaryDirectory();
        String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
        final file =
            await File('${tempDir.path}/ApprovalRequest-$timestamp.xlsx')
                .create();
        file.writeAsBytesSync(bytes);
        await OpenFile.open(file.path);

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
