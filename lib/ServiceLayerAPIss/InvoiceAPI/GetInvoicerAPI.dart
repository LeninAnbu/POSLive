import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/Sapinvoicesmodel.dart';

import '../../url/url.dart';

class SerlaySalesInvoiceAPI {
  static Future<SapSalesinvoiceModel> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("${URL.sapUrl}/Invoices($sapDocEntry)");
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/Invoices($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("Invoice stscode::${response.statusCode}");

      if (response.statusCode == 200) {
        return SapSalesinvoiceModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Invoice::${json.decode(response.body)}");

        log("Invoice Exception: Error");
        throw Exception("Errorrrrr");
        // return SapSalesOrderModel.issue(
        //     json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetInvException:: $e");
      throw Exception("Error");
      // return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}