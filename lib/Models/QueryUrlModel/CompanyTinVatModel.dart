import 'dart:convert';

class CompanyTinVatMdl {
  CompanyTinVatMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<CompanyTinVatMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory CompanyTinVatMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<CompanyTinVatMdlData> dataList = list
            .map(
                (dynamic enquiries) => CompanyTinVatMdlData.fromJson(enquiries))
            .toList();
        return CompanyTinVatMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return CompanyTinVatMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return CompanyTinVatMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory CompanyTinVatMdl.error(String e, int stcode) {
    return CompanyTinVatMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class CompanyTinVatMdlData {
  String? vatNo;

  String? tinNo;
  CompanyTinVatMdlData({
    required this.vatNo,
    required this.tinNo,
  });

  factory CompanyTinVatMdlData.fromJson(dynamic jsons) {
    return CompanyTinVatMdlData(
      vatNo: jsons['vatNo'] ?? '',
      tinNo: jsons['tinNo'] ?? '',
    );
  }
}
