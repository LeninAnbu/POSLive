import 'dart:convert';

class ExpenseGetModel {
  List<EpenseDataModel>? addressdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ExpenseGetModel(
      {required this.addressdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ExpenseGetModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<EpenseDataModel> dataList =
          list.map((data) => EpenseDataModel.fromJson(data)).toList();
      return ExpenseGetModel(
          addressdata: dataList,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return ExpenseGetModel(
          addressdata: null,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory ExpenseGetModel.error(String jsons, int stcode) {
    return ExpenseGetModel(
        addressdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class EpenseDataModel {
  String code;
  String? name;
  double? currentTotal;

  EpenseDataModel({
    required this.code,
    required this.name,
    this.currentTotal,
  });

  factory EpenseDataModel.fromJson(Map<String, dynamic> json) =>
      EpenseDataModel(code: json['Code'] ?? '', name: json['Name'] ?? '');
}
