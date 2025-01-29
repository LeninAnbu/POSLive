

class InvoicePayReceipt {
  int? sapbasedocentry;
  String? docNum;
  String? transdocentry;
  String? date;
  double? amount;
  String? doctype;
  int? checkbx;
  bool? checkClr;

  InvoicePayReceipt({
   this.sapbasedocentry,
    this.amount,
    this.date,
    this.checkbx,
    this.docNum,
     this.transdocentry,
    this.doctype,
     this.checkClr,
  });
}
