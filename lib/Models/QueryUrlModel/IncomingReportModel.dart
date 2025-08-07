import 'dart:convert';

class IncomingReportsModel {
  IncomingReportsModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<IncomingReportsData>? activitiesData;
  String? error;
  int? statusCode;

  factory IncomingReportsModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List;
        List<IncomingReportsData> dataList = list
            .map((dynamic enquiries) => IncomingReportsData.fromJson(enquiries))
            .toList();
        return IncomingReportsModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return IncomingReportsModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return IncomingReportsModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class IncomingReportsData {
  int paymentNo;
  String userCode;
  String paymentDate;
  String customerCode;
  String cusotmerName;
  double paymentAmount;
  String paymentMode;
  String remarks;
  String? journalMemo;
  String? currency;
  IncomingReportsData({
    required this.paymentNo,
    required this.paymentAmount,
    required this.paymentDate,
    required this.paymentMode,
    required this.cusotmerName,
    required this.customerCode,
    required this.currency,
    required this.userCode,
    required this.remarks,
    required this.journalMemo,
  });

  factory IncomingReportsData.fromJson(dynamic jsons) {
    return IncomingReportsData(
      paymentDate: jsons['Payment Date'] ?? '',
      paymentMode: jsons['PAYMENT MODE'] ?? '',
      paymentNo: jsons['Payment No'] ?? 0,
      cusotmerName: jsons['Customer Name'] ?? '',
      customerCode: jsons['Customer Code'] ?? '',
      paymentAmount: jsons['Payment Amount'] ?? 0,
      currency: jsons['Currency'] ?? '',
      userCode: jsons['UserCode'] ?? 0,
      remarks: jsons['Remarks'] ?? '',
      journalMemo: jsons['Journal Memo'] ?? 0,
    );
  }
}
