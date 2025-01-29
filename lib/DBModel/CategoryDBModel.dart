const String tableCategory = "Category";//Subcategory

class CategoryT {
  static String categoryname = "categoryname";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class CategoryTModelDB {
  String? categoryname;
  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  CategoryTModelDB(
      {required this.categoryname,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.updatedDatetime,
      required this.updateduserid});

  Map<String, Object?> toMap() => {
        CategoryT.categoryname:categoryname,
        CategoryT.createdUserID: createdUserID,
        CategoryT.createdateTime: createdateTime,
        CategoryT.lastupdateIp: lastupdateIp,
        CategoryT.updatedDatetime: updatedDatetime,
        CategoryT.updateduserid: updateduserid,
      };
}
