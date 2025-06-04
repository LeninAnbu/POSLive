//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
// import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';

class SerlayCloseQuoAPI {
// /http://102.69.167.106:50000/b1s/v1/Quotations(48386)/Close
  static Future getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.post(
        Uri.parse(
            'http://102.69.167.106:50000/b1s/v1/Quotations($sapDocEntry)/Close'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("SalesQuoclose stscode::${response.statusCode}");
      log("SalesQuoclose::${json.decode(response.body)}");

      if (response.statusCode == 204) {
        log("Successfully closed");
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      log("QuotCloxeException:: $e");
      throw Exception("Error");
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}