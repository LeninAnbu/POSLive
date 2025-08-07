class StockOutwardList {
  String? docentry;
  String? baceDocentry;

  String? cardCode;
  String? cardName;
  String? sapbaceDocentry;
  double? stock;

  String? remarks;
  String? branch;

  String? reqtransdate;

  String? documentno;

  String? reqfromWhs;
  String? reqtoWhs;
  String? u_reqWhs;

  String? docstatus;

  List<StockOutwardDetails> data;

  StockOutwardList(
      {required this.branch,
      this.baceDocentry,
      this.stock,
      this.docentry,
      this.docstatus,
      required this.documentno,
      this.u_reqWhs,
      required this.sapbaceDocentry,
      this.cardCode,
      this.cardName,
      required this.reqfromWhs,
      required this.remarks,
      required this.reqtoWhs,
      required this.reqtransdate,
      required this.data});
}

class StockOutwardDetails {
  int? docentry;
  int? baseDocentry;
  int? baseDocline;
  int? lineNo;
  String? itemcode;
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
  String? managedBy;

  double? balQty;
  double? stock;
  double? Scanned_Qty = 0;
  double? trans_Qty;
  bool? listClr;
  bool? insertValue;

  List<StockOutSerialbatch>? serialbatchList;

  StockOutwardDetails(
      {this.createdUserID,
      this.createdateTime,
      this.docentry,
      this.listClr,
      this.balQty,
      this.insertValue,
      this.managedBy,
      this.stock,
      this.baseDocline,
      this.dscription,
      this.itemcode,
      this.lastupdateIp,
      this.lineNo,
      this.qty,
      this.baseDocentry,
      this.serialbatchList,
      this.status,
      this.updatedDatetime,
      this.updateduserid,
      this.price,
      this.serialBatch,
      this.taxRate,
      this.taxType,
      this.Scanned_Qty,
      this.trans_Qty});
}

class StockOutSerialbatch {
  String? docentry;
  String? baseDocentry;
  String? lineno;
  String? itemcode;
  double? qty;

  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StockOutSerialbatch(
      {required this.lineno,
      this.docentry,
      required this.itemcode,
      required this.qty,
      this.scanbool,
      this.docstatus,
      this.baseDocentry,
      required this.serialbatch});
}
