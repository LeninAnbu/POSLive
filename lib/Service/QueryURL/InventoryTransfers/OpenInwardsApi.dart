import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/openStkQueryModel/StockOpenOutward.dart';

class OpenInwardAPi {
  static Future<OpenStkOutwardModl> getGlobalData(
    String siteCode,
  ) async {
    try {
//100008d-1001850, 1001919, 1002070

      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_OpenInwardAPi '$siteCode'"
              }));

      log("Openinward Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenStkOutwardModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OpenStkOutwardModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');

      return OpenStkOutwardModl.error(e.toString(), 500);
    }
  }
}
