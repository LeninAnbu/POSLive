import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/CreditLimitandDaysModel.dart';

class CustCreditLimitAPi {
  static Future<CreditLimitModel> getGlobalData(
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
                "query":
                "EXEC BZ_POS_CustCreditLimitAPi '$cardCode'"
                    // "Select CreditLine from OCRD  where CardCode='$cardCode'"
              }));
//${AppConstant.sapDB}

      // log("CashCardAccount Data::: ${json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query": "Select CreditLine from OCRD  where CardCode='$cardCode'"
      //     })}");

      // log("CashCard Acc Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return CreditLimitModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return CreditLimitModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return CreditLimitModel.exception(e.toString(), 500);
    }
  }
}
