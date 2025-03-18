import 'dart:convert';

class NewSeriesMdl {
  NewSeriesMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NewSeriesMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory NewSeriesMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<NewSeriesMdlData> dataList = list
            .map((dynamic enquiries) => NewSeriesMdlData.fromJson(enquiries))
            .toList();
        return NewSeriesMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NewSeriesMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NewSeriesMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory NewSeriesMdl.error(String e, int stcode) {
    return NewSeriesMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class NewSeriesMdlData {
  int? series;

  NewSeriesMdlData({
    required this.series,
  });

  factory NewSeriesMdlData.fromJson(dynamic jsons) {
    return NewSeriesMdlData(
      series: jsons['series'] ?? 0,
    );
  }
}
