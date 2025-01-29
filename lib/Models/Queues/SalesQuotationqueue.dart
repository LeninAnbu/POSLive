import 'dart:convert';
import '../../DBModel/SalesQuotationHead.dart';
import '../../DBModel/SalesQuotationLine.dart';

class SalesQuotationQueue {
  int? typeCode;
  String? typeName;
  List<SalesQuotationHeaderModelDB>? salesQuotHeader;
  List<SalesQuotationLineTDB>? salesQuotLine;
  // List<SalesOrderPayTDB>? salesOrderPayDB;

  SalesQuotationQueue({
    required this.typeCode,
    required this.typeName,
    required this.salesQuotHeader,
    required this.salesQuotLine,
    // required this.salesOrderPayDB
  });

  factory SalesQuotationQueue.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['SalesQuotationHeader'].toString()) as List;
    var line = jsonDecode(resp['SalesQuotationLine'].toString()) as List;
    //  var pay = jsonDecode(resp['SalesOrderPay'].toString()) as List;

    List<SalesQuotationHeaderModelDB> listhead =
        header.map((e) => SalesQuotationHeaderModelDB.fromjson(e)).toList();

    List<SalesQuotationLineTDB> listline =
        line.map((e) => SalesQuotationLineTDB.fromjson(e)).toList();

    //  List<SalesOrderPayTDB> paylist=  pay.map((e) =>
    //  SalesOrderPayTDB .fromjson(e)).toList();

    return SalesQuotationQueue(
      typeCode: resp['TypeCode'],
      typeName: resp['TypeName'],
      salesQuotHeader: listhead,
      salesQuotLine: listline,
      // salesOrderPayDB:paylist
    );
  }
}
