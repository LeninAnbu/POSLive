const String tableCustomerMaster = "CustomerMaster";

class CustomerMasterT {
  static String customerCode = "customerCode";
  static String customername = "customername";
  static String premiumid = "premiumid";
  static String customertype = "customertype";
  static String taxno = "taxno";
  static String createdbybranch = "createdbybranch";
  static String balance = "balance";
  static String points = "points";
  static String snapdatetime = "snapdatetime";
  static String phoneno1 = "phoneno1";
  static String phoneno2 = "phoneno2";
  static String emalid = "emalid";
  static String createdateTime = "createdateTime";
  static String updatedDatetime = "updatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
  static String TaxCode = "TaxCode";

  // static String autoid = "autoid";
  // static String customerCode = "customercode";
  // static String customername = "customername";
  // static String premiumid = "premiumid";
  // static String customertype = "customertype";
  // static String taxno = "taxno";
  // static String taxCode = "taxCode";
  // static String createdbybranch = 'createdbybranch';
  // static String balance = "balance";
  // static String points = "points";
  // static String snapdatetime = "snapdatetime";
  // static String phoneno1 = "phoneno1";
  // static String phoneno2 = "phoneno2";
  // static String emalid = "emalid";
  // static String tinNo = 'tinNo';
  // static String vatregno = 'vatregno';
  // static String terminal = "terminal";
  // static String createdateTime = 'createdateTime';
  // static String updatedDatetime = "UpdatedDatetime";
  // static String createdUserID = "createdUserID";
  // static String updateduserid = "updateduserid";
  // static String lastupdateIp = "lastupdateIp";
}

class CustomerModelDB {
  String? autoid;
  String? vatregno;
  String? tinNo;
  String? customerCode;
  String? customername;
  String? premiumid;
  String? customertype;
  String? taxno;
  String? taxCode;
  String? createdbybranch;
  double balance;
  double? points;
  String? snapdatetime;
  String? phoneno1;
  String? phoneno2;
  String? emalid;
  String? terminal;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  CustomerModelDB(
      {required this.customerCode,
      required this.createdUserID,
      this.autoid,
      this.tinNo,
      required this.taxCode,
      this.vatregno,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.balance,
      required this.createdbybranch,
      this.terminal,
      required this.customername,
      required this.customertype,
      required this.emalid,
      required this.phoneno1,
      required this.phoneno2,
      required this.points,
      required this.premiumid,
      required this.snapdatetime,
      required this.taxno});
  factory CustomerModelDB.fromMap(Map<String, dynamic> item) => CustomerModelDB(
        customerCode: item['createdUserID'],
        createdUserID: item['createdUserID'],
        createdateTime: item['createdUserID'],
        lastupdateIp: item['createdUserID'],
        updatedDatetime: item['createdUserID'],
        updateduserid: item['createdUserID'],
        balance: item['createdUserID'],
        createdbybranch: item['createdUserID'],
        customername: item['createdUserID'],
        customertype: item['createdUserID'],
        emalid: item['createdUserID'],
        phoneno1: item['createdUserID'],
        phoneno2: item['createdUserID'],
        points: item['createdUserID'],
        premiumid: item['createdUserID'],
        snapdatetime: item['createdUserID'],
        taxno: item['createdUserID'],
        taxCode: item['createdUserID'],
        terminal: item['terminal'],
        autoid: item['autoid'],
        tinNo: item['tinNo'],
        vatregno: item['vatregno'],
      );

  Map<String, Object?> toMap() => {
        // CustomerMasterT.autoid: autoid,
        // CustomerMasterT.tinNo: tinNo,
        CustomerMasterT.TaxCode: taxCode,
        // CustomerMasterT.vatregno: vatregno,
        CustomerMasterT.customerCode: customerCode,
        CustomerMasterT.balance: balance,
        CustomerMasterT.createdUserID: createdUserID,
        CustomerMasterT.createdateTime: createdateTime,
        CustomerMasterT.createdbybranch: createdbybranch,
        CustomerMasterT.customername: customername,
        CustomerMasterT.customertype: customertype,
        CustomerMasterT.emalid: emalid,
        // CustomerMasterT.terminal: terminal,
        CustomerMasterT.lastupdateIp: lastupdateIp,
        CustomerMasterT.phoneno1: phoneno1,
        CustomerMasterT.phoneno2: phoneno2,
        CustomerMasterT.points: points,
        CustomerMasterT.premiumid: premiumid,
        CustomerMasterT.snapdatetime: snapdatetime,
        CustomerMasterT.taxno: taxno,
        CustomerMasterT.updatedDatetime: updatedDatetime,
        CustomerMasterT.updateduserid: updateduserid,
      };
}
