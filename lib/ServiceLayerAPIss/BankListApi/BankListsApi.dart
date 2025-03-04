//GET https://localhost:50000/b1s/v1/Quotations(123)
//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/BankListModel/BankListsModels.dart';

class GetBankListAPI {
  static Future<BankListModels> getData() async {
    // log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      final response = await http.get(
        Uri.parse('http://102.69.167.106:50001/b1s/v1/Banks'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("GetBankListAPI stscode::${response.statusCode}");
      // log("GetBankLiApprovalsAPistAPI::${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return BankListModels.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("GetBankListAPI Exception: Error");
        // throw Exception("Errorrrrr");
        return BankListModels.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetBankListAPI exp:: $e");
      // throw Exception("Error");
      return BankListModels.issue("Exception", 500);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}