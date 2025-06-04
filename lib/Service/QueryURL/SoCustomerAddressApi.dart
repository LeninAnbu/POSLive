import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';

class SOCustAddressApii {
  static Future<SOCustomerAddModel> getGlobalData(String docEntry) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_SOCustAddressApi '$docEntry' "
              }));
      log('message::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "select T0.DocEntry,T0.CardCode,T0.CardName,T2.PrintHeadr,T0.Address  from ORDR T0 Inner Join OCRD T1 On T0.CardCode=T1.CardCode cross join OADM T2 Where T0.DocEntry ='$docEntry'"
          })}');
      log("InvAddressApi Data Res: ${json.decode(response.body)}");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return SOCustomerAddModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return SOCustomerAddModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('SOCustomerAddModel:::$e');
      return SOCustomerAddModel.error(e.toString(), 500);
    }
  }
}
