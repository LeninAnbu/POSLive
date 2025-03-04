// "select distinct T0.docentry,T0.docnum, T0.docdate,T0.U_ReqWhs ReqWhs, T1.FromWhsCod,  T0.docStatus from owtr t0 inner join WTR1 T1 on t0.docentry=t1.docentry where T0.U_ReqWhs ='ARSFG' and T0.docDate Between 20241210, 20241212 order by t0.docentry desc"

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ExpenseModel/SearchExpHeaderModel.dart';

class SerachExpHeaderAPi {
  static Future<SearchExpHeaderMdl> getGlobalData(
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
                    "EXEC BZ_POS_SerachExpHeaderAPi '$fromDate','$toDate' , '${AppConstant.branch}'"
                // "Select DocNum, DocEntry, DocDate, CashSum,Status, A.Address,  JrnlMemo from ovpm  A  Inner join OUSR B ON A.UserSign=B.USERID LEFT  JOIN [BZ_POS_Users] C ON C.SAPUserName=B.USER_CODE  Where A.DocDate between '$fromDate' and '$toDate' AND C.Branch='${AppConstant.branch}' order by DocDate desc,DocNum desc"
              }));

      // log("SerachExpHeader " +
      //     json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "Select DocNum, DocEntry, DocDate, CashSum,Status, A.Address,  JrnlMemo from ovpm  A  Inner join OUSR B ON A.UserSign=B.USERID LEFT  JOIN [BZ_POS_Users] C ON C.SAPUserName=B.USER_CODE  Where A.DocDate between '$fromDate' and '$toDate' AND C.Branch='${AppConstant.branch}' order by DocDate desc,DocNum desc"
      //          }));

      // log("Serach Exp Header Res: " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return SearchExpHeaderMdl.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return SearchExpHeaderMdl.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      //  throw Exception("Exception: $e");
      log('SerachExpHeader::${e.toString()}');
      return SearchExpHeaderMdl.error(e.toString(), 500);
    }
  }
}
