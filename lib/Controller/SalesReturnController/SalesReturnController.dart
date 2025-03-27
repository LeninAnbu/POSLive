import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/DB%20Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:posproject/ServiceLayerAPIss/InvoiceAPI/GetInvoicerAPI.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/SalesReturnHeadT.dart';
import '../../DBModel/SalesReturnLineT.dart';
import '../../DBModel/SalesReturnPayT.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SalespaytoSalesRetPayModel/SalesPaytoSalesReturnpayModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/ExpenseModel/ExpenseGetModel.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';
import '../../Models/QueryUrlModel/SalesRetqueryModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_order_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/ReturnPostingListModel.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/SapSaleReturnmodel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Service/Printer/SalesreturnPrintApi.dart';
import '../../Service/Printer/orderPrint.dart';
import '../../Service/QueryURL/CreditDaysModelAPI.dart';
import '../../Service/QueryURL/CreditLimitModeAPI.dart';
import '../../Service/QueryURL/ReturnCardCodeApi.dart';
import '../../Service/QueryURL/SalesReturnQueryApi.dart';
import '../../Service/SearchQuery/SearchReturnHeaderApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/approvals_details_api.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/PostingReturnData.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnApproval/AfterApvlToDocNumApi.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnApproval/RetApporvaltoDocApi.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnApproval/RetApprovalQryApi.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnApproval/RetPendingApprovalsApi.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnApproval/RetRejectedApi.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/GetReturnAPI.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnCloseAPI.dart';
import '../../ServiceLayerAPIss/SalesReturnAPI/ReturnLoginnAPI.dart';
import '../SalesInvoice/SalesInvoiceController.dart';

class SalesReturnController extends ChangeNotifier {
  Configure config = Configure();
  init(BuildContext context) {
    clearAllData();
    getdraftindex();
    getCustDetFDB();
    notifyListeners();
  }

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  String? invDocumentStatus;
  String? selectCreditNoteType;
  String? selectCreditNoteCode;
  bool isselectCredit = false;
  TextEditingController searchcontroller = TextEditingController();

  List<TextEditingController> srmycontroller =
      List.generate(500, (i) => TextEditingController());
  PosController? posC;
  List<GlobalKey<FormState>> formkey =
      List.generate(500, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> mycontroller2 =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> qtymycontroller =
      List.generate(500, (ij) => TextEditingController());
  List<TextEditingController> qtymycontroller2 =
      List.generate(500, (ij) => TextEditingController());
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;
  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;

  bool enableModeBtn = true;
  bool freezeScrn = false;
  bool searchbool = false;

  List<SalesModel> salesModel = [];
  List<StocksnapModelData> scannData = [];
  List<searchModel> searchData = [];
  bool validateqty = true;
  bool cancelbtn = false;

  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  TotalPayment? totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;
  List<GlobalKey<FormState>> approvalformkey =
      List.generate(500, (i) => GlobalKey<FormState>());
  double? totwieght2 = 0.0;
  double? totLiter2 = 0.0;
  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String holddocentry = '';

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  bool isApprove = false;
  bool clickAprList = false;

  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  String? totquantity;
  TextEditingController remarkcontroller3 = TextEditingController();

  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  int? adddiscperunit;
  double adjustAmt = 0;
  List<SalesPaytoSalesRetModel> salespaytosalesreturn = [];
  String? sameInvNum;
  String? baldocentry;
  String? baseDocentry;

  String? balquantity;
  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  PaymentWay? payment;
  PaymentWay? get getpayment => payment;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;
  double? mycontlr;
  double salesretrcamt = 0;
  double salesCreditamt = 0;
  double accbal = 0;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  String localDocentry = '';

  int? sapBaseDocentry;
  int? sapBaseDocNum;
  String? sapBaseDocDate;

  String sapDocuNumber = '';
  String? seriesValue;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<OpenSalesOrderHeaderData> searchHeader = [];
  List<OpenSalesOrderHeaderData> filtersearchData = [];

  List<OpenSalesReturnModelData>? salesRetData = [];
  List<OpenSalesReturnModelData>? salesRetCardCodeData = [];

  bool isloading = false;
  String invDocDate = '';
  String nodatamsg = '';
  List<ReturnDocumentLine> sapReturnLineData = [];
  List<Valuess> sapReturValuesData = [];

  List<ErrorModel> sererrorlist = [];
  List<EpenseDataModel> creditNoteType = [
    EpenseDataModel(code: '5', name: 'Reserve Invoice')
  ];
  List<EpenseDataModel> get getCreditNoteType => creditNoteType;
  clearAllData() {
    selectCreditNoteType = null;
    selectCreditNoteCode = null;
    isselectCredit = false;
    cancelbtn = false;
    onHoldFilter = [];
    serialbatchTable = [];
    searchHeader = [];
    salesRetCardCodeData = [];
    searchcontroller.text = '';
    filtersearchData = [];
    seriesType = '';
    uuiDeviceId = '';
    pendingApprovalData = [];
    filterPendingApprovalData = [];
    rejectedData = [];
    filterRejectedData = [];
    filterAprvlData = [];
    searchAprvlData = [];

    salesRetData = [];
    selectedcust = null;
    validateqty = false;
    isloading = false;
    isApprove = false;
    clickAprList = false;
    remarkcontroller3.text = '';
    invDocumentStatus = null;
    srmycontroller[1].text = '';
    srmycontroller[2].text = '';

    salesCreditamt = 0.00;
    srmycontroller = List.generate(500, (i) => TextEditingController());
    formkey = List.generate(500, (i) => GlobalKey<FormState>());
    mycontroller = List.generate(500, (i) => TextEditingController());
    mycontroller2 = List.generate(500, (i) => TextEditingController());
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(500, (ij) => TextEditingController());
    salespaytosalesreturn.clear();
    selectedcust = null;
    paymentWay.clear();
    scanneditemData.clear();
    srmycontroller[1].clear();
    accbal = 0;
    mycontlr = null;
    msgforAmount = null;
    holddocentry = '';
    paymentWay.clear();
    payment = null;
    totalPayment = null;
    salesCreditamt = 0;
    salesretrcamt = 0;
    balquantity = null;
    sameInvNum = null;
    adjustAmt = 0;
    adddiscperunit = null;
    scanneditemData2.clear();
    totquantity = null;
    onHold.clear();
    onHoldFilter = [];
    salesModel = [];
    selectedcust2 = null;
    totLiter = null;
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    totwieght = null;
    totLiter2 = null;
    totwieght2 = null;
    paymentWay2.clear();
    totalPayment2 = null;
    filtersearchData.clear();
    searchbool = false;
    searchData.clear();
    enableModeBtn = true;
    freezeScrn = false;
    salesModel.clear();
    scannData.clear();
    sapBaseDocentry = null;

    itemsValetails = [];
    itemsDocDetails = [];

    clearbutton();
    nullErrorMsg();
  }

  DateTime? currentBackPressTime;
  Future<bool> onbackpress() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Get.offAllNamed<dynamic>(ConstantRoutes.dashboard);
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    selectedcust = null;
    selectedcust55 = null;

    selectedBillAdress = 0;
    selectedShipAdress = 0;
    double? updateCustBal = 0;
    loadingscrn = true;
    holddocentry = '';
    log('message ustomerDetals.taxCode::${customerDetals.taxCode}');

    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        taxCode: customerDetals.taxCode,
        U_CashCust: customerDetals.U_CashCust,
        name: '',
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        point: customerDetals.point,
        accBalance: 0,
        address: [],
        invoiceDate: "",
        invoicenum: '',
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');
    await AccountBalApi.getData(customerDetals.cardCode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        updateCustBal =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      } else {
        updateCustBal = 0;
      }
    });

    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    await CustCreditLimitAPi.getGlobalData(customerDetals.cardCode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditLimitData != null) {
          selectedcust!.creditLimits =
              double.parse(value.creditLimitData![0].creditLine.toString());
          notifyListeners();
        }
      }
    });

    await CustCreditDaysAPI.getGlobalData(customerDetals.cardCode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditDaysData != null) {
          selectedcust!.creditDays =
              value.creditDaysData![0].creditDays.toString();
          selectedcust!.paymentGroup =
              value.creditDaysData![0].paymentGroup.toString().toLowerCase();
          if (selectedcust!.U_CashCust == 'YES') {
            selectedcust!.name = '';
          } else {
            selectedcust!.name = customerDetals.name!;
          }
          notifyListeners();
        }
        loadingscrn = false;
      }
    });
    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        U_CashCust: customerDetals.U_CashCust,
        name: customerDetals.name,
        taxCode: customerDetals.taxCode,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        point: customerDetals.point,
        address: [],
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');
    notifyListeners();
    for (int i = 0; i < customerDetals.address!.length; i++) {
      if (customerDetals.address![i].addresstype == "B") {
        selectedcust!.address!.add(Address(
            autoId: customerDetals.address![i].autoId,
            addresstype: customerDetals.address![i].addresstype,
            address1: customerDetals.address![i].address1,
            address2: customerDetals.address![i].address2,
            address3: customerDetals.address![i].address3,
            billCity: customerDetals.address![i].billCity,
            billCountry: customerDetals.address![i].billCountry,
            billPincode: customerDetals.address![i].billPincode,
            billstate: customerDetals.address![i].billstate));
        notifyListeners();
      }

      if (customerDetals.address![i].addresstype == "S") {
        selectedcust55!.address!.add(Address(
            autoId: customerDetals.address![i].autoId,
            addresstype: customerDetals.address![i].addresstype,
            address1: customerDetals.address![i].address1,
            address2: customerDetals.address![i].address2,
            address3: customerDetals.address![i].address3,
            billCity: customerDetals.address![i].billCity,
            billCountry: customerDetals.address![i].billCountry,
            billPincode: customerDetals.address![i].billPincode,
            billstate: customerDetals.address![i].billstate));
      }
      notifyListeners();
    }
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    if (scanneditemData.isNotEmpty) {
      for (var i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].taxRate = 0.0;
        if (selectedcust!.taxCode == 'O1') {
          scanneditemData[i].taxRate = 18;
        } else {
          scanneditemData[i].taxRate = 0.0;
        }
        notifyListeners();
      }
    }

    notifyListeners();
  }

  List<CustomerDetals> custList2 = [];

  getCustDetFDB() async {
    custList.clear();
    custList2.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<CustomerModelDB> cusdataDB = await DBOperation.getNewApiCstmMasDB(db);

    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    List<Map<String, Object?>> getTopCuslist =
        await DBOperation.getTopCuslist(db);

    for (int i = 1; i < cusdataDB.length; i++) {
      if (cusdataDB[i].customername != "This is my updated name") {
        custList.add(CustomerDetals(
            cardCode: cusdataDB[i].customerCode,
            taxCode: cusdataDB[i].taxCode,
            name: cusdataDB[i].customername,
            U_CashCust: cusdataDB[i].uCashCust,
            phNo: cusdataDB[i].phoneno1,
            accBalance: cusdataDB[i].balance,
            point: cusdataDB[i].points.toString(),
            tarNo: cusdataDB[i].taxno,
            email: cusdataDB[i].emalid,
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: []));
      }
    }
    for (int i = 0; i < custList.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList[i].cardCode == csadresdataDB[ia].custcode) {
          custList[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype,
                address1: csadresdataDB[ia].address1!,
                address2: csadresdataDB[ia].address2!,
                address3: csadresdataDB[ia].address3!,
                billCity: csadresdataDB[ia].city!,
                billCountry: csadresdataDB[ia].countrycode!,
                billPincode: csadresdataDB[ia].pincode!,
                billstate: csadresdataDB[ia].statecode,
              ));
        }
      }
    }

    for (int j = 0; j < getTopCuslist.length; j++) {
      for (int i = 1; i < cusdataDB.length; i++) {
        if (cusdataDB[i].customerCode ==
            getTopCuslist[j]["customercode"].toString()) {
          custList2.add(CustomerDetals(
              cardCode: cusdataDB[i].customerCode,
              taxCode: cusdataDB[i].taxCode,
              U_CashCust: cusdataDB[i].uCashCust,
              name: cusdataDB[i].customername,
              phNo: cusdataDB[i].phoneno1,
              point: cusdataDB[i].points.toString(),
              tarNo: cusdataDB[i].taxno,
              email: cusdataDB[i].emalid,
              invoicenum: '',
              invoiceDate: '',
              totalPayment: 00,
              address: []));
        }
      }
    }
    log("getTopCuslist2:::${custList2.length}");

    for (int i = 0; i < custList2.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList2[i].cardCode == csadresdataDB[ia].custcode) {
          custList2[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype,
                address1: csadresdataDB[ia].address1!,
                address2: csadresdataDB[ia].address2!,
                address3: csadresdataDB[ia].address3!,
                billCity: csadresdataDB[ia].city!,
                billCountry: csadresdataDB[ia].countrycode!,
                billPincode: csadresdataDB[ia].pincode!,
                billstate: csadresdataDB[ia].statecode,
              ));
        }
      }
    }

    filtercustList = custList;
    notifyListeners();
  }

  validateUDF(BuildContext context) {
    if (selectCreditNoteType == null) {
      isselectCredit = true;
      notifyListeners();
    } else {
      isselectCredit = false;
      for (var i = 0; i < creditNoteType.length; i++) {
        if (creditNoteType[i].name == selectCreditNoteType) {
          selectCreditNoteCode = creditNoteType[i].code;
          notifyListeners();
        }
      }
      Navigator.pop(context);
      notifyListeners();
    }
    notifyListeners();
  }

  callSearchHeaderApi() async {
    await SerachReturnHeaderAPi.getGlobalData(
            config.alignDate2(mycontroller[100].text),
            config.alignDate2(mycontroller[101].text))
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        searchHeader = value.activitiesData!;

        filtersearchData = searchHeader;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  callSerlaySalesReturnAPI(BuildContext context, ThemeData theme) async {
    await SerlaySalesReturnAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.returnvalue!.isNotEmpty) {
          sapReturnLineData = value.returnvalue!;

          for (int i = 0; i < sapReturValuesData.length; i++) {
            custserieserrormsg = '';
          }
        } else {}
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;

        custserieserrormsg = value.error!.message!.value.toString();
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
                      content: '$custserieserrormsg',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust2 = null;
          paymentWay2.clear();
          scanneditemData2.clear();

          notifyListeners();
        });
        notifyListeners();
      } else {}
    });
  }

  filterList(String v) async {
    if (v.isNotEmpty) {
      filtercustList = custList
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.name!.toLowerCase().contains(v.toLowerCase()))
          .toList();

      notifyListeners();
    } else if (v.isEmpty) {
      filtercustList = custList;

      notifyListeners();
    }
  }

  refresCufstList() {
    filtercustList = custList;

    notifyListeners();
  }

  callGetSalesRetCardCodeApi(BuildContext context, String cardCode) async {
    salesRetCardCodeData = [];
    searchcontroller.text = '';
    scanneditemData = [];
    await SalesReturnQryCardCodeApi.getGlobalData(AppConstant.branch, cardCode)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData!.isNotEmpty) {
          sapBaseDocNum = int.parse(value.activitiesData![0].docNum.toString());
          sapBaseDocDate = value.activitiesData![0].docDate.toString();
          log('sapBaseDocDate:::${sapBaseDocDate}');
          salesRetCardCodeData = value.activitiesData!;

          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: SingleChildScrollView(
                      child: Container(
                        width: Screens.width(context) * 0.3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.blue,
                                  )),
                            ),
                            Container(
                              height: Screens.padingHeight(context) * 0.5,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: salesRetCardCodeData!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () async {
                                        Get.back();

                                        srmycontroller[1].text =
                                            salesRetCardCodeData![index]
                                                .docNum
                                                .toString();

                                        await callGetSalesRetApi(
                                            context, srmycontroller[1].text);
                                      },
                                      child: Container(
                                        child: Card(
                                          margin: EdgeInsets.all(1),
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.05,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                      salesRetCardCodeData![
                                                              index]
                                                          .docNum
                                                          .toString()),
                                                ),
                                                Container(
                                                  height: Screens.padingHeight(
                                                          context) *
                                                      0.05,
                                                  alignment: Alignment.center,
                                                  child: Text(config.alignDate(
                                                      salesRetCardCodeData![
                                                              index]
                                                          .docDate
                                                          .toString())),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ));
              });

          notifyListeners();
        } else {}
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(child: Text('${value.error}')),
                    buttonName: null,
                  ));
            });
        isloading = false;
        notifyListeners();
      } else {
        isloading = false;
      }
    });
    notifyListeners();
  }

  List<Invbatch>? serialbatchTable;

  callGetSalesRetApi(BuildContext context, String docNum) async {
    isloading = true;
    scanneditemData = [];
    serialbatchTable = [];
    await SalesReturnQryApi.getGlobalData(AppConstant.branch, docNum)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData!.isNotEmpty) {
          sapBaseDocNum = int.parse(value.activitiesData![0].docNum.toString());
          sapBaseDocDate = value.activitiesData![0].docDate.toString();
          if (selectedcust == null) {
            addCustomer2(value.activitiesData![0].cardCode.toString());
          }
          if (selectedcust != null) {
            selectedcust!.name = value.activitiesData![0].cardName;
          }
          log('sapBaseDocDate:::${sapBaseDocDate}');
          salesRetData = value.activitiesData!;

          for (var i = 0; i < value.activitiesData!.length; i++) {
            scanneditemData.add(StocksnapModelData(
              branch: AppConstant.branch,
              itemCode: value.activitiesData![i].itemCode,
              itemName: value.activitiesData![i].itemName,
              serialBatch: value.activitiesData![i].batchNum,
              openRetQty: value.activitiesData![i].Qty,
              taxRate: 0,
              mrp: value.activitiesData![i].price,
              sellPrice: value.activitiesData![i].price,
              taxCode: value.activitiesData![i].taxCode,
              discountper: value.activitiesData![i].discount,
              baselineid: value.activitiesData![i].lineNum.toString(),
              basedocentry: value.activitiesData![i].docEntry.toString(),
            ));
            qtymycontroller[i].text = value.activitiesData![i].Qty.toString();

            serialbatchTable!.add(Invbatch(
                batchNumberProperty: value.activitiesData![i].batchNum,
                quantity: value.activitiesData![i].Qty,
                itemCode: value.activitiesData![i].itemCode,
                lineId: value.activitiesData![i].lineNum));
          }
          isloading = false;

          if (selectedcust != null) {
            selectedcust!.name = value.activitiesData![0].cardName ?? '';
            selectedcust!.invoiceDate =
                value.activitiesData![0].docDate.toString();
            selectedcust!.invoicenum =
                value.activitiesData![0].docNum.toString();
          }
          if (scanneditemData.isNotEmpty) {
            for (var i = 0; i < scanneditemData.length; i++) {
              scanneditemData[i].taxRate = 0.0;
              if (selectedcust!.taxCode == 'O1') {
                scanneditemData[i].taxRate = 18;
              } else {
                scanneditemData[i].taxRate = 0.0;
              }
              notifyListeners();
            }
            calCulateDocVal();
          }

          notifyListeners();
        } else {
          await showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Container(
                          padding: EdgeInsets.only(
                              top: Screens.padingHeight(context) * 0.02),
                          child: Center(child: Text('No Data Found'))),
                      buttonName: null,
                    ));
              });
          isloading = false;
          srmycontroller[1].text = '';
          searchcontroller.text = '';
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(child: Text('${value.error}')),
                    buttonName: null,
                  ));
            });
        isloading = false;
        notifyListeners();
      } else {
        isloading = false;
      }
    });
    notifyListeners();
  }

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[100].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[101].text = datetype!;
    } else {}
  }

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchHeader
          .where((e) =>
              e.cardName.toLowerCase().contains(v.toLowerCase()) ||
              e.cardCode.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchHeader;
      notifyListeners();
    }
  }

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getdbSaleretheader =
        await DBOperation.getSalesRetHeadDB(db, docentry);
    List<Map<String, Object?>> getdbSaleretline =
        await DBOperation.grtSalesRetLineDB(
            db, int.parse(getdbSaleretheader[0]['docentry'].toString()));
    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(
            db, int.parse(getdbSaleretheader[0]['docentry'].toString()));
    scanneditemData2.clear();
    sapDocuNumber = '';
    sapDocentry = '';
    totalPayment2 = null;
    totwieght2 = 0.0;
    totLiter2 = 0.0;
    selectedcust2 = null;
    mycontroller2[50].text = "";
    paymentWay2.clear();
    if (getdbSaleretheader.isNotEmpty) {
      totwieght2 =
          double.parse(getdbSaleretheader[0]["totalweight"].toString()) ?? 0;
      totLiter2 =
          double.parse(getdbSaleretheader[0]["totalltr"].toString()) ?? 0;

      mycontroller2[50].text = getdbSaleretheader[0]["remarks"].toString();

      sapDocentry = getdbSaleretheader[0]["sapDocentry"] != null
          ? getdbSaleretheader[0]["sapDocentry"].toString()
          : "";
      sapDocuNumber = getdbSaleretheader[0]["sapDocNo"] != null
          ? getdbSaleretheader[0]["sapDocNo"].toString()
          : "";
      for (int i = 0; i < getdbSaleretline.length; i++) {
        scanneditemData2.add(StocksnapModelData(
            invoiceNo: getdbSaleretline[i]['documentno'].toString() ?? "",
            transID: int.parse(getdbSaleretline[i]['lineID'].toString()) ?? 0,
            branch: getdbSaleretline[i]['branch'].toString(),
            itemCode: getdbSaleretline[i]['itemcode'].toString(),
            itemName: getdbSaleretline[i]['itemcode'].toString(),
            serialBatch: getdbSaleretline[i]['serialbatch'].toString() ?? "",
            openQty:
                double.parse(getdbSaleretline[i]['quantity'].toString()) ?? 0,
            qty: double.parse(getdbSaleretline[i]['quantity'].toString()) ?? 0,
            inDate: getdbSaleretline[i][''].toString(),
            inType: getdbSaleretline[i][''].toString(),
            mrp: 0,
            sellPrice:
                double.parse(getdbSaleretline[i]['price'].toString()) ?? 0,
            cost: 0,
            taxRate:
                double.parse(getdbSaleretline[i]['taxrate'].toString()) ?? 0,
            maxdiscount: getdbSaleretline[i]['discperc'] != null
                ? getdbSaleretline[i]['discperc'].toString()
                : '',
            discountper: getdbSaleretline[i]['discperc'] != null
                ? double.parse(getdbSaleretline[i]['discperc'].toString())
                : 0,
            taxvalue: getdbSaleretline[i]['taxtotal'] != null
                ? double.parse(getdbSaleretline[i]['taxtotal'].toString())
                : 0.0,
            liter: getdbSaleretline[i]['liter'] != null
                ? double.parse(getdbSaleretline[i]['liter'].toString())
                : 0.0,
            weight: getdbSaleretline[i]['weight'] != null
                ? double.parse(getdbSaleretline[i]['weight'].toString())
                : 0.0));
        qtymycontroller2[i].text =
            getdbSaleretline[i]['quantity'].toString() ?? '0';
        notifyListeners();
      }
      double? totalPay = 0;
      for (int iss = 0; iss < scanneditemData2.length; iss++) {
        totalPay = totalPay! + scanneditemData2[iss].qty!;
        notifyListeners();
      }

      selectedcust2 = CustomerDetals(
          name: getdbSaleretheader[0]["customername"].toString(),
          phNo: getdbSaleretheader[0]["customerphono"].toString(),
          cardCode: getdbSaleretheader[0]["customercode"].toString(),
          U_CashCust: '',
          accBalance:
              double.parse(getdbSaleretheader[0]["customeraccbal"].toString()),
          point: getdbSaleretheader[0]["customerpoint"].toString(),
          address: [
            Address(
                address1: getdbSaleretheader[0]['billaddressid'].toString(),
                billCity: getdbSaleretheader[0]['city'].toString(),
                billCountry: getdbSaleretheader[0]['country'].toString(),
                billPincode: getdbSaleretheader[0]['pinno'].toString(),
                billstate: getdbSaleretheader[0]['state'].toString())
          ],
          tarNo: getdbSaleretheader[0]["taxno"].toString(),
          email: getdbSaleretheader[0]["customeremail"].toString(),
          invoiceDate: getdbSaleretheader[0]["createdateTime"].toString(),
          invoicenum: getdbSaleretheader[0]["documentno"].toString(),
          docentry: getdbSaleretheader[0]["docentry"].toString(),
          totalPayment: getdbSaleretheader[0]["doctotal"] == null ||
                  getdbSaleretheader[0]["doctotal"].toString().isEmpty
              ? 0.0
              : double.parse(getdbSaleretheader[0]["doctotal"]
                  .toString()
                  .replaceAll(',', '')));

      totalPayment2 = TotalPayment(
        subtotal: double.parse(getdbSaleretheader[0]['docbasic'] == null
            ? '0'
            : getdbSaleretheader[0]['docbasic'].toString().replaceAll(',', '')),
        discount2: double.parse(
            getdbSaleretheader[0]['docdiscamt'].toString().replaceAll(',', '')),
        totalTX: double.parse(
            getdbSaleretheader[0]['taxamount'].toString().replaceAll(',', '')),
        discount: double.parse(
            getdbSaleretheader[0]['docdiscamt'].toString().replaceAll(',', '')),
        total: totalPay != 0 ? totalPay : 0,
        totalDue: double.parse(getdbSaleretheader[0]['amtpaid'] == null
            ? '0'
            : getdbSaleretheader[0]['amtpaid'].toString().replaceAll(',', '')),
        totpaid: double.parse(getdbSaleretheader[0]['amtpaid'] == null
            ? '0'
            : getdbSaleretheader[0]['amtpaid'].toString().replaceAll(',', '')),
        balance: double.parse(
            getdbSaleretheader[0]['baltopay'].toString().replaceAll(',', '')),
      );

      for (int j = 0; j < getdbSaleretpay.length; j++) {
        paymentWay2.add(PaymentWay(
          amt: getdbSaleretpay[j]['rcamount'] != null
              ? double.parse(getdbSaleretpay[j]['rcamount'].toString())
              : null,
          type: getdbSaleretpay[j]['rcmode'].toString(),
          reference: getdbSaleretpay[j]['reference'] != null
              ? getdbSaleretpay[j]['reference'].toString()
              : '',
        ));
      }
    }
    notifyListeners();
  }

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isEmpty) {
      cancelbtn = false;
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
                    content: 'Something went Wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust2 = null;
        paymentWay2.clear();
        scanneditemData2.clear();
        notifyListeners();
        notifyListeners();
      });
    } else {
      await sapReturnLoginApi();
      await callSerlaySalesReturnAPI(context, theme);
      await callReturnCancelAPI(context, theme);
      notifyListeners();
    }
  }

  sapReturnLoginApi() async {
    final pref2 = await pref;

    await PostReturnLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          AppConstant.sapSessionID = '';
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
      } else {
        const snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    notifyListeners();
  }

  seststate1() {
    notifyListeners();
  }

  bool searchLoading = false;
  callGetReturnApi(
      BuildContext context, ThemeData theme, String Docentry) async {
    await sapReturnLoginApi();

    sapReturnLineData = [];
    scanneditemData2 = [];
    mycontroller2[50].text = "";
    await SerlaySalesReturnAPI.getData(Docentry.toString()).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        mycontroller2[50].text = value.comments ?? '';

        if (value.returnvalue!.isNotEmpty) {
          sapReturnLineData = value.returnvalue!;

          for (int i = 0; i < sapReturnLineData.length; i++) {
            scanneditemData2.add(StocksnapModelData(
                branch: AppConstant.branch,
                itemCode: sapReturnLineData[i].itemCode.toString(),
                itemName: sapReturnLineData[i].itemDescription,
                serialBatch: '',
                qty: sapReturnLineData[i].quantity,
                openQty: sapReturnLineData[i].quantity,
                openRetQty: sapReturnLineData[i].quantity,
                discountper: sapReturnLineData[i].discountPercent ?? 0,
                mrp: 0,
                sellPrice: sapReturnLineData[i].unitPrice));
          }
          if (scanneditemData2.isNotEmpty) {
            for (int ik = 0; ik < scanneditemData2.length; ik++) {
              qtymycontroller2[ik].text =
                  scanneditemData2[ik].openQty.toString();
            }
            addCustomer2(value.cardCode.toString());
          }
        } else {}
        searchLoading = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        searchLoading = false;

        custserieserrormsg = value.error!.message!.value.toString();
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
                      content: '$custserieserrormsg',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust2 = null;
          paymentWay2.clear();
          scanneditemData2.clear();

          notifyListeners();
        });
        notifyListeners();
      } else {
        searchLoading = false;
      }
    });
    Get.back();
    notifyListeners();
  }

  callReturnCancelAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapReturnLineData.isNotEmpty) {
      if (sapReturnLineData[0].lineStatus.toString() == "bost_Open") {
        await SerlayReturnCancelAPI.getData(sapDocentry.toString())
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 204) {
            cancelbtn = false;

            await DBOperation.updateSaleRetclosedocsts(
                db, sapDocentry.toString());

            await Get.defaultDialog(
                    title: "Success",
                    middleText: 'Document is successfully cancelled ..!!',
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
              sapDocentry = '';
              sapDocuNumber = '';
              selectedcust2 = null;
              scanneditemData2.clear();
              selectedcust55 = null;
            });
            custserieserrormsg = '';
          } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
            cancelbtn = false;
            custserieserrormsg = value.exception!.message!.value.toString();
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                      contentPadding: const EdgeInsets.all(0),
                      content: AlertBox(
                        payMent: 'Alert',
                        errormsg: true,
                        widget: Center(
                            child: ContentContainer(
                          content: '$custserieserrormsg',
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {
              sapDocentry = '';
              sapDocuNumber = '';
            });
          } else {}
        });
      } else if (sapReturnLineData[0].lineStatus == "bost_Close") {
        cancelbtn = false;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Document is already closed',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';

          selectedcust2 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
        notifyListeners();
      }
    }
    Get.back();
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesRetHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          sapDocNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          qStatus: getSalesHeader[i]["qStatus"] == null
              ? ""
              : getSalesHeader[i]["qStatus"].toString(),
          docentry: getSalesHeader[i]["docentry"] == null
              ? 0
              : int.parse(getSalesHeader[i]["docentry"].toString()),
          docNo: getSalesHeader[i]["documentno"] == null
              ? "0"
              : getSalesHeader[i]["documentno"].toString(),
          docDate: getSalesHeader[i]["createdateTime"].toString(),
          sapNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          sapDate: getSalesHeader[i]["createdateTime"] == null
              ? ""
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: getSalesHeader[i]["customername"].toString(),
          doctotal: getSalesHeader[i]["baltopay"] == null
              ? 0
              : double.parse(getSalesHeader[i]["baltopay"]
                  .toString()
                  .replaceAll(',', ''))));
    }
    searchData.addAll(searchdata2);

    searchbool = false;
    notifyListeners();
  }

  String? basedocentryonqtyck;
  addCustomer(String cardCode, String cardName) async {
    double? updateCustBal;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, cardCode.toString());

    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(db, cardCode.toString());
    if (custData.isNotEmpty) {
      selectedcust = CustomerDetals(
        name: cardName ?? "",
        phNo: custData[0]['phoneno1'].toString() ?? '',
        U_CashCust: custData[0]['U_CASHCUST'].toString() ?? '',
        cardCode: custData[0]['customerCode'].toString() ?? '',
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
        taxCode: custData[0]['TaxCode'].toString(),
        invoicenum: sapBaseDocNum.toString(),
        invoiceDate: sapBaseDocDate.toString(),
        docentry: scanneditemData[0].basedocentry.toString(),
      );
      notifyListeners();

      selectedcust55 = CustomerDetals(
        autoId: custData[0]['autoid'].toString(),
        name: custData[0]['customername'].toString(),
        U_CashCust: custData[0]['U_CASHCUST'].toString() ?? '',
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customerCode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        taxCode: custData[0]['TaxCode'].toString(),
        tarNo: custData[0]['taxno'].toString(),
      );
      notifyListeners();

      for (int i = 0; i < getcustaddd.length; i++) {
        log('getcustaddd addresstype::${getcustaddd[i]['addresstype'].toString()}');
        if (getcustaddd[i]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(Address(
            autoId: int.parse(getcustaddd[i]['autoid'].toString()),
            addresstype: getcustaddd[i]['addresstype'].toString(),
            address1: getcustaddd[i]['address1'].toString(),
            address2: getcustaddd[i]['address2'].toString(),
            address3: getcustaddd[i]['address3'].toString(),
            billCity: getcustaddd[i]['city'].toString(),
            billCountry: getcustaddd[i]['countrycode'].toString(),
            billPincode: getcustaddd[i]['pincode'].toString(),
            billstate: getcustaddd[i]['statecode'].toString(),
          ));
          notifyListeners();
        }
        log('address1::${getcustaddd[i]['address1'].toString()}:::${selectedcust!.address!.length}');

        notifyListeners();

        if (getcustaddd[i]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(Address(
            autoId: int.parse(getcustaddd[i]['autoid'].toString()),
            addresstype: getcustaddd[i]['addresstype'].toString(),
            address1: getcustaddd[i]['address1'].toString(),
            address2: getcustaddd[i]['address2'].toString(),
            address3: getcustaddd[i]['address3'].toString(),
            billCity: getcustaddd[i]['city'].toString(),
            billCountry: getcustaddd[i]['countrycode'].toString(),
            billPincode: getcustaddd[i]['pincode'].toString(),
            billstate: getcustaddd[i]['statecode'].toString(),
          ));
          notifyListeners();
        }
      }

      notifyListeners();

      await AccountBalApi.getData(selectedcust!.cardCode.toString())
          .then((value) {
        loadingscrn = false;
        if (value.statuscode >= 200 && value.statuscode <= 210) {
          updateCustBal =
              double.parse(value.accBalanceData![0].balance.toString());
          notifyListeners();
        }
      });
      selectedcust!.accBalance =
          updateCustBal ?? double.parse(custData[0]['balance'].toString());
      selectedcust55!.accBalance =
          updateCustBal ?? double.parse(custData[0]['balance'].toString());
      for (var i = 0; i < scanneditemData.length; i++) {
        if (selectedcust!.taxCode == 'O1') {
          scanneditemData[i].taxRate = 18;
        } else {
          scanneditemData[i].taxRate = 0.0;
        }
        notifyListeners();
      }
      notifyListeners();
      calCulateDocVal();
    }
    notifyListeners();
  }

  addCustomer2(String cardCode) async {
    double? updateCustBal;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, cardCode.toString());

    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(db, cardCode.toString());
    selectedcust2 = CustomerDetals(
      autoId: custData[0]['autoid'].toString(),
      name: custData[0]['customername'].toString(),
      U_CashCust: custData[0]['U_CASHCUST'].toString() ?? '',
      phNo: custData[0]['phoneno1'].toString(),
      cardCode: custData[0]['customerCode'].toString(),
      accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
      taxCode: custData[0]['TaxCode'].toString(),
      invoicenum: '',
      invoiceDate: '',
      docentry: scanneditemData2[0].basedocentry.toString(),
    );
    notifyListeners();

    notifyListeners();

    for (int i = 0; i < getcustaddd.length; i++) {
      log('getcustaddd addresstype::${getcustaddd[i]['addresstype'].toString()}');
      if (getcustaddd[i]['addresstype'].toString() == "B") {
        selectedcust2!.address!.add(Address(
          autoId: int.parse(getcustaddd[i]['autoid'].toString()),
          addresstype: getcustaddd[i]['addresstype'].toString(),
          address1: getcustaddd[i]['address1'].toString(),
          address2: getcustaddd[i]['address2'].toString(),
          address3: getcustaddd[i]['address3'].toString(),
          billCity: getcustaddd[i]['city'].toString(),
          billCountry: getcustaddd[i]['countrycode'].toString(),
          billPincode: getcustaddd[i]['pincode'].toString(),
          billstate: getcustaddd[i]['statecode'].toString(),
        ));
        notifyListeners();
      }
      log('address1::${getcustaddd[i]['address1'].toString()}:::${selectedcust2!.address!.length}');

      notifyListeners();
    }

    notifyListeners();

    await AccountBalApi.getData(selectedcust2!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        updateCustBal =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    selectedcust2!.accBalance = updateCustBal ?? 0;

    for (var i = 0; i < scanneditemData2.length; i++) {
      if (selectedcust2!.taxCode == 'O1') {
        scanneditemData2[i].taxRate = 18;
      } else {
        scanneditemData2[i].taxRate = 0.0;
      }
      notifyListeners();
    }
    calCulateDocVal2();

    notifyListeners();

    notifyListeners();
  }

  invoiceScan(BuildContext context, ThemeData theme) async {
    salesCreditamt = 0;
    int? indx = await invoiceBatchAvail(
        srmycontroller[1].text.toString().toUpperCase().trim(), context, theme);
    if (indx != null) {
      if (scanneditemData.isEmpty) {
        await addCustomer('', '');
        await addProductValue(indx);
        calCulateDocVal();
        btnEnabledfn();
        notifyListeners();
      }
    } else {
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getsalesretrunvaltDB =
          await DBOperation.getsalesretrunalertDB(
              db, srmycontroller[1].text.toString().toUpperCase().trim());
      if (getsalesretrunvaltDB.isNotEmpty) {
        log("Step51::${getsalesretrunvaltDB[0]['basedocnum'].toString()} && ${srmycontroller[1].text.toString().toUpperCase().trim()}");

        if (srmycontroller[1].text.toString().toUpperCase().trim() ==
            getsalesretrunvaltDB[0]['basedocnum'].toString().trim()) {
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
                        content: 'This Document is Already Returned..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
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
                      content: 'Wrong Document Scanned..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }

    totalcalculate();
    srmycontroller[1].text = '';
  }

  clearData() {
    selectedcust = null;

    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    selectedcust = null;
    selectedcust55 = null;
    validateqty = false;
    selectCreditNoteType = null;
    selectCreditNoteCode = null;
    isselectCredit = false;
    remarkcontroller3.text = '';
    mycontroller[50].clear();
    paymentWay.clear();
    totalPayment = null;
    srmycontroller[1].text = "";
    scanneditemData = [];
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: "Data Cleared Sucessfully..!!",
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
      freezeScrn = false;
      notifyListeners();
    });
  }

  Future<int?> checkSameserialBatchScnd(String invc) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].invoiceNo == invc) {
        if (scanneditemData[i].qty == null) {
          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  addProductValue(ik) async {
    addProductItem(ik);
    notifyListeners();
    calCulateDocVal();

    notifyListeners();
  }

  addProductItem(int ins) {
    for (int i = 0; i < salesModel[ins].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          basedocentry: salesModel[ins].item![i].basedocentry,
          baselineid: salesModel[ins].item![i].baselineid,
          basic: salesModel[ins].item![i].basic,
          discount: salesModel[ins].item![i].discount,
          netvalue: salesModel[ins].item![i].netvalue,
          taxable: salesModel[ins].item![i].taxable,
          taxvalue: salesModel[ins].item![i].taxvalue ?? 00,
          transID: salesModel[ins].item![i].transID,
          branch: salesModel[ins].item![i].branch,
          itemCode: salesModel[ins].item![i].itemCode,
          itemName: salesModel[ins].item![i].itemName,
          serialBatch: salesModel[ins].item![i].serialBatch,
          openQty: salesModel[ins].item![i].openQty,
          qty: salesModel[ins].item![i].qty,
          inDate: salesModel[ins].item![i].inDate,
          inType: salesModel[ins].item![i].inType,
          mrp: salesModel[ins].item![i].mrp,
          sellPrice: salesModel[ins].item![i].sellPrice,
          cost: salesModel[ins].item![i].cost,
          taxRate: salesModel[ins].item![i].taxRate,
          invoiceNo: salesModel[ins].item![i].invoiceNo,
          maxdiscount: salesModel[ins].item![i].maxdiscount,
          discountper: salesModel[ins].item![i].discountper,
          liter: salesModel[ins].item![i].liter,
          weight: salesModel[ins].item![i].weight));

      notifyListeners();
    }
    qtychangemtd(ins);

    calCulateDocVal();
    notifyListeners();
  }

  qtychangemtd(int ind) {
    for (int ir = 0; ir < scanneditemData.length; ir++) {
      qtymycontroller[ir].text = scanneditemData[ir].qty.toString();
    }
  }

  callSerlaySalesQuoAPI() async {
    invDocumentStatus = null;
    await SerlaySalesInvoiceAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        invDocumentStatus = value.documentStatus;
        custserieserrormsg = '';
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.error!.message!.value.toString();
        Get.defaultDialog(
                title: "Alert",
                middleText: '$custserieserrormsg',
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
          freezeScrn = false;

          notifyListeners();
        });
      }
    });
  }

  Future<int?> invoiceBatchAvail(
      String invcno, BuildContext context, ThemeData theme) async {
    salesModel = [];
    scannData = [];
    scanneditemData = [];
    selectedcust = null;
    totLiter = 0.00;
    totwieght = 0.00;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.salestosalesret(db, invcno.toString().trim());
    for (int i = 0; i < getDBholddata1.length; i++) {
      if (getDBholddata1[i]['sapDocNo'].toString() == invcno) {
        List<Map<String, Object?>> getDBholdSalesLine =
            await DBOperation.saleslinegetbalqty(
                db, getDBholddata1[i]['docentry'].toString());
        if (getDBholdSalesLine.isNotEmpty) {
          baldocentry = getDBholddata1[i]['docentry'].toString();
          sameInvNum = getDBholddata1[i]['documentno'].toString();
          sapDocentry = getDBholddata1[i]['sapDocentry'].toString();
          sapDocuNumber = getDBholddata1[i]['sapDocNo'].toString();
          sapBaseDocentry =
              int.parse(getDBholddata1[i]['sapDocentry'].toString());
          totLiter = double.parse(getDBholddata1[i]['totalltr'].toString());
          totwieght = double.parse(getDBholddata1[i]['totalweight'].toString());
          for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
            scannData.add(StocksnapModelData(
              basedocentry: getDBholddata1[i]['docentry'].toString(),
              baselineid: getDBholdSalesLine[ik]['lineID'].toString(),
              invoiceNo: getDBholddata1[i]['documentno'].toString(),
              transID: int.parse(getDBholdSalesLine[ik]['lineID'].toString()),
              branch: getDBholdSalesLine[ik]['branch'].toString(),
              itemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
              itemName: getDBholdSalesLine[ik]['itemname'].toString(),
              serialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
              openQty:
                  double.parse(getDBholdSalesLine[ik]['quantity'].toString()),
              qty: double.parse(getDBholdSalesLine[ik]['balqty'].toString()),
              inDate: getDBholdSalesLine[ik][''].toString(),
              inType: getDBholdSalesLine[ik][''].toString(),
              mrp: 0,
              sellPrice:
                  double.parse(getDBholdSalesLine[ik]['price'].toString()),
              cost: 0,
              taxRate:
                  double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
              maxdiscount: getDBholdSalesLine[ik]['discperc'] != null
                  ? getDBholdSalesLine[ik]['discperc'].toString()
                  : '',
              discountper: getDBholdSalesLine[ik]['discperc'] != null
                  ? double.parse(getDBholdSalesLine[ik]['discperc'].toString())
                  : null,
              liter: getDBholdSalesLine[ik]['liter'] == null
                  ? 0.00
                  : double.parse(getDBholdSalesLine[ik]['liter'].toString()),
              weight: getDBholdSalesLine[ik]['weight'] == null
                  ? 0.00
                  : double.parse(getDBholdSalesLine[ik]['weight'].toString()),
            ));
          }
          notifyListeners();

          List<Map<String, Object?>> getDBholdSalespaydk =
              await DBOperation.getSalespaycreditCkout(
            db,
            int.parse(getDBholddata1[i]['docentry'].toString()),
          );
          for (int ii = 0; ii < getDBholdSalespaydk.length; ii++) {
            if (getDBholddata1[i]['docentry'].toString() ==
                getDBholdSalespaydk[ii]['docentry'].toString()) {
              salespaytosalesreturn.add(SalesPaytoSalesRetModel(
                  salesrcmode: getDBholdSalespaydk[ii]['rcmode'].toString(),
                  salesrcamt: double.parse(
                      getDBholdSalespaydk[ii]['rcamount'].toString()),
                  docentry: getDBholddata1[i]['docentry'].toString()));
              notifyListeners();
            }
          }

          List<Map<String, Object?>> getadjustamt =
              await DBOperation.adjustcreditamt(
                  db, int.parse(getDBholddata1[i]['docentry'].toString()));
          for (int iv = 0; iv < getadjustamt.length; iv++) {
            adjustAmt =
                double.parse(getadjustamt[iv]['adjustedamt'].toString());
          }
          List<Address> addressadd = [];
          List<Map<String, Object?>> csadresdataDB =
              await DBOperation.addgetCstmMasAddDB(
                  db, getDBholddata1[i]['customercode'].toString());
          for (int ia = 0; ia < csadresdataDB.length; ia++) {
            addressadd.add(Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ));
          }

          SalesModel salesM = SalesModel(
            totaldue: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            docentry: int.parse(getDBholddata1[i]['docentry'].toString()),
            transdocentry: getDBholddata1[i]['docentry'].toString(),
            custName: getDBholddata1[i]['customername'].toString(),
            taxCode: getDBholddata1[i]['taxCode'].toString(),
            phNo: getDBholddata1[i]['customerphono'].toString(),
            cardCode: getDBholddata1[i]['customercode'].toString(),
            accBalance: getDBholddata1[i]['customeraccbal'].toString(),
            point: getDBholddata1[i]['customerpoint'].toString(),
            tarNo: getDBholddata1[i]['taxno'] != null
                ? getDBholddata1[i]['taxno'].toString()
                : '',
            email: getDBholddata1[i]['customeremail'] != null
                ? getDBholddata1[i]['customeremail'].toString()
                : "",
            invoceDate: getDBholddata1[i]['createdateTime'].toString(),
            invoiceNum: getDBholddata1[i]['documentno'].toString(),
            invoceAmount: double.parse(getDBholddata1[i]['doctotal'] == null
                ? '0'
                : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
            address: addressadd,
            totalPayment: TotalPayment(
              totalTX: double.parse(getDBholddata1[i]['taxamount'] == null
                  ? '0'
                  : getDBholddata1[i]['taxamount'].toString()),
              subtotal: double.parse(getDBholddata1[i]['docbasic'] == null
                  ? '0'
                  : getDBholddata1[i]['docbasic']
                      .toString()
                      .replaceAll(',', '')),
              discount2: double.parse(getDBholddata1[i]['docdiscamt'] != null
                  ? getDBholddata1[i]['docdiscamt'].toString()
                  : '0'),
              discount: double.parse(getDBholddata1[i]['docdiscamt'] != null
                  ? getDBholddata1[i]['docdiscamt'].toString()
                  : '0'),
              totalDue: double.parse(getDBholddata1[i]['doctotal'] == null
                  ? '0'
                  : getDBholddata1[i]['doctotal']
                      .toString()
                      .replaceAll(',', '')),
              totpaid: double.parse(getDBholddata1[i]['amtpaid'] == null
                  ? '0'
                  : getDBholddata1[i]['amtpaid']
                      .toString()
                      .replaceAll(',', '')),
              balance: double.parse(getDBholddata1[i]['baltopay'] != null
                  ? getDBholddata1[i]['baltopay'].toString().replaceAll(',', '')
                  : '0'),
            ),
            item: scannData,
          );
          notifyListeners();

          salesModel.add(salesM);
          notifyListeners();

          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  balanceqtycheck(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log("basedocentryonqtyck::$basedocentryonqtyck");
    validateqty = true;
    List<Map<String, Object?>> getSalRethead =
        await DBOperation.getSalesRetHeaderDB(db, baldocentry.toString());
    if (getSalRethead.isNotEmpty) {
      List<Map<String, Object?>> getDBSalesLine =
          await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
      if (getDBSalesLine.isNotEmpty) {
        for (int i = 0; i < scanneditemData.length; i++) {
          for (int ik = 0; ik < getDBSalesLine.length; ik++) {
            if (int.parse(getDBSalesLine[ik]['balqty'].toString()) >=
                int.parse(qtymycontroller[i].text)) {
              validateqty = true;
            } else {
              validateqty = false;
              break;
            }
          }
        }
      }
    } else {
      List<Map<String, Object?>> getDBholdSalesLine =
          await DBOperation.saleslinegetbalqty(db, baldocentry.toString());
      for (int i = 0; i < scanneditemData.length; i++) {
        for (int ih = 0; ih < getDBholdSalesLine.length; ih++) {
          if (int.parse(getDBholdSalesLine[ih]['balqty'].toString()) >=
              int.parse(qtymycontroller[i].text)) {
            validateqty = true;
          } else {
            validateqty = false;
            break;
          }
        }
      }
    }
  }

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);
    for (int i = 0; i < scannData.length; i++) {
      if (scannData[i].serialBatch == scanneditemData[ind].serialBatch) {
        if (scannData[i].qty! > qtyctrl) {
          qtyctrl = qtyctrl + 1;
          qtymycontroller[ind].text = qtyctrl.toString();
          FocusScopeNode focus = FocusScope.of(context);
          calCulateDocVal();

          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
          notifyListeners();
          break;
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
                        content: 'No more qty to add..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
          notifyListeners();

          break;
        }
      }
    }
    notifyListeners();
  }

  itemIncrement11(int ind, BuildContext context, ThemeData theme) {
    log('message2222::${salesRetData!.length}');
    for (int i = 0; i < salesRetData!.length; i++) {
      if (salesRetData![i].batchNum.toString() ==
          scanneditemData[ind].serialBatch.toString()) {
        if (salesRetData![i].Qty >= double.parse(qtymycontroller[ind].text)) {
          if (double.parse(qtymycontroller[ind].text) != 0) {
            calCulateDocVal();
            FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus) {
              focus.unfocus();
            }
            notifyListeners();
          } else if (qtymycontroller[ind].text == '0') {
            log('message11');
            qtymycontroller.removeAt(ind);
            mycontroller.removeAt(ind);
            scanneditemData.removeAt(ind);

            calCulateDocVal();
            notifyListeners();
          }
        } else {
          qtymycontroller[ind].text = salesRetData![i].Qty.toString();
          FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
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
                        content: 'No more qty to add..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
          notifyListeners();

          break;
        }
      }
    }

    notifyListeners();
  }

  itemdecrement(int ind) {
    if (scanneditemData[ind].qty! > 1) {
      scanneditemData[ind].qty = scanneditemData[ind].qty! - 1;
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      notifyListeners();
    }
    calCulateDocVal();
  }

  nullErrorMsg() {
    msgforAmount = null;
    paymentterm = null;
    wallet = null;
    selectedType = null;
    coupon = null;
    discount = null;
    clearTextField();
    notifyListeners();
  }

  String? selectedType;
  List<String> transType = ['NEFT', 'RTGS', 'IMPS', 'UPI'];
  List<String> get gettransType => transType;

  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  List payTerminal = [
    "HDFC Machine",
    'Pinelabs Machine - 1',
    'Pinelabs - Accessories',
    'Pinelabs - 2nd Counter'
  ];
  List get getpayTerminal => payTerminal;
  String? paymentterm;

  List walletlist = [
    'GPAY',
    'PAYTM',
    'UPI',
    'PHONEPE',
    'BAHRAT PE',
    'MOBILE MONEY'
  ];
  List get getwalletlist => walletlist;
  String? wallet;

  List couponlist = [
    'GROUPON',
    'AMAZON PAY',
    'FLIPKART CORPORATE',
    'HDFC GIFTPLUS',
    'ICICI GIFT COUPON',
    'UNILET COUPONS',
    'INSIGNIA COUPONS'
  ];
  List get getcouponlist => couponlist;
  String? coupon;
  List discountType = [
    'Credit Note Discount',
    'Manager Discount',
    'Sellout Benefit',
    'Volume Discount',
    'ICICI GIFT COUPON',
    'Kitty Discount',
    'BuyBack Discount'
  ];
  List get getdiscountType => discountType;
  String? discount;

  clearTextField() {
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

    selectedType = null;
    notifyListeners();
  }

  clearbutton() {
    scanneditemData2.clear();
    selectedcust2 = null;
    totalPayment2 = null;
    paymentWay2.clear();
    scanneditemData.clear();
    selectedcust = null;
    totalPayment = null;
    paymentWay.clear();

    mycontroller2[50].text = "";
    notifyListeners();
  }

  double totalcalculate() {
    double totallamountt = 0;
    totallamountt = getBalancePaid2() - salesCreditamt;

    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "OnAccount") {
          totallamountt = (totallamountt + salesCreditamt);
          return totallamountt;
        }
      }
    } else {
      return totallamountt;
    }

    return totallamountt;
  }

  calCulateDocVal() async {
    await salesCreditRcAmt();
    await calculateLineVal();
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPay.total =
          totalPay.total! + scanneditemData[iss].openRetQty!.toInt();
      totalPay.subtotal = (totalPay.subtotal! + scanneditemData[iss].basic!);
      totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;
      totalPay.totalDue = (totalPay.totalDue! + scanneditemData[iss].netvalue!);
      final Database db = (await DBHelper.getInstance())!;
      double weight = 0.0;
      double liter = 0.0;

      List<Map<String, Object?>> getWeightLiter =
          await DBOperation.getWeightLiterStockSnap(db,
              scanneditemData[iss].itemCode, scanneditemData[iss].serialBatch);
      if (getWeightLiter.isNotEmpty) {
        weight = getWeightLiter[0]["weight"] == null
            ? 0.00
            : double.parse(getWeightLiter[0]["weight"].toString());
        liter = getWeightLiter[0]["liter"] == null
            ? 0.00
            : double.parse(getWeightLiter[0]["liter"].toString());
        totLiter = (scanneditemData[iss].openRetQty! * liter);
        totwieght = (scanneditemData[iss].openRetQty! * weight);
        notifyListeners();
      } else {
        weight = 0.0;
        liter = 0.0;
      }
      notifyListeners();
    }
    totalPayment = totalPay;
    notifyListeners();

    btnEnabledfn();
    totalcalculate();
  }

  calCulateDocVal2() async {
    await calculateLineVal2();
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    if (scanneditemData2.isNotEmpty) {
      for (int iss = 0; iss < scanneditemData2.length; iss++) {
        totalPay.total =
            totalPay.total! + scanneditemData2[iss].openQty!.toInt();
        totalPay.subtotal = (totalPay.subtotal! + scanneditemData2[iss].basic!);
        totalPay.discount =
            totalPay.discount! + scanneditemData2[iss].discount!;
        totalPay.totalTX = totalPay.totalTX! + scanneditemData2[iss].taxvalue!;
        totalPay.totalDue =
            (totalPay.totalDue! + scanneditemData2[iss].netvalue!);
        final Database db = (await DBHelper.getInstance())!;
        double weight = 0.0;
        double liter = 0.0;

        List<Map<String, Object?>> getWeightLiter =
            await DBOperation.getWeightLiterStockSnap(
                db,
                scanneditemData2[iss].itemCode,
                scanneditemData2[iss].serialBatch);
        if (getWeightLiter.isNotEmpty) {
          weight = getWeightLiter[0]["weight"] == null
              ? 0.00
              : double.parse(getWeightLiter[0]["weight"].toString());
          liter = getWeightLiter[0]["liter"] == null
              ? 0.00
              : double.parse(getWeightLiter[0]["liter"].toString());
          totLiter = (scanneditemData2[iss].openRetQty! * liter);
          totwieght = (scanneditemData2[iss].openRetQty! * weight);
          notifyListeners();
        } else {
          weight = 0.0;
          liter = 0.0;
        }
        notifyListeners();
      }
    }
    totalPayment2 = totalPay;
    notifyListeners();

    totalcalculate();
  }

  calculateLineVal() {
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      scanneditemData[iss].openRetQty =
          double.parse(qtymycontroller[iss].text.toString());

      scanneditemData[iss].basic =
          (scanneditemData[iss].sellPrice! * scanneditemData[iss].openRetQty!);
      scanneditemData[iss].discount = (scanneditemData[iss].basic! *
          scanneditemData[iss].discountper! /
          100);
      scanneditemData[iss].taxable =
          scanneditemData[iss].basic! - scanneditemData[iss].discount!;

      scanneditemData[iss].taxvalue =
          scanneditemData[iss].taxable! * scanneditemData[iss].taxRate! / 100;

      scanneditemData[iss].netvalue = scanneditemData[iss].basic! -
          scanneditemData[iss].discount! +
          scanneditemData[iss].taxvalue!;
      notifyListeners();
    }
    notifyListeners();
  }

  calculateLineVal2() {
    for (int iss = 0; iss < scanneditemData2.length; iss++) {
      scanneditemData2[iss].openRetQty =
          double.parse(qtymycontroller2[iss].text.toString());

      scanneditemData2[iss].basic =
          (scanneditemData2[iss].sellPrice! * scanneditemData2[iss].openQty!);
      scanneditemData2[iss].discount = (scanneditemData2[iss].basic! *
          scanneditemData2[iss].discountper! /
          100);
      scanneditemData2[iss].taxable =
          scanneditemData2[iss].basic! - scanneditemData2[iss].discount!;
      scanneditemData2[iss].taxRate = scanneditemData2[iss].taxRate != null
          ? scanneditemData2[iss].taxRate
          : 0;

      scanneditemData2[iss].taxvalue =
          scanneditemData2[iss].taxable! * scanneditemData2[iss].taxRate! / 100;

      scanneditemData2[iss].taxvalue = scanneditemData2[iss].taxvalue != null
          ? scanneditemData2[iss].taxvalue!
          : 0;
      scanneditemData2[iss].netvalue = scanneditemData2[iss].basic! -
          scanneditemData2[iss].discount! +
          scanneditemData2[iss].taxvalue!;
      notifyListeners();
    }
    notifyListeners();
  }

  double getNoOfqty() {
    var getqty = scanneditemData.map((itemdet) => itemdet.qty.toString());
    var getSum = getqty.map(double.parse).toList();
    var totalqty = getSum.reduce((a, b) => a + b);
    return totalqty;
  }

  double getSumPrice() {
    var getprice =
        scanneditemData.map((itemdet) => itemdet.sellPrice.toString());
    var getpriceSum = getprice.map(double.parse).toList();
    var toalPrice = getpriceSum.reduce((a, b) => a + b);
    return toalPrice;
  }

  double getSumTotalTax() {
    var getTax = scanneditemData.map((itemdet) => itemdet.taxRate.toString());
    var getTaxSum = getTax.map(double.parse).toList();
    var toalTax = getTaxSum.reduce((a, b) => a + b);
    return toalTax;
  }

  double getNoSubTotal() {
    double totalqty = 0;
    double totalPrice = 0;
    double sumTotal = 0;

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].sellPrice.toString());
      totalqty = scanneditemData[iss].qty!;
      sumTotal = (sumTotal + (totalqty * totalPrice));
    }

    return sumTotal;
  }

  double getTotalTax() {
    double totalqty = 0;
    double totalPrice = 0;
    double tax = 0;
    double totalTax = 0;

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].sellPrice.toString());
      totalqty = scanneditemData[iss].qty!;
      tax = double.parse(scanneditemData[iss].taxRate.toString());
      totalTax = (totalTax + ((totalqty * totalPrice) * (tax / 100)));
    }
    return totalTax;
  }

  double getDiscount() {
    return 0;
  }

  double getSumTotalPaid2() {
    double toalPaid = 0.0;
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        toalPaid = toalPaid + paymentWay[i].amt!;
      }

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getSumTotalPaid3() {
    double toalPaid = 0.0;
    if (paymentWay2.isNotEmpty) {
      for (int i = 0; i < paymentWay2.length; i++) {
        toalPaid = toalPaid + paymentWay2[i].amt!;
      }

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getBalancePaid3() {
    salesCreditRcAmt();
    if (paymentWay2.isNotEmpty) {
      return double.parse(config
              .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
              .replaceAll(',', '')) -
          double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totalPayment2 != null
        ? double.parse(config
            .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
            .replaceAll(',', ''))
        : 0.00;
  }

  double getBalancePaid2() {
    salesCreditRcAmt();
    if (paymentWay.isNotEmpty) {
      return double.parse(config
              .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
              .replaceAll(',', '')) -
          double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totalPayment != null
        ? double.parse(config
            .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
            .replaceAll(',', ''))
        : 0.00;
  }

  double getBalancePaid22() {
    if (paymentWay2.isNotEmpty) {
      return double.parse(config
              .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
              .replaceAll(',', '')) -
          double.parse(getSumTotalPaid2().toStringAsFixed(2));
    }
    return totalPayment2 != null
        ? double.parse(config
            .splitValues(totalPayment2!.totalDue!.toStringAsFixed(2))
            .replaceAll(',', ''))
        : 0.00;
  }

  salesCreditRcAmt() {
    for (int i = 0; i < salespaytosalesreturn.length; i++) {
      if (salespaytosalesreturn[i].salesrcmode == "Credit") {
        salesCreditamt = double.parse(
            salespaytosalesreturn[i].salesrcamt!.toStringAsFixed(2).toString());

        if (adjustAmt != 0) {
          salesCreditamt = double.parse(
              (salesCreditamt - adjustAmt).toStringAsFixed(2).toString());
        } else {
          salesCreditamt = double.parse(salespaytosalesreturn[i]
              .salesrcamt!
              .toStringAsFixed(2)
              .toString());
        }
      }
    }
  }

  btnEnabledfn() {
    salesCreditRcAmt();
    totalcalculate();
    if (salesCreditamt != 0) {
      if (getBalancePaid2() < salesCreditamt) {
        enableModeBtn = false;
        notifyListeners();
      } else {
        enableModeBtn = true;
      }
    } else if (adjustAmt != 0) {
      enableModeBtn = false;
      notifyListeners();
    }
  }

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();

    mycontroller[22].text = totalcalculate().toStringAsFixed(2);

    fpaymt.amt = double.parse(mycontroller[22].text.toString());
    fpaymt.dateTime = config.currentDate();
    fpaymt.type = type;
    if (fpaymt.amt! < 100000) {
      if (fpaymt.amt != null) {
        int check = checkAlreadyUsed(fpaymt.type!);
        if (check == 0) {
          addPayAmount(fpaymt, context);
        } else if (check == 1) {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: SizedBox(
                      width: Screens.width(context) * 0.5,
                      height: Screens.bodyheight(context) * 0.15,
                      child: ContentWidgetMob(
                          theme: theme,
                          msg:
                              "Already you used ${fpaymt.type!} mode of payment..!!"),
                    ));
              });
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
                    content: 'Choose Correct Amount of Below 1,00,000..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
  }

  double getSumTotalOnAccountPaid() {
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "OnAccount") {
          var getTotalPaid =
              paymentWay.map((itemdet) => itemdet.amt.toString());
          var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
          var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
          return toalPaid;
        }
      }
    }
    return 0.00;
  }

  double getonaccbalPaid2() {
    double creditAmount = 0.0;

    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "OnAccount") {
          creditAmount = creditAmount + paymentWay[i].amt!;
        }
      }
      creditAmount = double.parse(config
              .splitValues(salesCreditamt.toStringAsFixed(2))
              .replaceAll(',', '')) -
          creditAmount;
      return creditAmount;
    } else {
      return getBalancePaid2() != 0
          ? double.parse(config
              .splitValues(getBalancePaid2().toStringAsFixed(2))
              .replaceAll(',', ''))
          : 0.00;
    }
  }

  addOnAccAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (formkey[i].currentState!.validate()) {
      if (type == 'OnAccount') {
        paymt.amt = double.parse(mycontroller[38].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      }
    }

    if (paymt.amt != null) {
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        addPayAmount(paymt, context);
      } else if (check == 1) {
        hintcolor = false;
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkItemCode(db, '');
    notifyListeners();
  }

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (formkey[i].currentState!.validate()) {
      if (type == 'Cash') {
        mycontlr = double.parse(mycontroller[22].text.toString().trim());

        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();

        paymt.type = type;
      } else if (type == 'Cheque') {
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[24].text;
        paymt.chequeno = mycontroller[23].text;
        paymt.remarks = mycontroller[26].text;
        paymt.type = type;
      } else if (type == 'Coupons') {
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        paymt.couponcode = mycontroller[35].text;
        paymt.coupontype = coupon;
      }
    }

    if (paymt.amt != null) {
      notifyListeners();
      int check = checkAlreadyUsed(paymt.type!);
      notifyListeners();

      if (check == 0) {
        addPayAmount(paymt, context);
      } else if (check == 1) {
        hintcolor = false;
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type == typeofMoney) {
        return 1;
      }
      notifyListeners();
    }
    return 0;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    if (paymentWay.isEmpty) {
      if (double.parse(config
                  .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid2() &&
          double.parse(getBalancePaid2().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    } else {
      if (double.parse(config
                  .splitValues(totalPayment!.totalDue!.toStringAsFixed(2))
                  .replaceAll(',', '')) >
              getSumTotalPaid2() &&
          double.parse(getBalancePaid2().toStringAsFixed(2)) >= paymt.amt!) {
        addToPaymentWay(paymt, context);
      } else {
        log("ErroAmt222: ${paymt.amt!.toStringAsFixed(2).replaceAll(',', '')}");

        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    }
  }

  addToOnAccPaymentWay(
    payment,
    BuildContext context,
  ) {
    paymentWay.add(PaymentWay(
      amt: payment.amt,
      dateTime: payment.dateTime,
      type: payment.type,
      chequedate: payment.chequedate,
      chequeno: payment.chequeno,
      reference: payment.reference ?? '',
      remarks: payment.remarks,
      couponcode: payment.couponcode,
      coupontype: payment.coupontype,
    ));
    if (payment.type == "OnAccount") {
      getSumTotalOnAccountPaid();
    }
    Navigator.pop(context);
    notifyListeners();
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
      couponcode: paymt.couponcode,
      coupontype: paymt.coupontype,
    ));
    getSumTotalPaid2();
    getBalancePaid2();

    Navigator.pop(context);
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid2();
    getBalancePaid2();
    accbal = 0;
    notifyListeners();
  }

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
    mycontroller[24].text = datetype!;
    mycontroller[44].text = datetype!;
  }

  cpyBtnclik(int i) {
    totalcalculate();
    mycontroller[i].text = totalcalculate().toStringAsFixed(2).toString();
    notifyListeners();
  }

  onAcccpyBtnclik(ik) {
    totalcalculate();

    if (totalPayment!.totalDue! < salesCreditamt) {
      mycontroller[ik].text = totalPayment!.totalDue.toString();
    } else {
      mycontroller[ik].text = (salesCreditamt).toStringAsFixed(2).toString();
      notifyListeners();
    }
  }

  custAccBal() {
    double mycontrol = 0;
    accbal = 0;
    accbal = double.parse(selectedcust!.accBalance.toString());
    mycontrol = double.parse(mycontroller[38].text);
    accbal = accbal + mycontrol;
    notifyListeners();
  }

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    freezeScrn = true;
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
        freezeScrn = false;
        notifyListeners();
      });
    } else {
      saveSalRetValuesTODB('hold', context, theme);

      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteSalesRetHold(db, holddocentry.toString())
            .then((value) {
          onHoldFilter!.clear();
          holddocentry = '';
          getdraftindex();
          notifyListeners();
        });
      }
      notifyListeners();
    }
    notifyListeners();
  }

  filterListOnHold(String v) {
    log("salesModelsalesModel.length:${salesModel.length}");

    if (v.isNotEmpty) {
      onHoldFilter = salesModel
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoiceNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.phNo!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesModel;
      notifyListeners();
    }
  }

  mapHoldValues(int ih, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    selectedcust55 = null;
    scanneditemData = [];
    holddocentry = '';
    basedocentryonqtyck = '';
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesRetheadholdDB(db);
    for (int ik = 0; ik < getDBholddata1.length; ik++) {
      List<Map<String, Object?>> getcustaddd =
          await DBOperation.addgetCstmMasAddDB(
              db, getDBholddata1[ik]['customercode'].toString().toString());
      List<Map<String, Object?>> custData =
          await DBOperation.getCstmMasDatabyautoid(
              db, getDBholddata1[ik]['customercode'].toString());
      selectedcust = CustomerDetals(
          name: getDBholddata1[ik]['customername'].toString(),
          phNo: custData[0]['phoneno1'].toString(),
          cardCode: custData[0]['customerCode'].toString(),
          U_CashCust: custData[0]['U_CashCust'].toString(),
          accBalance: double.parse(custData[0]['balance'].toString()),
          point: custData[0]['points'].toString(),
          address: [],
          email: custData[0]['emalid'].toString(),
          tarNo: custData[0]['taxno'].toString(),
          invoiceDate: salesModel[ih].invoceDate,
          invoicenum: salesModel[ih].invoiceNum,
          docentry: salesModel[ih].transdocentry,
          totalPayment: salesModel[ih].totalPayment!.totalDue);
      notifyListeners();

      selectedcust55 = CustomerDetals(
        name: getDBholddata1[ik]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customerCode'].toString(),
        U_CashCust: custData[0]['U_CASHCUST'].toString() ?? '',
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
      );
      notifyListeners();

      remarkcontroller3.text = getDBholddata1[ik]['remarks'].toString();
      for (int i = 0; i < getcustaddd.length; i++) {
        if (getDBholddata1[ik]['billaddressid'].toString() != null ||
            getDBholddata1[ik]['billaddressid'].toString().isNotEmpty) {
          if (getDBholddata1[ik]['billaddressid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            selectedcust!.address!.add(Address(
              autoId: int.parse(getcustaddd[i]['autoid'].toString()),
              addresstype: getcustaddd[i]['addresstype'].toString(),
              address1: getcustaddd[i]['address1'].toString(),
              address2: getcustaddd[i]['address2'].toString(),
              address3: getcustaddd[i]['address3'].toString(),
              billCity: getcustaddd[i]['city'].toString(),
              billCountry: getcustaddd[i]['countrycode'].toString(),
              billPincode: getcustaddd[i]['pincode'].toString(),
              billstate: getcustaddd[i]['statecode'].toString(),
            ));
            notifyListeners();
          }
        }
        notifyListeners();

        if (getDBholddata1[ik]['shipaddresid'].toString().isNotEmpty) {
          if (getDBholddata1[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            selectedcust55!.address!.add(Address(
              autoId: int.parse(getcustaddd[i]['autoid'].toString()),
              addresstype: getcustaddd[i]['addresstype'].toString(),
              address1: getcustaddd[i]['address1'].toString(),
              address2: getcustaddd[i]['address2'].toString(),
              address3: getcustaddd[i]['address3'].toString(),
              billCity: getcustaddd[i]['city'].toString(),
              billCountry: getcustaddd[i]['countrycode'].toString(),
              billPincode: getcustaddd[i]['pincode'].toString(),
              billstate: getcustaddd[i]['statecode'].toString(),
            ));
            notifyListeners();
          }
        }
      }
      notifyListeners();
    }

    notifyListeners();

    for (int i = 0; i < salesModel[ih].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          maxdiscount: salesModel[ih].item![i].maxdiscount,
          discountper: salesModel[ih].item![i].discountper,
          branch: salesModel[ih].item![i].branch,
          itemCode: salesModel[ih].item![i].itemCode,
          itemName: salesModel[ih].item![i].itemName,
          serialBatch: salesModel[ih].item![i].serialBatch,
          qty: salesModel[ih].item![i].qty,
          openQty: salesModel[ih].item![i].openQty,
          mrp: salesModel[ih].item![i].mrp,
          sellPrice: salesModel[ih].item![i].sellPrice,
          taxRate: salesModel[ih].item![i].taxRate,
          weight: salesModel[ih].item![i].weight,
          basedocentry: salesModel[ih].item![i].basedocentry,
          baselineid: salesModel[ih].item![i].baselineid,
          transID: salesModel[ih].item![i].transID,
          liter: salesModel[ih].item![i].liter));
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData.length; i++) {
      qtymycontroller[i].text = scanneditemData[i].qty.toString();

      notifyListeners();
    }
    basedocentryonqtyck = salesModel[ih].transdocentry;

    totalPayment = salesModel[ih].totalPayment;
    notifyListeners();
    holddocentry = salesModel[ih].docentry.toString();

    calCulateDocVal();
    totalcalculate();
    salesCreditRcAmt();
    enableModeBtn = true;
    btnEnabledfn();
    notifyListeners();
  }

  confirmReturn(BuildContext context, ThemeData theme) async {
    freezeScrn = true;
    final Database db = (await DBHelper.getInstance())!;
    validateqty = false;
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
        freezeScrn = false;

        notifyListeners();
      });
    } else if (scanneditemData.isEmpty) {
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
                      content: 'Choose Product..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        freezeScrn = false;

        notifyListeners();
      });
    } else if (selectCreditNoteType == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.all(0),
                content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Please Update the UDF',
                      theme: theme,
                    )),
                    buttonName: null));
          });
      freezeScrn = false;
    } else {
      await balanceqtycheck(context, theme);
      if (validateqty == false) {
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
                      content: "Can't Return More qty than Invoiced",
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          validateqty = true;
          freezeScrn = false;
        });
      } else {
        saveSalRetValuesTODB('confirm return', context, theme);
        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteSalesRetHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            holddocentry = '';
            getdraftindex();
            notifyListeners();
          });
        }
        validateqty = false;
      }
    }

    notifyListeners();
  }

  saveSalRetValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesRetHeaderToDB(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "confirm return") {
      insertSalesRetHeaderToDB(docstatus, context, theme);
    }

    notifyListeners();
  }

  viewSalesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.dltsalesret(db);
  }

  deletealesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.dltsalesret(db);
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    return listdata;
  }

  Uuid uuid = const Uuid();
  String? uuiDeviceId = '';

  insertSalesRetHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    uuiDeviceId = '';
    final Database db = (await DBHelper.getInstance())!;
    List<SalesReturnTModelDB> salesRHeaderValues1 = [];
    List<SalesReturnPayTDB> salesPayValues = [];
    List<SalesReturnLineTDB> salesLineValues = [];
    uuiDeviceId = uuid.v1();

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesReturnHeader");
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
      docEntryCreated = await DBOperation.generateDocentr(
          db, "docentry", "SalesReturnHeader");
    }

    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 3);

    List<String> getseriesvalue = await checkingdoc(3);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();

    SalesReturnTModelDB salesRetTable = SalesReturnTModelDB(
        doctype: "Sales Return",
        docentry: docEntryCreated.toString(),
        uDeviceId: uuiDeviceId.toString(),
        amtpaid: totalPayment != null
            ? config.splitValues(getSumTotalPaid2().toStringAsFixed(2))
            : '',
        baltopay: totalPayment != null
            ? config.splitValues(getBalancePaid2().toStringAsFixed(2))
            : '',
        billaddressid: selectedcust != null && selectedcust!.address!.isNotEmpty
            ? selectedcust!.address![selectedBillAdress].autoId.toString()
            : '',
        billtype: '',
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust != null ? selectedcust!.cardCode! : "",
        customername: selectedcust != null ? selectedcust!.name : "",
        customertype: UserValues.userType,
        docbasic: totalPayment != null
            ? config.splitValues(totalPayment!.subtotal!.toStringAsFixed(2))
            : "",
        docdiscamt: totalPayment != null
            ? config.splitValues(totalPayment!.discount!.toStringAsFixed(2))
            : "",
        docdiscuntpercen: '',
        documentno: documentNum.toString(),
        docstatus: docstatus == "hold"
            ? '1'
            : docstatus == "confirm return"
                ? '3'
                : "null",
        doctotal: selectedcust!.totalPayment != null
            ? selectedcust!.totalPayment!.toStringAsFixed(2)
            : '',
        lastupdateIp: UserValues.lastUpdateIp,
        premiumid: "",
        remarks: remarkcontroller3.text,
        salesexec: "",
        seresid: "",
        seriesnum: "",
        shipaddresid:
            selectedcust55 != null && selectedcust55!.address!.isNotEmpty
                ? selectedcust55!.address![selectedShipAdress].autoId.toString()
                : "",
        sodocno: "",
        sodocseries: "",
        sodocseriesno: '',
        sodoctime: config.currentDate(),
        sosystime: config.currentDate(),
        sotransdate: config.currentDate(),
        sysdatetime: config.currentDate(),
        taxamount: totalPayment != null
            ? config.splitValues(totalPayment!.totalTX!.toStringAsFixed(2))
            : '',
        taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
        transactiondate: '',
        transtime: config.currentDate(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        paystatus: '',
        customeraccbal:
            selectedcust != null ? selectedcust!.accBalance!.toString() : '',
        customeremail: selectedcust != null ? selectedcust!.email : '',
        customerphono: selectedcust != null ? selectedcust!.phNo : '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCity,
        gst: selectedcust != null ? selectedcust!.tarNo : '',
        pinno: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billPincode,
        state: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billstate,
        country: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCountry,
        basedocentry: selectedcust!.docentry.toString(),
        basedocnum: selectedcust!.invoicenum.toString(),
        terminal: UserValues.terminal,
        sapDocentry: null,
        sapDocNo: null,
        qStatus: "No",
        sapInvoicedocentry: sapDocentry.toString(),
        sapInvoicedocnum: sapDocuNumber.toString(),
        totalltr: totLiter,
        totalweight: totwieght);

    salesRHeaderValues1.add(salesRetTable);

    int? docentry2 =
        await DBOperation.insertSaleReturnheader(db, salesRHeaderValues1);

    await DBOperation.updatenextno(db, 3, nextno);
    for (int i = 0; i < scanneditemData.length; i++) {
      salesLineValues.add(SalesReturnLineTDB(
        basedocentry: scanneditemData[i].basedocentry,
        baselineID: scanneditemData[i].baselineid,
        basic: scanneditemData[i].basic.toString(),
        terminal: UserValues.terminal,
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: scanneditemData[i].discountper.toString(),
        discperunit: (scanneditemData[i].sellPrice! *
                scanneditemData[i].discountper! /
                100)
            .toString(),
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].itemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        itemname: scanneditemData[i].itemName,
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue.toString(),
        price: scanneditemData[i].sellPrice.toString(),
        quantity: qtymycontroller[i].text.toString(),
        serialbatch: scanneditemData[i].serialBatch,
        taxrate: scanneditemData[i].taxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue.toString(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
      ));
      notifyListeners();
    }

    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      salesPayValues.add(SalesReturnPayTDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry2.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: getpaymentWay[ij].amt != null
              ? getpaymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          amt: getpaymentWay[ij].amt != null
              ? getpaymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          rcdatetime: config.currentDate(),
          rcdocentry: "",
          rcmode: 'OnAccount',
          rcnumber: "",
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          chequedate: getpaymentWay[ij].chequedate,
          chequeno: getpaymentWay[ij].chequeno,
          couponcode: getpaymentWay[ij].couponcode,
          coupontype: getpaymentWay[ij].coupontype,
          reference: '',
          remarks: '',
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          lineId: ij.toString()));
      notifyListeners();
    }
    if (salesPayValues.isNotEmpty) {
      DBOperation.insertSalesReturnPay(db, salesPayValues, docentry2!);
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      DBOperation.insertSalesReturnLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    if (docstatus == "hold") {
      getdraftindex();

      scanneditemData.clear();
      mycontroller = List.generate(500, (i) => TextEditingController());
      selectedcust = null;
      mycontroller[50].clear();
      paymentWay.clear();
      totalPayment = null;
      srmycontroller[1].text = "";
      remarkcontroller3.text = '';
      notifyListeners();

      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "confirm return"
                  ? 'Successfully Returned..!!, Document Number is $documentNum'
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
        freezeScrn = false;
        notifyListeners();
      });
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "confirm return") {
        callReturnPostApi(
          context,
          theme,
          docentry2!,
          selectedcust!.docentry.toString(),
          docstatus,
        );
        notifyListeners();
      }
    }

    notifyListeners();
  }

  String seriesType = '';
  List<SeriesValue> seriesVal = [];
  callSeriesApi(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    seriesVal = [];
    seriesType = '';
    log('sessionid::${AppConstant.sapSessionID}');
    await SeriesAPi.getGlobalData('14').then((value) async {
      if (value.stsCode! >= 200 && value.stsCode! <= 210) {
        if (value.seriesvalue != null) {
          seriesVal = value.seriesvalue!;
          notifyListeners();
          List<Map<String, Object?>> branchdata =
              await DBOperation.getBrnachbyCode(db, AppConstant.branch);
          for (var i = 0; i < seriesVal.length; i++) {
            for (var ik = 0; ik < branchdata.length; ik++) {
              if (branchdata[ik]['WhsName'].toString() == seriesVal[i].name) {
                seriesType = seriesVal[i].series.toString();
              }
            }
          }
        }
      } else {}
    });

    notifyListeners();
  }

  callReturnPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String baseDocentry,
    String docstatus,
  ) async {
    await sapReturnLoginApi();

    await postingreturn(
      context,
      theme,
      docEntry,
      baseDocentry,
      docstatus,
    );
    notifyListeners();
  }

  void showSnackBar(
    String msg,
    BuildContext context,
  ) {
    final sn = SnackBar(
      content: Text(
        "$msg",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(sn);
  }

  callReturnPrintApi(
      BuildContext context, ThemeData theme, String docEntry) async {
    freezeScrn = true;

    // SalesReturnPrintAPii.docEntry = sapDocentry;
    SalesReturnPrintAPii.slpCode = AppConstant.slpCode;

    await SalesReturnPrintAPii.getGlobalData(docEntry).then((value) {
      if (value == 200) {
        freezeScrn = false;
        notifyListeners();
      } else {
        freezeScrn = false;

        showSnackBar('Try again!!..', context);
      }
    });
    notifyListeners();
  }

  List<Invbatch>? batchTable;
  addBatchtable(int ik) {
    batchTable = [];

    batchTable!.add(Invbatch(
      quantity: double.parse(scanneditemData[ik].openRetQty.toString()),
      batchNumberProperty: scanneditemData[ik].serialBatch.toString(),
    ));
    notifyListeners();
  }

  addBatchtable2(int ik) {
    batchTable!.add(Invbatch(
      quantity: double.parse(qtymycontroller[ik].text),
      batchNumberProperty: scanneditemData[ik].serialBatch.toString(),
    ));
    notifyListeners();
  }

  List<ReturnPostingtLine> itemsDocDetails = [];
  List<ReturnValuess> itemsValetails = [];

  adddocValues() {
    itemsValetails = [];
    addDocLine();
    itemsValetails.add(ReturnValuess(
        docDate: config.currentDate().toString(),
        docDueDate: config.currentDate().toString(),
        cardCode: selectedcust!.cardCode.toString(),
        cardName: selectedcust!.name.toString(),
        reference1: remarkcontroller3.text,
        returnDocumentLines: itemsDocDetails));
  }

  addDocLineTest() {
    itemsDocDetails = [];
    batchTable = [];
    double retQty = 0;

    for (int i = 0; i < scanneditemData.length; i++) {
      if (itemsDocDetails.isEmpty) {
        addBatchtableTest(i);
        itemsDocDetails.add(ReturnPostingtLine(
            lineNum: i,
            itemCode: scanneditemData[i].itemCode.toString(),
            itemDescription: scanneditemData[i].itemName.toString(),
            quantity: 0,
            price: scanneditemData[i].sellPrice!,
            discountPercent: scanneditemData[i].discountper!,
            warehouseCode: UserValues.branch!,
            batchNumbers: batchTable!,
            baseType: 13,
            basedocentry:
                int.parse(scanneditemData[i].basedocentry!.toString()),
            baseline: int.parse(scanneditemData[i].baselineid.toString())));
        notifyListeners();
      } else {
        var xxxx = 0;

        for (int im = 0; im < itemsDocDetails.length; im++) {
          if (itemsDocDetails[im].baseline.toString() ==
                  scanneditemData[i].baselineid.toString() &&
              itemsDocDetails[im].itemCode.toString() ==
                  scanneditemData[i].itemCode.toString()) {
            xxxx = 1;
          }
        }
        log('xxxxxx11:::$xxxx:::$i');
        if (xxxx == 1) {
          addBatchtableTest(i);
          log('xxxxxx22:::$xxxx:::$i');

          notifyListeners();
        } else {
          batchTable = [];
          addBatchtableTest(i);
          itemsDocDetails.add(ReturnPostingtLine(
              lineNum: i,
              itemCode: scanneditemData[i].itemCode.toString(),
              itemDescription: scanneditemData[i].itemName.toString(),
              quantity: 0,
              price: scanneditemData[i].sellPrice!,
              discountPercent: scanneditemData[i].discountper!,
              warehouseCode: UserValues.branch!,
              batchNumbers: batchTable!,
              baseType: 13,
              basedocentry:
                  int.parse(scanneditemData[i].basedocentry!.toString()),
              baseline: int.parse(scanneditemData[i].baselineid.toString())));
          notifyListeners();
        }
      }
    }
    retQty = 0;
    for (int ic = 0; ic < itemsDocDetails.length; ic++) {
      retQty = 0;
      for (int i = 0; i < scanneditemData.length; i++) {
        if (itemsDocDetails[ic].baseline.toString() ==
            scanneditemData[i].baselineid.toString()) {
          if (itemsDocDetails[ic].batchNumbers.length > 1) {
            retQty = retQty + double.parse(qtymycontroller[i].text);
            itemsDocDetails[ic].quantity = retQty;
            notifyListeners();
          } else {
            retQty = 0;
            retQty = retQty + double.parse(qtymycontroller[i].text);
            itemsDocDetails[ic].quantity = retQty;
            notifyListeners();
          }
        }
      }
      itemsDocDetails[ic].lineNum = ic;
    }
    notifyListeners();
  }

  addBatchtableTest(int ik) {
    log('kkkkk');
    for (var i = 0; i < serialbatchTable!.length; i++) {
      if (scanneditemData[ik].itemCode.toString() ==
              serialbatchTable![i].itemCode.toString() &&
          scanneditemData[ik].baselineid.toString() ==
              serialbatchTable![i].lineId.toString() &&
          scanneditemData[ik].serialBatch.toString() ==
              serialbatchTable![i].batchNumberProperty.toString()) {
        batchTable!.add(Invbatch(
            quantity: double.parse(qtymycontroller[ik].text),
            batchNumberProperty: serialbatchTable![i].batchNumberProperty));
        break;
      }
      log('batchTable::${batchTable!.length}');
      notifyListeners();
    }

    notifyListeners();
  }

  addDocLine() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      addBatchtable(i);
      itemsDocDetails.add(ReturnPostingtLine(
          lineNum: i,
          itemCode: scanneditemData[i].itemCode.toString(),
          itemDescription: scanneditemData[i].itemName.toString(),
          quantity: scanneditemData[i].openRetQty!,
          price: scanneditemData[i].sellPrice!,
          discountPercent: scanneditemData[i].discountper!,
          warehouseCode: UserValues.branch!,
          batchNumbers: batchTable!,
          baseType: 13,
          basedocentry: int.parse(scanneditemData[i].basedocentry!.toString()),
          baseline: int.parse(scanneditemData[i].baselineid.toString())));
      notifyListeners();
    }
    notifyListeners();
  }

  postingreturn(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String baseDocentry,
    String docstatus,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await addDocLineTest();
    SalesReurnPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesReurnPostAPi.docLineQout = itemsDocDetails;
    SalesReurnPostAPi.docDate = config.currentDate();
    SalesReurnPostAPi.dueDate = config.currentDate().toString();
    SalesReurnPostAPi.remarks = remarkcontroller3.text;
    SalesReurnPostAPi.cnType = selectCreditNoteCode!;
    SalesReurnPostAPi.seriesType = seriesType;

    SalesReurnPostAPi.method(uuiDeviceId);

    await SalesReurnPostAPi.getGlobalData(uuiDeviceId).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        await DBOperation.UpdateApprovalReturnDB(db, docEntry.toString());

        notifyListeners();
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "confirm return"
                    ? 'Successfully Sent to Approval'
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
          if (docstatus == "confirm return") {
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          freezeScrn = false;
          notifyListeners();
        });
        custserieserrormsg = '';
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        {
          freezeScrn = false;

          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: const EdgeInsets.all(0),
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: '${value.error!.message!.value!}',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            freezeScrn = false;
          });
        }
      }
    });

    notifyListeners();
  }

  postRabitMqSalesRet(int docentry, String basedocentry) async {
    final Database db = (await DBHelper.getInstance())!;
    String? salesRetHeader;
    String? salesRetLine;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(
            db, int.parse(basedocentry.toString()));
    baldocentry = getDBSalesHeader[0]['docentry'].toString();
    sameInvNum = getDBSalesHeader[0]['documentno'].toString();
    sapDocentry = getDBSalesHeader[0]['sapDocentry'].toString();
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'].toString();
    await sapReturnLoginApi();
    await callSerlaySalesQuoAPI();

    if (invDocumentStatus.toString() == "bost_Open") {
      salesRetHeader = null;
      salesRetLine = null;
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, docentry);
      List<Map<String, Object?>> getdbSaleretline1 =
          await DBOperation.grtSalesRetLineDB(db, docentry);
      salesRetHeader = jsonEncode(getdbSaleretheader1);
      salesRetLine = jsonEncode(getdbSaleretline1);
    } else {
      salesRetHeader = null;
      salesRetLine = null;
      List<SalesReturnTModelDB> getdbSaleretheader =
          await DBOperation.salesretrunupdate(db, docentry.toString());
      List<SalesReturnTModelDB> salesReturnTModelDBuser = [];
      salesReturnTModelDBuser.add(SalesReturnTModelDB(
        docentry: getdbSaleretheader[0].docentry,
        doctype: getdbSaleretheader[0].doctype,
        documentno: getdbSaleretheader[0].documentno,
        amtpaid: getdbSaleretheader[0].amtpaid,
        country: getdbSaleretheader[0].country,
        city: getdbSaleretheader[0].city,
        state: getdbSaleretheader[0].state,
        uDeviceId: getdbSaleretheader[0].uDeviceId,
        gst: getdbSaleretheader[0].gst,
        pinno: getdbSaleretheader[0].pinno,
        baltopay: getdbSaleretheader[0].baltopay,
        billaddressid: getdbSaleretheader[0].billaddressid,
        shipaddresid: getdbSaleretheader[0].shipaddresid,
        billtype: getdbSaleretheader[0].billtype,
        branch: getdbSaleretheader[0].branch,
        createdUserID: getdbSaleretheader[0].createdUserID,
        createdateTime: getdbSaleretheader[0].createdateTime,
        createdbyuser: getdbSaleretheader[0].createdbyuser,
        customerphono: getdbSaleretheader[0].customerphono,
        customeremail: getdbSaleretheader[0].customeremail,
        customerpoint: getdbSaleretheader[0].customerpoint,
        customeraccbal: getdbSaleretheader[0].customeraccbal,
        customercode: getdbSaleretheader[0].customercode,
        customername: getdbSaleretheader[0].customername,
        customertype: getdbSaleretheader[0].customertype,
        docbasic: getdbSaleretheader[0].docbasic,
        docdiscamt: getdbSaleretheader[0].docdiscamt,
        docdiscuntpercen: getdbSaleretheader[0].docdiscuntpercen,
        terminal: getdbSaleretheader[0].terminal,
        basedocentry: getdbSaleretheader[0].basedocentry,
        basedocnum: getdbSaleretheader[0].basedocnum,
        docstatus: getdbSaleretheader[0].docstatus,
        doctotal: getdbSaleretheader[0].doctotal,
        lastupdateIp: getdbSaleretheader[0].lastupdateIp,
        paystatus: getdbSaleretheader[0].paystatus,
        premiumid: getdbSaleretheader[0].premiumid,
        remarks: getdbSaleretheader[0].remarks,
        salesexec: getdbSaleretheader[0].salesexec,
        seresid: getdbSaleretheader[0].seresid,
        seriesnum: getdbSaleretheader[0].seriesnum,
        sodocno: getdbSaleretheader[0].sodocno,
        sodocseries: getdbSaleretheader[0].sodocseries,
        sodocseriesno: getdbSaleretheader[0].sodocseriesno,
        sodoctime: getdbSaleretheader[0].sodoctime,
        sosystime: getdbSaleretheader[0].sosystime,
        sotransdate: getdbSaleretheader[0].sotransdate,
        sysdatetime: getdbSaleretheader[0].sysdatetime,
        taxamount: getdbSaleretheader[0].taxamount,
        taxno: getdbSaleretheader[0].taxno,
        transactiondate: getdbSaleretheader[0].transactiondate,
        transtime: getdbSaleretheader[0].transtime,
        updatedDatetime: getdbSaleretheader[0].updatedDatetime,
        updateduserid: getdbSaleretheader[0].updateduserid,
        sapInvoicedocentry: getdbSaleretheader[0].sapInvoicedocentry,
        sapInvoicedocnum: getdbSaleretheader[0].sapInvoicedocnum,
        totalltr: double.parse(getdbSaleretheader[0].totalltr.toString()),
        totalweight: double.parse(getdbSaleretheader[0].totalweight.toString()),
        qStatus: 'No',
        sapDocentry: getdbSaleretheader[0].sapDocentry,
        sapDocNo: getdbSaleretheader[0].sapDocNo,
      ));
      notifyListeners();
      List<SalesReturnLineTDB> getdbSaleretline =
          await DBOperation.salesRetrunLineUpdate(db, docentry.toString());

      List<SalesReturnLineTDB> saleretlineuser = [];
      for (int i = 0; i < getdbSaleretline.length; i++) {
        saleretlineuser.add(SalesReturnLineTDB(
          createdUser: getdbSaleretline[i].createdUser,
          docentry: getdbSaleretline[i].docentry,
          baselineID: getdbSaleretline[i].baselineID,
          basedocentry: getdbSaleretline[i].basedocentry,
          basic: getdbSaleretline[i].basic,
          itemname: getdbSaleretline[i].itemname.toString(),
          branch: getdbSaleretline[i].branch.toString(),
          terminal: getdbSaleretline[i].terminal.toString(),
          createdUserID: getdbSaleretline[i].createdUserID.toString(),
          createdateTime: getdbSaleretline[i].createdateTime.toString(),
          discamt: getdbSaleretline[i].discamt.toString(),
          discperc: getdbSaleretline[i].discperc.toString(),
          discperunit: getdbSaleretline[i].discperunit.toString(),
          itemcode: getdbSaleretline[i].itemcode.toString(),
          lastupdateIp: getdbSaleretline[i].lastupdateIp.toString(),
          lineID: getdbSaleretline[i].lineID.toString(),
          linetotal: getdbSaleretline[i].linetotal.toString(),
          netlinetotal: getdbSaleretline[i].netlinetotal.toString(),
          price: getdbSaleretline[i].price.toString(),
          quantity: getdbSaleretline[i].quantity.toString(),
          serialbatch: getdbSaleretline[i].serialbatch.toString(),
          taxrate: getdbSaleretline[i].taxrate.toString(),
          taxtotal: getdbSaleretline[i].taxtotal.toString(),
          updatedDatetime: getdbSaleretline[i].updatedDatetime.toString(),
          updateduserid: getdbSaleretline[i].updateduserid.toString(),
        ));
        notifyListeners();
      }
      salesRetHeader = jsonEncode(salesReturnTModelDBuser);
      salesRetLine = jsonEncode(saleretlineuser);
      notifyListeners();
    }

    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(db, docentry);
    String salesRetPay = json.encode(getdbSaleretpay);

    var ddd = json.encode({
      "ObjectType": 2,
      "ActionType": "Add",
      "SalesReturnHeader": salesRetHeader,
      "SalesReturnLine": salesRetLine,
      "SalesReturntPay": salesRetPay,
    });
    log("payload11 : $ddd");

    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);

    properties.headers = {"branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqSalesRet2(int docentry, String basedocentry) async {
    final Database db = (await DBHelper.getInstance())!;

    String? salesRetHeader;
    String? salesRetLine;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, int.parse(basedocentry));

    baldocentry = getDBSalesHeader[0]['docentry'].toString();
    sameInvNum = getDBSalesHeader[0]['documentno'].toString();
    sapDocentry = getDBSalesHeader[0]['sapDocentry'].toString();
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'].toString();

    await sapReturnLoginApi();
    await callSerlaySalesQuoAPI();
    if (invDocumentStatus.toString() == "bost_Open") {
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, docentry);
      salesRetHeader = json.encode(getdbSaleretheader1);
      List<Map<String, Object?>> getdbSaleretline1 =
          await DBOperation.grtSalesRetLineDB(db, docentry);
      salesRetLine = json.encode(getdbSaleretline1);
    } else {
      List<SalesReturnTModelDB> getdbSaleretheader =
          await DBOperation.salesretrunupdate(db, docentry.toString());
      List<SalesReturnTModelDB> salesReturnTModelDBuser = [];
      salesReturnTModelDBuser.add(SalesReturnTModelDB(
        qStatus: 'No',
        sapDocentry: null,
        sapDocNo: null,
        docentry: getdbSaleretheader[0].docentry.toString(),
        doctype: getdbSaleretheader[0].doctype.toString(),
        uDeviceId: getdbSaleretheader[0].uDeviceId.toString(),
        documentno: getdbSaleretheader[0].documentno.toString(),
        amtpaid: getdbSaleretheader[0].amtpaid.toString(),
        country: getdbSaleretheader[0].country.toString(),
        city: getdbSaleretheader[0].city.toString(),
        state: getdbSaleretheader[0].state.toString(),
        gst: getdbSaleretheader[0].gst.toString(),
        pinno: getdbSaleretheader[0].pinno.toString(),
        baltopay: getdbSaleretheader[0].baltopay.toString(),
        billaddressid: getdbSaleretheader[0].billaddressid.toString(),
        billtype: getdbSaleretheader[0].billtype.toString(),
        branch: getdbSaleretheader[0].branch.toString(),
        createdUserID: getdbSaleretheader[0].createdUserID.toString(),
        createdateTime: getdbSaleretheader[0].createdateTime.toString(),
        createdbyuser: getdbSaleretheader[0].createdbyuser.toString(),
        customerphono: getdbSaleretheader[0].customerphono.toString(),
        customeremail: getdbSaleretheader[0].customeremail.toString(),
        customerpoint: getdbSaleretheader[0].customerpoint.toString(),
        customeraccbal: getdbSaleretheader[0].customeraccbal.toString(),
        customercode: getdbSaleretheader[0].customercode.toString(),
        customername: getdbSaleretheader[0].customername.toString(),
        customertype: getdbSaleretheader[0].customertype.toString(),
        docbasic: getdbSaleretheader[0].docbasic.toString(),
        docdiscamt: getdbSaleretheader[0].docdiscamt.toString(),
        docdiscuntpercen: getdbSaleretheader[0].docdiscuntpercen.toString(),
        terminal: getdbSaleretheader[0].terminal.toString(),
        basedocentry: getdbSaleretheader[0].basedocentry.toString(),
        basedocnum: getdbSaleretheader[0].basedocnum.toString(),
        docstatus: getdbSaleretheader[0].docstatus.toString(),
        doctotal: getdbSaleretheader[0].doctotal.toString(),
        lastupdateIp: getdbSaleretheader[0].lastupdateIp.toString(),
        paystatus: getdbSaleretheader[0].paystatus.toString(),
        premiumid: getdbSaleretheader[0].premiumid.toString(),
        remarks: getdbSaleretheader[0].remarks.toString(),
        salesexec: getdbSaleretheader[0].salesexec.toString(),
        seresid: getdbSaleretheader[0].seresid.toString(),
        seriesnum: getdbSaleretheader[0].seriesnum.toString(),
        shipaddresid: getdbSaleretheader[0].shipaddresid.toString(),
        sodocno: getdbSaleretheader[0].sodocno.toString(),
        sodocseries: getdbSaleretheader[0].sodocseries.toString(),
        sodocseriesno: getdbSaleretheader[0].sodocseriesno.toString(),
        sodoctime: getdbSaleretheader[0].sodoctime.toString(),
        sosystime: getdbSaleretheader[0].sosystime.toString(),
        sotransdate: getdbSaleretheader[0].sotransdate.toString(),
        sysdatetime: getdbSaleretheader[0].sysdatetime.toString(),
        taxamount: getdbSaleretheader[0].taxamount.toString(),
        taxno: getdbSaleretheader[0].taxno.toString(),
        transactiondate: getdbSaleretheader[0].transactiondate.toString(),
        transtime: getdbSaleretheader[0].transtime.toString(),
        updatedDatetime: getdbSaleretheader[0].updatedDatetime.toString(),
        updateduserid: getdbSaleretheader[0].updateduserid.toString(),
        sapInvoicedocentry: getdbSaleretheader[0].sapInvoicedocentry.toString(),
        sapInvoicedocnum: getdbSaleretheader[0].sapInvoicedocnum.toString(),
        totalltr: double.parse(getdbSaleretheader[0].totalltr.toString()),
        totalweight: double.parse(getdbSaleretheader[0].totalweight.toString()),
      ));

      List<SalesReturnLineTDB> getdbSaleretline =
          await DBOperation.salesRetrunLineUpdate(db, docentry.toString());
      SalesReturnLineTDB? saleretlineuser;
      for (int i = 0; i < getdbSaleretline.length; i++) {
        saleretlineuser = SalesReturnLineTDB(
          docentry: getdbSaleretline[i].docentry.toString(),
          baselineID: getdbSaleretline[i].baselineID.toString(),
          basedocentry: null,
          basic: getdbSaleretline[i].basic.toString(),
          itemname: getdbSaleretline[i].itemname.toString(),
          branch: getdbSaleretline[i].branch.toString(),
          terminal: getdbSaleretline[i].terminal.toString(),
          createdUserID: getdbSaleretline[i].createdUserID.toString(),
          createdateTime: getdbSaleretline[i].createdateTime.toString(),
          discamt: getdbSaleretline[i].discamt.toString(),
          discperc: getdbSaleretline[i].discperc.toString(),
          discperunit: getdbSaleretline[i].discperunit.toString(),
          itemcode: getdbSaleretline[i].itemcode.toString(),
          lastupdateIp: getdbSaleretline[i].lastupdateIp.toString(),
          lineID: getdbSaleretline[i].lineID.toString(),
          linetotal: getdbSaleretline[i].linetotal.toString(),
          netlinetotal: getdbSaleretline[i].netlinetotal.toString(),
          price: getdbSaleretline[i].price.toString(),
          quantity: getdbSaleretline[i].quantity.toString(),
          serialbatch: getdbSaleretline[i].serialbatch.toString(),
          taxrate: getdbSaleretline[i].taxrate.toString(),
          taxtotal: getdbSaleretline[i].taxtotal.toString(),
          updatedDatetime: getdbSaleretline[i].updatedDatetime.toString(),
          updateduserid: getdbSaleretline[i].updateduserid.toString(),
        );
      }
      salesRetHeader = jsonEncode(salesReturnTModelDBuser);
      salesRetLine = jsonEncode(saleretlineuser);
    }
    List<Map<String, Object?>> getdbSaleretpay =
        await DBOperation.getSalesRetPayDB(db, docentry);

    String salesRetPay = json.encode(getdbSaleretpay);

    var ddd = json.encode({
      "ObjectType": 2,
      "ActionType": "Add",
      "SalesReturnHeader": salesRetHeader,
      "SalesReturnLine": salesRetLine,
      "SalesReturntPay": salesRetPay,
    });
    log("payload2 : $ddd");

    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"branch": UserValues.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getSalesRetheadholdDB(db);
    log("getDBholddata5 lenght:${getDBholddata5.length.toString()}");
    onHoldFilter = [];
    onHold = [];
    salesModel = [];
    holddocentry = '';

    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);
    }
    notifyListeners();
  }

  getdraft(int ji) async {
    holddocentry = '';

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesRetheadholdDB(db);

    salesModel = [];
    onHoldFilter = [];
    onHold = [];

    List<StocksnapModelData> scannDataaa = [];
    List<PaymentWay> payment = [];
    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getSalesRetPayDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));
    log('getDBholdSalespaygetDBholdSalespay.length::${getDBholdSalespay.length}');
    List<Map<String, Object?>> getDBholdSalesLine =
        await DBOperation.grtSalesRetLineDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));
    log('getDBholdSalesLinegetDBholdSalesLine.length::${getDBholdSalesLine.length}');

    for (int kk = 0; kk < getDBholdSalespay.length; kk++) {
      if (getDBholddata1[ji]['docentry'].toString() ==
          getDBholdSalespay[kk]['docentry'].toString()) {
        payment.add(PaymentWay(
          amt: getDBholdSalespay[kk]['rcamount'] != null
              ? double.parse(getDBholdSalespay[kk]['rcamount'].toString())
              : null,
          type: getDBholdSalespay[kk]['rcmode'].toString(),
          dateTime: getDBholdSalespay[kk]['createdateTime'].toString(),
          reference: getDBholdSalespay[kk]['reference'] != null
              ? getDBholdSalespay[kk]['reference'].toString()
              : '',
          cardApprno: getDBholdSalespay[kk]['cardApprno'] != null
              ? getDBholdSalespay[kk]['cardApprno'].toString()
              : '',
          cardref: getDBholdSalespay[kk]['cardref'].toString(),
          cardterminal: getDBholdSalespay[kk]['cardterminal'].toString(),
          chequedate: getDBholdSalespay[kk]['chequedate'].toString(),
          chequeno: getDBholdSalespay[kk]['chequeno'].toString(),
          couponcode: getDBholdSalespay[kk]['couponcode'].toString(),
          coupontype: getDBholdSalespay[kk]['coupontype'].toString(),
          discountcode: getDBholdSalespay[kk]['discountcode'].toString(),
          discounttype: getDBholdSalespay[kk]['discounttype'].toString(),
          recoverydate: getDBholdSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBholdSalespay[kk]['redeempoint'].toString(),
          availablept: getDBholdSalespay[kk]['rcmode'].toString(),
          remarks: getDBholdSalespay[kk]['remarks'].toString(),
          transtype: getDBholdSalespay[kk]['transtype'].toString(),
          walletid: getDBholdSalespay[kk]['walletid'].toString(),
          wallettype: getDBholdSalespay[kk]['wallettype'].toString(),
        ));
      }
      notifyListeners();
    }
    for (int ik = 0; ik < getDBholdSalesLine.length; ik++) {
      if (getDBholddata1[ji]['docentry'] ==
          getDBholdSalesLine[ik]['docentry']) {
        scannDataaa.add(StocksnapModelData(
            baselineid: getDBholdSalesLine[ik]['baselineID'].toString(),
            basedocentry: getDBholdSalesLine[ik]['basedocentry'].toString(),
            transID: int.parse(getDBholdSalesLine[ik]['baselineID'].toString()),
            branch: getDBholdSalesLine[ik]['branch'].toString(),
            itemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
            itemName: getDBholdSalesLine[ik]['itemname'].toString(),
            serialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
            openQty:
                double.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            qty: double.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            inDate: getDBholdSalesLine[ik][''].toString(),
            inType: getDBholdSalesLine[ik][''].toString(),
            taxvalue:
                double.parse(getDBholdSalesLine[ik]['taxtotal'].toString()),
            discount:
                double.parse(getDBholdSalesLine[ik]['discamt'].toString()),
            mrp: 0,
            sellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
            cost: 0,
            taxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
            maxdiscount: getDBholdSalesLine[ik]['maxdiscount'] != null
                ? getDBholdSalesLine[ik]['maxdiscount'].toString()
                : '',
            discountper:
                double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
            liter: getDBholdSalesLine[ik]['liter'] == null
                ? 0.00
                : double.parse(getDBholdSalesLine[ik]['liter'].toString()),
            weight: getDBholdSalesLine[ik]['weight'] == null
                ? 0.00
                : double.parse(getDBholdSalesLine[ik]['weight'].toString())));
        totquantity = getDBholdSalesLine[ik]['quantity'].toString();
      }
      notifyListeners();
    }
    List<Address> addressadd = [];
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, getDBholddata1[ji]['customercode'].toString());
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      addressadd.add(Address(
        address1: csadresdataDB[ia]['address1'].toString(),
        address2: csadresdataDB[ia]['address2'].toString(),
        address3: csadresdataDB[ia]['address3'].toString(),
        billCity: csadresdataDB[ia]['city'].toString(),
        billCountry: csadresdataDB[ia]['countrycode'].toString(),
        billPincode: csadresdataDB[ia]['pincode'].toString(),
        billstate: csadresdataDB[ia]['statecode'].toString(),
      ));
    }
    SalesModel salesM = SalesModel(
        docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
        transdocentry: getDBholddata1[ji]['basedocentry'].toString(),
        custName: getDBholddata1[ji]['customername'].toString(),
        phNo: getDBholddata1[ji]['customerphono'].toString(),
        cardCode: getDBholddata1[ji]['customercode'].toString(),
        taxCode: getDBholddata1[ji]['taxCode'].toString(),
        accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
        point: getDBholddata1[ji]['customerpoint'].toString(),
        tarNo: getDBholddata1[ji]['taxno'].toString(),
        email: getDBholddata1[ji]['customeremail'].toString(),
        invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholddata1[ji]['basedocnum'].toString(),
        createdateTime: getDBholddata1[ji]['createdateTime'].toString(),
        invoceAmount: getDBholddata1[ji]['doctotal'] == null ||
                getDBholddata1[ji]['doctotal'] == 'null' ||
                getDBholddata1[ji]['doctotal'].toString().isEmpty
            ? 0
            : double.parse(
                getDBholddata1[ji]['doctotal'].toString().replaceAll(",", '')),
        address: addressadd,
        totalPayment: TotalPayment(
          subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null
              ? '0'
              : getDBholddata1[ji]['docbasic'].toString().replaceAll(',', '')),
          discount2: getDBholddata1[ji]['docdiscamt'] != null
              ? double.parse(getDBholddata1[ji]['docdiscamt']
                  .toString()
                  .replaceAll(',', ''))
              : 0,
          totalTX: double.parse(
              getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),
          discount: double.parse(
              getDBholddata1[ji]['docdiscamt'].toString().replaceAll(',', '')),
          total: getDBholddata1[ji]['quantity'] != null
              ? double.parse(getDBholddata1[ji]['quantity'].toString())
              : 0,
          totalDue: getDBholddata1[ji]['doctotal'] == null ||
                  getDBholddata1[ji]['doctotal'] == 'null' ||
                  getDBholddata1[ji]['doctotal'].toString().isEmpty
              ? 0
              : double.parse(getDBholddata1[ji]['doctotal']
                  .toString()
                  .replaceAll(',', '')),
          totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null
              ? '0'
              : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
          balance: double.parse(
              getDBholddata1[ji]['baltopay'].toString().replaceAll(',', '')),
        ),
        item: scannDataaa,
        paymentway: payment);
    notifyListeners();
    log("salesModel.length 444444:${salesModel.length}");

    salesModel.add(salesM);

    notifyListeners();
    log("salesModel.length 666:${salesModel.length}");
    onHoldFilter = salesModel;
    log("onHoldFilter.length:${onHoldFilter!.length}");

    notifyListeners();
  }

  void callApprovaltoDocApi(BuildContext context, ThemeData theme) async {
    sapDocentry = '';
    sapDocuNumber = '';
    freezeScrn = true;
    final Database db = (await DBHelper.getInstance())!;
    await sapReturnLoginApi();
    ApprovalsRetPostAPi.docEntry = approvalDetailsValue!.docEntry.toString();

    log('kkkkk' + selectedcust2!.docentry.toString());
    await ApprovalsRetPostAPi.getGlobalData().then((valuex) async {
      if (valuex.statusCode >= 200 && valuex.statusCode <= 210) {
        ApprovalsRetAPi.uDeviceID =
            approvalDetailsValue!.uDevicTransId.toString();

        await ApprovalsRetAPi.getGlobalData().then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            if (value.approvalsOrdersValue!.isNotEmpty) {
              await DBOperation.updtAprvltoDocSalRetHead(
                  db,
                  int.parse(value.approvalsOrdersValue![0].docEntry.toString()),
                  int.parse(value.approvalsOrdersValue![0].docNum.toString()),
                  int.parse(localDocentry));

              await Get.defaultDialog(
                      title: "Success",
                      middleText:
                          "Successfully Done,\nSales return Document Number ${value.approvalsOrdersValue![0].docNum}",
                      backgroundColor: Colors.white,
                      titleStyle: const TextStyle(color: Colors.red),
                      middleTextStyle: const TextStyle(color: Colors.black),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  loadingscrn = false;

                                  Get.back();
                                }),
                          ],
                        ),
                      ],
                      radius: 5)
                  .then((value) {
                isApprove = false;
                selectedcust2 = null;
                scanneditemData2 = [];
                freezeScrn = false;

                paymentWay2 = [];
                totalPayment2 = null;
                Get.offAllNamed(ConstantRoutes.dashboard);
                notifyListeners();
              });
            } else {
              freezeScrn = false;
            }
          }
        });
        notifyListeners();
      } else if (valuex.statusCode >= 400 || valuex.statusCode <= 404) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${valuex.erorrs!.message!.value}',
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
          selectedcust2 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
          freezeScrn = false;
        });
        notifyListeners();
      } else {
        await Get.defaultDialog(
                title: "Alert",
                middleText: '${valuex.erorrs!.message!.value}',
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
          selectedcust2 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
          freezeScrn = false;
        });
      }
    });
  }

  ApprovalDetailsValue? approvalDetailsValue;
  List<DocumentApprovalValue> documentApprovalValue = [];
  getdraftDocEntry(
      BuildContext context, ThemeData theme, String dcEntry) async {
    approvalDetailsValue = null;
    await ApprovalsDetailsAPi.getGlobalData(dcEntry).then((value) async {
      if (value.documentLines != null) {
        approvalDetailsValue = value;
        documentApprovalValue = value.documentLines!;
        log('documentApprovalValue::${documentApprovalValue.length}');
        await mapApprovalData(context, theme);
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  int? tbDocEntry;
  mapApprovalData(BuildContext context, ThemeData theme) async {
    selectedcust2 = null;
    isApprove = true;
    scanneditemData2 = [];
    scanneditemData = [];
    paymentWay2 = [];
    totalPayment2 = null;
    localDocentry = '';
    final Database db = (await DBHelper.getInstance())!;
    int totalQuantity = 0;

    List<Map<String, Object?>> getsoheader =
        await DBOperation.getReturnApprovalsts(
            db, approvalDetailsValue!.uDevicTransId.toString());
    if (approvalDetailsValue != null && getsoheader.isNotEmpty) {
      //
      localDocentry = getsoheader[0]['docentry'].toString();
      tbDocEntry = int.parse(getsoheader[0]['docentry'].toString());
      List<Map<String, Object?>> getdbSaleretline =
          await DBOperation.grtSalesRetLineDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));
      List<Map<String, Object?>> getdbSaleretpay =
          await DBOperation.getSalesRetPayDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));
      scanneditemData2.clear();
      sapDocuNumber = '';
      sapDocentry = '';
      totalPayment2 = null;
      totwieght2 = 0.0;
      totLiter2 = 0.0;
      selectedcust2 = null;
      mycontroller2[50].text = "";
      paymentWay2.clear();
      if (getsoheader.isNotEmpty) {
        totwieght2 = getsoheader[0]["totalweight"] != null
            ? double.parse(getsoheader[0]["totalweight"].toString())
            : 0;
        totLiter2 = getsoheader[0]["totalltr"] != null
            ? double.parse(getsoheader[0]["totalltr"].toString())
            : 0;

        mycontroller2[50].text = getsoheader[0]["remarks"].toString();

        sapDocentry = getsoheader[0]["sapDocentry"] != null
            ? getsoheader[0]["sapDocentry"].toString()
            : "";
        sapDocuNumber = getsoheader[0]["sapDocNo"] != null
            ? getsoheader[0]["sapDocNo"].toString()
            : "";
        for (int i = 0; i < getdbSaleretline.length; i++) {
          scanneditemData2.add(StocksnapModelData(
              invoiceNo: getdbSaleretline[i]['documentno'].toString(),
              transID: int.parse(getdbSaleretline[i]['lineID'].toString()),
              branch: getdbSaleretline[i]['branch'].toString(),
              itemCode: getdbSaleretline[i]['itemcode'].toString(),
              itemName: getdbSaleretline[i]['itemname'].toString(),
              serialBatch: getdbSaleretline[i]['serialbatch'].toString(),
              openQty: getdbSaleretline[i]['quantity'].toString() == 'null' ||
                      getdbSaleretline[i]['quantity'] == null ||
                      getdbSaleretline[i]['quantity'].toString().isEmpty
                  ? 0
                  : double.parse(getdbSaleretline[i]['quantity'].toString()),
              qty: getdbSaleretline[i]['quantity'].toString() == 'null' ||
                      getdbSaleretline[i]['quantity'] == null ||
                      getdbSaleretline[i]['quantity'].toString().isEmpty
                  ? 0
                  : double.parse(getdbSaleretline[i]['quantity'].toString()),
              inDate: getdbSaleretline[i][''].toString(),
              inType: getdbSaleretline[i][''].toString(),
              mrp: 0,
              sellPrice: getdbSaleretline[i]['price'] != null
                  ? double.parse(getdbSaleretline[i]['price'].toString())
                  : 0,
              cost: 0,
              taxRate: double.parse(getdbSaleretline[i]['taxrate'].toString()),
              maxdiscount: getdbSaleretline[i]['discperc'] != null
                  ? getdbSaleretline[i]['discperc'].toString()
                  : '',
              discountper: getdbSaleretline[i]['discperc'] != null
                  ? double.parse(getdbSaleretline[i]['discperc'].toString())
                  : null,
              taxvalue: getdbSaleretline[i]['taxtotal'] != null
                  ? double.parse(getdbSaleretline[i]['taxtotal'].toString())
                  : 0.0,
              liter: getdbSaleretline[i]['liter'] != null
                  ? double.parse(getdbSaleretline[i]['liter'].toString())
                  : 0.0,
              weight: getdbSaleretline[i]['weight'] != null
                  ? double.parse(getdbSaleretline[i]['weight'].toString())
                  : 0.0));

          notifyListeners();
        }
        double? totalPay = 0;
        for (int iss = 0; iss < scanneditemData2.length; iss++) {
          qtymycontroller2[iss].text = scanneditemData2[iss].qty.toString();
          totalPay = totalPay! + scanneditemData2[iss].qty!;
          notifyListeners();
        }

        List<Address>? address2 = [];
        List<Address>? address25 = [];
        List<Map<String, Object?>> newcusdataDB =
            await DBOperation.getCstmMasDatabyautoid(
                db, approvalDetailsValue!.cardCode.toString());

        List<CustomerAddressModelDB> csadresdataDB =
            await DBOperation.getCstmMasAddDBCardCode(
                db, approvalDetailsValue!.cardCode.toString());
        for (int k = 0; k < csadresdataDB.length; k++) {
          if (csadresdataDB[k].custcode.toString() ==
              approvalDetailsValue!.cardCode.toString()) {
            if (csadresdataDB[k].autoid.toString() ==
                getsoheader[0]['billaddressid'].toString()) {
              address2 = [
                Address(
                    autoId: int.parse(csadresdataDB[k].autoid.toString()),
                    address1: csadresdataDB[k].address1,
                    address2: csadresdataDB[k].address2,
                    address3: csadresdataDB[k].address3,
                    custcode: csadresdataDB[k].custcode,
                    billCity: csadresdataDB[k].city ?? '', //city
                    billCountry: csadresdataDB[k].countrycode!, //country
                    billPincode: csadresdataDB[k].pincode!, //pinno
                    billstate: csadresdataDB[k].statecode)
              ];
            }
            if (getsoheader[0]['shipaddresid'].toString().isNotEmpty) {
              if (csadresdataDB[k].autoid.toString() ==
                  getsoheader[0]['shipaddresid'].toString()) {
                address25 = [
                  Address(
                      autoId: int.parse(csadresdataDB[k].autoid.toString()),
                      address1: csadresdataDB[k].address1,
                      address2: csadresdataDB[k].address2,
                      address3: csadresdataDB[k].address3,
                      custcode: csadresdataDB[k].custcode,
                      billCity: csadresdataDB[k].city!, //city
                      billCountry: csadresdataDB[k].countrycode!, //country
                      billPincode: csadresdataDB[k].pincode!, //pinno
                      billstate: csadresdataDB[k].statecode)
                ];
              }
            }
          }
        }
        for (int ij = 0; ij < newcusdataDB.length; ij++) {
          selectedcust2 = CustomerDetals(
              docentry: approvalDetailsValue!.docEntry.toString(),
              taxCode: newcusdataDB[ij]['taxCode'].toString(),
              autoId: newcusdataDB[ij]['autoid'].toString(),
              cardCode: newcusdataDB[ij]['customerCode'].toString(),
              U_CashCust: newcusdataDB[ij]['U_CASHCUST'].toString() ?? '',
              name: newcusdataDB[ij]['customername'].toString(),
              phNo: newcusdataDB[ij]['phoneno1'].toString(),
              accBalance: double.parse(newcusdataDB[ij]['balance'].toString()),
              point: newcusdataDB[ij]['points'].toString(),
              tarNo: newcusdataDB[ij]['taxno'].toString(),
              email: newcusdataDB[ij]['emalid'].toString(),
              invoiceDate: approvalDetailsValue!.DocDate.toString(),
              invoicenum: '',
              totalPayment: 00,
              address: address2);

          double? updateCustBal;
          await AccountBalApi.getData(selectedcust2!.cardCode.toString())
              .then((value) {
            loadingscrn = false;
            if (value.statuscode >= 200 && value.statuscode <= 210) {
              updateCustBal =
                  double.parse(value.accBalanceData![0].balance.toString());
              notifyListeners();
            }
          });
          if (selectedcust2 != null) {
            selectedcust2!.accBalance = updateCustBal ?? 0;
          }

          totalPayment2 = TotalPayment(
            subtotal: double.parse(getsoheader[0]['docbasic'] == null
                ? '0'
                : getsoheader[0]['docbasic'].toString().replaceAll(',', '')),
            discount2: double.parse(
                getsoheader[0]['docdiscamt'].toString().replaceAll(',', '')),
            totalTX: double.parse(
                getsoheader[0]['taxamount'].toString().replaceAll(',', '')),
            discount: double.parse(
                getsoheader[0]['docdiscamt'].toString().replaceAll(',', '')),
            total: totalPay != 0 ? totalPay : 0,
            totalDue: double.parse(getsoheader[0]['amtpaid'] == null
                ? '0'
                : getsoheader[0]['amtpaid'].toString().replaceAll(',', '')),
            totpaid: double.parse(getsoheader[0]['amtpaid'] == null
                ? '0'
                : getsoheader[0]['amtpaid'].toString().replaceAll(',', '')),
            balance: double.parse(
                getsoheader[0]['baltopay'].toString().replaceAll(',', '')),
          );
        }
      }
      notifyListeners();
    }
  }

  searchAprvlMethod() {
    mycontroller[102].text = config.alignDate(config.currentDate());
    mycontroller[103].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  List<ApprovalsOrdersValue> filterAprvlData = [];
  List<ApprovalsOrdersValue> searchAprvlData = [];

  callPendingApprovalapi(BuildContext context) async {
    await ReturnPendingApprovalsAPi.getGlobalData(
      config.alignDate2(mycontroller[102].text),
      config.alignDate2(mycontroller[103].text),
    ).then((value) {
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        pendingApprovalData = value.approvalsvalue!;
        filterPendingApprovalData = pendingApprovalData;
        log('pendingApprovalDatapendingApprovalData::${pendingApprovalData.length}');
        notifyListeners();
      } else if (value.stsCode >= 400 || value.stsCode <= 404) {
      } else {}
    });
    notifyListeners();
  }

  callRejectedAPi(BuildContext context) async {
    await ReturnRejectedAPi.getGlobalData(
      config.alignDate2(mycontroller[102].text),
      config.alignDate2(mycontroller[103].text),
    ).then((value) {
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        log('messagellllll');
        rejectedData = value.approvalsvalue!;
        filterRejectedData = rejectedData;
        log('Rejected data length::${filterRejectedData.length}');
        notifyListeners();
      } else if (value.stsCode >= 400 || value.stsCode <= 404) {
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  callAprvllDataDatewise(String fromdate, String todate) async {
    searchAprvlData = [];
    filterAprvlData = [];
    searchbool = true;
    ReturnApprovalAPi.slpCode = AppConstant.slpCode;
    ReturnApprovalAPi.dbname = "${AppConstant.sapDB}";
    await ReturnApprovalAPi.getGlobalData(fromdate, todate).then(
      (value) {
        if (value.statusCode! >= 200 && value.statusCode! <= 204) {
          searchAprvlData = value.approvedData!;
          filterAprvlData = searchAprvlData;
          notifyListeners();
        } else if (value.statusCode! >= 400 && value.statusCode! <= 404) {
          log('message:::${value.error}');
        } else {
          log('message22:::${value.error}');
        }
      },
    );

    notifyListeners();
  }

  filterAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterAprvlData = searchAprvlData
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterAprvlData = searchAprvlData;
      notifyListeners();
    }
  }

  List<ApprovalsValue> pendingApprovalData = [];
  List<ApprovalsValue> filterPendingApprovalData = [];
  List<ApprovalsValue> rejectedData = [];
  List<ApprovalsValue> filterRejectedData = [];

  filterPendingAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterPendingApprovalData = pendingApprovalData
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterPendingApprovalData = pendingApprovalData;
      notifyListeners();
    }
  }

  filterRejectedBoxList(String v) {
    if (v.isNotEmpty) {
      filterRejectedData = rejectedData
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterRejectedData = rejectedData;
      notifyListeners();
    }
  }

  int? groupValueSelected = 0;
  int? get getgroupValueSelected => groupValueSelected;
  groupSelectvalue(int i) {
    groupValueSelected = i;
    if (i == 0) {
      notifyListeners();
    } else {}
    notifyListeners();
  }

  getAprvlDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[102].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      mycontroller[103].text = datetype!;
    } else {}
  }
}
