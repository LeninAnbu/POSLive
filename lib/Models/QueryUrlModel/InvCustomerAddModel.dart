// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"address\":\"LUMUMBA ST\\r\\rMWANZA\\rTANZANIA\",\"U_VAT_NUMBER\":null,\"U_TinNO\":\"1234\"}]"
// }
import 'dart:convert';

class InvCustomerAddModel {
  InvCustomerAddModel({
    required this.status,
    required this.message,
    required this.openOutwardData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<InvCustomerAddModelData>? openOutwardData;
  String? error;
  int? statusCode;

  factory InvCustomerAddModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      if (jsons['data'].toString() != 'No data found') {
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<InvCustomerAddModelData> dataList = list
            .map((dynamic enquiries) =>
                InvCustomerAddModelData.fromJson(enquiries))
            .toList();
        return InvCustomerAddModel(
          openOutwardData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return InvCustomerAddModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          openOutwardData: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return InvCustomerAddModel(
        message: null,
        status: null,
        openOutwardData: [],
        error: '',
        statusCode: stcode,
      );
    }
  }
  factory InvCustomerAddModel.error(String e, int stcode) {
    return InvCustomerAddModel(
      message: null,
      status: null,
      openOutwardData: null,
      error: e,
      statusCode: stcode,
    );
  }
}

class InvCustomerAddModelData {
  String? address;
  String? U_VAT_NUMBER;
  String? U_TinNO;
  InvCustomerAddModelData({
    required this.address,
    required this.U_VAT_NUMBER,
    required this.U_TinNO,
  });
// {
//     "status": true,
//     "msg": "Success",
//     "data": "[{\"address\":\"LUMUMBA ST\\r\\rMWANZA\\rTANZANIA\",\"U_VAT_NUMBER\":null,\"U_TinNO\":\"1234\"}]"
// }
  factory InvCustomerAddModelData.fromJson(dynamic jsons) {
    return InvCustomerAddModelData(
      address: jsons['address'] ?? '',
      U_TinNO: jsons['U_TinNO'] ?? '',
      U_VAT_NUMBER: jsons['U_VAT_NUMBER'] ?? '',
    );
  }
}
