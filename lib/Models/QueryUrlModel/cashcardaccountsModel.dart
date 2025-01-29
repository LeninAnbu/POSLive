// Quot Data Res: {status: true, msg: Success, data: [c]}

import 'dart:convert';

class CashCardAccDetailsModel {
  CashCardAccDetailsModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<CashCardAccDetailData>? activitiesData;
  String? error;
  int? statusCode;

  factory CashCardAccDetailsModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<CashCardAccDetailData> dataList = list
            .map((dynamic enquiries) =>
                CashCardAccDetailData.fromJson(enquiries))
            .toList();
        return CashCardAccDetailsModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return CashCardAccDetailsModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return CashCardAccDetailsModel(
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
class CashCardAccDetailData {
  String uCashAcct;
  String uCreditAcct;
  String uChequeAcct;
  String uTransferAcct;
  String uWalletAcc;
  CashCardAccDetailData({
    required this.uCashAcct,
    required this.uChequeAcct,
    required this.uCreditAcct,
    required this.uTransferAcct,
    required this.uWalletAcc,
  });

  factory CashCardAccDetailData.fromJson(dynamic jsons) {
    return CashCardAccDetailData(
      uCashAcct: jsons['U_CashAcct'] ?? '',
      uChequeAcct: jsons['U_CreditAcct'] ?? "",
      uCreditAcct: jsons['U_ChequeAcct'] ?? "",
      uTransferAcct: jsons['U_TransAcct'] ?? '',
      uWalletAcc: jsons['U_WalletAcct'] ?? '',

      //
    );
  }
}
