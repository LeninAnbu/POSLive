import 'dart:convert';
import 'dart:developer';

import 'package:posproject/Controller/ApiSettingsController/ApiSettingsController.dart';
import 'package:posproject/Controller/DownLoadController/DownloadController.dart';

import '../Models/Service Model/productMasterModel.dart';
import 'package:http/http.dart' as http;

import '../url/url.dart';

class NewProductsApi {
  static int resCode = 0;
  static Future<ProductMasterModsl> getData(
      String branch, String terminal) async {
    try {
      final stopwatch = Stopwatch()..start();
log("fff::"+"${URL.url}ProductMaster/$branch/$terminal");
      final response = await http.get(
        Uri.parse('${URL.url}ProductMaster/$branch/$terminal'),
        headers: {
          "content-type": "application/json",
        },
      );

      resCode = response.statusCode;
      log("prooofff sts::::${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        List<dynamic> responcedata = [];
        if (ApiSettingsController.productapisetting == true) {
          responcedata =
              await ApiSettingsController.jsonconvertProduct(response.body);
        } else {
          responcedata =
              await DownLoadController.jsonconvertProduct(response.body);
        }
        stopwatch.stop();
        log('API response.statusCode ${stopwatch.elapsedMilliseconds} milliseconds');

        return ProductMasterModsl.fromJson(
            responcedata as Map<String, dynamic>, response.statusCode);
      } else {
        print("Error: ${json.decode(response.body)}");
        return ProductMasterModsl.error(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      resCode = 500;
      log("Product Exception: " + e.toString());
      return ProductMasterModsl.error(e.toString(), resCode);
    }
  }

  // static Future<List<Map<String, dynamic>>> jsonconvertexamplex(
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
  //   await DBOperation.insertList(db, jsonList).then((value) {
  //     log("Inserted Product Master");
  //   });
  //   return jsonList;
  // }
}
