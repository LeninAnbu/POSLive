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
      log("EXEC BZ_POS_Retrunregisterapi '$fromDate','$toDate'");
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_Retrunregisterapi '$fromDate','$toDate'"
              }));

      log("Return reg Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return ReturnRegtModel.fromJson(response.body, response.statusCode);
      } else {
        return ReturnRegtModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');

      return ReturnRegtModel.error(e.toString(), 500);
    }
  }
}
