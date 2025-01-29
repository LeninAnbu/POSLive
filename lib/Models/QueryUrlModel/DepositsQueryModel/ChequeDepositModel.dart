//  {status: true, msg: Success, data: [{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"},{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"},{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"},{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"},{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"},{"Cheque":"464448","ChequeKey":1,"ChequeDate":"2011-03-01T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2392157.000000,"Action":"Deposit"}
//{"Cheque":"167620","ChequeKey":3043,"ChequeDate":"2011-11-18T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2000100.000000,"Action":"Deposit"},
import 'dart:convert';

class ChequeDepositQueryModel {
  ChequeDepositQueryModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<ChequeDepositQueryData>? activitiesData;
  String? error;
  int? statusCode;

  factory ChequeDepositQueryModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<ChequeDepositQueryData> dataList = list
            .map((dynamic enquiries) =>
                ChequeDepositQueryData.fromJson(enquiries))
            .toList();
        return ChequeDepositQueryModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return ChequeDepositQueryModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return ChequeDepositQueryModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class ChequeDepositQueryData {
  String cheque;
  int chequeKey;
  String chequeDate;
  double chequeAmt;
  String bank;
  String action;
  String branch;
  String accNo;
  int? onchanged;
  bool? checkClr;
  ChequeDepositQueryData({
    this.onchanged,
    this.checkClr,
    required this.accNo,
    required this.action,
    required this.bank,
    required this.branch,
    required this.cheque,
    required this.chequeAmt,
    required this.chequeDate,
    required this.chequeKey,
  });
//{"Cheque":"167620","ChequeKey":3043,"ChequeDate":"2011-11-18T00:00:00","Bank":"Standard","Branch":"","AccNo":"","ChequeAmt":2000100.000000,"Action":"Deposit"},

  factory ChequeDepositQueryData.fromJson(dynamic jsons) {
    return ChequeDepositQueryData(
      accNo: jsons['AccNo'] ?? '',
      action: jsons['Action'] ?? '',
      bank: jsons['Bank'] ?? '',
      branch: jsons['Branch'] ?? '',
      cheque: jsons['Cheque'] ?? '',
      chequeAmt: jsons['ChequeAmt'] ?? 0,
      chequeDate: jsons['ChequeDate'] ?? '',
      chequeKey: jsons['ChequeKey'] ?? 0,
    );
  }
}
