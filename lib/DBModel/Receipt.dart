const String tableReceiptHeader = "ReceiptHeader";

class ReceiptHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String branch = "branch";
  static String docstatus = "docstatus";
  static String customerSeriesNum = 'customerSeriesNum';
  static String docnumber = "documentno";
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

class ReceiptHeaderTDB {
  String? customerSeriesNum;
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
  ReceiptHeaderTDB({
    required this.customerSeriesNum,
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

  factory ReceiptHeaderTDB.fromjson(Map<String, dynamic> resp) {
    return ReceiptHeaderTDB(
      customerSeriesNum: resp['String customerSeriesNum'].toString(),
      docentry: resp['docentry'],
      doctype: resp['doctype'],
      docnumber: resp['documentno'],
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
        ReceiptHeaderT.customerSeriesNum: customerSeriesNum,
        ReceiptHeaderT.createdUserID: createdUserID,
        ReceiptHeaderT.createdateTime: createdateTime,
        ReceiptHeaderT.customer: customer,
        ReceiptHeaderT.docentry: docentry,
        ReceiptHeaderT.branch: branch,
        ReceiptHeaderT.doctype: doctype,
        ReceiptHeaderT.terminal: terminal,
        ReceiptHeaderT.docstatus: docstatus,
        ReceiptHeaderT.docnumber: docnumber,
        ReceiptHeaderT.lastupdateIp: lastupdateIp,
        ReceiptHeaderT.series: series,
        ReceiptHeaderT.remarks: remarks,
        ReceiptHeaderT.seriesnumber: seriesnumber,
        ReceiptHeaderT.sysdate: sysdate,
        ReceiptHeaderT.totalamount: totalamount,
        ReceiptHeaderT.transdocentry: transdocentry,
        ReceiptHeaderT.transdocnum: transdocnum,
        ReceiptHeaderT.transdate: transdate,
        ReceiptHeaderT.transtime: transtime,
        ReceiptHeaderT.updatedDatetime: updatedDatetime,
        ReceiptHeaderT.updateduserid: updateduserid,
        ReceiptHeaderT.sapDocentry: sapDocentry,
        ReceiptHeaderT.sapDocNo: sapDocNo,
        ReceiptHeaderT.qStatus: qStatus,
        ReceiptHeaderT.sapInvoicedocentry: sapInvoicedocentry,
        ReceiptHeaderT.sapInvoicedocnum: sapInvoicedocnum,
      };
}
