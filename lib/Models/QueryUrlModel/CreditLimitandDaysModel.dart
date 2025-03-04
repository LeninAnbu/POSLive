// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"CreditLine\":1.000000}]"
// }
import 'dart:convert';
import 'dart:developer';

class CreditLimitModel {
  bool? status;
  String? message;
  List<CreditLimitModelData>? creditLimitData;
  String? exception;
  int statuscode;
  CreditLimitModel(
      {required this.status,
      //
      required this.message,
      this.creditLimitData,
      required this.statuscode,
      this.exception});

  factory CreditLimitModel.fromJson(
      Map<String, dynamic> jsons, int Statuscode) {
    if (Statuscode >= 200 && Statuscode <= 210) {
      var list = jsonDecode(jsons['data']) as List;

      List<CreditLimitModelData> dataList =
          list.map((data) => CreditLimitModelData.fromJson(data)).toList();

      return CreditLimitModel(
          creditLimitData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      return CreditLimitModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          creditLimitData: null,
          statuscode: Statuscode);
    }
  }

  factory CreditLimitModel.exception(String e, int statuscode) {
    return CreditLimitModel(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        creditLimitData: null);
  }
}

class CreditLimitModelData {
  double creditLine;

  CreditLimitModelData({required this.creditLine});

  factory CreditLimitModelData.fromJson(dynamic jsons) {
    return CreditLimitModelData(
      creditLine: jsons['CreditLine'] ?? 0,
    );
  }
}

class CreditDaysModel {
  bool? status;
  String? message;
  List<CreditDaysModelData>? creditDaysData;
  String? exception;
  int statuscode;
  CreditDaysModel(
      {required this.status,
      //
      required this.message,
      this.creditDaysData,
      required this.statuscode,
      this.exception});

  factory CreditDaysModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (Statuscode >= 200 && Statuscode <= 210) {
      var list = jsonDecode(jsons['data']) as List;
      List<CreditDaysModelData> dataList =
          list.map((data) => CreditDaysModelData.fromJson(data)).toList();

      return CreditDaysModel(
          creditDaysData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      log("stcode$Statuscode");
      return CreditDaysModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          creditDaysData: null,
          statuscode: Statuscode);
    }
  }

  factory CreditDaysModel.exception(String e, int statuscode) {
    return CreditDaysModel(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        creditDaysData: null);
  }
}

class CreditDaysModelData {
  int creditDays;
  String paymentGroup;

  CreditDaysModelData({required this.creditDays, required this.paymentGroup});

  factory CreditDaysModelData.fromJson(Map<String, dynamic> jsons) {
    log('jsons CrExtraDayseditLine::${jsons['ExtraDays'].toString()}');

    return CreditDaysModelData(
      creditDays: jsons['ExtraDays'] ?? 0,
      paymentGroup: jsons['PymntGroup'] ?? '',
    );
  }
}
