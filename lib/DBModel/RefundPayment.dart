// // ignore_for_file: non_constant_identifier_names

const String tableRefundPay = "RefundPay";

class RefundPayT {
  static String docentry = "docentry";
  static String lineId = "lineId";
  static String rcdocentry = "rcdocentry";
  static String branch = "branch";
  static String terminal = "terminal";
  static String rcnumber = "rcnumber";
  static String rcdatetime = "rcdatetime";
  static String rcmode = "rcmode";
  static String rcamount = "rcamount";
  static String reference = 'reference';
  static String chequeno = 'chequeno';
  static String chequedate = 'chequedate';
  static String remarks = 'remarks';
  static String amt = 'amt';
  static String Ref2 = "Ref2";
  static String Ref3 = "Ref3";
  static String Ref4 = "Ref4";
  static String Ref5 = 'Ref5';
  static String VouchCode = 'VouchCode';
  static String VouchCode2 = 'VouchCode2';
  static String cardterminal = 'cardterminal';
  static String cardApprno = 'cardApprno';
  // static String cardref = 'cardref';
  static String wallettype = 'wallettype';
  static String walletid = 'walletid';
  // static String walletref = 'walletref';
  static String transtype = 'transtype';
  // static String transref = 'transref';
  static String coupontype = 'coupontype';
  static String couponcode = 'couponcode';
  static String availablept = 'availablept';
  static String redeempoint = 'redeempoint';
  static String discounttype = 'discounttype';
  static String discountcode = 'discountcode';
  // static String creditref = 'creditref';
  static String recoverydate = 'recoverydate';
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class RefundPayTDB {
  String? lineId;
  String? docentry;
  String? rcdocentry;
  String? rcnumber;
  String? rcdatetime;
  String? rcmode;
  String? terminal;
  String? branch;
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
  // String? cardref;
  String? wallettype;
  String? walletid;
  // String? walletref;
  String? transtype;
  // String? transref;
  String? coupontype;
  String? couponcode;
  String? availablept;
  String? redeempoint;
  String? discounttype;
  String? discountcode;
  // String? creditref;
  String? recoverydate;
  String? Ref2;
  String? Ref3;
  String? Ref4;
  String? Ref5;
  String? VouchCode;
  String? VouchCode2;
  RefundPayTDB(
      {required this.createdUserID,
      required this.createdateTime,
      required this.docentry,
      required this.lineId,
      required this.lastupdateIp,
      required this.rcamount,
      required this.rcdatetime,
      required this.rcdocentry,
      required this.rcmode,
      required this.rcnumber,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.reference,
      this.amt,
      required this.branch,
      required this.terminal,
      required this.Ref2,
      required this.Ref3,
      required this.Ref4,
      required this.Ref5,
      required this.VouchCode,
      required this.VouchCode2,
      required this.availablept,
      required this.cardApprno,
      // required this.cardref,
      required this.cardterminal,
      required this.chequedate,
      required this.chequeno,
      required this.couponcode,
      required this.coupontype,
      // required this.creditref,
      required this.discountcode,
      required this.discounttype,
      required this.recoverydate,
      required this.redeempoint,
      required this.remarks,
      // required this.transref,
      required this.transtype,
      required this.walletid,
      // required this.walletref,
      required this.wallettype});
  factory RefundPayTDB.fromjson(Map<String, dynamic> resp) {
    return RefundPayTDB(
        createdUserID: resp['createdUserID'].toString(),
        createdateTime: resp['createdateTime'],
        docentry: resp['docentry'].toString(),
        lineId: resp['lineId'].toString(),
        lastupdateIp: resp['lastupdateIp'],
        rcamount: resp['rcamount'].toString(),
        rcdatetime: resp['rcdatetime'],
        rcdocentry: resp['rcdocentry'].toString(),
        rcmode: resp['rcmode'],
        rcnumber: resp['rcnumber'],
        updatedDatetime: resp['updatedDatetime'],
        updateduserid: resp['updateduserid'].toString(),
        reference: resp['reference'],
        branch: resp['branch'],
        terminal: resp['terminal'],
        Ref2: resp['Ref2'],
        Ref3: resp['Ref3'],
        Ref4: resp['Ref4'],
        Ref5: resp['Ref5'],
        VouchCode: resp['VouchCode'],
        VouchCode2: resp['VouchCode2'],
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
        redeempoint: resp['redeempoint'],
        remarks: resp['remarks'],
        transtype: resp['transtype'],
        walletid: resp['walletid'],
        wallettype: resp['wallettype']);
  }

  Map<String, Object?> toMap(int docentry) => {
        RefundPayT.createdUserID: createdUserID,
        RefundPayT.createdateTime: createdateTime,
        RefundPayT.docentry: docentry,
        RefundPayT.lineId: lineId,
        RefundPayT.lastupdateIp: lastupdateIp,
        RefundPayT.rcamount: rcamount,
        RefundPayT.rcdatetime: rcdatetime,
        RefundPayT.rcdocentry: rcdocentry,
        RefundPayT.rcmode: rcmode,
        RefundPayT.rcnumber: rcnumber,
        RefundPayT.updatedDatetime: updatedDatetime,
        RefundPayT.updateduserid: updateduserid,
        RefundPayT.amt: amt,
        RefundPayT.branch: branch,
        RefundPayT.terminal: terminal,
        RefundPayT.reference: reference,
        RefundPayT.availablept: availablept,
        RefundPayT.cardApprno: cardApprno,
        // RefundPayT.cardref: cardref,
        RefundPayT.cardterminal: cardterminal,
        RefundPayT.chequedate: chequedate,
        RefundPayT.chequeno: chequeno,
        RefundPayT.couponcode: couponcode,
        RefundPayT.coupontype: coupontype,
        // RefundPayT.creditref: creditref,
        RefundPayT.discountcode: discountcode,
        RefundPayT.discounttype: discounttype,
        RefundPayT.recoverydate: recoverydate,
        RefundPayT.redeempoint: redeempoint,
        RefundPayT.remarks: remarks,
        // RefundPayT.transref: transref,
        RefundPayT.transtype: transtype,
        RefundPayT.walletid: walletid,
        // RefundPayT.walletref: walletref,
        RefundPayT.Ref2: Ref2,
        RefundPayT.Ref3: Ref3,
        RefundPayT.Ref4: Ref4,
        RefundPayT.Ref5: Ref5,
        RefundPayT.VouchCode: VouchCode,
        RefundPayT.VouchCode2: VouchCode2,
        RefundPayT.wallettype: wallettype
      };
}





// const String tableRefundPay = "RefundPay";

// class RefundPayT {
//   static String docentry = "docentry";
//   static String rc_entry = "rc_entry";
//   static String ModeofPay = "ModeofPay";
//   static String Amount = "Amount";
//   static String TransRef = "TransRef";
  // static String Ref2 = "Ref2";
  // static String Ref3 = "Ref3";
  // static String Ref4 = "Ref4";
  // static String Ref5 = 'Ref5';
  // static String VouchCode = 'VouchCode';
  // static String VouchCode2 = 'VouchCode2';
//   static String RefAmt = 'RefAmt';
//   static String PointAmt = 'PointAmt';
//   static String ReedemAmt = 'ReedemAmt';
//   static String createdateTime = 'createdateTime';
//   static String updatedDatetime = "UpdatedDatetime";
//   static String createdUserID = "createdUserID";
//   static String updateduserid = "updateduserid";
//   static String lastupdateIp = "lastupdateIp";
// }

// class RefundPayTDB {
//   int? docentry;
//   String? rc_entry;
//   String ?ModeofPay;
//   String ?Amount;
//   String ?TransRef;
  // String ?Ref2;
  // String? Ref3 ;
  // String? Ref4;
  // String? Ref5;
  // String? VouchCode ;
  // String? VouchCode2 ;
//   String? RefAmt ;
//   String? PointAmt;
//   String? ReedemAmt ;
//   String? createdateTime ;
//   String? updatedDatetime ;
//   String? createdUserID ;
//   String? updateduserid;
//   String? lastupdateIp ;

//   RefundPayTDB({
//    required this.Amount,
//    required this.ModeofPay,
//    required this.PointAmt,
//    required this.ReedemAmt,
//    required this.Ref2,
//    required this.Ref3,
//    required this.Ref4,
//    required this.Ref5,
//    required this.RefAmt,
//    required this.TransRef,
  //  required this.VouchCode,
  //  required this.VouchCode2,
//    required this.createdUserID,
//    required this.createdateTime,
//    required this.docentry,
//    required this.lastupdateIp,
//    required this.rc_entry,
//    required this.updatedDatetime,
//    required this.updateduserid
//       });

//   Map<String, Object?> toMap() => {
//       RefundPayT.Amount:Amount,
//       RefundPayT.ModeofPay:ModeofPay,
//       RefundPayT.PointAmt:PointAmt,
//       RefundPayT.ReedemAmt:ReedemAmt,
      // RefundPayT.Ref2:Ref2,
      // RefundPayT.Ref3:Ref3,
      // RefundPayT.Ref4:Ref4,
      // RefundPayT.Ref5:Ref5,
//       RefundPayT.RefAmt:RefAmt,
//       RefundPayT.TransRef:TransRef,
      // RefundPayT.VouchCode:VouchCode,
      // RefundPayT.VouchCode2:VouchCode2,
//       RefundPayT.createdUserID:createdUserID,
//       RefundPayT.createdateTime:createdateTime,
//       RefundPayT.docentry:docentry,
//       RefundPayT.lastupdateIp:lastupdateIp,
//       RefundPayT.rc_entry:rc_entry,
//       RefundPayT.updatedDatetime:updatedDatetime,
//       RefundPayT.updateduserid:updateduserid
//       };
// }
