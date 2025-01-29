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
    //     this.addtnlDiscPer,
    //    this.addtnlDiscVal,
    //    this.bnlc,

    //   this.brand,
    //    this.category,
    //  this.discOper,
    //   this.ean,
    //    this.hsn,

    //  this.itemCode,
    // this.itemName, this.transId,
    // this.locCode,
    // this.maxDiscPer,
    //  this.maxDiscVal,
    //  this.minDiscPer,
    //  this.minDiscVal,
    //  this.oP1,
    //  this.other1,
    //  this.priceDeviation,
    //  this.product,
    //  this.sac,
    //  this.segment,
    //  this.slpCode,
    //  this.syncDateTime,

    //  this.validFrom,
    //  this.validto,
  });

  // factory PosItems.fromMap(Map<String, dynamic> item) => PosItems(
  //       branch: item["Branch"] ?? "",
  //       itemCode: item["ItemCode"] ?? "",
  //       itemName: item["ItemName"] ?? "",
  //       transId: item["TransId"],
  //       inDate: item["InDate"] ?? "",
  //       inType: item["InType"] ?? "",
  //       serialBatch: item["SerialBatch"] ?? "",
  //       dis: item["VenCode"] ?? "",
  //       venName: item["VenName"] ?? "",
  //       qty: item["Qty"],
  //       openQty: item["OpenQty"],
  //       mrp: item["MRP"],
  //       sellPrice: item["SellPrice"],
  //       taxRate: item["TaxRate"],
  //       taxType: item["TaxType"] ?? "",
  //       cost: item["Cost"],
  //       maxdiscount: item["Maxdiscount"],
  //     );

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
