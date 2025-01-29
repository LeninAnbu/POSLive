const String tableStockTrans= "StockTrans";

class StockTransT {
  static String itemcode = "itemcode";
  static String branchcode = "branchcode";
  static String serialbatch = "serialbatch";
  static String quantity = "quantity";
  static String sellprice = "sellprice";
  static String mrpprice = "mrpprice";
  static String specialprice = "specialprice";
  static String maxdiscount = "maxdiscount";
  static String purchasedate = "purchasedate";
  static String snapdatetime = "snapdatetime";
  static String transtype = "transtype";
  static String transentry = "transentry";
  static String transno = "transno";
  static String translineid = "translineid";
  static String pushstatus = "pushstatus";
  static String transdatetime = "transdatetime";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class StockTransTModelDB {
  String? itemcode;
  String? branchcode;
  String? serialbatch;
  String? quantity;
  String? sellprice;
  String? mrpprice;
  String? specialprice;
  String? maxdiscount;
  String? purchasedate;
  String? snapdatetime;
  String? transtype ;
  String? transno ;
  String? translineid ;
  String? pushstatus ;
  String? transdatetime ;
  String? transentry;


  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  StockTransTModelDB({
      required this.branchcode,
      required this.createdUserID,
      required this.createdateTime,
      required this.itemcode,
      required this.lastupdateIp,
      required this.maxdiscount,
      required this.mrpprice,
      required this.purchasedate,
      required this.quantity,
      required this.sellprice,
      required this.serialbatch,
      required this.snapdatetime,
      required this.specialprice,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.pushstatus,
      required this.transdatetime,
      required this.translineid,
      required this.transno,
      required this.transtype,
      required this.transentry
      });

  Map<String, Object?> toMap() => {
        StockTransT.branchcode:branchcode,
        StockTransT.itemcode:itemcode,
        StockTransT.maxdiscount:maxdiscount,
        StockTransT.mrpprice:mrpprice,
        StockTransT.purchasedate:purchasedate,
        StockTransT.quantity:quantity,
        StockTransT.sellprice:sellprice,
        StockTransT.serialbatch:serialbatch,
        StockTransT.snapdatetime:snapdatetime,
        StockTransT.specialprice:specialprice,
        StockTransT.transdatetime:transdatetime,
        StockTransT.transentry:transentry,
        StockTransT.translineid:translineid,
        StockTransT.transno:transno,
        StockTransT.transtype:transtype,
        StockTransT.pushstatus:pushstatus,
        StockTransT.createdUserID: createdUserID,
        StockTransT.createdateTime: createdateTime,
        StockTransT.lastupdateIp: lastupdateIp,
        StockTransT.updatedDatetime: updatedDatetime,
        StockTransT.updateduserid: updateduserid,
      };
}
