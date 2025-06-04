import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Controller/DownLoadController/DownloadController.dart';
import '../Constant/AppConstant.dart';
import '../Controller/ApiSettingsController/ApiSettingsController.dart';
import '../Models/Service Model/CustomerMasterModel.dart';
import '../url/url.dart';

class CustomerMasterApi {
  static Future<CustomerModel> getData() async {
    int resCode = 500;

    try {
      log("${URL.url}CustomerMaster/${AppConstant.branch}/${AppConstant.terminal}");

      final response = await http.get(
        Uri.parse(
            '${URL.url}CustomerMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
      String csvData = response.body;
      List<dynamic> responcedata = [];

      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        if (ApiSettingsController.customerapisetting == true) {
          responcedata =
              await ApiSettingsController.jsonconvertCustomer(response.body);
        } else {
          responcedata =
              await DownLoadController.jsonconvertCustomer(response.body);
        }

        return CustomerModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Error CM: ${json.decode(response.body)}");

        return CustomerModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception CM: $e");

      return CustomerModel.error(e.toString(), resCode);
    }
  }
}
