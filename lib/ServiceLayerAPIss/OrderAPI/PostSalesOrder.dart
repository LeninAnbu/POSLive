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
  static String? orderDate;
  static String? orderType;
  static String? gpApproval;
  static String? seriesType;

  static String? orderTime;
  static String? custREfNo;
  static String? deviceCode;
  static String? deviceTransID;
  static String? slpCode;

  // static void method(String latitude, String longitude) {
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
  //   final dat = json.encode({
  //     // "AppVersion":AppVersion.version,
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
  //     "U_latitude ": latitude,
  //     "U_longitude": longitude,
  //     "DocumentLines": copyfromsq == true
  //         ? docLineQout!.map((e) => e.tojson()).toList()
  //         : docLineQout!.map((e) => e.tojson2()).toList(),
  //   });

  //   // log("Jsons Sales ORder Post11: $dat");
  // }

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
        "NumAtCard": "$custREfNo",
        'U_DeviceCode': deviceCode,
        'U_DeviceTransID': deviceTransID,
        // 'SalesPersonCode': '$slpCode',
        "U_latitude ": latitude,
        "U_longitude": longitude,
        // 'Series': '$seriesType',
        "DocumentLines": copyfromsq == true
            ? docLineQout!.map((e) => e.tojson()).toList()
            : docLineQout!.map((e) => e.tojson2()).toList(),
      });
      log('copyfromsqcopyfromsq22::$copyfromsq');

      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/Orders",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${sessionID!}',
          // "Prefer": "return-no-content"
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
          // 'Series': '$seriesType',
          "U_Request": data,
          "DocumentLines": copyfromsq == true
              ? docLineQout!.map((e) => e.tojson()).toList()
              : docLineQout!.map((e) => e.tojson2()).toList(),
        }),
      );

      log('Direct order' +
          json.encode({
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
            "U_PosUserCode": UserValues.userCode,
            "U_PosTerminal": AppConstant.terminal,
            // 'Series': '$seriesType',

            // 'Series':'${GetValues.seriresOrder}',
            "U_latitude ": latitude,
            "U_longitude": longitude,
            "U_Request": data,
            "DocumentLines": copyfromsq == true
                ? docLineQout!.map((e) => e.tojson()).toList()
                : docLineQout!.map((e) => e.tojson2()).toList(),
          }));

      // print("ABCD: "+response.statusCode.toString());
      log("statucCode: ${response.statusCode}");
      // log("bodyyy post order: ${response.body}");
      if (response.statusCode >= 200 && response.statusCode <= 210) {
        ///bedor 201
        // log("save : "+response.body.toString());
        // print("statucCode: "+response.statusCode.toString());
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
      //  throw Exception(e);
      return SapSalesOrderModel.expError(
          'Restart the app or contact the admin!!..\n', 500); //+e.toString()
    }
  }
}
