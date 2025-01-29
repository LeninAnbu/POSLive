class ItemCodeListModel {
  ItemCodeListModel({
    this.basic,
    this.discount,
    this.taxvalue,
    this.netvalue,
    this.taxable,
    this.taxCode,
    this.maxdiscount,
    this.discountper,
    this.docEntry,
    this.baselineid,
    this.branch,
    this.itemCode,
    this.itemName,
    this.serialBatch,
    this.openQty,
    this.qty,
    this.specialprice,
    this.purchasedate,
    this.createdateTime,
    this.snapdatetime,
    this.updatedDatetime,
    this.createdUserID,
    this.lastupdateIp,
    this.updateduserid,
    this.inDate,
    this.inType,
    this.venCode,
    this.venName,
    this.mrp,
    this.sellPrice,
    this.cost,
    this.taxRate,
    this.taxType,
    this.invoiceNo,
    this.liter,
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.uSpecificGravity,
    this.weight,
  });
  double? uPackSize;
  int? uTINSPERBOX;
  double? uSpecificGravity;
  String? maxdiscount;
  String? taxCode;

  double? basic;
  double? taxable;
  double? discount;
  double? taxvalue;
  double? netvalue;
  double? discountper;
  String? docEntry;

  int? baselineid;
  String? branch;
  String? itemCode;
  String? itemName;
  String? inDate;
  String? inType;
  String? serialBatch;
  int? openQty;
  double? qty;

  String? venCode;
  String? venName;
  double? mrp;
  double? sellPrice;
  double? specialprice;
  String? purchasedate;
  String? snapdatetime;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? cost;
  double? taxRate;
  String? taxType;
  String? invoiceNo;
  double? liter;
  double? weight;
}
