import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/Service%20Model/PettyCashModel.dart';

import '../url/url.dart';

class PettyCashModelAPI {
  static Future<PettyCashModel> getData(
    String branch,
  ) async {
    int ressCode = 500;
    try {
      final response = await http.get(
        Uri.parse(
            '${URL.url}GetAccountDetails/Branch?Branch=${AppConstant.branch}'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      log(response.statusCode.toString());
      log("Petty cash response:::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return PettyCashModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error userlogin: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception userlogin: $e");
      throw Exception(e.toString());
    }
  }
}
