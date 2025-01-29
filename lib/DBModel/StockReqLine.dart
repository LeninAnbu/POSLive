const String tableStockReqLineT = "StockReqLineT";

class StockReqLineT {
  static String docentry = "docentry";
  static String branch = "branch";
  static String terminal = "terminal";
  static String lineNo = "lineNo";
  static String itemcode = "itemcode";
  static String serialBatch = "serialBatch";
  static String dscription = "dscription";
  static String quantity = "quantity";
  static String price = "price";
  static String taxRate = "taxRate";
  static String taxType = "taxType";
  static String status = "status";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class StockReqLineTDB {
  int? docentry;
  int? lineNo;
  String? itemcode;
  String? branch;
  String? terminal;
  String? serialBatch;
  String? dscription;
  double? qty;
  double? price;
  double? taxRate;
  String? taxType;
  String? status;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  StockReqLineTDB(
      {
        required this.createdUserID,
        required this.createdateTime,
        required this.docentry,
        required this.branch,
        required this.terminal,
        required this.dscription,
        required this.itemcode,
        required this.lastupdateIp,
        required this.lineNo,
        required this.qty,
        required this.status,
        required this.updatedDatetime,
        required this.updateduserid,
        required this.price,
        required this.serialBatch,
        required this.taxRate,
        required this.taxType
      });
factory StockReqLineTDB.fromjson(Map<String , dynamic> resp){
    return StockReqLineTDB(
      createdUserID: resp['createdUserID'], createdateTime: resp['createdateTime'], 
      docentry: resp['docentry'],branch: resp['branch'], terminal: resp['terminal'], 
      dscription: resp['dscription'], itemcode: resp['itemcode'], 
      lastupdateIp: resp['lastupdateIp'], lineNo: resp['lineNo'], 
      qty:double.parse(resp['quantity'].toString()), status: resp['status'], 
      updatedDatetime: resp['updatedDatetime'], updateduserid: resp['updateduserid'], 
      price: double.parse(resp['price'].toString()), 
      serialBatch: resp['serialBatch'], 
      taxRate:double.parse(resp['taxRate'].toString()), taxType: resp['taxType']
      );}
  Map<String, Object?> toMap(int iddoc) => {
        StockReqLineT.branch:branch,
        StockReqLineT.terminal:terminal,
        StockReqLineT.createdUserID:createdUserID,
        StockReqLineT.createdateTime:createdateTime,
        StockReqLineT.docentry:iddoc,
        StockReqLineT.serialBatch:serialBatch,
        StockReqLineT.serialBatch:serialBatch,
        StockReqLineT.price:price,
        StockReqLineT.taxRate:taxRate,
        StockReqLineT.taxType:taxType,
        StockReqLineT.dscription:dscription,
        StockReqLineT.itemcode:itemcode,
        StockReqLineT.lastupdateIp:lastupdateIp,
        StockReqLineT.lineNo:lineNo,
        StockReqLineT.quantity:qty,
        StockReqLineT.status:status,
        StockReqLineT.updatedDatetime:updatedDatetime,
        StockReqLineT.updateduserid:updateduserid,
      };
}