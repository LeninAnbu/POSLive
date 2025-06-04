import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ServiceLayerModel/SapSalesReturnModel/SapSaleReturnmodel.dart';
import '../../url/url.dart';

class SerlaySalesReturnAPI {
  static Future<SapSalesReturnModel> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocEntry sapDocEntry::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/CreditNotes($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("Return stscode::${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SapSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return SapSalesReturnModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetRetException:: $e");

      return SapSalesReturnModel.exceptionn(e.toString(), 500);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}