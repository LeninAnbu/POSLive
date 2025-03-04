import 'dart:developer';

class SchemeQuotModal {
  SchemeQuotModal(
      {required this.status,
      required this.message,
      this.saleOrder,
      required this.statuscode,
      this.exception});

  bool? status;
  String? message;
  List<SchemeQuotModalData>? saleOrder;
  String? exception;
  int statuscode;

  factory SchemeQuotModal.fromJson(Map<String, dynamic> jsons, int statuscode) {
    if (jsons['saleQuoatation'] != null) {
      var list = jsons['saleQuoatation'] as List;

      List<SchemeQuotModalData> dataList = list
          .map((dynamic enquiries) => SchemeQuotModalData.fromJson(enquiries))
          .toList();
      return SchemeQuotModal(
          saleOrder: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: statuscode);
    } else {
      log("stcode$statuscode");
      return SchemeQuotModal(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          saleOrder: null,
          statuscode: statuscode);
    }
  }
  factory SchemeQuotModal.issue(int statuscode) {
    return SchemeQuotModal(
        status: null, message: null, saleOrder: null, statuscode: statuscode);
  }

  factory SchemeQuotModal.exception(String e, int statuscode) {
    return SchemeQuotModal(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        saleOrder: null);
  }
}

class SchemeQuotModalData {
  int docEntry;
  String schemeEntry;
  int lineNum;

  double discPer;
  double discVal;

  SchemeQuotModalData(
      {required this.docEntry,
      required this.schemeEntry,
      required this.lineNum,
      required this.discPer,
      required this.discVal});

  factory SchemeQuotModalData.fromJson(dynamic jsons) {
    log('jsons::${jsons}');
    return SchemeQuotModalData(
      docEntry: int.parse(jsons['docEntry'].toString()),
      schemeEntry: jsons['schemeEntry'].toString(),
      lineNum: int.parse(jsons['lineNum'].toString()),
      discPer: double.parse(jsons['discPer'].toString()),
      discVal: double.parse(jsons['discVal'].toString()),
    );
  }
}

// for api
