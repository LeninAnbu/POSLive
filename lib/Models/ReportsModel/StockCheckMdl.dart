// {
// "status": true,
// "msg": "Success",
// "data": "[{\"ItemCode\":\"100608B\",\"ItemName\":\"DELUX WEATHERGUARD EMULSION NEW LIGHT GREY  - 10 LTR\",\"SERIAL/BATCH\":\"1000621\",\"QUANTITY\":0.000000,\"BRANCH\":\"ARSGIT\",\"PRICE\":24790.983810},

import 'dart:convert';
import 'dart:developer';

class StockCheckModel {
  List<StockCheckList>? customerdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  StockCheckModel(
      {required this.customerdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory StockCheckModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        log('listlistlist length::${list.length}');
        List<StockCheckList> dataList =
            list.map((data) => StockCheckList.fromJson(data)).toList();
        return StockCheckModel(
            customerdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return StockCheckModel(
            customerdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return StockCheckModel(
          customerdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory StockCheckModel.error(String jsons, int stcode) {
    return StockCheckModel(
        customerdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class StockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  double? qty;
  double? price;
  StockCheckList({
    required this.price,
    required this.branch,
    required this.itemCode,
    required this.itemname,
    required this.qty,
    required this.serialbatch,
  });
  //{\"ItemCode\":\"100608B\",\"ItemName\":\"DELUX WEATHERGUARD EMULSION NEW LIGHT GREY  - 10 LTR\",\"SERIAL/BATCH\":\"1000621\",\"QUANTITY\":0.000000,\"BRANCH\":\"ARSGIT\",\"PRICE\":24790.983810}
  factory StockCheckList.fromJson(Map<String, dynamic> json) => StockCheckList(
        price: json['PRICE'] ?? '',
        branch: json['BRANCH'] ?? '',
        itemCode: json['ItemCode'] ?? '',
        itemname: json['ItemName'] ?? '',
        serialbatch: json['SERIAL/BATCH'] ?? '',
        qty: json['QUANTITY'] ?? 0.0,
      );
}
