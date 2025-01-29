const String tableSalesOrderPay = "SalesOrderPay";

class SalesOrderPayT {
  static String docentry = "docentry";
  static String lineid = "lineid";
  static String rcdocentry = "rcdocentry";
  static String rcnumber = "rcnumber";
  static String rcdatetime = "rcdatetime";
  static String rcmode = "rcmode";
  static String rcamount = "rcamount";
  static String reference = 'reference';
  static String chequeno = 'chequeno';
  static String chequedate = 'chequedate';
  static String remarks = 'remarks';
  static String amt = 'amt';
  static String cardterminal = 'cardterminal';
  static String cardApprno = 'cardApprno';
  static String cardref = 'cardref';
  static String wallettype = 'wallettype';
  static String walletid = 'walletid';
  static String walletref = 'walletref';
  static String transtype = 'transtype';
  static String transref = 'transref';
  static String coupontype = 'coupontype';
  static String couponcode = 'couponcode';
  static String availablept = 'availablept';
  static String redeempoint = 'redeempoint';
  static String discounttype = 'discounttype';
  static String discountcode = 'discountcode';
  static String creditref = 'creditref';
  static String recoverydate = 'recoverydate';
  static String branch = "branch";
  static String terminal = "terminal";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class SalesOrderPayTDB {
  String? docentry;
  String? lineid;
  String? rcdocentry;
  String? rcnumber;
  String? rcdatetime;
  String? rcmode;
  String? reference;
  String? rcamount;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? chequeno;
  String? chequedate;
  String? remarks;
  String? amt;
  String? cardterminal;
  String? cardApprno;
  String? cardref;
  String? wallettype;
  String? walletid;
  String? walletref;
  String? transtype;
  String? transref;
  String? coupontype;
  String? couponcode;
  String? availablept;
  String? redeempoint;
  String? discounttype;
  String? discountcode;
  String? creditref;
  String? recoverydate;
  String? terminal;
  String? branch;
  SalesOrderPayTDB({
    required this.createdUserID,
    required this.createdateTime,
    required this.docentry,
    required this.lastupdateIp,
    required this.rcamount,
    required this.rcdatetime,
    required this.rcdocentry,
    required this.rcmode,
    required this.rcnumber,
    required this.lineid,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.reference,
    this.amt,
    required this.availablept,
    required this.cardApprno,
    this.cardref,
    required this.cardterminal,
    required this.chequedate,
    required this.chequeno,
    required this.couponcode,
    required this.coupontype,
    this.creditref,
    required this.discountcode,
    required this.discounttype,
    required this.recoverydate,
    required this.redeempoint,
    required this.remarks,
    this.transref,
    required this.transtype,
    required this.walletid,
    this.walletref,
    this.wallettype,
    required this.branch,
    required this.terminal,
  });
  factory SalesOrderPayTDB.fromjson(Map<String, dynamic> resp) {
    return SalesOrderPayTDB(
        amt: resp['amt'],
        creditref: resp['creditref'],
        transref: resp['transref'],
        walletref: resp['walletref'],
        wallettype: resp['wallettype'],
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'],
        docentry: resp['docentry'].toString(),
        lastupdateIp: resp['lastupdateIp'].toString(),
        rcamount: resp['rcamount'].toString(),
        rcdatetime: resp['rcdatetime'],
        rcdocentry: resp['rcdocentry'].toString(),
        rcmode: resp['rcmode'],
        rcnumber: resp['rcnumber'],
        lineid: resp['lineid'].toString(),
        updatedDatetime: resp['updatedDatetime'],
        updateduserid: resp['updateduserid'].toString(),
        reference: resp['reference'],
        availablept: resp['availablept'],
        cardApprno: resp['cardApprno'],
        cardterminal: resp['cardterminal'],
        chequedate: resp['chequedate'],
        chequeno: resp['chequeno'],
        couponcode: resp['couponcode'],
        coupontype: resp['coupontype'],
        discountcode: resp['discountcode'],
        discounttype: resp['discounttype'],
        recoverydate: resp['recoverydate'],
        redeempoint: resp['redeempoint'].toString(),
        remarks: resp['remarks'],
        transtype: resp['transtype'],
        walletid: resp['walletid'],
        branch: resp['branch'],
        terminal: resp['terminal']);
  }

  Map<String, Object?> toMap(int? docEntry) => {
        SalesOrderPayT.createdUserID: createdUserID,
        SalesOrderPayT.createdateTime: createdateTime,
        SalesOrderPayT.docentry: docEntry,
        SalesOrderPayT.lineid: lineid,
        SalesOrderPayT.lastupdateIp: lastupdateIp,
        SalesOrderPayT.rcamount: rcamount,
        SalesOrderPayT.rcdatetime: rcdatetime,
        SalesOrderPayT.rcdocentry: rcdocentry,
        SalesOrderPayT.rcmode: rcmode,
        SalesOrderPayT.rcnumber: rcnumber,
        SalesOrderPayT.updatedDatetime: updatedDatetime,
        SalesOrderPayT.updateduserid: updateduserid,
        SalesOrderPayT.amt: amt,
        SalesOrderPayT.reference: reference,
        SalesOrderPayT.availablept: availablept,
        SalesOrderPayT.cardApprno: cardApprno,
        SalesOrderPayT.cardref: cardref,
        SalesOrderPayT.cardterminal: cardterminal,
        SalesOrderPayT.chequedate: chequedate,
        SalesOrderPayT.chequeno: chequeno,
        SalesOrderPayT.couponcode: couponcode,
        SalesOrderPayT.coupontype: coupontype,
        SalesOrderPayT.creditref: creditref,
        SalesOrderPayT.discountcode: discountcode,
        SalesOrderPayT.discounttype: discounttype,
        SalesOrderPayT.recoverydate: recoverydate,
        SalesOrderPayT.redeempoint: redeempoint,
        SalesOrderPayT.remarks: remarks,
        SalesOrderPayT.transref: transref,
        SalesOrderPayT.transtype: transtype,
        SalesOrderPayT.walletid: walletid,
        SalesOrderPayT.walletref: walletref,
        SalesOrderPayT.wallettype: wallettype,
        SalesOrderPayT.branch: branch,
        SalesOrderPayT.terminal: terminal,
      };
}
