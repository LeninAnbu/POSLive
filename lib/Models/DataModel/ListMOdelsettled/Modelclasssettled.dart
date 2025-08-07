class PayList {
  String? approvelNo;
  String? cardref;
  String? rupees;
  String? name;
  int? phNo;
  String? date;
  int? onchanged;
  bool? checkClr;
  String? chequeNo;
  String? chequeDate;
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
  PayList(
      {this.amounthand,
      this.amountsettledoff,
      this.settlementaccount,
      this.paymode,
      this.approvelNo,
      this.cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.phNo,
      this.date,
      this.checkClr,
      this.chequeNo,
      this.chequeDate,
      this.walletname,
      this.payNo,
      this.couponname,
      this.cardType,
      this.paycardterminal,
      this.walletterminal,
      this.couponterminal});
}

class CardList {
  String? docentry;
  String approvelNo;
  String cardref;
  String rupees;
  String name;
  int phNo;
  String date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  CardList(
      {this.docentry,
      required this.approvelNo,
      required this.cardref,
      required this.rupees,
      required this.name,
      this.onchanged,
      required this.phNo,
      required this.date,
      this.checkClr,
      this.cardterminal});
}

class Chequelist {
  String? docentry;
  String name;
  int phNo;
  String rupees;

  String chequeNo;

  String chequeDate;

  int? onchanged;
  bool? checkClr;
  Chequelist({
    this.docentry,
    required this.name,
    required this.phNo,
    required this.rupees,
    this.onchanged,
    required this.chequeNo,
    required this.chequeDate,
    this.checkClr,
  });
}

class Cashlist {
  String? docentry;
  String? approvelNo;
  String? cardref;
  String? rupees;
  String? name;
  int? phNo;
  String? date;
  int? onchanged;
  bool? checkClr;
  String? cardterminal;
  Cashlist(
      {this.docentry,
      this.approvelNo,
      this.cardref,
      this.rupees,
      this.name,
      this.onchanged,
      this.phNo,
      this.date,
      this.checkClr,
      this.cardterminal});
}

class Walletlist {
  String? docentry;
  String walletname;

  String rupees;
  String date;
  String name;
  int phNo;
  String payNo;

  int? onchanged;
  bool? checkClr;
  Walletlist({
    this.docentry,
    required this.walletname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.phNo,
    required this.date,
    this.checkClr,
  });
}

class CouponCodeList {
  String? docentry;
  String couponname;

  String rupees;
  String date;
  String name;
  int phNo;
  String payNo;

  int? onchanged;
  bool? checkClr;

  CouponCodeList({
    this.docentry,
    required this.couponname,
    required this.payNo,
    required this.rupees,
    required this.name,
    this.onchanged,
    required this.phNo,
    required this.date,
    this.checkClr,
  });
}
