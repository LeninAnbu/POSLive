import 'dart:convert';
import 'dart:developer';

class CollectionReport {
  CollectionReport({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<CollectionReportData>? openOutwardData;
  String? error;
  int? statusCode;

  factory CollectionReport.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<CollectionReportData> dataList = list
            .map(
                (dynamic enquiries) => CollectionReportData.fromJson(enquiries))
            .toList();
        return CollectionReport(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return CollectionReport(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return CollectionReport(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory CollectionReport.error(String e, int stcode) {
    return CollectionReport(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class CollectionReportData {
  int docNum;
  String cardName;
  String cardCode;
  String jrnlMemo;
  double total;
  double cashInHand;
  double chequeDeposits;
  String bankName;
  double cashInBankDeposits;
  String docDate;
  String acctName;
  String seriesName;
  String branch;

  CollectionReportData({
    required this.docDate,
    required this.docNum,
    required this.total,
    required this.cardName,
    required this.jrnlMemo,
    required this.cashInBankDeposits,
    required this.cardCode,
    required this.cashInHand,
    required this.chequeDeposits,
    required this.bankName,
    required this.branch,
    required this.acctName,
    required this.seriesName,
  });
// {"DocNum":3010191,"CardCode":"D4418","CardName":"3D DISTRIBUTORS (TZ) LIMITED","JrnlMemo":"Incoming Payments - D4418",
//"CASH IN HAND":142461.400000,"CHEQUE DEPOSITS":0.000000,"BANK NAME":" ","CASH IN BANK DEPOSIT":0.000000,"DocDate"
//:"2024-12-14T00:00:00","AcctName":"Cash in Hand (AR)","SeriesName":"ARUSHA24","TOTAL":142461.400000,"Branch":"ARSFG"},
  factory CollectionReportData.fromJson(Map<String, dynamic> json) {
    return CollectionReportData(
      docDate: json['DocDate'] ?? '',
      docNum: json['DocNum'] ?? 0,
      jrnlMemo: json['JrnlMemo'] ?? "",
      cashInBankDeposits: json['CASH IN BANK DEPOSIT'] ?? 0,
      cardCode: json['CardCode'] ?? "",
      cashInHand: json['CASH IN HAND'] ?? 0,
      chequeDeposits: json['CHEQUE DEPOSITS'] ?? 0,
      bankName: json['BANK NAME'] ?? "",
      branch: json['Branch'] ?? "",
      seriesName: json['SeriesName'] ?? '',
      acctName: json['AcctName'] ?? '',
      total: json['TOTAL'] ?? 0,
      cardName: json['CardName'] ?? "",
    );
  }

  Map<String, Object?> toMap() => {
        'DocNum': docNum,
        'CardCode': cardCode,
        'CardName': cardName,
        'JrnlMemo': jrnlMemo,
        'CASH IN HAND': cashInHand,
        'CHEQUE DEPOSITS': chequeDeposits,
        'BANK NAME': bankName,
        'CASH IN BANK DEPOSIT': cashInBankDeposits,
        'DocDate': docDate,
        'AcctName': acctName,
        'SeriesName': seriesName,
        'TOTAL': total,
        'Branch': branch
      };
}
