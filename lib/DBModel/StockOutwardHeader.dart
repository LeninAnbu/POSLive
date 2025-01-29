const String tableStockOutHeaderDataDB = "StockOutHeaderDataDB";

class StockOutHeaderData {
  static String terminal = "terminal";
  static String docentry = "docentry";
  static String documentno = "documentno";
  static String cardCode = "CardCode";
  static String cardName = "CardName";
  static String baseDocentry = "baseDocentry";
  static String branch = "branch";
  static String reqdocno = "reqdocno";
  static String docseries = "docseries";
  static String docseriesno = 'docseriesno';
  static String transdate = "transdate";
  static String doctime = "doctime";
  static String remarks = "remarks";
  static String reqfromWhs = "reqfromWhs";
  static String reqtoWhs = "reqtoWhs";
  static String systime = "systime";
  static String totalitems = "totalitems";
  static String totalweight = "totalweight";
  static String totalqty = "totalqty";
  static String totalltr = "totalltr";
  static String docstatus = "docstatus";
  static String salesexec = "salesexec";
  static String createdateTime = "createdateTime";
  static String updatedDatetime = 'UpdatedDatetime';
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapStockReqdocentry = 'sapStockReqdocentry';
  static String sapStockReqdocnum = 'sapStockReqdocnum';
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
}

class StockOutHeaderDataDB {
  String? terminal;
  String? docentry;
  String? documentno;
  String cardCode;
  String cardName;
  String? baseDocentry;
  String? branch;
  String? remarks;
  String? reqdocno;
  String? docseries;
  int? docseriesno;
  String? transdate;
  String? doctime;
  String? systime;
  String? reqfromWhs;
  String? reqtoWhs;
  int? totalitems;
  double? totalqty;
  double? totalltr;
  String? docstatus;
  String? salesexec;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? sapStockReqdocentry;
  String? sapStockReqdocnum;
  String? qStatus;

  StockOutHeaderDataDB({
    this.documentno,
    required this.branch,
    required this.createdUserID,
    required this.createdateTime,
    required this.baseDocentry,
    required this.terminal,
    required this.remarks,
    required this.cardCode,
    required this.cardName,
    this.docentry,
    required this.docstatus,
    required this.lastupdateIp,
    required this.reqdocno,
    required this.docseries,
    required this.docseriesno,
    required this.doctime,
    required this.reqfromWhs,
    required this.systime,
    required this.reqtoWhs,
    required this.transdate,
    required this.salesexec,
    required this.totalitems,
    required this.totalltr,
    required this.totalqty,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.sapStockReqdocentry,
    required this.sapStockReqdocnum,
    required this.qStatus,
    required this.sapDocNo,
    required this.sapDocentry,
  });
  factory StockOutHeaderDataDB.fromjson(Map<String, dynamic> resp) {
    return StockOutHeaderDataDB(
      docentry: resp['docentry'].toString(),
      branch: resp['branch'],
      cardCode: resp['docentry'].toString(),
      cardName: resp['branch'],
      createdUserID: int.parse(resp['createdUserID']),
      createdateTime: resp['createdateTime'],
      baseDocentry: resp['baseDocentry'],
      terminal: resp['terminal'],
      docstatus: resp['docstatus'],
      lastupdateIp: resp['lastupdateIp'],
      reqdocno: resp['reqdocno'],
      docseries: resp['docseries'],
      docseriesno: resp['docseriesno'],
      doctime: resp['doctime'],
      reqfromWhs: resp['reqfromWhs'],
      systime: resp['systime'],
      reqtoWhs: resp['reqtoWhs'],
      transdate: resp['transdate'],
      salesexec: resp['salesexec'],
      totalitems: resp['totalitems'],
      totalltr: double.parse(resp['totalltr'].toString()),
      totalqty: double.parse(resp['totalqty'].toString()),
      updatedDatetime: resp['UpdatedDatetime'],
      updateduserid: int.parse(resp['updateduserid'].toString()),
      sapStockReqdocentry: resp['sapStockReqdocentry'].toString(),
      sapStockReqdocnum: resp['sapStockReqdocnum'].toString(),
      qStatus: resp['qStatus'],
      remarks: resp['remarks'],
      sapDocentry: resp['sapDocentry'],
      sapDocNo: resp['sapDocNo'],
      documentno: resp['documentno'].toString(),
    );
  }
  Map<String, Object?> toMap() => {
        StockOutHeaderData.documentno: documentno,
        StockOutHeaderData.branch: branch,
        StockOutHeaderData.cardCode: cardCode,
        StockOutHeaderData.cardName: cardName,
        StockOutHeaderData.terminal: terminal,
        StockOutHeaderData.createdUserID: createdUserID,
        StockOutHeaderData.createdateTime: createdateTime,
        StockOutHeaderData.baseDocentry: baseDocentry,
        StockOutHeaderData.docentry: docentry,
        StockOutHeaderData.docstatus: docstatus,
        StockOutHeaderData.lastupdateIp: lastupdateIp,
        StockOutHeaderData.reqdocno: reqdocno,
        StockOutHeaderData.docseries: docseries,
        StockOutHeaderData.docseriesno: docseriesno,
        StockOutHeaderData.doctime: doctime,
        StockOutHeaderData.reqfromWhs: reqfromWhs,
        StockOutHeaderData.systime: systime,
        StockOutHeaderData.remarks: remarks,
        StockOutHeaderData.reqtoWhs: reqtoWhs,
        StockOutHeaderData.transdate: transdate,
        StockOutHeaderData.salesexec: salesexec,
        StockOutHeaderData.totalitems: totalitems,
        StockOutHeaderData.totalltr: totalltr,
        StockOutHeaderData.totalqty: totalqty,
        StockOutHeaderData.updatedDatetime: updatedDatetime,
        StockOutHeaderData.updateduserid: updateduserid,
        StockOutHeaderData.sapStockReqdocentry: sapStockReqdocentry,
        StockOutHeaderData.sapStockReqdocnum: sapStockReqdocnum,
        StockOutHeaderData.qStatus: qStatus,
        StockOutHeaderData.sapDocentry: sapDocentry,
        StockOutHeaderData.sapDocNo: sapDocNo,
      };
}
