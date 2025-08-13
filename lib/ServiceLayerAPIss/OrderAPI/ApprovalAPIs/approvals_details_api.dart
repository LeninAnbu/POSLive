// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import '../../../url/url.dart';

class ApprovalsDetailsAPi {
  static String url = "SQLQueries${AppConstant.sapSessionID}";
  static Future<ApprovalDetailsValue> getGlobalData(String? draftEntry) async {
    log("Test draft: " + URL.sapUrl + "/Drafts($draftEntry)");

    try {
      final response = await http.get(
        Uri.parse(
          URL.sapUrl + "Drafts($draftEntry)",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
      );
      log("statusCode::" + response.statusCode.toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalDetailsValue.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        log(json.decode(response.body));
        log(response.statusCode.toString());

        return ApprovalDetailsValue.issue(
            'Restart the app or contact the admin!!..');
      }
    } catch (e) {
      return ApprovalDetailsValue.issue(
          'Restart the app or contact the admin!!..');
    }
  }
}
