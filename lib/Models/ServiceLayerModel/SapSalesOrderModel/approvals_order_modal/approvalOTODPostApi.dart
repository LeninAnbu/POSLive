import '../../../DataModel/SeriesMode/SeriesModels.dart';

class ApprovalstoDocModal {
  ApprovalstoDocModal({
    required this.statusCode,
    this.erorrs,
    this.exception,
  });
  Errors? erorrs;
  int statusCode;
  String? exception;

  factory ApprovalstoDocModal.fromJson(int statusCode) {
    return ApprovalstoDocModal(
      statusCode: statusCode,
    );
  }

  factory ApprovalstoDocModal.fromJson2(
      int statusCode, Map<String, dynamic> jsons) {
    return ApprovalstoDocModal(
      statusCode: statusCode,
      erorrs: Errors.fromJson(jsons["error"]),
    );
  }
  factory ApprovalstoDocModal.issue(String resp, int stcode) {
    return ApprovalstoDocModal(
        exception: resp, statusCode: stcode, erorrs: null);
  }
}

class ApprovalsOTORModal {
  List<ApprovalsOrdersValue>? approvalsOrdersValue;
  String? error;
  Errors? erorrs;
  int? statusCode;
  ApprovalsOTORModal({
    this.approvalsOrdersValue,
    this.error,
    this.erorrs,
    this.statusCode,
  });
  factory ApprovalsOTORModal.fromJson(Map<String, dynamic> jsons, int stscode) {
    if (jsons['value'] != null) {
      final list = jsons['value'] as List; //jsonDecode
      // print(list);
      List<ApprovalsOrdersValue> dataList = list
          .map((dynamic enquiries) => ApprovalsOrdersValue.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return ApprovalsOTORModal(
          approvalsOrdersValue: dataList,
          statusCode: stscode,
          erorrs: null,
          error: null
          // nextLink:  jsons['odata.nextLink'].toString(),
          );
    } else {
      return ApprovalsOTORModal(
          approvalsOrdersValue: null,
          statusCode: stscode,
          erorrs: Errors.fromJson(jsons["error"]),
          error: null);
    }
  }

  factory ApprovalsOTORModal.issue(String e) {
    return ApprovalsOTORModal(
      approvalsOrdersValue: null,
      statusCode: null,
      erorrs: null,
      error: e,
    );
  }
}

class ApprovalsOrdersValue {
  int? docEntry;
  int? docNum;

  ApprovalsOrdersValue({
    required this.docEntry,
    required this.docNum,
  });

  factory ApprovalsOrdersValue.fromJson(dynamic jsons) {
    return ApprovalsOrdersValue(
      docEntry: jsons['DocEntry'] as int,
      docNum: jsons['DocNum'] as int,
    );
  }
//  {\"WddCode\":965998,\"WtmCode\":69,\"ObjType\":\"17\",\"CurrStep\":62,\
//  "CreateDate\":\"2022-06-08T00:00:00\",\"CreateTime\":1550,\"DraftEntry\":
//  787512,\"FromUser\":\"HOORDER\",\"DocNum\":3853,\"DocDate\":\"2022-06-08'
//  T00:00:00\",\"CardCode\":\"D9121\",\"CardName\":\"ED\"}
}
