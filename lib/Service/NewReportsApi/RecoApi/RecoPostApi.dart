import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/url/url.dart';

import '../../../Models/Service Model/RecoModel/RecoPostModel.dart';

class RecoPostAPi {
  static String? cardCodePost;
  static List<RecoPostModelData>? docLineQout;
  static String? docDate;
  static method() {
    log('step1:::${docLineQout!.length}');
    log('step12::${docDate}');

    final data = json.encode({
      "CardOrAccount": "coaCard",
      "ReconDate": "$docDate",
      "InternalReconciliationOpenTransRows":
          docLineQout!.map((e) => e.toJson3()).toList()
    });
    log('RecoPostAPi::$data');
  }

  static Future<RecoPostModel> getGlobalData(String? sessionID) async {
    try {
      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/InternalReconciliations",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${sessionID!}',
        },
        body: json.encode({
          "CardOrAccount": "coaCard",
          "ReconDate": "$docDate",
          "InternalReconciliationOpenTransRows":
              docLineQout!.map((e) => e.toJson3()).toList()
        }),
      );
      log("statucCode: ${response.statusCode}");
      log("bodyyy post order: ${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 210) {
        return RecoPostModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("bodyyy post order: ${response.body}");

        return RecoPostModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return RecoPostModel.exception(
          'Restart the app or contact the admin!!..\n', 500);
    }
  }
}
