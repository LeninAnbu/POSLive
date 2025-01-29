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
    // int? ressCode = 500;
    log("AppConstant.sapSessionIDxx:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        //http://102.69.167.106:50000/b1s/v1/Orders($sapDocEntry)/Close
        Uri.parse('${URL.sapUrl}/Orders($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("SalesOrder stscode::${response.statusCode}");
      // log("SalesQuo::${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SapSalesOrderModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SalesQuo Exception: Error");
        // throw Exception("Errorrrrr");
        return SapSalesOrderModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetOrderException:: $e");
      // throw Exception("Error");
      return SapSalesOrderModel.issue(json.decode(e.toString()), 500);
    }
  }
}



//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}