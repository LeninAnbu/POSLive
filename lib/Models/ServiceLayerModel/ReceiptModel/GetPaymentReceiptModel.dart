// To parse this JSON data, do
//
//     final GetIncomingReceiptModel = GetIncomingReceiptModelFromJson(jsonString);

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

  // String docCurrency;
  // dynamic checkAccount;
  // dynamic transferAccount;
  // dynamic transferDate;

  // String localCurrency;
  // int docRate;
  // String reference1;
  // dynamic reference2;
  // dynamic counterReference;
  String remarks;
  // String journalRemarks;
  // String splitTransaction;
  // dynamic contactPersonCode;
  // String applyVat;
  // DateTime taxDate;
  // int series;
  // dynamic bankCode;
  // dynamic bankAccount;
  // int discountPercent;
  // dynamic projectCode;
  // String currencyIsLocal;
  // int deductionPercent;
  // int deductionSum;
  // int cashSumFc;
  // double cashSumSys;
  // dynamic boeAccount;
  // int billOfExchangeAmount;
  // dynamic billofExchangeStatus;
  // int billOfExchangeAmountFc;
  // int billOfExchangeAmountSc;
  // dynamic billOfExchangeAgent;
  // dynamic wtCode;
  // int wtAmount;
  // int wtAmountFc;
  // int wtAmountSc;
  // dynamic wtAccount;
  // int wtTaxableAmount;
  // String proforma;
  // dynamic payToBankCode;
  // dynamic payToBankBranch;
  // dynamic payToBankAccountNo;
  // String payToCode;
  // dynamic payToBankCountry;
  // String isPayToBank;

  // String paymentPriority;
  // dynamic taxGroup;
  // int bankChargeAmount;
  // int bankChargeAmountInFc;
  // int bankChargeAmountInSc;
  // int underOverpaymentdifference;
  // int underOverpaymentdiffSc;
  // int wtBaseSum;
  // int wtBaseSumFc;
  // int wtBaseSumSc;
  // dynamic vatDate;
  // dynamic transactionCode;
  // String paymentType;
  // int transferRealAmount;
  // String docObjectCode;
  // String docTypte;
  // DateTime dueDate;
  // dynamic locationCode;
  // String cancelled;
  // String controlAccount;
  // int underOverpaymentdiffFc;
  // String authorizationStatus;
  // dynamic bplid;
  // dynamic bplName;
  // dynamic vatRegNum;
  // dynamic blanketAgreement;
  // String paymentByWtCertif;
  // dynamic cig;
  // dynamic cup;
  // dynamic attachmentEntry;
  // dynamic signatureInputMessage;
  // dynamic signatureDigest;
  // dynamic certificationNumber;
  // dynamic privateKeyVersion;
  // dynamic eDocExportFormat;
  // dynamic elecCommStatus;
  // dynamic elecCommMessage;
  // String splitVendorCreditRow;
  // String digitalPayments;
  // dynamic uRefSeries;
  // dynamic uPrnNumber;
  // String uDccIspl;
  // String uDccco;
  // dynamic uIntKey;
  // dynamic uRvc;
  // dynamic uVat;
  // dynamic uServType;
  // dynamic uRefNo;
  // List<dynamic> paymentCreditCards;
  // List<dynamic> paymentAccounts;
  // List<dynamic> paymentDocumentReferencesCollection;
  // BillOfExchange billOfExchange;
  // List<dynamic> withholdingTaxCertificatesCollection;
  // List<dynamic> electronicProtocols;
  // List<CashFlowAssignment> cashFlowAssignments;
  // List<dynamic> paymentsApprovalRequests;
  // List<dynamic> withholdingTaxDataWtxCollection;

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
    // required this.docCurrency,
    required this.cashSum,
    // required this.checkAccount,
    // required this.transferAccount,
    required this.transferSum,
    // required this.transferDate,
    required this.transferReference,
    // required this.localCurrency,
    // required this.docRate,
    // required this.reference1,
    // required this.reference2,
    // required this.counterReference,
    required this.remarks,
    // required this.journalRemarks,
    // required this.splitTransaction,
    // required this.contactPersonCode,
    // required this.applyVat,
    // required this.taxDate,
    // required this.series,
    // required this.bankCode,
    // required this.bankAccount,
    // required this.discountPercent,
    // required this.projectCode,
    // required this.currencyIsLocal,
    // required this.deductionPercent,
    // required this.deductionSum,
    // required this.cashSumFc,
    // required this.cashSumSys,
    // required this.boeAccount,
    // required this.billOfExchangeAmount,
    // required this.billofExchangeStatus,
    // required this.billOfExchangeAmountFc,
    // required this.billOfExchangeAmountSc,
    // required this.billOfExchangeAgent,
    // required this.wtCode,
    // required this.wtAmount,
    // required this.wtAmountFc,
    // required this.wtAmountSc,
    // required this.wtAccount,
    // required this.wtTaxableAmount,
    // required this.proforma,
    // required this.payToBankCode,
    // required this.payToBankBranch,
    // required this.payToBankAccountNo,
    // required this.payToCode,
    // required this.payToBankCountry,
    // required this.isPayToBank,
    required this.docEntry,
    // required this.paymentPriority,
    // required this.taxGroup,
    // required this.bankChargeAmount,
    // required this.bankChargeAmountInFc,
    // required this.bankChargeAmountInSc,
    // required this.underOverpaymentdifference,
    // required this.underOverpaymentdiffSc,
    // required this.wtBaseSum,
    // required this.wtBaseSumFc,
    // required this.wtBaseSumSc,
    // required this.vatDate,
    // required this.transactionCode,
    // required this.paymentType,
    // required this.transferRealAmount,
    // required this.docObjectCode,
    // required this.docTypte,
    // required this.dueDate,
    // required this.locationCode,
    // required this.cancelled,
    // required this.controlAccount,
    // required this.underOverpaymentdiffFc,
    // required this.authorizationStatus,
    // required this.bplid,
    // required this.bplName,
    // required this.vatRegNum,
    // required this.blanketAgreement,
    // required this.paymentByWtCertif,
    // required this.cig,
    // required this.cup,
    // required this.attachmentEntry,
    // required this.signatureInputMessage,
    // required this.signatureDigest,
    // required this.certificationNumber,
    // required this.privateKeyVersion,
    // required this.eDocExportFormat,
    // required this.elecCommStatus,
    // required this.elecCommMessage,
    // required this.splitVendorCreditRow,
    // required this.digitalPayments,
    // required this.uRefSeries,
    // required this.uPrnNumber,
    // required this.uDccIspl,
    // required this.uDccco,
    // required this.uIntKey,
    // required this.uRvc,
    // required this.uVat,
    // required this.uServType,
    // required this.uRefNo,
    required this.paymentChecks,
    required this.paymentInvoices,
    // required this.paymentCreditCards,
    // required this.paymentAccounts,
    // required this.paymentDocumentReferencesCollection,
    // required this.billOfExchange,
    // required this.withholdingTaxCertificatesCollection,
    // required this.electronicProtocols,
    // required this.cashFlowAssignments,
    // required this.paymentsApprovalRequests,
    // required this.withholdingTaxDataWtxCollection,
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
        printed: json["Printed"] ?? '',
        docDate: json["DocDate"] ?? '',
        cardCode: json["CardCode"] ?? '',
        cardName: json["CardName"] ?? '',
        cashSum: json["CashSum"]?.toDouble(),
        transferSum: json["TransferSum"] ?? 0,
        address: json["Address"] ?? '',
        cashAccount: json["CashAccount"] ?? '',
        remarks: json["Remarks"] ?? '',
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
  // docCurrency: json["DocCurrency"],

  // checkAccount: json["CheckAccount"],
  // transferAccount: json["TransferAccount"],
  // transferDate: json["TransferDate"],
  // localCurrency: json["LocalCurrency"],
  // docRate: json["DocRate"],
  // reference1: json["Reference1"],
  // reference2: json["Reference2"],
  // counterReference: json["CounterReference"],
  // remarks: json["Remarks"],
  // journalRemarks: json["JournalRemarks"],
  // splitTransaction: json["SplitTransaction"],
  // contactPersonCode: json["ContactPersonCode"],
  // applyVat: json["ApplyVAT"],
  // taxDate: DateTime.parse(json["TaxDate"]),
  // series: json["Series"],
  // bankCode: json["BankCode"],
  // bankAccount: json["BankAccount"],
  // discountPercent: json["DiscountPercent"],
  // projectCode: json["ProjectCode"],
  // currencyIsLocal: json["CurrencyIsLocal"],
  // deductionPercent: json["DeductionPercent"],
  // deductionSum: json["DeductionSum"],
  // cashSumFc: json["CashSumFC"],
  // cashSumSys: json["CashSumSys"]?.toDouble(),
  // boeAccount: json["BoeAccount"],
  // billOfExchangeAmount: json["BillOfExchangeAmount"],
  // billofExchangeStatus: json["BillofExchangeStatus"],
  // billOfExchangeAmountFc: json["BillOfExchangeAmountFC"],
  // billOfExchangeAmountSc: json["BillOfExchangeAmountSC"],
  // billOfExchangeAgent: json["BillOfExchangeAgent"],
  // wtCode: json["WTCode"],
  // wtAmount: json["WTAmount"],
  // wtAmountFc: json["WTAmountFC"],
  // wtAmountSc: json["WTAmountSC"],
  // wtAccount: json["WTAccount"],
  // wtTaxableAmount: json["WTTaxableAmount"],
  // proforma: json["Proforma"],
  // payToBankCode: json["PayToBankCode"],
  // payToBankBranch: json["PayToBankBranch"],
  // payToBankAccountNo: json["PayToBankAccountNo"],
  // payToCode: json["PayToCode"],
  // payToBankCountry: json["PayToBankCountry"],
  // isPayToBank: json["IsPayToBank"],
  // paymentPriority: json["PaymentPriority"],
  // taxGroup: json["TaxGroup"],
  // bankChargeAmount: json["BankChargeAmount"],
  // bankChargeAmountInFc: json["BankChargeAmountInFC"],
  // bankChargeAmountInSc: json["BankChargeAmountInSC"],
  // underOverpaymentdifference: json["UnderOverpaymentdifference"],
  // underOverpaymentdiffSc: json["UnderOverpaymentdiffSC"],
  // wtBaseSum: json["WtBaseSum"],
  // wtBaseSumFc: json["WtBaseSumFC"],
  // wtBaseSumSc: json["WtBaseSumSC"],
  // vatDate: json["VatDate"],
  // transactionCode: json["TransactionCode"],
  // paymentType: json["PaymentType"],
  // transferRealAmount: json["TransferRealAmount"],
  // docObjectCode: json["DocObjectCode"],
  // docTypte: json["DocTypte"],
  // dueDate: DateTime.parse(json["DueDate"]),
  // locationCode: json["LocationCode"],
  // cancelled: json["Cancelled"],
  // controlAccount: json["ControlAccount"],
  // underOverpaymentdiffFc: json["UnderOverpaymentdiffFC"],
  // authorizationStatus: json["AuthorizationStatus"],
  // bplid: json["BPLID"],
  // bplName: json["BPLName"],
  // vatRegNum: json["VATRegNum"],
  // blanketAgreement: json["BlanketAgreement"],
  // paymentByWtCertif: json["PaymentByWTCertif"],
  // cig: json["Cig"],
  // cup: json["Cup"],
  // attachmentEntry: json["AttachmentEntry"],
  // signatureInputMessage: json["SignatureInputMessage"],
  // signatureDigest: json["SignatureDigest"],
  // certificationNumber: json["CertificationNumber"],
  // privateKeyVersion: json["PrivateKeyVersion"],
  // eDocExportFormat: json["EDocExportFormat"],
  // elecCommStatus: json["ElecCommStatus"],
  // elecCommMessage: json["ElecCommMessage"],
  // splitVendorCreditRow: json["SplitVendorCreditRow"],
  // digitalPayments: json["DigitalPayments"],
  // uRefSeries: json["U_Ref_Series"],
  // uPrnNumber: json["U_PRN_Number"],
  // uDccIspl: json["U_DCC_ISPL"],
  // uDccco: json["U_DCCCO"],
  // uIntKey: json["U_IntKey"],
  // uRvc: json["U_RVC"],
  // uVat: json["U_VAT"],
  // uServType: json["U_ServType"],
  // uRefNo: json["U_RefNo"],
  // paymentCreditCards:
  //     List<dynamic>.from(json["PaymentCreditCards"].map((x) => x)),
  // paymentAccounts:
  //     List<dynamic>.from(json["PaymentAccounts"].map((x) => x)),
  // paymentDocumentReferencesCollection: List<dynamic>.from(
  //     json["PaymentDocumentReferencesCollection"].map((x) => x)),
  // billOfExchange: BillOfExchange.fromJson(json["BillOfExchange"]),
  // withholdingTaxCertificatesCollection: List<dynamic>.from(
  //     json["WithholdingTaxCertificatesCollection"].map((x) => x)),
  // electronicProtocols:
  //     List<dynamic>.from(json["ElectronicProtocols"].map((x) => x)),
  // cashFlowAssignments: List<CashFlowAssignment>.from(
  //     json["CashFlowAssignments"]
  //         .map((x) => CashFlowAssignment.fromJson(x))),
  // paymentsApprovalRequests:
  //     List<dynamic>.from(json["Payments_ApprovalRequests"].map((x) => x)),
  // withholdingTaxDataWtxCollection: List<dynamic>.from(
  //     json["WithholdingTaxDataWTXCollection"].map((x) => x)),

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
        // "DocCurrency": docCurrency,
        // "CashSum": cashSum,
        // "CheckAccount": checkAccount,
        // "TransferAccount": transferAccount,
        // "TransferSum": transferSum,
        // "TransferDate": transferDate,
        // "TransferReference": transferReference,
        // "LocalCurrency": localCurrency,
        // "DocRate": docRate,
        // "Reference1": reference1,
        // "Reference2": reference2,
        // "CounterReference": counterReference,
        // "Remarks": remarks,
        // "JournalRemarks": journalRemarks,
        // "SplitTransaction": splitTransaction,
        // "ContactPersonCode": contactPersonCode,
        // "ApplyVAT": applyVat,
        // "TaxDate": taxDate.toIso8601String(),
        // "Series": series,
        // "BankCode": bankCode,
        // "BankAccount": bankAccount,
        // "DiscountPercent": discountPercent,
        // "ProjectCode": projectCode,
        // "CurrencyIsLocal": currencyIsLocal,
        // "DeductionPercent": deductionPercent,
        // "DeductionSum": deductionSum,
        // "CashSumFC": cashSumFc,
        // "CashSumSys": cashSumSys,
        // "BoeAccount": boeAccount,
        // "BillOfExchangeAmount": billOfExchangeAmount,
        // "BillofExchangeStatus": billofExchangeStatus,
        // "BillOfExchangeAmountFC": billOfExchangeAmountFc,
        // "BillOfExchangeAmountSC": billOfExchangeAmountSc,
        // "BillOfExchangeAgent": billOfExchangeAgent,
        // "WTCode": wtCode,
        // "WTAmount": wtAmount,
        // "WTAmountFC": wtAmountFc,
        // "WTAmountSC": wtAmountSc,
        // "WTAccount": wtAccount,
        // "WTTaxableAmount": wtTaxableAmount,
        // "Proforma": proforma,
        // "PayToBankCode": payToBankCode,
        // "PayToBankBranch": payToBankBranch,
        // "PayToBankAccountNo": payToBankAccountNo,
        // "PayToCode": payToCode,
        // "PayToBankCountry": payToBankCountry,
        // "IsPayToBank": isPayToBank,
        "DocEntry": docEntry,
        // "PaymentPriority": paymentPriority,
        // "TaxGroup": taxGroup,
        // "BankChargeAmount": bankChargeAmount,
        // "BankChargeAmountInFC": bankChargeAmountInFc,
        // "BankChargeAmountInSC": bankChargeAmountInSc,
        // "UnderOverpaymentdifference": underOverpaymentdifference,
        // "UnderOverpaymentdiffSC": underOverpaymentdiffSc,
        // "WtBaseSum": wtBaseSum,
        // "WtBaseSumFC": wtBaseSumFc,
        // "WtBaseSumSC": wtBaseSumSc,
        // "VatDate": vatDate,
        // "TransactionCode": transactionCode,
        // "PaymentType": paymentType,
        // "TransferRealAmount": transferRealAmount,
        // "DocObjectCode": docObjectCode,
        // "DocTypte": docTypte,
        // "DueDate": dueDate.toIso8601String(),
        // "LocationCode": locationCode,
        // "Cancelled": cancelled,
        // "ControlAccount": controlAccount,
        // "UnderOverpaymentdiffFC": underOverpaymentdiffFc,
        // "AuthorizationStatus": authorizationStatus,
        // "BPLID": bplid,
        // "BPLName": bplName,
        // "VATRegNum": vatRegNum,
        // "BlanketAgreement": blanketAgreement,
        // "PaymentByWTCertif": paymentByWtCertif,
        // "Cig": cig,
        // "Cup": cup,
        // "AttachmentEntry": attachmentEntry,
        // "SignatureInputMessage": signatureInputMessage,
        // "SignatureDigest": signatureDigest,
        // "CertificationNumber": certificationNumber,
        // "PrivateKeyVersion": privateKeyVersion,
        // "EDocExportFormat": eDocExportFormat,
        // "ElecCommStatus": elecCommStatus,
        // "ElecCommMessage": elecCommMessage,
        // "SplitVendorCreditRow": splitVendorCreditRow,
        // "DigitalPayments": digitalPayments,
        // "U_Ref_Series": uRefSeries,
        // "U_PRN_Number": uPrnNumber,
        // "U_DCC_ISPL": uDccIspl,
        // "U_DCCCO": uDccco,
        // "U_IntKey": uIntKey,
        // "U_RVC": uRvc,
        // "U_VAT": uVat,
        // "U_ServType": uServType,
        // "U_RefNo": uRefNo,
        "PaymentChecks":
            List<PaymentCheckData>.from(paymentChecks.map((x) => x)),
        "PaymentInvoicess":
            List<dynamic>.from(paymentInvoices.map((x) => x.toJson())),
        // "PaymentCreditCards":
        //     List<dynamic>.from(paymentCreditCards.map((x) => x)),
        // "PaymentAccounts": List<dynamic>.from(paymentAccounts.map((x) => x)),
        // "PaymentDocumentReferencesCollection": List<dynamic>.from(
        //     paymentDocumentReferencesCollection.map((x) => x)),
        // "BillOfExchange": billOfExchange.toJson(),
        // "WithholdingTaxCertificatesCollection": List<dynamic>.from(
        //     withholdingTaxCertificatesCollection.map((x) => x)),
        // "ElectronicProtocols":
        //     List<dynamic>.from(electronicProtocols.map((x) => x)),
        // "CashFlowAssignments":
        //     List<dynamic>.from(cashFlowAssignments.map((x) => x.toJson())),
        // "Payments_ApprovalRequests":
        //     List<dynamic>.from(paymentsApprovalRequests.map((x) => x)),
        // "WithholdingTaxDataWTXCollection":
        //     List<dynamic>.from(withholdingTaxDataWtxCollection.map((x) => x)),
      };
}

class PaymentInvoices {
  int lineNum;
  int docEntry;
  int docNum;
  double sumApplied;
  // int appliedFc;
  // double appliedSys;
  // int docRate;
  int docLine;
  String invoiceType;
  double discountPercent;
  double paidSum;
  // int installmentId;
  // int witholdingTaxApplied;
  // int witholdingTaxAppliedFc;
  // int witholdingTaxAppliedSc;
  // dynamic linkDate;
  // dynamic distributionRule;
  // dynamic distributionRule2;
  // dynamic distributionRule3;
  // dynamic distributionRule4;
  // dynamic distributionRule5;
  // int totalDiscount;
  // int totalDiscountFc;
  // int totalDiscountSc;
  // int uInvExRate;

  PaymentInvoices({
    required this.lineNum,
    required this.docEntry,
    required this.docNum,
    required this.sumApplied,
    // required this.appliedFc,
    // required this.appliedSys,
    // required this.docRate,
    required this.docLine,
    required this.invoiceType,
    required this.discountPercent,
    required this.paidSum,
    // required this.installmentId,
    // required this.witholdingTaxApplied,
    // required this.witholdingTaxAppliedFc,
    // required this.witholdingTaxAppliedSc,
    // required this.linkDate,
    // required this.distributionRule,
    // required this.distributionRule2,
    // required this.distributionRule3,
    // required this.distributionRule4,
    // required this.distributionRule5,
    // required this.totalDiscount,
    // required this.totalDiscountFc,
    // required this.totalDiscountSc,
    // required this.uInvExRate,
  });

  factory PaymentInvoices.fromJson(Map<String, dynamic> json) =>
      PaymentInvoices(
        lineNum: json["LineNum"] ?? null,
        docEntry: json["DocEntry"] ?? 0,
        docNum: json["DocNum"] ?? 0,
        sumApplied: json["SumApplied"]?.toDouble(),
        // appliedFc: json["AppliedFC"],
        // appliedSys: json["AppliedSys"]?.toDouble(),
        // docRate: json["DocRate"],
        docLine: json["DocLine"] ?? null,
        invoiceType: json["InvoiceType"] ?? '',
        discountPercent: json["DiscountPercent"] ?? 0,
        paidSum: json["PaidSum"] ?? 0,
        // installmentId: json["InstallmentId"],
        // witholdingTaxApplied: json["WitholdingTaxApplied"],
        // witholdingTaxAppliedFc: json["WitholdingTaxAppliedFC"],
        // witholdingTaxAppliedSc: json["WitholdingTaxAppliedSC"],
        // linkDate: json["LinkDate"],
        // distributionRule: json["DistributionRule"],
        // distributionRule2: json["DistributionRule2"],
        // distributionRule3: json["DistributionRule3"],
        // distributionRule4: json["DistributionRule4"],
        // distributionRule5: json["DistributionRule5"],
        // totalDiscount: json["TotalDiscount"],
        // totalDiscountFc: json["TotalDiscountFC"],
        // totalDiscountSc: json["TotalDiscountSC"],
        // uInvExRate: json["U_InvExRate"],
      );

  Map<String, dynamic> toJson() => {
        "LineNum": lineNum,
        "DocEntry": docEntry,
        "DocNum": docNum,
        "SumApplied": sumApplied,
        // "AppliedFC": appliedFc,
        // "AppliedSys": appliedSys,
        // "DocRate": docRate,
        "DocLine": docLine,
        "InvoiceType": invoiceType,
        "DiscountPercent": discountPercent,
        "PaidSum": paidSum,
        // "InstallmentId": installmentId,
        // "WitholdingTaxApplied": witholdingTaxApplied,
        // "WitholdingTaxAppliedFC": witholdingTaxAppliedFc,
        // "WitholdingTaxAppliedSC": witholdingTaxAppliedSc,
        // "LinkDate": linkDate,
        // "DistributionRule": distributionRule,
        // "DistributionRule2": distributionRule2,
        // "DistributionRule3": distributionRule3,
        // "DistributionRule4": distributionRule4,
        // "DistributionRule5": distributionRule5,
        // "TotalDiscount": totalDiscount,
        // "TotalDiscountFC": totalDiscountFc,
        // "TotalDiscountSC": totalDiscountSc,
        // "U_InvExRate": uInvExRate,
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
