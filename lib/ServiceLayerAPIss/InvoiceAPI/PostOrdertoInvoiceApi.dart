import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/Sapinvoicesmodel.dart';

import '../../url/url.dart';

class OrderToInvoicesPostAPI {
  static String? sessionID;
  static String? cardCodePost;
  static List<PostingInvoiceLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? docType;
  static String? cardName;
  static String? seriesType;
  static String? tinNo;
  static String? VATNo;
  static String? remarks;
  static int? uTruckInternal;

  static void method(String? deviceTransID) {
    final data = json.encode({
      "CardCode": "$cardCodePost",
      "CardName": "$cardName",
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "Comments": "$remarks",
      "U_VAT_NUMBER": "$VATNo",
      'U_TinNO': '$tinNo',
      "U_DeviceTransID": deviceTransID,
      "U_Truck_Internal": uTruckInternal,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
    });
    log("post Order to invoice data : $data");
  }

  static Future<SapSalesinvoiceModel> getGlobalData(
      String? deviceTransID) async {
    try {
      final data = json.encode({
        "DocType": "$docType",
        "CardCode": "$cardCodePost",
        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "Comments": "$remarks",
        "U_VAT_NUMBER": "$VATNo",
        'U_TinNO': '$tinNo',
        "U_DeviceTransID": deviceTransID,
        "U_Truck_Internal": uTruckInternal,
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
      });
      log("${URL.sapUrl}/Invoices");
      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/Invoices",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocType": "$docType",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "Comments": "$remarks",
          "U_VAT_NUMBER": "$VATNo",
          'U_TinNO': '$tinNo',
          "U_DeviceTransID": deviceTransID,
          "U_Truck_Internal": uTruckInternal,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "U_Request": data,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
        }),
      );

      log(
        "datatatatorder: ${json.encode({
              "DocType": "$docType",
              "CardCode": "$cardCodePost",
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              // "DocDueDate": "$dueDate",
              "U_VAT_NUMBER": "$VATNo",
              "Comments": "$remarks",
              'U_TinNO': '$tinNo',
              "U_DeviceTransID": deviceTransID,
              "U_Truck_Internal": uTruckInternal,
              "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
            })}",
      );

      log("statucCode: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        json.decode(response.body.toString());
        return SapSalesinvoiceModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return SapSalesinvoiceModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return SapSalesinvoiceModel.exceptionn('$e', 500);
    }
  }
}
