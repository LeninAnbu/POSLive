import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/IncomingPaymentCardCodeModel.dart';

class IncomingPaymentDocNumAPi {
  static Future<IncomingPayCardCodeModel> getGlobalData(String docNum) async {
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
                "EXEC BZ_POS_IncomingPaymentDocNumAPi '$docNum'"
                    // "Select docentry, docnum, docdate, taxdate, cardcode, cardname, doctotal, paidtodate paid, doctotal-paidtodate balance from oinv where canceled ='n' and doctotal-paidtodate > 0 and docnum = '$docNum'"
              }));

      // log("Quot Header Data ${json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "Select docentry, docnum, docdate, taxdate, cardcode, cardname, doctotal, paidtodate paid, doctotal-paidtodate balance from oinv where canceled ='n' and doctotal-paidtodate > 0 and docnum = '$docNum'"
      //     })}");
      log("PayReceipt DocNum sts: ${response.statusCode}");

      // log("PayReceipt DocNum Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
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
      //  throw Exception("Exception: $e");
      return IncomingPayCardCodeModel.error(e.toString(), 500);
    }
  }
}
