// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../../url/url.dart';

class ApprovalsRetAPi {
  static String? uDeviceID;

  static Future<ApprovalsOTORModal> getGlobalData() async {
    try {
      log(
        "Ret api:::" +
            URL.sapUrl +
            "/CreditNotes?\$select=DocEntry,DocNum&\$filter=U_DeviceTransID eq '$uDeviceID'",
      );
      final response = await http.get(
        Uri.parse(
            "http://102.69.167.106:50001/b1s/v1/CreditNotes?\$select=DocEntry,DocNum&\$filter=U_DeviceTransID eq '$uDeviceID'"),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
      );
      log("statucCode: " + response.statusCode.toString());
      log("Ret ApprovalDoc num: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalsOTORModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else {
        return ApprovalsOTORModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      return ApprovalsOTORModal.issue(
          'Restart the app or contact the admin!!..');
    }
  }
}
