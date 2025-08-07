const String tableUsers = "Users";

class UsersT {
  static String autoId = "autoId";
  static String usercode = "usercode";
  static String userName = "userName";
  static String password = "password";
  static String lockpin = "lockpin";
  static String branch = 'branch';
  static String terminal = "terminal";
  static String userstatus = "userstatus";
  static String usertype = "usertype";
  static String licensekey = "licensekey";
  static String lastpasswordchanged = "lastpasswordchanged";
  static String createdateTime = 'createdateTime';
  static String updatedDatetime = "UpdatedDatetime";
  static String createdUserID = "createdUserID";
  static String updateduserid = "updateduserid";
  static String lastupdateIp = "lastupdateIp";
}

class UserModelDB {
  int? autoId;
  String? usercode;
  String? userName;
  String? password;
  String? lockpin;
  String? branch;
  String? terminal;
  String? userstatus;
  String? usertype;
  String? licensekey;
  String? lastpasswordchanged;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  UserModelDB({
    this.autoId,
    required this.usercode,
    required this.userName,
    required this.branch,
    required this.terminal,
    required this.createdUserID,
    required this.createdateTime,
    required this.lastpasswordchanged,
    required this.lastupdateIp,
    required this.licensekey,
    required this.lockpin,
    required this.password,
    required this.updatedDatetime,
    required this.updateduserid,
    required this.userstatus,
    required this.usertype,
  });

  factory UserModelDB.fromMap(Map<String, dynamic> item) => UserModelDB(
      autoId: item[''],
      usercode: item[''],
      userName: item[''],
      branch: item[''],
      terminal: item[''],
      createdUserID: item[''],
      createdateTime: item[''],
      lastpasswordchanged: item[''],
      lastupdateIp: item[''],
      licensekey: item[''],
      lockpin: item[''],
      password: item[''],
      updatedDatetime: item[''],
      updateduserid: item[''],
      userstatus: item[''],
      usertype: item['']);

  Map<String, Object?> toMap() => {
        UsersT.autoId: autoId,
        UsersT.branch: branch,
        UsersT.terminal: terminal,
        UsersT.createdUserID: createdUserID,
        UsersT.createdateTime: createdateTime,
        UsersT.lastpasswordchanged: lastpasswordchanged,
        UsersT.lastupdateIp: lastupdateIp,
        UsersT.licensekey: licensekey,
        UsersT.lockpin: lockpin,
        UsersT.password: password,
        UsersT.updatedDatetime: updatedDatetime,
        UsersT.userName: userName,
        UsersT.usercode: usercode,
        UsersT.userstatus: userstatus,
        UsersT.usertype: usertype,
        UsersT.updateduserid: updateduserid
      };
}
