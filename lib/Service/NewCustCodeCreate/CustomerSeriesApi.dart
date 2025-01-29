import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:posproject/url/url.dart';

import '../../Constant/AppConstant.dart';
import '../../Models/Service Model/CusotmerSeriesModel.dart';

class GetSeriesApiAPi {
  static Future<CustSeriesModel> getGlobalData() async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
            "EXEC BZ_POS_GetSeriesApi"
                // "Select Series, SeriesName From nnm1 Where ObjectCode = '2' And DocSubType = 'C'",
          }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return CustSeriesModel.fromJson(response.body, response.statusCode);
      } else {
        log("series Exception11: Error");
        return CustSeriesModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log("seriesException22: $e");
      //  throw Exception("Exception: $e");
      return CustSeriesModel.fromJson(e.toString(), 500);
    }
  }
}
