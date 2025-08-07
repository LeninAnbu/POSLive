//{status: true, msg: Success, data: [{"OnHand":814.000000,"ItemCode":"100017A","WhsCode":"HOFG"}]}
import 'dart:convert';

class OnHandModels {
  OnHandModels({
    required this.status,
    required this.message,
    required this.onHandData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<OnHandModelsData>? onHandData;
  String? error;
  int? statusCode;

  factory OnHandModels.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<OnHandModelsData> dataList = list
            .map((dynamic enquiries) => OnHandModelsData.fromJson(enquiries))
            .toList();
        return OnHandModels(
          onHandData: dataList,
          message: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return OnHandModels(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          onHandData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return OnHandModels(
        message: null,
        status: null,
        onHandData: null,
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory OnHandModels.errors(String e, int stcode) {
    return OnHandModels(
      message: null,
      status: null,
      onHandData: [],
      error: e,
      statusCode: stcode,
    );
  }
}

class OnHandModelsData {
  double onHand;
  double availableStock;

  String itemCode;
  String whsCode;
  OnHandModelsData({
    required this.onHand,
    required this.availableStock,
    required this.itemCode,
    required this.whsCode,
  });
// [{\"OnHand\":226.800000,\"ItemCode\":\"100017A\",\"WhsCode\":\"UBNFG\",\"AvailableStock\":2198.625200}]"
  factory OnHandModelsData.fromJson(dynamic jsons) {
    return OnHandModelsData(
      onHand: jsons['OnHand'] ?? 0,
      availableStock: jsons['AvailableStock'] ?? 0,
      itemCode: jsons['ItemCode'] ?? "",
      whsCode: jsons['WhsCode'] ?? "",
    );
  }
}
