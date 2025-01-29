// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../../url/url.dart';

class ApprovalsQuotAPi {
  static String? uDeviceID;

  static Future<ApprovalsOTORModal> getGlobalData() async {
    try {
      log(
        "api:::" +
            URL.sapUrl +
            "/Orders?\$select=DocEntry,DocNum&\$filter=U_DeviceTransID eq '$uDeviceID'",
      ); //fa2f2550-80c0-1e3f-a62d-d7bc54c54083
      final response = await http.get(
        Uri.parse(
          URL.sapUrl +
              "/Orders?\$select=DocEntry,DocNum&\$filter=U_DeviceTransID eq '$uDeviceID' ", //&\$filter= DocumentStatus eq 'bost_Open'
        ), //fa2f2550-80c0-1e3f-a62d-d7bc54c54083
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          // "Prefer":"return-no-content"
        },
      );
      log("statucCode: " + response.statusCode.toString());
      log("ApprovalDoc num: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalsOTORModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      } else {
        //  throw Exception('Restart the app or contact the admin!!..');
        return ApprovalsOTORModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
          response.statusCode,
        );
      }
    } catch (e) {
      // throw Exception(e);
      return ApprovalsOTORModal.issue(
          'Restart the app or contact the admin!!..');
    }
  }
}
