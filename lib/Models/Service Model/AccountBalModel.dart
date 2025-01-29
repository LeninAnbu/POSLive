import 'dart:convert';
import 'dart:developer';

class AccountBalanceModel {
  bool? status;
  String? message;
  List<AccountBalanceModelData>? accBalanceData;
  String? exception;
  int statuscode;
  AccountBalanceModel(
      {required this.status,
      //
      required this.message,
      this.accBalanceData,
      required this.statuscode,
      this.exception});

  factory AccountBalanceModel.fromJson(
      Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['message'] == "Success") {
      var list = jsonDecode(jsons['data'] as String) as List;
      List<AccountBalanceModelData> dataList =
          list.map((data) => AccountBalanceModelData.fromJson(data)).toList();

      return AccountBalanceModel(
          accBalanceData: dataList,
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      log("stcode$Statuscode");
      return AccountBalanceModel(
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          accBalanceData: null,
          statuscode: Statuscode);
    }
  }
  // factory AccountBalanceModel.issue(int statuscode) {
  //   return AccountBalanceModel(
  //       status: null,
  //       message: null,
  //       accBalanceData: null,
  //       statuscode: statuscode);
  // }

  factory AccountBalanceModel.exception(String e, int statuscode) {
    return AccountBalanceModel(
        status: null,
        message: null,
        exception: e,
        statuscode: statuscode,
        accBalanceData: null);
  }
}

// AccBal Res{status: true, message: Success,
//data: [{"cardcode":"B1111","CardName":"MOSHI DEPOT","Balance":-25000.000000}]}
class AccountBalanceModelData {
  String cardcode;
  String cardName;
  double balance;

  AccountBalanceModelData(
      {required this.cardcode, required this.cardName, required this.balance});

  factory AccountBalanceModelData.fromJson(Map<String, dynamic> jsons) {
    return AccountBalanceModelData(
      cardcode: jsons['cardcode'].toString(),
      cardName: jsons['CardName'].toString(),
      balance: jsons['Balance'] ?? 0,
    );
  }
}
