import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/LeadDateMdl.dart';

class NewLeadDateApi {
  static Future<LeadDateMdl> getGlobalData(String itemCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "[BZ_POS_LeadTime] '$itemCode'"
              }));

      log("NewLeadDateApi Data Res::[BZ_POS_LeadTime] $itemCode:: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return LeadDateMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return LeadDateMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('LeadDateMdl:::$e');
      //  throw Exception("Exception: $e");
      return LeadDateMdl.error(e.toString(), 500);
    }
  }
}
