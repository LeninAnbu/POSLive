import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../Models/QueryUrlModel/NewCashAccount.dart';

class NewCashCardAccountAPi {
  static Future<NewCashCardAccDetailsModel> getGlobalData(
    String siteCode,
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
                    "Select U_Mode, U_AcctName , U_AcctCode From [@POS_OPMA] T0 Inner Join [@POS_PMA1] T1 on T0.Code = T1.Code Where T0.U_Branch = '$siteCode'"
              }));

      log('New CashCard Acc Res::${json.decode(response.body)}');
      if (response.statusCode == 200) {
        return NewCashCardAccDetailsModel.fromJson(
            response.body, response.statusCode);
      } else {
        log("New CashCard Acc Res: ${json.decode(response.body)}");

        return NewCashCardAccDetailsModel.fromJson(
            response.body, response.statusCode);
      }
    } catch (e) {
      log('new cash exp::${e.toString()}');

      return NewCashCardAccDetailsModel.fromJson(e.toString(), 500);
    }
  }
}
