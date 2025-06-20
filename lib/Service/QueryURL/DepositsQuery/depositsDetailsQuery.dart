import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/DepositQryModel.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/depositsdetModel.dart';

class DepositsDetailsQueryAPi {
  static Future<DepositDetailsModel> getGlobalData(
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
                "query": "EXEC BZ_POS_GetBalDeposits '$siteCode'"
              }));

      log("Acc Data sts: ${response.statusCode}");

      log("Acc Data Res: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        return DepositDetailsModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return DepositDetailsModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return DepositDetailsModel.error(e.toString(), 500);
    }
  }
}
