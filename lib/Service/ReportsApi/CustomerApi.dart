import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/CustomerReportModel.dart';

class CustomersReportApi {
  static Future<CustomersReportModel> getGlobalData() async {
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
                "EXEC BZ_POS_CustomersReportApi"
                    // "SELECT A.CARDNAME[Customer Name],A.CARDCODE [CustomerCode],A.Balance [Balance],''[Points],A.E_Mail [Email id],A.Cellular [Phone No],A.VatGroup [TaxCode],A.CardType [Customer Type],A.Address [Customer Address]FROM OCRD A  where CardType='C'"
              }));

      // log("Cusotmer Repprt Res: ${json.decode(response.body)}");
      log("CustomersReport Res: ${response.statusCode}");

      if (response.statusCode == 200) {
        return CustomersReportModel.fromJson(
            response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return CustomersReportModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return CustomersReportModel.error(e.toString(), 500);
    }
  }
}
