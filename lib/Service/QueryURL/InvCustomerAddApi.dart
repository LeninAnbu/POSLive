import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/InvCustomerAddModel.dart';

class InvAddressApi {
  static Future<InvCustomerAddModel> getGlobalData(String docEntry) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_InvAddressApi '$docEntry'"
              }));
      log('message::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select T1.Address as address, Case When T5.LicTradNum IS Not NULL THEN  T5.LicTradNum Else T1.U_VAT_NUMBER End As  U_VAT_NUMBER, Case When T5.AddID IS Not NULL THEN  T5.AddID Else T1.U_TinNO End As 'U_TinNO' From OINV T1 INNER JOIN INV1 T2 ON T1.DocEntry=T2.DocEntry Left JOIN RDR1 T3 ON T3.DocEntry=T2.BaseEntry  And T2.ItemCode=T3.ItemCode Left JOIN ORDR T4 ON  T4.DocEntry=T3.DocEntry  INNER JOIN OCRD T5 ON T5.CardCode=T1.CardCode WHere T1.DocEntry ='$docEntry'"
          })}');

      print(response.statusCode);
      if (response.statusCode == 200) {
        return InvCustomerAddModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return InvCustomerAddModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('InvCustomerAddModel:::$e');
      return InvCustomerAddModel.error(e.toString(), 500);
    }
  }
}
