import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';

class CompanyTinVatApii {
  static Future<CompanyTinVatMdl> getGlobalData() async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_CompanyTinVatApi"
              }));
      log('message::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query": "select TaxIdNum3 as tinNo, TaxIdNum2 as vatNo from OADM"
          })}');
      log("InvAddressApi Data Res: ${json.decode(response.body)}");

      print(response.statusCode);
      if (response.statusCode == 200) {
        return CompanyTinVatMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return CompanyTinVatMdl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('CompanyTinVatMdl:::$e');
      return CompanyTinVatMdl.error(e.toString(), 500);
    }
  }
}
