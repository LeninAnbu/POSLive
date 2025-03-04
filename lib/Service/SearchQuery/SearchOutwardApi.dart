// "select distinct T0.docentry,T0.docnum, T0.docdate,T0.U_ReqWhs ReqWhs, T1.FromWhsCod,  T0.docStatus from owtr t0 inner join WTR1 T1 on t0.docentry=t1.docentry where T0.U_ReqWhs ='ARSFG' and T0.docDate Between 20241210, 20241212 order by t0.docentry desc"

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';

class SerachOutwardHeaderAPi {
  static Future<OpenSalesReqHeadersModl> getGlobalData(
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
                    "EXEC BZ_POS_SerachOutwardHeaderAPi  '${AppConstant.branch}', '$fromDate','$toDate'"
                // "select distinct  T0.CardCode,T0.CardName,T0.DocEntry, T0.DocNum, T0.DocDate,T0.U_ReqWhs, T1.FromWhsCod,T0.DocStatus from owtr t0 inner join WTR1 T1 on t0.DocEntry=t1.DocEntry where T1.FromWhsCod ='${AppConstant.branch}' and T0.DocDate Between'$fromDate' and '$toDate' order by T0.DocDate desc,t0.DocNum desc"
              }));

      // log("Serach Outward HeaderAPi " +
      //     json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "select distinct T0.CardCode,T0.CardName, T0.DocEntry,T0.DocNum, T0.DocDate,T0.U_ReqWhs, T1.FromWhsCod,  T0.DocStatus from owtr t0 inner join WTR1 T1 on t0.DocEntry=t1.DocEntry where T0.U_ReqWhs ='${AppConstant.branch}' and T0.DocDate Between '$fromDate' and '$toDate' order by t0.DocNum desc"
      //     }));

      // log("SerachOutwardHeaderAPi Res: " +
      //     json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return OpenSalesReqHeadersModl.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      log('SalsesOrderHeaderAPi::${e.toString()}');
      return OpenSalesReqHeadersModl.error(e.toString(), 500);
    }
  }
}
