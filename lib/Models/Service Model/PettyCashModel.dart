import 'dart:convert';
import 'dart:developer';

class PettyCashModel {
  bool? status;
  String? message;
  List<PettyCashData>? pettyCashList;
  String? exception;
  int statuscode;
  PettyCashModel(
      {required this.status,
      required this.message,
      this.pettyCashList,
      required this.statuscode,
      this.exception});

  factory PettyCashModel.fromJson(Map<String, dynamic> jsons, int Statuscode) {
    if (jsons['message'] == "Success") {
      var list = jsonDecode(jsons['data'] as String) as List;
      List<PettyCashData> dataList =
          list.map((data) => PettyCashData.fromJson(data)).toList();

      return PettyCashModel(
          pettyCashList: dataList,
          //
          message: jsons['message'].toString(),
          status: jsons['status'] as bool,
          statuscode: Statuscode);
    } else {
      log("stcode::$Statuscode");
      return PettyCashModel(
          message: jsons['message'].toString(),
          //
          status: jsons['status'] as bool,
          pettyCashList: null,
          statuscode: Statuscode);
    }
  }
  factory PettyCashModel.exception(String jsons, int stcode) {
    return PettyCashModel(
        pettyCashList: null,
        //
        message: null,
        status: null,
        statuscode: stcode,
        exception: jsons);
  }
}

class PettyCashData {
  String? code;
  String? name;
  double? currTotal;
  // String? formatCode;
  String? creditAcc;
  String? debitAcc;
  String? whsCode;

  PettyCashData({
    required this.whsCode,
    required this.code,
    required this.name,
    required this.currTotal,
    required this.creditAcc,
    required this.debitAcc,
  });
// Old one --{"status":true,"message":"Success","data":"[{\"AcctCode\":\"_SYS00000000362\",\"AcctName\":\"Petty Cash (AR)\",\"CurrTotal\":0.756840,\"FormatCode\":\"114000602\",\"WhsCode\":\"ARSFG\"}]"}

//New One [{\"Code\":\"Electricity\",\"Name\":\"Electricty expences\",\"Branch\":\"ARSFG\",\"DebitAcct\":\"_SYS00000000526\",\"CreditAcct\":\"_SYS00000000358\",\"CurrTotal\":2738766.462210},{\"Code\":\"Telephone\",\"Name\":\"Telephone expenses\",\"Branch\":\"ARSFG\",\"DebitAcct\":\"_SYS00000000516\",\"CreditAcct\":\"_SYS00000000358\",\"CurrTotal\":2738766.462210}]"

  factory PettyCashData.fromJson(Map<String, dynamic> jsons) => PettyCashData(
        code: jsons['Code'].toString(),
        name: jsons['Name'].toString(),
        creditAcc: jsons['CreditAcct'].toString(),
        debitAcc: jsons['DebitAcct'].toString(),
        currTotal: jsons['CurrTotal'] ?? 0,
        whsCode: jsons['Branch'].toString(),
      );
}
