// ignore_for_file: unused_local_variable

const String tableDepositLine = "DepositLine";

class DepositLineT {
  static String docentry = "docentry";
  static String basedoctype = "basedoctype";
  static String baselineid = "baselineid";
  static String basedocentry = "basedocentry";
  static String linenumber = "linenumber";
  static String transactionRefno = "transactionRefno";
  static String instrumentno = "instrumentno";
  static String paymodetype = "paymodetype";
  static String rcDocentry  = "RcDocentry";
  static String rcDocnum    = "RcDocnum";
  static String payentry = "payentry";
  static String paylineno = "paylineno";
  static String payamount = "payamount";
  static String ref1 = "ref1";
  static String ref2 = "ref2";
  static String ref3 = "ref3";
  static String paytransdate = "paytransdate";
  static String commissionamount = "commissionamount";
  static String nettosettle = "nettosettle";
  static String createdatetime = "createdatetime";
  static String updatedDatetime = "updatedDatetime";
  static String createduserid = "createduserid";
  static String updateduserid = "updateduserid";
  static String lastupdateip = "lastupdateip";
  static String terminal = "terminal";
  static String branch = "branch";
  static String jurnelRemarks = 'jurnelRemarks';
  static String transactionID = 'transactionID';
}

class DepositLineTDB {
  String rcDocentry ; 
String rcDocnum    ;
  String? baselineid;
  String? basedocentry;
  String? basedoctype;
  String? terminal;
  String? branch;
  String? docentry;
  String? linenumber;
  String? transactionRefno;
  String? instrumentno;
  String? paymodetype;
  String? payentry;
  String? paylineno;
  String? payamount;
  String? ref1;
  String? ref2;
  String? ref3;
  String? paytransdate;
  String? commissionamount;
  String? nettosettle;
  String? createdatetime;
  String? updatedDatetime;
  String? createduserid;
  String? updateduserid;
  String? lastupdateip;
  String? jurnelRemarks;
  String? transactionID;
  DepositLineTDB(
      {required this.basedoctype,
      required this.basedocentry,
      required this.baselineid,
      this.docentry,
     required this.rcDocentry,
     required this.rcDocnum,
      required this.linenumber,
      required this.transactionRefno,
      required this.instrumentno,
      required this.paymodetype,
      required this.payentry,
      required this.paylineno,
      required this.payamount,
      required this.ref1,
      required this.ref2,
      required this.ref3,
      required this.paytransdate,
      required this.commissionamount,
      required this.nettosettle,
      required this.createdatetime,
      required this.updatedDatetime,
      required this.createduserid,
      required this.updateduserid,
      required this.lastupdateip,
      required this.branch,
      required this.jurnelRemarks,
      required this.transactionID,
      required this.terminal});
  factory DepositLineTDB.fromjson(Map<String, dynamic> resp) {
    return DepositLineTDB(
      docentry: resp['docentry'].toString(),
      basedoctype: resp['basedoctype'],
      basedocentry: resp['basedocentry'].toString(),
      baselineid: resp['baselineid'],
      linenumber: resp['linenumber'],
      transactionRefno: resp['transactionRefno'],
      instrumentno: resp['instrumentno'],
      paymodetype: resp['paymodetype'],
      payentry: resp['payentry'],
      paylineno: resp['paylineno'],
      payamount: resp['payamount'].toString(),
      ref1: resp['ref1'],
      ref2: resp['ref2'],
      ref3: resp['ref3'],
      paytransdate: resp['paytransdate'],
      commissionamount: resp['commissionamount'].toString(),
      nettosettle: resp['nettosettle'],
      createdatetime: resp['createdatetime'],
      updatedDatetime: resp['updatedDatetime'],
      createduserid: resp['createduserid'].toString(),
      updateduserid: resp['updateduserid'].toString(),
      lastupdateip: resp['lastupdateip'],
      branch: resp['branch'],
      terminal: resp['terminal'],
      jurnelRemarks: resp['jurnelRemarks'],
      transactionID: resp['transactionID'], rcDocentry:resp['RcDocentry'], rcDocnum: resp['RcDocnum'],
    );
  }
  Map<String, Object?> toMap(int docentry) => {
    DepositLineT.rcDocentry:rcDocentry,
    DepositLineT.rcDocnum:rcDocnum,
        DepositLineT.basedocentry: basedocentry,
        DepositLineT.transactionID: transactionID,
        DepositLineT.jurnelRemarks: jurnelRemarks,
        DepositLineT.basedoctype: basedoctype,
        DepositLineT.baselineid: baselineid,
        DepositLineT.docentry: docentry,
        DepositLineT.linenumber: linenumber,
        DepositLineT.transactionRefno: transactionRefno,
        DepositLineT.instrumentno: instrumentno,
        DepositLineT.paymodetype: paymodetype,
        DepositLineT.payentry: payentry,
        DepositLineT.paylineno: paylineno,
        DepositLineT.payamount: payamount,
        DepositLineT.ref1: ref1,
        DepositLineT.ref2: ref2,
        DepositLineT.ref3: ref3,
        DepositLineT.paytransdate: paytransdate,
        DepositLineT.commissionamount: commissionamount,
        DepositLineT.nettosettle: nettosettle,
        DepositLineT.createdatetime: createdatetime,
        DepositLineT.updatedDatetime: updatedDatetime,
        DepositLineT.createduserid: createduserid,
        DepositLineT.updateduserid: updateduserid,
        DepositLineT.lastupdateip: lastupdateip,
        DepositLineT.branch: branch,
        DepositLineT.terminal: terminal
      };
}
