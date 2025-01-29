class ApprovalsOrdersModal {
  String? odatametadata;
  List<ApprovalsOrdersValue>? approvalsOrdersValue;
  String? error;
  String? nextLink;

  ApprovalsOrdersModal({
    required this.odatametadata,
    this.approvalsOrdersValue,
    this.error,
    this.nextLink,
  });
  factory ApprovalsOrdersModal.fromJson(Map<String, dynamic> jsons) {
    if (jsons['value'] != null) {
      final list = jsons['value'] as List; //jsonDecode
      // print(list);
      List<ApprovalsOrdersValue> dataList = list
          .map((dynamic enquiries) => ApprovalsOrdersValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ApprovalsOrdersModal(
        approvalsOrdersValue: dataList,
        odatametadata: jsons['odata.metadata'].toString(),
        // nextLink:  jsons['odata.nextLink'].toString(),
      );
    } else {
      return ApprovalsOrdersModal(
        odatametadata: null,
      );
    }
  }

  factory ApprovalsOrdersModal.issue(String e) {
    return ApprovalsOrdersModal(
      odatametadata: null,
      error: e,
    );
  }
}

class ApprovalsOrdersValue {
  int? docEntry;
  String? cardCode;
  String? cardName;
  int? docNum;
  double? docTotal;
  String? docDate;
  String? U_DeviceTransID;
  String? fromUser;
  String? objType;
  int? wddCode;
  ApprovalsOrdersValue({
    required this.docEntry,
    required this.cardCode,
    required this.cardName,
    required this.docTotal,
    required this.docDate,
    required this.U_DeviceTransID,
    required this.docNum,
    required this.objType,
    required this.fromUser,
    required this.wddCode,
  });

  factory ApprovalsOrdersValue.fromJson(dynamic jsons) {
    return ApprovalsOrdersValue(
      docEntry: jsons['DraftEntry'] ?? 0,
      cardCode: jsons['CardCode'] ?? '',
      cardName: jsons['CardName'] ?? '',
      U_DeviceTransID: jsons['U_DeviceTransID'] ?? '',
      docTotal: jsons['DocTotal'] ?? 0,
      docDate: jsons['DocDate'] ?? '',
      docNum: jsons['DocNum'] ?? 0,
      fromUser: jsons['FromUser'] ?? '',
      objType: jsons['ObjType'] ?? '',
      wddCode: jsons['WddCode'] ?? 0,
    );
  }
//  {\"WddCode\":965998,\"WtmCode\":69,\"ObjType\":\"17\",\"CurrStep\":62,\
//  "CreateDate\":\"2022-06-08T00:00:00\",\"CreateTime\":1550,\"DraftEntry\":
//  787512,\"FromUser\":\"HOORDER\",\"DocNum\":3853,\"DocDate\":\"2022-06-08'
//  T00:00:00\",\"CardCode\":\"D9121\",\"CardName\":\"ED\"}
}
