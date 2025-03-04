// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"docentry\":564926,\"docnum\":1016788,\"docdate\":\"2024-10-14T00:00:00\",\"taxdate\":\"2024-10-14T00:00:00\",\"cardcode\":\"D14131\",\"cardname\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"doctotal\":73632.000000,\"paid\":0.000000,\"balance\":73632.000000}]"
// }
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
      // log('resprespresp::${jsons['data'].toString()}');
      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
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

// [{\"docentry\":564926,\"docnum\":1016788,\"docdate\":\"2024-10-14T00:00:00\",\"taxdate\":\"2024-10-14T00:00:00\",\"cardcode\":\"D14131\",\"cardname\":\"21ST CENTURY FOOD & PACKAGING LTD SILO\",\"doctotal\":73632.000000,\"paid\":0.000000,\"balance\":73632.000000}]"

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
