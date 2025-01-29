const String tableSubCategory = "SubCategory";//Subcategory

class SubCategoryT {
  static String subcategoryname = "subcategoryname";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class SubCategoryTModelDB {
  String? subcategoryname;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  SubCategoryTModelDB(
      {required this.subcategoryname,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid});

  Map<String, Object?> toMap() => {
        SubCategoryT.subcategoryname:subcategoryname,
        SubCategoryT.createdUserID: createdUserID,
        SubCategoryT.createdateTime: createdateTime,
        SubCategoryT.lastupdateIp: lastupdateIp,
        SubCategoryT.updatedDatetime: updatedDatetime,
        SubCategoryT.updateduserid: updateduserid,
      };
}
