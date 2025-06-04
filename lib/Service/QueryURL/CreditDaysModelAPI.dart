import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/CreditLimitandDaysModel.dart';

class CustCreditDaysAPI {
  static Future<CreditDaysModel> getGlobalData(
    String cardCode,
  ) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_CustCreditDaysAPI '$cardCode'"
              }));

      log("CustCreditDaysAPI Acc Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return CreditDaysModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return CreditDaysModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return CreditDaysModel.exception(e.toString(), 500);
    }
  }
}
