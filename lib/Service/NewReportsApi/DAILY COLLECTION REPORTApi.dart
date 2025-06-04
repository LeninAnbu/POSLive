import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/NewReportsModel/CollectionReportModel.dart';

class CollectionReportApi {
  static Future<CollectionReport> getGlobalData(
    String frmDate,
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
                    "[BZ_POS_DAILY COLLECTION REPORT_R1] '$frmDate' , '$toDate' , '${AppConstant.branch}'"
              }));

      log("collection  Data Res: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return CollectionReport.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return CollectionReport.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('CollectionReport:::$e');

      return CollectionReport.error(e.toString(), 500);
    }
  }
}
