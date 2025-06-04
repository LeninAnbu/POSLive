import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/CashReportMdl.dart';

class Cashreportapi {
  static Future<CashReportModel> getGlobalData(
    String fromDate,
    String toDate,
  ) async {
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
                "query": "EXEC BZ_POS_Cashreportapi '$fromDate','$toDate'"
              }));

      log("CustomersReport Res: ${response.statusCode}");

      if (response.statusCode == 200) {
        return CashReportModel.fromJson(response.body, response.statusCode);
      } else {
        log('exp::${response.body}');

        return CashReportModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return CashReportModel.error(e.toString(), 500);
    }
  }
}
