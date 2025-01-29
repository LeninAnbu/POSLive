import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Constant/AppConstant.dart';
import '../Models/ExpenseModel/ExpenseGetModel.dart';
import '../url/url.dart';

class ExpanseMasterApi {
  static Future<ExpenseGetModel> getData() async {
    int resCode = 500;
    try {
      final response = await http.get(
        Uri.parse(
            '${URL.url}ExpenseMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      resCode = response.statusCode;
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return ExpenseGetModel.fromJson(json.decode(response.body), resCode);
      } else {
        log("Error Exp: ${json.decode(response.body)}");
        return ExpenseGetModel.error('404 not found..!!', response.statusCode);
      }
    } catch (e) {
      log("Exception Exp: $e");
      return ExpenseGetModel.error(e.toString(), 500);
    }
  }
}
