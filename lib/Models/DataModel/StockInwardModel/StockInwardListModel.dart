class StockInwardList {
  String? docentry;
  String? baceDocentry;
  String? sapbaceDocentry;
  String? cardCode;
  String? branch;
  String? remarks;
  String? reqdocumentno;

  String? reqtransdate;

  String? documentno;

  String? reqfromWhs;
  String? reqtoWhs;

  String? docstatus;

  List<StockInwardDetails>? data;

  StockInwardList(
      {this.branch,
      this.remarks,
      this.docentry,
      this.cardCode,
      this.docstatus,
      this.documentno,
      this.reqdocumentno,
      this.reqfromWhs,
      this.reqtoWhs,
      this.baceDocentry,
      this.reqtransdate,
      this.data});
}

class StockInwardDetails {
  int? docentry;
  int? baseDocentry;
  int? baseDocline;
  bool? listClr;
  int? lineNo;
  String? itemcode;
  String? serialBatch;
  String? frmWhs;
  String? towhs;
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
  double? Scanned_Qty = 0.0;
  double? trans_Qty;
  String? baseDocNum;

  List<StOutSerialbatch>? StOutSerialbatchList;

  List<StockInSerialbatch>? serialbatchList;

  StockInwardDetails(
      {this.createdUserID,
      this.createdateTime,
      this.docentry,
      required this.baseDocline,
      required this.baseDocNum,
      required this.dscription,
      required this.itemcode,
      this.lastupdateIp,
      this.frmWhs,
      this.towhs,
      this.listClr,
      required this.lineNo,
      required this.qty,
      required this.baseDocentry,
      this.serialbatchList,
      this.StOutSerialbatchList,
      this.status,
      this.updatedDatetime,
      this.updateduserid,
      required this.price,
      required this.serialBatch,
      this.taxRate,
      this.taxType,
      this.Scanned_Qty,
      this.trans_Qty});
}

class StockInSerialbatch {
  String? baseDocentry;

  String? docentry;
  String? lineno;
  String? itemcode;
  String? itemName;

  int? qty;
  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StockInSerialbatch(
      {required this.lineno,
      this.docentry,
      this.baseDocentry,
      required this.itemcode,
      required this.itemName,
      required this.qty,
      this.scanbool,
      this.docstatus,
      required this.serialbatch});
}

class StOutSerialbatch {
  String? baseDocentry;
  String? docentry;
  String? lineno;
  String? itemcode;
  double? qty;
  String? serialbatch;
  String? docstatus;
  bool? scanbool = false;
  int? scannedQty;

  StOutSerialbatch(
      {required this.lineno,
      required this.docentry,
      required this.baseDocentry,
      required this.itemcode,
      required this.qty,
      this.scanbool,
      this.docstatus,
      required this.serialbatch});
}
