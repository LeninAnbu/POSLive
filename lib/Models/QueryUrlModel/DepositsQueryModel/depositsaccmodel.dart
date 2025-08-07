import 'dart:developer';

import 'dart:convert';

class DepositAccountModel {
  bool? status;
  String? msg;

  String? error;
  int? statusCode;
  List<DepositAccountQueryData> data;

  DepositAccountModel({
    required this.status,
    required this.msg,
    required this.error,
    required this.statusCode,
    required this.data,
  });

  factory DepositAccountModel.fromJson(Map<String, dynamic> jsons, int stcode) {
    if (stcode >= 200 && stcode <= 210) {
      // log('resprespresp::${jsons['data'].toString()}');

      // var jsons = json.decode(resp) as Map<String, dynamic>;

      if (jsons['data'].toString() != 'No data found') {
        log('dddddddd');
        var list = jsonDecode(jsons['data']) as List; //jsonDecode
        List<DepositAccountQueryData> dataList = list
            .map((dynamic enquiries) =>
                DepositAccountQueryData.fromJson(enquiries))
            .toList();
        return DepositAccountModel(
          data: dataList,
          msg: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          error: null,
          statusCode: stcode,
        );
      } else {
        return DepositAccountModel(
          msg: jsons['msg'].toString(),
          status: jsons['status'] as bool,
          data: [],
          error: jsons['data'].toString(),
          statusCode: stcode,
        );
      }
    } else {
      return DepositAccountModel(
        msg: '',
        status: null,
        data: [],
        error: '',
        statusCode: stcode,
      );
    }
  }

  factory DepositAccountModel.error(String e, int stcode) {
    return DepositAccountModel(
      msg: null,
      status: null,
      data: [],
      error: '$e',
      statusCode: stcode,
    );
  }
}

// {\"U_WhsCode\":\"ARSFG\",\"U_WhsGit\":\"ARSGIT\",\"U_DepEntry\":\"_SYS00000000358\",\"AcctName\":\"Cash in Hand (AR)\"}

class DepositAccountQueryData {
  String whsCode;
  String whsGit;
  String depEntry;
  String acctName;

  DepositAccountQueryData({
    required this.whsCode,
    required this.whsGit,
    required this.depEntry,
    required this.acctName,
  });

  factory DepositAccountQueryData.fromJson(dynamic jsons) {
    return DepositAccountQueryData(
      whsGit: jsons['U_WhsGit'] ?? '',
      whsCode: jsons['U_WhsCode'] ?? '',
      depEntry: jsons['U_DepEntry'] ?? '',
      acctName: jsons['AcctName'] ?? '',
    );
  }
}
