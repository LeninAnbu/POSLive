import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/StockOutPostingMidel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/sapOutwardmodel.dart';
import '../../url/url.dart';

class PostStkOutwardAPi {
  static String? fromWarehouse;
  static String? toWarehouse;
  static String? comments;
  static String? ureqWarehouse;
  static String? seriesType;
  static String? cardCodePost;

  static String? docDate;
  static String? dueDate;
  static List<StockOutLineModel>? stockTransferLines;
  static void method(String? deviceCode) {
    final dat = json.encode({
      "CardCode": "$cardCodePost",

      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DueDate": "$dueDate",
      "FromWarehouse": "$fromWarehouse",
      "ToWarehouse": "$toWarehouse",
      'U_ReqWhs': "$ureqWarehouse",
      "Comments": "$comments",
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      // 'Series': '$seriesType',
      "StockTransferLines": stockTransferLines!.map((e) => e.toJson()).toList(),
    });

    log('outward json data:$dat');
  }

  static Future<SapOutwardModel> getGlobalData(String? deviceTransID) async {
    try {
      log("e::${URL.sapUrl}/StockTransfers");
      final response =
          await http.post(Uri.parse("${URL.sapUrl}/StockTransfers"),
              headers: {
                "content-type": "application/json",
                "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
                // "Prefer":"return-no-content"
              },
              body: json.encode({
                "DocumentStatus": "bost_Open",
                "CardCode": "$cardCodePost",

                "DocDate": "$docDate",
                "DueDate": "$dueDate",
                "FromWarehouse": "$fromWarehouse",
                "ToWarehouse": "$toWarehouse",
                "Comments": "$comments",
                // 'Series': '$seriesType',
                "U_DeviceTransID": deviceTransID,
                'U_ReqWhs': "$ureqWarehouse",
                "U_PosUserCode": UserValues.userCode,
                "U_PosTerminal": AppConstant.terminal,
                "StockTransferLines":
                    stockTransferLines!.map((e) => e.toJson()).toList(),
              }));
      log(json.encode({
        "CardCode": "$cardCodePost",

        "DocumentStatus": "bost_Open",
        "DocDate": "$docDate",
        "DueDate": "$dueDate",
        "FromWarehouse": "$fromWarehouse",
        "ToWarehouse": "$toWarehouse",
        "Comments": "$comments",
        // 'Series': '$seriesType',
        'U_ReqWhs': "$ureqWarehouse",
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "StockTransferLines":
            stockTransferLines!.map((e) => e.toJson()).toList(),
      }));
      log("Postoutward stcode11 ::${response.statusCode}");

      // log("StkOutwardAPi: ${json.decode(response.body)}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return SapOutwardModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("StkOutwardAPi: ${json.decode(response.body)}");
        log("Postoutward stcode22 ::${response.statusCode}");
        // throw Exception("Error");
        return SapOutwardModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('Exception StkOutwardAPiAPi: $e');
      throw Exception('Exception StkOutwardAPiAPi: $e');
      // return SapOutwardModel.issue(json.decode('Restart the app or contact the admin!!..'), 500);
    }
  }
}
