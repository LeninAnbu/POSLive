import '../ErrorModell/ErrorModelSl.dart';

class SapReceiptModel {
  int? stscode;
  ErrorModel? error;
  String? exception;

  int? docNum;
  int? docEntry;

  List<PaymentCheck>? paymentChecks;
  List<PaymentInvoice>? paymentInvoices;

  SapReceiptModel({
    required this.stscode,
    required this.error,
    this.exception,
    required this.docNum,
    required this.docEntry,
    required this.paymentChecks,
    required this.paymentInvoices,
  });

  factory SapReceiptModel.fromJson(Map<String?, dynamic> json, int? stsCodee) =>
      SapReceiptModel(
        stscode: stsCodee,
        error: null,
        docNum: json["DocNum"],
        docEntry: json["DocEntry"],
        paymentChecks: List<PaymentCheck>.from(
            json["PaymentChecks"].map((x) => PaymentCheck.fromJson(x))),
        paymentInvoices: List<PaymentInvoice>.from(
            json["PaymentInvoices"].map((x) => PaymentInvoice.fromJson(x))),
      );

  factory SapReceiptModel.issue(Map<String?, dynamic> json, int? stsCodee) =>
      SapReceiptModel(
        docNum: null,
        docEntry: null,
        paymentChecks: null,
        paymentInvoices: null,
        stscode: stsCodee,
        error: ErrorModel.fromJson(json['error']),
      );
  factory SapReceiptModel.exception(String e, int stsCode) => SapReceiptModel(
      docNum: null,
      docEntry: null,
      paymentChecks: null,
      paymentInvoices: null,
      stscode: stsCode,
      error: null,
      exception: e);

  Map<String?, dynamic> toJson() => {
        "DocNum": docNum,
        "DocEntry": docEntry,
        "PaymentChecks":
            List<dynamic>.from(paymentChecks!.map((x) => x.toJson2())),
        "PaymentInvoices":
            List<dynamic>.from(paymentInvoices!.map((x) => x.toJson3())),
      };
}

class BillOfExchange {
  BillOfExchange();

  factory BillOfExchange.fromJson(Map<String?, dynamic> json) =>
      BillOfExchange();

  Map<String?, dynamic> toJson() => {};
}

class PaymentCheck {
  int? lineNum;

  PaymentCheck({
    required this.lineNum,
  });

  factory PaymentCheck.fromJson(Map<String?, dynamic> json) => PaymentCheck(
        lineNum: json["LineNum"],
      );

  Map<String?, dynamic> toJson2() => {
        "LineNum": lineNum,
      };
}

class PaymentInvoice {
  int? lineNum;
  int? docEntry;
  double? sumApplied;

  PaymentInvoice({
    required this.lineNum,
    required this.docEntry,
    required this.sumApplied,
  });

  factory PaymentInvoice.fromJson(Map<String?, dynamic> json) => PaymentInvoice(
        lineNum: json["LineNum"],
        docEntry: json["DocEntry"],
        sumApplied: json["SumApplied"],
      );

  Map<String?, dynamic> toJson3() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "SumApplied": sumApplied,
      };
}
