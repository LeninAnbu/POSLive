import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/NewReportsModel/NewChangeReportModel.dart';

class NewReportApi {
  static Future<NewReportMdl> getGlobalData() async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_NewReportApi"
              }));

      log("New Changed sts: ${response.statusCode}");
      log("New Changed Res: ${json.decode(response.body)}");

      log(json.encode({
        "constr":
            "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
        "query": "EXEC BZ_POS_NewReportApi"
      }));
      print(response.statusCode);
      if (response.statusCode == 200) {
        return NewReportMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return NewReportMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('NewReportMdl:::$e');

      return NewReportMdl.error(e.toString(), 500);
    }
  }
}
