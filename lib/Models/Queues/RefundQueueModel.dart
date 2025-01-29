import 'dart:convert';
import '../../DBModel/RefundLine.dart';
import '../../DBModel/RefundPayment.dart';
import '../../DBModel/Refundheader.dart';

class RefundQueue {
  int? typeCode;
  String? typeName;
  List<RefundHeaderTDB>? refundHeader;
  List<RefundLineTDB>? refundLine;
  List<RefundPayTDB>? refundPayDB;

  RefundQueue(
      {required this.typeCode,
      required this.typeName,
      required this.refundHeader,
      required this.refundLine,
      required this.refundPayDB});
  factory RefundQueue.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['RefundHeader'].toString()) as List;
    var line = jsonDecode(resp['RefundLine'].toString()) as List;
    var pay = jsonDecode(resp['RefundPay'].toString()) as List;

    List<RefundHeaderTDB> listhead =
        header.map((e) => RefundHeaderTDB.fromjson(e)).toList();

    List<RefundLineTDB> listline =
        line.map((e) => RefundLineTDB.fromjson(e)).toList();

    List<RefundPayTDB> paylist =
        pay.map((e) => RefundPayTDB.fromjson(e)).toList();

    return RefundQueue(
        typeCode: resp['TypeCode'],
        typeName: resp['TypeName'],
        refundHeader: listhead,
        refundLine: listline,
        refundPayDB: paylist);
  }
}
