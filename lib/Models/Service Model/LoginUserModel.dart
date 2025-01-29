import 'dart:convert';
import 'dart:developer';

class LoginUserModel {
  bool? status;
  String? message;
  List<LoginUserData>? loginuserList;
  String? exception;
  int statuscode;
  LoginUserModel(
      {required this.status,
      required this.message,
      this.loginuserList,
      required this.statuscode,
      this.exception});

  factory LoginUserModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['message'] == "Success") {
      var list = jsonDecode(jsons['data'] as String) as List;
      List<LoginUserData> dataList =
          list.map((data) => LoginUserData.fromJson(data)).toList();

      return LoginUserModel(
          loginuserList: dataList,
          //
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      log("stcode::$Statuscode");
      return LoginUserModel(
          message: jsons['message'].toString(),
          //
          status: jsons['status'] as bool,
          loginuserList: null,
          statuscode: Statuscode);
    }
  }
  factory LoginUserModel.exception(String jsons, int stcode) {
    return LoginUserModel(
        loginuserList: null,
        //
        message: null,
        status: null,
        statuscode: stcode,
        exception: jsons);
  }
}

class LoginUserData {
  int? autoId;
  String? usercode;
  String? userName;
  String? password;
  String? sapUserName;
  String? sapPassword;
  String? sapDB;
  int? slpCode;
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

  LoginUserData({
    this.autoId,
    required this.usercode,
    required this.userName,
    this.sapUserName,
    this.sapPassword,
    required this.branch,
    this.slpCode,
    this.sapDB,
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
// {"status":true,"message":"Success","data":"[{\"Usercode\":\"U101\",\"UserName\":\"bala\",\"Password\":\"1234\",\"Lockpin\":null,\"Branch\":\"HOFG\",\"Terminal\":\"T1\",\"Userstatus\":\"Y\",\"Usertype\":\"user\",\"Licensekey\":\"buson123B\",\"Lastpasswordchanged\":null,\"CreatedateTime\":\"2023-01-02T00:00:00\",\"UpdatedDatetime\":\"2023-01-02T00:00:00\",\"createdUserID\":1,\"updateduserid\":1,\"LastupdateIp\":\"192.198.182.1\"}]"}
  factory LoginUserData.fromJson(Map<String, dynamic> jsons) => LoginUserData(
      // autoId: int.parse(jsons['autoId'].toString()),
      usercode: jsons['Usercode'].toString(),
      userName: jsons['UserName'].toString(),
      sapPassword: jsons['SAPPassword'].toString(),
      sapUserName: jsons['SAPUserName'].toString(),
      branch: jsons['Branch'].toString(),
      sapDB: jsons['SAPDB'] ?? '',
      slpCode: jsons['SlpCode'] ?? 0,
      terminal: jsons['Terminal'].toString(),
      createdUserID: jsons['createdUserID'].toString(),
      createdateTime: jsons['CreatedateTime'].toString(),
      lastpasswordchanged: jsons['Lastpasswordchanged'].toString(),
      lastupdateIp: jsons['LastupdateIp'].toString(),
      licensekey: jsons['Licensekey'].toString(),
      lockpin: jsons['Lockpin'].toString(),
      password: jsons['Password'].toString(),
      updatedDatetime: jsons['UpdatedDatetime'].toString(),
      updateduserid: int.parse(jsons['updateduserid'].toString()),
      userstatus: jsons['Userstatus'].toString(),
      usertype: jsons['Usertype'].toString());
}
