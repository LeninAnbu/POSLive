class StockReqPostiModel {
  int lineNum;
  String itemCode;
  String itemDescription;
  double quantity;
  String currency;
  String toWarehouseCode;
  String? fromWarehouseCode;
  String? gitWarehouseCode;

  StockReqPostiModel(
      {required this.currency,
      required this.fromWarehouseCode,
      required this.itemCode,
      required this.itemDescription,
      required this.quantity,
      required this.toWarehouseCode,
      required this.gitWarehouseCode,
      required this.lineNum});
  Map<String, dynamic> tojson() {
    Map<String, String> map = {
      "ItemCode": itemCode.toString(),
      "ItemDescription": itemDescription,
      "LineNum": lineNum.toString(),
      "Quantity": quantity.toString(),
      "Currency": currency,
      "FromWarehouseCode": fromWarehouseCode!,
      "WarehouseCode": gitWarehouseCode.toString(),
    };
    return map;
  }
}
