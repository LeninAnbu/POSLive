class CustomerDetals {
  String? customerSeriesNo;
  String? autoId;
  String? docentry;
  String? custRefNum;
  String? taxCode;

  String? basedocnum;
  String? cardCode;

  String? reqFrom;
  String? reqTo;
  String? phNo;
  String? name;
  List<Address>? address;
  double? accBalance;
  String? tarNo;
  String? email;
  String? creditDays;
  String? paymentGroup;

  double? creditLimits;
  String? point;
  String? tinno;
  String? vatregno;
  String? invoicenum;
  String? uDeviceId;
  String? uOrderDate;
  String? uOrderType;
  String? uGPApproval;
  String? uReceivedTime;
  String? invoiceDate;
  double? totalPayment;

  String? U_rctCde;
  String? U_QRPath;
  String? U_QRValue;
  String? U_VfdIn;
  String? U_Zno;
  String? U_idate;
  String? U_itime;
  CustomerDetals(
      {this.name,
      this.custRefNum,
      this.customerSeriesNo,
      this.autoId,
      this.phNo,
      this.reqFrom,
      this.reqTo,
      this.U_QRPath,
      this.U_QRValue,
      this.U_VfdIn,
      this.U_Zno,
      this.U_idate,
      this.U_itime,
      this.U_rctCde,
      this.creditDays,
      this.creditLimits,
      this.paymentGroup,
      this.tinno,
      this.vatregno,
      this.docentry,
      this.cardCode,
      this.accBalance,
      this.point,
      this.address,
      this.tarNo,
      this.taxCode,
      this.email,
      this.invoicenum,
      this.invoiceDate,
      this.uDeviceId,
      this.uOrderDate,
      this.uOrderType,
      this.uGPApproval,
      this.uReceivedTime,
      this.totalPayment});
}

class Address {
  int? autoId;
  String? addresstype;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String billCity;
  String billstate;
  String billPincode;
  String billCountry;
  Address({
    this.autoId,
    this.address1,
    this.address2,
    this.address3,
    this.custcode,
    this.addresstype,
    required this.billCity,
    required this.billCountry,
    required this.billPincode,
    required this.billstate,
  });
}

class ShipAddress {
  int? autoId;
  String? addresstype;
  String? custcode;
  String? address1;
  String? address2;
  String? address3;
  String shipCity;
  String shipstate;
  String shipPincode;
  String shipCountry;
  ShipAddress({
    this.autoId,
    required this.address1,
    this.address2,
    this.address3,
    this.custcode,
    this.addresstype,
    required this.shipCity,
    required this.shipCountry,
    required this.shipPincode,
    required this.shipstate,
  });
}
