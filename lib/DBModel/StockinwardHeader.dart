const String tableStockInHeaderDB = "StockInHeaderDB";

class StockInHeaderData {
  static String docentry = "docentry";
  static String documentno = "documentno";
  static String cardCode = "CardCode";
  static String cardName = "CardName";
  static String terminal = "terminal";
  static String branch = "branch";
  static String baseDocentry = "baseDocentry";
  static String reqdocno = "reqdocno";
  static String docseries = "docseries";
  static String docseriesno = 'docseriesno';
  static String transdate = "transdate";
  static String doctime = "doctime";
  static String reqfromWhs = "reqfromWhs";
  static String reqtoWhs = "reqtoWhs";
  static String systime = "systime";
  static String remarks = "remarks";
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

class StockInHeaderDataDB {
  String? docentry;
  String? documentno;
  String cardName;
  String cardCode;
  String? terminal;
  String? branch;
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
  String? remarks;

  String? salesexec;
  String? createdateTime;
  String? baseDocentry;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? sapStockReqdocentry;
  String? sapStockReqdocnum;
  String? qStatus;

  StockInHeaderDataDB({
    this.documentno,
    required this.branch,
    required this.terminal,
    required this.cardCode,
    required this.cardName,
    required this.createdUserID,
    required this.createdateTime,
    this.docentry,
    required this.docstatus,
    required this.baseDocentry,
    required this.lastupdateIp,
    required this.reqdocno,
    required this.docseries,
    required this.docseriesno,
    required this.doctime,
    required this.remarks,
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
    required this.sapDocNo,
    required this.sapDocentry,
    required this.qStatus,
  });

  factory StockInHeaderDataDB.fromjson(Map<String, dynamic> resp) {
    return StockInHeaderDataDB(
      documentno: resp['documentno'].toString(),
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
      remarks: resp['remarks'],
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
      sapDocentry: resp['sapDocentry'],
      sapDocNo: resp['sapDocNo'],
    );
  }

  Map<String, Object?> toMap() => {
        StockInHeaderData.documentno: documentno,
        StockInHeaderData.cardCode: cardCode,
        StockInHeaderData.cardName: cardName,
        StockInHeaderData.branch: branch,
        StockInHeaderData.terminal: terminal,
        StockInHeaderData.baseDocentry: baseDocentry,
        StockInHeaderData.createdUserID: createdUserID,
        StockInHeaderData.createdateTime: createdateTime,
        StockInHeaderData.docentry: docentry,
        StockInHeaderData.docstatus: docstatus,
        StockInHeaderData.lastupdateIp: lastupdateIp,
        StockInHeaderData.reqdocno: reqdocno,
        StockInHeaderData.docseries: docseries,
        StockInHeaderData.docseriesno: docseriesno,
        StockInHeaderData.doctime: doctime,
        StockInHeaderData.remarks: remarks,
        StockInHeaderData.reqfromWhs: reqfromWhs,
        StockInHeaderData.systime: systime,
        StockInHeaderData.reqtoWhs: reqtoWhs,
        StockInHeaderData.transdate: transdate,
        StockInHeaderData.salesexec: salesexec,
        StockInHeaderData.totalitems: totalitems,
        StockInHeaderData.totalltr: totalltr,
        StockInHeaderData.totalqty: totalqty,
        StockInHeaderData.updatedDatetime: updatedDatetime,
        StockInHeaderData.updateduserid: updateduserid,
        StockInHeaderData.sapStockReqdocentry: sapStockReqdocentry,
        StockInHeaderData.sapStockReqdocnum: sapStockReqdocnum,
        StockInHeaderData.qStatus: qStatus,
        StockInHeaderData.sapDocentry: sapDocentry,
        StockInHeaderData.sapDocNo: sapDocNo,
      };
}
