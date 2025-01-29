import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/ReturnRegisterModel.dart';

class Retrunregisterapi {
  static Future<ReturnRegtModel> getGlobalData(
    String fromDate,
    String toDate,
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
                "EXEC BZ_POS_Retrunregisterapi '$fromDate','$toDate'"
                    // "SELECT A.DocNum [Document number],B.LocCode [Branch],'' [Terminal] ,A.CardName [Customer Name],A.CardCode [Customer Code],B.ItemCode [Item Code],B.Dscription [Item Name],A.DocDate [DATE] FROM ORIN A INNER JOIN RIN1 B ON A.DocEntry=B.DocEntry where a.DocDate between '$fromDate' and '$toDate' Order by A.DocNum"
              }));

      log("Return reg Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return ReturnRegtModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return ReturnRegtModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return ReturnRegtModel.error(e.toString(), 500);
    }
  }
}
