import 'dart:convert';

// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"Address1\":\"21ST CENTURY FOOD & PACKAGING LTD-SILO\",\"Address2\":null,\"Address3\":null,\"State code\":null,\"Country code\":\"TZ\",\"Geolocation1\":\"\",\"Geolocation2\":\"\",\"Pincode\":null,\"Cust code\":\"D14131\"},{\"Address1\":\"Ship To\",\"Address2\":null,\"Address3\":null,\"State code\":null,\"Country code\":\"TZ\",\"Geolocation1\":\"\",\"Geolocation2\":\"\",\"Pincode\":null,\"Cust code\":\"D14131\"}]"
// }
class AddressReportModel {
  List<AddressReportData>? customerdata;
  String? message;
  bool? status;
  String? exception;
  int? stcode;
  AddressReportModel(
      {required this.customerdata,
      required this.message,
      required this.status,
      this.exception,
      required this.stcode});
  factory AddressReportModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons["data"]) as List;
        List<AddressReportData> dataList =
            list.map((data) => AddressReportData.fromJson(data)).toList();
        return AddressReportModel(
            customerdata: dataList,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      } else {
        return AddressReportModel(
            customerdata: null,
            message: jsons["message"],
            status: jsons["status"],
            stcode: stcode,
            exception: null);
      }
    } else {
      return AddressReportModel(
          customerdata: null,
          message: null,
          status: null,
          stcode: stcode,
          exception: null);
    }
  }

  factory AddressReportModel.error(String jsons, int stcode) {
    return AddressReportModel(
        customerdata: null,
        message: null,
        status: null,
        stcode: stcode,
        exception: jsons);
  }
}

class AddressReportData {
  String? pincode;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? statecode;
  String? countrycode;
  String? geolocation1;
  String? geolocation2;

  // String? terminal;
  String? createdateTime;
  String? updatedDatetime;
  String? createdUserID;
  String? updateduserid;
  String? lastupdateIp;
  AddressReportData(
      {this.createdUserID,
      this.createdateTime,
      this.lastupdateIp,
      this.updatedDatetime,
      this.updateduserid,
      required this.address1,
      required this.address2,
      required this.address3,
      required this.pincode,
      required this.city,
      required this.countrycode,
      required this.custcode,
      // required this.terminal,
      required this.geolocation1,
      required this.geolocation2,
      this.statecode});

//     "data": "[{\"Address1\":\"21ST CENTURY FOOD & PACKAGING LTD-SILO\",\"Address2\":null,\"Address3\":null,\"State code\":null,
//\"Country code\":\"TZ\",\"Geolocation1\":\"\",\"Geolocation2\":\"\",\"cc\":null,\"Cust code\":\"D14131\"},{\"Address1\":\"Ship To\",\"Address2\":null,\"Address3\":null,\"State code\":null,\"Country code\":\"TZ\",\"Geolocation1\":\"\",\"Geolocation2\":\"\",\"Pincode\":null,\"Cust code\":\"D14131\"}]"

  factory AddressReportData.fromJson(Map<String, dynamic> json) =>
      AddressReportData(
        address1: json['Address1'] ?? '',
        address2: json['Address2'] ?? '',
        address3: json['Address3'] ?? '',
        statecode: json['State code'] ?? '',
        pincode: json['Pincode'] ?? '',
        city: json['Customer Address'] ?? '',
        countrycode: json['Country code'] ?? 0.0,
        custcode: json['Cust code'] ?? '',
        geolocation1: json['Geolocation1'] ?? '',
        geolocation2: json['Geolocation2'] ?? '',
      );
}
