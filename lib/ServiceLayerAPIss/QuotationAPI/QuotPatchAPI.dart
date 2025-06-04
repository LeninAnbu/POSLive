//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/Service Model/CustomerModel/AddressPachModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class SerlaySalesQuoPatchAPI {
  static String? sessionID;
  static String? cardCodePost;
  static String? cardNamePost;
  static String? vatNo;
  static String? tinNo;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? deviceTransID;

  static Future<CreatePatchModel> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      final data = json.encode({
        "CardCode": "$cardCodePost",
        "U_VAT_NUMBER": "$vatNo",
        'U_TinNO': '$tinNo',
        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DocDueDate": "$dueDate",
        "Comments": "$remarks",
        "U_DeviceTransID": deviceTransID,
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
      });
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.patch(
        Uri.parse(
            'http://102.69.167.106:50001/b1s/v1/Quotations($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "U_VAT_NUMBER": "$vatNo",
          'U_TinNO': '$tinNo',
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_DeviceTransID": deviceTransID,
          "U_Request": data,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
        }),
      );

      log(
        "datatatat Patch: ${json.encode({
              "CardCode": "$cardCodePost",
              "CardName": "$cardNamePost",
              "U_VAT_NUMBER": "$vatNo",
              'U_TinNO': '$tinNo',
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_DeviceTransID": deviceTransID,
              "U_PosUserCode": UserValues.userCode,
              "U_PosTerminal": AppConstant.terminal,
              "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
              "U_Request": data,
            })}",
      );

      log("SalesQuopatch stscode::${response.statusCode}");
      // log("SalesQuopatch stscode::${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return CreatePatchModel.fromJson(response.statusCode);
      } else {
        log("SalesQuo Exception: Error");

        return CreatePatchModel.fromJson2(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("QuotPatchException:: $e");

      return CreatePatchModel.issue("Exception", 500);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}