const String tableDepositHeader = "tableDepositHeader";

class DepositHeaderT {
  static String docentry = "docentry";
  static String doctype = "doctype";
  static String terminal = "terminal";
  static String docdate = "docdate";
  static String docnumber = "documentno";
  static String series = "series";
  static String seriesnumber = "seriesnumber";
  static String transdate = "transdate";
  static String transtime = "transtime";
  static String sysdatetime = "sysdatetime";
  static String typedeposit = "typedeposit";
  static String fromaccountcode = "fromaccountcode";
  static String toaccountcode = "toaccountcode";
  static String amountsettled = "amountsettled";
  static String remarks = "remarks";
  static String createdatetime = "createdateTime";
  static String updatedDatetime = "updatedDatetime";
  static String createduserid = "createduserid";
  static String updateduserid = "updateduserid";
  static String lastupdateip = "lastupdateip";
  static String branch = "branch";
  static String sapDocentry = "sapDocentry";
  static String sapDocNo = "sapDocNo";
  static String qStatus = "qStatus";
}

class DepositHeaderTDB {
  int? docentry;
  String? terminal;
  String? docdate;
  String? doctype;
  int? sapDocentry;
  int? sapDocNo;
  String? qStatus;
  String? docnumber;
  String? series;
  String? seriesnumber;
  String? transdate;
  String? transtime;
  String? sysdatetime;
  String? typedeposit;
  String? fromaccountcode;
  String? toaccountcode;
  String? amountsettled;
  String? remarks;
  String? createdatetime;
  String? updatedDatetime;
  String? createduserid;
  String? updateduserid;
  String? lastupdateip;
  String? branch;
  DepositHeaderTDB(
      {this.docentry,
      required this.doctype,
      required this.terminal,
      required this.docdate,
      required this.docnumber,
      required this.series,
      required this.seriesnumber,
      required this.transdate,
      required this.transtime,
      required this.sysdatetime,
      required this.typedeposit,
      required this.fromaccountcode,
      required this.toaccountcode,
      required this.amountsettled,
      required this.remarks,
      required this.createdatetime,
      required this.updatedDatetime,
      required this.createduserid,
      required this.updateduserid,
      required this.lastupdateip,
      required this.sapDocentry,
      required this.sapDocNo,
      this.qStatus,
      required this.branch});
  factory DepositHeaderTDB.fromjson(Map<String, dynamic> resp) {
    return DepositHeaderTDB(
        docentry: resp['docentry'],
        doctype: resp['doctype'],
        docnumber: resp['documentno'],
        branch: resp['branch'],
        createduserid: resp['createduserid'].toString(),
        createdatetime: resp['createdateTime'],
        terminal: resp['terminal'],
        lastupdateip: resp['lastupdateip'],
        remarks: resp['remarks'],
        sysdatetime: resp['sysdatetime'],
        transtime: resp['transtime'],
        updatedDatetime: resp['updatedDatetime'],
        updateduserid: resp['updateduserid'].toString(),
        amountsettled: resp['amountsettled'].toString(),
        docdate: resp['docdate'].toString(),
        fromaccountcode: resp['fromaccountcode'].toString(),
        series: resp['series'].toString(),
        seriesnumber: resp['seriesnumber'].toString(),
        toaccountcode: resp['toaccountcode'].toString(),
        transdate: resp['transdate'].toString(),
        typedeposit: resp['typedeposit'].toString(),
        sapDocNo: resp['sapDocNo'] == null
            ? null
            : int.parse(resp['sapDocNo'].toString()),
        sapDocentry: resp['sapDocentry'] == null
            ? null
            : int.parse(resp['sapDocentry'].toString()),
        qStatus: 'Y');
  }
  Map<String, Object?> toMap() => {
        DepositHeaderT.docentry: docentry,
        DepositHeaderT.terminal: terminal,
        DepositHeaderT.doctype: doctype,
        DepositHeaderT.docdate: docdate,
        DepositHeaderT.docnumber: docnumber,
        DepositHeaderT.series: series,
        DepositHeaderT.seriesnumber: seriesnumber,
        DepositHeaderT.transdate: transdate,
        DepositHeaderT.transtime: transtime,
        DepositHeaderT.sysdatetime: sysdatetime,
        DepositHeaderT.typedeposit: typedeposit,
        DepositHeaderT.fromaccountcode: fromaccountcode,
        DepositHeaderT.toaccountcode: toaccountcode,
        DepositHeaderT.amountsettled: amountsettled,
        DepositHeaderT.remarks: remarks,
        DepositHeaderT.createdatetime: createdatetime,
        DepositHeaderT.updatedDatetime: updatedDatetime,
        DepositHeaderT.createduserid: createduserid,
        DepositHeaderT.updateduserid: updateduserid,
        DepositHeaderT.lastupdateip: lastupdateip,
        DepositHeaderT.branch: branch
      };
}
