import 'dart:convert';

class ReturnRegtModel {
  List<ReturnRegisterList>? returnRegdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  ReturnRegtModel(
      {required this.returnRegdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory ReturnRegtModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<ReturnRegisterList> dataList =
            list.map((data) => ReturnRegisterList.fromJson(data)).toList();
        return ReturnRegtModel(
            returnRegdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return ReturnRegtModel(
            returnRegdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return ReturnRegtModel(
          returnRegdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory ReturnRegtModel.error(String jsons, int stcode) {
    return ReturnRegtModel(
        returnRegdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class ReturnRegisterList {
  String? docno;
  int? docEntry;
  String? branch;
  String? terminal;
  String? cardcode;
  String? cardname;
  String? itemcode;
  String? itemname;
  String? date;

  ReturnRegisterList(
      {required this.branch,
      required this.cardcode,
      required this.cardname,
      required this.date,
      required this.docEntry,
      required this.docno,
      required this.itemcode,
      required this.itemname,
      required this.terminal});

  factory ReturnRegisterList.fromJson(Map<String, dynamic> json) =>
      ReturnRegisterList(
        branch: json['Branch'] ?? '',
        cardcode: json['Customer Code'] ?? '',
        cardname: json['Customer Name'] ?? '',
        date: json['State code'] ?? '',
        docEntry: json['Pincode'] ?? '',
        docno: json['Document number'] ?? '',
        itemcode: json['Item Code'] ?? 0.0,
        itemname: json['Item Name'] ?? '',
        terminal: json['Terminal'] ?? '',
      );
}
