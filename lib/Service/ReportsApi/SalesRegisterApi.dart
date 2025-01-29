import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/SaelsRegisterModel.dart';

class Salesregisterapi {
  static Future<SalesRegReportModel> getGlobalData(
    String fromDate,
    String toDate,
  ) async {
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
                "EXEC BZ_POS_Salesregisterapi '$fromDate','$toDate'"
                    // "SELECT A.DocNum [Document number],B.LocCode [Branch],'' [Terminal] ,A.CardName [Customer Name],A.CardCode [Customer Code],B.ItemCode [Item Code],B.Dscription [Item Name],A.DocDate [DATE]FROM OINV A INNER JOIN INV1 B ON A.DocEntry=B.DocEntry where a.DocDate between '$fromDate' and '$toDate' order by A.DocNum"
              }));

      log("Sales Reg Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return SalesRegReportModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return SalesRegReportModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return SalesRegReportModel.error(e.toString(), 500);
    }
  }
}
