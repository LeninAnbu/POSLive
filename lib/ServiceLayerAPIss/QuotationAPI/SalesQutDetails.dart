// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/url/url.dart';

import '../../Models/ServiceLayerModel/SapSalesQuotation/approvals_details.modal.dart';

class SalesDetailsQtAPi {
  static Future<ApprovalDetailsPutValue> getGlobalData(
      String? draftEntry) async {
    try {
      log(" AppConstant.sapSessionID::${AppConstant.sapSessionID}");

      final response = await http.get(
        Uri.parse(
          URL.sapUrl + "Quotations($draftEntry)",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
      );
      log("SalesDetails rescode::" + response.statusCode.toString());

      if (response.statusCode == 200) {
        return ApprovalDetailsPutValue.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log(json.decode(response.body));

        return ApprovalDetailsPutValue.issue(
          'Restart the app or contact the admin!!..',
        );
      }
    } catch (e) {
      log("EXXXX: $e");

      return ApprovalDetailsPutValue.issue(
        'Restart the app or contact the admin!!..',
      );
    }
  }
}
