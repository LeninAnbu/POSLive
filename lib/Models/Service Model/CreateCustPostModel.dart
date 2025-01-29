// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes

import 'dart:convert';

import '../DataModel/SeriesMode/SeriesModels.dart';

class CreateCustPostModel {
  CreateCustPostModel({
    required this.error,
    required this.statusCode,
    required this.cardcodeList,
    required this.errorMsg,
  });

  String? error;
  int? statusCode;
  List<cardCodeList> cardcodeList;
  Errors? errorMsg;

  factory CreateCustPostModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<cardCodeList> dataList = list
            .map(
                (dynamic enquiries) => cardCodeList.fromJson(enquiries, stcode))
            .toList();
        return CreateCustPostModel(
          error: null,
          cardcodeList: dataList,
          statusCode: stcode,
          errorMsg: null,
        );
      } else {
        return CreateCustPostModel(
            error: null, cardcodeList: [], statusCode: stcode, errorMsg: null
            // jsons["error"] == null ? null : Errors.fromJson(jsons["error"]),
            );
      }
    } else {
      return CreateCustPostModel(
        error: null,
        cardcodeList: [],
        statusCode: stcode,
        errorMsg:
            jsons["error"] == null ? null : Errors.fromJson(jsons["error"]),
      );
    }
  }

  factory CreateCustPostModel.error(String e, int stcode) {
    return CreateCustPostModel(
      error: e,
      cardcodeList: [],
      statusCode: stcode,
      errorMsg: null,
    );
  }
}

class cardCodeList {
  String? cardCode;
  String? cardName;

  cardCodeList({
    required this.cardCode,
    required this.cardName,
  });
  factory cardCodeList.fromJson(dynamic jsons, int stcode) {
    return cardCodeList(
        cardCode: jsons['CardCode'] ?? '', cardName: jsons['CardName'] ?? '');
  }
}
