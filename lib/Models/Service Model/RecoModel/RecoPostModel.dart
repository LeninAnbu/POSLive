import 'dart:developer';

import '../../DataModel/SeriesMode/SeriesModels.dart';

// {
//     "odata.metadata": "http://102.69.167.106:50001/b1s/v1/$metadata#InternalReconciliations/@Element",
//     "ReconNum": 971706,
//     "ReconDate": "2025-01-01T00:00:00Z",
//     "CardOrAccount": "coaCard",
//     "ReconType": "rtManual",
//     "Total": 280.0,
//     "CancelAbs": 0,
//     "InternalReconciliationRows": [
//         {
//             "LineSeq": 0,
//             "ShortName": "D1999",
//             "TransId": 4273422,
//             "TransRowId": 0,
//             "SrcObjTyp": "13",
//             "SrcObjAbs": 574507,
//             "CreditOrDebit": "codDebit",
//             "ReconcileAmount": 280.0,
//             "CashDiscount": 0.0
//         },
//         {
//             "LineSeq": 1,
//             "ShortName": "D1999",
//             "TransId": 4273768,
//             "TransRowId": 1,
//             "SrcObjTyp": "24",
//             "SrcObjAbs": 40369906,
//             "CreditOrDebit": "codCredit",
//             "ReconcileAmount": 100.0,
//             "CashDiscount": 0.0
//         },
//         {
//             "LineSeq": 2,
//             "ShortName": "D1999",
//             "TransId": 4273781,
//             "TransRowId": 1,
//             "SrcObjTyp": "24",
//             "SrcObjAbs": 40369907,
//             "CreditOrDebit": "codCredit",
//             "ReconcileAmount": 180.0,
//             "CashDiscount": 0.0
//         },
//         {
//             "LineSeq": 3,
//             "ShortName": "D1999",
//             "TransId": 4274154,
//             "TransRowId": 0,
//             "SrcObjTyp": "321",
//             "SrcObjAbs": 971706,
//             "CreditOrDebit": "codDebit",
//             "ReconcileAmount": 0.0,
//             "CashDiscount": 0.0
//         }
//     ],
//     "ElectronicProtocols": []
// }
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
      // log('InternalReconciliationRows::${jsonDecode(jsons['InternalReconciliationRows'].toString())}');
      // if (jsons['InternalReconciliationOpenTransRows'].toString() != 'No data found') {
      log('message1');
      // var list =
      //     jsonDecode(jsons['InternalReconciliationRows'].toString()) as List;

      // log('message2::$list');

      // List<RecoPostModelData> dataList =
      //     list.map((data) => RecoPostModelData.fromJson(data)).toList();

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
//  {
//             "CashDiscount": null,
//             "CreditOrDebit": "codCredit",
//             "ReconcileAmount": 10,
//             "Selected": "tYES",
//             "ShortName": "v01",
//             "SrcObjAbs": 11,
//             "SrcObjTyp": "18",
//             "TransId": 43,
//             "TransRowId": 0
//         }

//  "LineSeq": 1,
//             "ShortName": "D1999",
//             "TransId": 4273768,
//             "TransRowId": 1,
//             "SrcObjTyp": "24",
//             "SrcObjAbs": 40369906,
//             "CreditOrDebit": "codCredit",
//             "ReconcileAmount": 100.0,
//             "CashDiscount": 0.0
  factory RecoPostModelData.fromJson(Map<String, dynamic> jsons) {
    return RecoPostModelData(
      cashDiscount: jsons['CashDiscount'] ?? 0,
      LineSeq: jsons['LineSeq'] ?? 0,

      creditOrDebit: jsons['CreditOrDebit'].toString(),
      // selected: jsons['Selected'].toString(),
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
