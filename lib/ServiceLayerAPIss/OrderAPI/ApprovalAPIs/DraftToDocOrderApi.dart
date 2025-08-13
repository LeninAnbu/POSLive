// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, avoid_print, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../../url/url.dart';

class ApprovalsQuotPostAPi {
  static String? docDueDate;
  static String? docEntry;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? uDeviceId;

  static String? orderTime;
  static String? custREfNo;
  static Future<ApprovalstoDocModal> getGlobalData() async {
    final data = json.encode({
      "Document": {
        "DocDueDate": "$docDueDate",
        "DocEntry": "$docEntry",
        "U_OrderDate": "$orderDate",
        "U_Order_Type": "$orderType",
        "U_GP_Approval": "$gpApproval",
        "U_Received_Time": "$orderTime",
        "NumAtCard": "$custREfNo",
      }
    });

    log("Body Aproval request:" + data);
    try {
      log(
        "api:::" + URL.sapUrl + "DraftsService_SaveDraftToDocument",
      );
      final response = await http.post(
        Uri.parse(
          URL.sapUrl +
              "DraftsService_SaveDraftToDocument", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
        body: json.encode({
          "Document": {
            "DocDueDate": "$docDueDate",
            "DocEntry": "$docEntry",
            "U_OrderDate": "$orderDate",
            "U_Order_Type": "$orderType",
            "U_GP_Approval": "$gpApproval",
            "U_Received_Time": "$orderTime",
            "NumAtCard": "$custREfNo",
          }
        }),
      );
      log("statucCode: " + response.statusCode.toString());
      log("Approval to Doc Res: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalstoDocModal.fromJson(
          response.statusCode,
        );
      } else {
        return ApprovalstoDocModal.fromJson2(
          response.statusCode,
          json.decode(response.body),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
