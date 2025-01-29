
import 'package:posproject/Models/DataModel/PaymentModel/PaymentModel.dart';

class SalesReturnModel {
  String? cardCode;
  String? phNo;
  String? custName;
  String? accBalance;
  String? tarNo;
  String? email;
  String? point;
  String? invoiceNum;
  String? invoceDate;
  double? invoiceAmt;
  double? totalpayment;
  String? billAddress;
  String? shipAddress;
  List<TotalPayment>? tpayment;
  List<PaymentWay>? paymentway;
  List<ItemItemdetail>? item;
  SalesReturnModel(
      {required this.custName,
      required this.billAddress,
      required this.phNo,
      required this.item,
      required this.cardCode,
      required this.accBalance,
      required this.point,
      required this.tarNo,
      required this.email,
      required this.invoceDate,
      required this.invoiceNum,
      required this.totalpayment,
      required this.shipAddress,
      required this.tpayment,
      required this.paymentway, required double invoiceAmt});
}

class ItemItemdetail {
  String? itemName;
  String? batchCode;
  String? itemCode;
  double? price;
  double? qty;

  ItemItemdetail(
      {required this.itemName,
      required this.qty,
      required this.price,
      required this.batchCode,
      required this.itemCode});
}
