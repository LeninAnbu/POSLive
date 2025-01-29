const String tableSetUPPriceMaster = "PriceMasterSetUP";

class PriceMasterSetUPT {
  static String pricelistid = "pricelistid";
  static String pricelistname = "pricelistname";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class PriceMstSPTModelDB {
  String? pricelistid;
  String? pricelistname;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  PriceMstSPTModelDB({
      required this.pricelistid,
      required this.pricelistname,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid
      });

  Map<String, Object?> toMap() => {
        PriceMasterSetUPT.pricelistid:pricelistid,
        PriceMasterSetUPT.pricelistname:pricelistname,
        PriceMasterSetUPT.createdUserID: createdUserID,
        PriceMasterSetUPT.createdateTime: createdateTime,
        PriceMasterSetUPT.lastupdateIp: lastupdateIp,
        PriceMasterSetUPT.updatedDatetime: updatedDatetime,
        PriceMasterSetUPT.updateduserid: updateduserid,
      };
}
