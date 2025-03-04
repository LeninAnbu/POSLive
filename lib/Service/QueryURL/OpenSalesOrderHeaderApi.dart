// http://102.69.167.106:1705/api/SellerKit

// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';

class SalsesOrderHeaderAPi {
  static Future<OpenSalesOrderHeader> getGlobalData(
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
                "EXEC BZ_POS_SalsesOrderHeaderAPi '$cardCode','$siteCode'"
                    // "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T0.Comments,T0.CardCode,T0.CardName,T0.DocTotal,T1.WhsCode from ORDR T0 join RDR1 T1 On T0.DocEntry=T1.DocEntry Where T0.DocStatus='O' and T1.LineStatus='O' and T0.CardCode='$cardCode' and T1.WhsCode='$siteCode' order by T0.DocDate desc, T0.DocNum desc",
                //'${GetValues.slpCode}'
              }));

      // log("Order Header Data " +
      //     json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",

      //       // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "Select distinct T0.DocEntry,T0.DocNum,T0.DocDate,T0.CardCode,T0.CardName,T0.DocTotal,T1.WhsCode from ORDR T0 join RDR1 T1 On T0.DocEntry=T1.DocEntry Where T0.DocStatus='O' and T1.LineStatus='O' and T0.CardCode='$cardCode' and T1.WhsCode='$siteCode'",
      //     }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // log("SO Header Data Res: " + json.decode(response.body).toString());
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
