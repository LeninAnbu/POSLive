import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/url/url.dart';

import '../../Constant/AppConstant.dart';

class GetTeriteriAPi {
  static Future<GetTeriteriModel> getGlobalData() async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
            "EXEC BZ_POS_GetTeriteriAPi" 
            // "Select territryID, descript From OTER where parent > 0",
          }));

      // print('B1SESSION='+ GetValues.sessionID.toString());
      // print('odata.maxpagesize=${GetValues.maximumfetchValue}');
      // log("Terieri : " + json.decode(response.body).toString());
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return GetTeriteriModel.fromJson(response.body, response.statusCode);
      } else {
        log("teriteriException11: Error");
        return GetTeriteriModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log("teriteriException:22 $e");
      //  throw Exception("Exception: $e");
      return GetTeriteriModel.fromJson(e.toString(), 500);
    }
  }
}
