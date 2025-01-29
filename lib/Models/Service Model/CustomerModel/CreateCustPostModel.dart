// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes

import 'dart:convert';
import 'dart:developer';

import '../../DataModel/SeriesMode/SeriesModels.dart';

class CreateCustPostModel {
  CreateCustPostModel(
      {required this.cardCode,
      required this.error,
      required this.statusCode,
      required this.errorMsg});

  String? error;
  int? statusCode;
  String? cardCode;
  Errors? errorMsg;

  factory CreateCustPostModel.fromJson(String resp, int stcode) {
    var jsons = json.decode(resp) as Map<String, dynamic>;
    print('jsons :::$jsons');

    if (stcode >= 200 && stcode <= 210) {
      return CreateCustPostModel(
          cardCode: jsons['CardCode'] as String,
          error: null,
          statusCode: stcode,
          errorMsg: null);
    } else {
      return CreateCustPostModel(
        cardCode: null,
        error: resp,
        statusCode: stcode,
        errorMsg:
            jsons["error"] == null ? null : Errors.fromJson(jsons["error"]),
      );
    }
  }

  factory CreateCustPostModel.issue(String resp, int stcode) {
    var jsons = json.decode(resp) as Map<String, dynamic>;
    log('jsons :::$jsons');

    return CreateCustPostModel(
      cardCode: null,
      error: resp,
      statusCode: stcode,
      errorMsg: jsons["error"] == null ? null : Errors.fromJson(jsons["error"]),
    );
  }
}
