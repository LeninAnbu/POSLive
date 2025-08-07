class GetIncomingReceiptModel {
  String odataMetadata;
  String odataEtag;
  int docNum;
  int stsCode;
  String docType;
  String handWritten;
  String printed;
  String docDate;
  String cardCode;
  String cardName;
  String address;
  String cashAccount;
  List<PaymentInvoices> paymentInvoices = [];
  int docEntry;
  List<PaymentCheckData> paymentChecks;
  double cashSum;
  String transferReference;
  double transferSum;

  String counterReference;
  String remarks;

  GetIncomingReceiptModel({
    required this.odataMetadata,
    required this.odataEtag,
    required this.stsCode,
    required this.docNum,
    required this.docType,
    required this.handWritten,
    required this.printed,
    required this.docDate,
    required this.cardCode,
    required this.cardName,
    required this.address,
    required this.cashAccount,
    required this.cashSum,
    required this.transferSum,
    required this.transferReference,
    required this.counterReference,
    required this.remarks,
    required this.docEntry,
    required this.paymentChecks,
    required this.paymentInvoices,
  });

  factory GetIncomingReceiptModel.fromJson(
      Map<String, dynamic> json, int stsCode) {
    if (stsCode >= 200 && stsCode <= 210) {
      return GetIncomingReceiptModel(
        stsCode: stsCode,
        odataMetadata: json["odata.metadata"] ?? '',
        odataEtag: json["odata.etag"] ?? '',
        docNum: json["DocNum"] ?? 0,
        docEntry: json["DocEntry"] ?? 0,
        docType: json["DocType"] ?? '',
        handWritten: json["HandWritten"] ?? '',
        counterReference: json["CounterReference"] ?? '',
        printed: json["Printed"] ?? '',
        docDate: json["DocDate"] ?? '',
        cardCode: json["CardCode"] ?? '',
        cardName: json["CardName"] ?? '',
        cashSum: json["CashSum"]?.toDouble(),
        transferSum: json["TransferSum"] ?? 0,
        address: json["Address"] ?? '',
        cashAccount: json["CashAccount"] ?? '',
        remarks: json["JournalRemarks"] ?? '',
        transferReference: json["TransferReference"] ?? '',
        paymentChecks: List<PaymentCheckData>.from(
            json["PaymentChecks"].map((x) => PaymentCheckData.fromJson(x))),
        paymentInvoices: List<PaymentInvoices>.from(
            json["PaymentInvoices"].map((x) => PaymentInvoices.fromJson(x))),
      );
    } else {
      return GetIncomingReceiptModel(
          stsCode: stsCode,
          odataMetadata: '',
          odataEtag: '',
          remarks: '',
          transferReference: '',
          counterReference: '',
          docNum: 0,
          docEntry: 0,
          docType: '',
          handWritten: '',
          printed: '',
          docDate: '',
          cashSum: 0,
          transferSum: 0,
          cardCode: '',
          cardName: '',
          paymentChecks: [],
          address: '',
          paymentInvoices: [],
          cashAccount: '');
    }
  }

  Map<String, dynamic> toJson() => {
        "odata.metadata": odataMetadata,
        "odata.etag": odataEtag,
        "DocNum": docNum,
        "DocType": docType,
        "HandWritten": handWritten,
        "Printed": printed,
        "DocDate": docDate,
        "CardCode": cardCode,
        "CardName": cardName,
        "Address": address,
        "CashAccount": cashAccount,
        "DocEntry": docEntry,
        "PaymentChecks":
            List<PaymentCheckData>.from(paymentChecks.map((x) => x)),
        "PaymentInvoicess":
            List<dynamic>.from(paymentInvoices.map((x) => x.toJson())),
      };
}

class PaymentInvoices {
  int lineNum;
  int docEntry;
  int docNum;
  double sumApplied;

  int docLine;
  String invoiceType;
  double discountPercent;
  double paidSum;

  PaymentInvoices({
    required this.lineNum,
    required this.docEntry,
    required this.docNum,
    required this.sumApplied,
    required this.docLine,
    required this.invoiceType,
    required this.discountPercent,
    required this.paidSum,
  });

  factory PaymentInvoices.fromJson(Map<String, dynamic> json) =>
      PaymentInvoices(
        lineNum: json["LineNum"] ?? null,
        docEntry: json["DocEntry"] ?? 0,
        docNum: json["DocNum"] ?? 0,
        sumApplied: json["SumApplied"]?.toDouble(),
        docLine: json["DocLine"] ?? null,
        invoiceType: json["InvoiceType"] ?? '',
        discountPercent: json["DiscountPercent"] ?? 0,
        paidSum: json["PaidSum"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "DocNum": docNum,
        "SumApplied": sumApplied,
        "DocLine": docLine,
        "InvoiceType": invoiceType,
        "DiscountPercent": discountPercent,
        "PaidSum": paidSum,
      };
}

class PaymentCheckData {
  int lineNum;
  String dueDate;
  int checkNumber;
  String bankCode;
  String branch;
  String accounttNum;
  String details;
  String trnsfrable;
  double checkSum;
  String currency;
  String countryCode;
  int checkAbsEntry;
  String checkAccount;

  PaymentCheckData({
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
  });

  factory PaymentCheckData.fromJson(Map<String, dynamic> json) =>
      PaymentCheckData(
        lineNum: json["LineNum"] ?? null,
        dueDate: json["DueDate"] ?? '',
        checkNumber: json["CheckNumber"] ?? 0,
        bankCode: json["BankCode"] ?? '',
        branch: json["Branch"] ?? '',
        accounttNum: json["AccounttNum"] ?? '',
        details: json["Details"] ?? '',
        trnsfrable: json["Trnsfrable"] ?? '',
        checkSum: json["CheckSum"] ?? 0,
        currency: json["Currency"] ?? '',
        countryCode: json["CountryCode"] ?? '',
        checkAbsEntry: json["CheckAbsEntry"] ?? 0,
        checkAccount: json["CheckAccount"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DueDate": dueDate,
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
      };
}
