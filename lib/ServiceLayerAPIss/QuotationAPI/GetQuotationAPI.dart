//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';

class SerlaySalesQuoAPI {
  static Future<Servicrlayerquotation> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum:: http://102.69.167.106:50001/b1s/v1/Quotations($sapDocEntry)");
      final response = await http.get(
        Uri.parse(
            'http://102.69.167.106:50001/b1s/v1/Quotations($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      // log("SalesQuo stscode::${response.statusCode}");
      // log("SalesQuo::${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return Servicrlayerquotation.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SalesQuo Exception: Error");
        // throw Exception("Errorrrrr");
        return Servicrlayerquotation.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetQuotException:: $e");
      throw Exception("Error");
      // return Servicrlayerquotation.issue("Exception", ressCode!);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}