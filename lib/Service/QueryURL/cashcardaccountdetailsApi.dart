import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/cashcardaccountsModel.dart';

class CashCardAccountAPi {
  static Future<CashCardAccDetailsModel> getGlobalData(
    String siteCode,
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
                "EXEC BZ_POS_CashCardAccountAPi '$siteCode'"
                    // "Select U_CashAcct, U_CreditAcct, U_ChequeAcct, U_WalletAcct, U_TransAcct From [@BZ_POSBR] Where U_WhsCode = '$siteCode'"
              }));
//${AppConstant.sapDB}

      // log("CashCardAccount Data::: ${json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "Select U_CashAcct, U_CreditAcct, U_ChequeAcct, U_WalletAcct, U_TransAcct From [@BZ_POSBR] Where U_WhsCode = '$siteCode'"
      //     })}");

      if (response.statusCode == 200) {
        return CashCardAccDetailsModel.fromJson(
            response.body, response.statusCode);
      } else {
        log("CashCard Acc Res: ${json.decode(response.body)}");

        // throw Exception("Error!!...");
        return CashCardAccDetailsModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return CashCardAccDetailsModel.fromJson(e.toString(), 500);
    }
  }
}
