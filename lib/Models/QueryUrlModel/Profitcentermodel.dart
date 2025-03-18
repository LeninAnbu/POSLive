import 'dart:convert';

class ProfitCentermdl {
  ProfitCentermdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<ProfitCentermdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory ProfitCentermdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<ProfitCentermdlData> dataList = list
            .map((dynamic enquiries) => ProfitCentermdlData.fromJson(enquiries))
            .toList();
        return ProfitCentermdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return ProfitCentermdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return ProfitCentermdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory ProfitCentermdl.error(String e, int stcode) {
    return ProfitCentermdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class ProfitCentermdlData {
  String? ocrCode;
  String? ocrName;

  ProfitCentermdlData({
    required this.ocrCode,
    required this.ocrName,
  });

  factory ProfitCentermdlData.fromJson(dynamic jsons) {
    return ProfitCentermdlData(
      ocrName: jsons['OcrName'] ?? '',
      ocrCode: jsons['OcrCode'] ?? '',
    );
  }
}
