import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/IncomingPaymentCardCodeModel.dart';

class IncomingPaymentCardCodeAPi {
  static Future<IncomingPayCardCodeModel> getGlobalData(String cardCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_IncomingPaymentCardCodeAPi '$cardCode'"
              }));

      log("PayReceipt Data Res: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return IncomingPayCardCodeModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return IncomingPayCardCodeModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('IncomingPayCardCodeModel:::$e');

      return IncomingPayCardCodeModel.error(e.toString(), 500);
    }
  }
}
