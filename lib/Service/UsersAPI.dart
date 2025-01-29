import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/LoginUserModel.dart';

import '../url/url.dart';

class UsersAPI {
  static Future<LoginUserModel> getData(
    String branch,
  ) async {
    int ressCode = 500;
    try {
      log('ccccccc::::${URL.url}TerminalLogin/Branch?Branch=$branch');
      final response = await http.get(
        Uri.parse('${URL.url}TerminalLogin/Branch?Branch=$branch'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      log(response.statusCode.toString());
      log("response users22:::${response.body}");

      if (response.statusCode == 200) {
        return LoginUserModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error users: ${json.decode(response.body)}");
        throw Exception("Error");
        // return AccountBalanceModel.exception('Error', ressCode);
      }
    } catch (e) {
      log("Exception user: $e");
      // throw Exception(e.toString());
      return LoginUserModel.exception(e.toString(), ressCode);
    }
  }
}
