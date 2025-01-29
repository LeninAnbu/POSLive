const String tableHSNMaster = "HSNMaster";

class HSNMasterT {
  static String hsncode = "hsncode";
  static String taxrate = "taxrate";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class HSNMasterTModelDB {
  String? hsncode;
  double? taxrate;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  HSNMasterTModelDB(
      {required this.hsncode,
      required this.taxrate,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid});

  Map<String, Object?> toMap() => {
        HSNMasterT.hsncode :hsncode,
        HSNMasterT.taxrate:taxrate,
        HSNMasterT.createdUserID: createdUserID,
        HSNMasterT.createdateTime: createdateTime,
        HSNMasterT.lastupdateIp: lastupdateIp,
        HSNMasterT.updatedDatetime: updatedDatetime,
        HSNMasterT.updateduserid: updateduserid,
      };
}
