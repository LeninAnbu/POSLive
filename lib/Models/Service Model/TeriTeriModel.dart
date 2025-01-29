

// ignore_for_file: prefer_final_locals, omit_local_variable_types, require_trailing_commas

import 'dart:convert';

class GetTeriteriModel {
  GetTeriteriModel({
    required this.status,
    required this.message,
    required this.groupcustData,
    required this.statusCode
    });

  bool? status;
  String? message;
  List<GetTeriteriData>? groupcustData;
  int ? statusCode;

  factory GetTeriteriModel.fromJson(String resp, int stcode) {
    if(stcode >= 200 && stcode <= 210){
    var jsons = json.decode(resp) as Map<String, dynamic>;

        if (jsons['data'] != 'No data found') {
      var list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      List<GetTeriteriData> dataList = list
          .map((dynamic enquiries) => GetTeriteriData.fromJson(enquiries))
          .toList();
      return GetTeriteriModel(
        groupcustData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool, 
        statusCode: stcode,
      );
    } else {
      return GetTeriteriModel(
        message: jsons['data'].toString(),
        status: jsons['status'] as bool,
        groupcustData:null,
        statusCode: stcode,
      );
    }
    }else{
       return GetTeriteriModel(
        message: resp,
        status: null,
        groupcustData:null,
        statusCode: stcode,
      );
    }
  }
}

class GetTeriteriData{
  int? teriID;
String ? descript;

GetTeriteriData({
required  this.teriID,
required this.descript,
});
     
factory GetTeriteriData.fromJson(dynamic jsons) {  
    return GetTeriteriData(
    teriID:jsons['territryID']==null? 0 : jsons['territryID']as int,
    descript:  jsons['descript']==null? '' : jsons['descript']as String);}}
