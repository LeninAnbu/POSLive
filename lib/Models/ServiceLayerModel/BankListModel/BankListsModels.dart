class BankListModels {
  String expMsg;
  int stsCode;
  String odataMetadata;
  List<BankListValue> listValue;
  String odataNextLink;

  BankListModels({
    required this.odataMetadata,
    required this.expMsg,
    required this.stsCode,
    required this.listValue,
    required this.odataNextLink,
  });

  factory BankListModels.fromJson(Map<String, dynamic> json, int statusCode) {
    return BankListModels(
      stsCode: statusCode,
      expMsg: '',
      odataMetadata: json["odata.metadata"],
      listValue: List<BankListValue>.from(
          json["value"].map((x) => BankListValue.fromJson(x))),
      odataNextLink: json["odata.nextLink"],
    );
  }

  factory BankListModels.issue(String json, int statuscode) {
    return BankListModels(
        stsCode: statuscode,
        expMsg: json,
        odataMetadata: '',
        listValue: [],
        odataNextLink: '');
  }

  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "value": List<BankListValue>.from(listValue.map((x) => x.toJson())),
        "odata.nextLink": odataNextLink,
      };
}

class BankListValue {
  String? bankCode;
  String? bankName;
  String? accountforOutgoingChecks;
  String? branchforOutgoingChecks;
  int? nextCheckNumber;
  dynamic swiftNo;
  dynamic iban;
  String? countryCode;
  String? postOffice;
  int? absoluteEntry;
  int? defaultBankAccountKey;
  String? digitalPayments;

  BankListValue({
    required this.bankCode,
    required this.bankName,
    required this.accountforOutgoingChecks,
    required this.branchforOutgoingChecks,
    required this.nextCheckNumber,
    required this.swiftNo,
    required this.iban,
    required this.countryCode,
    required this.postOffice,
    required this.absoluteEntry,
    required this.defaultBankAccountKey,
    required this.digitalPayments,
  });

  factory BankListValue.fromJson(Map<String, dynamic> json) => BankListValue(
        bankCode: json["BankCode"] ?? '',
        bankName: json["BankName"] ?? '',
        accountforOutgoingChecks: json["AccountforOutgoingChecks"] ?? '',
        branchforOutgoingChecks: json["BranchforOutgoingChecks"] ?? '',
        nextCheckNumber: json["NextCheckNumber"] ?? 0,
        swiftNo: json["SwiftNo"] ?? '',
        iban: json["IBAN"] ?? '',
        countryCode: json["CountryCode"] ?? '',
        postOffice: json["PostOffice"] ?? '',
        absoluteEntry: json["AbsoluteEntry"] ?? 0,
        defaultBankAccountKey: json["DefaultBankAccountKey"] ?? 0,
        digitalPayments: json["DigitalPayments"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "BankCode": bankCode,
        "BankName": bankName,
        "AccountforOutgoingChecks": accountforOutgoingChecks,
        "BranchforOutgoingChecks": branchforOutgoingChecks,
        "NextCheckNumber": nextCheckNumber,
        "SwiftNo": swiftNo,
        "IBAN": iban,
        "CountryCode": countryCode,
        "PostOffice": postOffice,
        "AbsoluteEntry": absoluteEntry,
        "DefaultBankAccountKey": defaultBankAccountKey,
        "DigitalPayments": digitalPayments,
      };
}
