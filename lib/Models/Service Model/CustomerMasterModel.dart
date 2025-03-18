import 'dart:convert';

class CustomerModel {
  List<CustomerMasterModeldata>? customerdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  CustomerModel(
      {required this.customerdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory CustomerModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (jsons["data"] != null) {
      var list = jsonDecode(jsons["data"]) as List;
      List<CustomerMasterModeldata> dataList =
          list.map((data) => CustomerMasterModeldata.fromJson(data)).toList();
      return CustomerModel(
          customerdata: dataList,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    } else {
      return CustomerModel(
          customerdata: null,
          message: jsons["message"],
          status: jsons["status"],
          stcode: stcode,
          exception: null);
    }
  }

  factory CustomerModel.error(String jsons, int stcode) {
    return CustomerModel(
        customerdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class CustomerMasterModeldata {
  String? cardCode;
  String? phNo;
  String? Phno2;
  String? name;
  String? customertype;
  double? accBalance;
  String? taxNo;
  String? taxCode;
  String? email;
  String? uCashCust;

  String? point;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  String? premiumid;
  String? snapdatetime;
  String? createdbybranch;
  CustomerMasterModeldata({
    required this.cardCode,
    required this.customertype,
    required this.name,
    required this.phNo,
    required this.accBalance,
    required this.point,
    required this.taxNo,
    required this.taxCode,
    required this.uCashCust,
    required this.email,
    required this.Phno2,
    this.createdbybranch,
    this.snapdatetime,
    this.premiumid,
    this.createdateTime,
    this.updatedDatetime,
    this.createdUserID,
    this.lastupdateIp,
    this.updateduserid,
  });
  // {\"customerCode\":\"B1111\",\"customername\":\"MOSHI DEPOT\",\"premiumid\":\"\",
  //\"customertype\":\"Customers - Paints\",\"taxno\":\"\",\"createdbybranch\":\"\",\"balance\":0.000000,
  //\"points\":\"0\",\"snapdatetime\":\"2023-04-05T10:54:27.483\",\"phoneno1\":null,\"phoneno2\":null,
  //\"emalid\":null,\"createdateTime\":\"2023-04-05T10:54:27.483\",
  //\"updatedDatetime\":\"2023-04-05T10:54:27.483\",\"createdUserID\":\"1\",\"updateduserid\":\"1\",
  //\"lastupdateIp\":\"\"}

  factory CustomerMasterModeldata.fromJson(Map<String, dynamic> json) =>
      CustomerMasterModeldata(
        name: json['customername'] ?? '',
        phNo: json['phoneno1'] ?? '',
        cardCode: json['customerCode'] ?? '',
        uCashCust: json['U_CASHCUST'] ?? '',
        customertype: json['customertype'] ?? '',
        accBalance: json['balance'] ?? 0,
        premiumid: json['premiumid'] ?? '',
        point: json['points'] ?? '',
        taxNo: json['taxno'] ?? '',
        taxCode: json['TaxCode'] ?? '',
        email: json['emalid'] ?? '',
        createdbybranch: json['createdbybranch'] ?? '',
        snapdatetime: json['snapdatetime'] ?? '',
        createdUserID: json['createdUserID'] ?? '',
        createdateTime: json['createdateTime'] ?? '',
        lastupdateIp: json['lastupdateIp'] ?? '',
        updatedDatetime: json['updatedDatetime'] ?? '',
        updateduserid: json['updateduserid'] ?? '',
        Phno2: json['phoneno2'] ?? '',
      );
}
