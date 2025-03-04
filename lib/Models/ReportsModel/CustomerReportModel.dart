// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"Customer Name\":\"Tarmal\",\"CustomerCode \":\"0999\",\"Balance\":0.000000,\"Points\":\"\",\"Email id\":null,\"Phone No\":null,\"TaxCode\":null,\"Customer Type\":\"C\",\"Customer Address\":null}

import 'dart:convert';

class CustomersReportModel {
  List<CustomerReportData>? customerdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  CustomersReportModel(
      {required this.customerdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CustomersReportModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<CustomerReportData> dataList =
            list.map((data) => CustomerReportData.fromJson(data)).toList();
        return CustomersReportModel(
            customerdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return CustomersReportModel(
            customerdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return CustomersReportModel(
          customerdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory CustomersReportModel.error(String jsons, int stcode) {
    return CustomersReportModel(
        customerdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CustomerReportData {
  String? cardCode;
  String? phNo;
  String? name;
  String? customertype;
  double? accBalance;
  String? taxCode;
  String? email;
  String? point;
  String? customerAddress;

  CustomerReportData({
    required this.cardCode,
    required this.customertype,
    required this.name,
    required this.phNo,
    required this.accBalance,
    required this.customerAddress,
    required this.point,
    required this.taxCode,
    required this.email,
  });
// "data": "[{\"Customer Name\":\"Tarmal\",\"CustomerCode \":\"0999\",\"Balance\":0.000000,\"Points\":\"\",\"Email id\":null,\"Phone No\":null,\"TaxCode\":null,\"Customer Type\":\"C\",\"Customer Address\":null}

  factory CustomerReportData.fromJson(Map<String, dynamic> json) =>
      CustomerReportData(
        name: json['Customer Name'] ?? '',
        phNo: json['Phone No'] ?? '',
        cardCode: json['CustomerCode'] ?? '',
        customertype: json['Customer Type'] ?? '',
        customerAddress: json['Customer Address'] ?? '',
        accBalance: json['Balance'] ?? 0.0,
        point: json['Points'] ?? '',
        taxCode: json['TaxCode'] ?? '',
        email: json['Email id'] ?? '',
      );
}
