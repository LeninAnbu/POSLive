import 'dart:convert';

class ProjectCodeMdl {
  ProjectCodeMdl({
    required this.status,
    required this.message,
    required this.projectCodeData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<ProjectCodeMdlData>? projectCodeData;
  String? error;
  int? statusCode;

  factory ProjectCodeMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<ProjectCodeMdlData> dataList = list
            .map((dynamic enquiries) => ProjectCodeMdlData.fromJson(enquiries))
            .toList();
        return ProjectCodeMdl(
          projectCodeData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return ProjectCodeMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          projectCodeData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return ProjectCodeMdl(
        message: null,
        status: null,
        projectCodeData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory ProjectCodeMdl.error(String e, int stcode) {
    return ProjectCodeMdl(
      message: null,
      status: null,
      projectCodeData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class ProjectCodeMdlData {
  String? code;
  String? name;

  ProjectCodeMdlData({
    required this.code,
    required this.name,
  });

  factory ProjectCodeMdlData.fromJson(dynamic jsons) {
    return ProjectCodeMdlData(
      name: jsons['PrjName'] ?? '',
      code: jsons['PrjCode'] ?? '',
    );
  }
}
