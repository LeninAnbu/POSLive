// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"ItemCode\":\"1000002D\",\"ItemName\":\"RED OXIDE PRIMER - 4LTR\",\"BatchNum\":\"24-32434\",\"WhsCode\":\"HOFG\",\"Quantity\":152.000000,\"InDate\":\"2024-11-20T00:00:00\",\"Located\":null,\"ExpDate\":\"2026-11-20T00:00:00\",\"PrdDate\":null,\"Direction\":0}]"
// }
import 'dart:convert';
import 'dart:developer';

class AutoSelectModl {
  AutoSelectModl({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<AutoSelectModlData>? openOutwardData;
  String? error;
  int? statusCode;

  factory AutoSelectModl.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<AutoSelectModlData> dataList = list
            .map((dynamic enquiries) => AutoSelectModlData.fromJson(enquiries))
            .toList();
        return AutoSelectModl(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return AutoSelectModl(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return AutoSelectModl(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory AutoSelectModl.error(String e, int stcode) {
    return AutoSelectModl(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class AutoSelectModlData {
  String expDate;
  String inDate;
  String whsCode;
  String itemCode;
  String description;
  double qty;
  double price;
  double remQty;
  String batchNum;
  String prdDate;
  String itemName;
  String located;
  int direction;
  int? invoiceClr;
  bool? checkBClr;
  AutoSelectModlData(
      {required this.description,
      required this.itemCode,
      required this.whsCode,
      required this.batchNum,
      required this.itemName,
      required this.remQty,
      this.checkBClr,
      this.invoiceClr,
      required this.qty,
      required this.price,
      required this.located,
      required this.direction,
      required this.expDate,
      required this.inDate,
      required this.prdDate});
// "data": "[{\"ItemCode\":\"1000002D\",\"ItemName\":\"RED OXIDE PRIMER - 4LTR\",\"BatchNum\":\"24-32434\",\"WhsCode\":\"HOFG\",\"Quantity\":152.000000,\"InDate\":\"2024-11-20T00:00:00\",\"Located\":null,\"ExpDate\":\"2026-11-20T00:00:00\",\"PrdDate\":null,\"Direction\":0}]"

  factory AutoSelectModlData.fromJson(dynamic jsons) {
    return AutoSelectModlData(
        inDate: jsons['InDate'] ?? '',
        expDate: jsons['ExpDate'] ?? '',
        prdDate: jsons['PrdDate'] ?? '',
        itemName: jsons['ItemName'] ?? '',
        located: jsons['Located'] ?? '',
        whsCode: jsons['WhsCode'] ?? '',
        qty: jsons['Quantity'] ?? 0,
        remQty: jsons['RemQty'] ?? 0,
        price: jsons['Price'] ?? 0,
        batchNum: jsons['BatchNum'] ?? '',
        itemCode: jsons['ItemCode'] ?? '',
        description: jsons['Dscription'] ?? '',
        direction: jsons['Direction'] ?? 0);
  }
}
