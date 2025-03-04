import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';

class SerachReceiptHeaderAPi {
  static Future<OpenSalesOrderHeader> getGlobalData(
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

                // "constr": "Server=INSIGNIAC03313;Database=${GetValues.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_SerachReceiptHeaderAPi   '$fromDate','$toDate','${AppConstant.branch}'"
                    // "Select distinct  DocEntry,DocNum,DocDate,CardCode,CardName,DocTotal  from ORCT  A  Inner join OUSR B ON A.UserSign=B.USERID LEFT  JOIN [BZ_POS_Users] C ON C.SAPUserName=B.USER_CODE  Where A.DocDate between '$fromDate' and '$toDate' AND C.Branch='${AppConstant.branch}' order by DocDate desc,DocNum desc"
              }));

      // log("Receipt Header Res: " + json.decode(response.body).toString());
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
