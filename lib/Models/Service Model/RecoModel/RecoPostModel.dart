import 'dart:developer';

import '../../DataModel/SeriesMode/SeriesModels.dart';

class RecoPostModel {
  String? cardCode;
  Errors? error;
  List<RecoPostModelData>? recoListData;
  String? exception;
  int statuscode;
  int? reconNum;

  RecoPostModel(
      {required this.reconNum,
      required this.cardCode,
      this.recoListData,
      this.error,
      required this.statuscode,
      this.exception});

  factory RecoPostModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (Statuscode >= 200 || Statuscode <= 210) {
      log('message1');

      return RecoPostModel(
          recoListData: [],
          cardCode: jsons['CardOrAccount'].toString(),
          reconNum: jsons['ReconNum'],
          statuscode: Statuscode);
    } else {
      log("stcode$Statuscode");
      return RecoPostModel(
          exception: '',
          reconNum: null,
          cardCode: '',
          recoListData: null,
          statuscode: Statuscode);
    }
  }
  factory RecoPostModel.issue(Map<String, dynamic> jsons, int Statuscode) {
    log('Error111');
    return RecoPostModel(
        recoListData: [],
        reconNum: null,
        cardCode: '',
        error: Errors.fromJson(jsons["error"]),
        statuscode: Statuscode);
  }
  factory RecoPostModel.exception(String e, int statuscode) {
    return RecoPostModel(
        reconNum: null,
        exception: e,
        cardCode: '',
        statuscode: statuscode,
        recoListData: []);
  }
}

class RecoPostModelData {
  String? cashDiscount;
  String creditOrDebit;
  double reconcileAmount;
  String shortName;
  String? selected;
  int? LineSeq;
  int srcObjAbs;
  String srcObjTyp;
  int transId;
  int transRowId;

  RecoPostModelData({
    required this.cashDiscount,
    this.selected,
    this.LineSeq,
    required this.creditOrDebit,
    required this.reconcileAmount,
    required this.shortName,
    required this.srcObjAbs,
    required this.srcObjTyp,
    required this.transId,
    required this.transRowId,
  });

  factory RecoPostModelData.fromJson(Map<String, dynamic> jsons) {
    return RecoPostModelData(
      cashDiscount: jsons['CashDiscount'] ?? 0,
      LineSeq: jsons['LineSeq'] ?? 0,
      creditOrDebit: jsons['CreditOrDebit'].toString(),
      transRowId: jsons['TransRowId'] ?? 0,
      shortName: jsons['ShortName'] ?? '',
      srcObjAbs: jsons['SrcObjAbs'] ?? 0,
      srcObjTyp: jsons['SrcObjTyp'] ?? '',
      transId: jsons['TransId'] ?? 0,
      reconcileAmount: jsons['ReconcileAmount'] ?? 0,
    );
  }
  Map<String, dynamic> toJson3() => {
        "CashDiscount": cashDiscount,
        "CreditOrDebit": creditOrDebit,
        "ReconcileAmount": reconcileAmount,
        "Selected": selected,
        "ShortName": shortName,
        "SrcObjAbs": srcObjAbs,
        "SrcObjTyp": srcObjTyp,
        "TransId": transId,
        "TransRowId": transRowId
      };
}
