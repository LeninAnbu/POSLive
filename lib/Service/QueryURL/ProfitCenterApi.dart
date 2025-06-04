import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/Profitcentermodel.dart';

class ProfitCenterApii {
  static Future<ProfitCentermdl> getGlobalData() async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "[BZ_POS_ProfitCenter]"
              }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return ProfitCentermdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return ProfitCentermdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('ProfitCentermdl:::$e');
      return ProfitCentermdl.error(e.toString(), 500);
    }
  }
}
