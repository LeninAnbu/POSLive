import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/StockCheckMdl.dart';

class StockcheckAPi {
  static Future<StockCheckModel> getGlobalData() async {
    try {
      log('http://102.69.167.106:1705/api/SellerKit');
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_StockcheckAPi"
              }));

      log("StockCheckModel Res: ${response.body}");
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body.toString());
        log('datadatadata length::${data.length}');
        return StockCheckModel.fromJson(response.body, response.statusCode);
      } else {
        return StockCheckModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return StockCheckModel.error(e.toString(), 500);
    }
  }
}
