// http://102.69.167.106:1705/api/SellerKit

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderLineModel.dart';

class SalsesQuotLineAPi {
  static Future<OpenSalesOrderLine> getGlobalData(
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

                // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_SalsesQuotLineAPi '$cardCode','$siteCode' "
                    // "Select distinct T0.DocEntry,T1.LineNum,T1.ItemCode,T1.Dscription,T1.OpenQty,T1.DiscPrcnt,T1.PriceBefDi,T1.WhsCode , t2.U_Pack_Size  from OQUT T0 join QUT1 T1 On T0.DocEntry=T1.DocEntry inner join oitm t2 on t2.itemcode=t1.itemcode  Where T0.DocStatus='O' and T1.LineStatus='O' and T0.CardCode='$cardCode' and T1.WhsCode='$siteCode'"
              }));

      log("Quot Line Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",

            // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T0.CardCode,T0.CardName,T0.DocTotal,T1.WhsCode from ORDR T0 join RDR1 T1 On T0.DocEntry=T1.DocEntry Where T0.DocStatus='O' and T1.LineStatus='O' and T1.WhsCode='$siteCode'",
          })}");

      // log("Quot Data Line Res: ${json.decode(response.body)}");

      // log('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      } else {
        log("Quot Data Line Res: ${json.decode(response.body)}");

        // throw Exception("Error!!...");
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      return OpenSalesOrderLine.fromJson(e.toString(), 500);
    }
  }
}
