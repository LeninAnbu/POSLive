import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/QueryUrlModel/cashinhandmodel.dart';

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/DepositsQueryModel/ChequeDepositModel.dart';

class CashInHandQueryAPi {
  static Future<CashInHandModel> getGlobalData(
    String accCode,
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
                "query": "Select currtotal from oact where Acctcode ='$accCode'"
              }));

      log("Acc Data sts: ${response.statusCode}");

      if (response.statusCode == 200) {
        return CashInHandModel.fromJson(response.body, response.statusCode);
      } else {
        return CashInHandModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return CashInHandModel.fromJson(e.toString(), 500);
    }
  }
}
