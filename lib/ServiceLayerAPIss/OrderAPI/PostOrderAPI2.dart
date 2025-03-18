import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/url/url.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class OrderPostAPi2 {
  static String? sessionID;
  static String? cardCodePost;
  static bool? copyfromsq;
  static String? cardNamePost;
  static List<QuatationLines>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? remarks;
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? orderTime;
  static String? seriesType;
  static String? tinNo;
  static String? vatNo;
  static String? custREfNo;
  static String? deviceCode;
  static String? deviceTransID;
  static String? slpCode;

  static void method(String latitude, String longitude) {
    // final dat  =  CreateOrderDetailsState.isCameFromqutation == true?
    //         json.encode ({
    //         "AppVersion":AppVersion.version,
    //          "CardCode": "$cardCodePost",
    //         "CardName":"$cardNamePost",
    //         "DocumentStatus":"bost_Open",
    //         "DocDate":"$docDate",
    //         "DocDueDate":"$dueDate",
    //         "Comments":"$remarks",
    //         "U_OrderDate":"$orderDate",
    //         "U_Order_Type":"$orderType",
    //         "U_GP_Approval":"$gpApproval",
    //         "U_Received_Time":"$orderTime",
    //         "NumAtCard":"$custREfNo",
    //         'U_DeviceCode':deviceCode,
    //         'U_DeviceTransID':deviceTransID,
    //         'SalesPersonCode':'$slpCode',
    //         'Series':'${GetValues.seriresOrder}',
    //         "U_latitude ":latitude,
    //         "U_longitude":longitude,

    //         "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
    //         })
    //       :
    final datx = json.encode({
      // "AppVersion":AppVersion.version,
      "CardCode": "$cardCodePost",
      "CardName": "$cardNamePost",
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DocDueDate": "$dueDate",
      "Comments": "$remarks",
      'Series': '$seriesType',
      "NumAtCard": "$custREfNo",
      'U_TinNO': '$tinNo',
      "U_VAT_NUMBER": "$vatNo",

      "U_OrderDate": "$orderDate",
      "U_Order_Type": "$orderType",
      "U_GP_Approval": "$gpApproval",
      "U_Received_Time": "$orderTime",
      'U_DeviceCode': deviceCode,
      'U_DeviceTransID': deviceTransID,
      // 'SalesPersonCode': '$slpCode',
      "U_latitude ": latitude,
      "U_longitude": longitude,
      "DocumentLines": copyfromsq == true
          ? docLineQout!.map((e) => e.tojson()).toList()
          : docLineQout!.map((e) => e.tojson3()).toList(),
    });

    log("Jsons Sales ORder Post222: $datx");
  }

  static Future<SalesQuotStatus> getGlobalData(
      String latitude, String longitude) async {
    try {
      final data = json.encode({
        "CardCode": "$cardCodePost",
        "CardName": "$cardNamePost",
        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DocDueDate": "$dueDate",
        "Comments": "$remarks",
        'Series': '$seriesType',
        "U_OrderDate": "$orderDate",
        "U_Order_Type": "$orderType",
        "U_GP_Approval": "$gpApproval",
        "U_Received_Time": "$orderTime",
        "NumAtCard": "$custREfNo",
        'U_DeviceCode': deviceCode,
        'U_DeviceTransID': deviceTransID,
        'U_TinNO': '$tinNo',
        "U_VAT_NUMBER": "$vatNo",
        // 'SalesPersonCode': '$slpCode',
        "U_latitude ": latitude,
        "U_longitude": longitude,
        "DocumentLines": copyfromsq == true
            ? docLineQout!.map((e) => e.tojson()).toList()
            : docLineQout!.map((e) => e.tojson3()).toList(),
      });
      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/Orders",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${sessionID!}',
          "Prefer": "return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "CardName": "$cardNamePost",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          'U_TinNO': '$tinNo',
          "U_VAT_NUMBER": "$vatNo",
          'Series': '$seriesType',
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
          "DocumentLines": copyfromsq == true
              ? docLineQout!.map((e) => e.tojson()).toList()
              : docLineQout!.map((e) => e.tojson3()).toList(),
        }),
      );
      log(json.encode({
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
        "U_VAT_NUMBER": "$vatNo",
        // 'Series':'${GetValues.seriresOrder}',
        "U_latitude ": latitude,
        "U_longitude": longitude,
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "U_Request": data,
        "DocumentLines": copyfromsq == true
            ? docLineQout!.map((e) => e.tojson()).toList()
            : docLineQout!.map((e) => e.tojson2()).toList(),
      }));
      //  CreateOrderDetailsState.isCameFromqutation== true?
      //      log( json.encode ({
      //        "CardCode": "$cardCodePost",
      //       "CardName":"$cardNamePost",
      //       "DocumentStatus":"bost_Open",
      //       "DocDate":"$docDate",
      //       "DocDueDate":"$dueDate",
      //       "Comments":"$remarks",
      //       "U_OrderDate":"$orderDate",
      //       "U_Order_Type":"$orderType",
      //       "U_GP_Approval":"$gpApproval",
      //       "U_Received_Time":"$orderTime",
      //       "NumAtCard":"$custREfNo",
      //       'U_DeviceCode':deviceCode,
      //       'U_DeviceTransID':deviceTransID,
      //       'SalesPersonCode':'$slpCode',
      //       'Series':'${GetValues.seriresOrder}',
      //       "U_latitude ":latitude,
      //       "U_longitude":longitude,
      //        "U_Request":data,
      //       "DocumentLines": docLineQout!.map((e) => e.tojson2()).toList(),
      //       }),)
      //     :
      // log(
      //   json.encode({
      //     "CardCode": "$cardCodePost",
      //     "CardName": "$cardNamePost",
      //     "DocumentStatus": "bost_Open",
      //     "DocDate": "$docDate",
      //     "DocDueDate": "$dueDate",
      //     "Comments": "$remarks",
      //     "U_OrderDate": "$orderDate",
      //     "U_Order_Type": "$orderType",
      //     "U_GP_Approval": "$gpApproval",
      //     "U_Received_Time": "$orderTime",
      //     "NumAtCard": "$custREfNo",
      //     'U_DeviceCode': deviceCode,
      //     'U_DeviceTransID': deviceTransID,
      //     'SalesPersonCode': '$slpCode',
      //     // 'Series':'${GetValues.seriresOrder}',
      //     "U_latitude ": latitude,
      //     "U_longitude": longitude,
      //     "U_Request": data,
      //     "DocumentLines": docLineQout!.map((e) => e.tojson()).toList(),
      //   }),
      // );
      log("statucCode: ${response.statusCode}");
      log("bodyyy post order222: ${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return SalesQuotStatus.fromJson(response.statusCode);
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return SalesQuotStatus.errorIN(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      //  throw Exception(e);
      return SalesQuotStatus.issue(
          'Restart the app or contact the admin!!..\n', 500); //+e.toString()
    }
  }
}
