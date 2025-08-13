// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, file_names

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../url/url.dart';

class PostMaxCommitAPi {
  static String? cardCodePost;
  static String? value;
  static Future<void> getGlobalData() async {
    final data = json.encode({"MaxCommitment": "$value"});
    log(data);
    try {
      final response = await http.patch(
        Uri.parse(
          URL.sapUrl + "BusinessPartners('$cardCodePost')",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          "Prefer": "return-no-content"
        },
        body: json.encode({"MaxCommitment": "$value"}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log(response.body);
        log("statucCode BusinessPartners: " + response.statusCode.toString());
      } else {
        log("Responce: " + (json.decode(response.body).toString()));
        log("statucCode: " + response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
