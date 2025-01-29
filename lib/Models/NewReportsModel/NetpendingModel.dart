import 'dart:convert';
import 'dart:developer';

class NetPendingOrderModel {
  NetPendingOrderModel({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NetPendingOrderModelData>? openOutwardData;
  String? error;
  int? statusCode;

  factory NetPendingOrderModel.fromJson(
      Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<NetPendingOrderModelData> dataList = list
            .map((dynamic enquiries) =>
                NetPendingOrderModelData.fromJson(enquiries))
            .toList();
        return NetPendingOrderModel(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NetPendingOrderModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NetPendingOrderModel(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory NetPendingOrderModel.error(String e, int stcode) {
    return NetPendingOrderModel(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class NetPendingOrderModelData {
  String slpName;
  int salesOrderNo;
  String salesOrderDate;
  int soElapsedDays;
  String notes;
  String cardName;
  String itemCode;
  String description;
  String subGroup;
  double salesOrderQty;
  double deliveredQty;
  double balanceQty;
  double onHand;
  double volume;
  double sellingPrice;
  double openAmount;
  double discountAmount;
  double afterDiscPercent;
  double taxAmount;
  double netAmount;

  NetPendingOrderModelData({
    required this.slpName,
    required this.salesOrderNo,
    required this.salesOrderDate,
    required this.soElapsedDays,
    required this.notes,
    required this.cardName,
    required this.itemCode,
    required this.description,
    required this.subGroup,
    required this.salesOrderQty,
    required this.deliveredQty,
    required this.balanceQty,
    required this.onHand,
    required this.volume,
    required this.sellingPrice,
    required this.openAmount,
    required this.discountAmount,
    required this.afterDiscPercent,
    required this.taxAmount,
    required this.netAmount,
  });

  factory NetPendingOrderModelData.fromJson(Map<String, dynamic> json) {
    return NetPendingOrderModelData(
      slpName: json['slpname'] ?? '',
      salesOrderNo: json['Sales Order No'] ?? "",
      salesOrderDate: json['Sales Order Date'] ?? "",
      soElapsedDays: json['SO Elapsed Days'] ?? 0,
      notes: json['Notes'] ?? "",
      cardName: json['CardName'] ?? "",
      itemCode: json['ItemCode'] ?? "",
      description: json['Dscription'] ?? "",
      subGroup: json['SubGrp'] ?? "",
      salesOrderQty: json['Sales Order Qty'] ?? 0,
      deliveredQty: json['Delivered Qty'] ?? 0,
      balanceQty: json['Balance Qty'] ?? 0,
      onHand: json['OnHand'] ?? 0,
      volume: json['Volume'] ?? 0,
      sellingPrice: json['Selling Price'] ?? 0,
      openAmount: json['Open Amount'] ?? 0,
      discountAmount: json['Discount Amount'] ?? 0,
      afterDiscPercent: json['After Disc%'] ?? 0,
      taxAmount: json['Tax Amt'] ?? 0,
      netAmount: json['Net Amount'] ?? 0,
    );
  }
  Map<String, Object?> toMap() => {
        'slpname': slpName,
        'Sales Order No': salesOrderNo,
        'Sales Order Date': salesOrderDate,
        'SO Elapsed Days': soElapsedDays,
        'Notes': notes,
        'CardName': cardName,
        'ItemCode': itemCode,
        'Dscription': description,
        'SubGrp': subGroup,
        'Sales Order Qty': salesOrderQty,
        'Delivered Qty': deliveredQty,
        'Balance Qty': balanceQty,
        'OnHand': onHand,
        'Volume': volume,
        'Selling Price': sellingPrice,
        'Open Amount': openAmount,
        'Discount Amount': discountAmount,
        'After Disc%': afterDiscPercent,
        'Tax Amt': taxAmount,
        'Net Amount': netAmount,
      };
}
