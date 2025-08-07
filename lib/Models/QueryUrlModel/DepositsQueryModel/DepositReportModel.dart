import 'dart:convert';

class DepositsReportsModel {
  DepositsReportsModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<DepositsReportsData>? activitiesData;
  String? error;
  int? statusCode;

  factory DepositsReportsModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<DepositsReportsData> dataList = list
            .map((dynamic enquiries) => DepositsReportsData.fromJson(enquiries))
            .toList();
        return DepositsReportsModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return DepositsReportsModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return DepositsReportsModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class DepositsReportsData {
  int deposNum;
  String deposDate;
  String debitActName;
  double debitAmt;
  String creditActName;
  double creditAmount;
  String paymentMode;
  String? deposCurr;
  DepositsReportsData({
    required this.deposNum,
    required this.debitActName,
    required this.debitAmt,
    required this.paymentMode,
    required this.deposCurr,
    required this.deposDate,
    required this.creditActName,
    required this.creditAmount,
  });
// {\"DeposDate\":\"2025-06-01T00:00:00\",\"DeposNum\":5000001,\"DeposCurr\":\"TZS\",\"Debit_ActName\":\"Exim Bank (T) Ltd TZS-0100011975 (GEN)\",
//\"Debit_Amt\":2.000000,\"Credit_ActName\":\"Cash in Hand (UB)\",\"Credit_Amount\":2.000000,\"PAYMENT MODE\":\"CASH

  factory DepositsReportsData.fromJson(dynamic jsons) {
    return DepositsReportsData(
      deposDate: jsons['DeposDate'] ?? '',
      paymentMode: jsons['PAYMENT MODE'] ?? '',
      debitActName: jsons['Debit_ActName'] ?? '',
      debitAmt: jsons['Debit_Amt'] ?? 0,
      deposCurr: jsons['DeposCurr'] ?? '',
      deposNum: jsons['DeposNum'] ?? 0,
      creditActName: jsons['Credit_ActName'] ?? '',
      creditAmount: jsons['Credit_Amount'] ?? 0,
    );
  }
}
