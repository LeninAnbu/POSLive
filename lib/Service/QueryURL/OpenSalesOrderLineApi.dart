// http://102.69.167.106:1705/api/SellerKit

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderLineModel.dart';

class SalesOrderLineApi {
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
                "query": "EXEC BZ_POS_SalesOrderLineApi '$cardCode','$siteCode'"
              }));

      log("Line Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",

            "query":
                "Select distinct T0.DocEntry,T1.LineNum,T1.PriceBefDi,T1.ItemCode,T1.Dscription,T1.OpenQty,T1.WhsCode , T2.Onhand stock from ORDR T0 join RDR1 T1 On T0.DocEntry=T1.DocEntry Inner join  OITW T2 on T2.Itemcode = T1.Itemcode and T2.WhsCode = T1.Whscode  Where T0.DocStatus='O' and T1.LineStatus='O' and T0.CardCode='D0402' and T1.WhsCode='${AppConstant.branch}'" //'${GetValues.slpCode}'
          })}");

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      } else {
        return OpenSalesOrderLine.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      return OpenSalesOrderLine.fromJson(e.toString(), 500);
    }
  }
}
