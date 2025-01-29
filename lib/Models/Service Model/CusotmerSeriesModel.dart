// import 'dart:convert';

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

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
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
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

// class CustSeriesModel {
//   CustSeriesModel(
//       {required this.status,
//       required this.message,
//       required this.seriescustData,
//       required this.statusCode,
//       required this.exception});

//   bool? status;
//   String? message;
//   List<CustSeriesModelData>? seriescustData;
//   int? statusCode;
//   String? exception;

//   factory CustSeriesModel.fromJson(String jsons, int stcode) {
//     if (jsons['message'] == "Success") {
//       var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
//       List<CustSeriesModelData> dataList = list
//           .map((dynamic enquiries) => CustSeriesModelData.fromJson(enquiries))
//           .toList();
//       return CustSeriesModel(
//         seriescustData: dataList,
//         message: jsons['message'].toString(),
//         status: jsons['status'],
//         statusCode: stcode,
//         exception: null,
//       );
//     } else {
//       return CustSeriesModel(
//         message: jsons['message'].toString(),
//         status: jsons['status'] as bool,
//         seriescustData: null,
//         statusCode: stcode,
//         exception: null,
//       );
//     }
//   }
//   factory CustSeriesModel.error(String jsons, int stcode) {
//     return CustSeriesModel(
//         seriescustData: null,
//         message: null,
//         status: null,
//         statusCode: stcode,
//         exception: jsons);
//   }
// }

// class CustSeriesModelData {
//   int? Series;
//   String? SeriesName;

//   CustSeriesModelData({
//     required this.Series,
//     required this.SeriesName,
//   });

//   factory CustSeriesModelData.fromJson(Map<String, dynamic> jsons) {
//     return CustSeriesModelData(
//         Series: jsons['Series'], SeriesName: jsons['SeriesName'].toString());
//   }
// }
