import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/OnhandModel.dart';

class OnhandApi {
  static Future<OnHandModels> getGlobalData(
      String itemCode, String whsCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "[dbo].[BZ_POS_OnHand] '$itemCode','$whsCode'"
              }));

      log("Onhand Data Res: ${json.decode(response.body)}");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return OnHandModels.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OnHandModels.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('OnHandModel:::$e');
      // throw (e);
      return OnHandModels.errors(e.toString(), 500);
    }
  }
}
