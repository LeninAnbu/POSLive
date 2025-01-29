const String tableCustomerTrans = "CustomerTrans ";

class CustomerTransT {
  static String customercode = "customercode";
  static String value = "value";
  static String currencycode = "currencycode";
  static String branch = "branch";
  static String transtype = "transtype";
  static String tranentry = "tranentry";
  static String tranno = "tranno";
  static String transdatetime = "transdatetime";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class CustomerTransTModelDB {
  String? customercode;
  String? value;
  String? currencycode;
  String? branch;
  String? transtype;
  String? tranentry;
  String? tranno;
  String? transdatetime;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;
  String? transentry;

  CustomerTransTModelDB({
      required this.branch,
      required this.createdUserID,
      required this.createdateTime,
      required this.currencycode,
      required this.customercode,
      required this.lastupdateIp,
      required this.tranentry,
      required this.tranno,
      required this.transdatetime,
      required this.transentry,
      required this.transtype,
      required this.updatedDatetime,
      required this.updateduserid,
      required this.value
      });

  Map<String, Object?> toMap() => {
        CustomerTransT.branch :branch,
        CustomerTransT.currencycode:currencycode,
        CustomerTransT.customercode:customercode,
        CustomerTransT.tranentry:tranentry,
        CustomerTransT.tranno:tranno,
        CustomerTransT.transdatetime:transdatetime,
        CustomerTransT.transtype:transtype,
        CustomerTransT.value:value,
        CustomerTransT.createdUserID: createdUserID,
        CustomerTransT.createdateTime: createdateTime,
        CustomerTransT.lastupdateIp: lastupdateIp,
        CustomerTransT.updatedDatetime: updatedDatetime,
        CustomerTransT.updateduserid: updateduserid,
      };
}
