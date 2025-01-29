
class CouponDetModel {
  String? coupontype;
  String? docentry;
  String? couponcode;
  String? cardcode;
  String? doctype;
  String? status;
  String? docstatus;
  double? couponamt;
  int? createdUserID;
  int? updateduserid;
  String? lastupdateIp;

  CouponDetModel(
      {this.coupontype,
      this.createdUserID,
      this.couponcode,
      this.status,
      this.cardcode,
      this.docentry,
      this.doctype,
      this.lastupdateIp,
      this.couponamt,
      this.updateduserid});
}

class CouponTypeData {
  String couponTypeName;
  CouponTypeData({required this.couponTypeName});
}
