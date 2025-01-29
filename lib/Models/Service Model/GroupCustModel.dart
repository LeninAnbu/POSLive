

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class GroupCustModel {
  GroupCustModel(
      {required this.status,
      required this.message,
     required this.groupcustData,
      required this.statusCode});

  bool? status;
  String? message;
  List<GroupCustData>? groupcustData;
  int ? statusCode;

  factory GroupCustModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GroupCustData> dataList = list
          .map((dynamic enquiries) => GroupCustData.fromJson(enquiries))
          .toList();
      return GroupCustModel(
        groupcustData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        statusCode: stcode,
      );
    } else {
      return GroupCustModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        groupcustData:null,
        statusCode: stcode,
      );
    }
    }else{
       return GroupCustModel(
        message: resp,
        status: null,
        groupcustData:null,
        statusCode: stcode,
      );
    }
  }
}

class GroupCustData{
  int? GroupCode;
String ? GroupName;
String ? GroupType;
String ? Locked;
String ? DataSource;
int ? UserSign;
String? PriceList;
String? DiscRel;
String? EffecPrice;
String? U_CGuid;

GroupCustData({
required  this.DataSource,
required this.DiscRel,
required this.EffecPrice,
required this.GroupCode,
required this.GroupName,
required this.GroupType,
required this.Locked,
required this.PriceList,
required this.U_CGuid,
required this.UserSign,
});
     
factory GroupCustData.fromJson(dynamic jsons) {  
    return GroupCustData(
      DataSource: jsons['DataSource']==null?'': jsons['DataSource']as String,
      DiscRel: jsons['DiscRel']==null?'': jsons['DiscRel']as String,
      EffecPrice: jsons['EffecPrice']==null?'': jsons['EffecPrice']as String,
      GroupCode: jsons['GroupCode']==null?0: jsons['GroupCode']as int,
      GroupName: jsons['GroupName']==null?'': jsons['GroupName']as String,
      GroupType:  jsons['GroupType']==null?'':jsons['GroupType']as String,
      Locked: jsons['Locked']==null?'': jsons['Locked']as String,
      PriceList: jsons['PriceList']==null?'': jsons['PriceList']as String, 
      U_CGuid: jsons['U_CGuid']==null?'': jsons['U_CGuid']as String,
      UserSign: jsons['UserSign']==null? 0 : jsons['UserSign']as int);}}
