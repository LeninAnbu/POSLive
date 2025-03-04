// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"ItemName\":\"ZINC CHROMATE PRIMER RED - BULK\",\"Quantity\":0.000000},{\"ItemName\":\"BOARD PAINT LIGHT GREY - BULK\",\"Quantity\":0.000000},{\"ItemName\":\"ALUMINIUM SULPHATE\",\"Quantity\":300.000000},{\"ItemName\":\"DIP Slides\",\"Quantity\":0.000000}]"
// }

import 'dart:convert';

class StockRepModel {
  StockRepModel({
    required this.status,
    required this.message,
    required this.stockRepData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<StockRepModelData>? stockRepData;
  String? error;
  int? statusCode;

  factory StockRepModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<StockRepModelData> dataList = list
            .map((dynamic enquiries) => StockRepModelData.fromJson(enquiries))
            .toList();
        return StockRepModel(
          stockRepData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return StockRepModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          stockRepData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return StockRepModel(
        message: null,
        status: null,
        stockRepData: null,
        error: resp,
        statusCode: stcode,
      );
    }
  }
  factory StockRepModel.error(String resp, int stcode) {
    return StockRepModel(
      message: null,
      status: null,
      stockRepData: null,
      error: resp,
      statusCode: stcode,
    );
  }
}

//  "data": "[{\"Item Code\":\"110947A\",\"Item Name\":\"DELUX PRO GUARD EMULSION SWEAT LAVANDER  G 548 -20LTR\",\"BRANCH\":\"MWZFG\",\"Serial/ Batch\":null,\"Quantity \":1.000000},{\"
class StockRepModelData {
  String itemName;
  String itemCode;
  String serialBatch;
  String branch;

  double qty;

  StockRepModelData(
      {required this.itemName,
      required this.qty,
      required this.branch,
      required this.itemCode,
      required this.serialBatch});

  factory StockRepModelData.fromJson(dynamic jsons) {
    return StockRepModelData(
      itemName: jsons['ItemName'] ?? '',
      qty: jsons['Quantity'] ?? 0.0,
      itemCode: jsons['ItemCode'] ?? '',
      branch: jsons['BRANCH'] ?? '',
      serialBatch: jsons['Serial/ Batch'] ?? '',
    );
  }
}
