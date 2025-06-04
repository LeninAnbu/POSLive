import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/NewReportsModel/GetReportFieldModel.dart';

class NewFieldReportApi {
  static Future<NewReportFieldMdl> getGlobalData(String code) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_NewFieldReportApi '$code'"
              }));

      log("New report field Res: ${json.decode(response.body)}");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return NewReportFieldMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return NewReportFieldMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('NewReportFieldMdl:::$e');

      return NewReportFieldMdl.error(e.toString(), 500);
    }
  }
}
