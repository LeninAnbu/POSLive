//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/GetSapOrderstatusModel.dart';
// import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../url/url.dart';

class SerlaySalesOrderAPI {
  static Future<SapSalesOrderModel> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionIDxx:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::${URL.sapUrl}/Orders($sapDocEntry)");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/Orders($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("SalesOrder stscode::${response.statusCode}");
      // log("SalesOrder resp::${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SapSalesOrderModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SalesQuo Exception: Error");

        return SapSalesOrderModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetOrderException:: $e");

      return SapSalesOrderModel.expError(e.toString(), 500);
    }
  }
}



//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}