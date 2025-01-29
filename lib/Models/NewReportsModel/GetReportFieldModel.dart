import 'dart:convert';
import 'dart:developer';

class NewReportFieldMdl {
  NewReportFieldMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NewReportFieldMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory NewReportFieldMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<NewReportFieldMdlData> dataList = list
            .map((dynamic enquiries) =>
                NewReportFieldMdlData.fromJson(enquiries))
            .toList();
        return NewReportFieldMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NewReportFieldMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NewReportFieldMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory NewReportFieldMdl.error(String e, int stcode) {
    return NewReportFieldMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class NewReportFieldMdlData {
  String code;
  String object;
  String loginst;
  int lineid;
  String uParamName;
  String uParamType;
  String? uParamQry;
  String uParamDesc;
  String uDefault;

  NewReportFieldMdlData({
    required this.lineid,
    required this.code,
    required this.uDefault,
    required this.uParamDesc,
    required this.uParamName,
    required this.uParamQry,
    required this.uParamType,
    required this.loginst,
    required this.object,
  });
// {\"Code\":\"01\",\"LineId\":1,\"Object\":\"POSRPT\",\"LogInst\":null,\"U_ParamName\":\"FD\",\"U_ParamType\":\"D\",\"U_ParamDesc\":\"From Date\",\"U_ParamQry\":null,\"U_Default\":null},

  factory NewReportFieldMdlData.fromJson(Map<String, dynamic> json) {
    return NewReportFieldMdlData(
      lineid: json['LineId'] ?? 0,
      code: json['Code'] ?? '',
      uDefault: json['U_Default'] ?? "",
      uParamDesc: json['U_ParamDesc'] ?? '',
      uParamName: json['U_ParamName'] ?? '',
      uParamQry: json['U_ParamQry'] ?? '',
      object: json['Object'] ?? '',
      uParamType: json['U_ParamType'] ?? "",
      loginst: json['LogInst'] ?? "",
    );
  }
}
