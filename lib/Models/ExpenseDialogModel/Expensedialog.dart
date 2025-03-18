class Expensedummy {
  String? docentry;
  String? expensecode;
  String? reference;
  String? rcamount;
  String? attachment;

  String? uRVC;
  String? taxCode;
  String? distRule;

  String? paidto;
  String? paidfrom;
  String? docstatus;
  String? createDate;
  String? remarks;
  String? projectName;

  Expensedummy({
    this.docentry,
    required this.expensecode,
    required this.attachment,
    required this.reference,
    required this.uRVC,
    required this.distRule,
    required this.taxCode,
    required this.rcamount,
    required this.paidto,
    required this.paidfrom,
    required this.docstatus,
    required this.createDate,
    required this.remarks,
    required this.projectName,
  });
}
