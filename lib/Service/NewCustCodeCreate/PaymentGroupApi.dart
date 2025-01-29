// ignore_for_file: prefer_single_quotes, avoid_print, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas, unnecessary_brace_in_string_interps

import 'dart:convert';
// import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/url/url.dart';

import '../../Constant/AppConstant.dart';

class GetPaymentGroupAPi {
  static Future<GetPaymentGroupModel> getGlobalData() async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
            "EXEC BZ_POS_GetPaymentGroupAPi"
            //  "Select GroupNum, PymntGroup from OCTG",
          }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      //  log("Terieri : " + json.decode(response.body).toString());
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GetPaymentGroupModel.fromJson(
            response.body, response.statusCode);
      } else {
        print(" pargroupException111: Error");
        return GetPaymentGroupModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      print("pargroupException222: $e");
      //  throw Exception("Exception: $e");
      return GetPaymentGroupModel.fromJson(e.toString(), 500);
    }
  }
}
