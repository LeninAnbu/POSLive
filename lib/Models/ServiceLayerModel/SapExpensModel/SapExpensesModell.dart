import '../ErrorModell/ErrorModelSl.dart';

class SapExpenseModel {
  int? docEntry;
  int? docNum;
  ErrorModel? error;
  int? statusCode;
  String? exceptionmsg;

  SapExpenseModel({
    required this.docEntry,
    required this.docNum,
    this.error,
    this.exceptionmsg,
    this.statusCode,
  });

  factory SapExpenseModel.fromJson(Map<String, dynamic> json, int stsCode) =>
      SapExpenseModel(
        docNum: json["DocNum"],
        docEntry: json["DocEntry"],
        statusCode: stsCode,
      );
  factory SapExpenseModel.issue(Map<String, dynamic> json, int stsCode) =>
      SapExpenseModel(
        docNum: null,
        docEntry: null,
        statusCode: stsCode,
        error: ErrorModel.fromJson(json['error']),
      );

  factory SapExpenseModel.error(String e, int stsCode) => SapExpenseModel(
        docNum: null,
        docEntry: null,
        statusCode: stsCode,
        exceptionmsg: e,
        error: null,
      );
  Map<String, dynamic> toJson() => {
        "DocNum": docNum,
        "DocEntry": docEntry,
      };
}

class BillOfExchange {
  BillOfExchange();

  factory BillOfExchange.fromJson(Map<String, dynamic> json) =>
      BillOfExchange();

  Map<String, dynamic> toJson() => {};
}

class PaymentCheck {
  int lineNum;
  DateTime dueDate;
  int checkNumber;
  String bankCode;
  String branch;
  String accounttNum;
  dynamic details;
  String trnsfrable;
  int checkSum;
  String currency;
  String countryCode;
  int checkAbsEntry;
  String checkAccount;
  String manualCheck;
  dynamic fiscalId;
  dynamic originallyIssuedBy;
  String endorse;
  dynamic endorsableCheckNo;

  PaymentCheck({
    required this.lineNum,
    required this.dueDate,
    required this.checkNumber,
    required this.bankCode,
    required this.branch,
    required this.accounttNum,
    required this.details,
    required this.trnsfrable,
    required this.checkSum,
    required this.currency,
    required this.countryCode,
    required this.checkAbsEntry,
    required this.checkAccount,
    required this.manualCheck,
    required this.fiscalId,
    required this.originallyIssuedBy,
    required this.endorse,
    required this.endorsableCheckNo,
  });

  factory PaymentCheck.fromJson(Map<String, dynamic> json) => PaymentCheck(
        lineNum: json["LineNum"],
        dueDate: DateTime.parse(json["DueDate"]),
        checkNumber: json["CheckNumber"],
        bankCode: json["BankCode"],
        branch: json["Branch"],
        accounttNum: json["AccounttNum"],
        details: json["Details"],
        trnsfrable: json["Trnsfrable"],
        checkSum: json["CheckSum"],
        currency: json["Currency"],
        countryCode: json["CountryCode"],
        checkAbsEntry: json["CheckAbsEntry"],
        checkAccount: json["CheckAccount"],
        manualCheck: json["ManualCheck"],
        fiscalId: json["FiscalID"],
        originallyIssuedBy: json["OriginallyIssuedBy"],
        endorse: json["Endorse"],
        endorsableCheckNo: json["EndorsableCheckNo"],
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DueDate":
            "${dueDate.year.toString().padLeft(4, '0')}-${dueDate.month.toString().padLeft(2, '0')}-${dueDate.day.toString().padLeft(2, '0')}",
        "CheckNumber": checkNumber,
        "BankCode": bankCode,
        "Branch": branch,
        "AccounttNum": accounttNum,
        "Details": details,
        "Trnsfrable": trnsfrable,
        "CheckSum": checkSum,
        "Currency": currency,
        "CountryCode": countryCode,
        "CheckAbsEntry": checkAbsEntry,
        "CheckAccount": checkAccount,
        "ManualCheck": manualCheck,
        "FiscalID": fiscalId,
        "OriginallyIssuedBy": originallyIssuedBy,
        "Endorse": endorse,
        "EndorsableCheckNo": endorsableCheckNo,
      };
}

class PaymentInvoice {
  int lineNum;
  int docEntry;
  int sumApplied;
  int appliedFc;
  double appliedSys;
  int docRate;
  int docLine;
  String invoiceType;
  int discountPercent;
  int paidSum;
  int installmentId;
  int witholdingTaxApplied;
  int witholdingTaxAppliedFc;
  int witholdingTaxAppliedSc;
  dynamic linkDate;
  dynamic distributionRule;
  dynamic distributionRule2;
  dynamic distributionRule3;
  dynamic distributionRule4;
  dynamic distributionRule5;
  int totalDiscount;
  int totalDiscountFc;
  int totalDiscountSc;

  PaymentInvoice({
    required this.lineNum,
    required this.docEntry,
    required this.sumApplied,
    required this.appliedFc,
    required this.appliedSys,
    required this.docRate,
    required this.docLine,
    required this.invoiceType,
    required this.discountPercent,
    required this.paidSum,
    required this.installmentId,
    required this.witholdingTaxApplied,
    required this.witholdingTaxAppliedFc,
    required this.witholdingTaxAppliedSc,
    required this.linkDate,
    required this.distributionRule,
    required this.distributionRule2,
    required this.distributionRule3,
    required this.distributionRule4,
    required this.distributionRule5,
    required this.totalDiscount,
    required this.totalDiscountFc,
    required this.totalDiscountSc,
  });

  factory PaymentInvoice.fromJson(Map<String, dynamic> json) => PaymentInvoice(
        lineNum: json["LineNum"],
        docEntry: json["DocEntry"],
        sumApplied: json["SumApplied"],
        appliedFc: json["AppliedFC"],
        appliedSys: json["AppliedSys"]?.toDouble(),
        docRate: json["DocRate"],
        docLine: json["DocLine"],
        invoiceType: json["InvoiceType"],
        discountPercent: json["DiscountPercent"],
        paidSum: json["PaidSum"],
        installmentId: json["InstallmentId"],
        witholdingTaxApplied: json["WitholdingTaxApplied"],
        witholdingTaxAppliedFc: json["WitholdingTaxAppliedFC"],
        witholdingTaxAppliedSc: json["WitholdingTaxAppliedSC"],
        linkDate: json["LinkDate"],
        distributionRule: json["DistributionRule"],
        distributionRule2: json["DistributionRule2"],
        distributionRule3: json["DistributionRule3"],
        distributionRule4: json["DistributionRule4"],
        distributionRule5: json["DistributionRule5"],
        totalDiscount: json["TotalDiscount"],
        totalDiscountFc: json["TotalDiscountFC"],
        totalDiscountSc: json["TotalDiscountSC"],
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "SumApplied": sumApplied,
        "AppliedFC": appliedFc,
        "AppliedSys": appliedSys,
        "DocRate": docRate,
        "DocLine": docLine,
        "InvoiceType": invoiceType,
        "DiscountPercent": discountPercent,
        "PaidSum": paidSum,
        "InstallmentId": installmentId,
        "WitholdingTaxApplied": witholdingTaxApplied,
        "WitholdingTaxAppliedFC": witholdingTaxAppliedFc,
        "WitholdingTaxAppliedSC": witholdingTaxAppliedSc,
        "LinkDate": linkDate,
        "DistributionRule": distributionRule,
        "DistributionRule2": distributionRule2,
        "DistributionRule3": distributionRule3,
        "DistributionRule4": distributionRule4,
        "DistributionRule5": distributionRule5,
        "TotalDiscount": totalDiscount,
        "TotalDiscountFC": totalDiscountFc,
        "TotalDiscountSC": totalDiscountSc,
      };
}
