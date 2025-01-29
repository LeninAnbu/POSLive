// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../../url/url.dart';

class ApprovalsRetPostAPi {
  static String? docDueDate;
  static String? docEntry;

  static Future<ApprovalstoDocModal> getGlobalData() async {
    final data = json.encode({
      "Document": {
        // "DocDueDate": "$docDueDate",
        "DocEntry": "$docEntry",
      }
    });

    log("Body Aproval request:" + data);
    try {
      log(
        "api:::" + URL.sapUrl + "/DraftsService_SaveDraftToDocument",
      );
      final response = await http.post(
        Uri.parse(
          URL.sapUrl +
              "/DraftsService_SaveDraftToDocument", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "Document": {
            // "DocDueDate": "$docDueDate",
            "DocEntry": "$docEntry",
          }
        }),
      );
      log("statucCode: " + response.statusCode.toString());
      log("Approval to Doc Res: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        // if (response.statusCode == 200 || response.statusCode == 204) {

        return ApprovalstoDocModal.fromJson(
          response.statusCode,
        );
      } else {
        //  throw Exception('Restart the app or contact the admin!!..');
        return ApprovalstoDocModal.fromJson2(
          response.statusCode,
          json.decode(response.body),
        );
      }
    } catch (e) {
      throw Exception(e);
      // return ApprovalstoDocModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
