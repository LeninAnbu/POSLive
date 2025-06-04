import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/url/url.dart';

import '../../Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/LoginModel/login_data.dart';

class PostRequestLoginAPi {
  static String? username;
  static String? password;

  static Future<Logindata> getGlobalData() async {
    try {
      log("Step11:::${"${URL.sapUrl}/Login"}");
      final response = await http.post(Uri.parse("${URL.sapUrl}/Login"),
          headers: {
            'Content-Type': 'application/json'
          }, //{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}
          body: json.encode({
            "CompanyDB": "${AppConstant.sapDB}",
            "UserName": AppConstant.sapUserName,
            "Password": AppConstant.sapPassword
          }));
      log(json.encode({
        "CompanyDB": "${AppConstant.sapDB}",
        "UserName": AppConstant.sapUserName,
        "Password": AppConstant.sapPassword,
      }));
      log("saplogin stcode11 ::${response.statusCode}");

      log("// saplogin: ${json.decode(response.body)}");

      if (response.statusCode == 200) {
        log("Step22");

        return Logindata.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log("// saplogin: ${json.decode(response.body)}");
        log("saplogin stcode22 ::${response.statusCode}");
        throw Exception("Error");
      }
    } catch (e) {
      log('Exception // saplogin: $e');
      throw Exception('Exception // saplogin: $e');
    }
  }
}
