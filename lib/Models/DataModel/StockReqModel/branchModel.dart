const String draftCustomerTable = "Draft Customer";

class ShipAddresss {
  String? billAddress;
  String? billCity;
  String? billstate;
  String? billPincode;
  String? billCountry;

  ShipAddresss({
    required this.billAddress,
    required this.billCity,
    required this.billCountry,
    required this.billPincode,
    required this.billstate,
  });
}
