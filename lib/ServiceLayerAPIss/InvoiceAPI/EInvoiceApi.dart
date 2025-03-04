import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Models/ServiceLayerModel/SapInvoiceModel/AR_EinvoiceModel.dart';

class AREinvoiceAPI {
  static Future<AREinvoiceModel> getGlobalData(String? docEntry) async {
    try {
      log("http://102.69.167.106:8083/api/AR_EInvoice");
      final response = await http.post(
        Uri.parse(
          "http://102.69.167.106:8083/api/AR_EInvoice",
        ),
        headers: {"content-type": "application/json"},
        body: json.encode({"DocEntry": "$docEntry"}),
      );
      log("statusCode: ${response.statusCode}");
      log("Einvoice resp: ${response.body}");

      log(
        "EInvoice: ${json.encode({
              "DocEntry": "$docEntry",
            })}",
      );
      log(' json.decode(response.body)::${json.decode(response.body)}');
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return AREinvoiceModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return AREinvoiceModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      // throw Exception(e);
      return AREinvoiceModel.error(
          'Restart the app or contact the admin!!..\n', 500);
    }
  }
}
