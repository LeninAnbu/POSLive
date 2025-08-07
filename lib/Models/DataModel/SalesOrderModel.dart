import 'package:posproject/Models/DataModel/PayReceiptModel/InvoicePayReceipt.dart';
import '../Service Model/StockSnapModelApi.dart';
import 'CustomerModel/CustomerModel.dart';
import 'PaymentModel/PaymentModel.dart';

class SalesModel {
  int? docentry;
  String? ordReference;

  String? transdocentry;
  String? transdocnm;
  String? cardCode;
  String? taxCode;
  String? phNo;
  String? custName;
  String? custautoid;
  String? accBalance;
  String? tarNo;
  String? email;
  String? point;
  String? invoiceNum;
  String? invoceDate;
  int? invoiceClr;
  bool? checkBClr;
  double? totaldue;
  String? date;
  double? invoceAmount;
  String? createdateTime;
  String? doctype;
  String? objtype;
  String? sapInvoiceNum;
  String? sapOrderNum;
  String? objname;
  String? remarks;
  String? reference;

  List<Address>? address;
  List<StocksnapModelData>? item;
  List<InvoicePayReceipt>? payItem;
  TotalPayment? totalPayment;
  List<PaymentWay>? paymentway;

  SalesModel(
      {required this.custName,
      this.docentry,
      this.transdocentry,
      this.doctype,
      this.objtype,
      this.objname,
      this.address,
      this.ordReference,
      this.custautoid,
      this.remarks,
      this.reference,
      this.phNo,
      this.item,
      this.checkBClr,
      this.invoiceClr,
      this.invoceAmount,
      this.totaldue,
      this.payItem,
      this.createdateTime,
      required this.cardCode,
      this.accBalance,
      this.point,
      this.tarNo,
      this.email,
      required this.invoceDate,
      required this.taxCode,
      required this.invoiceNum,
      this.sapInvoiceNum,
      this.sapOrderNum,
      this.paymentway,
      this.totalPayment});
}
