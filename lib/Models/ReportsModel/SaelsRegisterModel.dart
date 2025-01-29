// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"Document number\":1016788,\"Branch\":null,\"Terminal\":\"\",\"Customer Name\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"Customer Code\":\"D14131\",\"Item Code\":\"200105E\",\"Item Name\":\"HIGH GLOSS ENAMEL LIGHT BLUE - 1LTR\",\"DATE\":\"2024-10-14T00:00:00\"},{\"Document number\":1016789,\"Branch\":null,\"Terminal\":\"\",\"Customer Name\":\"CASH ACCOUNT MAGRETH\",\"Customer Code\":\"D4387\",\"Item Code\":\"1000002E\",\"Item Name\":\"RED OXIDE PRIMER - 1LTR\",\"DATE\":\"2024-10-15T00:00:00\"},{\"Document number\":1016790,\"Branch\":null,\"Terminal\":\"\",\"Customer Name\":\"CASH ACCOUNT MAGRETH\",\"Customer Code\":\"D4387\",\"Item Code\":\"1000002E\",\"Item Name\":\"RED OXIDE PRIMER - 1LTR\",\"DATE\":\"2024-10-15T00:00:00\"},
// }

import 'dart:convert';

class SalesRegReportModel {
  List<StockRegisterList> salesRegData;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  SalesRegReportModel(
      {required this.salesRegData,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory SalesRegReportModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<StockRegisterList> dataList =
            list.map((data) => StockRegisterList.fromJson(data)).toList();
        return SalesRegReportModel(
            salesRegData: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return SalesRegReportModel(
            salesRegData: [],
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return SalesRegReportModel(
          salesRegData: [],
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory SalesRegReportModel.error(String jsons, int stcode) {
    return SalesRegReportModel(
        salesRegData: [],
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class StockRegisterList {
  int? docno;
  int? docEntry;
  String? branch;
  String? terminal;
  String? cardcode;
  String? cardname;
  String? itemcode;
  String? itemname;
  String? date;

  StockRegisterList(
      {required this.branch,
      required this.cardcode,
      required this.cardname,
      required this.date,
      this.docEntry,
      required this.docno,
      required this.itemcode,
      required this.itemname,
      required this.terminal});

// {\"Document number\":1016788,\"Branch\":null,\"Terminal\":\"\",\"Customer Name\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"Customer Code\":\"D14131\",\"Item Code\":\"200105E\",\"Item Name\":\"HIGH GLOSS ENAMEL LIGHT BLUE - 1LTR\",\"DATE\":\"2024-10-14T00:00:00\"},{\"

  factory StockRegisterList.fromJson(Map<String, dynamic> json) {
    return StockRegisterList(
      branch: json['Branch'] ?? '',
      itemcode: json['Item Code'] ?? '',
      itemname: json['Item Name'] ?? '',
      terminal: json['Terminal'] ?? '',
      docno: json['Document number'] ?? 0,
      date: json['DATE'] ?? '',
      cardname: json['Customer Name'] ?? '',
      cardcode: json['CustomerName'] ?? '',
    );
  }
}
