// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"TransType\":\"24\",\"Ref1\":\"1001494\",\"CardCode\":\"D3044\",\"CardName\":\"4G MODERN INVESTMENTS\",\"RefDate\":\"2020-04-04T00:00:00\",\"Ref2\":\"\",\"Amount\":-504000.000000,\"Balance\":-1565.200000,\"ReconcileAmount\":-1565.200000,\"CreditOrDebitT\":\"codCredit\"}]"
// }

import 'dart:convert';
import 'dart:developer';

class RecoModel {
  bool? status;
  String? message;
  List<RecoModelData>? recoListData;
  String? exception;
  int statuscode;
  RecoModel(
      {required this.status,
      //
      required this.message,
      this.recoListData,
      required this.statuscode,
      this.exception});

  factory RecoModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (Statuscode == 200) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List;
        List<RecoModelData> dataList =
            list.map((data) => RecoModelData.fromJson(data)).toList();

        return RecoModel(
            recoListData: dataList,
            message: jsons['message'].toString(),
            status: jsons['status'] as bool,
            statuscode: Statuscode);
      } else {
        log("stcode$Statuscode");
        return RecoModel(
            message: jsons['message'].toString(),
            status: jsons['status'] as bool,
            exception: '',
            recoListData: [],
            statuscode: Statuscode);
      }
    } else {
      log("stcode$Statuscode");
      return RecoModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          exception: '',
          recoListData: null,
          statuscode: Statuscode);
    }
  }

  factory RecoModel.exception(String e, int statuscode) {
    return RecoModel(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        recoListData: null);
  }
}

class RecoModelData {
  String cardcode;
  String cardName;
  String transtype;
  int transId;

  String ref1;
  String refDate;
  String srcObjTyp;
  String? memo;

  int srcObjAbs;
  int transRowId;
  //Memo
  String ref2;
  String creditOrDebitT;
  double amount;
  double balance;
  double reconcileAmount;
  bool? listclr;
  RecoModelData({
    required this.cardcode,
    required this.transId,
    required this.srcObjAbs,
    required this.memo,
    required this.transRowId,
    required this.srcObjTyp,
    this.listclr,
    required this.cardName,
    required this.balance,
    required this.transtype,
    required this.ref1,
    required this.ref2,
    required this.amount,
    required this.refDate,
    required this.reconcileAmount,
    required this.creditOrDebitT,
  });
//{\"SrcObjTyp\":\"13\",\"TransId\":4202348,\"TransRowId\":0,\"SrcObjAbs\":565600,\"Memo\":\"A/R Invoices - D1999\",\"Ref1\":\"7074009\",\"CardCode\":\"D1999\",\"CardName\":\"BOA VIDA COMPANY LIMITED\",\"RefDate\":\"2024-09-20T00:00:00\",\"Ref2\":\"NADDY\",\"Amount\":269092.108800,\"Balance\":269092.108800,\"ReconcileAmount\":269092.108800,\"CreditOrDebitT\":\"codDebit\"}
  factory RecoModelData.fromJson(Map<String, dynamic> jsons) {
    return RecoModelData(
      cardcode: jsons['CardCode'] ?? '',
      cardName: jsons['CardName'] ?? '',
      memo: jsons['Memo'] ?? '',
      balance: jsons['Balance'] ?? 0,
      srcObjAbs: jsons['SrcObjAbs'] ?? 0,
      transId: jsons['TransId'] ?? 0,
      srcObjTyp: jsons['SrcObjTyp'] ?? '',
      transRowId: jsons['TransRowId'] ?? 0,
      transtype: jsons['TransType'] ?? '',
      amount: jsons['Amount'] ?? 0,
      reconcileAmount: jsons['ReconcileAmount'] ?? 0,
      ref1: jsons['Ref1'] ?? 0,
      ref2: jsons['Ref2'] ?? '',
      refDate: jsons['RefDate'] ?? '',
      creditOrDebitT: jsons['CreditOrDebitT'] ?? 0,
    );
  }
}
