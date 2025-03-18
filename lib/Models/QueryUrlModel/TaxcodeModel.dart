import 'dart:convert';

class TaxCodeMdl {
  TaxCodeMdl({
    required this.status,
    required this.message,
    required this.taxCodeData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<TaxCodeMdlData>? taxCodeData;
  String? error;
  int? statusCode;

  factory TaxCodeMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<TaxCodeMdlData> dataList = list
            .map((dynamic enquiries) => TaxCodeMdlData.fromJson(enquiries))
            .toList();
        return TaxCodeMdl(
          taxCodeData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return TaxCodeMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          taxCodeData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return TaxCodeMdl(
        message: null,
        status: null,
        taxCodeData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory TaxCodeMdl.error(String e, int stcode) {
    return TaxCodeMdl(
      message: null,
      status: null,
      taxCodeData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class TaxCodeMdlData {
  String? code;
  String? name;
  double? rate;

  TaxCodeMdlData({
    required this.code,
    required this.name,
    required this.rate,
  });

  factory TaxCodeMdlData.fromJson(dynamic jsons) {
    return TaxCodeMdlData(
      code: jsons['Code'] ?? '',
      name: jsons['Name'] ?? '',
      rate: jsons['Rate'] ?? '',
    );
  }
}
