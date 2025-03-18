import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/DBModel/Receipt.dart';
import 'package:posproject/DBModel/ReceiptLine2.dart';
import 'package:posproject/DBModel/RecieptLine1.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PayReceiptModel/InvoicePayReceipt.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import 'package:posproject/Constant/UserValues.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/QueryUrlModel/IncomingPaymentCardCodeModel.dart';
import '../../Models/QueryUrlModel/NewCashAccount.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/CusotmerSeriesModel.dart';
import '../../Models/ServiceLayerModel/BankListModel/BankListsModels.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Service/NewCashAccountApi.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../Service/QueryURL/IncomingPaymentCardCodeQuery.dart';
import '../../Service/QueryURL/IncomingPaymentDocNumApi.dart';
import '../../Service/SearchQuery/SearchReceiptHeadApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/BankListApi/BankListsApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/GetpaymentReceiptApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';

class PayreceiptController extends ChangeNotifier {
  init(BuildContext context) async {
    callClearAllData();

    getdraftindex();
    injectfromdb();
    await callNewCashAccountApi();
    await sapLoginApi(context);
    await getCustSeriesApi();
    await callBankmasterApi();

    notifyListeners();
  }

  Configure config = Configure();
  bool loadSearch = false;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAd = GlobalKey<FormState>();
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  TextEditingController postingDatecontroller = TextEditingController();
  List<TextEditingController> invMycontroller =
      List.generate(150, (i) => TextEditingController());
  bool ondDisablebutton = false;
  List<CustomerAddressModelDB> createNewAddress = [];
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
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
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  List<searchModel> searchData = [];
  bool searchbool = false;

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

  bool get getisVisible => _isVisible;
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
  String holddocentry = '';
  String? autoidddd;
  String? selectedcustcode;
  List<InvoicePayReceipt> filterInvList = [];
  double invAmt = 0;
  String typeee = '';
  List<CustomerDetals> filtercustList1 = [];
  List<CustomerDetals> get getfiltercustList1 => filtercustList1;

  List<CustomerAddressModelDB> newAddrsValue = [];
  List<CustomerDetals> custList = [];

  List<SalesModel> filtercustList = [];
  List<SalesModel> get getfiltercustList => filtercustList;

  List<CustomerDetals> custList2 = [];
  int totalinvdamtamt = 0;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String? sapDocentry = '';
  String sapDocuNumber = '';

  String? custseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<CustSeriesModelData> seriesData = [];
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  String? custerrormsg = '';
  bool groCustLoad = false;
  bool loadingBtn = false;
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];
  bool advancests = false;
  double? totpaidamt2 = 0.0;
  String textError = '';
  String vatfileError = '';
  String tinfileError = '';
  String? custautoid;
  callClearAllData() {
    advancests = false;
    cashAcctype = null;
    cashAccCode = null;
    cardAcctype = null;
    cardAccCode = null;
    chequeAcctype = null;
    chequeAccCode = null;
    transAcctype = null;
    transAccCode = null;
    walletAcctype = null;
    walletAccCode = null;
    formkey = List.generate(50, (i) => GlobalKey<FormState>());
    formkeyAd = GlobalKey<FormState>();
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    mycontroller = List.generate(150, (i) => TextEditingController());
    invMycontroller = List.generate(150, (i) => TextEditingController());
    loadingscrn = false;
    ondDisablebutton = false;
    loadSearch = false;
    seriesType = '';
    seriesVal = [];
    selectedShipAdress = 0;
    selectedcust25 = null;
    msgforAmount = null;
    newAddrsValue = [];
    newCustValues = [];
    selectedCustomer = 0;
    filtersearchData.clear();
    remarkcontroller3 = TextEditingController();
    searchData.clear();
    selectedBillAdress = 0;
    checkboxx = false;
    _isVisible = true;
    hintcolor = false;
    advancetype = '';
    holddocentry = '';
    totalduepay2 = 0;
    totalduepay = 0;
    onHoldFilter = [];
    onHoldValue = [];
    couponData = [];
    salesPayModell5 = [];
    createNewAddress.clear();
    scanneditemData = [];
    invAmt = 0;
    typeee = '';
    totpaidamt = 0;
    isExpanded = false;
    isExpanded2 = true;
    selectcust = null;
    selectedcust2 = null;
    totalinvamt = null;
    selectedcust = null;
    selectedcust55 = null;
    selectedcust25 = null;
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
    cpndata = CouponDetModel();
    paymentWay2 = [];
    paymentWay = [];
    totalPayment2 = null;
    sameInvNum = null;
    totalduepay2 = null;
    searchbool = false;
    scanneditemData2 = [];
    postingDatecontroller.text = '';
    hideButtonController = ScrollController(initialScrollOffset: 0.0);
    itemsPaymentCheckDet = [];
    itemsPaymentInvDet = [];
    bankList = [];
    selectedBankType = null;
    selectbankCode = '';
    bankhintcolor = false;
    clearTextField();
    postingDatecontroller.text = config.alignDate(DateTime.now().toString());
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

  List<IncomingPayCardCodeModelData>? paymentReceiptData = [];
  doubleDotMethodPayTerms(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    mycontroller[i].text = modifiedString2.toString();
    log(mycontroller[i].text);
    notifyListeners();
  }

  callCasrdCodeOpenReceiptApi(
    String cardCode,
  ) async {
    loadingscrn = true;
    log('kkkkkkkkkk');
    await IncomingPaymentCardCodeAPi.getGlobalData(
      cardCode,
    ).then((value) async {
      List<InvoicePayReceipt> sscannData = [];
      salesPayModell5 = [];
      scanneditemData = [];
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        paymentReceiptData = value.activitiesData!;
        log('paymentReceiptDatapaymentReceiptData::${paymentReceiptData!.length}');
        loadingscrn = false;

        if (paymentReceiptData!.isNotEmpty) {
          for (var i = 0; i < paymentReceiptData!.length; i++) {
            sscannData = [];
            sscannData.add(InvoicePayReceipt(
              sapbasedocentry:
                  int.parse(paymentReceiptData![i].docEntry.toString()),
              amount: paymentReceiptData![i].balance,
              docNum: paymentReceiptData![i].docNum.toString(),
              date: paymentReceiptData![i].docDate.toString(),
              doctype: 'Sales Invoice',
              transdocentry: paymentReceiptData![i].docEntry.toString(),
              checkClr: true,
              checkbx: 1,
            ));
            SalesModel salesM = SalesModel(
                custName: paymentReceiptData![i].cardName,
                cardCode: paymentReceiptData![i].cardCode,
                taxCode: paymentReceiptData![i].taxCode,
                transdocentry: paymentReceiptData![i].docEntry.toString(),
                invoceDate: paymentReceiptData![i].docDate,
                invoiceNum: paymentReceiptData![i].docNum.toString(),
                payItem: sscannData);
            notifyListeners();
            salesPayModell5.add(salesM);
          }
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
      }
    });
    log('stockInwardstockInward length::${paymentReceiptData!.length}');
    notifyListeners();
  }

  doubleDotMethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    invMycontroller[i].text = modifiedString2.toString();
    log(invMycontroller[i].text);
    notifyListeners();
  }

  callopenReceiptApiDocNum(
      String docNum, ThemeData theme, BuildContext context) async {
    loadingscrn = true;
    log('kkkkkkkkkk');
    await IncomingPaymentDocNumAPi.getGlobalData(
      docNum,
    ).then((value) async {
      List<InvoicePayReceipt> sscannData = [];
      salesPayModell5 = [];
      log('kkkkkkkkkk22222');
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        paymentReceiptData = value.activitiesData!;
        log('paymentReceiptDatapaymentReceiptData::${paymentReceiptData!.length}');
        loadingscrn = false;

        if (paymentReceiptData!.isNotEmpty) {
          for (var i = 0; i < paymentReceiptData!.length; i++) {
            log('paymentReceiptData![i].balance::${paymentReceiptData![i].balance}');
            sscannData = [];
            sscannData.add(InvoicePayReceipt(
              sapbasedocentry:
                  int.parse(paymentReceiptData![i].docEntry.toString()),
              amount: paymentReceiptData![i].balance,
              docNum: paymentReceiptData![i].docNum.toString(),
              date: paymentReceiptData![i].docDate.toString(),
              doctype: 'Sales Invoice',
              transdocentry: paymentReceiptData![i].docEntry.toString(),
              checkClr: true,
              checkbx: 1,
            ));
            SalesModel salesM = SalesModel(
                custName: paymentReceiptData![i].cardName,
                cardCode: paymentReceiptData![i].cardCode,
                taxCode: paymentReceiptData![i].taxCode,
                transdocentry: paymentReceiptData![i].docEntry.toString(),
                invoceDate: paymentReceiptData![i].docDate,
                invoiceNum: paymentReceiptData![i].docNum.toString(),
                payItem: sscannData);
            notifyListeners();
            salesPayModell5.add(salesM);
            log('salesPayModell5salesPayModell5::${salesPayModell5.length}');
          }
        } else {
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'No Data Found..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
      }
    });
    log('stockInwardstockInward length::${paymentReceiptData!.length}');
    notifyListeners();
  }

  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
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

  postingDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    String datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
    postingDatecontroller.text = datetype;
  }

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchHeader
          .where((e) =>
              e.cardCode.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.cardName.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
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

  getCustSeriesApi() async {
    mycontroller[48].text = AppConstant.slpCode.toString();
    await GetSeriesApiAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.seriescustData != null) {
          seriesData = value.seriescustData!;
          notifyListeners();
        } else {
          custserieserrormsg = value.message!.toString();
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!.toString();
        notifyListeners();
      } else {
        custserieserrormsg = value.message!.toString();
        notifyListeners();
      }
      notifyListeners();
    });
    await GetCustomerGrpAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          groupcData = value.groupcustData!;
          custerrormsg = '';
          notifyListeners();
        } else {
          custerrormsg = value.message!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custerrormsg = value.message!;
      } else {
        custerrormsg = value.message!;
      }
      notifyListeners();
    });

    await GetTeriteriAPi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          teriteritData = value.groupcustData!;
          custserieserrormsg = '';
          notifyListeners();
        } else {
          custserieserrormsg = value.message!;
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!;
        notifyListeners();
      } else {
        custserieserrormsg = value.message!;
      }
    });

    await GetPaymentGroupAPi.getGlobalData().then((value) {
      groCustLoad = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.groupcustData != null) {
          paygroupData = value.groupcustData!;
          custserieserrormsg = '';
          notifyListeners();
        } else {
          custserieserrormsg = value.message!;
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.message!;
        notifyListeners();
      } else {
        custserieserrormsg = value.message!;
        notifyListeners();
      }
    });
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostInvoiceLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        if (value.error!.code != null) {
          loadingscrn = false;
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(
              bottom: Screens.bodyheight(context) * 0.3,
            ),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red,
            content: Text(
              "${value.error!.message!.value}\nCheck Your Sap Details !!..",
              style: const TextStyle(color: Colors.white),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(const Duration(seconds: 5), () {
            exit(0);
          });
        }
      } else if (value.stCode == 500) {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: const Text(
            "Opps Something went wrong !!..",
            style: TextStyle(color: Colors.white),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    notifyListeners();
  }

  String cardCodexx = '';

  Future<void> addFiles() async {
    filedata.clear();
    List<int> intdata = tinFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata),
        fileName: tinFiles!.path.split('/').last));
    List<int> intdata2 = vatFiles!.readAsBytesSync();
    filedata.add(FilesData(
        fileBytes: base64Encode(intdata2),
        fileName: vatFiles!.path.split('/').last));
  }

  callCustPostApi(BuildContext context, ThemeData theme) async {
    loadingBtn = true;

    await addFiles();
    await sapLoginApi(context);

    NewCutomerModel newCutomerModel = NewCutomerModel();

    for (int i = 0; i < filedata.length; i++) {
      await FilePostApi.getFilePostData(
              filedata[i].fileBytes, filedata[i].fileName)
          .then((value) {
        if (value.stCode! >= 200 && value.stCode! <= 210) {
          if (i == 0) {
            newCutomerModel.tincer = value.filepath!;
            notifyListeners();
          } else if (i == 1) {
            newCutomerModel.vatcer = value.filepath!;
            notifyListeners();
          }
        } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        } else {}
      });
    }

    newCutomerModel.cardCode =
        mycontroller[3].text.isEmpty ? null : mycontroller[3].text;
    newCutomerModel.cardName = mycontroller[6].text;
    newCutomerModel.grupCode = codeValue == null ? null : int.parse(codeValue!);
    newCutomerModel.additionalID = mycontroller[46].text;
    newCutomerModel.federalTaxID = mycontroller[47].text;
    newCutomerModel.cellular = mycontroller[4].text;
    newCutomerModel.salesPersonCode =
        mycontroller[48].text.isEmpty ? null : int.parse(mycontroller[48].text);
    newCutomerModel.contactPerson = mycontroller[51].text;
    newCutomerModel.creditLimit = mycontroller[49].text.isEmpty
        ? null
        : int.parse(
            mycontroller[49].text.replaceAll(",", "").replaceAll(".", ""));
    newCutomerModel.notes = mycontroller[50].text;
    newCutomerModel.series =
        custseriesNo == null ? null : int.parse(custseriesNo!);
    newCutomerModel.territory =
        teriteriValue == null ? null : int.parse(teriteriValue!);
    newCutomerModel.payTermsGrpCod =
        paygrpValue == null ? null : int.parse(paygrpValue!);
    newCutomerModel.newModel = [
      NewCutomeAdrsModel(
        addressName: mycontroller[7].text,
        addressName2: mycontroller[8].text,
        addressName3: mycontroller[9].text,
        addressType: 'bo_BillTo',
        city: mycontroller[10].text,
        country: '', //mycontroller[10].text,
        state: '',
        street: '',
        zipCode: mycontroller[13].text,
      ),
      NewCutomeAdrsModel(
        addressName: mycontroller[14].text,
        addressName2: mycontroller[15].text,
        addressName3: mycontroller[16].text,
        addressType: 'bo_ShipTo',
        city: mycontroller[17].text,
        country: '', //mycontroller[20].text,
        state: '', //mycontroller[19].text,
        street: '',
        zipCode: mycontroller[18].text,
      ),
    ];
    newCutomerModel.contEmp = [ContactEmployees(name: mycontroller[51].text)];
    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.cardCode.toString();
        await insertAddNewCusToDB(context);

        config.showDialogSucessB(
            "Customer created successfully ..!!", "Success");
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        config.showDialogg("${value.errorMsg!.message!.value}..!!", "Failed");
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Success");
      }
    });
    notifyListeners();
  }

  void selectVatattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        vatFiles = filesz[i];
        notifyListeners();
      }
    }
  }

  void selectattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();

      for (int i = 0; i < filesz.length; i++) {
        tinFiles = filesz[i];
        notifyListeners();
      }
    }
  }

  fixDataMethod(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    scanneditemData2.clear();
    paymentWay2.clear();
    mycontroller2[50].text = "";
    selectedcust2 = null;
    advancests = true;
    mycontroller2[50].text = getDBReceiptHeader[0]['remarks'].toString();

    List<Address>? address = [];
    List<Address>? address25 = [];

    List<Map<String, Object?>> custDataDet =
        await DBOperation.getCstmMasDatabyautoid(
            db, getDBReceiptHeader[0]['customer'].toString());

    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.createNewgetCstmMasAddDB(
            db, getDBReceiptHeader[0]['customer'].toString());
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].addresstype == 'B') {
        address = [
          Address(
              autoId: int.parse(csadresdataDB[k].autoid.toString()),
              address1: csadresdataDB[k].address1!.isNotEmpty
                  ? csadresdataDB[k].address1
                  : '',
              address2: csadresdataDB[k].address2,
              address3: csadresdataDB[k].address3,
              addresstype: csadresdataDB[k].addresstype,
              custcode: csadresdataDB[k].custcode,
              billCity: csadresdataDB[k].city!,
              billCountry: csadresdataDB[k].countrycode!,
              billPincode: csadresdataDB[k].pincode!,
              billstate: csadresdataDB[k].statecode)
        ];
      }

      if (csadresdataDB[k].addresstype.toString() == "S") {
        address25 = [
          Address(
              autoId: int.parse(csadresdataDB[k].autoid.toString()),
              address1: csadresdataDB[k].address1,
              address2: csadresdataDB[k].address2,
              address3: csadresdataDB[k].address3,
              addresstype: csadresdataDB[k].addresstype,
              custcode: csadresdataDB[k].custcode,
              billCity: csadresdataDB[k].city!,
              billCountry: csadresdataDB[k].countrycode!,
              billPincode: csadresdataDB[k].pincode!,
              billstate: csadresdataDB[k].statecode)
        ];
      }
    }

    selectedcust2 = CustomerDetals(
      name: custDataDet[0]["customername"].toString(),
      U_CashCust: '',
      taxCode: custDataDet[0]["taxCode"].toString(),
      phNo: custDataDet[0]["phoneno1"].toString(),
      docentry: getDBReceiptHeader[0]["docentry"].toString(),
      cardCode: custDataDet[0]["customercode"].toString(),
      accBalance: double.parse(
          custDataDet[0]["balance"].toString().replaceAll(",", '')),
      point: custDataDet[0]["points"].toString(),
      address: address,
      tarNo: custDataDet[0]["taxno"].toString(),
      email: custDataDet[0]["emalid"].toString(),
      invoicenum: getDBReceiptHeader[0]["documentno"].toString(),
      invoiceDate: getDBReceiptHeader[0]["createdateTime"].toString(),
      totalPayment: getDBReceiptHeader[0][""] == null
          ? 0.0
          : double.parse(getDBReceiptHeader[0][""].toString()),
    );
    selectedcust25 = CustomerDetals(
      name: custDataDet[0]["customername"].toString(),
      phNo: custDataDet[0]["customerphono"].toString(),
      docentry: custDataDet[0]["docentry"].toString(),
      taxCode: custDataDet[0]["taxCode"].toString(),
      U_CashCust: '',
      cardCode: custDataDet[0]["customercode"].toString(),
      accBalance: double.parse(custDataDet[0]["balance"].toString()),
      point: custDataDet[0]["customerpoint"].toString(),
      address: address25,
      tarNo: custDataDet[0]["taxno"].toString(),
      email: custDataDet[0]["customeremail"].toString(),
      invoicenum: getDBReceiptHeader[0]["documentno"].toString(),
      invoiceDate: getDBReceiptHeader[0]["createdateTime"].toString(),
      totalPayment: getDBReceiptHeader[0]["totalamount"] == null
          ? 0.0
          : double.parse(getDBReceiptHeader[0]["totalamount"].toString()),
    );
    notifyListeners();

    for (int ik = 0; ik < getDBReceiptLine.length; ik++) {
      scanneditemData2.add(InvoicePayReceipt(
        date: getDBReceiptLine[ik]['TransDocDate'].toString(),
        amount: double.parse(getDBReceiptLine[ik]['TransAmount'].toString()),
        docNum: getDBReceiptLine[ik]['TransDocNum'].toString(),
        doctype: getDBReceiptLine[ik]['transType'].toString(),
        transdocentry: getDBReceiptLine[ik]['transDocEnty'].toString(),
        checkClr: true,
        checkbx: 1,
        sapbasedocentry:
            int.parse(getDBReceiptHeader[0]["sapInvoicedocentry"].toString()),
      ));
      mycontroller2[ik].text = getDBReceiptLine[ik]['TransAmount'].toString();
      totalduepay2 = totalduepay2 != null
          ? totalduepay2! +
              double.parse(getDBReceiptLine[ik]['TransAmount'].toString())
          : 0.00;

      notifyListeners();
    }
    for (int kk = 0; kk < getDBReceipt2.length; kk++) {
      paymentWay2.add(PaymentWay(
        amt: double.parse(getDBReceipt2[kk]['rcamount'].toString()),
        type: getDBReceipt2[kk]['rcmode'].toString(),
        dateTime: getDBReceipt2[kk]['createdateTime'].toString(),
        reference: getDBReceipt2[kk]['reference'] != null
            ? getDBReceipt2[kk]['reference'].toString()
            : '',
        cardApprno: getDBReceipt2[kk]['cardApprno'] != null
            ? getDBReceipt2[kk]['cardApprno'].toString()
            : '',
        cardref: getDBReceipt2[kk]['cardref'].toString(),
        cardterminal: getDBReceipt2[kk]['cardterminal'].toString(),
        chequedate: getDBReceipt2[kk]['chequedate'].toString(),
        chequeno: getDBReceipt2[kk]['chequeno'].toString(),
        couponcode: getDBReceipt2[kk]['couponcode'].toString(),
        coupontype: getDBReceipt2[kk]['coupontype'].toString(),
        discountcode: getDBReceipt2[kk]['discountcode'].toString(),
        discounttype: getDBReceipt2[kk]['discounttype'].toString(),
        recoverydate: getDBReceipt2[kk]['recoverydate'].toString(),
        redeempoint: getDBReceipt2[kk]['redeempoint'].toString(),
        availablept: getDBReceipt2[kk]['availablept'].toString(),
        remarks: getDBReceipt2[kk]['remarks'].toString(),
        transtype: getDBReceipt2[kk]['transtype'].toString(),
        walletid: getDBReceipt2[kk]['walletid'].toString(),
        wallettype: getDBReceipt2[kk]['wallettype'].toString(),
        basedoctype: '',
      ));
    }
    notifyListeners();
  }

  totalpaidamt2() {
    totalduepay2 = 0;
    double myctrlval = 0;
    for (int i = 0; i < scanneditemData2.length; i++) {
      if (scanneditemData2[i].amount! >=
          double.parse(mycontroller2[i].text.toString())) {
        myctrlval = myctrlval + double.parse(mycontroller2[i].text.toString());
      }
    }
    totalduepay2 = totalduepay2! + myctrlval;
    return totalduepay2;
  }

  List<OpenSalesOrderHeaderData> searchHeader = [];
  List<OpenSalesOrderHeaderData> filtersearchData = [];

  callSearchHeaderApi() async {
    await SerachReceiptHeaderAPi.getGlobalData(
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

  setstate1() {
    notifyListeners();
  }

  getReceiptApi(
      String sapDocEntry, BuildContext context, ThemeData theme) async {
    await sapLoginApi(context);

    await SerlayPayReceiptAPI.getData(sapDocEntry).then((value) async {
      paymentWay2 = [];
      scanneditemData2 = [];
      totalduepay2 = 0;
      remarkcontroller3.text = '';
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        sapDocentry = value.docEntry.toString();
        log('value.documentLines length::${value.remarks}');
        remarkcontroller3.text = value.remarks;
        if (value.paymentChecks.isNotEmpty) {
          for (var i = 0; i < value.paymentChecks.length; i++) {
            if (value.paymentChecks[i].checkSum != 0) {
              paymentWay2.add(PaymentWay(
                cardApprno: value.paymentChecks[i].checkNumber.toString(),
                amt: value.paymentChecks[i].checkSum,
                type: 'Cheque',
                dateTime: value.docDate,
                reference: value.remarks,
              ));
            }
          }
        }
        if (value.paymentInvoices.isNotEmpty) {
          double? cash = value.cashSum ?? 0;
          double? transfer = value.transferSum ?? 0;

          if (transfer != 0) {
            paymentWay2.add(PaymentWay(
              amt: transfer,
              type: 'Transfer',
              dateTime: value.docDate,
              reference: value.transferReference,
              remarks: value.remarks,
            ));
          }
          if (cash != 0) {
            paymentWay2.add(PaymentWay(
              amt: transfer,
              type: 'Cash',
              dateTime: value.docDate,
              reference: value.remarks,
              remarks: value.remarks,
            ));
          }
          for (var i = 0; i < value.paymentInvoices.length; i++) {
            scanneditemData2.add(InvoicePayReceipt(
              date: value.docDate,
              amount: value.paymentInvoices[i].sumApplied,
              docNum: value.paymentInvoices[i].docNum.toString(),
              doctype: value.paymentInvoices[i].invoiceType.toString(),
              transdocentry: value.paymentInvoices[i].docEntry.toString(),
              sapbasedocentry: value.paymentInvoices[i].docEntry,
              checkClr: true,
              checkbx: 1,
            ));
            mycontroller2[i].text =
                value.paymentInvoices[i].sumApplied.toString();
          }
        } else {
          double cash = value.cashSum ?? 0;
          double transfer = value.transferSum ?? 0;

          if (cash != 0) {
            paymentWay2.add(PaymentWay(
              amt: cash,
              type: 'Cash',
              dateTime: value.docDate,
              reference: value.remarks,
            ));
          }
          if (transfer != 0) {
            paymentWay2.add(PaymentWay(
              amt: transfer,
              type: 'Transfer',
              dateTime: value.docDate,
              reference: value.remarks,
            ));
          }
        }
        notifyListeners();

        notifyListeners();

        final Database db = (await DBHelper.getInstance())!;

        List<Address>? address2 = [];
        List<Address>? address25 = [];
        List<CustomerAddressModelDB> csadresdataDB =
            await DBOperation.getCstmMasAddDBCardCode(
                db, value.cardCode.toString());
        for (int k = 0; k < csadresdataDB.length; k++) {
          if (csadresdataDB[k].addresstype == "B") {
            address2 = [
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
          if (csadresdataDB[k].addresstype == "S") {
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
        List<Map<String, Object?>> getcustomer =
            await DBOperation.getCstmMasDatabyautoid(
                db, value.cardCode.toString());

        selectedcust2 = CustomerDetals(
          name: getcustomer[0]['customername'].toString(),
          phNo: getcustomer[0]['phoneno1'].toString(),
          U_CashCust: getcustomer[0]['U_CASHCUST'].toString(),
          taxCode: getcustomer[0]['taxCode'].toString(),
          cardCode: getcustomer[0]['customerCode'].toString(),
          point: getcustomer[0]['points'].toString(),
          accBalance: 0,
          address: address2,
          email: getcustomer[0]['emalid'].toString(),
          tarNo: getcustomer[0]['taxno'].toString(),
          autoId: getcustomer[0]['autoid'].toString(),
        );
        selectedcust25 = CustomerDetals(
          name: getcustomer[0]['customername'].toString(),
          phNo: getcustomer[0]['phoneno1'].toString(),
          taxCode: getcustomer[0]['taxCode'].toString(),
          cardCode: getcustomer[0]['customerCode'].toString(),
          U_CashCust: getcustomer[0]['U_CASHCUST'].toString(),
          point: getcustomer[0]['points'].toString(),
          address: address25,
          accBalance: 0,
          email: getcustomer[0]['emalid'].toString(),
          tarNo: getcustomer[0]['taxno'].toString(),
          autoId: getcustomer[0]['autoid'].toString(),
        );
        double? updateCustBal;
        await AccountBalApi.getData(value.cardCode.toString()).then((value) {
          loadingscrn = false;
          if (value.statuscode >= 200 && value.statuscode <= 210) {
            updateCustBal =
                double.parse(value.accBalanceData![0].balance.toString());
            notifyListeners();
          }
        });
        selectedcust2!.accBalance =
            updateCustBal ?? double.parse(getcustomer[0]['balance'].toString());
        selectedcust25!.accBalance =
            updateCustBal ?? double.parse(getcustomer[0]['balance'].toString());

        loadSearch = true;
      } else if (value.stsCode >= 400 && value.stsCode <= 410) {
        loadSearch = false;
      } else {
        loadSearch = false;
      }
    });
    Get.back();

    notifyListeners();
  }

  Future getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getPayReciptHeaderDateWise(
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
              ? '0'
              : getSalesHeader[i]["documentno"].toString(),
          docDate: getSalesHeader[i]["createdateTime"].toString(),
          sapNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          sapDate: getSalesHeader[i]["createdateTime"] == null
              ? ""
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: getSalesHeader[i]["customer"].toString(),
          doctotal: getSalesHeader[i]["totalamount"] == null
              ? 0
              : double.parse(getSalesHeader[i]["totalamount"].toString())));
    }
    searchData.addAll(searchdata2);

    notifyListeners();

    searchbool = false;
    notifyListeners();
  }

  billToShip(bool dat) {
    notifyListeners();
    if (checkboxx == true) {
      mycontroller[14].text = mycontroller[7].text; //bill add1
      mycontroller[15].text = mycontroller[8].text; //bill add2
      mycontroller[16].text = mycontroller[9].text; //bill add3
      mycontroller[17].text = mycontroller[10].text; //city
      mycontroller[18].text = mycontroller[11].text; //pin
      mycontroller[19].text = mycontroller[12].text; //state
      mycontroller[20].text = mycontroller[13].text;
    } else {
      mycontroller[14].clear();
      mycontroller[15].clear();
      mycontroller[16].clear();
      mycontroller[17].clear();
      mycontroller[18].clear();
      mycontroller[19].clear();
    }
    notifyListeners();
  }

  shipToBill(bool dat) {
    notifyListeners();
    if (checkboxx == true) {
      mycontroller[7].text = mycontroller[14].text; //bill add1
      mycontroller[8].text = mycontroller[15].text; //bill add2
      mycontroller[9].text = mycontroller[16].text; //bill add3
      mycontroller[10].text = mycontroller[17].text; //city
      mycontroller[11].text = mycontroller[18].text; //pin
      mycontroller[12].text = mycontroller[19].text; //state
      mycontroller[13].text = mycontroller[20].text; //country
    } else {
      mycontroller[7].clear();
      mycontroller[8].clear();
      mycontroller[9].clear();
      mycontroller[10].clear();
      mycontroller[11].clear();
      mycontroller[12].clear();
      mycontroller[13].clear();
    }
    notifyListeners();
  }

  mapUpdateCustomer(int sInd) async {
    mycontroller[3].text = selectedcust!.cardCode!;
    mycontroller[4].text = selectedcust!.phNo!;
    mycontroller[5].text = selectedcust!.tarNo!;
    mycontroller[6].text = selectedcust!.name!;
    mycontroller[21].text = selectedcust!.email!;
    mycontroller[7].text = selectedcust!.address![selectedBillAdress].address1!;
    mycontroller[8].text = selectedcust!.address![selectedBillAdress].address2!;
    mycontroller[9].text = selectedcust!.address![selectedBillAdress].address3!;
    mycontroller[10].text = selectedcust!.address![selectedBillAdress].billCity;
    mycontroller[11].text =
        selectedcust!.address![selectedBillAdress].billPincode;
    mycontroller[12].text =
        selectedcust!.address![selectedBillAdress].billstate;
    mycontroller[13].text =
        selectedcust!.address![selectedBillAdress].billCountry;

    mycontroller[14].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address1 != null
        ? selectedcust55!.address![selectedShipAdress].address1!
        : '';
    mycontroller[15].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address2 != null
        ? selectedcust55!.address![selectedShipAdress].address2!
        : '';
    mycontroller[16].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].address3 != null
        ? selectedcust55!.address![selectedShipAdress].address3!
        : '';

    mycontroller[17].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billCity.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billCity
        : "";

    mycontroller[18].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billPincode.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billPincode
        : '';
    mycontroller[19].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billstate.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billstate
        : "";
    mycontroller[20].text = selectedcust55 != null &&
            selectedcust55!.address!.isNotEmpty &&
            selectedcust55!.address![selectedShipAdress].billCountry.isNotEmpty
        ? selectedcust55!.address![selectedShipAdress].billCountry
        : '';
    notifyListeners();
  }

  updateAAAA(BuildContext context, ThemeData theme, int i, int ij) {
    if (formkey[6].currentState!.validate()) {
      updateCustomer(context, i, ij);
      Navigator.pop(context);

      notifyListeners();
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
      notifyListeners();
    }
    notifyListeners();
  }

  updateCustomer(BuildContext context, int i, int ij) async {
    final Database db = (await DBHelper.getInstance())!;
    String aId = selectedcust!.address![selectedBillAdress].autoId.toString();

    selectedcust!.cardCode = mycontroller[3].text;
    selectedcust!.phNo = mycontroller[4].text;
    selectedcust!.tarNo = mycontroller[5].text;
    selectedcust!.name = mycontroller[6].text;
    selectedcust!.email = mycontroller[21].text;

    selectedcust!.address![selectedBillAdress].address1 = mycontroller[7].text;
    selectedcust!.address![selectedBillAdress].address2 = mycontroller[8].text;
    selectedcust!.address![selectedBillAdress].address3 = mycontroller[9].text;
    selectedcust!.address![selectedBillAdress].billCity = mycontroller[10].text;

    selectedcust!.address![selectedBillAdress].billPincode =
        mycontroller[11].text;
    selectedcust!.address![selectedBillAdress].billstate =
        mycontroller[12].text;
    selectedcust!.address![selectedBillAdress].billCountry =
        mycontroller[13].text;

    selectedcust55!.cardCode = mycontroller[3].text;
    selectedcust55!.phNo = mycontroller[4].text;
    selectedcust55!.tarNo = mycontroller[5].text;
    selectedcust55!.name = mycontroller[6].text;
    selectedcust55!.email = mycontroller[21].text;

    if (mycontroller[14].text.isNotEmpty ||
        mycontroller[16].text.isNotEmpty ||
        mycontroller[17].text.isNotEmpty ||
        mycontroller[18].text.isNotEmpty ||
        mycontroller[15].text.isNotEmpty ||
        mycontroller[19].text.isNotEmpty ||
        mycontroller[20].text.isNotEmpty) {
      if (selectedcust55!.address!.isNotEmpty) {
        selectedcust55!.address![selectedShipAdress].address1 =
            mycontroller[14].text;
        selectedcust55!.address![selectedShipAdress].address2 =
            mycontroller[15].text;
        selectedcust55!.address![selectedShipAdress].address3 =
            mycontroller[16].text;
        selectedcust55!.address![selectedShipAdress].billCity =
            mycontroller[17].text;
        selectedcust55!.address![selectedShipAdress].billPincode =
            mycontroller[18].text;
        selectedcust55!.address![selectedShipAdress].billstate =
            mycontroller[19].text;
        selectedcust55!.address![selectedShipAdress].billCountry =
            mycontroller[20].text;

        String autoid5 = selectedcust55!.address != null
            ? selectedcust55!.address![selectedShipAdress].autoId.toString()
            : "";
        await DBOperation.updateShipAddressDetails(
            db, ij, selectedcust55!, autoid5.toString());
      } else {
        shipcreateNewAddress.add(CustomerAddressModelDB(
          custcode: selectedcust55!.cardCode,
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          lastupdateIp: '1',
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.lastUpdateIp.toString(),
          address1: mycontroller[14].text,
          address2: mycontroller[15].text,
          address3: mycontroller[16].text,
          city: mycontroller[17].text,
          countrycode: mycontroller[20].text,
          geolocation1: '',
          geolocation2: '',
          statecode: mycontroller[19].text,
          pincode: mycontroller[18].text,
          branch: UserValues.branch.toString(),
          terminal: UserValues.terminal,
          addresstype: 'S',
        ));
        if (shipcreateNewAddress.isNotEmpty) {
          await DBOperation.insertCustomerAddress(db, shipcreateNewAddress);
        }
      }
    }

    await DBOperation.updateCustomerDetails(
      db,
      selectedcust!.autoId.toString(),
      selectedcust!,
    );
    await DBOperation.updateAddressDetails(
        db, i, selectedcust!, aId.toString());
    await getCustDetFDB();
    await getUpdateCustandadd(context, selectedcust!.cardCode.toString());
    notifyListeners();
  }

  getUpdateCustandadd(BuildContext context, String cardcode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust!.address = [];
    selectedcust55!.address = [];

    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(db, cardcode.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(db, cardcode.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      selectedcust = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          taxCode: newcusdataDB[i]["taxCode"].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          U_CashCust: newcusdataDB[0]['U_CASHCUST'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
    }
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        if (newaddrssdataDB[ik]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
        }

        if (newaddrssdataDB[ik]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
        }
      }
    }
  }

  addadress(BuildContext context) {
    selectedcust!.address!.add(Address(
      address1: mycontroller[14].text,
      address2: mycontroller[15].text,
      address3: mycontroller[16].text,

      billCity: mycontroller[10].text,
      billCountry: mycontroller[13].text, //'ind'
      billPincode: mycontroller[11].text,
      billstate: mycontroller[12].text,
    ));
    selectedBillAdress = (selectedcust!.address!.length - 1);
    selectedShipAdress = (selectedcust!.address!.length - 1);

    Navigator.pop(context);
    notifyListeners();
  }

  getcustaddresslist() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);
    selectedcust!.address = [];

    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust!.cardCode == csadresdataDB[ia]['custcode'].toString()) {
        selectedcust!.address!.add(Address(
          address1: csadresdataDB[ia]['address1'].toString(),
          address2: csadresdataDB[ia]['address2'].toString(),
          address3: csadresdataDB[ia]['address3'].toString(),
          billCity: csadresdataDB[ia]['city'].toString(),
          billCountry: csadresdataDB[ia]['countrycode'].toString(),
          billPincode: csadresdataDB[ia]['pincode'].toString(),
          billstate: csadresdataDB[ia]['statecode'].toString(),
        ));
      }
      notifyListeners();
    }
    notifyListeners();
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

  insertCreatenewbilAddress() async {
    final Database db = (await DBHelper.getInstance())!;
    billcreateNewAddress = [];
    if (mycontroller[7].text.isNotEmpty) {
      billcreateNewAddress.add(CustomerAddressModelDB(
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: '1',
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.lastUpdateIp.toString(),
        address1: mycontroller[7].text,
        address2: mycontroller[8].text,
        address3: mycontroller[9].text,
        city: mycontroller[10].text,
        countrycode: mycontroller[13].text,
        custcode: selectedcust!.cardCode,
        geolocation1: '',
        geolocation2: '',
        statecode: mycontroller[12].text,
        pincode: mycontroller[11].text,
        branch: UserValues.branch.toString(),
        terminal: UserValues.terminal,
        addresstype: 'B',
      ));
    }

    if (billcreateNewAddress.isNotEmpty) {
      await DBOperation.insertCustomerAddress(db, billcreateNewAddress);
    }
    getCustDetFDB();
  }

  insertCreatenewsipAddress() async {
    final Database db = (await DBHelper.getInstance())!;
    shipcreateNewAddress = [];
    if (mycontroller[14].text.isNotEmpty) {
      shipcreateNewAddress.add(CustomerAddressModelDB(
        custcode: selectedcust55!.cardCode,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: '1',
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.lastUpdateIp.toString(),
        address1: mycontroller[14].text,
        address2: mycontroller[15].text,
        address3: mycontroller[16].text,
        city: mycontroller[17].text,
        countrycode: mycontroller[20].text,
        geolocation1: '',
        geolocation2: '',
        statecode: mycontroller[19].text,
        pincode: mycontroller[18].text,
        branch: UserValues.branch.toString(),
        terminal: UserValues.terminal,
        addresstype: 'S',
      ));
    }

    if (shipcreateNewAddress.isNotEmpty) {
      await DBOperation.insertCustomerAddress(db, shipcreateNewAddress);
    }

    notifyListeners();
  }

  insertnewbilladdresscreation(BuildContext context, ThemeData theme) async {
    adondDisablebutton = true;

    if (formkeyAd.currentState!.validate()) {
      if (checkboxx == true) {
        await callAddressPostApi(context);
        notifyListeners();
      } else {
        await callBillAddressPostApi(context);
        notifyListeners();
      }
      notifyListeners();
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
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        adondDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
    notifyListeners();
  }

  bool adondDisablebutton = false;

  callBillAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    adondDisablebutton = true;
    await sapLoginApi(context);
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel.newModel = [
      NewCutomeAdrsModel(
        addressName: mycontroller[7].text,
        addressName2: mycontroller[8].text,
        addressName3: mycontroller[9].text,
        addressType: 'bo_BillTo',
        city: mycontroller[10].text,
        country: "TZ", //mycontroller[13].text,
        state: '', //mycontroller[12].text,
        street: '',
        zipCode: mycontroller[11].text,
      ),
    ];
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewbilAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        adondDisablebutton = false;

        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        adondDisablebutton = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        adondDisablebutton = false;
      }
    });
    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    await sapLoginApi(context);
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel.newModel = [
      NewCutomeAdrsModel(
        addressName: mycontroller[14].text,
        addressName2: mycontroller[15].text,
        addressName3: mycontroller[16].text,
        addressType: 'bo_ShipTo',
        city: mycontroller[17].text,
        country: "TZ", //mycontroller[20].text,
        state: '',
        street: '',
        zipCode: mycontroller[18].text,
      ),
    ];
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewsipAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustshipaddresslist(
          context,
        );
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        adondDisablebutton = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        adondDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    final Database db = (await DBHelper.getInstance())!;

    await sapLoginApi(context);
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel.newModel = [
      NewCutomeAdrsModel(
        addressName: mycontroller[7].text,
        addressName2: mycontroller[8].text,
        addressName3: mycontroller[9].text,
        addressType: 'bo_BillTo',
        city: mycontroller[10].text,
        country: "TZ", //mycontroller[13].text,
        state: '', //mycontroller[12].text,
        street: '',
        zipCode: mycontroller[11].text,
      ),
      NewCutomeAdrsModel(
        addressName: mycontroller[14].text,
        addressName2: mycontroller[15].text,
        addressName3: mycontroller[16].text,
        addressType: 'bo_ShipTo',
        city: mycontroller[17].text,
        country: "TZ", //mycontroller[20].text,
        state: '',
        street: '',
        zipCode: mycontroller[18].text,
      ),
    ];
    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertCreatenewbilAddress();
        await insertCreatenewsipAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        await getcustshipaddresslist(
          context,
        );
        adondDisablebutton = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        adondDisablebutton = false;
        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        adondDisablebutton = false;
        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    adondDisablebutton = true;

    if (formkeyShipAd.currentState!.validate()) {
      if (checkboxx == true) {
        await callAddressPostApi(context);

        notifyListeners();
      } else {
        callShipAddressPostApi(context);
        notifyListeners();
      }

      notifyListeners();
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
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        adondDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
  }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    selectedcust55!.address = [];
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust55!.cardCode ==
          csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            //autoid
            Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
            ),
          );
          selectedShipAdress = selectedcust55!.address!.length - 1;
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }

  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    newCustValues = [];
    custautoid = '';
    final Database db = (await DBHelper.getInstance())!;
    newCustValues.add(CustomerModelDB(
        taxCode: '',
        customerCode:
            mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        balance: 0,
        createdbybranch: UserValues.branch,
        customertype: '',
        customername:
            mycontroller[6].text.isNotEmpty ? mycontroller[6].text : '',
        emalid: mycontroller[21].text.isNotEmpty ? mycontroller[21].text : '',
        phoneno1: mycontroller[4].text.isNotEmpty ? mycontroller[4].text : '',
        phoneno2: "",
        points: 0,
        premiumid: '',
        snapdatetime: config.currentDate(),
        taxno: mycontroller[5].text.isNotEmpty
            ? mycontroller[5].text.toString()
            : '',
        terminal: UserValues.terminal,
        tinNo: '',
        vatregno: '',
        uCashCust: ''));
    notifyListeners();

    newBillAddrsValue.add(CustomerAddressModelDB(
      custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
      countrycode:
          mycontroller[13].text.isNotEmpty ? mycontroller[13].text : '',
      createdUserID: '1',
      createdateTime: config.currentDate(),
      lastupdateIp: '1',
      updatedDatetime: config.currentDate(),
      updateduserid: '1',
      address1: mycontroller[7].text.isNotEmpty ? mycontroller[7].text : '',
      address2: mycontroller[8].text.isNotEmpty ? mycontroller[8].text : '',
      address3: mycontroller[9].text.isNotEmpty ? mycontroller[9].text : '',
      city: mycontroller[10].text.isNotEmpty ? mycontroller[10].text : '',
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text.isNotEmpty ? mycontroller[12].text : '',
      pincode: mycontroller[11].text.isNotEmpty ? mycontroller[11].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'B',
    ));
    newShipAddrsValue.add(CustomerAddressModelDB(
      custcode: mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
      createdUserID: '1',
      createdateTime: config.currentDate(),
      lastupdateIp: '1',
      updatedDatetime: config.currentDate(),
      updateduserid: '1',
      address1: mycontroller[14].text.isNotEmpty ? mycontroller[14].text : '',
      address2: mycontroller[15].text.isNotEmpty ? mycontroller[15].text : '',
      address3: mycontroller[16].text.isNotEmpty ? mycontroller[16].text : '',
      city: mycontroller[17].text.isNotEmpty ? mycontroller[17].text : '',
      countrycode:
          mycontroller[20].text.isNotEmpty ? mycontroller[20].text : '',
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[19].text.isNotEmpty ? mycontroller[19].text : '',
      pincode: mycontroller[18].text.isNotEmpty ? mycontroller[18].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'S',
    ));

    int newadd = 0;
    if (newBillAddrsValue.isNotEmpty) {
      newadd = newadd + 1;
    }
    if (newShipAddrsValue.isNotEmpty) {
      newadd = newadd + 1;
    }
    if (newadd == 2) {
      await DBOperation.insertCustomer(db, newCustValues);
      await DBOperation.insertCustomerAddress(db, newBillAddrsValue);
      await DBOperation.insertCustomerAddress(db, newShipAddrsValue);

      List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
      List<CustomerAddressModelDB> newcusAddrssdataDB =
          await DBOperation.getCstmMasAddDB(db);

      await DBOperation.updateCustomerDetailstocrdcode(db, cardCodexx,
          newcusdataDB[newcusdataDB.length - 1].autoid.toString());
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 2].autoid.toString());
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 1].autoid.toString());
    }
    notifyListeners();
  }

  CareateNewBillAdd() async {
    final Database db = (await DBHelper.getInstance())!;
    String addCardCode = selectedcust!.cardCode.toString();

    List<CustomerAddressModelDB> createnewcsaddDB =
        await DBOperation.createNewgetCstmMasAddDB(db, addCardCode);

    for (int i = 0; i < custList.length; i++) {
      for (int ia = createnewcsaddDB.length - 1;
          ia < createnewcsaddDB.length;
          ia++) {
        if (custList[i].cardCode == createnewcsaddDB[ia].custcode) {
          custList[i].address!.add(Address(
                address1: createnewcsaddDB[ia].address1!,
                address2: createnewcsaddDB[ia].address2!,
                address3: createnewcsaddDB[ia].address3!,
                billCity: createnewcsaddDB[ia].city!,
                billCountry: createnewcsaddDB[ia].countrycode!,
                billPincode: createnewcsaddDB[ia].pincode!,
                billstate: createnewcsaddDB[ia].statecode,
              ));
          selectedcust!.address = custList[i].address!;
          selectedBillAdress = (selectedcust!.address!.length - 1);
          selectedShipAdress = (selectedcust!.address!.length - 1);
          notifyListeners();
        }
      }
    }

    notifyListeners();
  }

  getcustBilladdresslist(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    selectedcust!.address = [];
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust!.cardCode == csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
              address1: csadresdataDB[ia]['address1'].toString(),
              address2: csadresdataDB[ia]['address2'].toString(),
              address3: csadresdataDB[ia]['address3'].toString(),
              billCity: csadresdataDB[ia]['city'].toString(),
              billCountry: csadresdataDB[ia]['countrycode'].toString(),
              billPincode: csadresdataDB[ia]['pincode'].toString(),
              billstate: csadresdataDB[ia]['statecode'].toString(),
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
            ),
          );
          selectedBillAdress = selectedcust!.address!.length - 1;
        }
      }
    }

    notifyListeners();
  }

  insertCreatenewAddress() async {
    final Database db = (await DBHelper.getInstance())!;

    createNewAddress.add(CustomerAddressModelDB(
      addresstype: 'B',
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      lastupdateIp: UserValues.lastUpdateIp.toString(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.lastUpdateIp != null
          ? UserValues.lastUpdateIp.toString()
          : "0",
      address1: mycontroller[7].text,
      address2: mycontroller[8].text,
      address3: mycontroller[9].text,
      city: mycontroller[10].text,
      countrycode: mycontroller[13].text,
      custcode: selectedcust!.cardCode,
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text,
      pincode: mycontroller[11].text,
      branch: UserValues.branch.toString(),
      terminal: UserValues.terminal,
    ));
    await DBOperation.insertCustomerAddress(db, createNewAddress);
    await DBOperation.getdata(db);
    notifyListeners();
  }

  String? selectedType;
  List<String> transType = ['NEFT', 'RTGS', 'IMPS'];
  List<String> get gettransType => transType;

  List payTerminal = [
    "Terminal - 1",
    'Terminal - 2',
    'Terminal - 3',
    'Terminal - 4'
  ];
  List get getpayTerminal => payTerminal;
  String? paymentterm;

  List walletlist = ['GPAY', 'PAYTM', 'PHONEPE', 'BAHRAT PE', 'MOBILE MONEY'];
  List get getwalletlist => walletlist;
  String? wallet;

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
    msgforAmount = '';
    adondDisablebutton = false;
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatFiles = null;
    checkboxx = false;
    mycontroller[4].clear();
    mycontroller[6].clear();
    mycontroller[2].clear();
    mycontroller[3].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[7].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[20].clear();
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
    mycontroller[46].clear();
    mycontroller[47].clear();
    mycontroller[49].clear();
    mycontroller[50].clear();
    mycontroller[51].clear();

    selectedType = null;
    notifyListeners();
  }

  submitted(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log('Step1');
    ondDisablebutton = true;
    if (selectedcust == null) {
      log('Step2');

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
        ondDisablebutton = false;
        notifyListeners();
      });
    } else if (advancetype != "Advance" && scanneditemData.isEmpty) {
      log('Step3');

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
                      content: 'Choose a Document..!! or Advance',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
        notifyListeners();
      });
    } else if (advancetype != "Advance" &&
        scanneditemData.isNotEmpty &&
        paymentWay.isEmpty &&
        getBalancePaid() < 1 &&
        totalduepay! < 1 &&
        getSumTotalPaid() < 1) {
      log('Step4');

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
                      content: 'Choose a Advance or Document..!! ',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
        notifyListeners();
      });
    } else if (advancetype != "Advance") {
      if (getSumTotalPaid() < 1 && getBalancePaid() > 0) {
        log('Step5');

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
                        content: "Pay the full amount",
                        theme: theme,
                      )),
                      buttonName: null));
            }).then((value) {
          ondDisablebutton = false;
          notifyListeners();
        });
      } else {
        if (paymentWay.isNotEmpty && totalduepay == getSumTotalPaid()) {
          savepayreceiptValuesTODB('submit', context, theme);
          log('Step6');

          if (holddocentry.isNotEmpty) {
            DBOperation.deletepayreceipttHold(db, holddocentry.toString())
                .then((value) {
              holddocentry = '';
              onHoldFilter!.clear();
              getdraftindex();
            });
          }
          notifyListeners();
        } else if (paymentWay.isNotEmpty &&
            totalduepay! < 1 &&
            getSumTotalPaid() > 0) {
          log('Step7');

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
                          content: 'Choose a Advance or Document..!!',
                          theme: theme,
                        )),
                        buttonName: null));
              }).then((value) {
            ondDisablebutton = false;
            notifyListeners();
          });
        } else {
          log('Step8');

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
            ondDisablebutton = false;
            notifyListeners();
          });
        }
      }
    } else if (advancetype == "Advance" && paymentWay.isNotEmpty) {
      log('Step9');

      advSavePayReceiptValuesTODB('submit', context, theme);
      if (holddocentry.isNotEmpty) {
        DBOperation.deletepayreceipttHold(db, holddocentry.toString())
            .then((value) {
          onHoldFilter!.clear();
          getdraftindex();
        }).then((value) {
          holddocentry = '';
        });
      }
      notifyListeners();
    } else {
      log('Step10');

      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Pay the amount..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  checkadvanceamt(BuildContext context, ThemeData theme) {
    int? indx = int.parse(deSelectalladv("Advance", context, theme).toString());
    savepayreceiptValuesTODB('submit', context, theme);
    notifyListeners();
  }

  pointconvert() {
    double availPoint = double.parse(mycontroller[37].text);
    double enteredPoint = double.parse(mycontroller[38].text);
    if (availPoint >= enteredPoint) {
      mycontroller[39].text = mycontroller[38].text;
      mycontroller[40].text = mycontroller[39].text;
    } else {
      msgforAmount = "Points to redeem greater than available point";
      mycontroller[40].clear();
      mycontroller[39].clear();
    }
    notifyListeners();
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type != "Card") {
        if (paymentWay[ip].type == typeofMoney) {
          return 1;
        }
      }
    }
    return 0;
  }

  double getSumTotalPaid33() {
    double toalPaid2 = 0;
    if (paymentWay2.isNotEmpty) {
      var getTotalPaid = paymentWay2.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      toalPaid2 = getTotalPaidSum.reduce((a, b) => a + b);

      return toalPaid2;
    } else {
      return 0.00;
    }
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

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  double getSumTotalPaid2() {
    double toalPaid = 0;
    if (paymentWay2.isNotEmpty) {
      var getTotalPaid = paymentWay2.map((itemdet) => itemdet.amt.toString());
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

  double getBalancePaid33() {
    if (paymentWay2.isNotEmpty) {
      return totpaidamt2 != 0
          ? (totpaidamt2! - double.parse(getSumTotalPaid().toStringAsFixed(2)))
          : totalduepay2! - double.parse(getSumTotalPaid().toStringAsFixed(2));
    } else if (totalduepay2 != null) {
      return totpaidamt2 != 0 ? totpaidamt2! : totalduepay2!;
    } else {
      totalduepay2 = 0.00;
      return 0.00;
    }
  }

  itemDeSelect(int i) {
    double totalduepayx = 0;
    advancetype = '';
    if (scanneditemData[i].checkbx == 0 &&
        scanneditemData[i].checkClr == false) {
      scanneditemData[i].checkbx = 1;
      scanneditemData[i].checkClr = true;
      totalduepayx = totalduepay! + scanneditemData[i].amount!;
      totalduepay = double.parse(totalduepayx.toStringAsFixed(2));
      notifyListeners();
    } else if (scanneditemData[i].checkbx == 1 &&
        scanneditemData[i].checkClr == true) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepayx = totalduepay! - scanneditemData[i].amount!;
      totalduepay = double.parse(totalduepayx.toStringAsFixed(2));

      notifyListeners();
    }

    notifyListeners();
  }

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();
    mycontroller[22].text = totalduepay.toString();
    String fullam = getBalancePaid().toStringAsFixed(2);
    fpaymt.amt = double.parse(fullam.replaceAll(",", ""));
    fpaymt.dateTime = config.currentDate();
    fpaymt.type = type;
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
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content:
                          'Already you used ${fpaymt.type!} mode of payment..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }
  }

  selectedcoupontype() {
    for (int i = 0; i < couponData.length; i++) {
      if (couponData[i].cardcode.toString() == selectedcustcode.toString() &&
          couponData[i].coupontype == coupon) {
        CouponDetModel cpndata2 = CouponDetModel(
          couponamt: couponData[i].couponamt,
          cardcode: couponData[i].cardcode,
          coupontype: couponData[i].coupontype,
          couponcode: couponData[i].couponcode,
          status: couponData[i].status,
        );
        cpndata = cpndata2;
      }
    }
  }

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();

    if (selectedType == null && type == 'Transfer') {
      hintcolor = true;
      notifyListeners();
    }
    if (selectedBankType == null && type == 'Cheque') {
      bankhintcolor = true;
    }
    if (formkey[i].currentState!.validate()) {
      if (type == 'Cash') {
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Cheque') {
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[44].text;
        paymt.chequeno = mycontroller[23].text.toString();
        paymt.type = type;
      } else if (type == 'Card') {
        paymt.amt = double.parse(
            mycontroller[29].text.toString().trim().replaceAll(',', ''));
        paymt.reference = mycontroller[28].text;
        paymt.cardApprno = mycontroller[27].text;
        paymt.cardref = mycontroller[28].text;
        paymt.cardterminal = paymentterm.toString();
        paymt.type = type;
      } else if (type == 'Transfer') {
        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Wallet') {
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        paymt.walletref = mycontroller[33].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Coupons') {
        paymt.couponcode = mycontroller[35].text;
        paymt.coupontype = coupon;
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Points Redemption') {
        paymt.redeempoint = mycontroller[38].text;
        paymt.availablept = mycontroller[37].text;
        paymt.amt = double.parse(mycontroller[40].text.toString().trim());
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
                  contentPadding: EdgeInsets.zero,
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

  addPayAmount(PaymentWay paymt, BuildContext context) {
    selectedcoupontype();
    if (advancetype != "Advance") {
      if (paymentWay.isEmpty) {
        if (paymt.type == 'Coupons') {
          if (cpndata.cardcode.toString() == selectedcustcode.toString()) {
            if (cpndata.coupontype == paymt.coupontype) {
              if (cpndata.couponcode == paymt.couponcode) {
                if (cpndata.couponamt! >= paymt.amt!) {
                  addToPaymentWay(paymt, context);
                  notifyListeners();
                } else {
                  msgforAmount = 'Amount entered exceeds coupon values';
                  notifyListeners();
                }
              }
            } else {
              msgforAmount = 'Invalid Coupon Type..!!';
              notifyListeners();
            }
          }
          notifyListeners();
        } else if (totalduepay! > getSumTotalPaid() &&
            getBalancePaid() >= double.parse(paymt.amt!.toStringAsFixed(2))) {
          addToPaymentWay(paymt, context);
        } else {
          msgforAmount = 'Enter Correct amount..!!';
          notifyListeners();
        }
      } else {
        if (totalduepay! > getSumTotalPaid() &&
            double.parse(getBalancePaid().toStringAsFixed(2)) >=
                double.parse(paymt.amt!.toStringAsFixed(2))) {
          addToPaymentWay(paymt, context);
        } else {
          msgforAmount = 'Enter Correct amount..!!';
          notifyListeners();
        }
      }
    } else {
      addToPaymentWay(paymt, context);
    }
  }

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    hintcolor = false;
    paymentWay.add(PaymentWay(
        amt: paymt.amt,
        dateTime: paymt.dateTime,
        reference: paymt.reference ?? '',
        type: paymt.type,
        cardApprno: paymt.cardApprno,
        cardref: paymt.cardref,
        cardterminal: paymt.cardterminal,
        chequedate: paymt.chequedate,
        chequeno: paymt.chequeno,
        couponcode: paymt.couponcode,
        coupontype: paymt.coupontype,
        discountcode: paymt.discountcode,
        discounttype: paymt.discounttype,
        recoverydate: paymt.recoverydate,
        redeempoint: paymt.redeempoint,
        availablept: paymt.availablept,
        remarks: paymt.remarks,
        transtype: paymt.transtype,
        walletid: paymt.walletid,
        wallettype: paymt.wallettype));

    getSumTotalPaid();
    getBalancePaid();
    Navigator.pop(context);
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();
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

  cpyBtnclik(int i) {
    if (double.parse(getBalancePaid().toStringAsFixed(2)) > 0) {
      mycontroller[i].text = getBalancePaid().toStringAsFixed(2);
      notifyListeners();
    } else {
      mycontroller[i].text = '';
    }
  }

  custCodeReadOnly() {
    if (custseriesNo.toString().toLowerCase() == '218') {
      seriesValuebool = false;
      notifyListeners();
    } else {
      seriesValuebool = true;
      notifyListeners();
    }
    notifyListeners();
  }

  couponcpybtn() {
    selectedcoupontype();
    if (cpndata.status == "Open") {
      mycontroller[36].text = cpndata.couponamt.toString();
    } else {
      mycontroller[36].text = 0.toString();
    }
    notifyListeners();
  }

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    ondDisablebutton = true;
    if (selectedcust == null) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
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
        ondDisablebutton = false;
        notifyListeners();
      });
    } else {
      if (advancetype == "Advance") {
        advSavePayReceiptValuesTODB('hold', context, theme);
        if (holddocentry.isNotEmpty) {
          DBOperation.deletepayreceipttHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            getdraftindex();
          });
        }
        holddocentry = '';
      } else {
        savepayreceiptValuesTODB('hold', context, theme);
        if (holddocentry.isNotEmpty) {
          DBOperation.deletepayreceipttHold(db, holddocentry.toString())
              .then((value) {
            onHoldFilter!.clear();
            getdraftindex();
          });
        }
        holddocentry = '';
        notifyListeners();
      }
    }

    notifyListeners();
  }

  mapHoldValues(int ih, BuildContext context, ThemeData theme) async {
    holddocentry = '';
    scanneditemData = [];
    loadingscrn = true;
    paymentWay = [];
    totalduepay = 0;
    selectedcust = CustomerDetals(
        name: salesPayModell5[ih].custName,
        taxCode: salesPayModell5[ih].taxCode!,
        phNo: salesPayModell5[ih].phNo,
        cardCode: salesPayModell5[ih].cardCode,
        U_CashCust: '',
        accBalance: salesPayModell5[ih].accBalance != null
            ? double.parse(salesPayModell5[ih].accBalance.toString())
            : 0,
        point: salesPayModell5[ih].point,
        address: salesPayModell5[ih].address!,
        tarNo: salesPayModell5[ih].tarNo,
        email: salesPayModell5[ih].email,
        invoicenum: salesPayModell5[ih].invoiceNum,
        docentry: salesPayModell5[ih].transdocentry.toString());

    if (salesPayModell5[ih].payItem!.isNotEmpty) {
      for (int i = 0; i < salesPayModell5[ih].payItem!.length; i++) {
        scanneditemData.add(InvoicePayReceipt(
            amount: salesPayModell5[ih].payItem![i].amount,
            transdocentry: salesPayModell5[ih].payItem![i].transdocentry,
            docNum: salesPayModell5[ih].payItem![i].docNum,
            date: salesPayModell5[ih].payItem![i].date,
            doctype: salesPayModell5[ih].payItem![i].doctype,
            checkbx: salesPayModell5[ih].payItem![i].checkbx,
            checkClr: salesPayModell5[ih].payItem![i].checkClr,
            sapbasedocentry: salesPayModell5[ih].payItem![i].sapbasedocentry));
      }
    } else {
      advancetype = "Advance";
    }

    for (int ij = 0; ij < salesPayModell5[ih].paymentway!.length; ij++) {
      paymentWay.add(PaymentWay(
          amt: salesPayModell5[ih].paymentway![ij].amt!,
          dateTime: salesPayModell5[ih].paymentway![ij].dateTime,
          reference: salesPayModell5[ih].paymentway![ij].reference ?? '',
          type: salesPayModell5[ih].paymentway![ij].type,
          cardApprno: salesPayModell5[ih].paymentway![ij].cardApprno,
          cardref: salesPayModell5[ih].paymentway![ij].cardref,
          cardterminal: salesPayModell5[ih].paymentway![ij].cardterminal,
          chequedate: salesPayModell5[ih].paymentway![ij].chequedate,
          chequeno: salesPayModell5[ih].paymentway![ij].chequeno,
          discountcode: salesPayModell5[ih].paymentway![ij].discountcode,
          discounttype: salesPayModell5[ih].paymentway![ij].discounttype,
          recoverydate: salesPayModell5[ih].paymentway![ij].recoverydate,
          redeempoint: salesPayModell5[ih].paymentway![ij].redeempoint,
          availablept: salesPayModell5[ih].paymentway![ij].availablept,
          remarks: salesPayModell5[ih].paymentway![ij].remarks,
          transtype: salesPayModell5[ih].paymentway![ij].transtype,
          walletid: salesPayModell5[ih].paymentway![ij].walletid,
          wallettype: salesPayModell5[ih].paymentway![ij].wallettype));
      notifyListeners();
    }

    paymentWay = salesPayModell5[ih].paymentway!;
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        selectedcust!.accBalance =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        mycontroller[i].text = scanneditemData[i].amount.toString();
        invMycontroller[i].text = scanneditemData[i].amount.toString();
        totalduepay =
            totalduepay! + double.parse(mycontroller[i].text.toString());
        notifyListeners();
      }
      notifyListeners();
    } else {
      if (scanneditemData.isEmpty && paymentWay.isNotEmpty) {
        advancests = true;
        notifyListeners();
      }
    }

    holddocentry = salesPayModell5[ih].docentry.toString();

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

  buttonHideMethod() {
    _isVisible = true;
    hideButtonController = ScrollController();
    hideButtonController.addListener(() {
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _isVisible = false;
        notifyListeners();
      }
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isVisible = true;
        notifyListeners();
      }
    });
  }

  selectall() {
    double totalduepayx = 0;
    advancetype = '';
    advancests = false;
    for (int i = 0; i < scanneditemData.length; i++) {
      log("mycontroller[i]2222:::${invMycontroller[i].text}");

      if (scanneditemData[i].checkbx == 0 &&
          scanneditemData[i].checkClr == false) {
        scanneditemData[i].checkbx = 1;
        scanneditemData[i].checkClr = true;
        totalduepayx = totalduepay! + scanneditemData[i].amount!;
        totalduepay = double.parse(totalduepayx.toStringAsFixed(2));
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

  aaaadvance(
    String advancetype1,
    BuildContext context,
    ThemeData theme,
  ) {
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
        advancests = false;
        notifyListeners();
      });
    } else {
      deSelectalladv(advancetype1, context, theme);
      advancetype = advancetype1;
    }
  }

  deSelectalladv(
    String advancetype1,
    BuildContext context,
    ThemeData theme,
  ) {
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].checkbx = 0;
      scanneditemData[i].checkClr = false;
      totalduepay = 0;
      notifyListeners();
    }
    advancetype = advancetype1;
  }

  clearAddress() {
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    checkboxx = false;
    postingDatecontroller.text = '';
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[20].clear();
    totalduepay = 0;
    advancetype = '';
    notifyListeners();
  }

  clearCustomer() {
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[21].clear();

    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    ondDisablebutton = true;
    selectbankCode = '';
    selectedBankType = null;
    bankhintcolor = false;
    scanneditemData.clear();
    selectedcust = null;
    mycontroller[50].clear();
    newAddrsValue = [];
    newCustValues = [];
    paymentWay.clear();
    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: " Data Cleared Successfully..!!",
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
      ondDisablebutton = false;
      notifyListeners();
    });
    ondDisablebutton = false;
  }

  clearpayData() async {
    advancests = false;
    paymentWay2.clear();
    selectedcust = null;
    selectedcust2 = null;
    isExpanded = false;
    scanneditemData.clear();
    scanneditemData2.clear();
    advancetype = '';
    holddocentry = '';
    advancests = false;
    paymentWay.clear();
    totalduepay2 = 0;
    totalduepay = 0;
    mycontroller2[50].text = "";
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

  forOnAccPaid2222() {
    double totalduepayx = 0;

    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 1 &&
          scanneditemData[i].checkClr == true) {
        scanneditemData[i].checkbx = 0;
        scanneditemData[i].checkClr = false;
        totalduepayx = totalduepay! - scanneditemData[i].amount!;
        totalduepay = double.parse(totalduepayx.toStringAsFixed(2));
        notifyListeners();
      }
    }
    typeee = 'Advance';

    notifyListeners();
  }

  foraccselect(BuildContext context, ThemeData theme, String type) {
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
          });
    } else if (selectedcust == null && advancetype == "Advance") {
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
          });
    } else if (scanneditemData.length < 0) {
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
          });
    } else if (advancetype != "Advance" &&
        scanneditemData.isNotEmpty &&
        paymentWay.isEmpty &&
        getBalancePaid() < 1 &&
        totalduepay! < 1 &&
        getSumTotalPaid() < 1) {
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
                      content: 'Choose a Advance or Document..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
        notifyListeners();
      });
    } else {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].checkClr == false) {
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
              });
        }
      }
    }
  }

  filtercustomerList(String v) {
    if (v.isNotEmpty) {
      filtercustList1 = custList
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.name!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercustList1 = custList;
      notifyListeners();
    }
  }

  refreshfiltercust() {
    filtercustList1 = custList;
    notifyListeners();
  }

  Future getCustDetFDB() async {
    custList.clear();
    custList2 = [];
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
            U_CashCust: cusdataDB[i].uCashCust,
            name: cusdataDB[i].customername,
            phNo: cusdataDB[i].phoneno1,
            taxCode: cusdataDB[i].taxCode,
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
    for (int j = 0; j < getTopCuslist.length; j++) {
      for (int i = 1; i < cusdataDB.length; i++) {
        if (cusdataDB[i].customerCode ==
            getTopCuslist[j]["customercode"].toString()) {
          custList2.add(CustomerDetals(
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
    }
    for (int i = 0; i < custList.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList[i].cardCode == csadresdataDB[ia].custcode) {
          custList[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype!,
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
    for (int i = 0; i < custList2.length; i++) {
      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (custList2[i].cardCode == csadresdataDB[ia].custcode) {
          custList2[i].address!.add(Address(
                autoId: int.parse(csadresdataDB[ia].autoid.toString()),
                addresstype: csadresdataDB[ia].addresstype!,
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
    if (newCustValues.isNotEmpty && newAddrsValue.isNotEmpty) {
      selectedcust = CustomerDetals(
        accBalance: custList[custList.length - 1].accBalance,
        cardCode: custList[custList.length - 1].cardCode,
        name: custList[custList.length - 1].name,
        taxCode: custList[custList.length - 1].taxCode,
        U_CashCust: custList[custList.length - 1].U_CashCust,
        phNo: custList[custList.length - 1].phNo,
        point: custList[custList.length - 1].point,
        tarNo: custList[custList.length - 1].tarNo,
        email: custList[custList.length - 1].email,
        address: [
          Address(
            address1: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address1,
            address2: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address2,
            address3: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .address3,
            billCity: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billCity,
            billCountry: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billCountry,
            billPincode: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billPincode,
            billstate: custList[custList.length - 1]
                .address![custList[custList.length - 1].address!.length - 1]
                .billstate,
          ),
        ],
      );
    }

    filtercustList1 = custList;
    notifyListeners();
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

    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        U_CashCust: customerDetals.U_CashCust,
        taxCode: customerDetals.taxCode,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        point: customerDetals.point,
        address: [],
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        taxCode: customerDetals.taxCode,
        name: customerDetals.name,
        U_CashCust: customerDetals.U_CashCust,
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
        notifyListeners();
      }
    }
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.accBalanceData != null) {
          updateCustBal =
              double.parse(value.accBalanceData![0].balance.toString());
          notifyListeners();
        } else {
          updateCustBal = 0;
        }
      } else {
        updateCustBal = 0;
      }
    });
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    notifyListeners();
    topcustcodeScan(context, theme);
  }

  billaddresslist() async {
    billadrrssItemlist = [];
    for (int i = 0; i < selectedcust!.address!.length; i++) {
      if (selectedcust!.address![i].addresstype == "B") {
        billadrrssItemlist.add(Address(
            autoId: selectedcust!.address![i].autoId,
            address1: selectedcust!.address![i].address1,
            addresstype: selectedcust!.address![i].addresstype,
            address2: selectedcust!.address![i].address2,
            address3: selectedcust!.address![i].address3,
            billCity: selectedcust!.address![i].billCity,
            billCountry: selectedcust!.address![i].billCountry,
            billPincode: selectedcust!.address![i].billPincode,
            billstate: selectedcust!.address![i].billstate));
        notifyListeners();
      }
      notifyListeners();
    }
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];
    for (int i = 0; i < selectedcust55!.address!.length; i++) {
      if (selectedcust55!.address![i].addresstype == "S") {
        shipadrrssItemlist.add(Address(
            autoId: selectedcust55!.address![i].autoId,
            addresstype: selectedcust55!.address![i].addresstype,
            address1: selectedcust55!.address![i].address1,
            address2: selectedcust55!.address![i].address2,
            address3: selectedcust55!.address![i].address3,
            billCity: selectedcust55!.address![i].billCity,
            billCountry: selectedcust55!.address![i].billCountry,
            billPincode: selectedcust55!.address![i].billPincode,
            billstate: selectedcust55!.address![i].billstate));
      }
      notifyListeners();
    }

    notifyListeners();
  }

  filterInvoiceList(String v) {
    if (v.isNotEmpty) {
      filterInvList = scanneditemData
          .where((e) =>
              e.docNum!.toLowerCase().contains(v.toLowerCase()) ||
              e.date!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterInvList = scanneditemData;
      notifyListeners();
    }
  }

  Future addProductValue() async {
    await addProductItem();

    notifyListeners();
  }

  totalpaidamt(BuildContext context, ThemeData theme) {
    totpaidamt = 0;
    totalduepay = 0;
    double totalduepayx = 0;

    double myctrlval = 0;
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].checkbx == 1) {
        if (scanneditemData[i].amount! >=
            double.parse(invMycontroller[i].text.toString())) {
          myctrlval =
              myctrlval + double.parse(invMycontroller[i].text.toString());
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
                        content:
                            'Your enter amount is more than invoice amount',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
      }
    }

    totalduepayx = totalduepay! + myctrlval;
    totalduepay = double.parse(totalduepayx.toStringAsFixed(2));
    notifyListeners();
    return totalduepay;
  }

  Future addProductItem() async {
    scanneditemData = [];
    totalinvamt = 0;
    for (int ins = 0; ins < salesPayModell5.length; ins++) {
      for (int i = 0; i < salesPayModell5[ins].payItem!.length; i++) {
        if (salesPayModell5[ins].invoiceNum ==
            salesPayModell5[ins].payItem![i].docNum) {
          scanneditemData.add(InvoicePayReceipt(
              checkClr: salesPayModell5[ins].payItem![i].checkClr,
              amount: salesPayModell5[ins].payItem![i].amount,
              docNum: salesPayModell5[ins].payItem![i].docNum,
              date: salesPayModell5[ins].payItem![i].date,
              doctype: salesPayModell5[ins].payItem![i].doctype,
              checkbx: salesPayModell5[ins].payItem![i].checkbx,
              transdocentry: salesPayModell5[ins].payItem![i].transdocentry,
              sapbasedocentry:
                  salesPayModell5[ins].payItem![i].sapbasedocentry));
        }
        notifyListeners();
      }
    }
    for (int ij = 0; ij < scanneditemData.length; ij++) {
      invMycontroller[ij].text =
          scanneditemData[ij].amount!.toStringAsFixed(2).toString();

      if (scanneditemData[ij].checkbx == 1) {
        totalduepay =
            totalduepay! + double.parse(invMycontroller[ij].text.toString());
        totalinvamt = scanneditemData[ij].amount;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  addCustomer() async {
    final Database db = (await DBHelper.getInstance())!;
    for (int ik = 0; ik < salesPayModell5.length; ik++) {
      log('salesPayModell5 card code::${salesPayModell5[ik].cardCode}');
      List<Map<String, Object?>> getcustaddd =
          await DBOperation.addgetCstmMasAddDB(
              db, salesPayModell5[ik].cardCode.toString());
      List<Map<String, Object?>> custData =
          await DBOperation.getCstmMasDatabyautoid(
              db, salesPayModell5[ik].cardCode.toString());
      selectedcust = CustomerDetals(
        name: custData[0]['customername'].toString() ?? '',
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customerCode'].toString(),
        U_CashCust: custData[0]['U_CASHCUST'].toString(),
        taxCode: custData[0]['TaxCode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
        invoicenum: salesPayModell5[ik].invoiceNum.toString(),
        invoiceDate: salesPayModell5[ik].invoceDate,
        docentry: salesPayModell5[ik].transdocentry.toString(),
      );
      notifyListeners();

      selectedcust55 = CustomerDetals(
        name: custData[0]['customername'].toString(),
        phNo: custData[0]['phoneno1'].toString(),
        cardCode: custData[0]['customercode'].toString(),
        U_CashCust: custData[0]['U_CASHCUST'].toString(),
        taxCode: custData[0]['taxCode'].toString(),
        accBalance: double.parse(custData[0]['balance'].toString()),
        point: custData[0]['points'].toString(),
        address: [],
        email: custData[0]['emalid'].toString(),
        tarNo: custData[0]['taxno'].toString(),
        invoicenum: salesPayModell5[ik].invoiceNum.toString(),
        invoiceDate: salesPayModell5[ik].invoceDate,
        docentry: salesPayModell5[ik].transdocentry.toString(),
      );
      notifyListeners();

      notifyListeners();

      for (int i = 0; i < getcustaddd.length; i++) {
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
    }
    notifyListeners();
  }

  injectfromdb() async {
    await getCustDetFDB();
    notifyListeners();
  }

  iniialCustList() {
    filtercustList1 = custList;
  }

  invoiceScan(BuildContext context, ThemeData theme) async {
    salesPayModell5 = [];
    scanneditemData = [];
    await callopenReceiptApiDocNum(
        invMycontroller[80].text.toString().trim(), theme, context);

    if (scanneditemData.isEmpty) {
      addProductValue();
      addCustomer();

      notifyListeners();
    }

    getcoupontypevalue();
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

  Future<int?> invoiceBatchAvail(
      String invcno, BuildContext context, ThemeData theme) async {
    salesPayModell5.clear();
    scanneditemData.clear();
    totalduepay = 0;
    totpaidamt = 0;
    advancetype = '';
    final Database db = (await DBHelper.getInstance())!;
    List<InvoicePayReceipt> scannData = [];

    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.salestosalesret(db, invcno.toString());

    for (int i = 0; i < getDBholddata1.length; i++) {
      List<Map<String, Object?>> salespayreceiptt =
          await DBOperation.salespaymentreceipt(
              db, getDBholddata1[i]['documentno'].toString());
      if (salespayreceiptt.isNotEmpty) {
        for (int ik = 0; ik < salespayreceiptt.length; ik++) {
          if (int.parse(getDBholddata1[i]['docentry'].toString()) ==
              int.parse(salespayreceiptt[ik]['docentry'].toString())) {
            scannData.add(InvoicePayReceipt(
              amount: salespayreceiptt[ik]['Balance'] != null
                  ? double.parse(salespayreceiptt[ik]['Balance']
                      .toString()
                      .replaceAll(',', ''))
                  : 0,
              docNum: getDBholddata1[i]['documentno'].toString(),
              date: salespayreceiptt[ik]['createdateTime'].toString(),
              doctype: salespayreceiptt[ik]['doctype'].toString(),
              transdocentry: salespayreceiptt[ik]['docentry'].toString(),
              checkClr: true,
              checkbx: 1,
              sapbasedocentry:
                  int.parse(salespayreceiptt[ik]['sapDocentry'].toString()),
            ));
            notifyListeners();
          }
        }
      } else {
        selectedcust = null;
        List<Map<String, Object?>> getDBholdPayReceiptdata1 =
            await DBOperation.getpayreceiptHeadDB(db);
        for (int ir = 0; ir < getDBholdPayReceiptdata1.length; ir++) {
          if (getDBholddata1[i]['docentry'].toString() ==
              getDBholdPayReceiptdata1[ir]['transdocentry'].toString()) {
            Get.defaultDialog(
                    title: "Alert",
                    middleText:
                        getDBholdPayReceiptdata1[ir]["docstatus"].toString() ==
                                '1'
                            ? 'Your document is hold on draft bills..!!'
                            : "",
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
              selectedcust = null;
              notifyListeners();
            });
          }
        }
      }
      notifyListeners();

      List<Map<String, Object?>> csadresdataDB =
          await DBOperation.addgetCstmMasAddDB(
              db, getDBholddata1[i]['customercode'].toString());
      List<Address> address55 = [];

      for (int ia = 0; ia < csadresdataDB.length; ia++) {
        if (getDBholddata1[i]['customercode'].toString() ==
            csadresdataDB[ia]['custcode'].toString()) {
          address55.add(Address(
            address1: csadresdataDB[ia]['address1'].toString(),
            address2: csadresdataDB[ia]['address2'].toString(),
            address3: csadresdataDB[ia]['address3'].toString(),
            billCity: csadresdataDB[ia]['city'].toString(),
            billCountry: csadresdataDB[ia]['countrycode'].toString(),
            billPincode: csadresdataDB[ia]['pincode'].toString(),
            billstate: csadresdataDB[ia]['statecode'].toString(),
          ));
        }
        notifyListeners();
      }

      SalesModel salesM = SalesModel(
          totaldue: double.parse(getDBholddata1[i]['doctotal'] == null
              ? '0'
              : getDBholddata1[i]['doctotal'].toString().replaceAll(',', '')),
          docentry: int.parse(getDBholddata1[i]['docentry'].toString()),
          taxCode: getDBholddata1[i]['taxCode'].toString(),
          transdocentry: getDBholddata1[i]['docentry'].toString(),
          custName: getDBholddata1[i]['customername'].toString(),
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
          address: address55,
          totalPayment: TotalPayment(
            totalTX: double.parse(getDBholddata1[i]['taxamount'] == null
                ? '0'
                : getDBholddata1[i]['taxamount'].toString()),

            subtotal: double.parse(getDBholddata1[i]['docbasic'] == null
                ? '0'
                : getDBholddata1[i]['docbasic']
                    .toString()
                    .replaceAll(',', '')), //doctotal
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
          payItem: scannData);

      salesPayModell5.add(salesM);

      notifyListeners();

      return Future.value(i);
    }
    notifyListeners();
    return Future.value(null);
  }

  topcustcodeScan(BuildContext context, ThemeData theme) async {
    await callCasrdCodeOpenReceiptApi(
      selectedcust!.cardCode.toString(),
    );

    if (scanneditemData.isEmpty) {
      addProductValue();
      addCustomer();

      notifyListeners();
    }
  }

  custcodeScan(BuildContext context, ThemeData theme) async {
    await callCasrdCodeOpenReceiptApi(
        mycontroller[81].text.toString().trim().toUpperCase());
    addProductValue();
    addCustomer();

    notifyListeners();
  }

  Future<int?> scancardcode(
      String invcno, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    salesPayModell5.clear();
    scanneditemData.clear();
    totalduepay = 0;
    List<InvoicePayReceipt> sscannData = [];

    List<Map<String, Object?>> getDBholdPayReceiptLine22 =
        await DBOperation.salespaymentareceiptcardcode(db, invcno.toString());
    for (int ik = 0; ik < getDBholdPayReceiptLine22.length; ik++) {
      sscannData.add(InvoicePayReceipt(
        sapbasedocentry:
            int.parse(getDBholdPayReceiptLine22[ik]['sapDocentry'].toString()),
        amount: getDBholdPayReceiptLine22[ik]['Balance'] != null
            ? double.parse(getDBholdPayReceiptLine22[ik]['Balance']
                .toString()
                .replaceAll(',', ''))
            : 0,
        docNum: getDBholdPayReceiptLine22[ik]['documentno'].toString(),
        date: getDBholdPayReceiptLine22[ik]['createdateTime'].toString(),
        doctype: getDBholdPayReceiptLine22[ik]['doctype'].toString(),
        transdocentry: getDBholdPayReceiptLine22[ik]['docentry'].toString(),
        checkClr: true,
        checkbx: 1,
      ));
      notifyListeners();
      SalesModel salesM = SalesModel(
          taxCode: getDBholdPayReceiptLine22[ik]['taxCode'].toString(),
          totaldue: double.parse(
              getDBholdPayReceiptLine22[ik]['doctotal'] == null
                  ? '0'
                  : getDBholdPayReceiptLine22[ik]['doctotal']
                      .toString()
                      .replaceAll(',', '')),
          docentry:
              int.parse(getDBholdPayReceiptLine22[ik]['docentry'].toString()),
          transdocentry: getDBholdPayReceiptLine22[ik]['docentry'].toString(),
          custName: getDBholdPayReceiptLine22[ik]['customername'].toString(),
          phNo: getDBholdPayReceiptLine22[ik]['customerphono'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customerphono'].toString(),
          cardCode: getDBholdPayReceiptLine22[ik]['customercode'].toString(),
          accBalance: getDBholdPayReceiptLine22[ik]['customeraccbal'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customeraccbal'].toString(),
          point: getDBholdPayReceiptLine22[ik]['customerpoint'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['customerpoint'].toString(),
          tarNo: getDBholdPayReceiptLine22[ik]['taxno'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['taxno'].toString(),
          email: getDBholdPayReceiptLine22[ik]['customeremail'] == null
              ? ''
              : getDBholdPayReceiptLine22[ik]['customeremail'].toString(),
          invoceDate: getDBholdPayReceiptLine22[ik]['createdateTime'] == null
              ? ""
              : getDBholdPayReceiptLine22[ik]['createdateTime'].toString(),
          invoiceNum: getDBholdPayReceiptLine22[ik]['documentno'].toString(),
          address: [],
          totalPayment: TotalPayment(
            totalTX: double.parse(
                getDBholdPayReceiptLine22[ik]['taxamount'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['taxamount'].toString()),

            subtotal: double.parse(
                getDBholdPayReceiptLine22[ik]['docbasic'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['docbasic']
                        .toString()
                        .replaceAll(',', '')), //doctotal
            discount2: double.parse(
                getDBholdPayReceiptLine22[ik]['docdiscamt'] != null
                    ? getDBholdPayReceiptLine22[ik]['docdiscamt'].toString()
                    : '0'),
            discount: double.parse(
                getDBholdPayReceiptLine22[ik]['docdiscamt'] != null
                    ? getDBholdPayReceiptLine22[ik]['docdiscamt'].toString()
                    : '0'),

            totalDue: double.parse(
                getDBholdPayReceiptLine22[ik]['doctotal'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['doctotal']
                        .toString()
                        .replaceAll(',', '')),
            totpaid: double.parse(
                getDBholdPayReceiptLine22[ik]['amtpaid'] == null
                    ? '0'
                    : getDBholdPayReceiptLine22[ik]['amtpaid']
                        .toString()
                        .replaceAll(',', '')),
            balance: double.parse(
                getDBholdPayReceiptLine22[ik]['baltopay'] != null
                    ? getDBholdPayReceiptLine22[ik]['baltopay']
                        .toString()
                        .replaceAll(',', '')
                    : '0'),
          ),
          payItem: sscannData);
      salesPayModell5.add(salesM);
    }

    notifyListeners();
    return null;
  }

  savepayreceiptValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertPaymentReceipt(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "submit") {
      insertPaymentReceipt(docstatus, context, theme);
    }

    notifyListeners();
  }

  advSavePayReceiptValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      advInsertPaymentReceipt(docstatus, context, theme);
      notifyListeners();
    } else if (docstatus.toLowerCase() == "submit") {
      advInsertPaymentReceipt(docstatus, context, theme);
    }

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

  insertPaymentReceipt(
      String? docstatus, BuildContext context, ThemeData theme) async {
    List<ReceiptHeaderTDB> receiptHeader = [];
    List<ReceiptLineTDB> receiptLine1 = [];
    List<ReceiptLine2TDB> receiptLine2 = [];
    final Database db = (await DBHelper.getInstance())!; //
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "ReceiptHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "ReceiptHeader");
    }
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 7);

    List<String> getseriesvalue = await checkingdoc(7);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();

    int selectdocentry = selectedcust != null && selectedcust!.docentry != null
        ? int.parse(selectedcust!.docentry.toString())
        : 0;

    List<Map<String, Object?>> sapdetails =
        await DBOperation.getSaleHeadSapDet(db, selectdocentry, 'SalesHeader');

    receiptHeader.add(ReceiptHeaderTDB(
      customerSeriesNum: '',
      docentry: docEntryCreated,
      doctype: "Payment Receipt",
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      customer: selectedcust!.cardCode.toString(),
      docnumber: documentNum.toString(),
      branch: UserValues.branch.toString(),
      lastupdateIp: UserValues.lastUpdateIp,
      series: '',
      seriesnumber: '',
      sysdate: config.currentDate(),
      totalamount: getSumTotalPaid().toString().replaceAll(',', ''),
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
      transdocentry: selectedcust!.docentry.toString(),
      transdocnum: selectedcust!.invoicenum.toString(),
      sapDocNo: null,
      qStatus: "No",
      sapDocentry: null,
      sapInvoicedocentry:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocentry'].toString() : "",
      sapInvoicedocnum:
          sapdetails.isNotEmpty ? sapdetails[0]['sapDocNo'].toString() : '',
      remarks: mycontroller[50].text.toString(),
    ));
    int? docentry5 = await DBOperation.insertRecieptHeader(db, receiptHeader);
    await DBOperation.updatenextno(db, 7, nextno);
    for (int ij = 0; ij < scanneditemData.length; ij++) {
      if (scanneditemData[ij].checkbx == 1) {
        receiptLine1.add(ReceiptLineTDB(
            TransAmount: double.parse(invMycontroller[ij].text.toString())
                .toStringAsFixed(2),
            TransDocDate: scanneditemData[ij].date.toString(),
            TransDocNum: scanneditemData[ij].docNum,
            transDocEnty: scanneditemData[ij].transdocentry,
            createdUserID: UserValues.userID.toString(),
            createdateTime: config.currentDate(),
            docentry: docentry5,
            lastupdateIp: UserValues.lastUpdateIp,
            rc_entry: ij,
            transType: scanneditemData[ij].doctype,
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID.toString(),
            branch: UserValues.branch,
            sapDocNo: null,
            qStatus: "No",
            sapDocentry: null,
            terminal: UserValues.terminal));
        notifyListeners();
      }
    }
    for (int i = 0; i < paymentWay.length; i++) {
      receiptLine2.add(ReceiptLine2TDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry5.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[i].amt!.toStringAsFixed(2),
          rcdatetime: selectedcust!.invoiceDate,
          rcdocentry: selectedcust!.docentry,
          rcmode: paymentWay[i].type.toString(),
          rcnumber: selectedcust!.invoicenum,
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          reference: paymentWay[i].reference,
          ref2: '',
          ref3: '',
          ref4: '',
          ref5: '',
          vouchCode: '',
          vouchCode2: '',
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
      await DBOperation.insertRecieptLine(db, receiptLine1, docentry5!);
    }
    if (receiptLine2.isNotEmpty) {
      await DBOperation.insertReciepLine2(db, receiptLine2, docentry5!);
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "submit") {
        if (!context.mounted) return;
        await callReceiptPostApi(
            context, theme, docentry5!, docstatus!, documentNum);

        notifyListeners();
      }
    }

    if (docstatus == "hold") {
      getdraftindex();
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "submit"
                  ? 'Successfully Done, Document Number is $documentNum'
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
        notifyListeners();
      });
      scanneditemData.clear();
      selectedcust = null;
      selectbankCode = '';
      selectedBankType = null;
      bankhintcolor = false;
      totalduepay = 0;
      paymentWay.clear();
      totpaidamt = 0;
      advancetype = '';
      mycontroller[80].clear();
      mycontroller[81].clear();
      mycontroller[50].clear();
      newAddrsValue = [];
      newCustValues = [];
      advancests = false;
      getcoupontypevalue();
      mycontroller[0].clear();
      mycontroller[1].clear();
      ondDisablebutton = false;

      notifyListeners();
    }
  }

  String seriesType = '';
  List<SeriesValue> seriesVal = [];
  callSeriesApi(BuildContext context, String type) async {
    final Database db = (await DBHelper.getInstance())!;
    seriesVal = [];
    seriesType = '';
    log('sessionid::${AppConstant.sapSessionID}');
    await SeriesAPi.getGlobalData('$type').then((value) async {
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

  callReceiptPostApi(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    await sapLoginApi(context);
    await postingReceipt(
      context,
      theme,
      docEntry,
      docstatus,
      documentNum,
    );
    notifyListeners();
  }

  List<PostPaymentCheck> itemsPaymentCheckDet = [];
  List<PostPaymentInvoice> itemsPaymentInvDet = [];
  List<PostPaymentCard> itemcardPayment = [];

  addCardValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    itemcardPayment = [];
    String creditAcc = (preferences.getString('UCreditAccount'))!.toString();
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == "Card") {
        itemcardPayment.add(PostPaymentCard(
            creditAcc: creditAcc,
            cardValidity: config.currentDate2(),
            creditSum: paymentWay[i].amt,
            creditCardNum: paymentWay[i].cardApprno.toString(),
            creditcardCode: 1,
            voucherNum: paymentWay[i].reference.toString()));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  List<NewCashCardAccDetailData> newCashAcc = [];
  callNewCashAccountApi() async {
    newCashAcc = [];
    await NewCashCardAccountAPi.getGlobalData(AppConstant.branch).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData!.isNotEmpty) {
          newCashAcc = value.activitiesData!;
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  String? cashAcctype;
  String? cashAccCode;

  String? cardAcctype;
  String? cardAccCode;

  String? chequeAcctype;
  String? chequeAccCode;

  String? transAcctype;
  String? transAccCode;

  String? walletAcctype;
  String? walletAccCode;
  NewCashAccSelect(value) {
    for (var i = 0; i < newCashAcc.length; i++) {
      if (newCashAcc[i].uAcctName == value) {
        if (newCashAcc[i].uMode == 'CASH') {
          cashAccCode = newCashAcc[i].uAcctCode.toString();
          log('step1::${cashAccCode}');
        } else if (newCashAcc[i].uMode == 'CARD') {
          cardAccCode = newCashAcc[i].uAcctCode.toString();
          log('step12');
        } else if (newCashAcc[i].uMode == 'CHEQUE') {
          log('step13');

          chequeAccCode = newCashAcc[i].uAcctCode.toString();
        } else if (newCashAcc[i].uMode == 'WALLET') {
          walletAccCode = newCashAcc[i].uAcctCode.toString();
          log('step14:::$walletAccCode');
        } else if (newCashAcc[i].uMode == 'TRANSFER') {
          log('step15');

          transAccCode = newCashAcc[i].uAcctCode.toString();
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }

  addChequeValues() {
    itemsPaymentCheckDet = [];
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == "Cheque") {
        itemsPaymentCheckDet.add(PostPaymentCheck(
            dueDate: config.currentDate(),
            checkNumber: int.parse(paymentWay[i].chequeno.toString()),
            bankCode: selectbankCode,
            accounttNum: '',
            details: remarkcontroller3.text,
            checkSum: paymentWay[i].amt!));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  addInvoiceLine() {
    itemsPaymentInvDet = [];
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].checkbx == 1 &&
            scanneditemData[i].checkClr == true) {
          itemsPaymentInvDet.add(PostPaymentInvoice(
              docEntry: scanneditemData[i].sapbasedocentry,
              docNum: int.parse(scanneditemData[i].docNum.toString()),
              sumApplied: scanneditemData[i].amount,
              invoiceType: 'it_Invoice'));
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  postingReceipt(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    await callSeriesApi(context, '24');
    await addChequeValues();
    await addCardValues();
    await addInvoiceLine();
    String wallwtType = wallet != null ? wallet! : '';

    ReceiptPostAPi.transferSum = null;
    ReceiptPostAPi.cashSum = null;
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.seriesType = seriesType.toString();
    ReceiptPostAPi.checkAccount = chequeAccCode;
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentCards = itemcardPayment;
    ReceiptPostAPi.docPaymentInvoices = itemsPaymentInvDet;
    ReceiptPostAPi.docDate = postingDatecontroller.text.isNotEmpty
        ? config.alignDate2(postingDatecontroller.text)
        : '';
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = mycontroller[50].text +
        " " +
        mycontroller[32].text +
        " " +
        mycontroller[33].text +
        " " +
        wallwtType;
    ReceiptPostAPi.journalRemarks = mycontroller[50].text +
        " " +
        mycontroller[32].text +
        " " +
        mycontroller[33].text +
        " " +
        wallwtType;

    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == 'Cash') {
        ReceiptPostAPi.cashAccount = cashAccCode;
        ReceiptPostAPi.cashSum = paymentWay[i].amt;
        notifyListeners();
      }

      if (paymentWay[i].type == 'Transfer') {
        ReceiptPostAPi.transferAccount = transAccCode;
        ReceiptPostAPi.transferSum = paymentWay[i].amt!;
        ReceiptPostAPi.transferReference = paymentWay[i].transref;
        ReceiptPostAPi.transferDate = config.currentDate.toString();
        notifyListeners();
      }
      if (paymentWay[i].type == 'Wallet') {
        ReceiptPostAPi.cashAccount = walletAccCode;
        ReceiptPostAPi.cashSum = paymentWay[i].amt;
        notifyListeners();
      }
      notifyListeners();
    }

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry!),
              int.parse(sapDocuNumber), docEntry, 'ReceiptHeader');

          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(sapDocuNumber),
              int.parse(sapDocentry!),
              'ReceiptLine2');

          notifyListeners();
          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "submit"
                      ? 'Successfully Done, Document Number is $sapDocuNumber'
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
              mycontroller = List.generate(150, (i) => TextEditingController());
              selectedcust = null;
              paymentWay.clear();
              postingDatecontroller.text = '';
              remarkcontroller3.text = "";
              scanneditemData.clear();
              cashAccCode = '';
              cardAcctype = '';
              cardAccCode = '';
              chequeAcctype = '';
              chequeAccCode = '';
              transAcctype = '';
              transAccCode = '';
              walletAcctype = '';
              walletAccCode = '';
              Get.offAllNamed(ConstantRoutes.dashboard);
            }

            notifyListeners();
          });
          custserieserrormsg = '';
        } else {
          custserieserrormsg = value.error!.message!.value.toString();
          mycontroller = List.generate(150, (i) => TextEditingController());

          selectedcust = null;
          cashAcctype = null;
          cashAccCode = null;
          cardAcctype = null;
          cardAccCode = null;
          chequeAcctype = null;
          chequeAccCode = null;
          transAcctype = null;
          transAccCode = null;
          walletAcctype = null;
          walletAccCode = null;
          paymentWay.clear();
          postingDatecontroller.text = '';

          scanneditemData.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
        }
      } else if (value.stscode! >= 400 && value.stscode! <= 410) {
        custserieserrormsg = value.error!.message!.value.toString();
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
          ondDisablebutton = false;

          notifyListeners();
        });
      } else {
        custserieserrormsg = value.exception.toString();
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
          ondDisablebutton = false;

          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  advInsertPaymentReceipt(
      String? docstatus, BuildContext context, ThemeData theme) async {
    List<ReceiptHeaderTDB> receiptHeader = [];
    List<ReceiptLine2TDB> receiptLine2 = [];
    final Database db = (await DBHelper.getInstance())!;
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "ReceiptHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "ReceiptHeader");
    }
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 7);

    List<String> getseriesvalue = await checkingdoc(7);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();

    receiptHeader.add(ReceiptHeaderTDB(
      docentry: docEntryCreated,
      doctype: "Payment Receipt",
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      customerSeriesNum: '',
      customer: selectedcust!.cardCode.toString(),
      docnumber: documentNum.toString(),
      branch: UserValues.branch.toString(),
      lastupdateIp: UserValues.lastUpdateIp,
      series: '',
      seriesnumber: '',
      sysdate: config.currentDate(),
      totalamount: getSumTotalPaid().toString().replaceAll(',', ''),
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
      transdocentry: '',
      transdocnum: '',
      sapDocNo: null,
      qStatus: "NO",
      sapDocentry: null,
      sapInvoicedocentry: '',
      sapInvoicedocnum: '',
      remarks: mycontroller[50].text.toString(),
    ));
    int? docentry5 = await DBOperation.insertRecieptHeader(db, receiptHeader);
    await DBOperation.updatenextno(db, 7, nextno);

    for (int i = 0; i < paymentWay.length; i++) {
      receiptLine2.add(ReceiptLine2TDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry5.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[i].amt!.toStringAsFixed(2).replaceAll(',', ''),
          rcdatetime: selectedcust!.invoiceDate,
          rcdocentry: selectedcust!.docentry,
          rcmode: paymentWay[i].type.toString(),
          rcnumber: selectedcust!.invoicenum,
          updatedDatetime: config.currentDate(),
          updateduserid: UserValues.userID.toString(),
          reference: paymentWay[i].reference,
          ref2: '',
          ref3: '',
          ref4: '',
          ref5: '',
          vouchCode: '',
          vouchCode2: '',
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

    if (receiptLine2.isNotEmpty) {
      await DBOperation.insertReciepLine2(db, receiptLine2, docentry5!);
    }
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      if (docstatus == "submit") {
        await callReceiptPostApi(
            context, theme, docentry5!, docstatus!, documentNum);
        notifyListeners();
      }
    }
    if (docstatus == "hold") {
      getdraftindex();
      notifyListeners();
      ondDisablebutton = true;
      advancests = false;
      scanneditemData.clear();
      selectedcust = null;
      totalduepay = 0;
      paymentWay.clear();
      totpaidamt = 0;
      advancetype = '';
      postingDatecontroller.text = '';
      mycontroller[80].text = "";
      mycontroller[81].text = "";
      mycontroller[0].text = "";
      mycontroller[1].text = "";
      Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "hold" ? "Saved as draft" : "null",
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
          Get.offAllNamed(ConstantRoutes.dashboard);
        }
        ondDisablebutton = false;
        notifyListeners();
      });
    }
  }

  postRabitMqPaymentReceipt(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry!);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    String receiptPAY = json.encode(getDBReceipt2);
    String receiptLine = json.encode(getDBReceiptLine);
    String receiptHeader = json.encode(getDBReceiptHeader);
    var ddd = json.encode({
      "ObjectType": 7,
      "ActionType": "Add",
      "ReceiptHeader": receiptHeader,
      "ReceiptLine": receiptLine,
      "ReceiptPay": receiptPAY,
    });
//log("payload11 : $ddd");
    //RabitMQ
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //"102.69.167.106"
        //AppConstant.ip
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqPaymentReceipt2(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBReceipt2 =
        await DBOperation.getReceiptLine2(db, docentry!);
    List<Map<String, Object?>> getDBReceiptLine =
        await DBOperation.getReceiptLine1(db, docentry);
    List<Map<String, Object?>> getDBReceiptHeader =
        await DBOperation.getReceiptHeaderDB(db, docentry);
    String receiptPAY = json.encode(getDBReceipt2);
    String receiptLine = json.encode(getDBReceiptLine);
    String receiptHeader = json.encode(getDBReceiptHeader);
    var ddd = json.encode({
      "ObjectType": 7,
      "ActionType": "Add",
      "ReceiptHeader": receiptHeader,
      "ReceiptLine": receiptLine,
      "ReceiptPay": receiptPAY,
    });
//log("payload22 :$ddd");
    //RabitMQ

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        //"102.69.167.106"
        //AppConstant.ip
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"Branch": UserValues.branch};
    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    client1.close();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getholdpayreceiptHeadDB(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);

      notifyListeners();
    }
    notifyListeners();
  }

  getSelectbankCode(String value) {
    selectbankCode = '';
    for (var i = 0; i < bankList.length; i++) {
      if (bankList[i].bankName == value) {
        selectbankCode = bankList[i].bankCode.toString();
        log('selectbankCode:::$selectbankCode');
      }
      notifyListeners();
    }
    notifyListeners();
  }

  List<BankListValue> bankList = [];
  String? selectedBankType;
  String selectbankCode = '';
  bool bankhintcolor = false;
  bool get getbankhintcolor => bankhintcolor;
  callBankmasterApi() async {
    bankList = [];
    await GetBankListAPI.getData().then((value) {
      if (value.stsCode >= 200 && value.stsCode <= 210) {
        for (var i = 0; i < value.listValue.length; i++) {
          if (value.listValue[i].bankName!.isNotEmpty) {
            bankList.add(BankListValue(
                bankCode: value.listValue[i].bankCode,
                bankName: value.listValue[i].bankName,
                accountforOutgoingChecks:
                    value.listValue[i].accountforOutgoingChecks,
                branchforOutgoingChecks:
                    value.listValue[i].branchforOutgoingChecks,
                nextCheckNumber: value.listValue[i].nextCheckNumber,
                swiftNo: value.listValue[i].swiftNo,
                iban: value.listValue[i].iban,
                countryCode: value.listValue[i].countryCode,
                postOffice: value.listValue[i].postOffice,
                absoluteEntry: value.listValue[i].absoluteEntry,
                defaultBankAccountKey: value.listValue[i].defaultBankAccountKey,
                digitalPayments: value.listValue[i].digitalPayments));
            notifyListeners();
          }
        }

        notifyListeners();
      } else if (value.stsCode >= 400 && value.stsCode <= 410) {
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  getdraft(int ji) async {
    salesPayModell5.clear();
    totalduepay = 0;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholdPayReceiptdata1 =
        await DBOperation.getholdpayreceiptHeadDB(db);
    List<Address> address55 = [];

    List<InvoicePayReceipt> scannData = [];
    List<PaymentWay> payment = [];
    CustomerDetals? customeredetailss = CustomerDetals();
    List<Map<String, Object?>>? getDBholdPayReceiptLine =
        await DBOperation.getpayreceipLine11DB(
            db, int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> getDBholdPayReceiptLine22 =
        await DBOperation.getpayreceipLine22DB(
            db, int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, getDBholdPayReceiptdata1[ji]['customer'].toString());
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
          csadresdataDB[ia]['custcode'].toString()) {
        address55.add(Address(
          custcode: csadresdataDB[ia]['custcode'].toString(),
          autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
          addresstype: csadresdataDB[ia]['addresstype'].toString(),
          address1: csadresdataDB[ia]['address1'].toString(),
          address2: csadresdataDB[ia]['address2'].toString(),
          address3: csadresdataDB[ia]['address3'].toString(),
          billCity: csadresdataDB[ia]['city'].toString(),
          billCountry: csadresdataDB[ia]['countrycode'].toString(),
          billPincode: csadresdataDB[ia]['pincode'].toString(),
          billstate: csadresdataDB[ia]['statecode'].toString(),
        ));
        notifyListeners();
      }
    }
    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(
            db, getDBholdPayReceiptdata1[ji]['customer'].toString());
    if (getDBholdPayReceiptdata1[ji]['customer'].toString() ==
        custData[0]['customerCode'].toString()) {
      CustomerDetals customerde = CustomerDetals(
          accBalance: double.parse(custData[0]['balance'].toString()),
          name: custData[0]['customername'].toString(),
          phNo: custData[0]['phoneno1'].toString(),
          U_CashCust: custData[0]['U_CASHCUST'].toString(),
          taxCode: custData[0]['taxCode'].toString(),
          cardCode: custData[0]['customerCode'].toString(),
          point: custData[0]['points'].toString(),
          address: address55,
          tarNo: custData[0]['taxno'].toString(),
          email: custData[0]['emalid'].toString(),
          docentry: getDBholdPayReceiptdata1[ji]['docentry'].toString());
      customeredetailss = customerde;
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
          couponcode: getDBholdPayReceiptLine22[kk]['couponcode'].toString(),
          coupontype: getDBholdPayReceiptLine22[kk]['coupontype'].toString(),
          discountcode:
              getDBholdPayReceiptLine22[kk]['discountcode'].toString(),
          discounttype:
              getDBholdPayReceiptLine22[kk]['discounttype'].toString(),
          recoverydate:
              getDBholdPayReceiptLine22[kk]['recoverydate'].toString(),
          redeempoint: getDBholdPayReceiptLine22[kk]['redeempoint'].toString(),
          availablept: getDBholdPayReceiptLine22[kk]['availablept'].toString(),
          remarks: getDBholdPayReceiptLine22[kk]['remarks'].toString(),
          transtype: getDBholdPayReceiptLine22[kk]['transtype'].toString(),
          walletid: getDBholdPayReceiptLine22[kk]['walletid'].toString(),
          wallettype: getDBholdPayReceiptLine22[kk]['wallettype'].toString(),
          basedoctype: '',
        ));
        notifyListeners();
      }
    }
    if (getDBholdPayReceiptLine.isNotEmpty) {
      for (int ik = 0; ik < getDBholdPayReceiptLine.length; ik++) {
        if (getDBholdPayReceiptdata1[ji]['docentry'] ==
            getDBholdPayReceiptLine[ik]['docentry']) {
          scannData.add(InvoicePayReceipt(
            date: getDBholdPayReceiptLine[ik]['TransDocDate'].toString(),
            amount: double.parse(
                getDBholdPayReceiptLine[ik]['TransAmount'].toString()),
            docNum: getDBholdPayReceiptLine[ik]['TransDocNum'].toString(),
            doctype: getDBholdPayReceiptLine[ik]['transType'].toString(),
            transdocentry:
                getDBholdPayReceiptLine[ik]['transDocEnty'].toString(),
            checkClr: true,
            checkbx: 1,
            sapbasedocentry:
                getDBholdPayReceiptdata1[ji]['sapInvoicedocentry'] == null ||
                        getDBholdPayReceiptdata1[ji]['sapInvoicedocentry']
                            .toString()
                            .isEmpty
                    ? null
                    : int.parse(getDBholdPayReceiptdata1[ji]
                            ['sapInvoicedocentry']
                        .toString()),
          ));
        }

        notifyListeners();
      }
    }

    log('address55address55::${address55.length}');
    SalesModel salesM = SalesModel(
        transdocentry: getDBholdPayReceiptdata1[ji]['transdocentry'].toString(),
        docentry:
            int.parse(getDBholdPayReceiptdata1[ji]['docentry'].toString()),
        address: address55,
        custName: customeredetailss != null
            ? customeredetailss.name.toString()
            : null,
        phNo: customeredetailss != null ? customeredetailss.phNo : "",
        totaldue: getDBholdPayReceiptdata1[ji]['totalamount'] != null
            ? double.parse(
                getDBholdPayReceiptdata1[ji]['totalamount'].toString())
            : 0,
        cardCode: customeredetailss != null ? customeredetailss.cardCode : "",
        accBalance: customeredetailss != null
            ? customeredetailss.accBalance.toString()
            : null,
        point: customeredetailss != null ? customeredetailss.point : "",
        tarNo: customeredetailss != null ? customeredetailss.tarNo : "",
        taxCode: customeredetailss != null ? customeredetailss.taxCode : "",
        email: customeredetailss != null ? customeredetailss.email : "",
        invoceDate:
            customeredetailss != null ? customeredetailss.invoiceDate : "",
        createdateTime:
            getDBholdPayReceiptdata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholdPayReceiptdata1[ji]['documentno'].toString(),
        payItem: scannData,
        paymentway: payment);
    notifyListeners();

    notifyListeners();

    salesPayModell5.add(salesM);

    onHoldFilter = salesPayModell5;
    notifyListeners();

    notifyListeners();
  }

  insertpaymentreceipt() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.deletereceipt(db);
    notifyListeners();
  }

  createnewchagescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    await addnewCustomer(context, theme, ij);
    await getCustDetFDB();
    await getNewCustandadd(context);
    notifyListeners();
  }

  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    int sucesss = 0;
    tinfileError = '';
    vatfileError = '';
    if (formkey[ij].currentState!.validate()) {
      sucesss = sucesss + 1;
    }

    if (formkeyAd.currentState!.validate()) {
      sucesss = sucesss + 1;
      notifyListeners();
    }

    if (sucesss == 2) {
      if (tinFiles == null) {
        fileValidation = true;
        tinfileError = "Select a Tin File";
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: tinfileError,
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          loadingBtn = false;
          notifyListeners();
        });

        notifyListeners();
      } else if (vatFiles == null) {
        fileValidation = true;
        vatfileError = 'Select a Vat File';
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: vatfileError,
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          loadingBtn = false;
          notifyListeners();
        });

        notifyListeners();
      } else {
        fileValidation = false;
        notifyListeners();
      }
      await callCustPostApi(context, theme);

      notifyListeners();
    } else {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: textError,
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  getNewCustandadd(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    selectedcust55 = null;

    mycontroller[3].text = mycontroller[3].text.isNotEmpty
        ? mycontroller[3].text.toString()
        : cardCodexx.toString();
    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(
            db, mycontroller[3].text.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, mycontroller[3].text.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      selectedcust = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          U_CashCust: newcusdataDB[i]['U_CASHCUST'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
      notifyListeners();
      selectedcust55 = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          U_CashCust: newcusdataDB[i]['U_CASHCUST'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          email: newcusdataDB[i]['emalid'].toString(),
          invoicenum: '',
          invoiceDate: '',
          totalPayment: 00,
          address: []);
      notifyListeners();
    }
    if (newaddrssdataDB.isNotEmpty) {
      for (int ik = 0; ik < newaddrssdataDB.length; ik++) {
        if (newaddrssdataDB[ik]['addresstype'].toString() == "B") {
          selectedcust!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
          notifyListeners();
        }

        if (newaddrssdataDB[ik]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              autoId: int.parse(newaddrssdataDB[ik]['autoid'].toString()),
              addresstype: newaddrssdataDB[ik]['addresstype'].toString(),
              address1: newaddrssdataDB[ik]['address1'].toString(),
              address2: newaddrssdataDB[ik]['address2'].toString(),
              address3: newaddrssdataDB[ik]['address3'].toString(),
              billCity: newaddrssdataDB[ik]['city'].toString(),
              billCountry: newaddrssdataDB[ik]['countrycode'].toString(),
              billPincode: newaddrssdataDB[ik]['pincode'].toString(),
              billstate: newaddrssdataDB[ik]['statecode'].toString(),
            ),
          );
        }

        selectedBillAdress = selectedcust!.address!.length - 1;
        selectedShipAdress = selectedcust55!.address!.length - 1;
      }
    }

    notifyListeners();
  }

  getcoupontypevalue() async {
    final Database db = (await DBHelper.getInstance())!;
    String custcardcode =
        (selectedcust != null && selectedcust!.cardCode != null)
            ? selectedcust!.cardCode.toString()
            : '';

    List<Map<String, Object?>> couponTypeValue =
        await DBOperation.getcoupontype(db, custcardcode.toString());
    for (int i = 0; i < couponTypeValue.length; i++) {
      couponData.add(CouponDetModel(
          coupontype: couponTypeValue[i]['coupontype'].toString(),
          createdUserID: couponTypeValue[i]['createdUserID'] != null
              ? int.parse(couponTypeValue[i]['createdUserID'].toString())
              : null,
          couponcode: couponTypeValue[i]['couponcode'].toString(),
          status: couponTypeValue[i]['status'].toString(),
          cardcode: couponTypeValue[i]['cardcode'].toString(),
          doctype: couponTypeValue[i]['doctype'].toString(),
          lastupdateIp: couponTypeValue[i]['lastupdateIp'].toString(),
          couponamt: double.parse(couponTypeValue[i]['couponamt'].toString()),
          updateduserid: couponTypeValue[i]['updateduserid'] != null
              ? int.parse(couponTypeValue[i]['updateduserid'].toString())
              : null));
    }
  }
}
