

import 'dart:convert';

NewCustomerModal2 logindataFromJson(String str) =>
    NewCustomerModal2.fromJson(json.decode(str) as Map<String, dynamic>);


class NewCustomerModal2 {
  NewCustomerModal2(
      {required this.status,
      required this.message,
      this.CustomerData,
      this.error,
      this.exception,});

  bool? status;
  String? message;
  List<NewCustomerData>? CustomerData;
  String? error;
  String? exception;

  factory NewCustomerModal2.fromJson(Map<String, dynamic> jsons) {
    if (jsons['data'] != 'No Data Found') {
      final list = jsonDecode(jsons['data'] as String) as List; //jsonDecode
      // print(list);
      final dataList = list
          .map((dynamic enquiries) => NewCustomerData.fromJson(enquiries))
          .toList();
      // print(dataList[0]);
      return NewCustomerModal2(
        CustomerData: dataList,
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    } else {
      return NewCustomerModal2(
        message: jsons['message'].toString(),
        status: jsons['status'] as bool,
      );
    }
  }
  factory NewCustomerModal2.issue(String e) {
    return NewCustomerModal2(status: null, message: null, error: e);
  }

  factory NewCustomerModal2.exception(String e) {
    return NewCustomerModal2(status: null, message: null, error: e,
    exception: e,
    );
  }
}

class NewCustomerData{
double? currentAccountBalance;
double? currentOrderBalance;

String? cardCode;
String ?cardName;
int?slpcode;
String? slpname;
String? pymntGroup;
String? ShipToDefault;
String? BilltoDefault;
String? U_CASHCUST;

NewCustomerData({
required  this.cardCode,
required  this.cardName,
required  this.slpcode,
required  this.slpname,
required  this.pymntGroup,
required  this.currentAccountBalance,
required  this.BilltoDefault,
required this.ShipToDefault,
required this.U_CASHCUST,
required this.currentOrderBalance,

});

factory NewCustomerData.fromJson(dynamic jsons) {  
    return NewCustomerData( 
      slpcode: jsons['SlpCode']as int,
      slpname: jsons['SlpName'].toString(), 
      pymntGroup: jsons['PymntGroup'].toString(),
      cardCode: jsons['CardCode'].toString(), 
      cardName: jsons['CardName'].toString(),
      ShipToDefault: jsons['ShipToDef']==null?'': jsons['ShipToDef']as String, 
      BilltoDefault: jsons['BillToDef']==null?'': jsons['BillToDef']as String,
       currentAccountBalance:  jsons['Balance']==null?0.0: jsons['Balance']as double, 
       U_CASHCUST:jsons['U_CASHCUST']==null?'':jsons['U_CASHCUST'].toString(),
        currentOrderBalance:  jsons['OrdersBal']==null?0.0: jsons['OrdersBal']as double, 
       );
 }
 }
