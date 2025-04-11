//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../url/url.dart';

class SalesOrdPatchAPI {
  static String? sessionID;
  static String? cardCodePost;
  static String? cardNamePost;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? orderTime;
  static String? custREfNo;
  static String? deviceCode;
  static String? deviceTransID;
  static String? slpCode;
  static bool? corporateuser;

  static Future<ApprovalstoDocModal> gettData(
      String sapDocEntry, String latitude, String longitude) async {
    // int? ressCode = 500;
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      final data = json.encode({
        //  "AppVersion":AppVersion.version,
        "CardCode": "$cardCodePost",
        "CardName": "$cardNamePost",
        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DocDueDate": "$dueDate",
        "Comments": "$remarks",
        "U_OrderDate": "$orderDate",
        "U_Order_Type": "$orderType",
        "U_GP_Approval": "$gpApproval",
        "U_Received_Time": "$orderTime",
        "NumAtCard": "$custREfNo",
        'U_DeviceCode': deviceCode,
        'U_DeviceTransID': deviceTransID,
        'SalesPersonCode': '$slpCode',
        "U_latitude ": latitude,
        "U_longitude": longitude,
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "DocumentLines": corporateuser == true
            ? docLineQout!.map((e) => e.tojson4()).toList()
            : docLineQout!.map((e) => e.tojson3()).toList(),
      });
      log("sapDocEntry sapDocEntry::$data");
      log("url::::${'${URL.sapUrl}/Orders($sapDocEntry)'}");
      final response = await http.patch(
        Uri.parse('${URL.sapUrl}/Orders($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "CardName": "$cardNamePost",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_OrderDate": "$orderDate",
          "U_Order_Type": "$orderType",
          "U_GP_Approval": "$gpApproval",
          "U_Received_Time": "$orderTime",
          "NumAtCard": "$custREfNo",
          'U_DeviceCode': deviceCode,
          'U_DeviceTransID': deviceTransID,
          // 'SalesPersonCode': '$slpCode',
          "U_latitude ": latitude,
          "U_longitude": longitude,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "U_Request": data,
          "DocumentLines": corporateuser == true
              ? docLineQout!.map((e) => e.tojson4()).toList()
              : docLineQout!.map((e) => e.tojson3()).toList(),
        }),
      );
      log("Sales Ord patch stscode::${response.statusCode}");
      log("Sales Ord patch:${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return ApprovalstoDocModal.fromJson(response.statusCode);
      } else {
        log("SalesOrd Edit Exception: Error");
        // throw Exception("Errorrrrr");
        return ApprovalstoDocModal.fromJson2(
          response.statusCode,
          json.decode(response.body) as Map<String, dynamic>,
        );
      }
    } catch (e) {
      log("OrderPatchException:: $e");
      // throw Exception("Error");
      return ApprovalstoDocModal.issue("$e", 500);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}