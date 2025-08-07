class CardModel {
  String rcdocentry;
  String rcdoctno;
  String documentno;
  int docentry;
  int lineid;
  String doctype;
  double rcamount;
  String rcmode;
  String cardApprno;
  String cardterminal;
  String rcdatetime;
  String createdateTime;
  bool? isSelected = false;

  CardModel(
      {required this.rcdocentry,
      required this.rcdoctno,
      required this.cardApprno,
      required this.cardterminal,
      required this.createdateTime,
      required this.docentry,
      required this.doctype,
      required this.documentno,
      required this.lineid,
      required this.rcamount,
      required this.rcdatetime,
      required this.rcmode,
      this.isSelected});
}
