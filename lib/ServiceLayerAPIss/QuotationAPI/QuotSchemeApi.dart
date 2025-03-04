// ignore_for_file: file_names, prefer_single_quotes, require_trailing_commas, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import '../../Models/SchemeOrderModel/QuotScheme.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';

class SchemeQuteAPi {
  static Future<SchemeQuotModal> getGlobalData(
      List<SalesOrderScheme> salesOderSchene) async {
    try {
      final response = await http.post(
          Uri.parse('http://102.69.167.106:80/Api/DisCalculation_Quo'),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "SCHEMES": salesOderSchene.map((e) => e.toMap()).toList(),
          }));
      log('http://102.69.167.106:80/Api/DisCalculation_Quo');

      log("Quot SCHEMES Res: " + response.body);

      log("Quot SCHEMES Json: " +
          json.encode(
              {"SCHEMES": salesOderSchene.map((e) => e.toMap()).toList()}));

      if (response.statusCode == 200) {
        print(json.decode(response.body));
        return SchemeQuotModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        print(json.decode(response.body));
        // throw Exception("Error!!...");
        return SchemeQuotModal.issue(
          response.statusCode,
        );
      }
    } catch (e) {
      //  throw Exception("Exceptionsss: $e");
      return SchemeQuotModal.exception(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
