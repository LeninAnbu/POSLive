import 'dart:convert';

class SearchExpHeaderMdl {
  List<SearchEpenseDataModel>? expSearchdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  SearchExpHeaderMdl(
      {required this.expSearchdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory SearchExpHeaderMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<SearchEpenseDataModel> dataList =
          list.map((data) => SearchEpenseDataModel.fromJson(data)).toList();
      return SearchExpHeaderMdl(
          expSearchdata: dataList,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return SearchExpHeaderMdl(
          expSearchdata: null,
          message: jsons["msg"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory SearchExpHeaderMdl.error(String jsons, int stcode) {
    return SearchExpHeaderMdl(
        expSearchdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class SearchEpenseDataModel {
  String status;
  String? docDate;
  String address;
  String? jrnlMemo;
  int docNum;
  double cashSum;
  int? docEntry;
  SearchEpenseDataModel({
    required this.status,
    required this.docDate,
    required this.address,
    required this.jrnlMemo,
    required this.cashSum,
    required this.docEntry,
    required this.docNum,
  });
  factory SearchEpenseDataModel.fromJson(Map<String, dynamic> json) =>
      SearchEpenseDataModel(
          status: json['Status'] ?? '',
          address: json['Address'] ?? '',
          jrnlMemo: json['JrnlMemo'] ?? '',
          cashSum: json['CashSum'] ?? 0,
          docDate: json['DocDate'] ?? '',
          docEntry: json['DocEntry'] ?? 0,
          docNum: json['DocNum'] ?? 0);
}
