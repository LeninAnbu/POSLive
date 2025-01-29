//{"CompanyDB":"MRP T1","UserName":"mwanza","Password":"8765"}

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
// import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';

class SerlayCancelQuoAPI {
  static int? stcodevalid;

// /http://102.69.167.106:50001/b1s/v1/Quotations(48386)/Cancel
  static Future<Cancelmodel> getData(String sapDocEntry) async {
    // Cancelmodel canlmdl = Cancelmodel();
    int? ressCode = 500;
    log("AppConstant.sapSessionID:::${AppConstant.sapSessionID}");
    try {
      log("cancell sapDocNum ::$sapDocEntry");
      final response = await http.post(
        Uri.parse(
            'http://102.69.167.106:50001/b1s/v1/Quotations($sapDocEntry)/Cancel'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      log('B1SESSION=${AppConstant.sapSessionID}');
      ressCode = response.statusCode;
      stcodevalid = response.statusCode;
      log("SalesQuocancel stscode::${response.statusCode}");
      log("SalesQuocancel response.body::${response.body}");

      if (response.statusCode == 204) {
        return Cancelmodel.fromJson(response.body, response.statusCode);
      } else {
        // print("SalesQuocancel Exception: Error");
        // throw Exception("Error");
        return Cancelmodel.exception(json.decode(response.body), ressCode);
      }
    } catch (e) {
      log("QuotCancelException:: $e");
      throw Exception("Error");
      // return Cancelmodel.exception(json.decode(e.toString()), ressCode!);
    }
  }
}

class Cancelmodel {
  int? statusCode;
  String? ordervalue;
  ErrorModel? exception;
  Cancelmodel({
    this.statusCode,
    this.ordervalue,
    this.exception,
  });

  factory Cancelmodel.fromJson(dynamic jsons, int statuscode) {
    if (statuscode == 204) {
      // var list = jsonDecode(jsons['data'] as String) as List;
      // List<AccountBalanceModelData> dataList =
      //     list.map((data) => AccountBalanceModelData.fromJson(data)).toList();
      log("jsonsjsons::$jsons");
      return Cancelmodel(
        statusCode: statuscode,
        ordervalue: jsons,
        exception: null,
      );
    } else {
      log("stcode$statuscode");
      return Cancelmodel(
        statusCode: statuscode,
        ordervalue: null,
        exception: null,
      );
    }
  }
  factory Cancelmodel.exception(Map<String, dynamic> json, int statuscode) {
    return Cancelmodel(
      exception: ErrorModel.fromJson(json['error']),
      statusCode: statuscode,
      ordervalue: null,
    );
  }
}
//  SalesQuo{error: {code: 301, message: {lang: en-us, value: Invalid session or session already timeout.}}}