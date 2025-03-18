import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/NewSeriesMode.dart';

class Newseriesapi {
  static Future<NewSeriesMdl> getGlobalData(String objCode) async {
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
                    "BZ_POS_GetUserSeries '${AppConstant.sapUserName}','$objCode'"
              }));

      // log('"constr": "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;", "query": "BZ_POS_GetUserSeries "${AppConstant.branch}","$objCode""');
      log("Newseries Data Res: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return NewSeriesMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return NewSeriesMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('NewSeriesMdl:::$e');
      //  throw Exception("Exception: $e");
      return NewSeriesMdl.error(e.toString(), 500);
    }
  }
}
