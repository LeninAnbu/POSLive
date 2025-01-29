import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/LoginModel/login_data.dart';
import '../../url/url.dart';

class PostOrderLoginAPi {
  static String? username;
  static String? password;

  static Future<Logindata> getGlobalData() async {
    try {
      log("Step11:::$password");
      final response = await http.post(Uri.parse("${URL.sapUrl}/Login"),
          headers: {'Content-Type': 'application/json'},
          //{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}
          body: json.encode({
            "CompanyDB": "${AppConstant.sapDB}",
            "UserName": "$username", //"api"
            "Password": "$password"
          }));
      // "UserName": "api",
      // "Password": "1234"
      log("S Order:::${json.encode({
            "CompanyDB": "${AppConstant.sapDB}",
            "UserName": "$username",
            "Password": "$password"
          })}");
      log("saplogin stcode11 ::${response.statusCode}");

      log("saplogin: ${json.decode(response.body)}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Step22");

        return Logindata.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("saplogin: ${json.decode(response.body)}");
        log("saplogin stcode22 ::${response.statusCode}");
        throw Exception("Error");
        // return Logindata.error(
        //     json.decode(response.body) as Map<String, dynamic>,
        //     response.statusCode);
      }
    } catch (e) {
      log('Exception saplogin: $e');
      // throw Exception('Exception saplogin: $e');
      return Logindata.issue('Restart the app or contact the admin!!..', 500);
    }
  }
}
