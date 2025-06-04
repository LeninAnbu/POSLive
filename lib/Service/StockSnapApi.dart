import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Constant/AppConstant.dart';
import '../Models/Service Model/StockSnapModelApi.dart';
import '../url/url.dart';

class StockSnapModelApi {
  static Future<StocksnapModel> getData() async {
    try {
      final response = await http.get(
        Uri.parse(
            '${URL.url}ItemMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return StocksnapModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Error SS: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception SS: $e");
      throw Exception(e.toString());
    }
  }
}
