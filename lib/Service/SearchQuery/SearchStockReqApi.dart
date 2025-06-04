import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';

class SerachReqHeaderAPi {
  static Future<OpenSalesReqHeadersModl> getGlobalData(
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
                    "EXEC BZ_POS_SerachReqHeaderAPi  '${AppConstant.branch}','$fromDate','$toDate'"
              }));

      log("Receipt Header Res: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('SalsesOrderHeaderAPi::${e.toString()}');
      return OpenSalesReqHeadersModl.error(e.toString(), 500);
    }
  }
}
