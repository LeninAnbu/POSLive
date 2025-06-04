import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/url/url.dart';
import '../Constant/AppConstant.dart';
import '../Models/Service Model/AddressMoasterModel.dart';

class AddressMasterApi {
  static Future<AddressrModel> getData() async {
    int resCode = 500;
    try {
      final response = await http.get(
        Uri.parse(
            '${URL.url}AddressMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      resCode = response.statusCode;
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        return AddressrModel.fromJson(json.decode(response.body), resCode);
      } else {
        log("Error AM: ${json.decode(response.body)}");
        throw Exception("Error");
      }
    } catch (e) {
      log("Exception AM: $e");

      return AddressrModel.error(e.toString(), resCode);
    }
  }
}
// {\"custcode\":\"D0002\",\"address1\":\"P. O. BOX 961\",\"address2\":null,\"address3\":null,\"city\":\"TANGA\",
// \"statecode\":null,\"pincode\":null,\"countrycode\":\"TZ\",\"geolocation1\":\"\",\"geolocation2\":\"\",
// \"createdateTime\":\"2023-08-12T07:59:49.637\",\"updatedDatetime\":\"2023-08-12T07:59:49.637\",\"createdUserID\":\"1\",
// \"updateduserid\":\"1\",\"lastupdateIp\":\"\",\"addresstype\":\"B\"},