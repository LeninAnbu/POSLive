//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
// import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../url/url.dart';
import '../QuotationAPI/QuotationCancelAPI.dart';

class SerlayRequestCancelAPI {
// /https://102.69.167.106:50000/b1s/v1/Quotations(48386)/Cancel
  static Future<Cancelmodel> getData(String sapDocEntry) async {
    Cancelmodel cancelmdl = Cancelmodel();

    log("Req sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("http://102.69.167.106:50001/b1s/v1/InventoryTransferRequests($sapDocEntry)/Close");
      final response = await http.post(
        Uri.parse(
            '${URL.sapUrl}/InventoryTransferRequests($sapDocEntry)/Close'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );

      cancelmdl.statusCode = response.statusCode;
      log("Invoice stscode::${response.statusCode}");

      if (response.statusCode == 204) {
        log("Successfully Cancelled");
        return Cancelmodel.fromJson(response.body, response.statusCode);
      } else {
        return Cancelmodel.exception(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("cancel Exception:: $e");
      throw Exception("Error");
    }
  }
}

//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}