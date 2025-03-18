import '../ServiceLayerModel/ErrorModell/ErrorModelSl.dart';

class GetExpnseDetModel {
  int? docNum;
  int? stsCode;
  String? docDate;
  String? errorMsg;
  String? reference1;
  ErrorModel? error;
  double? cashSum;
  String? remarks;
  String? journalRemarks;
  String? address;

// Address
  int? docEntry;
  String? uRVC;
  String? taxCode;
  String? distRule;
  String? projectCode;
  String counterReference;

  List<PaymentAccount> paymentAccounts;

  GetExpnseDetModel({
    required this.docNum,
    required this.docDate,
    required this.cashSum,
    required this.stsCode,
    required this.address,
    this.errorMsg,
    this.error,
    required this.remarks,
    required this.counterReference,
    required this.reference1,
    required this.journalRemarks,
    required this.docEntry,
    required this.distRule,
    required this.projectCode,
    required this.taxCode,
    required this.uRVC,
    required this.paymentAccounts,
  });

  factory GetExpnseDetModel.fromJson(Map<String, dynamic> json, int stsCode) =>
      GetExpnseDetModel(
        stsCode: stsCode,
        docNum: json["DocNum"],
        docDate: json["DocDate"] ?? '',
        reference1: json["Reference1"] ?? '',
        address: json["Address"] ?? '',

        cashSum: json["CashSum"] ?? 0,
        remarks: json["Remarks"] ?? '',
        journalRemarks: json["JournalRemarks"] ?? '',
        counterReference: json["CounterReference"] ?? '',

        projectCode: json["ProjectCode"] ?? '',
        uRVC: json["U_RVC"] ?? '',
        distRule: json["ProfitCenter"] ?? '',
        taxCode: json["VatGroup"] ?? '',

        docEntry: json["DocEntry"],
        //  List<InvoiceDocumentLine>.from(
        // json["DocumentLines"].map((x) => InvoiceDocumentLine.fromJson(x))),
        paymentAccounts: List<PaymentAccount>.from(
            json["PaymentAccounts"].map((x) => PaymentAccount.fromJson(x))),
      );
  factory GetExpnseDetModel.issue(Map<String, dynamic> json, int stsCode) =>
      GetExpnseDetModel(
          stsCode: stsCode,
          docNum: null,
          docDate: '',
          errorMsg: '',
          reference1: '',
          address: '',
          taxCode: '',
          projectCode: '',
          counterReference: '',
          distRule: '',
          uRVC: '',
          cashSum: null,
          error: ErrorModel.fromJson(json['error']),
          remarks: '',
          journalRemarks: '',
          docEntry: null,
          paymentAccounts: []);
  factory GetExpnseDetModel.exception(String e, int stsCode) =>
      GetExpnseDetModel(
          stsCode: stsCode,
          docNum: null,
          docDate: '',
          errorMsg: e,
          cashSum: null,
          reference1: '',
          taxCode: '',
          address: '',
          projectCode: '',
          distRule: '',
          counterReference: '',
          uRVC: '',
          remarks: '',
          journalRemarks: '',
          docEntry: null,
          paymentAccounts: []);

  // Map<String, dynamic> toJson() => {
  //     "odata.metadata": odataMetadata,
  //     "odata.etag": odataEtag,
  //     "DocNum": docNum,
  //     "DocType": docType,
  //     "HandWritten": handWritten,
  //     "Printed": printed,
  //     "DocDate": docDate.toIso8601String(),
  //     "CardCode": cardCode,
  //     "CardName": cardName,
  //     "Address": address,
  //     "CashAccount": cashAccount,
  //     "DocCurrency": docCurrency,
  //     "CashSum": cashSum,
  //     "CheckAccount": checkAccount,
  //     "TransferAccount": transferAccount,
  //     "TransferSum": transferSum,
  //     "TransferDate": transferDate,
  //     "TransferReference": transferReference,
  //     "LocalCurrency": localCurrency,
  //     "DocRate": docRate,
  //     "Reference1": reference1,
  //     "Reference2": reference2,
  // "CounterReference": counterReference,
  //     "Remarks": remarks,
  //     "JournalRemarks": journalRemarks,
  //     "SplitTransaction": splitTransaction,
  //     "ContactPersonCode": contactPersonCode,
  //     "ApplyVAT": applyVat,
  //     "TaxDate": taxDate.toIso8601String(),
  //     "Series": series,
  //     "BankCode": bankCode,
  //     "BankAccount": bankAccount,
  //     "DiscountPercent": discountPercent,
  //     "ProjectCode": projectCode,
  //     "CurrencyIsLocal": currencyIsLocal,
  //     "DeductionPercent": deductionPercent,
  //     "DeductionSum": deductionSum,
  //     "CashSumFC": cashSumFc,
  //     "CashSumSys": cashSumSys,
  //     "BoeAccount": boeAccount,
  //     "BillOfExchangeAmount": billOfExchangeAmount,
  //     "BillofExchangeStatus": billofExchangeStatus,
  //     "BillOfExchangeAmountFC": billOfExchangeAmountFc,
  //     "BillOfExchangeAmountSC": billOfExchangeAmountSc,
  //     "BillOfExchangeAgent": billOfExchangeAgent,
  //     "WTCode": wtCode,
  //     "WTAmount": wtAmount,
  //     "WTAmountFC": wtAmountFc,
  //     "WTAmountSC": wtAmountSc,
  //     "WTAccount": wtAccount,
  //     "WTTaxableAmount": wtTaxableAmount,
  //     "Proforma": proforma,
  //     "PayToBankCode": payToBankCode,
  //     "PayToBankBranch": payToBankBranch,
  //     "PayToBankAccountNo": payToBankAccountNo,
  //     "PayToCode": payToCode,
  //     "PayToBankCountry": payToBankCountry,
  //     "IsPayToBank": isPayToBank,
  //     "DocEntry": docEntry,
  //     "PaymentPriority": paymentPriority,
  //     "TaxGroup": taxGroup,
  //     "BankChargeAmount": bankChargeAmount,
  //     "BankChargeAmountInFC": bankChargeAmountInFc,
  //     "BankChargeAmountInSC": bankChargeAmountInSc,
  //     "UnderOverpaymentdifference": underOverpaymentdifference,
  //     "UnderOverpaymentdiffSC": underOverpaymentdiffSc,
  //     "WtBaseSum": wtBaseSum,
  //     "WtBaseSumFC": wtBaseSumFc,
  //     "WtBaseSumSC": wtBaseSumSc,
  //     "VatDate": vatDate,
  //     "TransactionCode": transactionCode,
  //     "PaymentType": paymentType,
  //     "TransferRealAmount": transferRealAmount,
  //     "DocObjectCode": docObjectCode,
  //     "DocTypte": docTypte,
  //     "DueDate": dueDate.toIso8601String(),
  //     "LocationCode": locationCode,
  //     "Cancelled": cancelled,
  //     "ControlAccount": controlAccount,
  //     "UnderOverpaymentdiffFC": underOverpaymentdiffFc,
  //     "AuthorizationStatus": authorizationStatus,
  //     "BPLID": bplid,
  //     "BPLName": bplName,
  //     "VATRegNum": vatRegNum,
  //     "BlanketAgreement": blanketAgreement,
  //     "PaymentByWTCertif": paymentByWtCertif,
  //     "Cig": cig,
  //     "Cup": cup,
  //     "AttachmentEntry": attachmentEntry,
  //     "SignatureInputMessage": signatureInputMessage,
  //     "SignatureDigest": signatureDigest,
  //     "CertificationNumber": certificationNumber,
  //     "PrivateKeyVersion": privateKeyVersion,
  //     "EDocExportFormat": eDocExportFormat,
  //     "ElecCommStatus": elecCommStatus,
  //     "ElecCommMessage": elecCommMessage,
  //     "SplitVendorCreditRow": splitVendorCreditRow,
  //     "DigitalPayments": digitalPayments,
  //     "U_Ref_Series": uRefSeries,
  //     "U_PRN_Number": uPrnNumber,
  //     "U_DCC_ISPL": uDccIspl,
  //     "U_DCCCO": uDccco,
  //     "U_IntKey": uIntKey,
  //     "U_RVC": uRvc,
  //     "U_VAT": uVat,
  //     "U_ServType": uServType,
  //     "U_RefNo": uRefNo,
  //     "U_DeviceCode": uDeviceCode,
  //     "U_DeviceTransID": uDeviceTransId,
  //     "PaymentChecks": List<dynamic>.from(paymentChecks.map((x) => x)),
  //     "PaymentInvoices": List<dynamic>.from(paymentInvoices.map((x) => x)),
  //     "PaymentCreditCards": List<dynamic>.from(paymentCreditCards.map((x) => x)),
  //     "PaymentAccounts": List<dynamic>.from(paymentAccounts.map((x) => x.toJson())),
  //     "PaymentDocumentReferencesCollection": List<dynamic>.from(paymentDocumentReferencesCollection.map((x) => x)),
  //     "BillOfExchange": billOfExchange.toJson(),
  //     "WithholdingTaxCertificatesCollection": List<dynamic>.from(withholdingTaxCertificatesCollection.map((x) => x)),
  //     "ElectronicProtocols": List<dynamic>.from(electronicProtocols.map((x) => x)),
  //     "CashFlowAssignments": List<dynamic>.from(cashFlowAssignments.map((x) => x)),
  //     "Payments_ApprovalRequests": List<dynamic>.from(paymentsApprovalRequests.map((x) => x)),
  //     "WithholdingTaxDataWTXCollection": List<dynamic>.from(withholdingTaxDataWtxCollection.map((x) => x)),
  // };
}

class PaymentAccount {
  int lineNum;
  String accountCode;
  double sumPaid;
  double sumPaidFc;
  String decription;
  String vatGroup;
  String accountName;
  double grossAmount;
  String profitCenter;
  String projectCode;
  double vatAmount;
  // dynamic profitCenter2;
  // dynamic profitCenter3;
  // dynamic profitCenter4;
  // dynamic profitCenter5;
  // dynamic locationCode;
  // int equalizationVatAmount;
  // dynamic uMonth;
  // dynamic uYear;
  // dynamic uBudgetAmount;
  // dynamic uDccEmpId;
  // dynamic uDccEmpName;
  // dynamic uDccPesaNo;
  // dynamic uDccmno;
  // String uDccco;
  // dynamic uVat;
  // dynamic uSupplier;
  // dynamic uRvc;

  PaymentAccount({
    required this.lineNum,
    required this.accountCode,
    required this.sumPaid,
    required this.sumPaidFc,
    required this.decription,
    required this.vatGroup,
    required this.accountName,
    required this.grossAmount,
    required this.profitCenter,
    required this.projectCode,
    required this.vatAmount,
    // required this.profitCenter2,
    // required this.profitCenter3,
    // required this.profitCenter4,
    // required this.profitCenter5,
    // required this.locationCode,
    // required this.equalizationVatAmount,
    // required this.uMonth,
    // required this.uYear,
    // required this.uBudgetAmount,
    // required this.uDccEmpId,
    // required this.uDccEmpName,
    // required this.uDccPesaNo,
    // required this.uDccmno,
    // required this.uDccco,
    // required this.uVat,
    // required this.uSupplier,
    // required this.uRvc,
  });

  factory PaymentAccount.fromJson(Map<String, dynamic> json) => PaymentAccount(
        lineNum: json["LineNum"] ?? 0,
        accountCode: json["AccountCode"] ?? '',
        sumPaid: json["SumPaid"] ?? 0,
        sumPaidFc: json["SumPaidFC"] ?? 0,
        decription: json["Decription"] ?? '',
        vatGroup: json["VatGroup"] ?? '',
        accountName: json["AccountName"] ?? '',
        grossAmount: json["GrossAmount"] ?? 0,
        profitCenter: json["ProfitCenter"] ?? '',
        projectCode: json["ProjectCode"] ?? '',
        vatAmount: json["VatAmount"] ?? 0,
        // profitCenter2: json["ProfitCenter2"],
        // profitCenter3: json["ProfitCenter3"],
        // profitCenter4: json["ProfitCenter4"],
        // profitCenter5: json["ProfitCenter5"],
        // locationCode: json["LocationCode"],
        // equalizationVatAmount: json["EqualizationVatAmount"],
        // uMonth: json["U_Month"],
        // uYear: json["U_Year"],
        // uBudgetAmount: json["U_Budget_Amount"],
        // uDccEmpId: json["U_DCCEmpId"],
        // uDccEmpName: json["U_DCCEmpName"],
        // uDccPesaNo: json["U_DCCPesaNo"],
        // uDccmno: json["U_DCCMNO"],
        // uDccco: json["U_DCCCO"],
        // uVat: json["U_VAT"],
        // uSupplier: json["U_Supplier"],
        // uRvc: json["U_RVC"],
      );

  // Map<String, dynamic> toJson() => {
  //       "LineNum": lineNum,
  //       "AccountCode": accountCode,
  //       "SumPaid": sumPaid,
  //       "SumPaidFC": sumPaidFc,
  //       "Decription": decription,
  //       "VatGroup": vatGroup,
  //       "AccountName": accountName,
  //       "GrossAmount": grossAmount,
  //       "ProfitCenter": profitCenter,
  //       "ProjectCode": projectCode,
  //       "VatAmount": vatAmount,
  //       "ProfitCenter2": profitCenter2,
  //       "ProfitCenter3": profitCenter3,
  //       "ProfitCenter4": profitCenter4,
  //       "ProfitCenter5": profitCenter5,
  //       "LocationCode": locationCode,
  //       "EqualizationVatAmount": equalizationVatAmount,
  //       "U_Month": uMonth,
  //       "U_Year": uYear,
  //       "U_Budget_Amount": uBudgetAmount,
  //       "U_DCCEmpId": uDccEmpId,
  //       "U_DCCEmpName": uDccEmpName,
  //       "U_DCCPesaNo": uDccPesaNo,
  //       "U_DCCMNO": uDccmno,
  //       "U_DCCCO": uDccco,
  //       "U_VAT": uVat,
  //       "U_Supplier": uSupplier,
  //       "U_RVC": uRvc,
  //     };
}
