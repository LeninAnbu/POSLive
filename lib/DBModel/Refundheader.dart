const String tableRefundHeader = "RefundHeader";

class RefundHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String branch = "branch";
  static String docstatus = "docstatus";
  static String docnumber = "docnumber";
  static String terminal = "terminal";
  static String series = "series";
  static String seriesnumber = "seriesnumber";
  static String transdocentry = "transdocentry";
  static String transdocnum = "transdocnum";
  static String transdate = "transdate";
  static String transtime = "transtime";
  static String sysdate = "sysdate";
  static String customer = "customer";
  static String totalamount = 'totalamount';
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
  static String remarks = "remarks";

  static String sapInvoicedocentry = 'sapInvoicedocentry';
  static String sapInvoicedocnum = 'sapInvoicedocnum';
}

class RefundHeaderTDB {
  int? docentry;
  String? docstatus;
  String remarks;
  String? doctype;
  String? docnumber;
  String? branch;
  String? terminal;
  String? series;
  String? seriesnumber;
  String transdocentry;
  String transdocnum;
  String? transdate;
  String? transtime;
  String? sysdate;
  String? customer;
  String? totalamount;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  int? sapDocentry;
  int? sapDocNo;
  String? qStatus;
  String? sapInvoicedocentry;
  String? sapInvoicedocnum;
  RefundHeaderTDB({
    required this.createdUserID,
    required this.createdateTime,
    required this.customer,
    required this.branch,
    this.docentry,
    this.doctype,
    required this.transdocnum,
    required this.remarks,
    required this.docstatus,
    required this.terminal,
    required this.docnumber,
    required this.lastupdateIp,
    required this.series,
    required this.seriesnumber,
    required this.sysdate,
    required this.totalamount,
    required this.transdocentry,
    required this.transdate,
    required this.transtime,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.sapDocentry,
    required this.sapDocNo,
    this.qStatus,
    required this.sapInvoicedocentry,
    required this.sapInvoicedocnum,
  });

  factory RefundHeaderTDB.fromjson(Map<String, dynamic> resp) {
    return RefundHeaderTDB(
      docentry: resp['docentry'],
      doctype: resp['doctype'],
      docnumber: resp['docnumber'],
      branch: resp['branch'],
      createdUserID: resp['createdUserID'].toString(),
      createdateTime: resp['createdateTime'],
      customer: resp['customername'],
      terminal: resp['terminal'],
      remarks: resp['remarks'],
      docstatus: resp['docstatus'],
      totalamount: resp['totalamount'].toString(),
      lastupdateIp: resp['lastupdateIp'],
      transtime: resp['transtime'],
      updatedDatetime: resp['updatedDatetime'],
      updateduserid: resp['updateduserid'].toString(),
      series: resp['series'].toString(),
      seriesnumber: resp['seriesnumber'].toString(),
      sysdate: resp['sysdate'].toString(),
      transdate: resp['transdate'].toString(),
      transdocentry: resp['transdocentry'].toString(),
      transdocnum: resp['transdocnum'].toString(),
      sapDocNo: resp['sapDocNo'] == null
          ? null
          : int.parse(resp['sapDocNo'].toString()),
      sapDocentry: resp['sapDocentry'] == null
          ? null
          : int.parse(resp['sapDocentry'].toString()),
      qStatus: 'Y',
      sapInvoicedocentry: resp['sapInvoicedocentry'].toString(),
      sapInvoicedocnum: resp['sapInvoicedocnum'].toString(),
    );
  }

  Map<String, Object?> toMap() => {
        RefundHeaderT.createdUserID: createdUserID,
        RefundHeaderT.createdateTime: createdateTime,
        RefundHeaderT.customer: customer,
        RefundHeaderT.docentry: docentry,
        RefundHeaderT.branch: branch,
        RefundHeaderT.doctype: doctype,
        RefundHeaderT.terminal: terminal,
        RefundHeaderT.docstatus: docstatus,
        RefundHeaderT.docnumber: docnumber,
        RefundHeaderT.lastupdateIp: lastupdateIp,
        RefundHeaderT.series: series,
        RefundHeaderT.remarks: remarks,
        RefundHeaderT.seriesnumber: seriesnumber,
        RefundHeaderT.sysdate: sysdate,
        RefundHeaderT.totalamount: totalamount,
        RefundHeaderT.transdocentry: transdocentry,
        RefundHeaderT.transdocnum: transdocnum,
        RefundHeaderT.transdate: transdate,
        RefundHeaderT.transtime: transtime,
        RefundHeaderT.updatedDatetime: updatedDatetime,
        RefundHeaderT.updateduserid: updateduserid,
        RefundHeaderT.sapDocentry: sapDocentry,
        RefundHeaderT.sapDocNo: sapDocNo,
        RefundHeaderT.qStatus: qStatus,
        RefundHeaderT.sapInvoicedocentry: sapInvoicedocentry,
        RefundHeaderT.sapInvoicedocnum: sapInvoicedocnum,
      };
}
