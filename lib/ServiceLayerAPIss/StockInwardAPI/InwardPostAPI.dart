import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/InwardPostList.dart';

import '../../Models/ServiceLayerModel/SapInwardModel/SapInwardModel.dart';
import '../../url/url.dart';

class PostStkInwardAPi {
  static String? fromWarehouse;
  static String? toWarehouse;
  static String? comments;
  static String? seriesType;
  static String? cardCodePost;

  static String? docDate;
  static String? dueDate;
  static List<StockInLineModel>? stockTransferLines;
  static void method() {
    final dat = json.encode({
      "CardCode": "$cardCodePost",
      "DocDate": "$docDate",
      "DueDate": "$dueDate",
      "FromWarehouse": "$fromWarehouse",
      "ToWarehouse": "$toWarehouse",
      "Comments": "$comments",
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "StockTransferLines": stockTransferLines!.map((e) => e.toJson()).toList(),
    });
    log('data::$dat');
  }

  static Future<SapInwardModel> getGlobalData() async {
    try {
      log("Step11");
      final response = await http.post(Uri.parse("${URL.sapUrl}StockTransfers"),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          },
          body: json.encode({
            "CardCode": "$cardCodePost",
            "DocDate": "$docDate",
            "DueDate": "$dueDate",
            "FromWarehouse": "$fromWarehouse",
            "ToWarehouse": "$toWarehouse",
            "Comments": "$comments",
            "U_PosUserCode": UserValues.userCode,
            "U_PosTerminal": AppConstant.terminal,
            "StockTransferLines":
                stockTransferLines!.map((e) => e.toJson()).toList(),
          }));
      log(json.encode({
        "DocDate": "$docDate",
        "DueDate": "$dueDate",
        "FromWarehouse": "$fromWarehouse",
        "ToWarehouse": "$toWarehouse",
        "Comments": "$comments",
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "StockTransferLines":
            stockTransferLines!.map((e) => e.toJson()).toList(),
      }));
      log("PostRequestAPi stcode11 ::${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return SapInwardModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("PostRequestAPi stcode22 ::${response.statusCode}");

        return SapInwardModel.issue(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');
      throw Exception('Exception PostRequestAPi: $e');
    }
  }
}
