import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';

class SerachInvoiceHeadAPi {
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
                "query":
                "EXEC BZ_POS_SerachInvoiceHeadAPi '$fromDate','$toDate' , '${AppConstant.branch}' "
                    // "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T1.whscode,T0.CardCode,T0.CardName,T0.DocTotal,T0.DocStatus from OINV T0 join INV1 T1 on T0.DocEntry=T1.DocEntry Where T0.DocDate between '$fromDate' and '$toDate' AND T1.WhsCode='${AppConstant.branch}' order by  T0.DocDate desc,DocNum desc"
              }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return OpenSalesOrderHeader.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SQ Header Data Res: " + json.decode(response.body).toString());

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
