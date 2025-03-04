import 'dart:convert';

class SOCustomerAddModel {
  SOCustomerAddModel({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<SOCustomerAddModelData>? openOutwardData;
  String? error;
  int? statusCode;

  factory SOCustomerAddModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<SOCustomerAddModelData> dataList = list
            .map((dynamic enquiries) =>
                SOCustomerAddModelData.fromJson(enquiries))
            .toList();
        return SOCustomerAddModel(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return SOCustomerAddModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return SOCustomerAddModel(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory SOCustomerAddModel.error(String e, int stcode) {
    return SOCustomerAddModel(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

// "data": "[{\"DocEntry\":464054,\"CardCode\":\"D8999\",\"CardName\":\"ghhhj\",\"PrintHeadr\":\"Insignia Limited\",
// \"Address\":\"TANZANIA\"}]"
class SOCustomerAddModelData {
  String? address;
  String? cardCode;
  String? cardName;
  String? printHeadr;
  int? docEntry;

  SOCustomerAddModelData({
    required this.address,
    required this.cardCode,
    required this.cardName,
    required this.docEntry,
    required this.printHeadr,
  });

  factory SOCustomerAddModelData.fromJson(dynamic jsons) {
    return SOCustomerAddModelData(
      address: jsons['Address'] ?? '',
      cardCode: jsons['CardCode'] ?? '',
      cardName: jsons['CardName'] ?? '',
      printHeadr: jsons['PrintHeadr'] ?? '',
      docEntry: jsons['DocEntry'] ?? 0,
    );
  }
}
