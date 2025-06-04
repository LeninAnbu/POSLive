const String tableposdesign = "ItemMasterDemo";

class PosColumn {
  static String transId = "TransId";
  static String branch = "Branch";
  static String itemCode = "ItemCode";
  static String itemName = "ItemName";
  static String serialBatch = "SerialBatch";
  static String openQty = "OpenQty";
  static String qty = "Qty";
  static String inDate = "InDate";
  static String inType = "InType";
  static String displayQty = "DisplayQty";
  static String minimumQty = "MinimumQty";
  static String mrp = "MRP";
  static String sellPrice = "SellPrice";
  static String maxdiscount = "Maxdiscount";
  static String cost = 'Cost';
  static String taxRate = "TaxRate";
  static String maximumQty = "MaximumQty";
}

class PosItems {
  int? maxdiscount;
  int? transId;
  String? branch;
  String? itemCode;
  String? itemName;
  String? serialBatch;
  int? openQty;
  int? qty;
  String? inDate;
  String? inType;
  String? maximumQty;
  String? minimumQty;
  int? mrp;
  int? sellPrice;
  int? cost;
  int? taxRate;
  String? dispalyQty;

  PosItems({
    required this.qty,
    required this.itemCode,
    required this.itemName,
    required this.transId,
    required this.branch,
    required this.minimumQty,
    required this.maximumQty,
    required this.inDate,
    required this.inType,
    required this.serialBatch,
    required this.openQty,
    required this.sellPrice,
    required this.mrp,
    required this.taxRate,
    required this.cost,
    required this.dispalyQty,
    required this.maxdiscount,
  });

  Map<String, Object?> toMap() => {
        PosColumn.branch: branch,
        PosColumn.itemCode: itemCode,
        PosColumn.itemName: itemName,
        PosColumn.transId: transId,
        PosColumn.serialBatch: serialBatch,
        PosColumn.qty: qty,
        PosColumn.openQty: openQty,
        PosColumn.maxdiscount: maxdiscount,
        PosColumn.minimumQty: minimumQty,
        PosColumn.inDate: branch,
        PosColumn.inType: itemCode,
        PosColumn.sellPrice: sellPrice,
        PosColumn.mrp: mrp,
        PosColumn.cost: cost,
        PosColumn.taxRate: taxRate,
        PosColumn.displayQty: dispalyQty,
        PosColumn.maxdiscount: maxdiscount,
      };
}
