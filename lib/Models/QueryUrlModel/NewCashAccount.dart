import 'dart:convert';

class NewCashCardAccDetailsModel {
  NewCashCardAccDetailsModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<NewCashCardAccDetailData>? activitiesData;
  String? error;
  int? statusCode;

  factory NewCashCardAccDetailsModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<NewCashCardAccDetailData> dataList = list
            .map((dynamic enquiries) =>
                NewCashCardAccDetailData.fromJson(enquiries))
            .toList();
        return NewCashCardAccDetailsModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return NewCashCardAccDetailsModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return NewCashCardAccDetailsModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

class NewCashCardAccDetailData {
  String uMode;
  String uAcctName;
  String uAcctCode;
  NewCashCardAccDetailData({
    required this.uMode,
    required this.uAcctCode,
    required this.uAcctName,
  });

  factory NewCashCardAccDetailData.fromJson(dynamic jsons) {
    return NewCashCardAccDetailData(
      uMode: jsons['U_Mode'] ?? '',
      uAcctCode: jsons['U_AcctCode'] ?? "",
      uAcctName: jsons['U_AcctName'] ?? "",
    );
  }
}
