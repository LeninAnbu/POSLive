import 'dart:convert';
import '../../DBModel/ExpenseDBModel.dart';

class ExpenseQueue {
  int? typeCode;
  String? typeName;
  List<ExpenseDBModel> salesHeader; //headersss

  ExpenseQueue({
    required this.typeCode,
    required this.typeName,
    required this.salesHeader,
  });

  factory ExpenseQueue.fromjson(Map<String, dynamic> resp) {
    var header = jsonDecode(resp['ExpensesHeader'].toString()) as List;

    List<ExpenseDBModel> listhead =
        header.map((e) => ExpenseDBModel.fromjson(e)).toList();

    return ExpenseQueue(
      typeCode: resp['TypeCode'],
      typeName: resp['TypeName'],
      salesHeader: listhead,
    );
  }
}
