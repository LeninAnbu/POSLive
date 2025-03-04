import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/DepositQryModel.dart';

class DepositsQueryAPi {
  static Future<DepositQueryModel> getGlobalData(
    String siteCode,
  ) async {
    log("Select CurrTotal CashBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_CashAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode'");
    // Select CurrTotal CardBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_CreditAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal WalletBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_WalletAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal ChequeBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_ChequeAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode'");

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
                "EXEC BZ_POS_DepositsQueryAPi '$siteCode'"
                    // "Select CurrTotal CashBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_CashAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode'"
              }));
      // Select CurrTotal CardBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_CreditAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal WalletBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_WalletAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode' Select CurrTotal ChequeBalance From [@BZ_POSBR] T0 Inner Join OACT T1 on T0.U_ChequeAcct = T1.AcctCode Where T0.U_WhsCode = '$siteCode'"

      log("Acc Data sts: ${response.statusCode}");

      log("Acc Data Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return DepositQueryModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return DepositQueryModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return DepositQueryModel.fromJson(e.toString(), 500);
    }
  }
}
