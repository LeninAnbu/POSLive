class StockInLineModel {
  String itemCode;
  double quantity;
  double unitPrice;
  String fromWarehouseCode;
  List<StockInbatch> batchNumbers;
  int? baseDocentry;
  String? baseline;
  int lineNum;
  String itemDescription;
  String toWarehouseCode;
  StockInLineModel({
    required this.itemCode,
    this.baseDocentry,
    this.baseline,
    required this.quantity,
    required this.unitPrice,
    required this.batchNumbers,
    required this.fromWarehouseCode,
    required this.itemDescription,
    required this.toWarehouseCode,
    required this.lineNum,
    required,
  });

  factory StockInLineModel.fromJson(Map<String, dynamic> json) =>
      StockInLineModel(
        itemCode: json["ItemCode"],
        quantity: json["Quantity"],
        unitPrice: json["UnitPrice"],
        batchNumbers: List<StockInbatch>.from(
            json["BatchNumbers"].map((x) => StockInbatch.fromJson(x))),
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
        "FromWarehouseCode": fromWarehouseCode,
        "U_BaseLine": baseline,
        "U_BaseEntry": baseDocentry,
        "BatchNumbers":
            List<dynamic>.from(batchNumbers.map((x) => x.toJson3())),
      };
}

class StockInbatch {
  double quantity;
  String batchNumberProperty;

  StockInbatch({
    // required this.baseLineNumber,
    required this.quantity,
    required this.batchNumberProperty,
  });

  factory StockInbatch.fromJson(Map<String, dynamic> json) => StockInbatch(
        // baseLineNumber: json["BaseLineNumber"],
        quantity: json["Quantity"],
        batchNumberProperty: json["BatchNumbers"],
      );

  Map<String, dynamic> toJson3() => {
        // "BaseLineNumber": baseLineNumber,
        "Quantity": quantity,
        "BatchNumber": batchNumberProperty,
      };
}
