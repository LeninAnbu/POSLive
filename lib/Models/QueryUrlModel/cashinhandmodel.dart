import 'dart:convert';

class CashInHandModel {
  CashInHandModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<CashInHandModelData>? activitiesData;
  String? error;
  int? statusCode;

  factory CashInHandModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<CashInHandModelData> dataList = list
            .map((dynamic enquiries) => CashInHandModelData.fromJson(enquiries))
            .toList();
        return CashInHandModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return CashInHandModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return CashInHandModel(
        message: null,
        status: null,
        activitiesData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
}

// {"U_CashAcct":"_SYS00000000112","U_CreditAcct":"_SYS00000001220","U_ChequeAcct":"_SYS00000000117","U_TransferAcct":"_SYS00000001220"}
class CashInHandModelData {
  double currentTotal;

  CashInHandModelData({
    required this.currentTotal,
  });

  factory CashInHandModelData.fromJson(dynamic jsons) {
    return CashInHandModelData(
      currentTotal: jsons['currtotal'] ?? 0,
    );
  }
}
