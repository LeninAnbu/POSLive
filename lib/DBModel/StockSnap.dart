const String tableStockSnap = "StockSnap";

class StockSnapT {
  static String itemcode = "itemcode";
  static String itemname = "itemname";
  static String branch = "branch";
  static String terminal = "terminal";
  static String serialbatch = "serialbatch";
  static String quantity = "quantity";
  static String sellprice = "sellprice";
  static String mrpprice = "mrpprice";
  static String specialprice = "specialprice";
  static String maxdiscount = "maxdiscount";
  static String taxrate = "taxrate";
  static String taxCode = "taxCode";
  static String uPackSize = "UPackSize";
  static String uTINSPERBOX = "UTINSPERBOX";
  static String uSpecificGravity = "USpecificGravity";
  static String uPackSizeuom = "UPackSizeUom";
  static String purchasedate = "purchasedate";
  static String snapdatetime = "snapdatetime";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String liter = "liter";
  static String weight = "weight";
}

class StockSnapTModelDB {
  String? itemname;
  String? itemcode;
  String? branchcode;
  String? serialbatch;
  String? quantity;
  String? sellprice;
  String? mrpprice;
  String? taxrate;
  String? taxCode;

  String uPackSize;
  int uTINSPERBOX;
  String uSpecificGravity;
  String? uPackSizeuom;
  String? specialprice;
  String? maxdiscount;
  String? purchasedate;
  String? snapdatetime;
  String? branch;
  String? terminal;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  String? transentry;
  double? liter;
  double? weight;

  StockSnapTModelDB({
    required this.uPackSizeuom,
    required this.uPackSize,
    required this.uTINSPERBOX,
    required this.uSpecificGravity,
    required this.branch,
    required this.terminal,
    required this.itemname,
    required this.branchcode,
    this.taxCode,
    required this.createdUserID,
    required this.createdateTime,
    required this.itemcode,
    required this.lastupdateIp,
    required this.maxdiscount,
    required this.taxrate,
    required this.mrpprice,
    required this.sellprice,
    required this.purchasedate,
    required this.quantity,
    required this.serialbatch,
    required this.snapdatetime,
    required this.specialprice,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.liter,
    required this.weight,
  });

  Map<String, Object?> toMap() => {
        StockSnapT.itemname: itemname,
        StockSnapT.branch: branch,
        StockSnapT.terminal: terminal,
        StockSnapT.itemcode: itemcode,
        StockSnapT.taxCode: taxCode,
        StockSnapT.maxdiscount: maxdiscount,
        StockSnapT.taxrate: taxrate,
        StockSnapT.mrpprice: mrpprice,
        StockSnapT.purchasedate: purchasedate,
        StockSnapT.quantity: quantity,
        StockSnapT.sellprice: sellprice,
        StockSnapT.serialbatch: serialbatch,
        StockSnapT.uPackSizeuom: uPackSizeuom,
        StockSnapT.uPackSize: uPackSize,
        StockSnapT.uTINSPERBOX: uTINSPERBOX,
        StockSnapT.uSpecificGravity: uSpecificGravity,
        StockSnapT.snapdatetime: snapdatetime,
        StockSnapT.specialprice: specialprice,
        StockSnapT.createdUserID: createdUserID,
        StockSnapT.createdateTime: createdateTime,
        StockSnapT.lastupdateIp: lastupdateIp,
        StockSnapT.updatedDatetime: updatedDatetime,
        StockSnapT.updateduserid: updateduserid,
        StockSnapT.liter: liter,
        StockSnapT.weight: weight,
      };
}
