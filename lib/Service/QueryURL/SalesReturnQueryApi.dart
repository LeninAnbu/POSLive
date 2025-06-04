import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SalesRetqueryModel.dart';

class SalesReturnQryApi {
  static Future<OpenSalesReturnModel> getGlobalData(
      String siteCode, String docNum) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "Query":
                    "EXEC BZ_POS_SalesReturnQryApi '${AppConstant.branch}','$docNum' "
              }));

//5030420

      log("SalesReturn Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return OpenSalesReturnModel.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('message::${e.toString()}');

      return OpenSalesReturnModel.error(e.toString(), 500);
    }
  }
}
