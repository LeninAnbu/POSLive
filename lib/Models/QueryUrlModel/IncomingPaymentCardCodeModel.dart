import 'dart:convert';
import 'dart:developer';

class IncomingPayCardCodeModel {
  IncomingPayCardCodeModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<IncomingPayCardCodeModelData>? activitiesData;
  String? error;
  int? statusCode;

  factory IncomingPayCardCodeModel.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List;
        List<IncomingPayCardCodeModelData> dataList = list
            .map((dynamic enquiries) =>
                IncomingPayCardCodeModelData.fromJson(enquiries))
            .toList();
        return IncomingPayCardCodeModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return IncomingPayCardCodeModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return IncomingPayCardCodeModel(
        message: null,
        status: null,
        activitiesData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory IncomingPayCardCodeModel.error(String e, int stcode) {
    return IncomingPayCardCodeModel(
      message: null,
      status: null,
      activitiesData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class IncomingPayCardCodeModelData {
  int docEntry;
  int docNum;
  String cardCode;
  String taxCode;

  double paid;
  double balance;
  String docDate;
  double docTotal;
  String cardName;
  String taxDate;
  int? invoiceClr;
  bool? checkBClr;
  IncomingPayCardCodeModelData({
    required this.docDate,
    required this.cardCode,
    required this.cardName,
    required this.balance,
    required this.taxCode,
    required this.paid,
    required this.taxDate,
    required this.docEntry,
    this.checkBClr,
    this.invoiceClr,
    required this.docNum,
    required this.docTotal,
  });

  factory IncomingPayCardCodeModelData.fromJson(dynamic jsons) {
    return IncomingPayCardCodeModelData(
      docDate: jsons['docdate'] ?? '',
      cardCode: jsons['cardcode'] ?? "",
      cardName: jsons['cardname'] ?? "",
      docEntry: jsons['docentry'] ?? 0,
      taxCode: jsons['taxCode'] ?? '',
      docNum: jsons['docnum'] ?? 0,
      docTotal: jsons['doctotal'] ?? 0,
      paid: jsons['paid'] ?? 0,
      balance: jsons['balance'] ?? 0,
      taxDate: jsons['taxdate'] ?? "",
    );
  }
}
