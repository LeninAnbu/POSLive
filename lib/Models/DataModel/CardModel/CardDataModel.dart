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
//  {documentno: 2302HOT3100001, docentry: 3000000, lineid: 2, doctype: Sales Invoice, 
//  rcamount: 10000, rcmode: Card, customerphono: , cardApprno: hubbhi, cardterminal: Terminal - 3,
//   rcdatetime: 2023-09-13 12: 44: 32, createdateTime: 2023-09-13 12: 44: 32, couponcode: ,
//    coupontype: , walletid: null, wallettype: null, chequedate: null, chequeno: null
//     },