import 'dart:convert';
import 'dart:developer';

import '../../DBModel/SettlementHeader.dart';
import '../../DBModel/SettlementLineDBModel.dart';

class DepositQueue {
  int? typeCode;
  String? typeName;
  List<DepositHeaderTDB> salesHeader; //headersss
  List<DepositLineTDB> salesLine;

  DepositQueue({
    required this.typeCode,
    required this.typeName,
    required this.salesHeader,
    required this.salesLine,
  });

  factory DepositQueue.fromjson(Map<String, dynamic> resp) {
    log('Queue:values');
    var header = jsonDecode(resp['DepositHeader'].toString()) as List;
    var line = jsonDecode(resp['DepositLine'].toString()) as List;

    List<DepositHeaderTDB> listhead =
        header.map((e) => DepositHeaderTDB.fromjson(e)).toList();

    List<DepositLineTDB> listline =
        line.map((e) => DepositLineTDB.fromjson(e)).toList();

    return DepositQueue(
      typeCode: resp['TypeCode'],
      typeName: resp['TypeName'],
      salesHeader: listhead,
      salesLine: listline,
    );
  }
}
