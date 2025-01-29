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
      //23-25942
      //23-28163

//100008d-1001850, 1001919, 1002070
      //100515d-21-1075 , 23-19416

      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_OpenInwardAPi '$siteCode'"
                // "select DISTINCT T2.DocNum, T2.DocEntry, T2.Filler FromWhs, T2.DocDate from wtr1 T0 Inner Join owtr T2 on T2.DocEntry = T0.DocEntry Left Join WTR1 T1 on T0.DocEntry = T1.U_BaseEntry And T0.LineNum = T1.U_BaseLine where U_ReqWhs = '$siteCode' Group by T0.LineNum ,T2.DocNum, T2.DocEntry, T2.Filler,T0.Quantity, T2.DocDate Having T0.Quantity - IsNull(Sum(T1.Quantity),0) > 0"
              }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log("Openinward Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenStkOutwardModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenStkOutwardModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');
      //  throw Exception("Exception: $e");
      return OpenStkOutwardModl.error(e.toString(), 500);
    }
  }
}
