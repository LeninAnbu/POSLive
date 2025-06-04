import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';

class OpenOutwardAPi {
  static Future<OpenSalesReqHeadersModl> getGlobalData(
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
                "query": "EXEC BZ_POS_OpenOutwardAPi '$siteCode'"
              }));

      // log("OpenOutward Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');

      return OpenSalesReqHeadersModl.error(e.toString(), 500);
    }
  }
}
