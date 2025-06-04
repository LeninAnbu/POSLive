import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/StockReplenishModel.dart';

class StockcheckAPi {
  static Future<StockRepModel> getGlobalData() async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_StockcheckAPi_V1 "
              }));

      if (response.statusCode == 200) {
        return StockRepModel.fromJson(response.body, response.statusCode);
      } else {
        return StockRepModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return StockRepModel.error(e.toString(), 500);
    }
  }
}
