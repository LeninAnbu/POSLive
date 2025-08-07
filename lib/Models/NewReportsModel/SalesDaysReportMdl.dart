import 'dart:convert';
import 'dart:developer';

class SalesInDay {
  SalesInDay({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<SalesInDayData>? openOutwardData;
  String? error;
  int? statusCode;

  factory SalesInDay.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List;
        List<SalesInDayData> dataList = list
            .map((dynamic enquiries) => SalesInDayData.fromJson(enquiries))
            .toList();
        return SalesInDay(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return SalesInDay(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return SalesInDay(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory SalesInDay.error(String e, int stcode) {
    return SalesInDay(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class SalesInDayData {
  int docNum;
  String cardName;
  String CustomerCode;
  String DocStatus;
  String taxDate;
  String NumAtCard;
  double DISC;
  double VatSum;
  String Comments;
  int ReceiptNum;
  String SlpName;
  String memo;

  int DocTime;
  double DocTotal;
  String branch;
  String IsIns;

  SalesInDayData({
    required this.DocTime,
    required this.docNum,
    required this.DocTotal,
    required this.DocStatus,
    required this.cardName,
    required this.CustomerCode,
    required this.Comments,
    required this.NumAtCard,
    required this.memo,
    required this.DISC,
    required this.VatSum,
    required this.branch,
    required this.IsIns,
    required this.ReceiptNum,
    required this.SlpName,
    required this.taxDate,
  });

  factory SalesInDayData.fromJson(Map<String, dynamic> json) {
    return SalesInDayData(
      DocTime: json['DocTime'] ?? 0,
      docNum: json['DocNum'] ?? 0,
      DocStatus: json['Doc Status'] ?? "",
      DocTotal: json['DocTotal'] ?? 0,
      DISC: json['DISC'] ?? 0,
      CustomerCode: json['Customer Code'] ?? "",
      Comments: json['Comments'] ?? '',
      NumAtCard: json['NumAtCard'] ?? "",
      branch: json['BRANCH'] ?? "",
      ReceiptNum: json['ReceiptNum'] ?? 0,
      SlpName: json['SlpName'] ?? '',
      VatSum: json['VatSum'] ?? 0,
      cardName: json['CardName'] ?? "",
      IsIns: json['IsIns'] ?? '',
      taxDate: json['taxDate'] ?? "",
      memo: json['Memo'] ?? "",
    );
  }

  Map<String, Object?> toMap() => {
        'DocNum': docNum,
        'Doc Status': DocStatus,
        'TaxDate': taxDate,
        'CardCode': CustomerCode,
        'CardName': cardName,
        'NumAtCard': NumAtCard,
        'DISC %': DISC,
        'VatSum': VatSum,
        'DocTotal': DocTotal,
        'Comments': Comments,
        'ReceiptNum': ReceiptNum,
        'SlpName': SlpName,
        'DocTime': DocTime,
        'Memo': memo,
        'IsIns': IsIns,
        'Branch': branch
      };
}
