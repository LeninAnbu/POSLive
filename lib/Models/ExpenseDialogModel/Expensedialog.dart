class Expensedummy {
  String? docentry;
  String? expensecode;
  String? reference;
  String? rcamount;
  String? attachment;

  String? paidto;
  String? paidfrom;
  String? docstatus;
  String? createDate;
  String? remarks;

  Expensedummy({
    this.docentry,
    required this.expensecode,
    required this.attachment,
    required this.reference,
    required this.rcamount,
    required this.paidto,
    required this.paidfrom,
    required this.docstatus,
    required this.createDate,
    required this.remarks,
  });
}
