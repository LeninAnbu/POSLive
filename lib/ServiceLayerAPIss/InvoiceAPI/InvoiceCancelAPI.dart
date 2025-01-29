//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../url/url.dart';
import '../QuotationAPI/QuotationCancelAPI.dart';

class SerlayInvoiceCancelAPI {
// /https://102.69.167.106:50000/b1s/v1/Quotations(48386)/Cancel
  static Future<Cancelmodel> getData(String sapDocEntry) async {
    // int? ressCode = 500;
    // Cancelmodel cancelmdl = Cancelmodel();

    log("Invoice sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("http://102.69.167.106:50001/b1s/v1/Invoices($sapDocEntry)/Cancel");
      final response = await http.post(
        Uri.parse('${URL.sapUrl}/Invoices($sapDocEntry)/Cancel'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      // cancelmdl.statusCode = response.statusCode;
      log("Invoice stscode::${response.statusCode}");
      log("Invoice Res::${response.body}");

      if (response.statusCode == 204) {
        log("Successfully Cancelled");

        return Cancelmodel.fromJson(response.body, response.statusCode);
      } else {
        // log("Invoicecancel Exception: Error");
        // throw Exception("Error");
        return Cancelmodel.exception(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("InvCancelException:: $e");
      throw Exception("Error");
      // return Cancelmodel.exception(e.toString(), ressCode);
    }
  }
}

//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}