import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/url/url.dart';

import '../../Models/Service Model/CustomerModel/AddressPachModel.dart';
import 'CreatecustPostApi copy.dart';

class PostAddressCreateAPi {
  static NewAddressModel? newCutomerAddModel;
  static Future<CreatePatchModel> getGlobalData(String? cardCode) async {
    try {
      log("${URL.sapUrl}BusinessPartners('$cardCode')");
      final response = await http.patch(
          Uri.parse("${URL.sapUrl}BusinessPartners('$cardCode')"),
          headers: {
            'content-type': 'application/json',
            "cookie": 'B1SESSION=${AppConstant.sapSessionID}'
          },
          body: json.encode({
            "BPAddresses":
                newCutomerAddModel!.newModel!.map((e) => e.tojson()).toList(),
          }));

      log('response code:::${response.statusCode}');
      log("response.body::${response.body}");

      log(json.encode({
        "BPAddresses": newCutomerAddModel!.newModel!
            .map(
              (e) => e.tojson(),
            )
            .toList()
      }));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        log("Success");
        return CreatePatchModel.fromJson(response.statusCode);
      } else {
        return CreatePatchModel.fromJson2(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("Exception22::$e");

      return CreatePatchModel.issue(e.toString(), 500);
    }
  }
}

class NewAddressModel {
  List<NewCutomeAdrsModel>? newModel;
  NewAddressModel({
    this.newModel,
  });
}
