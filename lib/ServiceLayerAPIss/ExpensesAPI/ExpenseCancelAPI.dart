import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../url/url.dart';
import '../QuotationAPI/QuotationCancelAPI.dart';

class SerlayExpensesCancelAPI {
  static Future<Cancelmodel> getData(String sapDocEntry) async {
    log("Expenses sapSessionID:::${AppConstant.sapSessionID}");
    try {
      final response = await http.post(
        Uri.parse('${URL.sapUrl}/VendorPayments($sapDocEntry)/Cancel'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      log("Expenses stscode::${response.statusCode}");
      log("Expenses Res::${response.body}");

      if (response.statusCode == 204) {
        log("Successfully Cancelled");

        return Cancelmodel.fromJson(response.body, response.statusCode);
      } else {
        return Cancelmodel.exception(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("ExpCancelException:: $e");
      throw Exception("Error");
    }
  }
}

//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}} 