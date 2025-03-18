import 'dart:convert';

class NewDocSeriesMdl {
  NewDocSeriesMdl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NewDocSeriesMdlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory NewDocSeriesMdl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<NewDocSeriesMdlData> dataList = list
            .map((dynamic enquiries) => NewDocSeriesMdlData.fromJson(enquiries))
            .toList();
        return NewDocSeriesMdl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NewDocSeriesMdl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NewDocSeriesMdl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory NewDocSeriesMdl.error(String e, int stcode) {
    return NewDocSeriesMdl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class NewDocSeriesMdlData {
  int? seriesCode;
  String? seriesName;

  NewDocSeriesMdlData({
    required this.seriesCode,
    required this.seriesName,
  });

  factory NewDocSeriesMdlData.fromJson(dynamic jsons) {
    return NewDocSeriesMdlData(
      seriesCode: jsons['Series'] ?? 0,
      seriesName: jsons['SeriesName'] ?? '',
    );
  }
}
