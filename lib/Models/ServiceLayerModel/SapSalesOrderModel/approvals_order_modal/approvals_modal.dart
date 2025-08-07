import 'dart:convert';

class ApprovalsModal {
  String? message;
  bool? status;
  List<ApprovalsValue>? approvalsvalue;
  String? error;
  int stsCode;
  String? nextLink;
  ApprovalsModal({
    this.message,
    this.status,
    required this.stsCode,
    this.approvalsvalue,
    this.error,
    this.nextLink,
  });
  factory ApprovalsModal.fromJson(Map<String, dynamic> jsons, int statusCode) {
    if (statusCode >= 200 && statusCode <= 210) {
      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data']) as List;

        List<ApprovalsValue> dataList = list
            .map((dynamic enquiries) => ApprovalsValue.fromJson(enquiries))
            .toList();

        return ApprovalsModal(
          approvalsvalue: dataList,
          message: jsons['msg'].toString(),
          status: jsons['status'],
          stsCode: statusCode,
        );
      } else {
        return ApprovalsModal(
          status: null,
          message: '',
          approvalsvalue: [],
          nextLink: null,
          stsCode: statusCode,
        );
      }
    } else {
      return ApprovalsModal(
        status: null,
        message: '',
        approvalsvalue: [],
        nextLink: null,
        stsCode: statusCode,
      );
    }
  }

  factory ApprovalsModal.issue(
    String e,
    int statusCode,
  ) {
    return ApprovalsModal(
      status: null,
      message: '',
      approvalsvalue: [],
      stsCode: statusCode,
      error: e,
      nextLink: null,
    );
  }
}

class ApprovalsValue {
  String? cardCode;
  String? cardName;
  String? createDate;
  int? createTime;
  int? currStep;
  String? docDate;
  int? docNum;
  double? DocTotal;
  int? draftEntry;
  String? fromUser;
  String? objType;
  int? wddCode;
  int? wtmCode;

  ApprovalsValue({
    required this.cardCode,
    required this.createDate,
    required this.cardName,
    required this.createTime,
    required this.currStep,
    required this.docDate,
    this.DocTotal,
    required this.docNum,
    required this.draftEntry,
    required this.fromUser,
    required this.objType,
    required this.wddCode,
    required this.wtmCode,
  });

  factory ApprovalsValue.fromJson(dynamic jsons) {
    return ApprovalsValue(
      cardCode: jsons['CardCode'] ?? '',
      cardName: jsons['CardName'] ?? '',
      DocTotal: jsons['DocTotal'] ?? 0.0,
      createDate: jsons['CreateDate'].toString(),
      createTime: jsons['CreateTime'] == null ? 0 : jsons['CreateTime'] as int,
      currStep: jsons['CurrStep'] as int,
      docDate: jsons['DocDate'] ?? '',
      docNum: jsons["DocNum"] ?? 0,
      draftEntry: jsons['DraftEntry'] == null ? 0 : jsons['DraftEntry'] as int,
      fromUser: jsons["FromUser"] == null ? '' : jsons['FromUser'].toString(),
      objType: jsons["ObjType"] == null ? '' : jsons['ObjType'].toString(),
      wddCode: jsons["WddCode"] as int,
      wtmCode: jsons["WtmCode"] as int,
    );
  }
}
