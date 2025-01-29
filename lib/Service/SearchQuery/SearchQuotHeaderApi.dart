import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';

class SerachQuotationHeadAPi {
  static Future<OpenSalesOrderHeader> getGlobalData(
      String fromDate, String toDate) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",

                // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_SerachQuotationHeadAPi   '$fromDate','$toDate','${AppConstant.branch}' "
                    // "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T0.DocStatus,T1.WhsCode,T0.CardCode,T0.CardName,T0.DocTotal from OQUT T0 join QUT1 T1 ON T0.DocEntry =T1.DocEntry Where T0.DocDate between '$fromDate' and '$toDate' AND T1.WhsCode='${AppConstant.branch}' order by  T0.DocDate desc,DocNum desc"
              }));

      // log("SQ Header Data Res: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return OpenSalesOrderHeader.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenSalesOrderHeader.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      log('SalsesOrderHeaderAPi::${e.toString()}');
      return OpenSalesOrderHeader.error(e.toString(), 500);
    }
  }
}
