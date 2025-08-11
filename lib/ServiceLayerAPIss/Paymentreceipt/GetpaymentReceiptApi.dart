//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/GetPaymentReceiptModel.dart';

import '../../url/url.dart';

class SerlayPayReceiptAPI {
  static Future<GetIncomingReceiptModel> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}IncomingPayments($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("receipt stscode::${response.statusCode}");

      if (response.statusCode == 200) {
        return GetIncomingReceiptModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Invoice Exception: Error");
        throw Exception("Errorrrrr");
      }
    } catch (e) {
      log("GetInvException:: $e");
      throw Exception("Error");
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}