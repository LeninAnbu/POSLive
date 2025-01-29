import 'dart:convert';

class CompanyAddressMdl {
  CompanyAddressMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<CompanyAddressMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory CompanyAddressMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<CompanyAddressMdlData> dataList = list
            .map((dynamic enquiries) =>
                CompanyAddressMdlData.fromJson(enquiries))
            .toList();
        return CompanyAddressMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return CompanyAddressMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return CompanyAddressMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory CompanyAddressMdl.error(String e, int stcode) {
    return CompanyAddressMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class CompanyAddressMdlData {
  String? companyAdd;

  CompanyAddressMdlData({
    required this.companyAdd,
  });

  factory CompanyAddressMdlData.fromJson(dynamic jsons) {
    return CompanyAddressMdlData(
      companyAdd: jsons['CompnyAddr'] ?? '',
    );
  }
}
