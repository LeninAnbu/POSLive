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
      final response = await http.get(
        Uri.parse(
            '${URL.url}BranchMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      ressCode = response.statusCode;

      if (response.statusCode == 200) {
        return BarnchMasterModel.fromJson(json.decode(response.body), ressCode);
      } else {
        log("Error Br: ${json.decode(response.body)}");

        return BarnchMasterModel.error('Error', ressCode);
      }
    } catch (e) {
      log("Exception Br: $e");

      return BarnchMasterModel.error(e.toString(), ressCode);
    }
  }
}
