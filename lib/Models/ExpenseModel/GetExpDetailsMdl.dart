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

  String uVat;
  String uSupplier;

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
    required this.uSupplier,
    required this.uVat,
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
        uVat: json["U_VAT"] ?? '',
        uSupplier: json["U_Supplier"] ?? "",
      );
}
