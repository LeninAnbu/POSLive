import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
// import '../Models/Service Model/AddressMasterModel.dart';
import '../Constant/AppConstant.dart';
import '../Models/Service Model/BranchMasterModel.dart';
import '../url/url.dart';

class BranchMasterApi {
  static Future<BarnchMasterModel> getData() async {
    int ressCode = 500;

    try {
      //${URL.url}BranchMaster/ARSFG/T1
      final response = await http.get(
        Uri.parse(
            '${URL.url}BranchMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;
      // log(response.body.toString());
      // log("sk_Address_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        // Map data = json.decode(response.body);
        return BarnchMasterModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error Br: ${json.decode(response.body)}");
        // throw Exception("Error");
        return BarnchMasterModel.error('Error', ressCode);
      }
    } catch (e) {
      log("Exception Br: $e");
      //  throw Exception(e.toString());
      return BarnchMasterModel.error(e.toString(), ressCode);
    }
  }
}
