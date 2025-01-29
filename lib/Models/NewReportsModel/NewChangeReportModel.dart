import 'dart:convert';
import 'dart:developer';

class NewReportMdl {
  NewReportMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NewReportMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory NewReportMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<NewReportMdlData> dataList = list
            .map((dynamic enquiries) => NewReportMdlData.fromJson(enquiries))
            .toList();
        return NewReportMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NewReportMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NewReportMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory NewReportMdl.error(String e, int stcode) {
    return NewReportMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class NewReportMdlData {
  String code;
  String name;
  int docEntry;
  String cancelled;
  String object;
  String loginst;
  int userSign;
  String transfered;
  String createDate;
  String updateDate;
  int createTime;
  int updateTime;
  String dataSource;
  String u_query;
  bool? reportclr;

  NewReportMdlData({
    required this.cancelled,
    required this.code,
    required this.createDate,
    required this.createTime,
    required this.dataSource,
    required this.docEntry,
    required this.name,
    this.reportclr,
    required this.u_query,
    required this.updateDate,
    required this.updateTime,
    required this.transfered,
    required this.loginst,
    required this.userSign,
    required this.object,
  });
// {status: true, msg: Success, data: [
//{"Code":"01","Name":"Daily Collection Report","DocEntry":1,"Canceled":"N","Object":"POSRPT","LogInst":null,
//"UserSign":72,"Transfered":"N","CreateDate":"2024-12-17T00:00:00","CreateTime":1350,"UpdateDate":"2024-12-17T00:00:00",
//"UpdateTime":1359,"DataSource":"I","U_Query":"BZ_POS_CONSOLIDATED SALES IN DAY_R1"}]}

  factory NewReportMdlData.fromJson(Map<String, dynamic> json) {
    return NewReportMdlData(
      cancelled: json['Canceled'] ?? '',
      code: json['Code'] ?? '',
      createDate: json['CreateDate'] ?? "",
      createTime: json['CreateTime'] ?? 0,
      dataSource: json['DataSource'] ?? '',
      docEntry: json['DocEntry'] ?? 0,
      object: json['Object'] ?? '',
      name: json['Name'] ?? "",
      transfered: json['Transfered'] ?? "",
      u_query: json['U_Query'] ?? 0,
      updateDate: json['UpdateDate'] ?? '',
      updateTime: json['UpdateTime'] ?? 0,
      userSign: json['UserSign'] ?? 0,
      loginst: json['LogInst'] ?? "",
    );
  }
}
