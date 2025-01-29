const String ExpensecodeMaster ="ExpenseMaster";

class ExpenseMasterT{
  static String docentry="docentry";
  static String expensecode="expensecode";
  static String expensename="expensename";
  static String debit="debit";
  static String credit="credit";
  static String limitval="limitval";

  
}
class ExpenseMasterModel{
  String? docentry;
  String? expensecode;
  String? expensename;
  String? debit;
  String? credit;
  String? limitval;
  String? remarks;
  ExpenseMasterModel({
    this.docentry,
    required this.expensecode,
    required this.expensename,
    required this.debit,
    required this.credit,
    required this.limitval,
  });
  Map<String, Object?> toMap()=>{
    ExpenseMasterT.docentry:docentry,
    ExpenseMasterT.expensecode:expensecode,
    ExpenseMasterT.expensename:expensename,
    ExpenseMasterT.debit:debit,
    ExpenseMasterT.credit:credit,
    ExpenseMasterT.limitval:limitval,

  };
}
