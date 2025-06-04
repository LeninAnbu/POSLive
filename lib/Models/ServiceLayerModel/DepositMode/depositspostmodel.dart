import '../ErrorModell/ErrorModelSl.dart';

class DepositsModel {
  String odataMetadata;
  int depositNumber;
  int absEntry;
  String depositType;
  String depositDate;
  String depositCurrency;

  String depositAccount;
  ErrorModel? error;

  String journalRemarks;
  double totalLc;

  String allocationAccount;
  String errorMsg;
  int? statusCode;

  DepositsModel(
      {required this.odataMetadata,
      this.error,
      required this.depositNumber,
      required this.absEntry,
      required this.depositType,
      required this.errorMsg,
      required this.depositDate,
      required this.depositCurrency,
      required this.depositAccount,
      required this.allocationAccount,
      required this.journalRemarks,
      required this.totalLc,
      this.statusCode});

  factory DepositsModel.fromJson(Map<String, dynamic> json, int stsCode) =>
      DepositsModel(
        odataMetadata: json["odata.metadata"] ?? '',
        depositNumber: json["DepositNumber"] ?? 0,
        absEntry: json["AbsEntry"],
        depositType: json["DepositType"],
        statusCode: stsCode,
        errorMsg: '',
        depositDate: json["DepositDate"],
        depositCurrency: json["DepositCurrency"],
        depositAccount: json["DepositAccount"],
        journalRemarks: json["JournalRemarks"],
        allocationAccount: json["AllocationAccount"],
        totalLc: json["TotalLC"],
      );
  factory DepositsModel.issue(Map<String, dynamic> json, int statuscode) {
    return DepositsModel(
        odataMetadata: '',
        depositNumber: 0,
        error: ErrorModel.fromJson(json['error']),
        absEntry: 0,
        depositType: '',
        errorMsg: '',
        statusCode: statuscode,
        depositDate: '',
        depositCurrency: '',
        depositAccount: '',
        allocationAccount: '',
        journalRemarks: '',
        totalLc: 0);
  }

  factory DepositsModel.expError(String json, int statuscode) {
    return DepositsModel(
        odataMetadata: '',
        depositNumber: 0,
        error: null,
        statusCode: statuscode,
        absEntry: 0,
        depositType: '',
        depositDate: '',
        depositCurrency: '',
        depositAccount: '',
        allocationAccount: '',
        errorMsg: json,
        journalRemarks: '',
        totalLc: 0);
  }
  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "DepositNumber": depositNumber,
        "AbsEntry": absEntry,
        "DepositType": depositType,
        "DepositDate": depositDate,
        "DepositCurrency": depositCurrency,
        "DepositAccount": depositAccount,
        "JournalRemarks": journalRemarks,
        "TotalLC": totalLc,
        "AllocationAccount": allocationAccount,
      };
}
