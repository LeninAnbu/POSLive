// http://102.69.167.106:1705/api/SellerKit

// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';

class SalsesQuotHeaderAPi {
  static Future<OpenSalesOrderHeader> getGlobalData(
      String siteCode, String cardCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                    "EXEC BZ_POS_SalsesQuotHeaderAPi '$cardCode','$siteCode'"
              }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return OpenSalesOrderHeader.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OpenSalesOrderHeader.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('OpenSalesOrderHeader:::$e');

      return OpenSalesOrderHeader.error(e.toString(), 500);
    }
  }
}
