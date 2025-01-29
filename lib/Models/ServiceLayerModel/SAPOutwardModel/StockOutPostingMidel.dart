class StockOutLineModel {
  String itemCode;
  double quantity;
  double unitPrice;
  String? baseType;
  String fromWarehouseCode;
  List<StockOutbatch> batchNumbers;
  int baseDocentry;
  String? baseline;
  int lineNum;
  String itemDescription;
  // String Currency;
  String toWarehouseCode;
  StockOutLineModel({
    required this.itemCode,
    required this.quantity,
    required this.unitPrice,
    required this.batchNumbers,
    // required this.Currency,
    required this.baseType,
    required this.baseDocentry,
    required this.baseline,
    required this.fromWarehouseCode,
    required this.itemDescription,
    required this.toWarehouseCode,
    required this.lineNum,
    required,
  });

  factory StockOutLineModel.fromJson(Map<String, dynamic> json) =>
      StockOutLineModel(
        itemCode: json["ItemCode"],
        quantity: json["Quantity"],
        unitPrice: json["UnitPrice"],
        baseType: json["BaseType"],
        batchNumbers: List<StockOutbatch>.from(
            json["BatchNumbers"].map((x) => StockOutbatch.fromJson(x))),
        baseDocentry: json['BaseEntry'],
        baseline: json['BaseLine'],
        fromWarehouseCode: json['FromWarehouseCode'],
        itemDescription: json['ItemDescription'],
        toWarehouseCode: json['WarehouseCode'],
        lineNum: json["LineNum"],
      );

  Map<String, dynamic> toJson() => {
        "ItemCode": itemCode,
        "Quantity": quantity,
        "UnitPrice": unitPrice,
        "WarehouseCode": toWarehouseCode,
        "ItemDescription": itemDescription,
        "LineNum": lineNum,
        // "Currency": Currency,
        "FromWarehouseCode": fromWarehouseCode,
        "BaseType": baseType,
        "BaseLine": baseline,
        "BaseEntry": baseDocentry,
        "BatchNumbers": List<dynamic>.from(batchNumbers.map((x) => x.toJson())),
      };
}

class StockOutbatch {
  // int baseLineNumber;
  double quantity;
  String batchNumberProperty;

  StockOutbatch({
    // required this.baseLineNumber,
    required this.quantity,
    required this.batchNumberProperty,
  });

  factory StockOutbatch.fromJson(Map<String, dynamic> json) => StockOutbatch(
        // baseLineNumber: json["BaseLineNumber"],
        quantity: json["Quantity"],
        batchNumberProperty: json["BatchNumbers"],
      );

  Map<String, dynamic> toJson() => {
        // "BaseLineNumber": baseLineNumber,
        "Quantity": quantity,
        "BatchNumber": batchNumberProperty,
      };
}


// import 'dart:convert';
// import 'dart:developer';
// class StockOutLineModel {
  // String? baseDocentry;
  // String? baseline;
  // int lineNum;
  // String ItemCode;
  // String ItemDescription;
  // int Quantity;
  // double? unitPrice;
  // String Currency;
  // String toWarehouseCode;
  // String? FromWarehouseCode;
//    List<StockOutbatch>? batchTble;
//   StockOutLineModel(
      // {required this.Currency,
      //  this.batchTble,
      // required this.baseDocentry,
      // required this.baseline,
      // required this.FromWarehouseCode,
      // required this.ItemCode,
      // required this.ItemDescription,
      // required this.Quantity,
      // required this.unitPrice,
      // required this.toWarehouseCode,
      // required this.lineNum});
//   Map<String, dynamic> tojson() {
//     Map<String, String> map = {
      // "ItemCode": ItemCode.toString(),
      // "ItemDescription": ItemDescription,
      // "LineNum": lineNum.toString(),
      // "Quantity": Quantity.toString(),
      // "Currency": Currency,
      // "FromWarehouseCode": FromWarehouseCode!,
      // "WarehouseCode": toWarehouseCode.toString(),
      // "UnitPrice": unitPrice.toString(),
      // "BaseLine": baseline.toString(),
      // "BaseEntry": baseDocentry.toString(),
//       "BatchNumbers":
//       // batchTble!.map((e) => e.tojson2()).toList(),
//      List<dynamic>.from(batchTble.map((x) => x.toMap())),

  
//     };
//     return map;
//   }
// }

// class StockOutbatch {
//   String? lineno;
//   String? itemcode;
//   int? qty;
//   String? serialbatch;
//   int? scannedQty;

//   StockOutbatch(
//       {required this.lineno,
//        this.itemcode,
//       required this.qty,
//       required this.serialbatch});

//     factory StockOutbatch.fromMap(Map<String, dynamic> json) => StockOutbatch(
//         lineno: json["BaseLineNumber"],
//         qty: json["Quantity"],
//         serialbatch: json["BatchNumberProperty"],
//     );

//     Map<String, dynamic> toMap() => {
//         "BaseLineNumber": lineno,
//         "Quantity": qty,
//         "BatchNumberProperty": serialbatch,
//     };
// }

//   // Map<String, dynamic> tojson2() {
//   //   Map<String, String> map = {
//   //     "ItemCode": itemcode.toString(),
//   //     "LineNum": lineno.toString(),
//   //     "Quantity": qty.toString(),
//   //     "BatchNumber": serialbatch.toString()
//   //   };
//   //   return map;
//   // }

