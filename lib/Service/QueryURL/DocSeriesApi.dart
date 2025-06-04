import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/DocSeriesMdl.dart';

class Newsdoceriesapi {
  static Future<NewDocSeriesMdl> getGlobalData(String objCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "[BZ_POS_GetSeries_Corp] '$objCode'"
              }));

      log("Docseries Data Res: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return NewDocSeriesMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return NewDocSeriesMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('NewDocSeriesMdl:::$e');

      return NewDocSeriesMdl.error(e.toString(), 500);
    }
  }
}
