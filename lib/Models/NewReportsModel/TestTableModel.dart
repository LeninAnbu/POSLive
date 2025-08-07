import 'dart:convert';
import 'dart:developer';

class TestModel {
  TestModel({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<TestModelData>? openOutwardData;
  String? error;
  int? statusCode;

  factory TestModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List;
        List<TestModelData> dataList = list
            .map((dynamic enquiries) => TestModelData.fromJson(enquiries))
            .toList();
        return TestModel(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return TestModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return TestModel(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory TestModel.error(String e, int stcode) {
    return TestModel(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class TestModelData {
  int DocNum;
  String DocDate;
  String CardCode;
  String Name;
  String TinNumber;
  double TotalBeforeTax;
  double Tax;
  double DocTotal;
  String CardName;
  String U_rctCde;
  String U_Zno;
  String U_VfdIn;
  String? U_NAME;
  String? canceled;
  String? whsCode;
  String? whsBranch;
  TestModelData({
    required this.DocDate,
    required this.DocNum,
    required this.CardName,
    required this.CardCode,
    required this.canceled,
    required this.Name,
    required this.whsCode,
    required this.whsBranch,
    required this.TinNumber,
    required this.DocTotal,
    required this.Tax,
    required this.TotalBeforeTax,
    required this.U_NAME,
    required this.U_VfdIn,
    required this.U_Zno,
    required this.U_rctCde,
  });

  factory TestModelData.fromJson(dynamic jsons) {
    return TestModelData(
        DocDate: jsons['DocDate'] ?? '',
        DocNum: jsons['DocNum'] ?? '',
        canceled: jsons['canceled'] ?? '',
        CardCode: jsons['CardCode'] ?? '',
        CardName: jsons['CardName'] ?? '',
        whsCode: jsons['WhsCode'] ?? '',
        whsBranch: jsons['whsBranch'] ?? '',
        Name: jsons['Name'] ?? '',
        TinNumber: jsons['Tin Number'] ?? '',
        DocTotal: jsons['DocTotal'] ?? 0,
        Tax: jsons['Tax'] ?? 0,
        TotalBeforeTax: jsons['Total Before Tax'] ?? 0,
        U_Zno: jsons['U_Zno'] ?? '',
        U_rctCde: jsons['U_rctCde'] ?? '',
        U_NAME: jsons['U_NAME'] ?? '',
        U_VfdIn: jsons['U_VfdIn'] ?? '');
  }
  Map<String, Object?> toMap() => {
        'DocNum': DocNum,
        'DocDate': DocDate,
        'CardCode': CardCode,
        'CardName': CardName,
        'Tin Number': TinNumber,
        'Total Before Tax': TotalBeforeTax,
        'Tax': Tax,
        'DocTotal': DocTotal,
        'U_rctCde': U_rctCde,
        'U_Zno': U_Zno,
        'U_VfdIn': U_VfdIn,
        'U_NAME': U_NAME,
        'canceled': canceled,
        'Name': Name,
        'WhsCode': canceled,
        'whsBranch': Name,
      };
}
