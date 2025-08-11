import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../url/url.dart';

class InvoicePatchAPI {
  static String? U_rctCde = '';
  static String? U_Zno = '';
  static String? U_VfdIn = '';
  static String? U_QRPath = '';
  static String? U_QRValue = '';
  static String? U_idate = '';
  static String? U_itime = '';
  static void method() {
    final data = json.encode({
      "U_rctCde": U_rctCde,
      "U_Zno": U_Zno,
      "U_VfdIn": U_VfdIn,
      "U_QRPath": U_QRPath,
      "U_QRValue": U_QRValue,
      "U_idate": U_idate,
      "U_itime": U_itime,
    });
    log("post invoice Patch data : $data");
  }

  static Future<ApprovalstoDocModal> getGlobalData(String? docEntry) async {
    try {
      log("${URL.sapUrl}Invoices($docEntry)");
      final response = await http.put(
        Uri.parse(
          "${URL.sapUrl}Invoices($docEntry)",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "U_rctCde": U_rctCde,
          "U_Zno": U_Zno,
          "U_VfdIn": U_VfdIn,
          "U_QRPath": U_QRPath,
          "U_QRValue": U_QRValue,
          "U_idate": U_idate,
          "U_itime": U_itime,
        }),
      );

      log(
        "datatatatInvoice patch: ${json.encode({
              "U_rctCde": U_rctCde,
              "U_Zno": U_Zno,
              "U_VfdIn": U_VfdIn,
              "U_QRPath": U_QRPath,
              "U_QRValue": U_QRValue,
              "U_idate": U_idate,
              "U_itime": U_itime,
            })}",
      );
      log("E-Responce: ${json.decode(response.body)}");
      log("statucCode: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalstoDocModal.fromJson(response.statusCode);
      } else {
        return ApprovalstoDocModal.issue(
            response.body.toString(), response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return ApprovalstoDocModal.issue(
          'Restart the app or contact the admin!!..\n', 500);
    }
  }
}
