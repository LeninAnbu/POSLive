import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ExpenseModel/GetExpDetailsMdl.dart';
import '../../url/url.dart';

class SerlayExpensesAPI {
  static Future<GetExpnseDetModel> getData(String sapDocEntry) async {
    log("Expenses sapSessionID:::${AppConstant.sapSessionID}:::::${URL.sapUrl}VendorPayments($sapDocEntry)");
    try {
      final response = await http.get(
        Uri.parse('${URL.sapUrl}VendorPayments($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("Get Det Expenses stscode::${response.statusCode}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return GetExpnseDetModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return GetExpnseDetModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("ExpGetException:: $e");

      return GetExpnseDetModel.exception(e.toString(), 500);
    }
  }
}

//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}} 