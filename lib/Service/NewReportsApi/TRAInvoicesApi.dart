import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/NewReportsModel/TestTableModel.dart';

class CreateTableApi {
  static Future<TestModel> getGlobalData(
    String frmDate,
    String toDate,
  ) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                    "[TRA Invoices user specific-1]  '$frmDate' , '$toDate' , '${AppConstant.branch}'"
              }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return TestModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return TestModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('TestModel:::$e');

      return TestModel.error(e.toString(), 500);
    }
  }
}
