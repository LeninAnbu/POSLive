//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/SapInwardModel.dart';

import '../../url/url.dart';

class SerlayInwardAPI {
  static Future<SapInwardModel> getData(String sapDocEntry) async {
    // int? ressCode = 500;
    // log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/StockTransfers($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("Invoice stscode::${response.statusCode}");
      log("inward::${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return SapInwardModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        throw Exception("Errorrrrr");
        // return SapSalesOrderModel.issue(
        //     json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetInwardException:: $e");
      throw Exception("Error");
      // return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}