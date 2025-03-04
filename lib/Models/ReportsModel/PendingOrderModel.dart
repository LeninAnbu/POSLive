// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"Document Number\":16362,\"CustomerName \":\"MASASI CONSTRUCTION\",\"date\":\"2024-09-02T00:00:00\",\"Total\":1129496.000000,\"ItemCode\":\"1500016N\",\"ItemName\":\"CORAL WALL PUTTY/WALL PLASTER (NEW PORT) - 25KG\",\"Total Qty\":50.000000,\"Balance Qty\":0.000000},

import 'dart:convert';

class PendingOrdersModel {
  List<PendingOrdersList>? pendingOrderdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  PendingOrdersModel(
      {required this.pendingOrderdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory PendingOrdersModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<PendingOrdersList> dataList =
            list.map((data) => PendingOrdersList.fromJson(data)).toList();
        return PendingOrdersModel(
            pendingOrderdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return PendingOrdersModel(
            pendingOrderdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return PendingOrdersModel(
          pendingOrderdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory PendingOrdersModel.error(String jsons, int stcode) {
    return PendingOrdersModel(
        pendingOrderdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class PendingOrdersList {
  String? itemname;
  String? itemCode;
  int? docNum;
  String? custName;
  String? customerCode;
  String? date;
  double? totalQty;
  double? balQty;
  double? total;
  PendingOrdersList({
    required this.totalQty,
    required this.date,
    required this.total,
    required this.docNum,
    required this.custName,
    required this.customerCode,
    required this.itemCode,
    required this.itemname,
    required this.balQty,
  });
//  "data": "[{\"Document Number\":16362,\"CustomerName \":\"MASASI CONSTRUCTION\",\"date\":\"2024-09-02T00:00:00\",
//\"Total\":1129496.000000,\"ItemCode\":\"1500016N\",\"ItemName\":\"CORAL WALL PUTTY/WALL PLASTER (NEW PORT) - 25KG\",
//\"Total Qty\":50.000000,\"Balance Qty\":0.000000},

  factory PendingOrdersList.fromJson(Map<String, dynamic> json) {
    // log('xxxxx::${json['CustomerName'].toString()}');
    return PendingOrdersList(
      total: json['Total'] ?? 0,
      itemCode: json['ItemCode'] ?? '',
      itemname: json['ItemName'] ?? '',
      customerCode: json['Customer Code'] ?? '',
      totalQty: json['Total Qty'] ?? 0,
      balQty: json['Balance Qty'] ?? 0,
      docNum: json['Document Number'] ?? 0,
      date: json['date'] ?? '',
      custName: json['CustomerName'] ?? '',
    );
  }
}
