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
      //${URL.url}CustomerMaster/ARSFG/T1
      final response = await http.get(
        Uri.parse(
            '${URL.url}CustomerMaster/${AppConstant.branch}/${AppConstant.terminal}'),
        headers: {
          "content-type": "application/json",
        },
      );
        String csvData = response.body;
        List<dynamic> responcedata = [];
      // resCode = response.statusCode;
      log(response.statusCode.toString());
      // log("cussk_inventory_master_data${json.decode(response.body)}");
      if (response.statusCode == 200) {
        if (ApiSettingsController.customerapisetting == true) {
       responcedata =
              await ApiSettingsController.jsonconvertCustomer(response.body);
        } else {
          responcedata =
              await DownLoadController.jsonconvertCustomer(response.body);
        }
        // Map data = json.decode(response.body);
        return CustomerModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("Error CM: ${json.decode(response.body)}");
        // throw Exception("Error");
        return CustomerModel.error('Error', resCode);
      }
    } catch (e) {
      log("Exception CM: $e");
      // throw Exception(e.toString());
      return CustomerModel.error(e.toString(), resCode);
    }
  }

  // static Future<List<Map<String, dynamic>>> jsonconvertCustomer(
  //     String tabularData) async {
  //   final Database db = (await DBHelper.getInstance())!;

  //   List<String> lines = tabularData.split('\n');
  //   List<String> headers = lines[0].split('\t');
  //   List<Map<String, dynamic>> jsonList = [];
  //   for (int i = 1; i < lines.length; i++) {
  //     List<String> values = lines[i].split('\t');
  //     if (values.length == headers.length) {
  //       // log('headersheaders::${headers.length}');
  //       Map<String, dynamic> jsonItem = {};
  //       for (int j = 0; j < headers.length; j++) {
  //         jsonItem[headers[j]] = values[j];
  //       }
  //       jsonList.add(jsonItem);
  //     }
  //   }
  //   log('jsonListjsonList::${jsonList.length}');

  //   await DBOperation.insertCustomer(db, jsonList).then((value) {
  //     log("Inserted Customer Master");
  //   });

  //   return jsonList;
  // }
}
