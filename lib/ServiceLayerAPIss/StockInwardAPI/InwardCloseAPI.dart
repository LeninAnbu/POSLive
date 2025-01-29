//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../url/url.dart';

class SerlayInwardCloseAPI {
  static Future getData(String sapDocEntry) async {
    // int? ressCode = 500;
    // log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.post(
        Uri.parse('${URL.sapUrl}/StockTransfers($sapDocEntry)/Close'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("Invoiceclose stscode::${response.statusCode}");
      log("Invoiceclose::${json.decode(response.body)}");

      if (response.statusCode == 204) {
        log("Successfully closed");
        // return Servicrlayerquotation.fromJson(
        //     json.decode(response.body), response.statusCode);
      } else {
        throw Exception("Error");
        // return Servicrlayerquotation.issue(
        //     json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("InwCloseException:: $e");
      throw Exception("Error");
      // return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}