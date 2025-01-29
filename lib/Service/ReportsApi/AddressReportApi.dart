import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ReportsModel/AddressRepModel.dart';

class Addressreportapi {
  static Future<AddressReportModel> getGlobalData(String cardCode) async {
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
                "EXEC BZ_POS_Addressreportapi '$cardCode'"
                    // "Select B.Address [Address1],B.Address2 [Address2],B.Address3 [Address3],B.State [State code],B.Country [Country code] ,'' [Geolocation1],'' [Geolocation2],B.ZipCode [Pincode],A.CardCode [Cust code] from OCRD A inner Join CRD1 B on A.CardCode=B.CardCode WHERE A.CardCode ='$cardCode'"
              }));

      // log("Address Res: ${json.decode(response.body)}");
      log("CustomersReport Res: ${response.statusCode}");

      if (response.statusCode == 200) {
        return AddressReportModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return AddressReportModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return AddressReportModel.error(e.toString(), 500);
    }
  }
}
