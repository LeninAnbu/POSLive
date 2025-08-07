import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/DepositReportModel.dart';

class DepositsReportAPi {
  static Future<DepositsReportsModel> getGlobalData(
      String sapUserCode, String fromDate, String toDate) async {
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
                    "EXEC [Deposit_Report] '$fromDate','$toDate', '$sapUserCode'"
              }));

      log("Deposit_Report sts: ${response.statusCode}");

      log("Deposit_Report Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return DepositsReportsModel.fromJson(
            response.body, response.statusCode);
      } else {
        return DepositsReportsModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return DepositsReportsModel.fromJson(e.toString(), 500);
    }
  }
}
