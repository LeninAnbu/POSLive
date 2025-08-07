import 'dart:convert';

import '../../DBModel/SalesReturnHeadT.dart';
import '../../DBModel/SalesReturnLineT.dart';

class SalesRetrun {
  int? typeCode;
  String? typeName;

  List<SalesReturnTModelDB>? salesHeader;
  List<SalesReturnLineTDB>? salesLine;

  SalesRetrun({
    required this.typeCode,
    required this.typeName,
    required this.salesHeader,
    required this.salesLine,
  });

  factory SalesRetrun.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['SalesReturnHeader'].toString()) as List;
    var line = jsonDecode(resp['SalesReturnLine'].toString()) as List;

    List<SalesReturnTModelDB> listhead =
        header.map((e) => SalesReturnTModelDB.fromjson(e)).toList();

    List<SalesReturnLineTDB> listline =
        line.map((e) => SalesReturnLineTDB.fromjson(e)).toList();

    return SalesRetrun(
      typeCode: resp['TypeCode'],
      typeName: resp['TypeName'],
      salesHeader: listhead,
      salesLine: listline,
    );
  }
}
