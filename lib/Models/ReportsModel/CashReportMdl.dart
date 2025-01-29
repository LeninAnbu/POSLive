// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"Document No\":\"1016788\",\"Branch-Terminal\":null,\"Document Type\":null,\"Customer Code\":\"D14131\",\"Customer Name\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"Rc amount\":0.000000,\"Expenses\":73632.000000,\"Document Date\":\"2024-10-14T00:00:00\"},
import 'dart:convert';

class CashReportModel {
  List<CashStateData>? customerdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  CashReportModel(
      {required this.customerdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CashReportModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<CashStateData> dataList =
            list.map((data) => CashStateData.fromJson(data)).toList();
        return CashReportModel(
            customerdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return CashReportModel(
            customerdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return CashReportModel(
          customerdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory CashReportModel.error(String jsons, int stcode) {
    return CashReportModel(
        customerdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CashStateData {
  String? docno;
  String? branch;
  String? terminal;
  String? cardcode;
  String? cardname;
  String? doctype;
  double? amount;
  double? expense;

  String? date;

  CashStateData(
      {required this.branch,
      required this.cardcode,
      required this.cardname,
      required this.date,
      required this.expense,
      required this.docno,
      required this.doctype,
      required this.amount,
      required this.terminal});
//     "data": "[{\"Document No\":\"1016788\",\"Branch-Terminal\":null,\"Document Type\":null,\"Customer Code\":\"D14131\",\"Customer Name\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"Rc amount\":0.000000,\"Expenses\":73632.000000,\"Document Date\":\"2024-10-14T00:00:00\"},
//
  factory CashStateData.fromJson(Map<String, dynamic> json) => CashStateData(
        branch: json['Branch-Terminal'] ?? '',
        cardcode: json['Customer Code'] ?? '',
        cardname: json['Customer Name'] ?? '',
        docno: json['Document No'] ?? '',
        doctype: json['Document Type'] ?? '',
        date: json['Document Date'] ?? '',
        expense: json['Expenses'] ?? 0,
        amount: json['Rc amount'] ?? 0,
        terminal: json['Branch-Terminal'] ?? '',
      );
}
