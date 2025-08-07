import 'dart:convert';

class CustSeriesModel {
  CustSeriesModel(
      {required this.status,
      required this.message,
      required this.seriescustData,
      required this.statusCode});

  bool? status;
  String? message;
  List<CustSeriesModelData>? seriescustData;
  int? statusCode;

  factory CustSeriesModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List;
        List<CustSeriesModelData> dataList = list
            .map((dynamic enquiries) => CustSeriesModelData.fromJson(enquiries))
            .toList();
        return CustSeriesModel(
          seriescustData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statusCode: stcode,
        );
      } else {
        return CustSeriesModel(
          message: jsons['data'].toString(),
          status: jsons['status'] as bool,
          seriescustData: null,
          statusCode: stcode,
        );
      }
    } else {
      return CustSeriesModel(
        message: resp,
        status: null,
        seriescustData: null,
        statusCode: stcode,
      );
    }
  }
}

class CustSeriesModelData {
  int? Series;
  String? SeriesName;

  CustSeriesModelData({
    required this.Series,
    required this.SeriesName,
  });

  factory CustSeriesModelData.fromJson(dynamic jsons) {
    return CustSeriesModelData(
        Series: jsons['Series'] == null ? 0 : jsons['Series'] as int,
        SeriesName:
            jsons['SeriesName'] == null ? '' : jsons['SeriesName'] as String);
  }
}
