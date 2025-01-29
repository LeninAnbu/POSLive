const String tableState = "State";

class StateT {
  static String stateCode = "stateCode";
  static String countrycode = "countrycode";
  static String statename = "statename";
  static String taxstatecode = "taxstatecode";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class StateModelDB {
  String? stateCode;
  String? countrycode;
  String? statename;
  String? taxstatecode;

  String? createdateTime;
  String? updatedDatetime;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  StateModelDB(
      {required this.countrycode,
      required this.createdUserID,
      required this.createdateTime,
      required this.lastupdateIp,
      required this.stateCode,
      required this.statename,
      required this.taxstatecode,
      required this.updatedDatetime,
      required this.updateduserid});

  Map<String, Object?> toMap() => {
        StateT.countrycode: countrycode,
        StateT.createdUserID: createdUserID,
        StateT.createdateTime: createdateTime,
        StateT.lastupdateIp: lastupdateIp,
        StateT.stateCode: stateCode,
        StateT.statename: statename,
        StateT.taxstatecode: taxstatecode,
        StateT.updatedDatetime: updatedDatetime,
        StateT.updateduserid: updateduserid,
      };
}
