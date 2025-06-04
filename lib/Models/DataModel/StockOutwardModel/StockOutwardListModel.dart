// ignore_for_file: non_constant_identifier_names

class StockOutwardList {
  String? docentry;
  String? baceDocentry;

  String? cardCode;
  String? cardName;
  String? sapbaceDocentry;
  double? stock;

  String? remarks;
  String? branch;
  // int? reqdocno;
  // String? reqdocseries;
  // int? reqdocseriesno;
  String? reqtransdate;
  // String? reqdoctime;
  // String? reqsystime;
  String? documentno;
  // int? seresid;
  // int? seriesnum;
  // String? transactiondate;
  // String? transtime;
  // String? sysdatetime;
  String? reqfromWhs;
  String? reqtoWhs;
  String? u_reqWhs;

  // int? totalitems;
  // double? totalweight;
  // double? totalqty;
  // double? totalltr;
  // String? isagainstorder;
  // String? isagainststock;
  String? docstatus;
  // String? salesexec;
  // String? createdateTime;
  // String? updatedDatetime;
  // int? createdUserID;
  // int? updateduserid;
  // String? lastupdateIp;
  // int?scanToatal;
  // int? transTotal;
  List<StockOutwardDetails> data;

  StockOutwardList(
      {required this.branch,
      // required this.createdUserID,
      // required this.createdateTime,
      this.baceDocentry,
      this.stock,
      this.docentry,
      this.docstatus,
      required this.documentno,
      this.u_reqWhs,
      required this.sapbaceDocentry,
      this.cardCode,
      this.cardName,

      // required this.isagainstorder,
      // required this.isagainststock,
      // required this.lastupdateIp,
      // required this.reqdocno,
      // required this.reqdocseries,
      // required this.reqdocseriesno,
      // required this.reqdoctime,
      required this.reqfromWhs,
      // required this.reqsystime,
      required this.remarks,
      required this.reqtoWhs,
      required this.reqtransdate,
      // required this.salesexec,
      // required this.seresid,
      // required this.seriesnum,
      // required this.sysdatetime,
      // required this.totalitems,
      // required this.totalltr,
      // required this.totalqty,
      // required this.totalweight,
      // required this.transactiondate,
      // required this.transtime,
      // required this.updatedDatetime,
      // required this.updateduserid,
      // this.scanToatal,
      // this.transTotal,

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

  // String? serialbatch;
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
  // int? openQty;
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
