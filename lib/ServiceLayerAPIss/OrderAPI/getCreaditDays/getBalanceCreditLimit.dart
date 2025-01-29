import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/CreditDaysModal/BalanceCredit.dart';
import '../../../url/url.dart';

class GetBalanceCreditAPi {
  static String? cardCode;
  static Future<BalanceCreaditModal> getGlobalData() async {
    log(" ${URL.sapUrl}/SQLQueries('CreditLimit')/List?CardCode='$cardCode'");
    try {
      final response = await http.get(
        Uri.parse(
          "${URL.sapUrl}/SQLQueries('CreditLimit')/List?CardCode='$cardCode'", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          'Prefer': 'odata.maxpagesize=20' //${GetValues.maximumfetchValue}'
        },
      );
      log('CreditLimit.statusCode::${response.statusCode}');
      log('CreditLimit.::${response.body}');

      if (response.statusCode == 200) {
        // print("GetBalanceCreditAPi:: "+json.decode(response.body).toString());
        return BalanceCreaditModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        log(json.decode(response.body));
        log(response.statusCode.toString());
        // throw Exception('Restart the app or contact the admin!!..');
        return BalanceCreaditModal.issue(
            'Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
      return BalanceCreaditModal.issue(
          'Restart the app or contact the admin!!..');
    }
  }
}
