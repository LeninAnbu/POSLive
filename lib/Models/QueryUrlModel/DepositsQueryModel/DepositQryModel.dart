import 'dart:convert';

class DepositQueryModel {
  DepositQueryModel({
    required this.status,
    required this.message,
    required this.activitiesData,
    required this.error,
    required this.statusCode,
  });

  bool? status;
  String? message;
  List<DepositQueryData>? activitiesData;
  String? error;
  int? statusCode;

  factory DepositQueryModel.fromJson(String resp, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'] != 'No data found') {
        var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
        List<DepositQueryData> dataList = list
            .map((dynamic enquiries) => DepositQueryData.fromJson(enquiries))
            .toList();
        return DepositQueryModel(
          activitiesData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return DepositQueryModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          activitiesData: null,
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return DepositQueryModel(
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
class DepositQueryData {
  double cashBal;
  double cardBal;
  double chequeBal;
  double walletBal;

  DepositQueryData({
    required this.cashBal,
    required this.cardBal,
    required this.chequeBal,
    required this.walletBal,
  });

  factory DepositQueryData.fromJson(dynamic jsons) {
    return DepositQueryData(
      cashBal: jsons['CashBalance'] ?? 0,
      cardBal: jsons['CardBalance'] ?? 0,
      chequeBal: jsons['ChequeBalance'] ?? 0,
      walletBal: jsons['WalletBalance'] ?? 0,
    );
  }
}
