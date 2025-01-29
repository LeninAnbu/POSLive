const String tableStockReqHDT = "StockReqHDT";

class StockReqHDT {
  static String docentry = "docentry";
  static String cardCode = "CardCode";
  static String cardName = "CardName";
  static String doctype = "doctype";
  static String branch = "branch";
  static String terminal = "terminal";
  static String reqdocno = "reqdocno";
  static String reqdocseries = "reqdocseries";
  static String reqdocseriesno = 'reqdocseriesno';
  static String reqtransdate = "reqtransdate";
  static String reqdoctime = "reqdoctime";
  static String reqsystime = "reqsystime";
  static String documentno = "documentno";
  static String seresid = "seresid";
  static String seriesnum = "seriesnum";
  static String transactiondate = "transactiondate";
  static String transtime = "transtime";
  static String sysdatetime = 'sysdatetime';
  static String reqfromWhs = "reqfromWhs";
  static String reqtoWhs = "reqtoWhs";
  static String remarks = "remarks";
  static String totalitems = "totalitems";
  static String totalweight = "totalweight";
  static String totalqty = "totalqty";
  static String totalltr = "totalltr";
  static String isagainstorder = "isagainstorder";
  static String isagainststock = "isagainststock";
  static String docstatus = "docstatus";
  static String salesexec = "salesexec";
  static String createdateTime = "createdateTime";
  static String updatedDatetime = 'UpdatedDatetime';
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
}

class StockReqHDTDB {
  String? docentry;
  String? branch;
  String? cardCode;
  String? cardName;
  String? terminal;
  String? remarks;
  String? doctype;
  int? reqdocno;
  String? reqdocseries;
  int? reqdocseriesno;
  String? reqtransdate;
  String? reqdoctime;
  String? reqsystime;
  String? documentno;
  int? seresid;
  int? seriesnum;
  String? transactiondate;
  String? transtime;
  String? sysdatetime;
  String? reqfromWhs;
  String? reqtoWhs;
  int? totalitems;
  double? totalweight;
  double? totalltr;
  double? totalqty;
  String? isagainstorder;
  String? isagainststock;
  String? docstatus;
  String? salesexec;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? qStatus;

  StockReqHDTDB({
    required this.branch,
    required this.doctype,
    required this.cardCode,
    required this.cardName,
    required this.terminal,
    required this.remarks,
    required this.createdUserID,
    required this.createdateTime,
    required this.docentry,
    required this.docstatus,
    required this.documentno,
    required this.isagainstorder,
    required this.isagainststock,
    required this.lastupdateIp,
    required this.reqdocno,
    required this.reqdocseries,
    required this.reqdocseriesno,
    required this.reqdoctime,
    required this.reqfromWhs,
    required this.reqsystime,
    required this.reqtoWhs,
    required this.reqtransdate,
    required this.salesexec,
    required this.seresid,
    required this.seriesnum,
    required this.sysdatetime,
    required this.totalitems,
    required this.totalqty,
    required this.totalweight,
    required this.totalltr,
    required this.transactiondate,
    required this.transtime,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.sapDocentry,
    required this.sapDocNo,
    this.qStatus,
  });
  factory StockReqHDTDB.fromjson(Map<String, dynamic> resp) {
    return StockReqHDTDB(
        branch: resp['branch'],
        doctype: resp['doctype'],
        cardCode: resp['branch'],
        cardName: resp['doctype'],
        terminal: resp['terminal'],
        createdUserID: resp['createdUserID'],
        createdateTime: resp['createdateTime'],
        docentry: resp['docentry'].toString(),
        docstatus: resp['docstatus'],
        documentno: resp['documentno'],
        isagainstorder: resp['isagainstorder'],
        isagainststock: resp['isagainststock'],
        lastupdateIp: resp['lastupdateIp'],
        reqdocno: resp['reqdocno'],
        reqdocseries: resp['reqdocseries'].toString(),
        reqdocseriesno: resp['reqdocseriesno'],
        reqdoctime: resp['reqdoctime'],
        reqfromWhs: resp['reqfromWhs'],
        remarks: resp['remarks'],
        reqsystime: resp['reqsystime'],
        reqtoWhs: resp['reqtoWhs'],
        reqtransdate: resp['reqtransdate'],
        salesexec: resp['salesexec'],
        seresid: resp['seresid'],
        seriesnum: resp['seriesnum'],
        sysdatetime: resp['sysdatetime'],
        totalitems: resp['totalitems'],
        totalltr: double.parse(resp['totalltr'].toString()),
        totalqty: double.parse(resp['totalqty'].toString()),
        totalweight: double.parse(resp['totalweight'].toString()),
        transactiondate: resp['transactiondate'],
        transtime: resp['transtime'],
        updatedDatetime: resp['UpdatedDatetime'],
        updateduserid: resp['updateduserid'],
        sapDocNo: resp['sapDocNo'] == null
            ? null
            : int.parse(resp['sapDocNo'].toString()),
        sapDocentry: resp['sapDocentry'] == null
            ? null
            : int.parse(resp['sapDocentry'].toString()),
        qStatus: 'Y');
  }
  Map<String, Object?> toMap() => {
        StockReqHDT.branch: branch,
        StockReqHDT.doctype: doctype,
        StockReqHDT.cardCode: cardCode,
        StockReqHDT.cardName: cardName,
        StockReqHDT.terminal: terminal,
        StockReqHDT.createdUserID: createdUserID,
        StockReqHDT.createdateTime: createdateTime,
        StockReqHDT.docentry: docentry,
        StockReqHDT.docstatus: docstatus,
        StockReqHDT.documentno: documentno,
        StockReqHDT.isagainstorder: isagainstorder,
        StockReqHDT.isagainststock: isagainststock,
        StockReqHDT.lastupdateIp: lastupdateIp,
        StockReqHDT.reqdocno: reqdocno,
        StockReqHDT.remarks: remarks,
        StockReqHDT.reqdocseries: reqdocseries,
        StockReqHDT.reqdocseriesno: reqdocseriesno,
        StockReqHDT.reqdoctime: reqdoctime,
        StockReqHDT.reqfromWhs: reqfromWhs,
        StockReqHDT.reqsystime: reqsystime,
        StockReqHDT.reqtoWhs: reqtoWhs,
        StockReqHDT.reqtransdate: reqtransdate,
        StockReqHDT.salesexec: salesexec,
        StockReqHDT.seresid: seresid,
        StockReqHDT.seriesnum: seriesnum,
        StockReqHDT.sysdatetime: sysdatetime,
        StockReqHDT.totalitems: totalitems,
        StockReqHDT.totalltr: totalltr,
        StockReqHDT.totalweight: totalweight,
        StockReqHDT.totalqty: totalqty,
        StockReqHDT.transactiondate: transactiondate,
        StockReqHDT.transtime: transtime,
        StockReqHDT.updatedDatetime: updatedDatetime,
        StockReqHDT.updateduserid: updateduserid,
        StockReqHDT.sapDocentry: sapDocentry,
        StockReqHDT.sapDocNo: sapDocNo,
        StockReqHDT.qStatus: qStatus,
      };
}
