import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/Service%20Model/LoginUserModel.dart';
import 'package:posproject/url/url.dart';

class LoginUserAPI {
  static Future<LoginUserModel> getData(
      String userCode, String fcmToken) async {
    int ressCode = 500; //

    try {
      log('Login Url:::${URL.url}LoginAuth/UserCode/Password/Terminal/Branch/FcmToken?UserCode=$userCode&Password=1234&Terminal=${AppConstant.terminal}&Branch=${AppConstant.branch}&FcmToken=$fcmToken');
      final response = await http.get(
        Uri.parse(
            '${URL.url}LoginAuth/UserCode/Password/Terminal/Branch/FcmToken?UserCode=$userCode&Password=1234&Terminal=${AppConstant.terminal}&Branch=${AppConstant.branch}&FcmToken=$fcmToken'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      log(response.statusCode.toString());
      log("login response:::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return LoginUserModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error userlogin: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception userlogin: $e");

      return LoginUserModel.exception(e.toString(), ressCode);
    }
  }
}
