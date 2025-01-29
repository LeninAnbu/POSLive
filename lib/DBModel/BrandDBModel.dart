const String tableBrand = "Brand";

class BrandT {
  static String brandname = "brandname";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class BrandTModelDB {
  String? brandname;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  BrandTModelDB(
      {required this.brandname,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid});

  Map<String, Object?> toMap() => {
        BrandT.brandname:brandname,
        BrandT.createdUserID: createdUserID,
        BrandT.createdateTime: createdateTime,
        BrandT.lastupdateIp: lastupdateIp,
        BrandT.updatedDatetime: updatedDatetime,
        BrandT.updateduserid: updateduserid,
      };
}
