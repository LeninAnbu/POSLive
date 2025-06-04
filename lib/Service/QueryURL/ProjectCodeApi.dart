import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/ProjectCodeModel.dart';

class NewProjectCodeApi {
  static Future<ProjectCodeMdl> getGlobalData() async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "BZ_POS_ProjectCode"
              }));

      print(response.statusCode);
      if (response.statusCode == 200) {
        return ProjectCodeMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return ProjectCodeMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('ProjectCodeMdl:::$e');

      return ProjectCodeMdl.error(e.toString(), 500);
    }
  }
}
