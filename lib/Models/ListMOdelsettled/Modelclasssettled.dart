class Paylist {
  String? ApprovelNo;
  String? Cardref;
  String? rupees;
  String? name;
  int? PhNo;
  String? Date;
  int? onchanged;
  bool? checkClr;
  String? ChequeNo;
  String? ChequeDate;
  String? walletname;
  String? couponname;
  String? payNo;
  String? cardType;
  String? amounthand;
  String? amountsettledoff;
  String? settlementaccount;
  String? paymode;
  String? paycardterminal;
  String? walletterminal;
  String? couponterminal;
  Paylist(
      {this.amounthand,
      this.amountsettledoff,
      this.settlementaccount,
      this.paymode,
      this.ApprovelNo,
      this.Cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.PhNo,
      this.Date,
      this.checkClr,
      this.ChequeNo,
      this.ChequeDate,
      this.walletname,
      this.payNo,
      this.couponname,
      this.cardType,
      this.paycardterminal,
      this.walletterminal,
      this.couponterminal});
}

class CashList {
  String rcdocentry;
  String rcdoctno;
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String? ApprovelNo;
  String? Cardref;
  String? rupees;
  String? name;
  int? PhNo;
  String? Date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  CashList(
      {this.basedoctype,
      required this.rcdocentry,
      required this.rcdoctno,
      this.basedocentry,
      this.baselineid,
      this.docentry,
      this.ApprovelNo,
      this.Cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.PhNo,
      this.Date,
      this.checkClr,
      this.cardterminal});
}

class CardList {
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String approvelNo;
  String cardRef;
  String rupees;
  String name;
  int? PhNo;
  String Date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  CardList(
      {this.basedoctype,
      this.docentry,
      this.basedocentry,
      this.baselineid,
      required this.approvelNo,
      required this.cardRef,
      required this.rupees,
      required this.name,
      this.onchanged,
      required this.PhNo,
      required this.Date,
      this.checkClr,
      this.cardterminal});
}

class ChequeList {
  String rcdocentry;
  String rcdoctno;
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String name;
  int PhNo;
  String rupees;
  String chequeNo;
  String chequeDate;
  String? docno;
  String? rcmode;
  int? onchanged;
  bool? checkClr;

  ChequeList({
    this.docno,
    this.rcmode,
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.rcdocentry,
    required this.rcdoctno,
    required this.name,
    required this.PhNo,
    required this.rupees,
    this.onchanged,
    required this.chequeNo,
    required this.chequeDate,
    this.checkClr,
  });
}

class Walletlist {
  String? basedoctype;
  String? basedocentry;
  String? baselineid;
  String? docentry;
  String walletname;

  String rupees;
  String Date;
  String name;
  int PhNo;
  String payNo;

  int? onchanged;
  bool? checkClr;
  Walletlist({
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.walletname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.PhNo,
    required this.Date,
    this.checkClr,
  });
}

class couponcodelist {
  String? basedoctype;
  String? docentry;
  String? basedocentry;
  String? baselineid;
  String couponname;

  String rupees;
  String Date;
  String name;
  int PhNo;
  String payNo;

  int? onchanged;
  bool? checkClr;

  couponcodelist({
    this.basedoctype,
    this.docentry,
    this.basedocentry,
    this.baselineid,
    required this.couponname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.PhNo,
    required this.Date,
    this.checkClr,
  });
}
