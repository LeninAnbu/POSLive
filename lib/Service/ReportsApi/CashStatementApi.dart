import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/CashReportMdl.dart';

class Cashreportapi {
  static Future<CashReportModel> getGlobalData(
    String fromDate,
    String toDate,
  ) async {
    try {
      log('Step2::http://102.69.167.106:1705/api/SellerKit');
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_Cashreportapi '$fromDate','$toDate'"
                    // "SELECT  A.BaseRef [Document No], A.Location [Branch-Terminal], A.U_BaseType [Document Type], B.CardCode [Customer Code], B.CardName [Customer Name], SUM(A.Credit) [Rc amount], SUM(A.Debit) [Expenses], A.RefDate [Document Date] FROM JDT1 A INNER JOIN OCRD B ON A.ShortName=B.CardCode where a.RefDate between '$fromDate' and '$toDate' GROUP BY  A.BaseRef , A.Location , A.U_BaseType , B.CardCode , B.CardName , A.RefDate  Order by BaseRef"
              }));

      // log("chashReport Res: ${json.decode(response.body)}");
      log("CustomersReport Res: ${response.statusCode}");

      if (response.statusCode == 200) {
        return CashReportModel.fromJson(response.body, response.statusCode);
      } else {
        log('exp::${response.body}');

        // throw Exception("Error!!...");
        return CashReportModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return CashReportModel.error(e.toString(), 500);
    }
  }
}
