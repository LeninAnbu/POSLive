import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../../Constant/AppConstant.dart';
import '../../../Models/Service Model/CreateCustPostModel.dart';

class CardCodeApi {
  static Future<CreateCustPostModel> getGlobalData() async {
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
                "EXEC BZ_POS_CardCodeApi"
                    // "Select CardCode, CardName From OCRD Where CardType = 'C'"
              }));
      log('CreateCust sts::${response.statusCode}');
      if (response.statusCode == 200) {
        return CreateCustPostModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return CreateCustPostModel.fromJson(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('CreateCustPostModel:::$e');
      return CreateCustPostModel.error(e.toString(), 500);
    }
  }
}
