import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../Models/Service Model/productMasterModel.dart';
import '../url/url.dart';

class ProductMasterApi {
  static Future<ProductMasterModsl> getData(
      String branch, String terminal) async {
    try {
      log("${URL.url}ProductMaster/$branch/$terminal");
      final response = await http.get(
        Uri.parse('${URL.url}ProductMaster/$branch/$terminal'),
        headers: {
          "content-type": "application/json",
        },
      );
      log("prooofff sts::::${response.statusCode.toString()}");
      log("prooofff res::::${response.body.toString()}");

      if (response.statusCode == 200) {
        return ProductMasterModsl.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Error PM: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception PM: $e");
      throw Exception(e.toString());
    }
  }
}
