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

    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_DepositsQueryAPi '$siteCode'"
              }));

      log("BZ_POS_DepositsQueryAPi sts: ${response.statusCode}");

      log("BZ_POS_DepositsQueryAPi Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return DepositQueryModel.fromJson(response.body, response.statusCode);
      } else {
        return DepositQueryModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return DepositQueryModel.fromJson(e.toString(), 500);
    }
  }
}
