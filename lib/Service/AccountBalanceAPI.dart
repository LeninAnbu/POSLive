import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/Service Model/AccountBalModel.dart';
import '../url/url.dart';

class AccountBalApi {
  static Future<AccountBalanceModel> getData(String cardcode) async {
    int ressCode = 500;

    try {
      log('${URL.url}GetAccountBalance/$cardcode');
      final response = await http.get(
        Uri.parse('${URL.url}GetAccountBalance/$cardcode'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;

      log("AccBal Res::${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return AccountBalanceModel.fromJson(
            json.decode(response.body), ressCode);
      } else {
        log("Error AccBal: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception AB: $e");

      return AccountBalanceModel.exception(e.toString(), ressCode);
    }
  }
}
