import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/QueryUrlModel/IncomingReportModel.dart';

import '../../../Constant/AppConstant.dart';

class IncomingPaymentReportApi {
  static Future<IncomingReportsModel> getGlobalData(
      String sapUserCode, String fromDt, String toDate) async {
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
                    "EXEC  [IncomingPayment_report] '$fromDt','$toDate', '$sapUserCode'"
              }));

      log("IncomingPayment_report sts: ${response.statusCode}");
      log("IncomingPayment_report Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return IncomingReportsModel.fromJson(
            response.body, response.statusCode);
      } else {
        return IncomingReportsModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return IncomingReportsModel.fromJson(e.toString(), 500);
    }
  }
}
