

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class GetPaymentGroupModel {
  GetPaymentGroupModel({
    required this.status,
    required this.message,
    required this.groupcustData,
    required this.statusCode
    });

  bool? status;
  String? message;
  List<GetPayGrpData>? groupcustData;
  int ? statusCode;

  factory GetPaymentGroupModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetPayGrpData> dataList = list
          .map((dynamic enquiries) => GetPayGrpData.fromJson(enquiries))
          .toList();
      return GetPaymentGroupModel(
        groupcustData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        statusCode: stcode,
      );
    } else {
      return GetPaymentGroupModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        groupcustData:null,
        statusCode: stcode,
      );
    }
    }else{
       return GetPaymentGroupModel(
        message: resp,
        status: null,
        groupcustData:null,
        statusCode: stcode,
      );
    }
  }
}

class GetPayGrpData{
  int? GroupNum;
String ? PymntGroup;

GetPayGrpData({
required  this.GroupNum,
required this.PymntGroup,
});
     
factory GetPayGrpData.fromJson(dynamic jsons) {  
    return GetPayGrpData(
    GroupNum:jsons['GroupNum']==null? 0 : jsons['GroupNum']as int,
    PymntGroup:  jsons['PymntGroup']==null? '' : jsons['PymntGroup']as String);}}
