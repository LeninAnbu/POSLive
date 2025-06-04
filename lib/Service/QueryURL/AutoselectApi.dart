import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/QueryUrlModel/AutoselectModel.dart';

import '../../Constant/AppConstant.dart';

class AutoSelectApi {
  static Future<AutoSelectModl> getGlobalData(String itemCode) async {
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
                    "Pos_AutoBatch_GetFiFoQty',$itemCode,','${AppConstant.branch}'"
              }));
      log('Pos_AutoBatch_GetFiFoQty Response::${response.body}');
      print(response.statusCode);
      if (response.statusCode == 200) {
        return AutoSelectModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return AutoSelectModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('AutoSelectModl:::$e');

      return AutoSelectModl.error(e.toString(), 500);
    }
  }
}
