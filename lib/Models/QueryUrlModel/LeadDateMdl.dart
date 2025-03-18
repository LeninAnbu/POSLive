import 'dart:convert';

class LeadDateMdl {
  LeadDateMdl({
    required this.status,
    required this.message,
    required this.leadDataList,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<LeadDateMdlData>? leadDataList;
  String? error;
  int? statusCode;

  factory LeadDateMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<LeadDateMdlData> dataList = list
            .map((dynamic enquiries) => LeadDateMdlData.fromJson(enquiries))
            .toList();
        return LeadDateMdl(
          leadDataList: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return LeadDateMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          leadDataList: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return LeadDateMdl(
        message: null,
        status: null,
        leadDataList: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory LeadDateMdl.error(String e, int stcode) {
    return LeadDateMdl(
      message: null,
      status: null,
      leadDataList: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class LeadDateMdlData {
  int? leadDays;

  LeadDateMdlData({
    required this.leadDays,
  });

  factory LeadDateMdlData.fromJson(dynamic jsons) {
    return LeadDateMdlData(
      leadDays: jsons['Column1'] ?? 0,
    );
  }
}
