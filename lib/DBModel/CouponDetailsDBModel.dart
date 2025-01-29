const String couponDetailsMaster = "CouponDetailsT";

class CouponDetailT {
  static String status = 'status';
  static String doctype = 'doctype';
  static String cardcode = "cardcode";
  static String docentry = "docentry";
  static String coupontype = "coupontype";
  static String couponno = 'couponcode';
  static String couponamt = "couponamt";
}

class CouponDetailDB {
  String? docentry;
  String? status;
  String? cardcode;
  String? doctype;
  String? coupontype;
  String? couponno;
  double? couponamt;

  CouponDetailDB({
    required this.status,
    required this.doctype,
    required this.cardcode,
    required this.coupontype,
    this.docentry,
    required this.couponno,
    required this.couponamt,
  });

  Map<String, Object?> toMap() => {
        CouponDetailT.docentry: docentry,
        CouponDetailT.coupontype: coupontype,
        CouponDetailT.couponno: couponno,
        CouponDetailT.couponamt: couponamt,
        CouponDetailT.cardcode: cardcode,
        CouponDetailT.status: status,
        CouponDetailT.doctype: doctype
      };
}
