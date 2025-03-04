import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class SalesQuotPostAPi {
  static String? sessionID;
  static String? cardCodePost;
  static String? cardNamePost;
  static String? vatNo;
  static String? tinNo;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? seriesType;

  static void method(String? deviceTransID) {
    final data = json.encode({
      "CardCode": "$cardCodePost",
      "CardName": "$cardNamePost",
      "U_VAT_NUMBER": "$vatNo",
      'U_TinNO': '$tinNo',
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DocDueDate": "$dueDate",
      "Comments": "$remarks",
      // 'Series': '$seriesType',
      "U_DeviceTransID": deviceTransID,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
    });
    log("post q data22 : $data");
  }

  static Future<Servicrlayerquotation> getGlobalData(
      String? deviceTransID) async {
    try {
      final data = json.encode({
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
        "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
      });
      log("http://102.69.167.106:50001/b1s/v1/Quotations");
      final response = await http.post(
        Uri.parse(
          // URL.url+
          "http://102.69.167.106:50001/b1s/v1/Quotations",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          // "Prefer":"return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "CardName": "$cardNamePost",
          "U_VAT_NUMBER": "$vatNo",
          'U_TinNO': '$tinNo',
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_Request": data,
          // 'Series': '$seriesType',
          "U_DeviceTransID": deviceTransID,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
        }),
      );

      log(
        "datatatat Quot: ${json.encode({
              "CardCode": "$cardCodePost",
              "CardName": "$cardNamePost",
              "U_VAT_NUMBER": "$vatNo",
              'U_TinNO': '$tinNo',
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_Request": data,
              "U_DeviceTransID": deviceTransID,
              "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
            })}",
      );
      log("statucCode: ${response.statusCode}");
      // log("Quotations post: " +
      //     json.decode(response.body.toString()).toString());
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        // final dynamic data = json.decode(response.body.toString());
        return Servicrlayerquotation.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Responce: ${json.decode(response.body)}");

        // throw Exception('Restart the app or contact the admin!!..');
        return Servicrlayerquotation.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      throw Exception(e);
      // return Servicrlayerquotation.issue(
      //     'Restart the app or contact the admin!!..\n');
    }
  }
}
