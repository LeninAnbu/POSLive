//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../url/url.dart';

class SerlayReturnCancelAPI {
  static Future getData(String sapDocEntry) async {
    // int? ressCode = 500;
    // log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.post(
        Uri.parse('${URL.sapUrl}/CreditNotes($sapDocEntry)/Close'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;

      log("Invoiceclose stscode::${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Successfully closed");
        return Servicrlayerquotation.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Invoiceclose Exception: Error");
        // throw Exception("Error");
        return Servicrlayerquotation.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("SalesRetException:: $e");
      throw Exception("Error");
      // return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}