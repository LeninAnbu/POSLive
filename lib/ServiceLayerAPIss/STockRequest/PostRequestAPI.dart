import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/SapStkRequestModel.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/StockReqPostringModel.dart';

import '../../url/url.dart';

class PostRequestAPi {
  static String? fromWarehouse;
  static String? gitWarehouse;
  static String? uReqWarehouse;
  static String? comments;
  static String? docDate;
  static String? dueDate;
  static String? seriesType;
  static String? cardCodePost;
  static List<StockReqPostiModel>? stockTransferLines;
  static void method(String? deviceCode) {
    final dat = json.encode({
      "CardCode": "$cardCodePost",

      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DueDate": "$dueDate",
      "FromWarehouse": "$fromWarehouse",
      "ToWarehouse": "$gitWarehouse",
      "Comments": "$comments",
      'U_ReqWhs': "$uReqWarehouse",
      // 'Series': '$seriesType',
      'U_DeviceCode': deviceCode,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "StockTransferLines": stockTransferLines!.map((e) => e.tojson()).toList(),
    });
  }

  static Future<SapStkrequestModel> getGlobalData(String? deviceTransID) async {
    try {
      log("Step11");
      final response =
          await http.post(Uri.parse("${URL.sapUrl}/InventoryTransferRequests"),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
                // "Prefer":"return-no-content"
              },
              body: json.encode({
                "CardCode": "$cardCodePost",

                "DocumentStatus": "bost_Open",
                "DocDate": "$docDate",
                "DueDate": "$dueDate",
                "FromWarehouse": "$fromWarehouse",
                "ToWarehouse": "$gitWarehouse",
                "Comments": "$comments",
                "U_DeviceTransID": deviceTransID,
                'U_ReqWhs': "$uReqWarehouse",
                "U_PosUserCode": UserValues.userCode,
                "U_PosTerminal": AppConstant.terminal,
                // 'Series': '$seriesType',

                "StockTransferLines":
                    stockTransferLines!.map((e) => e.tojson()).toList(),
                // [
                //   {
                //     "LineNum": 0,
                //     "DocEntry": 1000,
                //     "ItemCode": "100017A",
                //     "ItemDescription": "DELUX HI COVER EMUL WHITE - 20LTR",
                //     "Quantity": 500.0,
                //     "Price": 11739.810640,
                //     "Currency": "TZS",
                //     "WarehouseCode": "MBEGIT",
                //     "FromWarehouseCode": "HOFG",
                //   }
                // ]
              }));
      log(json.encode({
        "CardCode": "$cardCodePost",

        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DueDate": "$dueDate",
        "FromWarehouse": "$fromWarehouse",
        "ToWarehouse": "$gitWarehouse",
        "Comments": "$comments",
        'U_ReqWhs': "$uReqWarehouse",
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        // 'Series': '$seriesType',
        "StockTransferLines":
            stockTransferLines!.map((e) => e.tojson()).toList(),
      }));
      log("PostRequestAPi stcode11 ::${response.statusCode}");

      // log("PostRequestAPi: " + json.decode(response.body).toString());

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return SapStkrequestModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("PostRequestAPi: ${json.decode(response.body)}");
        log("Approval RequestAPi stcode22 ::${response.statusCode}");
        // throw Exception("Error");
        return SapStkrequestModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');
      throw Exception('Exception PostRequestAPi: $e');
      // return Logindata.issue('Restart the app or contact the admin!!..', 500);
    }
  }
}
