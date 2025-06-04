import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ReportsModel/AddressRepModel.dart';

class Addressreportapi {
  static Future<AddressReportModel> getGlobalData(String cardCode) async {
    try {
      log('Step2::http://102.69.167.106:1705/api/SellerKit');
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_Addressreportapi '$cardCode'"
              }));

      log("Address Res: ${json.decode(response.body)}");
      log("CustomersReport Res: ${response.statusCode}");

      if (response.statusCode == 200) {
        return AddressReportModel.fromJson(response.body, response.statusCode);
      } else {
        return AddressReportModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return AddressReportModel.error(e.toString(), 500);
    }
  }
}
