// ignore_for_file: prefer_final_locals, omit_local_variable_types, prefer_single_quotes, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:posproject/Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_order_modal.dart';

class ApprovaldyModel {
  ApprovaldyModel({
    required this.status,
    required this.message,
    required this.approvedData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<ApprovalsOrdersValue>? approvedData;
  String? error;
  int? statusCode;

  factory ApprovaldyModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;
      // log("json: " + jsons.toString());
      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<ApprovalsOrdersValue> dataList = list
            .map(
                (dynamic enquiries) => ApprovalsOrdersValue.fromJson(enquiries))
            .toList();
        return ApprovaldyModel(
          approvedData: dataList,
          message: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return ApprovaldyModel(
          message: jsons['data'].toString(),
          status: jsons['status'] as bool,
          approvedData: [],
          error: null,
          statusCode: stcode,
        );
      }
    } else {
      return ApprovaldyModel(
        message: null,
        status: null,
        approvedData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}
