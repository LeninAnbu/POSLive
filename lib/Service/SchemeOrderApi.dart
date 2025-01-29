import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../Models/SchemeOrderModel/SchemeOrderModel.dart';

class SchemeOrderAPi {
  static String? deviceId;
  static String? userCode;
  static String? password;

  static Future<SchemeOrderModal> getGlobalData(
      List<SalesOrderScheme> salesOderScheme) async {
    try {
      log('http://102.69.167.106:80/Api/DisCalculation_Order');
      final response = await http.post(
          Uri.parse('http://102.69.167.106:80/Api/DisCalculation_Order'),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "SCHEMES": salesOderScheme.map((e) => e.toMap()).toList(),
          }));

      log("Json:${json.encode({
            "SCHEMES": salesOderScheme.map((e) => e.toMap()).toList()
          })}");

      log("json ressss: ${response.body}");
      if (response.statusCode == 200) {
        return SchemeOrderModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        log(json.decode(response.body));

        log("error: ");
        throw Exception("Error!!...");
        // return SchemeOrderModal.issue(
        //   response.statusCode,
        // );
      }
    } catch (e) {
      log("SchemeOrder catch: $e");

      // throw Exception("Exceptionsss: $e");
      return SchemeOrderModal.exception(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
