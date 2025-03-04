import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesRetqueryModel.dart';

class SalesReturnQryCardCodeApi {
  static Future<OpenSalesReturnModel> getGlobalData(
      String siteCode, String cardCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "Query":
                "EXEC BZ_POS_SalesReturnQryCardCodeApi '$cardCode','${AppConstant.branch}'"
                    // "Select Distinct  T0.DocNum, T0.DocDate , T0.CardName   From OINV T0 Inner Join INV1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And T1.OpenQty > 0 And T0.CardCode = '$cardCode'  And T1.WhsCode = '${AppConstant.branch}' order by T0.DocDate desc,T0.DocNum desc"
              }));

      log('sales ret query::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "Query":
                " Select Distinct  T0.DocNum, T0.DocDate , T0.CardName ,   From OINV T0 Inner Join INV1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And T1.OpenQty > 0 And T0.CardCode = '$cardCode'  And T1.WhsCode = '${AppConstant.branch}'"
          })}');
      log("SalesReturn Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('message::${e.toString()}');
      //  throw Exception("Exception: $e");
      return OpenSalesReturnModel.error(e.toString(), 500);
    }
  }
}
