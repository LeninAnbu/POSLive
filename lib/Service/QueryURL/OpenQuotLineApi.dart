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
                "query":
                    "EXEC BZ_POS_SalsesQuotLineAPi '$cardCode','$siteCode' "
              }));

      log("Quot Line Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T0.CardCode,T0.CardName,T0.DocTotal,T1.WhsCode from ORDR T0 join RDR1 T1 On T0.DocEntry=T1.DocEntry Where T0.DocStatus='O' and T1.LineStatus='O' and T1.WhsCode='$siteCode'",
          })}");

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      } else {
        log("Quot Data Line Res: ${json.decode(response.body)}");

        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      return OpenSalesOrderLine.fromJson(e.toString(), 500);
    }
  }
}
