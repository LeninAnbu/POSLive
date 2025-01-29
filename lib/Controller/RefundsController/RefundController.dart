import 'dart:convert';
import 'dart:developer';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/DBModel/RefundPayment.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/RefundLine.dart';
import '../../DBModel/Refundheader.dart';
import '../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PayReceiptModel/InvoicePayReceipt.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SalesOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Widgets/AlertBox.dart';
import '../../Widgets/ContentContainer.dart';

class RefundController extends ChangeNotifier {
  init() {
    callClearAllData();
    getdraftindex();
    notifyListeners();
  }

  Configure config = Configure();

  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  bool onDisablebutton = false;
  List<CustomerAddressModelDB> createNewAddress = [];

  List<SalesModel>? onHoldFilter = [];
  List<SalesModel> onHoldValue = [];
  double onacc = 0;
  List<InvoicePayReceipt>? holdInvoiceItem = [];

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;
  bool checkboxx = false;

  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;
  String? sameInvNum;
  CustomerDetals? topselectedcust;
  CustomerDetals? get gettopselectedcust => topselectedcust;
  TextEditingController remarkcontroller3 = TextEditingController();

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  List<searchModel> searchData = [];
  bool searchbool = false;
  List<searchModel> filtersearchData = [];
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;

  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;
  List<InvoicePayReceipt> scanneditemData2 = [];
  List<InvoicePayReceipt> get getScanneditemData2 => scanneditemData2;
  TotalPayment? totalPayment2;
  double? totalduepay2 = 0;
  CouponDetModel cpndata = CouponDetModel();
  List<CouponDetModel> couponData = [];
  bool _isVisible = true;

  bool get get_isVisible => _isVisible;
  ScrollController hideButtonController =
      ScrollController(initialScrollOffset: 0.0);
  String advancetype = '';
  List<SalesModel> salesPayModell5 = [];
  List<InvoicePayReceipt> scanneditemData = [];
  List<InvoicePayReceipt> get getScanneditemData => scanneditemData;
  double? totpaidamt = 0;
  bool isExpanded = false;
  bool isExpanded2 = true;
  SalesModel? selectcust;
  SalesModel? get getselectcust => selectcust;
  double? totalduepay = 0;
  double? totalinvamt;
  String? autoidddd;
  String? selectedcustcode;
  List<InvoicePayReceipt> filterInvList = [];
  double invAmt = 0;
  String typeee = '';
  List<CustomerDetals> filtercustList1 = [];
  List<CustomerDetals> get getfiltercustList1 => filtercustList1;
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newAddrsValue = [];
  List<CustomerDetals> custList = [];

  List<SalesModel> filtercustList = [];
  List<SalesModel> get getfiltercustList => filtercustList;

  List<CustomerDetals> custList2 = [];
  int totalinvdamtamt = 0;

  callClearAllData() {
    formkey = List.generate(50, (i) => GlobalKey<FormState>());
    formkeyAd = GlobalKey<FormState>();
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    mycontroller = List.generate(150, (i) => TextEditingController());
    onDisablebutton = false;
    selectedShipAdress = 0;
    msgforAmount = null;
    selectedCustomer = 0;
    filtersearchData.clear();
    remarkcontroller3 = TextEditingController();
    searchData.clear();
    selectedBillAdress = 0;
    checkboxx = false;
    _isVisible = true;
    advancetype = '';
    onHoldFilter = [];
    onHoldValue = [];
    couponData = [];
    salesPayModell5 = [];
    createNewAddress.clear();
    invAmt = 0;
    typeee = '';
    totpaidamt = 0;
    isExpanded = false;
    isExpanded2 = true;
    selectcust = null;
    totalinvamt = null;
    selectedcust = null;
    topselectedcust = null;
    custList2 = [];
    totalinvdamtamt = 0;
    totalduepay = null;
    autoidddd = null;
    selectedcustcode = null;
    filterInvList = [];
    filtercustList1 = [];
    newCustValues = [];
    newAddrsValue = [];
    custList = [];
    filtercustList = [];
    onacc = 0;
    holdInvoiceItem = [];

    paymentWay2 = [];
    paymentWay = [];
    totalPayment2 = null;
    sameInvNum = null;
    totalduepay2 = null;
    searchbool = false;
    scanneditemData2 = [];
    scanneditemData = [];
    hideButtonController = ScrollController(initialScrollOffset: 0.0);
  }

  invoicedScan(BuildContext context, ThemeData theme) async {
    int? indx = await invoiceBatchAvail(
        mycontroller[80].text.toString().trim().toUpperCase(), context, theme);
    if (indx != null) {
      if (scanneditemData.isEmpty) {
        addProductValue(indx);

        addCustomer(context);

        notifyListeners();
      } else {
        int? arSc = await checkSameSerialBatchScnd(sameInvNum.toString());
        if (arSc != null) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Already scanned..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        } else {
          addProductValue(indx);
        }
        notifyListeners();
      }

      notifyListeners();
    } else if (indx == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Wrong Invoice Choosed..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
  }

  addCustomer(BuildContext context) {
    for (int i = 0; i < salesPayModell5.length; i++) {
      CustomerDetals selecust = CustomerDetals();
      selecust.cardCode = salesPayModell5[i].cardCode;

      selecust.accBalance = salesPayModell5[i].accBalance != 0
          ? double.parse(salesPayModell5[i].accBalance.toString())
          : 0.00;
      selecust.address = salesPayModell5[i].address;
      selecust.email = salesPayModell5[i].email;
      selecust.name = salesPayModell5[i].custName;
      selecust.phNo = salesPayModell5[i].phNo;
      selecust.point = salesPayModell5[i].point;
      selecust.tarNo = salesPayModell5[i].tarNo;
      selecust.docentry = salesPayModell5[i].transdocentry.toString();
      selecust.invoicenum = salesPayModell5[i].invoiceNum.toString();

      selecust.invoiceDate = salesPayModell5[i].invoceDate.toString();
      selectedcust = selecust;
      selectedcustcode = salesPayModell5[i].cardCode;

      notifyListeners();
    }
  }

  Future addProductValue(int i) async {
    log('iiiiiiiiiiiiiii $i');
    await addProductItem(i);

    notifyListeners();
  }

  Future addProductItem(int ins) async {
    totalinvamt = 0;
    totalduepay = 0;
    log("salesPayModell5[ins].payItem length::${salesPayModell5[ins].payItem!.length}");
    for (int i = 0; i < salesPayModell5[ins].payItem!.length; i++) {
      scanneditemData.add(InvoicePayReceipt(
          checkClr: salesPayModell5[ins].payItem![i].checkClr,
          amount: salesPayModell5[ins].payItem![i].amount,
          docNum: salesPayModell5[ins].payItem![i].docNum,
          date: salesPayModell5[ins].payItem![i].date,
          doctype: salesPayModell5[ins].payItem![i].doctype,
          checkbx: salesPayModell5[ins].payItem![i].checkbx,
          transdocentry: salesPayModell5[ins].docentry.toString()));

      for (int ji = 0; ji < scanneditemData.length; ji++) {
        mycontroller[ji].text =
            salesPayModell5[ins].invoceAmount!.toStringAsFixed(2).toString();

        if (scanneditemData[ji].checkbx == 1) {
          totalduepay =
              totalduepay! + double.parse(mycontroller[ji].text.toString());
          totalinvamt = scanneditemData[ji].amount;
          notifyListeners();
        }

        log("totalduepaytotalduepay:::$totalduepay");
      }

      notifyListeners();
    }

    notifyListeners();
  }

  Future<int?> checkSameSerialBatchScnd(String invc) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].docNum == invc) {
        if (scanneditemData[i].amount == null) {
          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  invoiceBatchAvail(
      String invcno, BuildContext context, ThemeData theme) async {
    salesPayModell5.clear();
    scanneditemData.clear();
    totalduepay = 0;
    totpaidamt = 0;
    advancetype = '';

    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.salesRetHeadtorefund(db, invcno.toString());
    if (getDBholddata1.isNotEmpty) {
      for (int i = 0; i < getDBholddata1.length; i++) {
        selectedcust = null;
        scanneditemData.add(InvoicePayReceipt(
          date: getDBholddata1[i]['createdateTime'] == null
              ? ""
              : getDBholddata1[i]['createdateTime'].toString(),
          amount: double.parse(
              getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')),
          docNum: getDBholddata1[i]['documentno'].toString(),
          doctype: getDBholddata1[i]['doctype'].toString(),
          transdocentry: getDBholddata1[i]['docentry'].toString(),
          checkClr: true,
          checkbx: 1,
        ));

        notifyListeners();
        log("scanneditemData::${scanneditemData.length}");
        notifyListeners();

        SalesModel salesM = SalesModel(
          doctype: getDBholddata1[i]['doctype'].toString(),
          totaldue: double.parse(getDBholddata1[i]['baltopay'] == null
              ? '0'
              : getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')),
          docentry: int.parse(getDBholddata1[i]['docentry'].toString()),
          transdocentry: getDBholddata1[i]['docentry'].toString(),
          custName: getDBholddata1[i]['customername'].toString(),
          taxCode: getDBholddata1[i]['taxCode'].toString(),
          phNo: getDBholddata1[i]['customerphono'] == null
              ? ""
              : getDBholddata1[i]['customerphono'].toString(),
          cardCode: getDBholddata1[i]['customercode'].toString(),
          accBalance: getDBholddata1[i]['customeraccbal'] == null
              ? ""
              : getDBholddata1[i]['customeraccbal'].toString(),
          point: getDBholddata1[i]['customerpoint'] == null
              ? ""
              : getDBholddata1[i]['customerpoint'].toString(),
          tarNo: getDBholddata1[i]['taxno'] == null
              ? ""
              : getDBholddata1[i]['taxno'].toString(),
          email: getDBholddata1[i]['customeremail'] == null
              ? ''
              : getDBholddata1[i]['customeremail'].toString(),
          invoceDate: getDBholddata1[i]['createdateTime'] == null
              ? ""
              : getDBholddata1[i]['createdateTime'].toString(),
          invoiceNum: getDBholddata1[i]['documentno'].toString(),
          invoceAmount: double.parse(
              getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')),
          address: [
            Address(
                address1: getDBholddata1[i]['billaddressid'].toString(),
                billCity: getDBholddata1[i]['city'].toString(),
                billCountry: getDBholddata1[i]['country'].toString(),
                billPincode: getDBholddata1[i]['pinno'].toString(),
                billstate: getDBholddata1[i]['state'].toString())
          ],
          totalPayment: TotalPayment(
            totalTX: double.parse(getDBholddata1[i]['taxamount'] == null
                ? '0'
                : getDBholddata1[i]['taxamount'].toString()),
            subtotal: double.parse(getDBholddata1[i]['docbasic'] == null
                ? '0'
                : getDBholddata1[i]['docbasic'].toString().replaceAll(',', '')),
            discount2: double.parse(getDBholddata1[i]['docdiscamt'] != null
                ? getDBholddata1[i]['docdiscamt'].toString()
                : '0'),
            discount: double.parse(getDBholddata1[i]['docdiscamt'] != null
                ? getDBholddata1[i]['docdiscamt'].toString()
                : '0'),
            totalDue: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            totpaid: double.parse(getDBholddata1[i]['amtpaid'] == null
                ? '0'
                : getDBholddata1[i]['amtpaid'].toString().replaceAll(',', '')),
            balance: double.parse(getDBholddata1[i]['baltopay'] != null
                ? getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')
                : '0'),
          ),
        );
        salesPayModell5.add(salesM);
        notifyListeners();
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Wrong Document Choosed..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    addCustomer(context);
    fortotalduepay();

    notifyListeners();
  }

  fortotalduepay() {
    for (int ji = 0; ji < scanneditemData.length; ji++) {
      mycontroller[ji].text =
          scanneditemData[ji].amount!.toStringAsFixed(2).toString();

      if (scanneditemData[ji].checkbx == 1) {
        totalduepay =
            totalduepay! + double.parse(mycontroller[ji].text.toString());
        totalinvamt = scanneditemData[ji].amount;
        notifyListeners();
      }

      log("totalduepaytotalduepay:::$totalduepay");
    }
  }

  scancardcode(String cardcode, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<InvoicePayReceipt> scannData = [];
    salesPayModell5.clear();
    scanneditemData.clear();
    totalinvamt = 0;
    double docamt = 0;
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesRetheadCkoutRefund(
      db,
      cardcode.toString(),
    );
    log("getDBholddata1getDBholddata1 length::${getDBholddata1.length}");
    if (getDBholddata1.isNotEmpty) {
      for (int ik = 0; ik < getDBholddata1.length; ik++) {
        if (cardcode.toString() ==
            getDBholddata1[ik]['customercode'].toString()) {
          scanneditemData.add(InvoicePayReceipt(
            date: getDBholddata1[ik]['createdateTime'] == null
                ? ""
                : getDBholddata1[ik]['createdateTime'].toString(),
            amount: double.parse(
                getDBholddata1[ik]['baltopay'].toString().replaceAll(',', '')),
            docNum: getDBholddata1[ik]['documentno'].toString(),
            doctype: getDBholddata1[ik]['doctype'].toString(),
            transdocentry: getDBholddata1[ik]['docentry'].toString(),
            checkClr: true,
            checkbx: 1,
          ));
          log('scannDatascannData::${scannData.length}');

          SalesModel salesPayModel = SalesModel(
            address: [
              Address(
                  address1: getDBholddata1[ik]['billaddressid'].toString(),
                  billCity: getDBholddata1[ik]['city'].toString(),
                  billCountry: getDBholddata1[ik]['country'].toString(),
                  billPincode: getDBholddata1[ik]['pinno'].toString(),
                  billstate: getDBholddata1[ik]['state'].toString())
            ],
            docentry: int.parse(getDBholddata1[ik]['docentry'].toString()),
            doctype: getDBholddata1[ik]['doctype'].toString(),
            totaldue: double.parse(getDBholddata1[ik]['baltopay'] == null
                ? '0'
                : getDBholddata1[ik]['baltopay']
                    .toString()
                    .replaceAll(',', '')),
            custName: getDBholddata1[ik]['customername'].toString(),
            phNo: getDBholddata1[ik]['customerphono'].toString(),
            cardCode: getDBholddata1[ik]['customercode'].toString(),
            accBalance: getDBholddata1[ik]['customeraccbal'].toString(),
            point: getDBholddata1[ik]['customerpoint'] == null
                ? ""
                : getDBholddata1[ik]['customerpoint'].toString(),
            tarNo: getDBholddata1[ik]['taxno'] == null
                ? ""
                : getDBholddata1[ik]['taxno'].toString(),
            email: getDBholddata1[ik]['customeremail'] == null
                ? ''
                : getDBholddata1[ik]['customeremail'].toString(),
            invoceDate: getDBholddata1[ik]['createdateTime'] == null
                ? ""
                : getDBholddata1[ik]['createdateTime'].toString(),
            transdocentry: getDBholddata1[ik]['docentry'].toString(),
            invoiceNum: getDBholddata1[ik]['documentno'].toString(),
            invoceAmount: double.parse(
                getDBholddata1[ik]['baltopay'].toString().replaceAll(',', '')),
            taxCode: '',
          );
          salesPayModell5.add(salesPayModel);
          log('salesPayModell5salesPayModell5::${salesPayModell5.length}');
          log("IKIKIKIKIKIK::$ik");
          notifyListeners();
          docamt = double.parse(
              getDBholddata1[ik]['baltopay'].toString().replaceAll(',', ''));
        }
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Wrong CustomerCode Choosed..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    addCustomer(context);
    for (int ji = 0; ji < scanneditemData.length; ji++) {
      mycontroller[ji].text = docamt.toString().replaceAll(',', '');

      if (scanneditemData[ji].checkbx == 1) {
        totalduepay =
            totalduepay! + double.parse(mycontroller[ji].text.toString());
        totalinvamt = scanneditemData[ji].amount;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  double getSumTotalPaid() {
    double toalPaid = 0;
    if (paymentWay.isNotEmpty) {
      var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      toalPaid = getTotalPaidSum.reduce((a, b) => a + b);

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getBalancePaid() {
    if (paymentWay.isNotEmpty) {
      return totpaidamt != 0
          ? (totpaidamt! - double.parse(getSumTotalPaid().toStringAsFixed(2)))
          : totalduepay! - double.parse(getSumTotalPaid().toStringAsFixed(2));
    } else if (totalduepay != null) {
      return totpaidamt != 0 ? totpaidamt! : totalduepay!;
    } else {
      totalduepay = 0.00;
      return 0.00;
    }
  }

  custSelected(
      CustomerDetals customerDetals, BuildContext context, ThemeData theme) {
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    selectedcust = null;
    CustomerDetals selectedcust2 = CustomerDetals(
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        accBalance: customerDetals.accBalance,
        point: customerDetals.point,
        address: customerDetals.address,
        email: customerDetals.email,
        tarNo: customerDetals.tarNo);
    selectedcust = selectedcust2;
    selectedcustcode = customerDetals.cardCode;
    autoidddd = customerDetals.address![selectedBillAdress].autoId.toString();

    notifyListeners();
  }

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mycontroller[24].text = config.alignDate(datetype!);
    mycontroller[44].text = datetype!;
  }

  String? selectedType;
  List<String> transType = ['NEFT', 'RTGS', 'IMPS'];
  List<String> get gettransType => transType;

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (selectedType == null && type == 'Transfer') {
      hintcolor = true;
      notifyListeners();
    }

    if (formkey[i].currentState!.validate()) {
      if (type == 'Cash') {
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Cheque') {
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = config.alignDate2(mycontroller[44].text);
        paymt.chequeno = mycontroller[23].text.toString();
        paymt.type = type;
      } else if (type == 'Transfer') {
        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      }
    }
    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      if (check == 0) {
        addPayAmount(paymt, context);
        notifyListeners();

        notifyListeners();
      } else if (check == 1) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content:
                          'Already you used ${paymt.type!} mode of payment..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type == typeofMoney) {
        return 1;
      }
    }
    return 0;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    if (paymentWay.isEmpty) {
      if (double.parse(config
                  .splitValues(totalduepay!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    } else {
      if (double.parse(config
                  .splitValues(totalduepay!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    }
  }

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    paymentWay.add(PaymentWay(
      amt: paymt.amt,
      dateTime: paymt.dateTime,
      type: paymt.type,
      chequedate: paymt.chequedate,
      chequeno: paymt.chequeno,
      reference: paymt.reference ?? '',
      remarks: paymt.remarks,
      transref: paymt.couponcode,
      transtype: paymt.coupontype,
    ));
    getSumTotalPaid();
    getBalancePaid();

    Navigator.pop(context);
    notifyListeners();
  }

  cpyBtnclik(int i) {
    mycontroller[i].text = getBalancePaid().toStringAsFixed(2);
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    return listdata;
  }

  saveRefundValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertRefund(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "submit") {
      insertRefund(docstatus, context, theme);
    }

    notifyListeners();
  }

  insertRefund(String? docstatus, BuildContext context, ThemeData theme) async {
    List<RefundHeaderTDB> receiptHeader = [];
    List<RefundLineTDB> receiptLine1 = [];
    List<RefundPayTDB> receiptLine2 = [];
    final Database db = (await DBHelper.getInstance())!;

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "RefundHeader");
    int? docEntryCreated = 0;

    if (counofData == 0) {
      if (AppConstant.terminal == 'T1') {
        docEntryCreated = 1000000;
      } else if (AppConstant.terminal == 'T2') {
        docEntryCreated = 2000000;
      } else if (AppConstant.terminal == 'T3') {
        docEntryCreated = 3000000;
      } else if (AppConstant.terminal == 'T4') {
        docEntryCreated = 4000000;
      }
    } else {
      docEntryCreated =
          await DBOperation.generateDocentr(db, "docentry", "RefundHeader");
    }

    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 5);

    List<String> getseriesvalue = await checkingdoc(5);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();

    int selectdocentry = selectedcust!.docentry != null
        ? int.parse(selectedcust!.docentry.toString())
        : 0;
    List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
        db, selectdocentry, 'SalesReturnHeader');

    receiptHeader.add(RefundHeaderTDB(
      docentry: docEntryCreated,
      doctype: "Refund",
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      customer: selectedcust!.cardCode.toString(),
      docnumber: documentNum.toString(),
      branch: UserValues.branch.toString(),
      lastupdateIp: UserValues.lastUpdateIp,
      series: '',
      seriesnumber: '',
      sysdate: config.currentDate(),
      totalamount: totalinvamt.toString(),
      transdate: config.currentDate(),
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID.toString(),
      docstatus: docstatus == "hold"
          ? '1'
          : docstatus == "submit"
              ? '3'
              : "null",
      terminal: UserValues.terminal,
      transdocentry: selectedcust!.docentry != null
          ? selectedcust!.docentry!.toString()
          : "",
      transdocnum: selectedcust!.invoicenum.toString(),
      sapDocNo: null,
      qStatus: "",
      sapDocentry: null,
      sapInvoicedocentry:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocentry'].toString() : "",
      sapInvoicedocnum:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocNo'].toString() : '',
      remarks: mycontroller[50].text.toString(),
    ));

    int? docentry5 = await DBOperation.insertRefundHeader(db, receiptHeader);
    await DBOperation.updatenextno(db, 5, nextno);
    for (int ij = 0; ij < scanneditemData.length; ij++) {
      if (scanneditemData[ij].checkbx == 1) {
        receiptLine1.add(RefundLineTDB(
            TransAmount: mycontroller[ij].text.toString(),
            TransDocDate: scanneditemData[ij].date.toString(),
            TransDocNum: scanneditemData[ij].docNum,
            createdUserID: UserValues.userID.toString(),
            createdateTime: config.currentDate(),
            docentry: docentry5,
            lastupdateIp: UserValues.lastUpdateIp,
            rc_entry: ij,
            transDocEnty: scanneditemData[ij].transdocentry,
            transType: scanneditemData[ij].doctype,
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID.toString(),
            branch: UserValues.branch,
            sapDocNo: null,
            qStatus: "",
            sapDocentry: null,
            terminal: UserValues.terminal));
        notifyListeners();
      }
    }
    for (int i = 0; i < paymentWay.length; i++) {
      receiptLine2.add(RefundPayTDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry5.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[i].amt.toString(),
          rcdatetime: selectedcust!.invoiceDate,
          rcdocentry: selectedcust!.docentry,
          rcmode: paymentWay[i].type.toString(),
          rcnumber: selectedcust!.invoicenum,
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          reference: paymentWay[i].reference,
          Ref2: '',
          Ref3: '',
          Ref4: '',
          Ref5: '',
          VouchCode: '',
          VouchCode2: '',
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          cardApprno: paymentWay[i].cardApprno,
          cardterminal: paymentWay[i].cardterminal,
          chequedate: paymentWay[i].chequedate,
          chequeno: paymentWay[i].chequeno,
          couponcode: paymentWay[i].couponcode,
          coupontype: paymentWay[i].coupontype,
          discountcode: paymentWay[i].discountcode,
          discounttype: paymentWay[i].discounttype,
          recoverydate: paymentWay[i].recoverydate,
          redeempoint: paymentWay[i].redeempoint,
          availablept: paymentWay[i].availablept,
          remarks: paymentWay[i].remarks,
          transtype: paymentWay[i].transtype,
          walletid: paymentWay[i].walletid,
          wallettype: paymentWay[i].wallettype,
          lineId: i.toString()));
      notifyListeners();
    }
    if (receiptLine1.isNotEmpty) {
      await DBOperation.insertRefundLine(db, receiptLine1, docentry5!);
    }
    if (receiptLine2.isNotEmpty) {
      await DBOperation.insertRefundPay(db, receiptLine2, docentry5!);
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {}

    if (docstatus == "hold") {
      getdraftindex();
    }
    if (cpndata.cardcode == selectedcust!.cardCode.toString()) {
      await DBOperation.updatecouponstatus(
          db, cpndata.couponcode.toString(), selectedcust!.cardCode.toString());
    }
    onDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    totalduepay = 0;
    paymentWay.clear();
    totpaidamt = 0;
    advancetype = '';
    mycontroller[80].clear();
    mycontroller[81].clear();
    mycontroller[50].clear();

    mycontroller[0].clear();
    mycontroller[1].clear();
    notifyListeners();
    Get.defaultDialog(
            title: "Alert",
            middleText: docstatus == "submit"
                ? ' Sucessfully Done..!!,  Document Number is $documentNum'
                : docstatus == "hold"
                    ? "Saved as draft"
                    : "null",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.red),
            middleTextStyle: const TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {
      if (docstatus == "submit") {
        Get.toNamed(ConstantRoutes.dashboard);
      }
      onDisablebutton = false;
      notifyListeners();
    });
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    onDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    totalduepay = 0;
    paymentWay.clear();
    totpaidamt = 0;
    advancetype = '';
    mycontroller[80].clear();
    mycontroller[81].clear();
    mycontroller[50].clear();

    mycontroller[0].clear();
    mycontroller[1].clear();
    notifyListeners();
    Get.defaultDialog(
            title: "Alert",
            middleText: " Suspended Sucessfully..!!",
            backgroundColor: Colors.white,
            titleStyle: const TextStyle(color: Colors.red),
            middleTextStyle: const TextStyle(color: Colors.black),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
            radius: 5)
        .then((value) {
      onDisablebutton = false;
    });
  }

  postRabitMqRefund(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBRefundHeader =
        await DBOperation.getRefundHeaderDB(db, docentry!);
    List<Map<String, Object?>> getDBReceiptPay =
        await DBOperation.getRefundPay(db, docentry);
    List<Map<String, Object?>> getDBReafundLine =
        await DBOperation.getRefundLine1(db, docentry);

    String refundHeader = json.encode(getDBRefundHeader);
    String refundLine = json.encode(getDBReafundLine);
    String refundPAY = json.encode(getDBReceiptPay);
    var ddd = json.encode({
      "ObjectType": 19,
      "ActionType": "Add",
      "RefundHeader": refundHeader,
      "RefundLine": refundLine,
      "RefundPay": refundPAY,
    });
    log("payload : $ddd");

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqRefund2(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBRefundHeader =
        await DBOperation.getRefundHeaderDB(db, docentry!);
    List<Map<String, Object?>> getDBReceiptPay =
        await DBOperation.getRefundPay(db, docentry);
    List<Map<String, Object?>> getDBReafundLine =
        await DBOperation.getRefundLine1(db, docentry);

    String refundHeader = json.encode(getDBRefundHeader);
    String refundLine = json.encode(getDBReafundLine);
    String refundPAY = json.encode(getDBReceiptPay);
    var ddd = json.encode({
      "ObjectType": 19,
      "ActionType": "Add",
      "RefundHeader": refundHeader,
      "RefundLine": refundLine,
      "RefundPay": refundPAY,
    });
    log("payload : $ddd");
  }

  submitted(BuildContext context, ThemeData theme) {
    onDisablebutton = true;
    if (selectedcust == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Choose customer..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else {
      if (paymentWay.isNotEmpty && totalduepay == getSumTotalPaid()) {
        saveRefundValuesTODB('submit', context, theme);
      } else {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Pay the full amount..!!',
                        theme: theme,
                      )),
                      buttonName: null));
            }).then((value) {
          onDisablebutton = false;
          notifyListeners();
        });
      }
    }
    onDisablebutton = false;
    notifyListeners();
  }

  nullErrorMsg() {
    msgforAmount = null;

    selectedType = null;

    clearTextField();
    notifyListeners();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getRefunOnHold(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);

      log("getDBholddata5 customer name:${getDBholddata5[i]['customer']}");

      notifyListeners();
    }
    notifyListeners();
  }

  getdraft(int ji) async {
    final Database db = (await DBHelper.getInstance())!;

    salesPayModell5.clear();
    totalduepay = 0;
    List<Map<String, Object?>> getDBholdPayReceiptdata1 =
        await DBOperation.getRefunOnHold(db);
    log("getDBholdPayReceiptdata1[ji]['docentry']::${getDBholdPayReceiptdata1[ji]['docentry']}");
    List<InvoicePayReceipt> scannData = [];
    List<PaymentWay> payment = [];
    CustomerDetals? customeredetailss = CustomerDetals();

    List<Map<String, Object?>> getDBholdPayReceiptLine22 =
        await DBOperation.getRefundPay(
            db, int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> getDBsalesdata1 =
        await DBOperation.getSalesretheaderCkout(
            db, getDBholdPayReceiptdata1[ji]['customer'].toString());

    for (int ig = 0; ig < getDBsalesdata1.length; ig++) {
      if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
          getDBsalesdata1[ig]['customercode'].toString()) {
        CustomerDetals customerde = CustomerDetals(
            accBalance:
                double.parse(getDBsalesdata1[ig]['customeraccbal'].toString()),
            name: getDBsalesdata1[ig]['customername'].toString(),
            phNo: getDBsalesdata1[ig]['customerphono'].toString(),
            cardCode: getDBsalesdata1[ig]['customercode'].toString(),
            point: getDBsalesdata1[ig]['customerpoint'].toString(),
            address: [
              Address(
                address1: getDBsalesdata1[ig]['billaddressid'].toString(),
                billCity: getDBsalesdata1[ig]['city'].toString(),
                billCountry: getDBsalesdata1[ig]['country'].toString(),
                billPincode: getDBsalesdata1[ig]['pinno'].toString(),
                billstate: getDBsalesdata1[ig]['state'].toString(),
              ),
            ],
            tarNo: getDBsalesdata1[ig]['taxno'].toString(),
            email: getDBsalesdata1[ig]['customeremail'].toString(),
            invoiceDate: getDBsalesdata1[ig]['createdateTime'].toString(),
            invoicenum: getDBsalesdata1[ig]['documentno'].toString(),
            docentry: getDBholdPayReceiptdata1[ji]['docentry'].toString());
        customeredetailss = customerde;
      }
    }

    for (int kk = 0; kk < getDBholdPayReceiptLine22.length; kk++) {
      if (getDBholdPayReceiptdata1[ji]['docentry'] ==
          getDBholdPayReceiptLine22[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(
              getDBholdPayReceiptLine22[kk]['rcamount'].toString()),
          type: getDBholdPayReceiptLine22[kk]['rcmode'].toString(),
          dateTime: getDBholdPayReceiptLine22[kk]['createdateTime'].toString(),
          reference: getDBholdPayReceiptLine22[kk]['reference'] != null
              ? getDBholdPayReceiptLine22[kk]['reference'].toString()
              : '',
          cardApprno: getDBholdPayReceiptLine22[kk]['cardApprno'] != null
              ? getDBholdPayReceiptLine22[kk]['cardApprno'].toString()
              : '',
          cardref: getDBholdPayReceiptLine22[kk]['cardref'].toString(),
          cardterminal:
              getDBholdPayReceiptLine22[kk]['cardterminal'].toString(),
          chequedate: getDBholdPayReceiptLine22[kk]['chequedate'].toString(),
          chequeno: getDBholdPayReceiptLine22[kk]['chequeno'].toString(),
          transtype: getDBholdPayReceiptLine22[kk]['transtype'].toString(),
          basedoctype: '',
        ));
      }
      notifyListeners();
    }

    scannData.add(InvoicePayReceipt(
      date: getDBholdPayReceiptdata1[ji]['transdate'].toString(),
      amount: getDBholdPayReceiptdata1[ji]['totalamount'] != null
          ? double.parse(getDBholdPayReceiptdata1[ji]['totalamount'].toString())
          : 0,
      docNum: getDBholdPayReceiptdata1[ji]['transdocnum'].toString(),
      doctype: "Sales Return",
      transdocentry: getDBholdPayReceiptdata1[ji]['transdocentry'].toString(),
      checkClr: true,
      checkbx: 1,
    ));

    notifyListeners();

    SalesModel salesM = SalesModel(
        transdocentry: getDBholdPayReceiptdata1[ji]['transdocentry'].toString(),
        docentry:
            int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()),
        address: customeredetailss?.address,
        custName: customeredetailss != null
            ? customeredetailss.name.toString()
            : null,
        phNo: customeredetailss != null ? customeredetailss.phNo : "",
        totaldue: customeredetailss != null ? totalduepay : null,
        cardCode: customeredetailss != null ? customeredetailss.cardCode : "",
        taxCode: customeredetailss != null ? customeredetailss.taxCode : "",
        accBalance: customeredetailss != null
            ? customeredetailss.accBalance.toString()
            : null,
        point: customeredetailss != null ? customeredetailss.point : "",
        tarNo: customeredetailss != null ? customeredetailss.tarNo : "",
        email: customeredetailss != null ? customeredetailss.email : "",
        invoceDate:
            customeredetailss != null ? customeredetailss.invoiceDate : "",
        invoiceNum:
            customeredetailss != null ? customeredetailss.invoicenum : "",
        payItem: scannData,
        paymentway: payment);

    notifyListeners();

    salesPayModell5.add(salesM);

    notifyListeners();

    onHoldFilter = salesPayModell5;

    log("onHoldFilter.length:${onHoldFilter!.length}");
    notifyListeners();
  }

  mapHoldValues(int ih, BuildContext context, ThemeData theme) async {
    log("FFFFFFFFFFFFFFFFFF::${salesPayModell5.length}");
    final Database db = (await DBHelper.getInstance())!;

    selectedcust = CustomerDetals(
        name: salesPayModell5[ih].custName,
        phNo: salesPayModell5[ih].phNo,
        cardCode: salesPayModell5[ih].cardCode,
        accBalance: salesPayModell5[ih].accBalance != null
            ? double.parse(salesPayModell5[ih].accBalance.toString())
            : 0,
        point: salesPayModell5[ih].point,
        address: salesPayModell5[ih].address!,
        tarNo: salesPayModell5[ih].tarNo,
        email: salesPayModell5[ih].email,
        invoicenum: salesPayModell5[ih].invoiceNum,
        docentry: salesPayModell5[ih].transdocentry.toString());
    totalinvamt = 0;

    scanneditemData = salesPayModell5[ih].payItem!;
    totalduepay = salesPayModell5[ih].totaldue!;
    paymentWay = salesPayModell5[ih].paymentway!;

    for (int i = 0; i < scanneditemData.length; i++) {
      log('scanneditemData amount::${scanneditemData[i].amount}');
      log('scanneditemData docnum::${scanneditemData[i].docNum}');
      log('scanneditemData date::${scanneditemData[i].date}');
      log('scanneditemData doctype::${scanneditemData[i].doctype}');

      mycontroller[i].text = scanneditemData[i].amount.toString();
      totalduepay =
          totalduepay! + double.parse(mycontroller[i].text.toString());
      log('scanneditemData Length::${scanneditemData.length}');
    }

    DBOperation.deletRefundHold(db, salesPayModell5[ih].docentry.toString())
        .then((value) {
      onHoldFilter!.clear();
      getdraftindex();
    });
    notifyListeners();
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onHoldFilter = salesPayModell5
          .where((e) =>
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoiceNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.phNo!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesPayModell5;
      notifyListeners();
    }
  }

  onHoldClicked(BuildContext context, ThemeData theme) {
    onDisablebutton = true;
    if (selectedcust == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Choose customer..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else {
      saveRefundValuesTODB('hold', context, theme);
      notifyListeners();
    }

    onDisablebutton = false;
    notifyListeners();
  }

  itemDeSelect(int i) {
    if (scanneditemData[i].checkbx == 0 &&
        scanneditemData[i].checkClr == false) {
      scanneditemData[i].checkbx = 1;
      scanneditemData[i].checkClr = true;

      totalduepay = totalduepay! + scanneditemData[i].amount!;

      notifyListeners();
    } else if (scanneditemData[i].checkbx == 1 &&
        scanneditemData[i].checkClr == true) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = totalduepay! - scanneditemData[i].amount!;
      notifyListeners();
    }

    notifyListeners();
  }

  selectall() {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 0 &&
          scanneditemData[i].checkClr == false) {
        scanneditemData[i].checkbx = 1;
        scanneditemData[i].checkClr = true;
        totalduepay = totalduepay! + scanneditemData[i].amount!;
        notifyListeners();
      }
      notifyListeners();
    }
  }

  deSelectall() {
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = 0;
      notifyListeners();
    }
  }

  clearTextField() {
    mycontroller[80].clear();

    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[7].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[21].clear();
    mycontroller[22].clear();
    mycontroller[23].clear();
    mycontroller[24].clear();
    mycontroller[25].clear();
    mycontroller[26].clear();
    mycontroller[27].clear();
    mycontroller[28].clear();
    mycontroller[29].clear();
    mycontroller[30].clear();
    mycontroller[31].clear();
    mycontroller[32].clear();
    mycontroller[33].clear();
    mycontroller[34].clear();
    mycontroller[35].clear();
    mycontroller[36].clear();
    mycontroller[37].clear();
    mycontroller[38].clear();
    mycontroller[39].clear();
    mycontroller[40].clear();
    mycontroller[41].clear();
    mycontroller[42].clear();
    mycontroller[43].clear();
    mycontroller[44].clear();
    mycontroller[45].clear();
    mycontroller[55].clear();

    notifyListeners();
  }

  deleterefundtable() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.deleterefund(db);
  }
}
