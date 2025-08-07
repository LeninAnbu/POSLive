import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/url/url.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/GetSapOrderstatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class SalesOrderPostAPi {
  static String? sessionID;
  static String? cardCodePost;
  static bool? copyfromsq;
  static String? cardNamePost;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? tinNo;
  static String? vatNo;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? seriesType;

  static String? orderTime;
  static String? custREfNo;
  static String? deviceCode;
  static String? deviceTransID;
  static String? slpCode;

  static void method(String latitude, String longitude) {
    final data = json.encode({
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
      "U_VAT_NUMBER": "$vatNo",
      "NumAtCard": "$custREfNo",
      'U_DeviceCode': deviceCode,
      'U_DeviceTransID': deviceTransID,
      'U_TinNO': '$tinNo',
      "U_latitude ": latitude,
      "U_longitude": longitude,
      'Series': '$seriesType',
      "DocumentLines": copyfromsq == true
          ? docLineQout!.map((e) => e.tojson()).toList()
          : docLineQout!.map((e) => e.tojson3()).toList(),
    });
    final jsondata = json.encode({
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
      "U_VAT_NUMBER": "$vatNo",
      'U_TinNO': '$tinNo',
      "U_latitude ": latitude,
      "U_longitude": longitude,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      'Series': '$seriesType',
      "U_Request": data,
      "DocumentLines": copyfromsq == true
          ? docLineQout!.map((e) => e.tojson()).toList()
          : docLineQout!.map((e) => e.tojson3()).toList(),
    });

    log("Jsons Sales ORder Post11: $jsondata");
  }

  static Future<SapSalesOrderModel> getGlobalData(
      String latitude, String longitude) async {
    try {
      log('copyfromsqcopyfromsq::$copyfromsq');

      final data = json.encode({
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
        "U_VAT_NUMBER": "$vatNo",
        "NumAtCard": "$custREfNo",
        'U_DeviceCode': deviceCode,
        'U_DeviceTransID': deviceTransID,
        'U_TinNO': '$tinNo',
        "U_latitude ": latitude,
        "U_longitude": longitude,
        'Series': '$seriesType',
        "DocumentLines": copyfromsq == true
            ? docLineQout!.map((e) => e.tojson()).toList()
            : docLineQout!.map((e) => e.tojson3()).toList(),
      });
      log('copyfromsqcopyfromsq22::$copyfromsq');

      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/Orders",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${sessionID!}',
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
          "U_VAT_NUMBER": "$vatNo",
          'U_TinNO': '$tinNo',
          "U_latitude ": latitude,
          "U_longitude": longitude,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          'Series': '$seriesType',
          "U_Request": data,
          "DocumentLines": copyfromsq == true
              ? docLineQout!.map((e) => e.tojson()).toList()
              : docLineQout!.map((e) => e.tojson3()).toList(),
        }),
      );

      log('Direct order' +
          json.encode({
            "CardCode": "$cardCodePost",
            "CardName": "$cardNamePost",
            "DocumentStatus": "bost_Open",
            "DocDate": "$docDate",
            "U_VAT_NUMBER": "$vatNo",
            'U_TinNO': '$tinNo',
            "DocDueDate": "$dueDate",
            "Comments": "$remarks",
            "U_OrderDate": "$orderDate",
            "U_Order_Type": "$orderType",
            "U_GP_Approval": "$gpApproval",
            "U_Received_Time": "$orderTime",
            "NumAtCard": "$custREfNo",
            'U_DeviceCode': deviceCode,
            'U_DeviceTransID': deviceTransID,
            "U_PosUserCode": UserValues.userCode,
            "U_PosTerminal": AppConstant.terminal,
            "U_latitude ": latitude,
            "U_longitude": longitude,
            'Series': '$seriesType',
            "U_Request": data,
            "DocumentLines": copyfromsq == true
                ? docLineQout!.map((e) => e.tojson()).toList()
                : docLineQout!.map((e) => e.tojson3()).toList(),
          }));

      log("statucCode: ${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return SapSalesOrderModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("bodyyy post order: ${response.body}");

        return SapSalesOrderModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return SapSalesOrderModel.expError(
          'Restart the app or contact the admin!!..\n', 500); //+e.toString()
    }
  }
}
