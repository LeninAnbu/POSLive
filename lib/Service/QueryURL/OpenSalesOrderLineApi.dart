// http://102.69.167.106:1705/api/SellerKit

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderLineModel.dart';

class SalesOrderLineApi {
  static Future<OpenSalesOrderLine> getGlobalData(
      String siteCode, String cardCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_SalesOrderLineApi '$cardCode','$siteCode'"
              }));

      log("BZ_POS_SalesOrderLineApi::" + response.body.toString());
      if (response.statusCode == 200) {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      } else {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      return OpenSalesOrderLine.fromJson(e.toString(), 500);
    }
  }
}
