class PaymentWay {
  String? dateTime;
  String? type;
  double? amt;
  String? basedoctype;
  String? reference;
  String? chequeno;
  String? chequedate;
  String? remarks;
  String? cardterminal;
  String? cardApprno;
  String? cardref;
  String? wallettype;
  String? walletid;
  String? walletref;
  String? transtype;
  String? transref;
  String? coupontype;
  String? couponcode;
  String? availablept;
  String? redeempoint;
  String? discounttype;
  String? discountcode;
  String? creditref;
  String? recoverydate;

  //    ${SalesPayT.couponcode}  varchar ,
//   ${SalesPayT.coupontype}  varchar ,
//   ${SalesPayT.creditref}  varchar ,
//   ${SalesPayT.discountcode}  varchar ,
//   ${SalesPayT.cardref}  varchar ,
//  ${SalesPayT.amt}  varchar ,
//   ${SalesPayT.discounttype}  varchar ,
// ${SalesPayT.walletref}  varchar ,
//   ${SalesPayT.wallettype}  varchar ,
  PaymentWay(
      {this.amt,
      this.basedoctype,
      this.dateTime,
      this.type,
      this.reference,
      this.availablept,
      this.cardApprno,
      this.cardref,
      this.cardterminal,
      this.chequedate,
      this.chequeno,
      this.couponcode,
      this.coupontype,
      this.creditref,
      this.discountcode,
      this.discounttype,
      this.recoverydate,
      this.redeempoint,
      this.remarks,
      this.transref,
      this.transtype,
      this.walletid,
      this.walletref,
      this.wallettype});
}

class TotalPayment {
  double? total;
  double? discount;
  double? subtotal;
  double? totalTX;
  double? taxable;
  double? discount2;
  double? totalDue;
  double? totpaid;
  double? balance;
  TotalPayment(
      {this.balance,
      this.totpaid,
      this.discount,
      this.discount2,
      this.subtotal,
      this.taxable,
      this.total,
      this.totalDue,
      this.totalTX});
}
