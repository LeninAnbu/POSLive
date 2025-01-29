const String tableSalesReturnPay = "SalesReturnPay";

class SalesReturnPayT {
  static String docentry = "docentry";
  static String lineId = "lineId";
  
  static String rcdocentry = "rcdocentry";
  static String rcnumber = "rcnumber";
  static String rcdatetime = "rcdatetime";
  static String rcmode = "rcmode";
  static String rcamount = "rcamount";
  static String branch = "branch";
  static String terminal = "terminal";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String reference = 'reference';
  static String chequeno = 'chequeno';
  static String chequedate = 'chequedate';
  static String remarks = 'remarks';
  static String amt = 'amt';
  static String coupontype = 'coupontype';
  static String couponcode = 'couponcode';
}

class SalesReturnPayTDB {
  String? docentry;
  String lineId;
  String? rcdocentry;
  String? rcnumber;
  String? rcdatetime;
  String? rcmode;
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
  String? coupontype;
  String? couponcode;
  String? branch;
  String? terminal;
  String? reference;

  SalesReturnPayTDB({
    required this.createdUserID,
    required this.createdateTime,
    required this.docentry,
   required this. lineId,
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
    required this.chequedate,
    required this.chequeno,
    required this.couponcode,
    required this.coupontype,
    required this.remarks,
  });
factory SalesReturnPayTDB.fromjson(Map<String , dynamic> resp){
    return SalesReturnPayTDB(
      amt:resp['amt'],
      createdUserID: resp['createdUserID'].toString(), createdateTime: resp['createdateTime'],
      docentry: resp['docentry'].toString(),
      lastupdateIp: resp['lastupdateIp'].toString(), rcamount: resp['rcamount'].toString(),rcdatetime: resp['rcdatetime'],
      rcdocentry: resp['rcdocentry'].toString(), rcmode: resp['rcmode'],rcnumber: resp['rcnumber'],
      updatedDatetime: resp['updatedDatetime'], 
      updateduserid: resp['updateduserid'].toString(),
      reference: resp['reference'], chequedate: resp['chequedate'],chequeno: resp['chequeno'], 
      couponcode: resp['couponcode'], coupontype: resp['coupontype'], 
      branch: resp['branch'], terminal: resp['terminal'], lineId: resp['lineId'].toString(), remarks:resp['remarks']
       );}
  Map<String, Object?> toMap(int? docEntry) => {
        SalesReturnPayT.createdUserID: createdUserID,
        SalesReturnPayT.createdateTime: createdateTime,
        SalesReturnPayT.docentry: docEntry,
        SalesReturnPayT.lineId: lineId,

        SalesReturnPayT.lastupdateIp: lastupdateIp,
        SalesReturnPayT.rcamount: rcamount,
        SalesReturnPayT.rcdatetime: rcdatetime,
        SalesReturnPayT.rcdocentry: rcdocentry,
        SalesReturnPayT.rcmode: rcmode,
        SalesReturnPayT.rcnumber: rcnumber,
        SalesReturnPayT.updatedDatetime: updatedDatetime,
        SalesReturnPayT.updateduserid: updateduserid,
        SalesReturnPayT.amt: amt,
        SalesReturnPayT.reference: reference,
        SalesReturnPayT.branch: branch,
        SalesReturnPayT.terminal: terminal,
        SalesReturnPayT.chequedate: chequedate,
        SalesReturnPayT.chequeno: chequeno,
        SalesReturnPayT.couponcode: couponcode,
        SalesReturnPayT.coupontype: coupontype,
        SalesReturnPayT.remarks: remarks,
      };
}
