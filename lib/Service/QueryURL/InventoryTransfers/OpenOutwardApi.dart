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
                "query":
                "EXEC BZ_POS_OpenOutwardAPi '$siteCode'"
                    // "Select Distinct T0.DocEntry, T0.DocNum, T0.DocDate, U_ReqWhs, T0.ToWhsCode From OWTQ T0 Inner Join WTQ1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And U_ReqWhs is Not Null And T0.Filler='$siteCode' Order By T0.DocDate"
              }));

      log("OpenReq Header Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select  Distinct T0.DocEntry , T0.DocNum , T0.DocDate ,U_ReqWhs ,T0.ToWhsCode From OWTQ T0 Inner Join WTQ1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And U_ReqWhs is Not Null And T0.Filler='$siteCode' Order By T0.DocDate"
          })}");

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log("OpenOutward Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');
      //  throw Exception("Exception: $e");
      return OpenSalesReqHeadersModl.error(e.toString(), 500);
    }
  }
}
