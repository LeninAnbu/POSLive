import 'dart:convert';
import '../../DBModel/StockReqLine.dart';
import '../../DBModel/StockRequestHD.dart';

class StockRequest {
  int? typeCode;
  String? typeName;

  List<StockReqHDTDB>? salesHeader;
  List<StockReqLineTDB>? salesLine;

  StockRequest({
    required this.typeCode,
    required this.typeName,
    required this.salesHeader,
    required this.salesLine,
  });

  factory StockRequest.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['StockRequestHeader'].toString()) as List;
    var line = jsonDecode(resp['StockRequestLine'].toString()) as List;

    List<StockReqHDTDB> listhead =
        header.map((e) => StockReqHDTDB.fromjson(e)).toList();

    List<StockReqLineTDB> listline =
        line.map((e) => StockReqLineTDB.fromjson(e)).toList();

    return StockRequest(
      typeCode: resp['TypeCode'],
      typeName: resp['TypeName'],
      salesHeader: listhead,
      salesLine: listline,
    );
  }
}
