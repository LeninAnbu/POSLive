// To parse this JSON data, do
//
//     final depositDetailsModel = depositDetailsModelFromJson(jsonString);

import 'dart:developer';

import 'package:meta/meta.dart';
import 'dart:convert';

class DepositDetailsModel {
  bool? status;
  String? msg;

  String? error;
  int? statusCode;
  List<DepositDetailsQueryData> data;

  DepositDetailsModel({
    required this.status,
    required this.msg,
    required this.error,
    required this.statusCode,
    required this.data,
  });

  factory DepositDetailsModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<DepositDetailsQueryData> dataList = list
            .map((dynamic enquiries) =>
                DepositDetailsQueryData.fromJson(enquiries))
            .toList();
        return DepositDetailsModel(
          data: dataList,
          msg: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return DepositDetailsModel(
          msg: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          data: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return DepositDetailsModel(
        msg: '',
        status: null,
        data: [],
        error: '',
        statusCode: stcode,
      );
    }
  }

  factory DepositDetailsModel.error(String e, int stcode) {
    return DepositDetailsModel(
      msg: null,
      status: null,
      data: [],
      error: '$e',
      statusCode: stcode,
    );
  }
}

//  "data": "[{\"AllocAcct\":\"_SYS00000001085\",\"AcctName\":\"Cash in Hand (UB)\",\"setteled\":0.000000,\"Collected\":321299955.758190}]"
class DepositDetailsQueryData {
  String allocAcct;
  String acctName;
  double setteled;
  double collected;
  double unSettled;

  DepositDetailsQueryData({
    required this.allocAcct,
    required this.acctName,
    required this.setteled,
    required this.unSettled,
    required this.collected,
  });

  factory DepositDetailsQueryData.fromJson(dynamic jsons) {
    return DepositDetailsQueryData(
      allocAcct: jsons['AllocAcct'] ?? '',
      acctName: jsons['AcctName'] ?? '',
      setteled: jsons['setteled'] ?? 0,
      collected: jsons['Collected'] ?? 0,
      unSettled: jsons['Unsetteled'] ?? 0,
    );
  }
}
