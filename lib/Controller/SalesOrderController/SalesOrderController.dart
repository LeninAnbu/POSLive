import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/QueryUrlModel/cashcardaccountsModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Models/ServiceLayerModel/BankListModel/BankListsModels.dart';
import 'package:posproject/Models/ServiceLayerModel/SapSalesOrderModel/OrderModelForPutModel.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Pages/SalesOrder/Widgets/Ordrprintinglayout.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/Service/QueryURL/cashcardaccountdetailsApi.dart';
import 'package:posproject/ServiceLayerAPIss/BankListApi/BankListsApi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/SalesOrderHeader.dart';
import '../../DBModel/SalesOrderLineDB.dart';
import '../../DBModel/SalesOrderPay.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/ItemCode/Itemcodelist.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/DataModel/StockReqModel/warehouseModel.dart';
import '../../Models/QueryUrlModel/CompanyAddModel.dart';
import '../../Models/QueryUrlModel/DocSeriesMdl.dart';
import '../../Models/QueryUrlModel/LeadDateMdl.dart';
import '../../Models/QueryUrlModel/NewCashAccount.dart';
import '../../Models/QueryUrlModel/NewSeriesMode.dart';
import '../../Models/QueryUrlModel/OnhandModel.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderLineModel.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/AccountBalModel.dart';
import '../../Models/Service Model/CusotmerSeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/GetSapOrderstatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_details.modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_order_modal.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Service/NewCashAccountApi.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../Service/Printer/orderPrint.dart';
import '../../Service/QueryURL/CompanyAddressApi.dart';
import '../../Service/QueryURL/CreditDaysModelAPI.dart';
import '../../Service/QueryURL/CreditLimitModeAPI.dart';
import '../../Service/QueryURL/DocSeriesApi.dart';
import '../../Service/QueryURL/LeadDateApi.dart';
import '../../Service/QueryURL/NewSeriesApi.dart';
import '../../Service/QueryURL/OnHandApi.dart';
import '../../Service/QueryURL/OpenQuotLineApi.dart';
import '../../Service/QueryURL/OpenQuotationApi.dart';
import '../../Service/QueryURL/SoCustomerAddressApi.dart';
import '../../Service/SearchQuery/SearchOrderHeaderApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/AfterApvlToDocNumApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/ApprovalQueryApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/DraftToDocOrderApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/OrderRejectedApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/PendingApprovals_api.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderDetailsApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderPatchApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/PostOrderAPI2.dart';
import '../../ServiceLayerAPIss/OrderAPI/PostSalesOrder.dart';
import '../../ServiceLayerAPIss/OrderAPI/ApprovalAPIs/approvals_details_api.dart';
import '../../ServiceLayerAPIss/OrderAPI/getCreaditDays/getBalanceCreditLimit.dart';
import '../../ServiceLayerAPIss/OrderAPI/getCreaditDays/getCreaditDaysApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Pages/SalesOrder/Widgets/SOBar.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../Service/SchemeOrderApi.dart';
import '../../ServiceLayerAPIss/OrderAPI/GetOrderAPI.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderCancelAPI.dart';
import '../../ServiceLayerAPIss/OrderAPI/OrderLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';

class SOCon extends ChangeNotifier {
  Configure config = Configure();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController tinNoController = TextEditingController();
  TextEditingController vatNoController = TextEditingController();
  List<GlobalKey<FormState>> formkey =
      List.generate(500, (i) => GlobalKey<FormState>());
  List<GlobalKey<FormState>> approvalformkey =
      List.generate(500, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAd = GlobalKey<FormState>();
  List<HoldedHeader> holdData = [];
  List<HoldedHeader> fileterHoldData = [];
  List<String> catchmsg = [];
  List<SalesOrderScheme> schemeData = [];
  List<SchemeOrderModalData> resSchemeDataList = [];
  List<TextEditingController> mycontroller =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> pricemycontroller =
      List.generate(500, (i) => TextEditingController());
  //
  List<TextEditingController> qtymycontroller =
      List.generate(500, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller =
      List.generate(500, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller2 =
      List.generate(500, (ij) => TextEditingController());
  List<TextEditingController> udfController =
      List.generate(500, (ij) => TextEditingController());

  TextEditingController remarkcontroller3 = TextEditingController();
  List<TextEditingController> warehousectrl =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> mycontroller2 =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> itemListDateCtrl =
      List.generate(200, (i) => TextEditingController());
  List<TextEditingController> itemListDateCtrl2 =
      List.generate(200, (i) => TextEditingController());
  List<TextEditingController> qtymycontroller2 =
      List.generate(500, (ij) => TextEditingController());
  TextEditingController searchcontroller = TextEditingController();
  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;
  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> scanneditemCheckUpdateData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  List<ItemMasterModelDB> getSearchedData = [];
  List<ItemMasterModelDB> getfilterSearchedData = [];
  List<ItemMasterModelDB> getAllSelect = [];
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  List<CustomerModelDB> newCustValues = [];
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];

  List<searchModel> searchData = [];

  List<FocusNode> focusnode = List.generate(500, (i) => FocusNode());
  String holddocentry = '';
  ItemCodeListModel? itemcodeitem;
  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;
  List<SalesModel> soSalesmodl = [];
  List<SalesModel> salesmodl = [];

  List<StocksnapModelData> soScanItem = [];

  bool schemebtnclk = false;
  bool clickAprList = false;

  bool cancelbtn = false;
  List<TextEditingController> soqtycontroller =
      List.generate(500, (ij) => TextEditingController());
  CustomerDetals? selectedcust;
  TextEditingController custNameController = TextEditingController();
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  String? totquantity;
  double? discountamt;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  String sapDocuNumber = '';
  int? sapReceiptDocentry;
  int? sapBaseDocEntry;

  String cancelDocnum = '';
  int? tbDocEntry;
  String? custseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  bool loadingBtn = false;
  bool loadingSqBtn = false;

  bool getsqdata = false;
  List<CustSeriesModelData> seriesData = [];

  List<OrderDocumentLine> sapSaleOrderModelData = [];
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];

  List<ApprovalsOrdersValue> filterAprvlData = [];
  List<ApprovalsOrdersValue> searchAprvlData = [];
  List<ApprovalsValue> pendingApprovalData = [];
  List<ApprovalsValue> filterPendingApprovalData = [];
  List<ApprovalsValue> rejectedData = [];
  List<ApprovalsValue> filterRejectedData = [];
  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;

  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String? shipaddress = "";

  bool searchbool = false;
  bool onDisablebutton = false;
  TextEditingController searchcon = TextEditingController();
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  bool groCustLoad = false;
  String? custerrormsg = '';
  String cardCodexx = '';

  List<CustomerDetals> custList2 = [];
  String exception = '';
  bool loading = false;

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;

  bool checkboxx = false;
  bool editqty = false;

  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<AccountBalanceModelData> accBalList = [];
  String textError = '';

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;

  String? selectedValue;
  String? get getselectedValue => selectedValue;

  bool isLoading = false;
  bool schemeApiLoad = false;
  bool isApprove = false;
  bool visibleItemList = false;
  FocusNode searchFocus1 = FocusNode();
  int? groupValueSelected = 0;
  int? get getgroupValueSelected => groupValueSelected;
  Future<void> init(BuildContext context, ThemeData theme) async {
    bool? havenet = await config.haveInterNet();

    log('haveInterNet::${havenet}');
    getSlpCode();
    clearAllData(context, theme);
    clearAll(context, theme);
    await callGetUserType();
    await callNewSeriesApi();
    await callNewDocSeriesApi();
    await getBrachDetails();

    injectToDb();
    await getCustDetFDB();
    await getdraftindex();
    await custSeriesApi();
    await sapOrderLoginApi(context);
    await callBankmasterApi();
    notifyListeners();
  }

  static const MethodChannel _channel =
      MethodChannel('com.buson.posinsignia/location');

  String? whsName;
  String? whsCode;

  List<WhsDetails> whsLists = [];

  selectedWhsCode(String val) async {
    for (var i = 0; i < whsLists.length; i++) {
      if (whsLists[i].companyName.toString() == val) {
        whsCode = whsLists[i].whsCode;

        if (editqty == true) {
          await callNewCashAccountApi(whsCode!);
        }
      }
    }
    notifyListeners();
  }

// AccCode
  selectedWhsCode2(String val) async {
    for (var i = 0; i < whsLists.length; i++) {
      if (whsLists[i].whsCode.toString() == val) {
        whsName = whsLists[i].companyName;
        whsCode = whsLists[i].whsCode;

        warehousectrl[0].text = whsLists[i].companyName!;
      }
    }
    log('whsName1::${whsName}');
    notifyListeners();
  }

  List<NewDocSeriesMdlData> newDocSeries = [];
  callNewDocSeriesApi() async {
    newDocSeries = [];
    await Newsdoceriesapi.getGlobalData('17').then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        newDocSeries = value.openOutwardData!;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
      notifyListeners();
    });
    notifyListeners();
  }

  String? newSeriesCode;
  String? newSeriesName;
  selectDocSeries(String val) {
    newSeriesCode = null;
    for (var i = 0; i < newDocSeries.length; i++) {
      if (newDocSeries[i].seriesName.toString() == newSeriesName) {
        newSeriesCode = newDocSeries[i].seriesCode!.toString();
      }
    }
  }

  selectDocSeries2(String val) {
    newSeriesCode = null;
    for (var i = 0; i < newDocSeries.length; i++) {
      if (newDocSeries[i].seriesCode.toString() == val) {
        newSeriesCode = newDocSeries[i].seriesCode!.toString();
        newSeriesName = newDocSeries[i].seriesName!.toString();
        warehousectrl[1].text = newDocSeries[i].seriesName!.toString();
      }
    }
  }

  getBrachDetails() async {
    final Database db = (await DBHelper.getInstance())!;
    whsLists = [];
    List<Map<String, Object?>> branchData = await DBOperation.getBranch(db);
    if (branchData.isNotEmpty) {
      for (int i = 0; i < branchData.length; i++) {
        whsLists.add(WhsDetails(
            whsName: branchData[i]['WhsName'].toString(),
            companyName: branchData[i]['CompanyName'].toString(),
            whsCode: branchData[i]['WhsCode'].toString(),
            gitWhs: branchData[i]['GITWhs'].toString(),
            whsmailID: branchData[i]['E_Mail'].toString(),
            whsPhoNo: '',
            whsGst: branchData[i]['GSTNo'].toString(),
            whsAddress: branchData[i]['Address1'].toString(),
            whsDistric: branchData[i]['DisAcct1'].toString(),
            pinCode: branchData[i]['Pincode'].toString(),
            whsState: branchData[i]['StateCode'].toString(),
            whsCity: branchData[i]['City'].toString()));
      }
      notifyListeners();
    }
    log('whsListswhsLists::${whsLists.length}');
    notifyListeners();
  }

  getLocation(BuildContext context) async {
    latitude = '';
    longitude = '';
    Position? position = await checkAndEnableLocation(context);
    if (position != null) {
      latitude = '${position.latitude}';
      longitude = '${position.longitude}';

      log("Sales order Latitude: $latitude, Longitude: $longitude");
      notifyListeners();
    } else {
      print("Location services are disabled or not available.");
    }
  }

  List<NewSeriesMdlData> newseries = [];
  callNewSeriesApi() async {
    newseries = [];
    await Newseriesapi.getGlobalData(
      '17',
    ).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          newseries = value.openOutwardData!;
          log('newseriesnewseries::${newseries[0].series.toString()}');
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
    notifyListeners();
  }

  String userTypes = '';

  callGetUserType() async {
    userTypes = '';
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> userData =
        await DBOperation.getusersvaldata(db, UserValues.username);
    if (userData.isNotEmpty) {
      log('usercodeusercode::${userData[0]['usercode'].toString().toLowerCase()}');

      userTypes = userData[0]['usertype'].toString().toLowerCase();
    }
    notifyListeners();
  }

  Future<Position?> checkAndEnableLocation(BuildContext context) async {
    try {
      final bool isEnabled = await _channel.invokeMethod('isLocationEnabled');
      if (!isEnabled) {
        checkAndPromptLocationService(context);
        notifyListeners();

        return null;
      }
      notifyListeners();

      return await getCurrentLatPosition();
    } on PlatformException catch (e) {
      log("Failed to check or enable location: '${e.message}'.");
      return null;
    }
  }

  Future<void> promptEnableLocation() async {
    try {
      await _channel.invokeMethod('openLocationSettings');
    } on PlatformException catch (e) {
      log("Failed to open location settings: '${e.message}'.");
    }
  }

  TextEditingController postingDatecontroller = TextEditingController();

  postingDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));
    if (pickedDate == null) {
      return;
    }
    String datetype = DateFormat('dd-MM-yyyy').format(pickedDate);
    postingDatecontroller.text = datetype;
  }

  List<LeadDateMdlData> leadDataList = [];
  callLeadDateApi(String itemCode) async {
    leadDataList = [];
    await NewLeadDateApi.getGlobalData('$itemCode').then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        leadDataList = value.leadDataList!;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  callLeadApiandDate(String itemcodee, BuildContext context, int i) async {
    await callLeadDateApi(itemcodee);
    await leadDatePicker2(context, i);
    notifyListeners();
  }

  leadDatePicker(
    BuildContext context,
    int i,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    String datetype2 = DateFormat('dd-MM-yyyy').format(pickedDate!);

    itemListDateCtrl[i].text = datetype2.toString();
  }

  // leadDatePickefr(
  //   BuildContext context,
  //   int i,
  // ) async {
  //   DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2100));
  //   if (pickedDate == null) {
  //     return;
  //   }
  //   // String datetype = DateFormat('yyyy-MM-dd').format(pickedDate);

  //   DateTime date1 = DateTime.parse(pickedDate.toString());

  //   log('leadDataList[0].leadDays::${leadDataList[0].leadDays!.toString()}');
  //   DateTime futureDate = date1
  //       .add(Duration(days: int.parse(leadDataList[0].leadDays!.toString())));

  //   log("date1 date: $date1");
  //   log("Date after 90 days: $futureDate");
  //   String datetype2 = DateFormat('dd-MM-yyyy').format(futureDate);

  //   itemListDateCtrl[i].text = datetype2.toString();
  // }

  leadDatePicker2(
    BuildContext context,
    int i,
  ) async {
    DateTime date1 = DateTime.parse(DateTime.now().toString());

    log('leadDataList[0].leadDays::${leadDataList[0].leadDays!.toString()}');
    DateTime futureDate = date1
        .add(Duration(days: int.parse(leadDataList[0].leadDays!.toString())));

    log("date1 date: $date1");
    log("Date after 90 days: $futureDate");
    String datetype2 = DateFormat('dd-MM-yyyy').format(futureDate);

    itemListDateCtrl[i].text = datetype2.toString();
  }

  void checkAndPromptLocationService(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enable location on your device '),
                SizedBox(
                  height: Screens.padingHeight(context) * 0.02,
                ),
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        await promptEnableLocation();
                        requestLocationPermission(context);
                      },
                      child: const Text('  OK  ')),
                )
              ],
            ),
          );
        });
  }

  static Future<Position> getCurrentLatPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  requestLocationPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      checkAndPromptLocationService(context);
    } else if (status.isPermanentlyDenied) {
      checkAndPromptLocationService(context);
    } else {
      getLocation(context);
    }
  }

  clearAll(BuildContext context, ThemeData theme) {
    filtersearchData = [];
    totalPayment2 = null;
    paymentWay2 = [];
    newseries = [];

    itemListDateCtrl = List.generate(200, (i) => TextEditingController());
    mycontroller = List.generate(500, (i) => TextEditingController());
    searchcontroller = TextEditingController();
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    postingDatecontroller.text = '';
    checkboxx = false;
    selectedcust = null;
    selectedcust2 = null;
    searchData.clear();
    custList.clear();
    filtercustList.clear();
    custList2.clear();
    selectedBillAdress = 0;
    getSearchedData = [];
    paymentWay.clear();
    itemData.clear();
    scanneditemData.clear();
    getfilterSearchedData = [];
    scanneditemData2.clear();
    latitude = '';
    longitude = '';
    mycontroller2 = List.generate(500, (i) => TextEditingController());
    mycontroller[99].clear();
    focusnode = List.generate(500, (i) => FocusNode());
    postingDatecontroller.text = config.alignDate(DateTime.now().toString());

    notifyListeners();
  }

  Future<List<ItemMasterModelDB>> getAllList(String data) async {
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;

    return getSearchedData;
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      getfilterSearchedData = getSearchedData
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemnameshort!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      getfilterSearchedData = getSearchedData;
      notifyListeners();
    }
  }

  Future<List<ItemMasterModelDB>?> getAllListItem(String data) async {
    if (data.isNotEmpty) {
      log('message111');
      final Database db = (await DBHelper.getInstance())!;
      getSearchedData = await DBOperation.getSearchedStockList(db, data);
      getfilterSearchedData = getSearchedData;

      return getSearchedData;
    } else {
      getSearchedData = [];
    }
    return null;
  }

  filterListItemSearched(String v) {
    if (v.isNotEmpty) {
      getfilterSearchedData = getSearchedData
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemnameshort!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      visibleItemList = false;
      getSearchedData = [];
      getfilterSearchedData = [];
      notifyListeners();
    }
  }

  singleitemsearch(BuildContext context, ThemeData theme, int indx) async {
    int res = checkhaveQty(indx, 0);
    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
      searchcon.clear();
    }
  }

  onselectFst(BuildContext context, ThemeData theme, int indx) async {
    Navigator.pop(context);

    int res = checkhaveQty(indx, 0);

    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
    }
    calCulateDocVal(context, theme);
  }

  onselectVisibleItem(BuildContext context, ThemeData theme, int indx) async {
    int res = checkhaveQty(indx, 0);

    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
    }

    calCulateDocVal(context, theme);
  }

  int checkhaveQty(int ind, int scanedQty) {
    int res = 0;
    res = 1;
    return res;
  }

  incrementQty(int indxs, String qty, BuildContext context, ThemeData theme) {
    qtychangemtd(indxs, qty, context, theme);
  }

  qtyEdited(int indx, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    if (double.parse(qtymycontroller[indx].text.toString()) == removeqty ||
        qtymycontroller[indx].text.isEmpty) {
      discountcontroller.removeAt(indx);

      itemListDateCtrl.removeAt(indx);
      qtymycontroller.removeAt(indx);
      scanneditemData.removeAt(indx);
      calCulateDocVal(context, theme);
      notifyListeners();
    } else {
      incrementQty(indx, '0', context, theme);
      notifyListeners();
    }

    notifyListeners();
  }

  priceChanged(
    int index,
    BuildContext context,
    ThemeData theme,
  ) async {
    scanneditemData[index].sellPrice =
        double.parse(pricemycontroller[index].text.toString());
    await calCulateDocVal(context, theme);
    notifyListeners();
  }

  discountChanged(
    int index,
    BuildContext context,
    ThemeData theme,
  ) async {
    scanneditemData[index].discountper =
        double.parse(discountcontroller[index].text.toString());
    await calCulateDocVal(context, theme);
    notifyListeners();
  }

  addSannedItem(
    int ind,
    BuildContext context,
    ThemeData theme,
  ) async {
    log('getfilterSearchedData[ind].uPackSize::${getfilterSearchedData[ind].uPackSize.toString()}');
    scanneditemData.add(StocksnapModelData(
        transID: 0,
        branch: '', //getfilterSearchedData[ind].,
        itemCode: getfilterSearchedData.isNotEmpty
            ? getfilterSearchedData[ind].itemcode
            : getfilterSearchedData[ind].itemnameshort,
        itemName: getfilterSearchedData[ind].itemnameshort,
        shipDate: '',
        serialBatch: getfilterSearchedData[ind].isserialBatch,
        openQty: getfilterSearchedData[ind].quantity,
        qty: 1,
        inDate: '',
        inType: '',
        mrp: double.parse(getfilterSearchedData[ind].mrpprice.toString()),
        sellPrice:
            double.parse(getfilterSearchedData[ind].sellprice.toString()),
        cost: 0,
        discount: 0,
        basic: 0,
        netvalue: 0,
        taxvalue: 0,
        maxdiscount: getfilterSearchedData[ind].maxdiscount.toString(),
        createdUserID: '',
        createdateTime: '',
        lastupdateIp: '',
        purchasedate: '',
        snapdatetime: '',
        specialprice: 0,
        updatedDatetime: '',
        updateduserid: '',
        discountper: 0,
        uPackSize: getfilterSearchedData[ind].uPackSize.isNotEmpty
            ? double.parse(getfilterSearchedData[ind].uPackSize)
            : null,
        uPackSizeuom: getfilterSearchedData[ind].uPackSizeuom,
        uSpecificGravity:
            double.parse(getfilterSearchedData[ind].uSpecificGravity),
        uTINSPERBOX: getfilterSearchedData[ind].uTINSPERBOX,
        liter: double.parse(getfilterSearchedData[ind].liter.toString()),
        weight: double.parse(getfilterSearchedData[ind].weight.toString())));

    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].transID = i;
      pricemycontroller[i].text = scanneditemData[i].sellPrice.toString();
      scanneditemData[i].discountper = 0.00;
      discountcontroller[i].text = scanneditemData[i].discountper.toString();
      if (selectedcust != null && selectedcust!.taxCode != null) {
        if (selectedcust!.taxCode == 'O1') {
          scanneditemData[i].taxRate = 18.0;
        } else {
          scanneditemData[i].taxRate = 0.0;
        }
        notifyListeners();
      } else {
        scanneditemData[i].taxRate = 0.0;
      }
      await callOnHandApi(scanneditemData[i].itemCode.toString(), i);
      log('scanneditemData[i].packsize::${scanneditemData[i].uPackSize.toString()}');
    }

    qtychangemtd(scanneditemData.length - 1, '1', context, theme);

    callLeadApiandDate(
        scanneditemData[scanneditemData.length - 1].itemCode.toString(),
        context,
        scanneditemData.length - 1);
    searchcon.clear();

    notifyListeners();
  }

  qtychangemtd(int ind, String qty, BuildContext context, ThemeData theme) {
    String added = (double.parse(qty) +
            double.parse(qtymycontroller[ind].text.isEmpty
                ? '0'
                : qtymycontroller[ind].text))
        .toString();
    qtymycontroller[ind].text = added;
    scanneditemData[ind].qty = double.parse(added);
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  Future<int> checkalreadyScanedd(int indx) async {
    int res = -1;
    for (int i = 0; i < scanneditemData.length; i++) {
      if (getfilterSearchedData[indx].itemcode == scanneditemData[i].itemCode) {
        res = i;
      }
    }
    return res;
  }

  removeEmptyList() {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtymycontroller[i].text.isEmpty) {
        scanneditemData.removeAt(i);
      }
    }
  }

  Future callgetSQValue(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    getsqdata = true;
    soData = [];
    soSalesmodl = [];
    List<StocksnapModelData> scannData = [];
    if (selectedcust != null) {
      List<Map<String, Object?>> getheaderData =
          await DBOperation.getSalesQuotationvalueDB(
              db, selectedcust!.cardCode.toString());
      soSalesmodl.clear();
      if (getheaderData.isNotEmpty) {
        loadingSqBtn = false;

        for (int ik = 0; ik < getheaderData.length; ik++) {
          if (selectedcust!.cardCode.toString() ==
              getheaderData[ik]['customercode'].toString()) {
            List<Map<String, Object?>> lineData =
                await DBOperation.getSalesQuotationLinevalueDB(
                    db, getheaderData[ik]['docentry'].toString());

            for (int i = 0; i < lineData.length; i++) {
              if (getheaderData[ik]['docentry'].toString() ==
                  lineData[i]['docentry'].toString()) {
                scannData.add(StocksnapModelData(
                    shipDate: '',
                    basedocentry: lineData[i]['docentry'].toString(),
                    sapbasedocentry:
                        int.parse(getheaderData[ik]['sapDocentry'].toString()),
                    baselineid: lineData[i]['lineID'].toString(),
                    basic: lineData[i]['basic'] != null
                        ? double.parse(lineData[i]['basic'].toString())
                        : 00,
                    netvalue: lineData[i]['netlinetotal'] != null
                        ? double.parse(lineData[i]['netlinetotal'].toString())
                        : null,
                    transID: int.parse(lineData[i]['docentry'].toString()),
                    branch: lineData[i]['branch'].toString(),
                    itemCode: lineData[i]['itemcode'].toString(),
                    itemName: lineData[i]['itemname'].toString(),
                    serialBatch: lineData[i]['serialbatch'].toString(),
                    openQty: double.parse(lineData[i]['quantity'].toString()),
                    qty: lineData[i]['Balanceqty'] != null
                        ? double.parse(lineData[i]['Balanceqty'].toString())
                        : double.parse(lineData[i]['quantity'].toString()),
                    inDate: lineData[i][''].toString(),
                    inType: lineData[i][''].toString(),
                    mrp: 0,
                    sellPrice: double.parse(lineData[i]['price'].toString()),
                    cost: 0,
                    discount: lineData[i]['discperunit'] != null
                        ? double.parse(lineData[i]['discperunit'].toString())
                        : 00,
                    taxvalue: lineData[i]['taxtotal'] != null
                        ? double.parse(lineData[i]['taxtotal'].toString())
                        : 00,
                    taxRate: double.parse(lineData[i]['taxrate'].toString()),
                    maxdiscount: lineData[i]['maxdiscount'].toString(),
                    discountper: lineData[i]['discperc'] == null
                        ? 0.0
                        : double.parse(lineData[i]['discperc'].toString()),
                    createdUserID: '',
                    createdateTime: lineData[i]['createdateTime'].toString(),
                    lastupdateIp: '',
                    purchasedate: '',
                    snapdatetime: '',
                    specialprice: 0,
                    updatedDatetime: '',
                    updateduserid: '',
                    liter: lineData[i]['liter'] == null
                        ? 0.0
                        : double.parse(lineData[i]['liter'].toString()),
                    weight: lineData[i]['weight'] == null
                        ? 0.0
                        : double.parse(lineData[i]['weight'].toString())));

                sapBaseDocEntry =
                    int.parse(getheaderData[ik]['sapDocentry'].toString());
              }
            }
            SalesModel salesM = SalesModel(
              objname: getheaderData[ik]['objname'].toString(),
              taxCode: getheaderData[ik]['taxCode'].toString(),
              objtype: getheaderData[ik]['objtype'].toString(),
              doctype: getheaderData[ik]['doctype'].toString(),
              docentry: int.parse(getheaderData[ik]['docentry'].toString()),
              custName: getheaderData[ik]['customername'].toString(),
              phNo: getheaderData[ik]['customerphono'].toString(),
              cardCode: getheaderData[ik]['customercode'].toString(),
              accBalance: getheaderData[ik]['customeraccbal'].toString(),
              point: getheaderData[ik]['customerpoint'].toString(),
              tarNo: getheaderData[ik]['taxno'].toString(),
              email: getheaderData[ik]['customeremail'].toString(),
              sapInvoiceNum: getheaderData[ik]['sapDocNo'].toString(),
              invoceAmount:
                  double.parse(getheaderData[ik]['doctotal'].toString()),
              invoceDate: config
                  .alignDate(getheaderData[ik]['createdateTime'].toString()),
              invoiceNum: getheaderData[ik]['documentno'].toString(),
              invoiceClr: 0,
              checkBClr: false,
              address: [
                Address(
                    address1: getheaderData[ik]['billaddressid'].toString(),
                    billCity: getheaderData[ik]['city'].toString(),
                    billCountry: getheaderData[ik]['country'].toString(),
                    billPincode: getheaderData[ik]['pinno'].toString(),
                    billstate: getheaderData[ik]['state'].toString())
              ],
              totalPayment: TotalPayment(
                discount2: getheaderData[ik]['docdiscamt'] == null
                    ? 0.00
                    : double.parse(getheaderData[ik]['docdiscamt'].toString()),
                discount: getheaderData[ik]['docdiscamt'] == null
                    ? 0.00
                    : double.parse(getheaderData[ik]['docdiscamt'].toString()),
                totalTX: double.parse(getheaderData[ik]['taxamount'] == null
                    ? '0'
                    : getheaderData[ik]['taxamount']
                        .toString()
                        .replaceAll(',', '')),

                subtotal: double.parse(getheaderData[ik]['docbasic'] == null
                    ? '0'
                    : getheaderData[ik]['docbasic']
                        .toString()
                        .replaceAll(',', '')), //doctotal

                total: totalPayment == null
                    ? 0
                    : double.parse(totalPayment!.total!.toString()),
                totalDue: double.parse(getheaderData[ik]['doctotal'] == null
                    ? '0'
                    : getheaderData[ik]['doctotal']
                        .toString()
                        .replaceAll(',', '')),
                totpaid: double.parse(getheaderData[ik]['amtpaid'] == null
                    ? '0'
                    : getheaderData[ik]['amtpaid']
                        .toString()
                        .replaceAll(',', '')),
              ),
              item: scannData,
            );
            getsqdata = false;

            soSalesmodl.add(salesM);

            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    cancelbtn = false;
  }

  itemDeSelect(int i) {
    if (soSalesmodl[i].invoiceClr == 0 && soSalesmodl[i].checkBClr == false) {
      soSalesmodl[i].invoiceClr = 1;
      soSalesmodl[i].checkBClr = true;

      notifyListeners();
    } else if (soSalesmodl[i].invoiceClr == 1 &&
        soSalesmodl[i].checkBClr == true) {
      soSalesmodl[i].invoiceClr = 0;
      soSalesmodl[i].checkBClr = false;
      notifyListeners();
    }

    notifyListeners();
  }

  openQuotItemDeSelect(int i) {
    if (openSalesQuot[i].invoiceClr == 0 &&
        openSalesQuot[i].checkBClr == false) {
      openSalesQuot[i].invoiceClr = 1;
      openSalesQuot[i].checkBClr = true;

      notifyListeners();
    } else if (openSalesQuot[i].invoiceClr == 1 &&
        openSalesQuot[i].checkBClr == true) {
      openSalesQuot[i].invoiceClr = 0;
      openSalesQuot[i].checkBClr = false;
      notifyListeners();
    }
  }

  salesQuodata() {
    soData.clear();
    loadingSqBtn = false;
    for (int ih = 0; ih < soSalesmodl.length; ih++) {
      if (soSalesmodl[ih].invoiceClr == 1 &&
          soSalesmodl[ih].checkBClr == true) {
        for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
          if (soSalesmodl[ih].item![ik].basedocentry.toString() ==
              soSalesmodl[ih].docentry.toString()) {
            if (soSalesmodl[ih].item![ik].qty != 0) {
              soData.add(StocksnapModelData(
                shipDate: '',
                docentry: soSalesmodl[ih].docentry.toString(),
                basedocentry: soSalesmodl[ih].item![ik].basedocentry,
                baselineid: soSalesmodl[ih].item![ik].baselineid,
                branch: soSalesmodl[ih].item![ik].branch,
                itemCode: soSalesmodl[ih].item![ik].itemCode,
                itemName: soSalesmodl[ih].item![ik].itemName,
                serialBatch: '',
                qty: soSalesmodl[ih].item![ik].qty,
                mrp: double.parse(soSalesmodl[ih].item![ik].mrp.toString()),
                createdUserID:
                    soSalesmodl[ih].item![ik].createdUserID.toString(),
                createdateTime: config.alignDate(
                    soSalesmodl[ih].item![ik].createdateTime.toString()),
                lastupdateIp: soSalesmodl[ih].item![ik].lastupdateIp,
                purchasedate: soSalesmodl[ih].item![ik].purchasedate,
                snapdatetime: soSalesmodl[ih].item![ik].snapdatetime,
                sapbasedocentry: soSalesmodl[ih].item![ik].sapbasedocentry,
                specialprice: double.parse(
                    soSalesmodl[ih].item![ik].specialprice.toString()),
                updatedDatetime: soSalesmodl[ih].item![ik].updatedDatetime,
                updateduserid:
                    soSalesmodl[ih].item![ik].updateduserid.toString(),
                sellPrice: double.parse(
                    soSalesmodl[ih].item![ik].sellPrice.toString()),
                maxdiscount: soSalesmodl[ih].item![ik].maxdiscount != null
                    ? soSalesmodl[ih].item![ik].maxdiscount.toString()
                    : '',
                taxRate: soSalesmodl[ih].item![ik].taxRate != null
                    ? double.parse(soSalesmodl[ih].item![ik].taxRate.toString())
                    : 0.0,
                discountper: double.parse(
                    soSalesmodl[ih].item![ik].discountper!.toString()),
                openQty: soSalesmodl[ih].item![ik].qty,
                inDate: '',
                cost: 0,
                inType: '',
                liter: soSalesmodl[ih].item![ik].liter != null
                    ? double.parse(soSalesmodl[ih].item![ik].liter.toString())
                    : 0.0,
                weight: soSalesmodl[ih].item![ik].weight != null
                    ? double.parse(soSalesmodl[ih].item![ik].weight.toString())
                    : 0.0,
              ));
              notifyListeners();
            }
          }
        }

        notifyListeners();
      }
      notifyListeners();
    }
  }

  doubleDotMethodsoqty(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    soqtycontroller[i].text = modifiedString2.toString();
    log(soqtycontroller[i].text);
    notifyListeners();
  }

  doubleDotMethodPayTerms(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    mycontroller[i].text = modifiedString2.toString();
    log(mycontroller[i].text);
    notifyListeners();
  }

  doubleDotMethod(int i, String val, String type) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");
    if (type == 'Qty') {
      qtymycontroller[i].text = modifiedString2.toString();
      log(qtymycontroller[i].text);
    } else if (type == 'Price') {
      pricemycontroller[i].text = modifiedString2.toString();
    } else if (type == 'Discount') {
      discountcontroller[i].text = modifiedString2.toString();
    }

    notifyListeners();
  }

  soqtychangealertbc(int ikn, BuildContext context, ThemeData theme) {
    if (soqtycontroller[ikn].text.isNotEmpty) {
      double sqqtyyy = double.parse(soqtycontroller[ikn].text.toString());
      if (openQuotLineList![ikn].openQty >= sqqtyyy) {
        soqtycontroller[ikn].text = sqqtyyy.toString();
        notifyListeners();
      } else {
        notifyListeners();

        soqtycontroller[ikn].text = '1';
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
                      content: 'No more qty to add..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }
    notifyListeners();
  }

  clearsQaqty() {
    soqtycontroller = List.generate(500, (ij) => TextEditingController());
  }

  bool cpyfrmsq = false;
  sqQtyEdited(int ind, BuildContext context, ThemeData theme) {
    for (int kn = 0; kn < openQuotLineList!.length; kn++) {
      if (openQuotLineList![kn].docEntry.toString() ==
              scanneditemData[ind].basedocentry.toString() &&
          openQuotLineList![kn].itemCode.toString() ==
              scanneditemData[ind].itemCode.toString()) {
        if (openQuotLineList![kn].openQty >=
            double.parse(qtymycontroller[ind].text.toString())) {
          calCulateDocVal(context, theme);
          notifyListeners();
        } else {
          qtymycontroller[ind].text = scanneditemData[ind].qty.toString();
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
                        content: 'No more qty to add!!..',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
        notifyListeners();
      }
    }
  }

  mapSQData(
    BuildContext context,
    ThemeData theme,
  ) async {
    double? totqty;
    mycontroller[50].text = "";

    totalPayment = null;

    scanneditemData = [];
    cpyfrmsq = true;

    for (var i = 0; i < openQuotLineList!.length; i++) {
      totqty = soqtycontroller[i].text.isEmpty
          ? 0
          : double.parse(soqtycontroller[i].text);
      if (totqty > 0 && openQuotLineList![i].openQty >= totqty) {
        scanneditemData.add(StocksnapModelData(
          docentry: openQuotLineList![i].docEntry.toString(),
          basedocentry: openQuotLineList![i].docEntry.toString(),
          shipDate: '',
          uPackSize: openQuotLineList![i].uPackSize != null ||
                  openQuotLineList![i].uPackSize != 0
              ? openQuotLineList![i].uPackSize!
              : null,
          baselineid: openQuotLineList![i].lineNum.toString(),
          branch: AppConstant.branch,
          itemCode: openQuotLineList![i].itemCode.toString(),
          itemName: openQuotLineList![i].description.toString(),
          sapbasedocentry: int.parse(openQuotLineList![i].docEntry.toString()),
          serialBatch: '',
          qty: totqty,
          mrp: 0,
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          sellPrice: openQuotLineList![i].price,
          maxdiscount: '',
          discountper: openQuotLineList![i].discPrcnt,
          openQty: totqty,
          inDate: '',
          cost: 0,
          inType: '',
          liter: 0.0,
          weight: 0.0,
        ));
      }
    }

    log('scanneditemDatascanneditemData111::${scanneditemData.length}');
    for (int il = 0; il < scanneditemData.length; il++) {
      log('scanneditemDatascanneditemData::${scanneditemData[il].baselineid}');

      discountcontroller[il].text = scanneditemData[il].discountper.toString();
      pricemycontroller[il].text = scanneditemData[il].sellPrice.toString();
      scanneditemData[il].transID = il;
      qtymycontroller[il].text = scanneditemData[il].qty.toString();
      if (selectedcust != null && selectedcust!.taxCode != null) {
        if (selectedcust!.taxCode == 'O1') {
          scanneditemData[il].taxRate = 18.0;
        } else {
          scanneditemData[il].taxRate = 0.0;
        }
        notifyListeners();
      } else {
        scanneditemData[il].taxRate = 0.0;
      }
      await callOnHandApi(scanneditemData[il].itemCode.toString(), il);
      await callLeadApiandDate(
          scanneditemData[il].itemCode.toString(), context, il);
    }

    notifyListeners();
    await calCulateDocVal(context, theme);
    Get.back();
    notifyListeners();
  }

  calculatescheme(BuildContext context, ThemeData theme) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      discountcontroller[i].text = 0.0.toString();
      scanneditemData[i].discountper = 0.0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData.length; i++) {
      for (int ik = 0; ik < resSchemeDataList.length; ik++) {
        if (resSchemeDataList[ik].lineNum == scanneditemData[i].transID) {
          scanneditemData[i].discountper =
              scanneditemData[i].discountper! + resSchemeDataList[ik].discPer;
          discountcontroller[i].text =
              scanneditemData[i].discountper!.toString();

          notifyListeners();
        }
      }
    }
    await calCulateDocVal(context, theme);
    notifyListeners();
  }

  callSchemeOrderAPi() async {
    catchmsg = [];
    resSchemeDataList = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].discountper = 0.0;
      discountcontroller[i].text = 0.0.toString();

      notifyListeners();
    }
    await SchemeOrderAPi.getGlobalData(schemeData).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        resSchemeDataList = [];

        if (value.saleOrder != null) {
          for (int i = 0; i < value.saleOrder!.length; i++) {
            resSchemeDataList.add(SchemeOrderModalData(
                docEntry: value.saleOrder![i].docEntry,
                schemeEntry: value.saleOrder![i].schemeEntry,
                lineNum: value.saleOrder![i].lineNum,
                discPer: value.saleOrder![i].discPer,
                discVal: value.saleOrder![i].discVal));
            notifyListeners();
          }

          notifyListeners();
        } else if (value.saleOrder == null) {
          catchmsg.add("Stock details2: ${value.message!}");
          notifyListeners();
        }
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        catchmsg.add("Stock details3: ${value.exception!}");
      } else {
        catchmsg.add("Stcok details4: ${value.exception!}");
      }
    });
    notifyListeners();
  }

  List<OnHandModelsData> onhandData = [];
  callOnHandApi(String itemCode, int index) async {
    onhandData = [];
    notifyListeners();

    await OnhandApi.getGlobalData('$itemCode', '${AppConstant.branch}')
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.onHandData != null || value.onHandData!.isNotEmpty) {
          for (int i = 0; i < value.onHandData!.length; i++) {
            onhandData.add(OnHandModelsData(
                onHand: value.onHandData![i].onHand,
                itemCode: value.onHandData![i].itemCode,
                whsCode: value.onHandData![i].whsCode));
            notifyListeners();
          }

          for (var ik = 0; ik < onhandData.length; ik++) {
            if (scanneditemData[index].itemCode.toString() ==
                onhandData[ik].itemCode.toString()) {
              scanneditemData[index].inStockQty =
                  double.parse(onhandData[ik].onHand.toString());
            }
          }
          notifyListeners();
        } else if (value.onHandData == null) {
          catchmsg.add("Stock details2: ${value.message!}");
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        catchmsg.add("Stock details3: ${value.error!}");
      } else {
        catchmsg.add("Stcok details4: ${value.error!}");
      }
    });
    notifyListeners();
  }

  salesOrderSchemeData() async {
    schemeData = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      schemeData.add(SalesOrderScheme(
        itemCode: scanneditemData[i].itemCode.toString(),
        priceBefDi: scanneditemData[i].sellPrice.toString(),
        quantity: qtymycontroller[i].text,
        uCartons: 0.toString(),
        lineno: i.toString(),
        balance: selectedcust!.accBalance.toString(),
        customer: selectedcust!.cardCode.toString(),
        warehouse: AppConstant.branch,
      ));
      notifyListeners();
    }

    notifyListeners();
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;
    List<HoldedHeader> holdData = [];
    fileterHoldData = [];
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesOrderHeadHoldvalueDB(db);
    for (int i = 0; i < getholddata.length; i++) {
      holdData.add(HoldedHeader(
          cardName: getholddata[i]['customername'].toString(),
          tinNo: getholddata[i]['TinNo'].toString(),
          vatNo: getholddata[i]['VatNo'].toString(),
          cardcode: getholddata[i]['customercode'].toString(),
          docEntry: int.parse(getholddata[i]['docentry'].toString()),
          branch: getholddata[i]['branch'].toString(),
          docNo: getholddata[i]['documentno'].toString(),
          date: getholddata[i]['createdateTime'].toString(),
          seresid: getholddata[i]['seresid'].toString()));

      notifyListeners();
    }
    fileterHoldData = holdData;
    notifyListeners();
  }

  mapHoldSelectedValues(
    HoldedHeader holddata,
    BuildContext context,
    ThemeData theme,
  ) async {
    holddocentry = '';
    scanneditemData = [];
    loadingscrn = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>>? getDBholdSalesLine =
        await DBOperation.getSalesOrderLineDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getdSalesOrderPayDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, holddata.cardcode.toString());

    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, holddata.cardcode.toString());

    selectedWhsCode2(holddata.branch!);
    selectDocSeries2(holddata.seresid!);

    await mapCustomer(
      getcustomer,
      holddata,
      getcustaddd,
    );
    await mapProdcut(getDBholdSalesLine, context, theme);

    await mapPayment(getDBholdSalespay);
    await getCustDetFDB();
    holddocentry = holddata.docEntry.toString();
    calCulateDocVal(context, theme);

    notifyListeners();
  }

  mapCustomer(List<Map<String, Object?>> custData, HoldedHeader holddata,
      List<Map<String, Object?>> getcustaddd) async {
    final Database db = (await DBHelper.getInstance())!;

    selectedcust = null;
    selectedcust55 = null;
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesOrderHeadHoldvalueDB(db);
    tinNoController.text = holddata.tinNo.toString();
    vatNoController.text = holddata.vatNo.toString();

    selectedcust = CustomerDetals(
      name: holddata.cardName,
      taxCode: custData[0]['taxCode'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      U_CashCust: custData[0]['U_CASHCUST'].toString(),
      cardCode: custData[0]['customerCode'].toString(),
      accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
    );

    for (int ik = 0; ik < getholddata.length; ik++) {
      remarkcontroller3.text = getholddata[ik]['remarks'].toString();
      for (int i = 0; i < getcustaddd.length; i++) {
        if (getholddata[ik]['billaddressid'].toString() != null ||
            getholddata[ik]['billaddressid'].toString().isNotEmpty) {
          if (getholddata[ik]['billaddressid'].toString() ==
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
          }
        }

        if (getholddata[ik]['shipaddresid'].toString().isNotEmpty) {
          if (getholddata[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            selectedcust55 = CustomerDetals(
              name: custData[0]['customername'].toString(),
              taxCode: custData[0]['taxCode'].toString(),
              phNo: custData[0]['phoneno1'].toString(),
              U_CashCust: custData[0]['U_CASHCUST'].toString(),
              cardCode: custData[0]['customerCode'].toString(),
              accBalance: double.parse(custData[0]['balance'].toString()),
              point: custData[0]['points'].toString(),
              address: [],
              email: custData[0]['emalid'].toString(),
              tarNo: custData[0]['taxno'].toString(),
            );
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
          }
        }
      }
    }

    await CustCreditLimitAPi.getGlobalData(holddata.cardcode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditLimitData != null) {
          selectedcust!.creditLimits =
              double.parse(value.creditLimitData![0].creditLine.toString());
          notifyListeners();
        }
      }
    });

    await CustCreditDaysAPI.getGlobalData(holddata.cardcode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditDaysData != null) {
          selectedcust!.creditDays =
              value.creditDaysData![0].creditDays.toString();
          selectedcust!.paymentGroup =
              value.creditDaysData![0].paymentGroup.toString().toLowerCase();
          log('selectedcust paymentGroup::${selectedcust!.U_CashCust!}');
          if (selectedcust!.U_CashCust == 'YES') {
            if (holddata.cardName!.isNotEmpty) {
              custNameController.text = holddata.cardName!;
            }
          }

          notifyListeners();
        }
        loadingscrn = false;
      }
    });
    notifyListeners();

    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        selectedcust!.accBalance =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    notifyListeners();
  }

  mapProdcut(List<Map<String, Object?>> lineData, BuildContext context,
      ThemeData theme) {
    scanneditemData = [];
    for (int i = 0; i < lineData.length; i++) {
      scanneditemData.add(StocksnapModelData(
          shipDate: lineData[i]['ShipDate'].toString(),
          basic: lineData[i]['basic'] != null
              ? double.parse(lineData[i]['basic'].toString())
              : 00,
          netvalue: lineData[i]['netlinetotal'] != null
              ? double.parse(lineData[i]['netlinetotal'].toString())
              : null,
          docentry: lineData[i]['docentry'].toString(),
          basedocentry: lineData[i]['basedocentry'].toString(),
          baselineid: lineData[i]['baselineID'].toString(),
          branch: lineData[i]['branch'].toString(),
          itemCode: lineData[i]['itemcode'].toString(),
          itemName: lineData[i]['itemname'].toString(),
          serialBatch: lineData[i]['serialbatch'].toString(),
          openQty: double.parse(lineData[i]['quantity'].toString()),
          qty: double.parse(lineData[i]['quantity'].toString()),
          inDate: lineData[i][''].toString(),
          inType: lineData[i][''].toString(),
          mrp: 0,
          sellPrice: double.parse(lineData[i]['price'].toString()),
          cost: 0,
          discount: lineData[i]['discperunit'] != null
              ? double.parse(lineData[i]['discperunit'].toString())
              : 00,
          taxvalue: lineData[i]['taxtotal'] != null
              ? double.parse(lineData[i]['taxtotal'].toString())
              : 00,
          taxRate: double.parse(lineData[i]['taxrate'].toString()),
          maxdiscount: lineData[i]['maxdiscount'].toString(),
          discountper: lineData[i]['discperc'] == null
              ? 0.0
              : double.parse(lineData[i]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: lineData[i]['liter'] == null
              ? 0.0
              : double.parse(lineData[i]['liter'].toString()),
          weight: lineData[i]['weight'] == null
              ? 0.0
              : double.parse(lineData[i]['weight'].toString()),
          uPackSize: lineData[i]['U_Pack_Size'] != null
              ? double.parse(lineData[i]['U_Pack_Size'].toString())
              : 0,
          uPackSizeuom: lineData[i]['U_Pack_Size_uom'] != null
              ? lineData[i]['U_Pack_Size_uom'].toString()
              : '',
          uSpecificGravity: lineData[i]['U_Specific_Gravity'] != null
              ? double.parse(lineData[i]['U_Specific_Gravity'].toString())
              : 0,
          uTINSPERBOX: lineData[i]['U_TINS_PER_BOX'] != null
              ? int.parse(
                  lineData[i]['U_TINS_PER_BOX'].toString(),
                )
              : 0));
    }
    notifyListeners();

    for (int ig = 0; ig < scanneditemData.length; ig++) {
      scanneditemData[ig].transID = ig;
      pricemycontroller[ig].text = scanneditemData[ig].sellPrice.toString();
      discountcontroller[ig].text = scanneditemData[ig].discountper!.toString();
      qtymycontroller[ig].text = scanneditemData[ig].openQty!.toString();

      itemListDateCtrl[ig].text = scanneditemData[ig].shipDate!.toString();
      notifyListeners();
      callOnHandApi(scanneditemData[ig].itemCode!, ig);
    }
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  mapPayment(List<Map<String, Object?>> payment) {
    paymentWay.clear();
    for (int i = 0; i < payment.length; i++) {
      paymentWay.add(PaymentWay(
        amt: double.parse(payment[i]['rcamount'].toString()),
        type: payment[i]['rcmode'].toString(),
        dateTime: payment[i]['createdateTime'].toString(),
        reference: payment[i]['reference'] != null
            ? payment[i]['reference'].toString()
            : '',
        cardApprno: payment[i]['cardApprno'] != null
            ? payment[i]['cardApprno'].toString()
            : '',
        cardref: payment[i]['cardref'].toString(),
        cardterminal: payment[i]['cardterminal'].toString(),
        chequedate: payment[i]['chequedate'].toString(),
        chequeno: payment[i]['chequeno'].toString(),
        couponcode: "",
        coupontype: "",
        discountcode: payment[i]['discountcode'].toString(),
        discounttype: payment[i]['discounttype'].toString(),
        recoverydate: payment[i]['recoverydate'].toString(),
        redeempoint: payment[i]['redeempoint'].toString(),
        availablept: payment[i]['availablept'].toString(),
        remarks: payment[i]['remarks'].toString(),
        transtype: payment[i]['transtype'].toString(),
        walletid: payment[i]['walletid'].toString(),
        wallettype: payment[i]['wallettype'].toString(),
      ));
      notifyListeners();
    }
    notifyListeners();
  }

  double totalLiter() {
    double total = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].liter != null) {
          total = total +
              (scanneditemData[i].liter! *
                  double.parse(scanneditemData[i].qty.toString()));
        }
      }
      return total;
    }
    return 0.00;
  }

  double totalLiter2() {
    double total = 0.0;
    if (scanneditemData2.isNotEmpty) {
      for (int i = 0; i < scanneditemData2.length; i++) {
        if (scanneditemData2[i].liter != null) {
          total = total +
              (scanneditemData2[i].liter! *
                  double.parse(scanneditemData2[i].qty.toString()));
        }
      }
      return total;
    }
    return 0.00;
  }

  double totalWeight() {
    double totalWeight = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].weight != null) {
          totalWeight = totalWeight +
              (scanneditemData[i].weight! *
                  double.parse(scanneditemData[i].qty.toString()));
        }
      }
      return totalWeight;
    }
    return 0.00;
  }

  double totalWeight2() {
    double totalWeight = 0.0;
    if (scanneditemData2.isNotEmpty) {
      for (int i = 0; i < scanneditemData2.length; i++) {
        totalWeight = totalWeight +
            (scanneditemData2[i].weight! *
                double.parse(scanneditemData2[i].qty.toString()));
      }

      return totalWeight;
    }
    return 0.00;
  }

  injectToDb() async {
    final Database db = (await DBHelper.getInstance())!;
    await getItemFromDB(db);
    notifyListeners();
  }

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchHeader
          .where((e) =>
              e.cardName.toLowerCase().contains(v.toLowerCase()) ||
              e.cardCode.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchHeader;
      notifyListeners();
    }
  }

  filterAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterAprvlData = searchAprvlData
          .where((e) =>
              e.cardName!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterAprvlData = searchAprvlData;
      notifyListeners();
    }
  }

  filterPendingAprvlBoxList(String v) {
    if (v.isNotEmpty) {
      filterPendingApprovalData = pendingApprovalData
          .where((e) =>
              e.cardName!.toLowerCase().contains(v.toLowerCase()) ||
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
              e.cardName!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterRejectedData = rejectedData;
      notifyListeners();
    }
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

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  searchAprvlMethod() {
    mycontroller[102].text = config.alignDate(config.currentDate());
    mycontroller[103].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  callAprvllDataDatewise(String fromdate, String todate) async {
    searchAprvlData = [];
    filterAprvlData = [];
    searchbool = true;
    GetDyApprovalAPi.slpCode = AppConstant.slpCode;
    GetDyApprovalAPi.dbname = "${AppConstant.sapDB}";
    await GetDyApprovalAPi.getGlobalData(fromdate, todate).then(
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

  mapApprovalData(BuildContext context, ThemeData theme) async {
    selectedcust2 = null;
    selectedcust25 = null;
    scanneditemData2 = [];
    scanneditemData = [];
    paymentWay2 = [];
    totalPayment2 = null;
    final Database db = (await DBHelper.getInstance())!;
    double totalQuantity = 0;

    List<Map<String, Object?>> getsoheader = await DBOperation.getSoApprovalsts(
        db, approvalDetailsValuess!.uDevicTransId.toString());
    if (approvalDetailsValuess != null && getsoheader.isNotEmpty) {
      //
      List<Map<String, Object?>> getsoHeaderData =
          await DBOperation.getDocEntrySalesOrderHeaderDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));

      tbDocEntry = int.parse(getsoheader[0]['docentry'].toString());
      List<Map<String, Object?>> getsoLineData =
          await DBOperation.getSalesOrderLineDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));

      List<Map<String, Object?>> getDBSalespay =
          await DBOperation.getdSalesOrderPayDB(
              db, int.parse(getsoheader[0]['docentry'].toString()));
      List<Map<String, Object?>> newcusdataDB =
          await DBOperation.getCstmMasDatabyautoid(
              db, approvalDetailsValuess!.cardCode.toString());
      mycontroller2[50].text = getsoHeaderData[0]['remarks'] != null
          ? getsoHeaderData[0]['remarks'].toString()
          : "";

      List<Address>? address2 = [];
      List<Address>? address25 = [];
      List<CustomerAddressModelDB> csadresdataDB =
          await DBOperation.getCstmMasAddDBCardCode(
              db, approvalDetailsValuess!.cardCode.toString());
      for (int k = 0; k < csadresdataDB.length; k++) {
        if (csadresdataDB[k].custcode.toString() ==
            approvalDetailsValuess!.cardCode.toString()) {
          if (csadresdataDB[k].autoid.toString() ==
              getsoheader[0]['billaddressid'].toString()) {
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
            docentry: approvalDetailsValuess!.docEntry.toString(),
            taxCode: newcusdataDB[ij]['taxCode'].toString(),
            autoId: newcusdataDB[ij]['autoid'].toString(),
            cardCode: newcusdataDB[ij]['customerCode'].toString(),
            name: newcusdataDB[ij]['customername'].toString(),
            U_CashCust: newcusdataDB[ij]['U_CASHCUST'].toString(),
            phNo: newcusdataDB[ij]['phoneno1'].toString(),
            accBalance: double.parse(newcusdataDB[ij]['balance'].toString()),
            point: newcusdataDB[ij]['points'].toString(),
            tarNo: newcusdataDB[ij]['taxno'].toString(),
            email: newcusdataDB[ij]['emalid'].toString(),
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: address2);
        notifyListeners();
        selectedcust25 = CustomerDetals(
            docentry: approvalDetailsValuess!.docEntry.toString(),
            autoId: newcusdataDB[ij]['autoid'].toString(),
            taxCode: newcusdataDB[ij]['taxCode'].toString(),
            cardCode: newcusdataDB[ij]['customerCode'].toString(),
            U_CashCust: newcusdataDB[ij]['U_CASHCUST'].toString(),
            name: newcusdataDB[ij]['customername'].toString(),
            phNo: newcusdataDB[ij]['phoneno1'].toString(),
            accBalance: double.parse(newcusdataDB[ij]['balance'].toString()),
            point: newcusdataDB[ij]['points'].toString(),
            tarNo: newcusdataDB[ij]['taxno'].toString(),
            email: newcusdataDB[ij]['emalid'].toString(),
            invoicenum: '',
            invoiceDate: '',
            totalPayment: 00,
            address: address25);
        notifyListeners();
      }

      for (int kk = 0; kk < getDBSalespay.length; kk++) {
        if (getDBSalespay[0]['docentry'] == getDBSalespay[kk]['docentry']) {
          if (getDBSalespay[kk]['rcmode'].toString() == 'Cash') {
            cashType = 'Cash';
            cashpayment =
                double.parse(getDBSalespay[kk]['rcamount'].toString());
          }
          if (getDBSalespay[kk]['rcmode'].toString() == 'Cheque') {
            chequeType = 'Cheque';
            chqnum = int.parse(getDBSalespay[kk]['chequeno'].toString());
            cqpayment = double.parse(getDBSalespay[kk]['rcamount'].toString());
            remarkcontroller3.text = getDBSalespay[kk]['remarks'].toString();
          }
          if (getDBSalespay[kk]['rcmode'].toString() == 'Transfer') {
            transferType = 'Transfer';
            transpayment =
                double.parse(getDBSalespay[kk]['rcamount'].toString());
            transrefff = getDBSalespay[kk]['reference'] != null
                ? getDBSalespay[kk]['reference'].toString()
                : '';
          }
          if (getDBSalespay[kk]['rcmode'].toString() == 'Card') {
            cardType = 'Card';
          }
          if (getDBSalespay[kk]['rcmode'].toString() == 'Wallet') {
            walletType = 'Wallet';
          }
          paymentWay2.add(PaymentWay(
            amt: double.parse(getDBSalespay[kk]['rcamount'].toString()),
            type: getDBSalespay[kk]['rcmode'].toString(),
            dateTime: getDBSalespay[kk]['createdateTime'].toString(),
            reference: getDBSalespay[kk]['reference'] != null
                ? getDBSalespay[kk]['reference'].toString()
                : '',
            cardApprno: getDBSalespay[kk]['cardApprno'] != null
                ? getDBSalespay[kk]['cardApprno'].toString()
                : '',
            cardref: getDBSalespay[kk]['cardref'].toString(),
            cardterminal: getDBSalespay[kk]['cardterminal'].toString(),
            chequedate: getDBSalespay[kk]['chequedate'].toString(),
            chequeno: getDBSalespay[kk]['chequeno'].toString(),
            couponcode: "",
            coupontype: "",
            discountcode: getDBSalespay[kk]['discountcode'].toString(),
            discounttype: getDBSalespay[kk]['discounttype'].toString(),
            recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
            redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
            availablept: getDBSalespay[kk]['availablept'].toString(),
            remarks: getDBSalespay[kk]['remarks'].toString(),
            transtype: getDBSalespay[kk]['transtype'].toString(),
            walletid: getDBSalespay[kk]['walletid'].toString(),
            wallettype: getDBSalespay[kk]['wallettype'].toString(),
          ));

          notifyListeners();
        }
        notifyListeners();
      }

      for (int i = 0; i < getsoLineData.length; i++) {
        scanneditemData2.add(StocksnapModelData(
          shipDate: '',
          basedocentry: getsoLineData[i]['basedocentry'].toString(),
          baselineid: getsoLineData[i]['baselineID'].toString(),
          baseType: int.parse(getsoLineData[i]['baseType'].toString()),
          discountper: double.parse(getsoLineData[i]['discperc'].toString()),
          maxdiscount: getsoLineData[i]['maxdiscount'].toString(),
          branch: getsoLineData[i]['branch'].toString(),
          itemCode: getsoLineData[i]['itemcode'].toString(),
          itemName: getsoLineData[i]['itemname'].toString(),
          serialBatch: '',
          qty: double.parse(getsoLineData[i]['quantity'].toString()),
          mrp: double.parse(
            getsoLineData[i]['price'].toString(),
          ),
          sellPrice: double.parse(getsoLineData[i]['price'].toString()),
          taxRate: double.parse(getsoLineData[i]['taxrate'].toString()),
          weight: double.parse(getsoheader[0]['totalweight'].toString()),
          liter: double.parse(getsoheader[0]['totalltr'].toString()),
        ));
        notifyListeners();
        totquantity = getsoLineData[i]['quantity'].toString();
        totalQuantity = double.parse(getsoLineData[i]['quantity'].toString());
      }
      if (scanneditemData2.isNotEmpty) {
        for (int i = 0; i < scanneditemData2.length; i++) {
          qtymycontroller2[i].text = scanneditemData2[i].qty.toString();
          discountcontroller2[i].text =
              scanneditemData2[i].discountper.toString();
          if (scanneditemData2[i].taxCode == 'O1') {
            scanneditemData2[i].taxRate = 18;
          }
          totalQuantity =
              totalQuantity + double.parse(qtymycontroller2[i].text.toString());

          notifyListeners();
        }
        await calCulateDocVal2(context, theme);
      }
    } else {
      isApprove = false;
    }
    clickAprList = false;
    notifyListeners();
  }

  String uttransId = '';
  getdraftDocEntry(
      BuildContext context, ThemeData theme, String dcEntry) async {
    approvalDetailsValuess = null;
    await ApprovalsDetailsAPi.getGlobalData(dcEntry).then((value) async {
      if (value.documentLines != null) {
        approvalDetailsValuess = value;
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

  ApprovalDetailsValue? approvalDetailsValuess;
  List<DocumentApprovalValue> documentApprovalValue = [];
  groupSelectvalue(int i) {
    groupValueSelected = i;
    if (i == 0) {
      notifyListeners();
    } else {}
    notifyListeners();
  }

  callPendingApprovalapi(BuildContext context) async {
    await PendingApprovalsAPi.getGlobalData(
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
    await RejectedAPi.getGlobalData(
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

  void callApprovaltoDocApi(BuildContext context, ThemeData theme) async {
    isLoading = true;
    sapDocentry = '';
    sapDocuNumber = '';
    sapReceiptDocNum = null;
    sapReceiptDocentry = null;
    final Database db = (await DBHelper.getInstance())!;
    await sapOrderLoginApi(context);
    ApprovalsQuotPostAPi.docEntry = approvalDetailsValuess!.docEntry.toString();
    ApprovalsQuotPostAPi.docDueDate = approvalDetailsValuess!.DocDate;
    ApprovalsQuotPostAPi.orderDate = approvalDetailsValuess!.U_OrderDate;
    ApprovalsQuotPostAPi.orderTime = approvalDetailsValuess!.U_Received_Time;
    ApprovalsQuotPostAPi.orderType = approvalDetailsValuess!.PostOrder_Type;
    ApprovalsQuotPostAPi.custREfNo = approvalDetailsValuess!.numAt;
    ApprovalsQuotPostAPi.gpApproval = approvalDetailsValuess!.PostGP_Approval;

    log('kkkkk' + selectedcust2!.docentry.toString());
    await ApprovalsQuotPostAPi.getGlobalData().then((valuex) async {
      if (valuex.statusCode >= 200 && valuex.statusCode <= 210) {
        ApprovalsQuotAPi.uDeviceID =
            approvalDetailsValuess!.uDevicTransId.toString();

        await ApprovalsQuotAPi.getGlobalData().then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            await DBOperation.updtAprvltoDocSalHead(
                db,
                int.parse(value.approvalsOrdersValue![0].docEntry.toString()),
                int.parse(value.approvalsOrdersValue![0].docNum.toString()),
                int.parse(selectedcust2!.docentry.toString()));
            if (cashType == 'Cash' ||
                chequeType == "Cheque" ||
                cardType == "Card" ||
                transferType == "Transfer" ||
                walletType == "Wallet" ||
                pointType == 'Points Redemption') {
              log("mycontroller[22].text:::$cashpayment");
            }
            await Get.defaultDialog(
                    title: "Success",
                    middleText:
                        "Successfully Done,\nS.O Document Number ${value.approvalsOrdersValue![0].docNum}",
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
                                isLoading = false;

                                Get.back();
                              }),
                        ],
                      ),
                    ],
                    radius: 5)
                .then((value) {
              isLoading = true;
              sapReceiptDocNum = null;
              sapReceiptDocentry = null;
              isApprove = false;
              selectedcust2 = null;
              selectedcust25 = null;
              scanneditemData2 = [];
              postingDatecontroller.text = '';
              custNameController.text = '';
              tinNoController.text = '';
              vatNoController.text = '';
              cashpayment = 0;
              cqpayment = 0;
              transpayment = null;
              chqnum = 0;
              transrefff = '';
              cashType = '';
              cashAccCode = '';
              cardAcctype = '';
              cardAccCode = '';
              chequeAcctype = '';
              chequeAccCode = '';
              transAcctype = '';
              transAccCode = '';
              walletAcctype = '';
              walletAccCode = '';
              creditType = '';
              cardType = '';
              chequeType = '';
              transferType = '';
              walletType = '';
              pointType = '';
              accType = '';
              paymentWay2 = [];
              totalPayment2 = null;
              itemListDateCtrl =
                  List.generate(200, (i) => TextEditingController());

              Get.offAllNamed(ConstantRoutes.dashboard);
              notifyListeners();
            });
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
          selectedcust25 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
        });
        notifyListeners();
      } else {
        isLoading = false;
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
          selectedcust25 = null;
          scanneditemData2 = [];
          paymentWay2 = [];
          totalPayment2 = null;
          isApprove = false;
        });
      }
    });
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesOrderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
        username: UserValues.username,
        terminal: AppConstant.terminal,
        type: "Sales Order",
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
        doctotal: getSalesHeader[i]["doctotal"] == null
            ? 0
            : double.parse(getSalesHeader[i]["doctotal"].toString()),
      ));
    }
    searchData.addAll(searchdata2);

    searchbool = false;
    notifyListeners();
  }

  List<OpenSalesOrderHeaderData> searchHeader = [];
  List<OpenSalesOrderHeaderData> filtersearchData = [];

  callSearchHeaderApi() async {
    await SearchOrderHeaderAPi.getGlobalData(
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

  getOrderApi(String sapDocEntry, String docStatus, BuildContext context,
      ThemeData theme) async {
    await sapOrderLoginApi(context);

    await SerlaySalesOrderAPI.getData(sapDocEntry).then((value) async {
      scanneditemData2 = [];
      editqty = false;
      sapDocentry = '';

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log(' value.uOrderDate::${value.docDueDate}');
        sapDocentry = value.docEntry.toString();
        log('sapDocentry::$sapDocentry');
        mycontroller2[50].text = value.comments.toString();
        remarkcontroller3.text = value.comments.toString();
        postingDatecontroller.text =
            config.alignDateT(value.docDueDate.toString());
        tinNoController.text = value.uTinNo.toString();
        vatNoController.text = value.uVatNumber.toString();

        selectDocSeries2(value.series.toString());

        if (value.documentLines.isNotEmpty) {
          selectedWhsCode2(value.documentLines[0].warehouseCode);

          for (var i = 0; i < value.documentLines.length; i++) {
            log('value.documentLines length::${value.documentLines[i].uPackSize}');

            scanneditemData2.add(StocksnapModelData(
                branch: AppConstant.branch,
                shipDate: value.documentLines[i].shipDate,
                itemCode: value.documentLines[i].itemCode,
                docentry: value.docEntry.toString(),
                itemName: value.documentLines[i].itemDescription,
                openRetQty: value.documentLines[i].quantity,
                lineStatus: value.documentLines[i].lineStatus,
                taxCode: value.documentLines[i].taxCode,
                uPackSize: value.documentLines[i].uPackSize,
                discountper: value.documentLines[i].discountPercent,
                serialBatch: '',
                mrp: 0,
                sellPrice: value.documentLines[i].unitPrice));
          }
          notifyListeners();

          for (var i = 0; i < scanneditemData2.length; i++) {
            itemListDateCtrl2[i].text =
                config.alignDate(scanneditemData2[i].shipDate.toString());
            discountcontroller[i].text =
                scanneditemData2[i].discountper.toString();
            qtymycontroller2[i].text =
                scanneditemData2[i].openRetQty.toString();
            if (scanneditemData2[i].taxCode == 'O1') {
              scanneditemData2[i].taxRate = 18;
            } else {
              scanneditemData2[i].taxRate = 0;
            }
          }
          notifyListeners();
        }

        final Database db = (await DBHelper.getInstance())!;

        List<Address>? address2 = [];
        List<Address>? address25 = [];
        List<CustomerAddressModelDB> csadresdataDB =
            await DBOperation.getCstmMasAddDBCardCode(
                db, value.cardCode.toString());

        if (csadresdataDB.isNotEmpty) {
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
        }
        List<Map<String, Object?>> getcustomer =
            await DBOperation.getCstmMasDatabyautoid(
                db, value.cardCode.toString());
        if (getcustomer.isNotEmpty) {
          selectedcust2 = CustomerDetals(
            name: value.cardName,
            phNo: getcustomer[0]['phoneno1'].toString(),
            taxCode: getcustomer[0]['TaxCode'].toString(),
            cardCode: getcustomer[0]['customerCode'].toString(),
            point: getcustomer[0]['points'].toString(),
            U_CashCust: getcustomer[0]['U_CASHCUST'].toString(),
            accBalance: 0,
            address: address2,
            uReceivedTime: value.uReceivedTime,
            uGPApproval: value.uGpApproval.toString(),
            uOrderDate: value.uOrderDate == 'null' || value.uOrderDate == null
                ? ''
                : config.alignDateT(value.uOrderDate),
            uOrderType: value.uOrderType != null || value.uOrderType!.isNotEmpty
                ? value.uOrderType
                : '1',
            invoiceDate: value.docDate,
            custRefNum: value.numAtCard,
            docentry: value.docEntry.toString(),
            invoicenum: value.docNum.toString(),
            docStatus: docStatus,
            email: getcustomer[0]['emalid'].toString(),
            tarNo: getcustomer[0]['taxno'].toString(),
            autoId: getcustomer[0]['autoid'].toString(),
          );
          selectedcust25 = CustomerDetals(
            name: getcustomer[0]['customername'].toString(),
            phNo: getcustomer[0]['phoneno1'].toString(),
            taxCode: getcustomer[0]['TaxCode'].toString(),
            cardCode: getcustomer[0]['customerCode'].toString(),
            point: getcustomer[0]['points'].toString(),
            address: address25,
            accBalance: 0,
            docStatus: docStatus,
            uOrderType: value.uOrderType ?? '1',
            uGPApproval: value.uGpApproval,
            uOrderDate: '',
            docentry: value.docEntry.toString(),
            invoiceDate: value.docDate,
            invoicenum: value.docNum.toString(),
            U_CashCust: getcustomer[0]['U_CASHCUST'].toString(),
            email: getcustomer[0]['emalid'].toString(),
            tarNo: getcustomer[0]['TaxCode'].toString(),
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
          if (selectedcust2 != null) {
            selectedcust2!.accBalance = updateCustBal ?? 0;
            selectedcust25!.accBalance = updateCustBal ?? 0;
          }

          await CustCreditLimitAPi.getGlobalData(value.cardCode..toString())
              .then((value) {
            if (value.statuscode >= 200 && value.statuscode <= 210) {
              if (value.creditLimitData != null) {
                if (selectedcust2 != null) {
                  selectedcust2!.creditLimits = double.parse(
                      value.creditLimitData![0].creditLine.toString());
                  notifyListeners();
                }
              }
            }
          });
          await CustCreditDaysAPI.getGlobalData(value.cardCode.toString())
              .then((valuex) {
            if (valuex.statuscode >= 200 && valuex.statuscode <= 210) {
              if (valuex.creditDaysData != null) {
                if (selectedcust2 != null) {
                  selectedcust2!.creditDays =
                      valuex.creditDaysData![0].creditDays.toString();
                  selectedcust2!.paymentGroup = valuex
                      .creditDaysData![0].paymentGroup
                      .toString()
                      .toLowerCase();
                  log('selectedcust paymentGroup::${selectedcust2!.paymentGroup!}');
                  if (selectedcust2!.paymentGroup!.contains('cash') == true) {
                    selectedcust2!.name = value.cardName;
                  } else {
                    selectedcust2!.name = value.cardName;
                  }
                  log('Cash paymentGroup::${selectedcust2!.paymentGroup!.contains('cash')}');
                  notifyListeners();
                }
                loadingscrn = false;
              }
            }
          });
        }
        if (scanneditemData2.isNotEmpty) {
          for (var i = 0; i < scanneditemData2.length; i++) {
            scanneditemData2[i].taxRate = 0.0;
            if (selectedcust2 != null) {
              if (selectedcust2!.taxCode == 'O1') {
                scanneditemData2[i].taxRate = 18;
              }
            } else {
              scanneditemData2[i].taxRate = 0.0;
            }
            notifyListeners();
          }
          calCulateDocVal2(context, theme);
        }
        clickAprList = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        clickAprList = false;
      } else {
        clickAprList = false;
      }
    });
    Get.back();

    notifyListeners();
  }

  List<CashCardAccDetailData> newCashAcc = [];

  String newCogsAccount = '';
  String newGlAccount = '';

  callNewCashAccountApi(String selectedBranch) async {
    newCogsAccount = '';
    newGlAccount = '';
    newCashAcc = [];
    await CashCardAccountAPi.getGlobalData('$selectedBranch').then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData!.isNotEmpty) {
          newCashAcc = value.activitiesData!;

          for (var i = 0; i < newCashAcc.length; i++) {
            newCogsAccount = newCashAcc[i].uCogsAcc.toString();
            newGlAccount = newCashAcc[i].uGlAcc.toString();
          }
        }

        log('newGlAccount::${newGlAccount}:newCogsAccount:${newCogsAccount}');
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  // NewCashAccSelect(value) {
  //   for (var i = 0; i < newCashAcc.length; i++) {
  //     if (newCashAcc[i].uAcctName == value) {
  //       if (newCashAcc[i].uMode == 'CASH') {
  //         cashAccCode = newCashAcc[i].uAcctCode.toString();
  //         log('step1::${cashAccCode}');
  //       } else if (newCashAcc[i].uMode == 'CARD') {
  //         cardAccCode = newCashAcc[i].uAcctCode.toString();
  //         log('step12::$cardAccCode');
  //       } else if (newCashAcc[i].uMode == 'CHEQUE') {
  //         chequeAccCode = newCashAcc[i].uAcctCode.toString();
  //         log('step13::$chequeAccCode');
  //       } else if (newCashAcc[i].uMode == 'WALLET') {
  //         walletAccCode = newCashAcc[i].uAcctCode.toString();
  //         log('step14::$walletAccCode');
  //       } else if (newCashAcc[i].uMode == 'TRANSFER') {
  //         transAccCode = newCashAcc[i].uAcctCode.toString();
  //         log('step15::$transAccCode');
  //       }
  //     }
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  newUpdateFixDataMethod(BuildContext context, ThemeData theme) async {
    await callGetUserType();

    scanneditemData = scanneditemData2;
    selectedcust = selectedcust2;
    selectedcust25 = selectedcust25;

    callNewCashAccountApi(whsCode!);

    for (var i = 0; i < scanneditemData.length; i++) {
      log('scanneditemData[i].qty.toString()::${scanneditemData[i].qty.toString()}');
      discountcontroller[i].text = scanneditemData[i].discountper.toString();
      pricemycontroller[i].text = scanneditemData[i].sellPrice.toString();
      qtymycontroller[i].text = scanneditemData[i].qty.toString();
      itemListDateCtrl[i].text =
          config.alignDateT(scanneditemData[i].shipDate.toString());

      scanneditemData[i].transID = i;
    }

    if (selectedcust != null) {
      custNameController.text = selectedcust!.name.toString();
      log('selectedcustselectedcust::${selectedcust!.uGPApproval}');
    }
    await postqtyreadonly();
    calCulateDocVal(context, theme);
    scanneditemData2 = [];
    selectedcust2 = null;
    selectedcust25 = null;

    notifyListeners();
  }

  fixDataMethod(int docentry, BuildContext context, ThemeData theme) async {
    sapDocentry = '';
    sapDocuNumber = '';
    cancelDocnum = '';
    salesmodl = [];
    editqty = false;
    tbDocEntry = null;
    mycontroller2[50].text = "";
    shipaddress = "";
    paymentWay2 = [];
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2.clear();
    totalPayment2 = null;
    selectedcust2 = null;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<PaymentWay> payment = [];
    int? totalQuantity = 0;
    mycontroller2[50].text = getDBSalesHeader[0]['remarks'] != null
        ? getDBSalesHeader[0]['remarks'].toString()
        : "";

    sapDocentry = getDBSalesHeader[0]['sapDocentry'] != null
        ? getDBSalesHeader[0]['sapDocentry'].toString()
        : "";
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'] != null
        ? getDBSalesHeader[0]['sapDocNo'].toString()
        : "";
    cancelDocnum = getDBSalesHeader[0]['documentno'] != null
        ? getDBSalesHeader[0]['documentno'].toString()
        : "";
    tbDocEntry = int.parse(getDBSalesHeader[0]["docentry"].toString());
    log("tbDocEntrytbDocEntry:::$tbDocEntry");

    totwieght = double.parse(getDBSalesHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesHeader[0]['totalltr'].toString());
    for (int kk = 0; kk < getDBSalespay.length; kk++) {
      if (getDBSalespay[0]['docentry'] == getDBSalespay[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(getDBSalespay[kk]['rcamount'].toString()),
          type: getDBSalespay[kk]['rcmode'].toString(),
          dateTime: getDBSalespay[kk]['createdateTime'].toString(),
          reference: getDBSalespay[kk]['reference'] != null
              ? getDBSalespay[kk]['reference'].toString()
              : '',
          cardApprno: getDBSalespay[kk]['cardApprno'] != null
              ? getDBSalespay[kk]['cardApprno'].toString()
              : '',
          cardref: getDBSalespay[kk]['cardref'].toString(),
          cardterminal: getDBSalespay[kk]['cardterminal'].toString(),
          chequedate: getDBSalespay[kk]['chequedate'].toString(),
          chequeno: getDBSalespay[kk]['chequeno'].toString(),
          couponcode: "", //getDBholdSalespay[kk]['couponcode'].toString(),
          coupontype: "", //getDBholdSalespay[kk]['coupontype'].toString(),
          discountcode: getDBSalespay[kk]['discountcode'].toString(),
          discounttype: getDBSalespay[kk]['discounttype'].toString(),
          recoverydate: getDBSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBSalespay[kk]['redeempoint'].toString(),
          availablept: getDBSalespay[kk]['availablept'].toString(),
          remarks: getDBSalespay[kk]['remarks'].toString(),
          transtype: getDBSalespay[kk]['transtype'].toString(),
          walletid: getDBSalespay[kk]['walletid'].toString(),
          wallettype: getDBSalespay[kk]['wallettype'].toString(),
        ));
        paymentWay2 = payment;
        notifyListeners();
      }
      notifyListeners();
    }

    for (int ik = 0; ik < getDBSalesLine.length; ik++) {
      scanneditemData2.add(StocksnapModelData(
          shipDate: '',
          basic: getDBSalesLine[ik]['basic'] != null
              ? double.parse(getDBSalesLine[ik]['basic'].toString())
              : 00,
          netvalue: getDBSalesLine[ik]['netlinetotal'] != null
              ? double.parse(getDBSalesLine[ik]['netlinetotal'].toString())
              : null,
          transID: int.parse(getDBSalesLine[ik]['docentry'].toString()),
          branch: getDBSalesLine[ik]['branch'].toString(),
          itemCode: getDBSalesLine[ik]['itemcode'].toString(),
          itemName: getDBSalesLine[ik]['itemname'].toString(),
          serialBatch: getDBSalesLine[ik]['serialbatch'].toString(),
          openQty: double.parse(getDBSalesLine[ik]['quantity'].toString()),
          qty: double.parse(getDBSalesLine[ik]['quantity'].toString()),
          inDate: getDBSalesLine[ik][''].toString(),
          inType: getDBSalesLine[ik][''].toString(),
          mrp: 0,
          sellPrice: double.parse(getDBSalesLine[ik]['price'].toString()),
          cost: 0,
          discount: getDBSalesLine[ik]['discperunit'] != null
              ? double.parse(getDBSalesLine[ik]['discperunit'].toString())
              : 00,
          taxvalue: getDBSalesLine[ik]['taxtotal'] != null
              ? double.parse(getDBSalesLine[ik]['taxtotal'].toString())
              : 00,
          taxRate: double.parse(getDBSalesLine[ik]['taxrate'].toString()),
          maxdiscount: getDBSalesLine[ik]['maxdiscount'].toString(),
          discountper: getDBSalesLine[ik]['discperc'] == null
              ? 0.0
              : double.parse(getDBSalesLine[ik]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: getDBSalesLine[ik]['liter'] == null
              ? 0.0
              : double.parse(getDBSalesLine[ik]['liter'].toString()),
          weight: getDBSalesLine[ik]['weight'] == null
              ? 0.0
              : double.parse(
                  getDBSalesLine[ik]['weight'].toString()))); //discperc
      totquantity = getDBSalesLine[ik]['quantity'].toString();

      notifyListeners();
    }

    for (int i = 0; i < scanneditemData2.length; i++) {
      qtymycontroller2[i].text = scanneditemData2[i].qty.toString();
      discountcontroller2[i].text = scanneditemData2[i].discountper.toString();

      scanneditemData2[i].priceAfDiscBasic =
          scanneditemData2[intval].sellPrice! * 1;
      double priceafd = (scanneditemData2[i].priceAfDiscBasic! *
          scanneditemData2[i].discountper! /
          100);
      double priceaftDisc = scanneditemData2[i].priceAfDiscBasic! - priceafd;
      scanneditemData2[i].priceAftDiscVal = priceaftDisc;
      totalQuantity =
          totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

      notifyListeners();
    }
    await calCulateDocVal2(context, theme);

    shipaddress = getDBSalesHeader[0]['shipaddresid'].toString();

    List<Address>? address2 = [];
    List<Address>? address25 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          getDBSalesHeader[0]['customercode'].toString()) {
        if (csadresdataDB[k].autoid.toString() ==
            getDBSalesHeader[0]['billaddressid'].toString()) {
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
        if (getDBSalesHeader[0]['shipaddresid'].toString().isNotEmpty) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesHeader[0]['shipaddresid'].toString()) {
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

    selectedcust2 = CustomerDetals(
      name: getDBSalesHeader[0]["customername"].toString(),
      phNo: getDBSalesHeader[0]["customerphono"].toString(),
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      taxCode: getDBSalesHeader[0]["taxCode"].toString(),
      U_CashCust: '',
      cardCode: getDBSalesHeader[0]["customercode"].toString(),
      accBalance:
          double.parse(getDBSalesHeader[0]["customeraccbal"].toString()),
      point: getDBSalesHeader[0]["customerpoint"].toString(),
      address: address2,
      tarNo: getDBSalesHeader[0]["taxno"].toString(),
      email: getDBSalesHeader[0]["customeremail"].toString(),
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    selectedcust25 = CustomerDetals(
      name: getDBSalesHeader[0]["customername"].toString(),
      phNo: getDBSalesHeader[0]["customerphono"].toString(),
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      taxCode: getDBSalesHeader[0]["taxCode"].toString(),
      U_CashCust: '',
      cardCode: getDBSalesHeader[0]["customercode"].toString(),
      accBalance:
          double.parse(getDBSalesHeader[0]["customeraccbal"].toString()),
      point: getDBSalesHeader[0]["customerpoint"].toString(),
      address: address25,
      tarNo: getDBSalesHeader[0]["taxno"].toString(),
      email: getDBSalesHeader[0]["customeremail"].toString(),
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    notifyListeners();

    SalesModel salesM = SalesModel(
      ordReference: getDBSalesHeader[0]['remarks'].toString(),
      objname: getDBSalesHeader[0]['objname'].toString(),
      taxCode: getDBSalesHeader[0]['taxCode'].toString(),
      objtype: getDBSalesHeader[0]['objtype'].toString(),
      doctype: getDBSalesHeader[0]['doctype'].toString(),
      docentry: int.parse(getDBSalesHeader[0]['docentry'].toString()),
      custName: getDBSalesHeader[0]['customername'].toString(),
      phNo: getDBSalesHeader[0]['customerphono'].toString(),
      cardCode: getDBSalesHeader[0]['customercode'].toString(),
      accBalance: getDBSalesHeader[0]['customeraccbal'].toString(),
      point: getDBSalesHeader[0]['customerpoint'].toString(),
      tarNo: getDBSalesHeader[0]['taxno'].toString(),
      email: getDBSalesHeader[0]['customeremail'].toString(),
      invoceDate: getDBSalesHeader[0]['createdateTime'].toString(),
      invoiceNum: getDBSalesHeader[0]['documentno'].toString(),
      sapOrderNum: getDBSalesHeader[0]['basedocentry'].toString(),
      sapInvoiceNum: getDBSalesHeader[0]['sapDocNo'].toString(),
      item: scanneditemData2,
    );

    notifyListeners();
    salesmodl.add(salesM);
    notifyListeners();

    selectedBillAdress = selectedcust2!.address!.length - 1;
    selectedShipAdress = selectedcust25!.address!.length - 1;
    notifyListeners();
  }

  postqtyreadonly() {
    editqty = true;
    notifyListeners();
  }

  Uuid uuid = const Uuid();
  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesHeaderToDB(docstatus, context, theme);
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

  viewSalesRet() async {}

  String? uuiDeviceId;
  insertSalesHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesOrderHeaderModelDB> salesHeaderValues1 = [];
    List<SalesOrderPayTDB> salesPayValues = [];
    List<SalesOrderLineTDB> salesLineValues = [];
    uuiDeviceId = uuid.v1();
    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesOrderHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "SalesOrderHeader");
    }

    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 1);
    List<String> getseriesvalue = await checkingdoc(1);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();

    salesHeaderValues1.add(SalesOrderHeaderModelDB(
        doctype: 'Sales Order',
        docentry: docEntryCreated.toString(),
        objname: '',
        objtype: '',
        amtpaid: totalPayment != null
            ? getSumTotalPaid().toString().replaceAll(',', '')
            : null,
        baltopay: totalPayment != null
            ? getBalancePaid().toString().replaceAll(',', '')
            : null,
        billaddressid: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].autoId.toString(),
        billtype: null,
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust!.cardCode != null
            ? selectedcust!.cardCode.toString()
            : '',
        customername: custNameController.text.isNotEmpty
            ? custNameController.text
            : selectedcust != null
                ? selectedcust!.name
                : "",
        tinNo: tinNoController.text,
        vatno: vatNoController.text,
        customertype: UserValues.userType,
        docbasic: totalPayment != null
            ? totalPayment!.subtotal!.toString().replaceAll(',', '')
            : null,
        docdiscamt: totalPayment != null
            ? totalPayment!.discount!.toString().replaceAll(',', '')
            : null,
        docdiscuntpercen: mycontroller[i].text.isNotEmpty
            ? mycontroller[i].text.toString()
            : '0',
        documentno: (documentNum).toString(),
        docstatus: docstatus == "hold"
            ? '1'
            : docstatus == "save as order"
                ? "2"
                : docstatus == "check out"
                    ? '3'
                    : "null",
        doctotal: totalPayment != null
            ? totalPayment!.totalDue!.toStringAsFixed(2)
            : null,
        lastupdateIp: UserValues.lastUpdateIp,
        premiumid: '',
        remarks: remarkcontroller3.text.toString(),
        salesexec: '',
        seresid: newSeriesCode != null
            ? newSeriesCode!.toString()
            : newseries.isNotEmpty
                ? newseries[0].series.toString()
                : '',
        seriesnum: '',
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
        taxamount:
            totalPayment != null ? totalPayment!.totalTX!.toString() : null,
        taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
        transactiondate: '',
        transtime: config.currentDate(),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        paystatus: '',
        customeraccbal:
            selectedcust != null ? selectedcust!.accBalance!.toString() : "",
        customeremail: selectedcust != null ? selectedcust!.email : '',
        customerphono: selectedcust != null ? selectedcust!.phNo : '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null || selectedcust!.address!.isEmpty
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
        terminal: UserValues.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: "No",
        totalltr: totalLiter(),
        totalweight: totalWeight(),
        basedocentry: selectedcust!.docentry != null ? selectedcust!.docentry.toString() : '',
        customerSeriesNum: '',
        editType: '',
        uOrderDate: udfController[2].text,
        uOrderType: valueSelectedOrder,
        uGPApproval: valueSelectedGPApproval,
        uReceivedTime: udfController[1].text,
        uDeviceId: uuiDeviceId!,
        custRefNo: udfController[0].text));

    int? docentry2 =
        await DBOperation.insertSaleOrderheader(db, salesHeaderValues1);

    await DBOperation.updatenextno(db, 1, nextno);

    for (int i = 0; i < scanneditemData.length; i++) {
      salesLineValues.add(SalesOrderLineTDB(
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        shipDate: itemListDateCtrl[i].text,
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: scanneditemData[i].discountper != null
            ? scanneditemData[i].discountper!.toString()
            : '0',
        discperunit: scanneditemData[i].discount.toString(),
        maxdiscount: scanneditemData[i].maxdiscount.toString(),
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].itemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        serialbatch: scanneditemData[i].serialBatch,
        taxrate: scanneditemData[i].taxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].itemName,
        basedocentry: scanneditemData[i].basedocentry ?? '',
        baselineID: scanneditemData[i].baselineid ?? '',
        basetype: '23',
      ));

      notifyListeners();
    }
    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      salesPayValues.add(SalesOrderPayTDB(
          createdUserID: UserValues.userID.toString(),
          createdateTime: config.currentDate(),
          docentry: docentry2.toString(),
          lastupdateIp: UserValues.lastUpdateIp,
          rcamount: paymentWay[ij].amt != null
              ? paymentWay[ij].amt!.toString().replaceAll(',', '')
              : "",
          rcdatetime: config.currentDate(),
          rcdocentry: "",
          rcmode: paymentWay[ij].type ?? '',
          rcnumber: "",
          updatedDatetime: config.currentDate(),
          reference: paymentWay[ij].reference,
          updateduserid: UserValues.userID.toString(),
          cardApprno: paymentWay[ij].cardApprno,
          cardterminal: paymentWay[ij].cardterminal,
          chequedate: paymentWay[ij].chequedate,
          chequeno: paymentWay[ij].chequeno,
          couponcode: "", //paymentWay[ij].couponcode,
          coupontype: "", //paymentWay[ij].coupontype,
          discountcode: paymentWay[ij].discountcode,
          discounttype: paymentWay[ij].discounttype,
          recoverydate: paymentWay[ij].recoverydate,
          redeempoint: paymentWay[ij].redeempoint,
          availablept: paymentWay[ij].availablept,
          remarks: paymentWay[ij].remarks,
          transtype: paymentWay[ij].transtype,
          walletid: paymentWay[ij].walletid,
          wallettype: paymentWay[ij].wallettype,
          branch: UserValues.branch,
          terminal: UserValues.terminal,
          lineid: ij.toString()));
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      DBOperation.insertSalesOrderLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    if (salesPayValues.isNotEmpty) {
      DBOperation.insertSalesOrderPay(db, salesPayValues, docentry2!);
      notifyListeners();
    }

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "check out") {
        await callOrdPostApi(
          context,
          theme,
          docentry2!,
          docstatus,
          documentNum,
        );
        notifyListeners();
      }
    }
    if (docstatus == "hold") {
      getdraftindex();

      await Get.defaultDialog(
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
        udfClear();

        cashType = '';
        creditType = '';
        cardType = '';
        chequeType = '';
        transferType = '';
        walletType = '';
        pointType = '';
        accType = '';
        cashpayment = null;
        cashpayment = null;
        newSeriesCode = null;
        newSeriesName = null;
        cqpayment = null;
        transpayment = null;
        chqnum = null;
        transrefff = null;
        addCardCode = '';
        selectedcust55 = null;
        selectedcust = null;
        scanneditemData.clear();
        schemebtnclk = false;
        paymentWay.clear();
        newShipAddrsValue = [];
        newBillAddrsValue = [];
        newCustValues = [];
        totalPayment = null;
        mycontroller[50].text = "";
        itemListDateCtrl = List.generate(200, (i) => TextEditingController());
        discountcontroller = List.generate(500, (i) => TextEditingController());
        mycontroller = List.generate(500, (i) => TextEditingController());
        qtymycontroller = List.generate(500, (i) => TextEditingController());
        remarkcontroller3.text = '';
        injectToDb();
        onDisablebutton = false;
        notifyListeners();
      });
    }

    notifyListeners();
  }

  static List<QuatationLines> itemsDocDetails = [];

  Future<bool> isLocationAvailable(BuildContext context) async {
    bool? serviceEnabled;
    try {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (serviceEnabled == true) {
        return Future.value(true);
      } else if (serviceEnabled == false) {
        notifyListeners();

        return Future.value(false);
      }
    } catch (e) {
      const snackBar = SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Colors.red,
          content: Text("Please turn on the Location!!.."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();

    return Future.value(false);
  }

  void showsnb(BuildContext context) {
    disableKeyBoard(context);
    const snackBar = SnackBar(
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text(
            "Please give location permission to pos app & turn on the Location!!.."));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    notifyListeners();
  }

  static String? latitude;
  static String? longitude;

  LocationPermission? permission;

  getOrderDocList() {
    itemsDocDetails = [];

    if (userTypes == 'corporate' || userTypes == 'retail') {
      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].sellPrice =
            double.parse(pricemycontroller[i].text.toString());
        scanneditemData[i].discountper =
            double.parse(discountcontroller[i].text.toString());
      }
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData.length; i++) {
      log('scanneditemData[i].discountper::${scanneditemData[i].discountper}');
      itemsDocDetails.add(
        QuatationLines(
            currency: "TZS",
            discPrcnt: scanneditemData[i].discountper.toString(),
            itemCode: scanneditemData[i].itemCode,
            price: scanneditemData[i].sellPrice.toString(),
            lineNo: i,
            quantity: scanneditemData[i].qty.toString(),
            taxCode: selectedcust!.taxCode,
            unitPrice: scanneditemData[i].sellPrice!.toStringAsFixed(2),
            whsCode: whsCode == null || whsCode!.isEmpty
                ? AppConstant.branch
                : whsCode,
            itemName: scanneditemData[i].itemName.toString(),
            baseType: scanneditemData[i].sapbasedocentry != null ? 23 : null,
            baseline: scanneditemData[i].baselineid == null ||
                    scanneditemData[i].baselineid!.isEmpty
                ? null
                : int.parse(scanneditemData[i].baselineid.toString()),
            basedocentry: scanneditemData[i].sapbasedocentry != null
                ? scanneditemData[i].sapbasedocentry
                : null,
            leadDate: config.alignDate1(itemListDateCtrl[i].text),
            cogsAcct: newCogsAccount ?? '',
            acctCode: newGlAccount ?? ''),
      );
    }
    notifyListeners();
  }

  Future<String?> getSlpCode() async {
    String? slpCodee = await SharedPref.getslpCode();
    log('slpCodeeslpCodee::$slpCodee');
    return slpCodee;
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  void getSelectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedTime = picked;
      udfController[1].clear();
      log('selectedTime.format(context)::${selectedTime.format(context)}');
      udfController[1].text = selectedTime.format(context);
      notifyListeners();
    }
  }

  final TimeOfDay _selectTime = TimeOfDay.now();
  String? installTime;
  void selecTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectTime,
    );
    MaterialLocalizations localizations = MaterialLocalizations.of(context);

    if (picked != null) {
      String format = localizations.formatTimeOfDay(picked);
      udfController[1].text = format;
      log('message installTime111::$format');

      String time, postTime, postTime2;
      time = picked.toString();
      log('message Time111::$time');

      postTime = time.replaceAll("TimeOfDay", "");
      postTime2 = postTime.replaceAll("(", "");
      installTime = postTime2.replaceAll(")", "");
      udfController[1].clear();
      udfController[1].text = installTime!;
      log('message installTime::$installTime');
      notifyListeners();
    }
  }

  String? valueSelectedOrder;
  String? valueSelectedGPApproval;

  List<Map<String, String>> salesOrderType = [
    {"name": "Select", "value": '0'},
    {"name": "Normal", "value": '1'},
    {"name": "Depot transfer", "value": "2"},
    {"name": "Root Sale", "value": '3'},
    {"name": "Project sale", "value": "4"},
    {"name": "Special Order", "value": "5"},
  ];
  List get getSalesOrderType => salesOrderType;
  List<Map<String, String>> grpApprovalRequired = [
    {"name": "NO", "value": '0'},
    {"name": "YES", "value": '1'},
  ];
  List get getgrpApprovalRequired => grpApprovalRequired;
  List<PostPaymentCheck> itemsPaymentCheckDet = [];

  String? sapReceiptDocNum = '';

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

  postingReceipt22(
    BuildContext context,
    ThemeData theme,
    int docEntry,
  ) async {
    seriesType = '';
    final Database db = (await DBHelper.getInstance())!;
    await addChequeValues22();
    await addCardValues();
    await callSeriesApi(context, "24");

    ReceiptPostAPi.transferSum = null;
    ReceiptPostAPi.cashSum = null;

    ReceiptPostAPi.transferAccount = null;
    ReceiptPostAPi.transferReference = null;
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = chequeAccCode;
    ReceiptPostAPi.cardCodePost =
        selectedcust2 != null && selectedcust2!.cardCode != null
            ? selectedcust2!.cardCode
            : selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentCards = itemcardPayment;
    ReceiptPostAPi.docPaymentInvoices = [];
    ReceiptPostAPi.docDate = config.currentDate();
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = remarkcontroller3.text;
    if (cashType == 'Cash') {
      log("chequeno:::${mycontroller[22].text}");
      ReceiptPostAPi.cashAccount = cashAccCode;
      ReceiptPostAPi.cashSum = cashpayment;
      notifyListeners();
    }
    if (transferType == 'Transfer') {
      ReceiptPostAPi.transferAccount = transAccCode;
      ReceiptPostAPi.transferSum = transpayment;
      ReceiptPostAPi.transferReference = transrefff;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    if (transferType == 'Wallet') {
      ReceiptPostAPi.transferAccount = walletAccCode;
      ReceiptPostAPi.transferSum = transpayment;
      ReceiptPostAPi.transferReference = transrefff;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    notifyListeners();

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry;
          sapReceiptDocNum = value.docNum.toString();
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesOrderPay");
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
        }
      } else {
        custserieserrormsg = value.exception.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: '${value.error!.message!.value}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(500, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          onDisablebutton = false;
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  List<PostPaymentCard> itemcardPayment = [];

  addCardValues() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    itemcardPayment = [];
    String creditAcc = (preferences.getString('UCreditAccount'))!.toString();
    if (paymentWay.isNotEmpty) {
      for (int i = 0; i < paymentWay.length; i++) {
        if (paymentWay[i].type == "Card") {
          itemcardPayment.add(PostPaymentCard(
              creditAcc: creditAcc,
              cardValidity: config.currentDate2(),
              creditcardCode: 1,
              voucherNum: paymentWay[i].reference.toString(),
              creditSum: paymentWay[i].amt,
              creditCardNum: paymentWay[i].cardApprno.toString()));
        }
      }
      notifyListeners();
    } else {
      if (paymentWay2.isNotEmpty) {
        for (int i = 0; i < paymentWay2.length; i++) {
          if (cardType == "Card") {
            itemcardPayment.add(PostPaymentCard(
                creditAcc: creditAcc,
                cardValidity: config.currentDate2(),
                creditcardCode: 1,
                voucherNum: paymentWay2[i].reference.toString(),
                creditSum: paymentWay2[i].amt,
                creditCardNum: paymentWay2[i].cardApprno.toString()));
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }

  String selectbankCode = '';

  getSelectbankCode(value) {
    for (var i = 0; i < bankList.length; i++) {
      if (bankList[i].bankName == value) {
        selectbankCode = bankList[i].bankCode.toString();
        log('selectbankCode:::$selectbankCode');
      }
      notifyListeners();
    }
    notifyListeners();
  }

  addChequeValues22() {
    itemsPaymentCheckDet = [];
    if (chequeType == "Cheque") {
      log("chequeno:::${mycontroller[23].text}");
      itemsPaymentCheckDet.add(PostPaymentCheck(
        dueDate: config.currentDate(),
        checkNumber: chqnum,
        bankCode: selectbankCode,
        accounttNum: '',
        details: remarkcontroller3.text,
        checkSum: cqpayment,
      ));
      notifyListeners();
    }
    notifyListeners();
  }

  addChequeValues(int ik) {
    itemsPaymentCheckDet = [];
    if (paymentWay[ik].type == "Cheque") {
      log("chequeno:::${mycontroller[23].text}");
      itemsPaymentCheckDet.add(PostPaymentCheck(
          dueDate: config.currentDate(),
          checkNumber: int.parse(paymentWay[ik].chequeno.toString()),
          bankCode: selectbankCode,
          accounttNum: '',
          details: remarkcontroller3.text,
          checkSum: paymentWay[ik].amt));
      notifyListeners();
    }
    notifyListeners();
  }

  postingReceipt(
      BuildContext context, ThemeData theme, int docEntry, int ik) async {
    final Database db = (await DBHelper.getInstance())!;

    await addChequeValues(ik);
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = chequeAccCode;
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentInvoices = [];
    ReceiptPostAPi.docDate = config.currentDate();
    ReceiptPostAPi.dueDate = config.currentDate().toString();
    ReceiptPostAPi.remarks = remarkcontroller3.text;
    if (paymentWay[ik].type == 'Cash') {
      log("chequeno:::${mycontroller[22].text}");

      ReceiptPostAPi.cashAccount = cashAccCode;
      ReceiptPostAPi.cashSum = paymentWay[ik].amt;

      notifyListeners();
    }
    if (paymentWay[ik].type == 'Transfer') {
      ReceiptPostAPi.transferAccount = transAccCode;
      ReceiptPostAPi.transferSum = paymentWay[ik].amt;
      ReceiptPostAPi.transferReference = paymentWay[ik].transref;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    if (paymentWay[ik].type == 'Wallet') {
      ReceiptPostAPi.transferAccount = walletAccCode;
      ReceiptPostAPi.transferSum = paymentWay[ik].amt;
      ReceiptPostAPi.transferReference = paymentWay[ik].transref;
      ReceiptPostAPi.transferDate = config.currentDate.toString();
      notifyListeners();
    }
    exit;
    notifyListeners();

    ReceiptPostAPi.method();
    await ReceiptPostAPi.getGlobalData().then((value) async {
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry;
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesOrderPay");
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          addCardCode = '';
        }
      } else {
        custserieserrormsg = value.exception.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: '${value.error!.message!.value}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(500, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          onDisablebutton = false;
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  checkcashcust() async {
    notifyListeners();
  }

  validateAndCallApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    seriesType = '';
    sapDocentry = '';
    sapDocuNumber = '';
    sapReceiptDocNum = null;
    sapReceiptDocentry = null;
    final Database db = (await DBHelper.getInstance())!;
    log('cpyfrmsqcpyfrmsq::$cpyfrmsq');
    await getOrderDocList();
    await callSeriesApi(context, "17");
    SalesOrderPostAPi.sessionID = AppConstant.sapSessionID.toString();
    SalesOrderPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesOrderPostAPi.cardNamePost = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;
    SalesOrderPostAPi.copyfromsq = cpyfrmsq;
    SalesOrderPostAPi.docLineQout = itemsDocDetails;
    SalesOrderPostAPi.docDate = config.currentDate();
    SalesOrderPostAPi.dueDate = config.alignDate2(postingDatecontroller.text);
    SalesOrderPostAPi.remarks = remarkcontroller3.text;
    SalesOrderPostAPi.tinNo = tinNoController.text;
    SalesOrderPostAPi.vatNo = vatNoController.text;
    SalesOrderPostAPi.orderDate = config.alignDate2(udfController[2].text);
    SalesOrderPostAPi.orderType = valueSelectedOrder;
    SalesOrderPostAPi.gpApproval = valueSelectedGPApproval;
    SalesOrderPostAPi.orderTime = udfController[1].text;
    SalesOrderPostAPi.custREfNo = udfController[0].text;
    SalesOrderPostAPi.deviceTransID = uuiDeviceId!;
    SalesOrderPostAPi.deviceCode = AppConstant.ip;
    SalesOrderPostAPi.slpCode = AppConstant.slpCode;
    SalesOrderPostAPi.seriesType = newSeriesCode != null
        ? newSeriesCode!.toString()
        : newseries.isNotEmpty
            ? newseries[0].series.toString()
            : '';
    // newseries

    double getcreditLimit;

    List<Map<String, Object?>> getCashCust =
        await DBOperation.getMoreCstgroups(db, selectedcust!.cardCode!);
    if (getCashCust.isNotEmpty) {
      if (selectedcust!.cardCode.toString() ==
          getCashCust[0]['customerCode'].toString()) {
        SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
        callPostSalesOrderApi(
          context,
          theme,
          docEntry,
          docstatus,
          documentNum,
        );
        notifyListeners();
      }
    } else {
      GetBalanceCreditAPi.cardCode = selectedcust!.cardCode;
      await GetBalanceCreditAPi.getGlobalData().then((value) {
        if (value.balanceCreaditValue!.isNotEmpty) {
          getcreditLimit = value.balanceCreaditValue![0].CreditLimit!;
          callSaveApi(
            getcreditLimit,
            context,
            theme,
            docEntry,
            docstatus,
            documentNum,
          );
        } else if (value.balanceCreaditValue!.isEmpty) {
          callSaveApi(
            0.00,
            context,
            theme,
            docEntry,
            docstatus,
            documentNum,
          );
        }
      });
    }
  }

  void callSaveApi(
    double getCredit,
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    log("cpyfrmsqcpyfrmsq222::$cpyfrmsq");

    GettCreditDaysAPi.cardCode = selectedcust!.cardCode;
    GettCreditDaysAPi.date = config.currentDate();
    await GettCreditDaysAPi.getGlobalData().then((value) async {
      if (value.creaditDaysValueValue![0].CreditDays == 0) {
        await GetBalanceCreditAPi.getGlobalData().then((value) async {
          if (value.balanceCreaditValue!.isNotEmpty) {
            double? balance = value.balanceCreaditValue![0].Balance;
            double? creditLimit = value.balanceCreaditValue![0].CreditLimit;
            double? ordersBal = value.balanceCreaditValue![0].OrdersBal;
            double ans =
                creditLimit! - balance! - ordersBal! - totalPayment!.totalDue!;
            if (ans < 0) {
              PostOrderLoginAPi.username = 'solimitapp';
              PostOrderLoginAPi.password = '1234';
              await PostOrderLoginAPi.getGlobalData().then((valuel) {
                if (valuel.sessionId!.isNotEmpty) {
                  soLimit = true;
                  OrderPostAPi2.copyfromsq = cpyfrmsq;
                  OrderPostAPi2.sessionID = valuel.sessionId!;
                  callPostSalesOrderApi22(
                      context, docEntry, docstatus, documentNum);
                } else {
                  isLoading = false;
                  schemeApiLoad = false;
                }
              });
            } else {
              SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
              callPostSalesOrderApi(
                context,
                theme,
                docEntry,
                docstatus,
                documentNum,
              );
            }
          } else {
            SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
            callPostSalesOrderApi(
              context,
              theme,
              docEntry,
              docstatus,
              documentNum,
            );
          }
        });
      } else if (value.creaditDaysValueValue![0].CreditDays! > 0) {
        PostOrderLoginAPi.username = 'sodaysapp';
        PostOrderLoginAPi.password = '1234';

        await PostOrderLoginAPi.getGlobalData().then((valuel) {
          if (valuel.sessionId != null) {
            soDats = true;
            OrderPostAPi2.sessionID = valuel.sessionId!;
            AppConstant.sapSessionID = valuel.sessionId!;
            OrderPostAPi2.copyfromsq = cpyfrmsq;
            callPostSalesOrderApi22(context, docEntry, docstatus, documentNum);
          } else if (valuel.sessionId == null) {
            isLoading = false;
            schemeApiLoad = false;
          }
        });
      } else {
        SalesOrderPostAPi.sessionID = AppConstant.sapSessionID;
        callPostSalesOrderApi(
          context,
          theme,
          docEntry,
          docstatus,
          documentNum,
        );
      }
    });
  }

  static bool soLimit = false;
  static bool soDats = false;

  void callPostSalesOrderApi22(BuildContext context, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    await callSeriesApi(context, "17");

    OrderPostAPi2.cardCodePost = selectedcust!.cardCode;
    OrderPostAPi2.cardNamePost = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;
    OrderPostAPi2.docLineQout = itemsDocDetails;

    OrderPostAPi2.docDate = config.currentDate();
    OrderPostAPi2.dueDate = config.alignDate2(postingDatecontroller.text);
    OrderPostAPi2.tinNo = tinNoController.text;
    OrderPostAPi2.vatNo = vatNoController.text;
    OrderPostAPi2.remarks = remarkcontroller3.text;
    OrderPostAPi2.orderDate = config.alignDate2(udfController[2].text);
    OrderPostAPi2.orderType = valueSelectedOrder;
    OrderPostAPi2.gpApproval = valueSelectedGPApproval;
    OrderPostAPi2.orderTime = udfController[1].text;
    OrderPostAPi2.custREfNo = udfController[0].text;
    OrderPostAPi2.deviceTransID = uuiDeviceId!;

    OrderPostAPi2.deviceCode = AppConstant.ip;
    OrderPostAPi2.slpCode = AppConstant.slpCode;
    OrderPostAPi2.seriesType = newSeriesCode != null
        ? newSeriesCode!.toString()
        : newseries.isNotEmpty
            ? newseries[0].series.toString()
            : '';
    OrderPostAPi2.method(latitude!, longitude!);
    await OrderPostAPi2.getGlobalData(latitude!, longitude!)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        await DBOperation.updateSOrdercApprovalsts(db, docEntry.toString());

        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done, This document is saved as Approval Draft'
                    : docstatus == "save as order"
                        ? "Sales order successfully saved..!!, Document Number is $documentNum"
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
          udfClear();
          cpyfrmsq = false;
          onDisablebutton = true;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          paymentWay.clear();
          newShipAddrsValue = [];
          newBillAddrsValue = [];
          newCustValues = [];
          totalPayment = null;
          postingDatecontroller.text = '';
          custNameController.text = '';
          tinNoController.text = '';
          vatNoController.text = '';
          mycontroller[50].text = "";
          itemListDateCtrl = List.generate(200, (i) => TextEditingController());

          discountcontroller =
              List.generate(500, (i) => TextEditingController());
          mycontroller = List.generate(500, (i) => TextEditingController());
          qtymycontroller = List.generate(500, (i) => TextEditingController());
          remarkcontroller3.text = '';
          injectToDb();
          onDisablebutton = false;
          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await DBOperation.updateSOrdercErrorApprovalsts(
            db, docEntry.toString());
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          notifyListeners();
        });
        onDisablebutton = false;
      } else {
        await DBOperation.updateSOrdercErrorApprovalsts(
            db, docEntry.toString());
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          notifyListeners();
        });
      }
    });
  }

  void callPostSalesOrderApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await SalesOrderPostAPi.getGlobalData(latitude!, longitude!)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntry, 'SalesOrderHeader');
        if (cashType == 'Cash' ||
            chequeType == "Cheque" ||
            cardType == "Card" ||
            transferType == "Transfer" ||
            walletType == "Wallet" ||
            pointType == 'Points Redemption') {
          log("mycontroller[22].text:::$cashpayment");
        }
        log(docEntry.toString());
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done,\nS.O Document Number $sapDocuNumber'
                    : docstatus == "save as order"
                        ? "Sales order successfully saved..!!, Document Number $sapDocuNumber"
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
          udfClear();
          cpyfrmsq = false;
          onDisablebutton = true;
          selectedcust55 = null;
          postingDatecontroller.text = '';
          custNameController.text = '';
          tinNoController.text = '';
          vatNoController.text = '';
          itemListDateCtrl = List.generate(200, (i) => TextEditingController());

          selectedcust = null;
          scanneditemData.clear();
          schemebtnclk = false;
          cashAccCode = '';
          cardAcctype = '';
          cardAccCode = '';
          chequeAcctype = '';
          chequeAccCode = '';
          transAcctype = '';
          transAccCode = '';
          walletAcctype = '';
          walletAccCode = '';
          paymentWay.clear();
          newShipAddrsValue = [];
          sapReceiptDocNum = null;
          sapReceiptDocentry = null;
          newBillAddrsValue = [];
          newCustValues = [];
          selectbankCode = '';
          selectedBankType = null;
          bankhintcolor = false;
          totalPayment = null;
          mycontroller[50].text = "";
          cashpayment = 0;
          cqpayment = 0;
          transpayment = null;
          chqnum = 0;
          transrefff = '';
          cashType = '';
          creditType = '';
          cardType = '';
          chequeType = '';
          transferType = '';
          walletType = '';
          pointType = '';
          accType = '';
          discountcontroller =
              List.generate(500, (i) => TextEditingController());
          mycontroller = List.generate(500, (i) => TextEditingController());
          qtymycontroller = List.generate(500, (i) => TextEditingController());
          remarkcontroller3.text = '';

          injectToDb();
          if (docstatus == "check out") {
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          onDisablebutton = false;

          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          notifyListeners();
        });
        onDisablebutton = false;
      } else {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.error!.message!.value}",
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
          notifyListeners();
        });
      }
    });
  }

  callOrdPostApi(
    BuildContext context,
    ThemeData theme,
    int docEntry,
    String docstatus,
    String documentNum,
  ) async {
    log('message lat and long::$latitude:::$longitude');
    if (latitude != null && longitude != null) {
      await sapOrderLoginApi(
        context,
      );
      await validateAndCallApi(
          context, theme, docEntry, docstatus, documentNum);
      notifyListeners();
    } else {
      requestLocationPermission(context);

      onDisablebutton = false;
    }
  }

  clickaEditBtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getheaderData =
        await DBOperation.salesOrderCancellQuery(db, tbDocEntry.toString());
    if (getheaderData.isNotEmpty) {
      if (getheaderData[0]['basedocentry'].toString() ==
          tbDocEntry.toString()) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content:
                          'This document is already converted into sales invoice',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          cancelDocnum = '';
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust2 = null;
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          cancelbtn = false;
          selectedcust2 = null;
          selectedcust = null;
          scanneditemData2.clear();
          paymentWay2.clear();
          totalPayment2 = null;
          injectToDb();
          getdraftindex();
          mycontroller2[50].text = "";
          notifyListeners();
        });
      }
    } else if (sapDocentry.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong...!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        cancelDocnum = '';
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust2 = null;
        selectedcust25 = null;
        paymentWay2.clear();
        scanneditemData2.clear();
        cancelbtn = false;
        selectedcust2 = null;
        selectedcust = null;
        scanneditemData2.clear();
        paymentWay2.clear();
        totalPayment2 = null;
        injectToDb();
        getdraftindex();
        mycontroller2[50].text = "";
        notifyListeners();
      });
    } else {
      log('vvvvvvvvv');

      // await checkSAPsts(context, theme);
      checkSAPsts22(context, theme);

      notifyListeners();
    }
  }

  callClearBtn() {
    editqty = false;
    custNameController.text = '';
    tinNoController.text = '';
    itemListDateCtrl2 = List.generate(200, (i) => TextEditingController());
    vatNoController.text = '';
    selectedcust2 = null;
    selectedcust25 = null;
    scanneditemData2.clear();
    paymentWay2.clear();
    totalPayment2 = null;
    custList2.clear();
    injectToDb();
    getdraftindex();
    mycontroller2[50].text = "";
    cancelbtn = false;
    whsCode = null;
    whsName = null;
    newSeriesName = null;
    newSeriesCode = null;
    warehousectrl = List.generate(200, (i) => TextEditingController());
    // warehousectrl[0].text = '';
    notifyListeners();
  }

  checkSAPsts22(BuildContext context, ThemeData theme) async {
    log('scanned;itemData2:${selectedcust2!.docStatus}:${scanneditemData2.length}');
    if (scanneditemData2.isNotEmpty) {
      log('step1');

      if (selectedcust2!.docStatus == "O") {
        log('step12');

        for (var i = 0; i < scanneditemData2.length; i++) {
          log('scanneditemData2[$i].lineStatus::${scanneditemData2[i].lineStatus}');
          if (scanneditemData2[i].lineStatus == 'bost_Open') {
            await newUpdateFixDataMethod(context, theme);
          } else if (scanneditemData2[i].lineStatus == 'bost_Close') {
            cancelbtn = false;

            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: AlertBox(
                        payMent: 'Alert',
                        errormsg: true,
                        widget: Center(
                            child: ContentContainer(
                          content: 'Document is partially closed',
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {
              notifyListeners();
            });
            notifyListeners();
            break;
          }
        }
      } else if (selectedcust2!.docStatus == "C") {
        log('step13');

        cancelbtn = false;

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Document is already cancelled',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          notifyListeners();
        });
        notifyListeners();
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        notifyListeners();
      });
    }
  }

  checkSAPsts(BuildContext context, ThemeData theme) async {
    log('scanned;itemData2:${selectedcust2!.docStatus}:${scanneditemData2.length}');
    if (scanneditemData2.isNotEmpty) {
      log('step1');

      if (selectedcust2!.docStatus == "O") {
        log('step12');

        await newUpdateFixDataMethod(context, theme);
      } else if (selectedcust2!.docStatus == "C") {
        log('step13');

        cancelbtn = false;

        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  content: AlertBox(
                    payMent: 'Alert',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: 'Document is already cancelled',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          notifyListeners();
        });
        notifyListeners();
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        notifyListeners();
      });
    }
  }

  onClickUpdate(
    BuildContext context,
    ThemeData theme,
  ) async {
    onDisablebutton = true;
    if (selectedcust == null || scanneditemData.isEmpty) {
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
                    content: 'Choose Dcoument..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    } else {
      await updatechangecheckout(context, theme);
      notifyListeners();
    }
  }

  List<DocumentOrderLine> getdocumentOrderLine = [];
  GetOrderDetails? getOrderDetailss = GetOrderDetails();
  getOrderDetails(
    String sapDocEntry,
    BuildContext context,
  ) async {
    sapDocentry = '';
    await GetOrderDetailsAPI.getData(sapDocEntry).then((value) {
      getdocumentOrderLine = [];

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        print("sapDocentry: " + sapDocentry.toString());
        sapDocentry = value.docEntry.toString();
        getOrderDetailss = value;
        getdocumentOrderLine = value.documentLines!;
        log('getdocumentOrderLinegetdocumentOrderLine::${getdocumentOrderLine.length}');
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

  GetOrderDetails? orderputdataval = GetOrderDetails();
  List<DocumentOrderLine> getdocitemsDetailsData = [];

  delputHeaderValues() {
    getdocitemsDetailsData = [];
    scanneditemCheckUpdateData = [];
    orderputdataval = GetOrderDetails(
      odataMetadata: getOrderDetailss!.odataMetadata == null ||
              getOrderDetailss!.odataMetadata == "null"
          ? null
          : getOrderDetailss!.odataMetadata,
      odataEtag: getOrderDetailss!.odataEtag == null ||
              getOrderDetailss!.odataEtag == "null"
          ? null
          : getOrderDetailss!.odataEtag,
      docEntry: getOrderDetailss!.docEntry == null ||
              getOrderDetailss!.docEntry == "null"
          ? null
          : getOrderDetailss!.docEntry,
      docNum:
          getOrderDetailss!.docNum == null || getOrderDetailss!.docNum == "null"
              ? null
              : getOrderDetailss!.docNum,
      docType: getOrderDetailss!.docType == null ||
              getOrderDetailss!.docType == "null"
          ? null
          : getOrderDetailss!.docType,
      handWritten: getOrderDetailss!.handWritten == null ||
              getOrderDetailss!.handWritten == "null"
          ? null
          : getOrderDetailss!.handWritten,
      printed: getOrderDetailss!.printed == null ||
              getOrderDetailss!.printed == "null"
          ? null
          : getOrderDetailss!.printed,
      docDate: getOrderDetailss!.docDate == null ||
              getOrderDetailss!.docDate == "null"
          ? null
          : getOrderDetailss!.docDate,
      docDueDate: getOrderDetailss!.docDueDate == null ||
              getOrderDetailss!.docDueDate == "null"
          ? null
          : getOrderDetailss!.docDueDate,
      cardCode: getOrderDetailss!.cardCode == null ||
              getOrderDetailss!.cardCode == "null"
          ? null
          : getOrderDetailss!.cardCode,
      cardName: getOrderDetailss!.cardName == null ||
              getOrderDetailss!.cardName == "null"
          ? null
          : getOrderDetailss!.cardName,
      address: getOrderDetailss!.address == null ||
              getOrderDetailss!.address == "null"
          ? null
          : getOrderDetailss!.address,
      numAtCard: getOrderDetailss!.numAtCard == null ||
              getOrderDetailss!.numAtCard == "null"
          ? null
          : getOrderDetailss!.numAtCard,
      docTotal: getOrderDetailss!.docTotal == null ||
              getOrderDetailss!.docTotal == "null"
          ? null
          : getOrderDetailss!.docTotal,
      attachmentEntry: getOrderDetailss!.attachmentEntry == null ||
              getOrderDetailss!.attachmentEntry == "null"
          ? null
          : getOrderDetailss!.attachmentEntry,
      docCurrency: getOrderDetailss!.docCurrency == null ||
              getOrderDetailss!.docCurrency == "null"
          ? null
          : getOrderDetailss!.docCurrency,
      docRate: getOrderDetailss!.docRate == null ||
              getOrderDetailss!.docRate == "null"
          ? null
          : getOrderDetailss!.docRate,
      reference1: getOrderDetailss!.reference1 == null ||
              getOrderDetailss!.reference1 == "null"
          ? null
          : getOrderDetailss!.reference1,
      reference2: getOrderDetailss!.reference2 == null ||
              getOrderDetailss!.reference2 == "null"
          ? null
          : getOrderDetailss!.reference2,
      comments: getOrderDetailss!.comments == null ||
              getOrderDetailss!.comments == "null"
          ? null
          : getOrderDetailss!.comments,
      journalMemo: getOrderDetailss!.journalMemo == null ||
              getOrderDetailss!.journalMemo == "null"
          ? null
          : getOrderDetailss!.journalMemo,
      paymentGroupCode: getOrderDetailss!.paymentGroupCode == null ||
              getOrderDetailss!.paymentGroupCode == "null"
          ? null
          : getOrderDetailss!.paymentGroupCode,
      docTime: getOrderDetailss!.docTime == null ||
              getOrderDetailss!.docTime == "null"
          ? null
          : getOrderDetailss!.docTime,
      salesPersonCode: getOrderDetailss!.salesPersonCode == null ||
              getOrderDetailss!.salesPersonCode == "null"
          ? null
          : getOrderDetailss!.salesPersonCode,
      transportationCode: getOrderDetailss!.transportationCode == null ||
              getOrderDetailss!.transportationCode == "null"
          ? null
          : getOrderDetailss!.transportationCode,
      confirmed: getOrderDetailss!.confirmed == null ||
              getOrderDetailss!.confirmed == "null"
          ? null
          : getOrderDetailss!.confirmed,
      importFileNum: getOrderDetailss!.importFileNum == null ||
              getOrderDetailss!.importFileNum == "null"
          ? null
          : getOrderDetailss!.importFileNum!,
      summeryType: getOrderDetailss!.summeryType == null ||
              getOrderDetailss!.summeryType == "null"
          ? null
          : getOrderDetailss!.summeryType,
      contactPersonCode: getOrderDetailss!.contactPersonCode == null ||
              getOrderDetailss!.contactPersonCode == "null"
          ? null
          : getOrderDetailss!.contactPersonCode,
      showScn: getOrderDetailss!.showScn == null ||
              getOrderDetailss!.showScn == "null"
          ? null
          : getOrderDetailss!.showScn,
      series:
          getOrderDetailss!.series == null || getOrderDetailss!.series == "null"
              ? null
              : getOrderDetailss!.series,
      taxDate: getOrderDetailss!.taxDate == null ||
              getOrderDetailss!.taxDate == "null"
          ? null
          : getOrderDetailss!.taxDate,
      partialSupply: getOrderDetailss!.partialSupply == null ||
              getOrderDetailss!.partialSupply == "null"
          ? null
          : getOrderDetailss!.partialSupply,
      docObjectCode: getOrderDetailss!.docObjectCode == null ||
              getOrderDetailss!.docObjectCode == "null"
          ? null
          : getOrderDetailss!.docObjectCode,
      shipToCode: getOrderDetailss!.shipToCode == null ||
              getOrderDetailss!.shipToCode == "null"
          ? null
          : getOrderDetailss!.shipToCode,
      indicator: getOrderDetailss!.indicator == null ||
              getOrderDetailss!.indicator == "null"
          ? null
          : getOrderDetailss!.indicator,
      federalTaxId: getOrderDetailss!.federalTaxId == null ||
              getOrderDetailss!.federalTaxId == "null"
          ? null
          : getOrderDetailss!.federalTaxId,
      discountPercent: getOrderDetailss!.discountPercent == null ||
              getOrderDetailss!.discountPercent == "null"
          ? null
          : getOrderDetailss!.discountPercent,
      paymentReference: getOrderDetailss!.paymentReference == null ||
              getOrderDetailss!.paymentReference == "null"
          ? null
          : getOrderDetailss!.paymentReference,
      creationDate: getOrderDetailss!.creationDate == null ||
              getOrderDetailss!.creationDate == "null"
          ? null
          : getOrderDetailss!.creationDate,
      updateDate: getOrderDetailss!.updateDate == null ||
              getOrderDetailss!.updateDate == "null"
          ? null
          : getOrderDetailss!.updateDate,
      financialPeriod: getOrderDetailss!.financialPeriod == null ||
              getOrderDetailss!.financialPeriod == "null"
          ? null
          : getOrderDetailss!.financialPeriod,
      userSign: getOrderDetailss!.userSign == null ||
              getOrderDetailss!.userSign == "null"
          ? null
          : getOrderDetailss!.userSign,
      transNum: getOrderDetailss!.transNum == null ||
              getOrderDetailss!.transNum == "null"
          ? null
          : getOrderDetailss!.transNum,
      vatSum:
          getOrderDetailss!.vatSum == null || getOrderDetailss!.vatSum == "null"
              ? null
              : getOrderDetailss!.vatSum,
      vatSumSys: getOrderDetailss!.vatSumSys == null ||
              getOrderDetailss!.vatSumSys == "null"
          ? null
          : getOrderDetailss!.vatSumSys,
      vatSumFc: getOrderDetailss!.vatSumFc == null ||
              getOrderDetailss!.vatSumFc == "null"
          ? null
          : getOrderDetailss!.vatSumFc,
      netProcedure: getOrderDetailss!.netProcedure == null ||
              getOrderDetailss!.netProcedure == "null"
          ? null
          : getOrderDetailss!.netProcedure,
      docTotalFc: getOrderDetailss!.docTotalFc == null ||
              getOrderDetailss!.docTotalFc == "null"
          ? null
          : getOrderDetailss!.docTotalFc,
      docTotalSys: getOrderDetailss!.docTotalSys == null ||
              getOrderDetailss!.docTotalSys == "null"
          ? null
          : getOrderDetailss!.docTotalSys,
      form1099: getOrderDetailss!.form1099 == null ||
              getOrderDetailss!.form1099 == "null"
          ? null
          : getOrderDetailss!.form1099,
      box1099: getOrderDetailss!.box1099 == null ||
              getOrderDetailss!.box1099 == "null"
          ? null
          : getOrderDetailss!.box1099,
      revisionPo: getOrderDetailss!.revisionPo == null ||
              getOrderDetailss!.revisionPo == "null"
          ? null
          : getOrderDetailss!.revisionPo,
      requriedDate: getOrderDetailss!.requriedDate == null ||
              getOrderDetailss!.requriedDate == "null"
          ? null
          : getOrderDetailss!.requriedDate,
      cancelDate: getOrderDetailss!.cancelDate == null ||
              getOrderDetailss!.cancelDate == "null"
          ? null
          : getOrderDetailss!.cancelDate,
      blockDunning: getOrderDetailss!.blockDunning == null ||
              getOrderDetailss!.blockDunning == "null"
          ? null
          : getOrderDetailss!.blockDunning,
      submitted: getOrderDetailss!.submitted == null ||
              getOrderDetailss!.submitted == "null"
          ? null
          : getOrderDetailss!.submitted,
      segment: getOrderDetailss!.segment == null ||
              getOrderDetailss!.segment == "null"
          ? null
          : getOrderDetailss!.segment,
      pickStatus: getOrderDetailss!.pickStatus == null ||
              getOrderDetailss!.pickStatus == "null"
          ? null
          : getOrderDetailss!.pickStatus,
      pick: getOrderDetailss!.pick == null || getOrderDetailss!.pick == "null"
          ? null
          : getOrderDetailss!.pick,
      paymentMethod: getOrderDetailss!.paymentMethod == null ||
              getOrderDetailss!.paymentMethod == "null"
          ? null
          : getOrderDetailss!.paymentMethod,
      paymentBlock: getOrderDetailss!.paymentBlock == null ||
              getOrderDetailss!.paymentBlock == "null"
          ? null
          : getOrderDetailss!.paymentBlock,
      paymentBlockEntry: getOrderDetailss!.paymentBlockEntry == null ||
              getOrderDetailss!.paymentBlockEntry == "null"
          ? null
          : getOrderDetailss!.paymentBlockEntry,
      centralBankIndicator: getOrderDetailss!.centralBankIndicator == null ||
              getOrderDetailss!.centralBankIndicator == "null"
          ? null
          : getOrderDetailss!.centralBankIndicator,
      maximumCashDiscount: getOrderDetailss!.maximumCashDiscount == null ||
              getOrderDetailss!.maximumCashDiscount == "null"
          ? null
          : getOrderDetailss!.maximumCashDiscount,
      reserve: getOrderDetailss!.reserve == null ||
              getOrderDetailss!.reserve == "null"
          ? null
          : getOrderDetailss!.reserve,
      project: getOrderDetailss!.project == null ||
              getOrderDetailss!.project == "null"
          ? null
          : getOrderDetailss!.project,
      exemptionValidityDateFrom:
          getOrderDetailss!.exemptionValidityDateFrom == null ||
                  getOrderDetailss!.exemptionValidityDateFrom == "null"
              ? null
              : getOrderDetailss!.exemptionValidityDateFrom,
      exemptionValidityDateTo:
          getOrderDetailss!.exemptionValidityDateTo == null ||
                  getOrderDetailss!.exemptionValidityDateTo == "null"
              ? null
              : getOrderDetailss!.exemptionValidityDateTo,
      wareHouseUpdateType: getOrderDetailss!.wareHouseUpdateType == null ||
              getOrderDetailss!.wareHouseUpdateType == "null"
          ? null
          : getOrderDetailss!.wareHouseUpdateType,
      rounding: getOrderDetailss!.rounding == null ||
              getOrderDetailss!.rounding == "null"
          ? null
          : getOrderDetailss!.rounding,
      externalCorrectedDocNum:
          getOrderDetailss!.externalCorrectedDocNum == null ||
                  getOrderDetailss!.externalCorrectedDocNum == "null"
              ? null
              : getOrderDetailss!.externalCorrectedDocNum,
      internalCorrectedDocNum:
          getOrderDetailss!.internalCorrectedDocNum == null ||
                  getOrderDetailss!.internalCorrectedDocNum == "null"
              ? null
              : getOrderDetailss!.internalCorrectedDocNum,
      nextCorrectingDocument:
          getOrderDetailss!.nextCorrectingDocument == null ||
                  getOrderDetailss!.nextCorrectingDocument == "null"
              ? null
              : getOrderDetailss!.nextCorrectingDocument,
      deferredTax: getOrderDetailss!.deferredTax == null ||
              getOrderDetailss!.deferredTax == "null"
          ? null
          : getOrderDetailss!.deferredTax,
      taxExemptionLetterNum: getOrderDetailss!.taxExemptionLetterNum == null ||
              getOrderDetailss!.taxExemptionLetterNum == "null"
          ? null
          : getOrderDetailss!.taxExemptionLetterNum,
      wtApplied: getOrderDetailss!.wtApplied == null ||
              getOrderDetailss!.wtApplied == "null"
          ? null
          : getOrderDetailss!.wtApplied,
      wtAppliedFc: getOrderDetailss!.wtAppliedFc == null ||
              getOrderDetailss!.wtAppliedFc == "null"
          ? null
          : getOrderDetailss!.wtAppliedFc,
      billOfExchangeReserved:
          getOrderDetailss!.billOfExchangeReserved == null ||
                  getOrderDetailss!.billOfExchangeReserved == "null"
              ? null
              : getOrderDetailss!.billOfExchangeReserved,
      agentCode: getOrderDetailss!.agentCode == null ||
              getOrderDetailss!.agentCode == "null"
          ? null
          : getOrderDetailss!.agentCode,
      wtAppliedSc: getOrderDetailss!.wtAppliedSc == null ||
              getOrderDetailss!.wtAppliedSc == "null"
          ? null
          : getOrderDetailss!.wtAppliedSc,
      totalEqualizationTax: getOrderDetailss!.totalEqualizationTax == null ||
              getOrderDetailss!.totalEqualizationTax == "null"
          ? null
          : getOrderDetailss!.totalEqualizationTax,
      totalEqualizationTaxFc:
          getOrderDetailss!.totalEqualizationTaxFc == null ||
                  getOrderDetailss!.totalEqualizationTaxFc == "null"
              ? null
              : getOrderDetailss!.totalEqualizationTaxFc,
      totalEqualizationTaxSc:
          getOrderDetailss!.totalEqualizationTaxSc == null ||
                  getOrderDetailss!.totalEqualizationTaxSc == "null"
              ? null
              : getOrderDetailss!.totalEqualizationTaxSc,
      numberOfInstallments: getOrderDetailss!.numberOfInstallments == null ||
              getOrderDetailss!.numberOfInstallments == "null"
          ? null
          : getOrderDetailss!.numberOfInstallments,
      applyTaxOnFirstInstallment:
          getOrderDetailss!.applyTaxOnFirstInstallment == null ||
                  getOrderDetailss!.applyTaxOnFirstInstallment == "null"
              ? null
              : getOrderDetailss!.applyTaxOnFirstInstallment,
      wtNonSubjectAmount: getOrderDetailss!.wtNonSubjectAmount == null ||
              getOrderDetailss!.wtNonSubjectAmount == "null"
          ? null
          : getOrderDetailss!.wtNonSubjectAmount,
      wtNonSubjectAmountSc: getOrderDetailss!.wtNonSubjectAmountSc == null ||
              getOrderDetailss!.wtNonSubjectAmountSc == "null"
          ? null
          : getOrderDetailss!.wtNonSubjectAmountSc,
      wtNonSubjectAmountFc: getOrderDetailss!.wtNonSubjectAmountFc == null ||
              getOrderDetailss!.wtNonSubjectAmountFc == "null"
          ? null
          : getOrderDetailss!.wtNonSubjectAmountFc,
      wtExemptedAmount: getOrderDetailss!.wtExemptedAmount == null ||
              getOrderDetailss!.wtExemptedAmount == "null"
          ? null
          : getOrderDetailss!.wtExemptedAmount,
      wtExemptedAmountSc: getOrderDetailss!.wtExemptedAmountSc == null ||
              getOrderDetailss!.wtExemptedAmountSc == "null"
          ? null
          : getOrderDetailss!.wtExemptedAmountSc,
      wtExemptedAmountFc: getOrderDetailss!.wtExemptedAmountFc == null ||
              getOrderDetailss!.wtExemptedAmountFc == "null"
          ? null
          : getOrderDetailss!.wtExemptedAmountFc,
      baseAmount: getOrderDetailss!.baseAmount == null ||
              getOrderDetailss!.baseAmount == "null"
          ? null
          : getOrderDetailss!.baseAmount,
      baseAmountSc: getOrderDetailss!.baseAmountSc == null ||
              getOrderDetailss!.baseAmountSc == "null"
          ? null
          : getOrderDetailss!.baseAmountSc,
      baseAmountFc: getOrderDetailss!.baseAmountFc == null ||
              getOrderDetailss!.baseAmountFc == "null"
          ? null
          : getOrderDetailss!.baseAmountFc,
      wtAmount: getOrderDetailss!.wtAmount == null ||
              getOrderDetailss!.wtAmount == "null"
          ? null
          : getOrderDetailss!.wtAmount,
      wtAmountSc: getOrderDetailss!.wtAmountSc == null ||
              getOrderDetailss!.wtAmountSc == "null"
          ? null
          : getOrderDetailss!.wtAmountSc,
      wtAmountFc: getOrderDetailss!.wtAmountFc == null ||
              getOrderDetailss!.wtAmountFc == "null"
          ? null
          : getOrderDetailss!.wtAmountFc,
      vatDate: getOrderDetailss!.vatDate == null ||
              getOrderDetailss!.vatDate == "null"
          ? null
          : getOrderDetailss!.vatDate,
      documentsOwner: getOrderDetailss!.documentsOwner == null ||
              getOrderDetailss!.documentsOwner == "null"
          ? null
          : getOrderDetailss!.documentsOwner,
      folioPrefixString: getOrderDetailss!.folioPrefixString == null ||
              getOrderDetailss!.folioPrefixString == "null"
          ? null
          : getOrderDetailss!.folioPrefixString,
      folioNumber: getOrderDetailss!.folioNumber == null ||
              getOrderDetailss!.folioNumber == "null"
          ? null
          : getOrderDetailss!.folioNumber,
      documentSubType: getOrderDetailss!.documentSubType == null ||
              getOrderDetailss!.documentSubType == "null"
          ? null
          : getOrderDetailss!.documentSubType,
      bpChannelCode: getOrderDetailss!.bpChannelCode == null ||
              getOrderDetailss!.bpChannelCode == "null"
          ? null
          : getOrderDetailss!.bpChannelCode,
      bpChannelContact: getOrderDetailss!.bpChannelContact == null ||
              getOrderDetailss!.bpChannelContact == "null"
          ? null
          : getOrderDetailss!.bpChannelContact,
      address2: getOrderDetailss!.address2 == null ||
              getOrderDetailss!.address2 == "null"
          ? null
          : getOrderDetailss!.address2,
      documentStatus: getOrderDetailss!.documentStatus == null ||
              getOrderDetailss!.documentStatus == "null"
          ? null
          : getOrderDetailss!.documentStatus,
      periodIndicator: getOrderDetailss!.periodIndicator == null ||
              getOrderDetailss!.periodIndicator == "null"
          ? null
          : getOrderDetailss!.periodIndicator,
      payToCode: getOrderDetailss!.payToCode == null ||
              getOrderDetailss!.payToCode == "null"
          ? null
          : getOrderDetailss!.payToCode,
      manualNumber: getOrderDetailss!.manualNumber == null ||
              getOrderDetailss!.manualNumber == "null"
          ? null
          : getOrderDetailss!.manualNumber,
      useShpdGoodsAct: getOrderDetailss!.useShpdGoodsAct == null ||
              getOrderDetailss!.useShpdGoodsAct == "null"
          ? null
          : getOrderDetailss!.useShpdGoodsAct,
      isPayToBank: getOrderDetailss!.isPayToBank == null ||
              getOrderDetailss!.isPayToBank == "null"
          ? null
          : getOrderDetailss!.isPayToBank,
      payToBankCountry: getOrderDetailss!.payToBankCountry == null ||
              getOrderDetailss!.payToBankCountry == "null"
          ? null
          : getOrderDetailss!.payToBankCountry,
      payToBankCode: getOrderDetailss!.payToBankCode == null ||
              getOrderDetailss!.payToBankCode == "null"
          ? null
          : getOrderDetailss!.payToBankCode,
      payToBankAccountNo: getOrderDetailss!.payToBankAccountNo == null ||
              getOrderDetailss!.payToBankAccountNo == "null"
          ? null
          : getOrderDetailss!.payToBankAccountNo,
      payToBankBranch: getOrderDetailss!.payToBankBranch == null ||
              getOrderDetailss!.payToBankBranch == "null"
          ? null
          : getOrderDetailss!.payToBankBranch,
      bplIdAssignedToInvoice:
          getOrderDetailss!.bplIdAssignedToInvoice == null ||
                  getOrderDetailss!.bplIdAssignedToInvoice == "null"
              ? null
              : getOrderDetailss!.bplIdAssignedToInvoice,
      downPayment: getOrderDetailss!.downPayment == null ||
              getOrderDetailss!.downPayment == "null"
          ? null
          : getOrderDetailss!.downPayment,
      reserveInvoice: getOrderDetailss!.reserveInvoice == null ||
              getOrderDetailss!.reserveInvoice == "null"
          ? null
          : getOrderDetailss!.reserveInvoice,
      languageCode: getOrderDetailss!.languageCode == null ||
              getOrderDetailss!.languageCode == "null"
          ? null
          : getOrderDetailss!.languageCode,
      trackingNumber: getOrderDetailss!.trackingNumber == null ||
              getOrderDetailss!.trackingNumber == "null"
          ? null
          : getOrderDetailss!.trackingNumber,
      pickRemark: getOrderDetailss!.pickRemark == null ||
              getOrderDetailss!.pickRemark == "null"
          ? null
          : getOrderDetailss!.pickRemark,
      closingDate: getOrderDetailss!.closingDate == null ||
              getOrderDetailss!.closingDate == "null"
          ? null
          : getOrderDetailss!.closingDate,
      sequenceCode: getOrderDetailss!.sequenceCode == null ||
              getOrderDetailss!.sequenceCode == "null"
          ? null
          : getOrderDetailss!.sequenceCode,
      sequenceSerial: getOrderDetailss!.sequenceSerial == null ||
              getOrderDetailss!.sequenceSerial == "null"
          ? null
          : getOrderDetailss!.sequenceSerial,
      seriesString: getOrderDetailss!.seriesString == null ||
              getOrderDetailss!.seriesString == "null"
          ? null
          : getOrderDetailss!.seriesString,
      subSeriesString: getOrderDetailss!.subSeriesString == null ||
              getOrderDetailss!.subSeriesString == "null"
          ? null
          : getOrderDetailss!.subSeriesString,
      sequenceModel: getOrderDetailss!.sequenceModel == null ||
              getOrderDetailss!.sequenceModel == "null"
          ? null
          : getOrderDetailss!.sequenceModel,
      useCorrectionVatGroup: getOrderDetailss!.useCorrectionVatGroup == null ||
              getOrderDetailss!.useCorrectionVatGroup == "null"
          ? null
          : getOrderDetailss!.useCorrectionVatGroup,
      totalDiscount: getOrderDetailss!.totalDiscount == null ||
              getOrderDetailss!.totalDiscount == "null"
          ? null
          : getOrderDetailss!.totalDiscount,
      downPaymentAmount: getOrderDetailss!.downPaymentAmount == null ||
              getOrderDetailss!.downPaymentAmount == "null"
          ? null
          : getOrderDetailss!.downPaymentAmount,
      downPaymentPercentage: getOrderDetailss!.downPaymentPercentage == null ||
              getOrderDetailss!.downPaymentPercentage == "null"
          ? null
          : getOrderDetailss!.downPaymentPercentage,
      downPaymentType: getOrderDetailss!.downPaymentType == null ||
              getOrderDetailss!.downPaymentType == "null"
          ? null
          : getOrderDetailss!.downPaymentType,
      downPaymentAmountSc: getOrderDetailss!.downPaymentAmountSc == null ||
              getOrderDetailss!.downPaymentAmountSc == "null"
          ? null
          : getOrderDetailss!.downPaymentAmountSc,
      downPaymentAmountFc: getOrderDetailss!.downPaymentAmountFc == null ||
              getOrderDetailss!.downPaymentAmountFc == "null"
          ? null
          : getOrderDetailss!.downPaymentAmountFc,
      vatPercent: getOrderDetailss!.vatPercent == null ||
              getOrderDetailss!.vatPercent == "null"
          ? null
          : getOrderDetailss!.vatPercent,
      serviceGrossProfitPercent:
          getOrderDetailss!.serviceGrossProfitPercent == null ||
                  getOrderDetailss!.serviceGrossProfitPercent == "null"
              ? null
              : getOrderDetailss!.serviceGrossProfitPercent,
      openingRemarks: getOrderDetailss!.openingRemarks == null ||
              getOrderDetailss!.openingRemarks == "null"
          ? null
          : getOrderDetailss!.openingRemarks,
      closingRemarks: getOrderDetailss!.closingRemarks == null ||
              getOrderDetailss!.closingRemarks == "null"
          ? null
          : getOrderDetailss!.closingRemarks,
      cancelled: getOrderDetailss!.cancelled == null ||
              getOrderDetailss!.cancelled == "null"
          ? null
          : getOrderDetailss!.cancelled,
      signatureInputMessage: getOrderDetailss!.signatureInputMessage == null ||
              getOrderDetailss!.signatureInputMessage == "null"
          ? null
          : getOrderDetailss!.signatureInputMessage,
      signatureDigest: getOrderDetailss!.signatureDigest == null ||
              getOrderDetailss!.signatureDigest == "null"
          ? null
          : getOrderDetailss!.signatureDigest,
      certificationNumber: getOrderDetailss!.certificationNumber == null ||
              getOrderDetailss!.certificationNumber == "null"
          ? null
          : getOrderDetailss!.certificationNumber,
      privateKeyVersion: getOrderDetailss!.privateKeyVersion == null ||
              getOrderDetailss!.privateKeyVersion == "null"
          ? null
          : getOrderDetailss!.privateKeyVersion,
      controlAccount: getOrderDetailss!.controlAccount == null ||
              getOrderDetailss!.controlAccount == "null"
          ? null
          : getOrderDetailss!.controlAccount,
      insuranceOperation347: getOrderDetailss!.insuranceOperation347 == null ||
              getOrderDetailss!.insuranceOperation347 == "null"
          ? null
          : getOrderDetailss!.insuranceOperation347,
      archiveNonremovableSalesQuotation:
          getOrderDetailss!.archiveNonremovableSalesQuotation == null ||
                  getOrderDetailss!.archiveNonremovableSalesQuotation == "null"
              ? null
              : getOrderDetailss!.archiveNonremovableSalesQuotation,
      gtsChecker: getOrderDetailss!.gtsChecker == null ||
              getOrderDetailss!.gtsChecker == "null"
          ? null
          : getOrderDetailss!.gtsChecker,
      gtsPayee: getOrderDetailss!.gtsPayee == null ||
              getOrderDetailss!.gtsPayee == "null"
          ? null
          : getOrderDetailss!.gtsPayee,
      extraMonth: getOrderDetailss!.extraMonth == null ||
              getOrderDetailss!.extraMonth == "null"
          ? null
          : getOrderDetailss!.extraMonth,
      extraDays: getOrderDetailss!.extraDays == null ||
              getOrderDetailss!.extraDays == "null"
          ? null
          : getOrderDetailss!.extraDays,
      cashDiscountDateOffset:
          getOrderDetailss!.cashDiscountDateOffset == null ||
                  getOrderDetailss!.cashDiscountDateOffset == "null"
              ? null
              : getOrderDetailss!.cashDiscountDateOffset,
      startFrom: getOrderDetailss!.startFrom == null ||
              getOrderDetailss!.startFrom == "null"
          ? null
          : getOrderDetailss!.startFrom,
      ntsApproved: getOrderDetailss!.ntsApproved == null ||
              getOrderDetailss!.ntsApproved == "null"
          ? null
          : getOrderDetailss!.ntsApproved,
      eTaxWebSite: getOrderDetailss!.eTaxWebSite == null ||
              getOrderDetailss!.eTaxWebSite == "null"
          ? null
          : getOrderDetailss!.eTaxWebSite,
      eTaxNumber: getOrderDetailss!.eTaxNumber == null ||
              getOrderDetailss!.eTaxNumber == "null"
          ? null
          : getOrderDetailss!.eTaxNumber,
      ntsApprovedNumber: getOrderDetailss!.ntsApprovedNumber == null ||
              getOrderDetailss!.ntsApprovedNumber == "null"
          ? null
          : getOrderDetailss!.ntsApprovedNumber,
      eDocGenerationType: getOrderDetailss!.eDocGenerationType == null ||
              getOrderDetailss!.eDocGenerationType == "null"
          ? null
          : getOrderDetailss!.eDocGenerationType,
      eDocSeries: getOrderDetailss!.eDocSeries == null ||
              getOrderDetailss!.eDocSeries == "null"
          ? null
          : getOrderDetailss!.eDocSeries,
      eDocNum: getOrderDetailss!.eDocNum == null ||
              getOrderDetailss!.eDocNum == "null"
          ? null
          : getOrderDetailss!.eDocNum,
      eDocExportFormat: getOrderDetailss!.eDocExportFormat == null ||
              getOrderDetailss!.eDocExportFormat == "null"
          ? null
          : getOrderDetailss!.eDocExportFormat,
      eDocStatus: getOrderDetailss!.eDocStatus == null ||
              getOrderDetailss!.eDocStatus == "null"
          ? null
          : getOrderDetailss!.eDocStatus,
      eDocErrorCode: getOrderDetailss!.eDocErrorCode == null ||
              getOrderDetailss!.eDocErrorCode == "null"
          ? null
          : getOrderDetailss!.eDocErrorCode,
      eDocErrorMessage: getOrderDetailss!.eDocErrorMessage == null ||
              getOrderDetailss!.eDocErrorMessage == "null"
          ? null
          : getOrderDetailss!.eDocErrorMessage,
      downPaymentStatus: getOrderDetailss!.downPaymentStatus == null ||
              getOrderDetailss!.downPaymentStatus == "null"
          ? null
          : getOrderDetailss!.downPaymentStatus,
      groupSeries: getOrderDetailss!.groupSeries == null ||
              getOrderDetailss!.groupSeries == "null"
          ? null
          : getOrderDetailss!.groupSeries,
      groupNumber: getOrderDetailss!.groupNumber == null ||
              getOrderDetailss!.groupNumber == "null"
          ? null
          : getOrderDetailss!.groupNumber,
      groupHandWritten: getOrderDetailss!.groupHandWritten == null ||
              getOrderDetailss!.groupHandWritten == "null"
          ? null
          : getOrderDetailss!.groupHandWritten,
      reopenOriginalDocument:
          getOrderDetailss!.reopenOriginalDocument == null ||
                  getOrderDetailss!.reopenOriginalDocument == "null"
              ? null
              : getOrderDetailss!.reopenOriginalDocument,
      reopenManuallyClosedOrCanceledDocument:
          getOrderDetailss!.reopenManuallyClosedOrCanceledDocument == null ||
                  getOrderDetailss!.reopenManuallyClosedOrCanceledDocument ==
                      "null"
              ? null
              : getOrderDetailss!.reopenManuallyClosedOrCanceledDocument,
      createOnlineQuotation: getOrderDetailss!.createOnlineQuotation == null ||
              getOrderDetailss!.createOnlineQuotation == "null"
          ? null
          : getOrderDetailss!.createOnlineQuotation,
      posEquipmentNumber: getOrderDetailss!.posEquipmentNumber == null ||
              getOrderDetailss!.posEquipmentNumber == "null"
          ? null
          : getOrderDetailss!.posEquipmentNumber,
      posManufacturerSerialNumber:
          getOrderDetailss!.posManufacturerSerialNumber == null ||
                  getOrderDetailss!.posManufacturerSerialNumber == "null"
              ? null
              : getOrderDetailss!.posManufacturerSerialNumber,
      posCashierNumber: getOrderDetailss!.posCashierNumber == null ||
              getOrderDetailss!.posCashierNumber == "null"
          ? null
          : getOrderDetailss!.posCashierNumber,
      applyCurrentVatRatesForDownPaymentsToDraw:
          getOrderDetailss!.applyCurrentVatRatesForDownPaymentsToDraw == null ||
                  getOrderDetailss!.applyCurrentVatRatesForDownPaymentsToDraw ==
                      "null"
              ? null
              : getOrderDetailss!.applyCurrentVatRatesForDownPaymentsToDraw,
      closingOption: getOrderDetailss!.closingOption == null ||
              getOrderDetailss!.closingOption == "null"
          ? null
          : getOrderDetailss!.closingOption,
      specifiedClosingDate: getOrderDetailss!.specifiedClosingDate == null ||
              getOrderDetailss!.specifiedClosingDate == "null"
          ? null
          : getOrderDetailss!.specifiedClosingDate,
      openForLandedCosts: getOrderDetailss!.openForLandedCosts == null ||
              getOrderDetailss!.openForLandedCosts == "null"
          ? null
          : getOrderDetailss!.openForLandedCosts,
      authorizationStatus: getOrderDetailss!.authorizationStatus == null ||
              getOrderDetailss!.authorizationStatus == "null"
          ? null
          : getOrderDetailss!.authorizationStatus,
      totalDiscountFc: getOrderDetailss!.totalDiscountFc == null ||
              getOrderDetailss!.totalDiscountFc == "null"
          ? null
          : getOrderDetailss!.totalDiscountFc,
      totalDiscountSc: getOrderDetailss!.totalDiscountSc == null ||
              getOrderDetailss!.totalDiscountSc == "null"
          ? null
          : getOrderDetailss!.totalDiscountSc,
      relevantToGts: getOrderDetailss!.relevantToGts == null ||
              getOrderDetailss!.relevantToGts == "null"
          ? null
          : getOrderDetailss!.relevantToGts,
      bplName: getOrderDetailss!.bplName == null ||
              getOrderDetailss!.bplName == "null"
          ? null
          : getOrderDetailss!.bplName,
      vatRegNum: getOrderDetailss!.vatRegNum == null ||
              getOrderDetailss!.vatRegNum == "null"
          ? null
          : getOrderDetailss!.vatRegNum,
      annualInvoiceDeclarationReference:
          getOrderDetailss!.annualInvoiceDeclarationReference == null ||
                  getOrderDetailss!.annualInvoiceDeclarationReference == "null"
              ? null
              : getOrderDetailss!.annualInvoiceDeclarationReference,
      supplier: getOrderDetailss!.supplier == null ||
              getOrderDetailss!.supplier == "null"
          ? null
          : getOrderDetailss!.supplier,
      releaser: getOrderDetailss!.releaser == null ||
              getOrderDetailss!.releaser == "null"
          ? null
          : getOrderDetailss!.releaser,
      receiver: getOrderDetailss!.receiver == null ||
              getOrderDetailss!.receiver == "null"
          ? null
          : getOrderDetailss!.receiver,
      blanketAgreementNumber:
          getOrderDetailss!.blanketAgreementNumber == null ||
                  getOrderDetailss!.blanketAgreementNumber == "null"
              ? null
              : getOrderDetailss!.blanketAgreementNumber,
      isAlteration: getOrderDetailss!.isAlteration == null ||
              getOrderDetailss!.isAlteration == "null"
          ? null
          : getOrderDetailss!.isAlteration,
      cancelStatus: getOrderDetailss!.cancelStatus == null ||
              getOrderDetailss!.cancelStatus == "null"
          ? null
          : getOrderDetailss!.cancelStatus,
      assetValueDate: getOrderDetailss!.assetValueDate == null ||
              getOrderDetailss!.assetValueDate == "null"
          ? null
          : getOrderDetailss!.assetValueDate,
      documentDelivery: getOrderDetailss!.documentDelivery == null ||
              getOrderDetailss!.documentDelivery == "null"
          ? null
          : getOrderDetailss!.documentDelivery,
      authorizationCode: getOrderDetailss!.authorizationCode == null ||
              getOrderDetailss!.authorizationCode == "null"
          ? null
          : getOrderDetailss!.authorizationCode,
      startDeliveryDate: getOrderDetailss!.startDeliveryDate == null ||
              getOrderDetailss!.startDeliveryDate == "null"
          ? null
          : getOrderDetailss!.startDeliveryDate,
      startDeliveryTime: getOrderDetailss!.startDeliveryTime == null ||
              getOrderDetailss!.startDeliveryTime == "null"
          ? null
          : getOrderDetailss!.startDeliveryTime,
      endDeliveryDate: getOrderDetailss!.endDeliveryDate == null ||
              getOrderDetailss!.endDeliveryDate == "null"
          ? null
          : getOrderDetailss!.endDeliveryDate,
      endDeliveryTime: getOrderDetailss!.endDeliveryTime == null ||
              getOrderDetailss!.endDeliveryTime == "null"
          ? null
          : getOrderDetailss!.endDeliveryTime,
      vehiclePlate: getOrderDetailss!.vehiclePlate == null ||
              getOrderDetailss!.vehiclePlate == "null"
          ? null
          : getOrderDetailss!.vehiclePlate,
      atDocumentType: getOrderDetailss!.atDocumentType == null ||
              getOrderDetailss!.atDocumentType == "null"
          ? null
          : getOrderDetailss!.atDocumentType,
      elecCommStatus: getOrderDetailss!.elecCommStatus == null ||
              getOrderDetailss!.elecCommStatus == "null"
          ? null
          : getOrderDetailss!.elecCommStatus,
      elecCommMessage: getOrderDetailss!.elecCommMessage == null ||
              getOrderDetailss!.elecCommMessage == "null"
          ? null
          : getOrderDetailss!.elecCommMessage,
      reuseDocumentNum: getOrderDetailss!.reuseDocumentNum == null ||
              getOrderDetailss!.reuseDocumentNum == "null"
          ? null
          : getOrderDetailss!.reuseDocumentNum,
      reuseNotaFiscalNum: getOrderDetailss!.reuseNotaFiscalNum == null ||
              getOrderDetailss!.reuseNotaFiscalNum == "null"
          ? null
          : getOrderDetailss!.reuseNotaFiscalNum,
      printSepaDirect: getOrderDetailss!.printSepaDirect == null ||
              getOrderDetailss!.printSepaDirect == "null"
          ? null
          : getOrderDetailss!.printSepaDirect,
      fiscalDocNum: getOrderDetailss!.fiscalDocNum == null ||
              getOrderDetailss!.fiscalDocNum == "null"
          ? null
          : getOrderDetailss!.fiscalDocNum,
      posDailySummaryNo: getOrderDetailss!.posDailySummaryNo == null ||
              getOrderDetailss!.posDailySummaryNo == "null"
          ? null
          : getOrderDetailss!.posDailySummaryNo,
      posReceiptNo: getOrderDetailss!.posReceiptNo == null ||
              getOrderDetailss!.posReceiptNo == "null"
          ? null
          : getOrderDetailss!.posReceiptNo,
      pointOfIssueCode: getOrderDetailss!.pointOfIssueCode == null ||
              getOrderDetailss!.pointOfIssueCode == "null"
          ? null
          : getOrderDetailss!.pointOfIssueCode,
      letter:
          getOrderDetailss!.letter == null || getOrderDetailss!.letter == "null"
              ? null
              : getOrderDetailss!.letter,
      folioNumberFrom: getOrderDetailss!.folioNumberFrom == null ||
              getOrderDetailss!.folioNumberFrom == "null"
          ? null
          : getOrderDetailss!.folioNumberFrom,
      folioNumberTo: getOrderDetailss!.folioNumberTo == null ||
              getOrderDetailss!.folioNumberTo == "null"
          ? null
          : getOrderDetailss!.folioNumberTo,
      interimType: getOrderDetailss!.interimType == null ||
              getOrderDetailss!.interimType == "null"
          ? null
          : getOrderDetailss!.interimType,
      relatedType: getOrderDetailss!.relatedType == null ||
              getOrderDetailss!.relatedType == "null"
          ? null
          : getOrderDetailss!.relatedType,
      relatedEntry: getOrderDetailss!.relatedEntry == null ||
              getOrderDetailss!.relatedEntry == "null"
          ? null
          : getOrderDetailss!.relatedEntry,
      sapPassport: getOrderDetailss!.sapPassport == null ||
              getOrderDetailss!.sapPassport == "null"
          ? null
          : getOrderDetailss!.sapPassport,
      documentTaxId: getOrderDetailss!.documentTaxId == null ||
              getOrderDetailss!.documentTaxId == "null"
          ? null
          : getOrderDetailss!.documentTaxId,
      dateOfReportingControlStatementVat:
          getOrderDetailss!.dateOfReportingControlStatementVat == null ||
                  getOrderDetailss!.dateOfReportingControlStatementVat == "null"
              ? null
              : getOrderDetailss!.dateOfReportingControlStatementVat,
      reportingSectionControlStatementVat:
          getOrderDetailss!.reportingSectionControlStatementVat == null ||
                  getOrderDetailss!.reportingSectionControlStatementVat ==
                      "null"
              ? null
              : getOrderDetailss!.reportingSectionControlStatementVat,
      excludeFromTaxReportControlStatementVat:
          getOrderDetailss!.excludeFromTaxReportControlStatementVat == null ||
                  getOrderDetailss!.excludeFromTaxReportControlStatementVat ==
                      "null"
              ? null
              : getOrderDetailss!.excludeFromTaxReportControlStatementVat,
      posCashRegister: getOrderDetailss!.posCashRegister == null ||
              getOrderDetailss!.posCashRegister == "null"
          ? null
          : getOrderDetailss!.posCashRegister,
      updateTime: getOrderDetailss!.updateTime == null ||
              getOrderDetailss!.updateTime == "null"
          ? null
          : getOrderDetailss!.updateTime,
      createQrCodeFrom: getOrderDetailss!.createQrCodeFrom == null ||
              getOrderDetailss!.createQrCodeFrom == "null"
          ? null
          : getOrderDetailss!.createQrCodeFrom,
      priceMode: getOrderDetailss!.priceMode == null ||
              getOrderDetailss!.priceMode == "null"
          ? null
          : getOrderDetailss!.priceMode,
      shipFrom: getOrderDetailss!.shipFrom == null ||
              getOrderDetailss!.shipFrom == "null"
          ? null
          : getOrderDetailss!.shipFrom,
      commissionTrade: getOrderDetailss!.commissionTrade == null ||
              getOrderDetailss!.commissionTrade == "null"
          ? null
          : getOrderDetailss!.commissionTrade,
      commissionTradeReturn: getOrderDetailss!.commissionTradeReturn == null ||
              getOrderDetailss!.commissionTradeReturn == "null"
          ? null
          : getOrderDetailss!.commissionTradeReturn,
      useBillToAddrToDetermineTax:
          getOrderDetailss!.useBillToAddrToDetermineTax == null ||
                  getOrderDetailss!.useBillToAddrToDetermineTax == "null"
              ? null
              : getOrderDetailss!.useBillToAddrToDetermineTax,
      cig: getOrderDetailss!.cig == null || getOrderDetailss!.cig == "null"
          ? null
          : getOrderDetailss!.cig,
      cup: getOrderDetailss!.cup == null || getOrderDetailss!.cup == "null"
          ? null
          : getOrderDetailss!.cup,
      fatherCard: getOrderDetailss!.fatherCard == null ||
              getOrderDetailss!.fatherCard == "null"
          ? null
          : getOrderDetailss!.fatherCard,
      fatherType: getOrderDetailss!.fatherType == null ||
              getOrderDetailss!.fatherType == "null"
          ? null
          : getOrderDetailss!.fatherType,
      shipState: getOrderDetailss!.shipState == null ||
              getOrderDetailss!.shipState == "null"
          ? null
          : getOrderDetailss!.shipState,
      shipPlace: getOrderDetailss!.shipPlace == null ||
              getOrderDetailss!.shipPlace == "null"
          ? null
          : getOrderDetailss!.shipPlace,
      custOffice: getOrderDetailss!.custOffice == null ||
              getOrderDetailss!.custOffice == "null"
          ? null
          : getOrderDetailss!.custOffice,
      fci: getOrderDetailss!.fci == null || getOrderDetailss!.fci == "null"
          ? null
          : getOrderDetailss!.fci,
      addLegIn: getOrderDetailss!.addLegIn == null ||
              getOrderDetailss!.addLegIn == "null"
          ? null
          : getOrderDetailss!.addLegIn,
      legTextF: getOrderDetailss!.legTextF == null ||
              getOrderDetailss!.legTextF == "null"
          ? null
          : getOrderDetailss!.legTextF,
      danfeLgTxt: getOrderDetailss!.danfeLgTxt == null ||
              getOrderDetailss!.danfeLgTxt == "null"
          ? null
          : getOrderDetailss!.danfeLgTxt,
      indFinal: getOrderDetailss!.indFinal == null ||
              getOrderDetailss!.indFinal == "null"
          ? null
          : getOrderDetailss!.indFinal,
      dataVersion: getOrderDetailss!.dataVersion == null ||
              getOrderDetailss!.dataVersion == "null"
          ? null
          : getOrderDetailss!.dataVersion,
      uPurchaseType: getOrderDetailss!.uPurchaseType == null ||
              getOrderDetailss!.uPurchaseType == "null"
          ? null
          : getOrderDetailss!.uPurchaseType,
      uApApprove: getOrderDetailss!.uApApprove == null ||
              getOrderDetailss!.uApApprove == "null"
          ? null
          : getOrderDetailss!.uApApprove,
      uFinalDel: getOrderDetailss!.uFinalDel == null ||
              getOrderDetailss!.uFinalDel == "null"
          ? null
          : getOrderDetailss!.uFinalDel,
      uIncoTerms: getOrderDetailss!.uIncoTerms == null ||
              getOrderDetailss!.uIncoTerms == "null"
          ? null
          : getOrderDetailss!.uIncoTerms,
      uSourceDest: getOrderDetailss!.uSourceDest == null ||
              getOrderDetailss!.uSourceDest == "null"
          ? null
          : getOrderDetailss!.uSourceDest,
      uTransNo: getOrderDetailss!.uTransNo == null ||
              getOrderDetailss!.uTransNo == "null"
          ? null
          : getOrderDetailss!.uTransNo,
      uVehicleNo: getOrderDetailss!.uVehicleNo == null ||
              getOrderDetailss!.uVehicleNo == "null"
          ? null
          : getOrderDetailss!.uVehicleNo,
      uSupplierDt: getOrderDetailss!.uSupplierDt == null ||
              getOrderDetailss!.uSupplierDt == "null"
          ? null
          : getOrderDetailss!.uSupplierDt,
      uQuotNo: getOrderDetailss!.uQuotNo == null ||
              getOrderDetailss!.uQuotNo == "null"
          ? null
          : getOrderDetailss!.uQuotNo,
      uQuotDate: getOrderDetailss!.uQuotDate == null ||
              getOrderDetailss!.uQuotDate == "null"
          ? null
          : getOrderDetailss!.uQuotDate,
      uGovPermit: getOrderDetailss!.uGovPermit == null ||
              getOrderDetailss!.uGovPermit == "null"
          ? null
          : getOrderDetailss!.uGovPermit,
      uGovPermitdt: getOrderDetailss!.uGovPermitdt == null ||
              getOrderDetailss!.uGovPermitdt == "null"
          ? null
          : getOrderDetailss!.uGovPermitdt,
      uCheckNo: getOrderDetailss!.uCheckNo == null ||
              getOrderDetailss!.uCheckNo == "null"
          ? null
          : getOrderDetailss!.uCheckNo,
      uCheckDate: getOrderDetailss!.uCheckDate == null ||
              getOrderDetailss!.uCheckDate == "null"
          ? null
          : getOrderDetailss!.uCheckDate,
      uApprovalDate: getOrderDetailss!.uApprovalDate == null ||
              getOrderDetailss!.uApprovalDate == "null"
          ? null
          : getOrderDetailss!.uApprovalDate,
      uOrderNoRecd: getOrderDetailss!.uOrderNoRecd == null ||
              getOrderDetailss!.uOrderNoRecd == "null"
          ? null
          : getOrderDetailss!.uOrderNoRecd,
      uOrderDate: getOrderDetailss!.uOrderDate == null ||
              getOrderDetailss!.uOrderDate == "null"
          ? null
          : getOrderDetailss!.uOrderDate,
      uClearingAgent: getOrderDetailss!.uClearingAgent == null ||
              getOrderDetailss!.uClearingAgent == "null"
          ? null
          : getOrderDetailss!.uClearingAgent,
      uDateSubAgent: getOrderDetailss!.uDateSubAgent == null ||
              getOrderDetailss!.uDateSubAgent == "null"
          ? null
          : getOrderDetailss!.uDateSubAgent,
      uIdfno:
          getOrderDetailss!.uIdfno == null || getOrderDetailss!.uIdfno == "null"
              ? null
              : getOrderDetailss!.uIdfno,
      uIdfDate: getOrderDetailss!.uIdfDate == null ||
              getOrderDetailss!.uIdfDate == "null"
          ? null
          : getOrderDetailss!.uIdfDate,
      uInspectionNo: getOrderDetailss!.uInspectionNo == null ||
              getOrderDetailss!.uInspectionNo == "null"
          ? null
          : getOrderDetailss!.uInspectionNo,
      uEta: getOrderDetailss!.uEta == null || getOrderDetailss!.uEta == "null"
          ? null
          : getOrderDetailss!.uEta,
      uAirwayBillNo: getOrderDetailss!.uAirwayBillNo == null ||
              getOrderDetailss!.uAirwayBillNo == "null"
          ? null
          : getOrderDetailss!.uAirwayBillNo,
      uBol: getOrderDetailss!.uBol == null || getOrderDetailss!.uBol == "null"
          ? null
          : getOrderDetailss!.uBol,
      uCotecna: getOrderDetailss!.uCotecna == null ||
              getOrderDetailss!.uCotecna == "null"
          ? null
          : getOrderDetailss!.uCotecna,
      uArrivalDate: getOrderDetailss!.uArrivalDate == null ||
              getOrderDetailss!.uArrivalDate == "null"
          ? null
          : getOrderDetailss!.uArrivalDate,
      uDahacoAgentFees: getOrderDetailss!.uDahacoAgentFees == null ||
              getOrderDetailss!.uDahacoAgentFees == "null"
          ? null
          : getOrderDetailss!.uDahacoAgentFees,
      uPortCharges: getOrderDetailss!.uPortCharges == null ||
              getOrderDetailss!.uPortCharges == "null"
          ? null
          : getOrderDetailss!.uPortCharges,
      uOtherExp: getOrderDetailss!.uOtherExp == null ||
              getOrderDetailss!.uOtherExp == "null"
          ? null
          : getOrderDetailss!.uOtherExp,
      uClearCharges: getOrderDetailss!.uClearCharges == null ||
              getOrderDetailss!.uClearCharges == "null"
          ? null
          : getOrderDetailss!.uClearCharges,
      uHiddenChrges: getOrderDetailss!.uHiddenChrges == null ||
              getOrderDetailss!.uHiddenChrges == "null"
          ? null
          : getOrderDetailss!.uHiddenChrges,
      uGoodsInspBy: getOrderDetailss!.uGoodsInspBy == null ||
              getOrderDetailss!.uGoodsInspBy == "null"
          ? null
          : getOrderDetailss!.uGoodsInspBy,
      uGoodsReport: getOrderDetailss!.uGoodsReport == null ||
              getOrderDetailss!.uGoodsReport == "null"
          ? null
          : getOrderDetailss!.uGoodsReport,
      uPymtStatus: getOrderDetailss!.uPymtStatus == null ||
              getOrderDetailss!.uPymtStatus == "null"
          ? null
          : getOrderDetailss!.uPymtStatus,
      uPymtType: getOrderDetailss!.uPymtType == null ||
              getOrderDetailss!.uPymtType == "null"
          ? null
          : getOrderDetailss!.uPymtType,
      uTtCopyImage: getOrderDetailss!.uTtCopyImage == null ||
              getOrderDetailss!.uTtCopyImage == "null"
          ? null
          : getOrderDetailss!.uTtCopyImage,
      uPfiImage: getOrderDetailss!.uPfiImage == null ||
              getOrderDetailss!.uPfiImage == "null"
          ? null
          : getOrderDetailss!.uPfiImage,
      uSupplierImage: getOrderDetailss!.uSupplierImage == null ||
              getOrderDetailss!.uSupplierImage == "null"
          ? null
          : getOrderDetailss!.uSupplierImage,
      uBolImage: getOrderDetailss!.uBolImage == null ||
              getOrderDetailss!.uBolImage == "null"
          ? null
          : getOrderDetailss!.uBolImage,
      uOrderType: getOrderDetailss!.uOrderType == null ||
              getOrderDetailss!.uOrderType == "null"
          ? null
          : getOrderDetailss!.uOrderType,
      uTruckInternal: getOrderDetailss!.uTruckInternal == null ||
              getOrderDetailss!.uTruckInternal == "null"
          ? null
          : getOrderDetailss!.uTruckInternal,
      uGpApproval: getOrderDetailss!.uGpApproval == null ||
              getOrderDetailss!.uGpApproval == "null"
          ? null
          : getOrderDetailss!.uGpApproval,
      uSupplierName: getOrderDetailss!.uSupplierName == null ||
              getOrderDetailss!.uSupplierName == "null"
          ? null
          : getOrderDetailss!.uSupplierName,
      uVatNumber: getOrderDetailss!.uVatNumber == null ||
              getOrderDetailss!.uVatNumber == "null"
          ? null
          : getOrderDetailss!.uVatNumber,
      uTransferType: getOrderDetailss!.uTransferType == null ||
              getOrderDetailss!.uTransferType == "null"
          ? null
          : getOrderDetailss!.uTransferType,
      uSalesOrder: getOrderDetailss!.uSalesOrder == null ||
              getOrderDetailss!.uSalesOrder == "null"
          ? null
          : getOrderDetailss!.uSalesOrder,
      uReceived: getOrderDetailss!.uReceived == null ||
              getOrderDetailss!.uReceived == "null"
          ? null
          : getOrderDetailss!.uReceived,
      uDriverName: getOrderDetailss!.uDriverName == null ||
              getOrderDetailss!.uDriverName == "null"
          ? null
          : getOrderDetailss!.uDriverName,
      uReserveInvoice: getOrderDetailss!.uReserveInvoice == null ||
              getOrderDetailss!.uReserveInvoice == "null"
          ? null
          : getOrderDetailss!.uReserveInvoice,
      uRefSeries: getOrderDetailss!.uRefSeries == null ||
              getOrderDetailss!.uRefSeries == "null"
          ? null
          : getOrderDetailss!.uRefSeries,
      uReceivedTime: getOrderDetailss!.uReceivedTime == null ||
              getOrderDetailss!.uReceivedTime == "null"
          ? null
          : getOrderDetailss!.uReceivedTime,
      uSkuBatchNo: getOrderDetailss!.uSkuBatchNo == null ||
              getOrderDetailss!.uSkuBatchNo == "null"
          ? null
          : getOrderDetailss!.uSkuBatchNo,
      uInwardNo: getOrderDetailss!.uInwardNo == null ||
              getOrderDetailss!.uInwardNo == "null"
          ? null
          : getOrderDetailss!.uInwardNo,
      uDispatchTime: getOrderDetailss!.uDispatchTime == null ||
              getOrderDetailss!.uDispatchTime == "null"
          ? null
          : getOrderDetailss!.uDispatchTime,
      uReceivedDate: getOrderDetailss!.uReceivedDate == null ||
              getOrderDetailss!.uReceivedDate == "null"
          ? null
          : getOrderDetailss!.uReceivedDate,
      uExpiryDate: getOrderDetailss!.uExpiryDate == null ||
              getOrderDetailss!.uExpiryDate == "null"
          ? null
          : getOrderDetailss!.uExpiryDate,
      uCnType: getOrderDetailss!.uCnType == null ||
              getOrderDetailss!.uCnType == "null"
          ? null
          : getOrderDetailss!.uCnType,
      uTinNo:
          getOrderDetailss!.uTinNo == null || getOrderDetailss!.uTinNo == "null"
              ? null
              : getOrderDetailss!.uTinNo,
      uLpoNo:
          getOrderDetailss!.uLpoNo == null || getOrderDetailss!.uLpoNo == "null"
              ? null
              : getOrderDetailss!.uLpoNo,
      uOrderQty: getOrderDetailss!.uOrderQty == null ||
              getOrderDetailss!.uOrderQty == "null"
          ? null
          : getOrderDetailss!.uOrderQty,
      uDispatchDate: getOrderDetailss!.uDispatchDate == null ||
              getOrderDetailss!.uDispatchDate == "null"
          ? null
          : getOrderDetailss!.uDispatchDate,
      uBranch: getOrderDetailss!.uBranch == null ||
              getOrderDetailss!.uBranch == "null"
          ? null
          : getOrderDetailss!.uBranch,
      uSalAppEntry: getOrderDetailss!.uSalAppEntry == null ||
              getOrderDetailss!.uSalAppEntry == "null"
          ? null
          : getOrderDetailss!.uSalAppEntry,
      uDocType: getOrderDetailss!.uDocType == null ||
              getOrderDetailss!.uDocType == "null"
          ? null
          : getOrderDetailss!.uDocType,
      uIntKey: getOrderDetailss!.uIntKey == null ||
              getOrderDetailss!.uIntKey == "null"
          ? null
          : getOrderDetailss!.uIntKey,
      uQrFileLoc: getOrderDetailss!.uQrFileLoc == null ||
              getOrderDetailss!.uQrFileLoc == "null"
          ? null
          : getOrderDetailss!.uQrFileLoc,
      uRctCde: getOrderDetailss!.uRctCde == null ||
              getOrderDetailss!.uRctCde == "null"
          ? null
          : getOrderDetailss!.uRctCde,
      uZno: getOrderDetailss!.uZno == null || getOrderDetailss!.uZno == "null"
          ? null
          : getOrderDetailss!.uZno,
      uVfdIn:
          getOrderDetailss!.uVfdIn == null || getOrderDetailss!.uVfdIn == "null"
              ? null
              : getOrderDetailss!.uVfdIn,
      uQrPath: getOrderDetailss!.uQrPath == null ||
              getOrderDetailss!.uQrPath == "null"
          ? null
          : getOrderDetailss!.uQrPath,
      uQrValue: getOrderDetailss!.uQrValue == null ||
              getOrderDetailss!.uQrValue == "null"
          ? null
          : getOrderDetailss!.uQrValue,
      uIdate:
          getOrderDetailss!.uIdate == null || getOrderDetailss!.uIdate == "null"
              ? null
              : getOrderDetailss!.uIdate,
      uItime:
          getOrderDetailss!.uItime == null || getOrderDetailss!.uItime == "null"
              ? null
              : getOrderDetailss!.uItime,
      uDeviceCode: getOrderDetailss!.uDeviceCode == null ||
              getOrderDetailss!.uDeviceCode == "null"
          ? null
          : getOrderDetailss!.uDeviceCode,
      uDeviceTransId: getOrderDetailss!.uDeviceTransId == null ||
              getOrderDetailss!.uDeviceTransId == "null"
          ? null
          : getOrderDetailss!.uDeviceTransId,
      uRvc: getOrderDetailss!.uRvc == null || getOrderDetailss!.uRvc == "null"
          ? null
          : getOrderDetailss!.uRvc,
      uVrn: getOrderDetailss!.uVrn == null || getOrderDetailss!.uVrn == "null"
          ? null
          : getOrderDetailss!.uVrn,
      uLongitude: getOrderDetailss!.uLongitude == null ||
              getOrderDetailss!.uLongitude == "null"
          ? null
          : getOrderDetailss!.uLongitude,
      uLatitude: getOrderDetailss!.uLatitude == null ||
              getOrderDetailss!.uLatitude == "null"
          ? null
          : getOrderDetailss!.uLatitude,
      uAuditJobGroup: getOrderDetailss!.uAuditJobGroup == null ||
              getOrderDetailss!.uAuditJobGroup == "null"
          ? null
          : getOrderDetailss!.uAuditJobGroup,
      uAuditName: getOrderDetailss!.uAuditName == null ||
              getOrderDetailss!.uAuditName == "null"
          ? null
          : getOrderDetailss!.uAuditName,
      uRequest: getOrderDetailss!.uRequest == null ||
              getOrderDetailss!.uRequest == "null"
          ? null
          : getOrderDetailss!.uRequest,
      documentLines: [],
      documentReferences: getOrderDetailss!.documentReferences!.isNotEmpty
          ? getOrderDetailss!.documentReferences
          : [],
      taxExtension: getOrderDetailss!.taxExtension,
      addressExtension: getOrderDetailss!.addressExtension,
    );
    getdocitemsDetailsData = getOrderDetailss!.documentLines!;

    for (var i = 0; i < getdocumentOrderLine.length; i++) {
      scanneditemCheckUpdateData.add(StocksnapModelData(
          branch: AppConstant.branch,
          itemCode: getdocitemsDetailsData[i].itemCode,
          shipDate: '',
          itemName: getdocitemsDetailsData[i].itemDescription,
          serialBatch: '',
          mrp: getdocitemsDetailsData[i].unitPrice,
          sellPrice: getdocitemsDetailsData[i].unitPrice));
    }
  }

  updatechangecheckout(BuildContext context, ThemeData theme) async {
    log('postingDatecontroller.text ::${postingDatecontroller.text}');

    if (scanneditemData.isNotEmpty) {
      SalesOrdPatchAPI.sessionID = AppConstant.sapSessionID.toString();
      SalesOrdPatchAPI.cardCodePost = selectedcust!.cardCode;
      SalesOrdPatchAPI.cardNamePost = custNameController.text.isNotEmpty
          ? custNameController.text
          : selectedcust!.name;
      SalesOrdPatchAPI.docDate = config.currentDate2();
      SalesOrdPatchAPI.dueDate = config.alignDate2(postingDatecontroller.text);
      SalesOrdPatchAPI.remarks = remarkcontroller3.text;
      SalesOrdPatchAPI.orderDate = selectedcust!.uOrderDate!.isNotEmpty
          ? config.alignDate2(selectedcust!.uOrderDate.toString())
          : '';
      SalesOrdPatchAPI.orderType = '1';

      SalesOrdPatchAPI.gpApproval = selectedcust!.uGPApproval;
      SalesOrdPatchAPI.orderTime = selectedcust!.uReceivedTime;
      SalesOrdPatchAPI.custREfNo = selectedcust!.custRefNum ?? '';
      SalesOrdPatchAPI.deviceTransID = selectedcust!.uDeviceId;
      SalesOrdPatchAPI.deviceCode = AppConstant.ip;
      SalesOrdPatchAPI.slpCode = AppConstant.slpCode;

      SalesOrdPatchAPI.corporateuser = userTypes == 'corporate' ? true : false;

      for (int ij = 0; ij < scanneditemData.length; ij++) {
        if (scanneditemData[ij].lineStatus == "bost_Open") {
          if (userTypes == 'user') {
            await scehmeapiforckout(context, theme);
          }
          await callOrderPatchApi(
              context, theme, int.parse(sapDocentry.toString()));
          notifyListeners();
        } else if (scanneditemData[ij].lineStatus == "bost_Close") {
          cancelbtn = false;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            sapDocentry = '';
            sapDocuNumber = '';
            onDisablebutton = false;
            selectedcust = null;
            scanneditemData.clear();
            selectedcust = null;
            notifyListeners();
          });
          notifyListeners();
          break;
        }
      }
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust = null;
        selectedcust55 = null;
        scanneditemData.clear();
        paymentWay.clear();
        totalPayment = null;
        custList2.clear();
        onDisablebutton = false;
        injectToDb();
        getdraftindex();
        remarkcontroller3.text = '';
        mycontroller2[50].text = "";
        cancelbtn = false;
        notifyListeners();
      });
    }
  }

  updateSalesHeaderToDB(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesOrderLineTDB> salesLineValues = [];

    SalesOrderHeaderModelDB salesHeaderValues1 = SalesOrderHeaderModelDB(
      doctype: 'Sales Order',
      docentry: tbDocEntry.toString(),
      objname: '',
      objtype: '',
      tinNo: tinNoController.text,
      vatno: vatNoController.text,
      amtpaid: totalPayment != null
          ? getSumTotalPaid().toString().replaceAll(',', '')
          : null,
      baltopay: totalPayment != null
          ? getBalancePaid().toString().replaceAll(',', '')
          : null,
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      customercode: selectedcust!.cardCode != null
          ? selectedcust!.cardCode.toString()
          : '',
      customername: selectedcust != null ? selectedcust!.name : "",
      customertype: UserValues.userType,
      docbasic: totalPayment != null
          ? totalPayment!.subtotal!.toString().replaceAll(',', '')
          : null,
      docdiscamt: totalPayment != null
          ? totalPayment!.discount!.toString().replaceAll(',', '')
          : null,
      docdiscuntpercen: mycontroller[i].text.isNotEmpty
          ? mycontroller[i].text.toString()
          : '0',
      documentno: (cancelDocnum).toString(),
      docstatus: '3',
      doctotal: totalPayment != null
          ? totalPayment!.totalDue!.toStringAsFixed(2)
          : null,
      lastupdateIp: UserValues.lastUpdateIp,
      premiumid: '',
      remarks: remarkcontroller3.text.toString(),
      salesexec: '',
      seresid: "",
      seriesnum: '',
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
      taxamount:
          totalPayment != null ? totalPayment!.totalTX!.toString() : null,
      taxno: selectedcust != null ? selectedcust!.tarNo.toString() : "",
      transactiondate: '',
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID.toString(),
      paystatus: '',
      customeraccbal:
          selectedcust != null ? selectedcust!.accBalance!.toString() : "",
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
      terminal: UserValues.terminal,
      sapDocNo:
          sapDocuNumber.isNotEmpty ? int.parse(sapDocuNumber.toString()) : 0,
      sapDocentry:
          sapDocentry.isNotEmpty ? int.parse(sapDocentry.toString()) : 0,
      qStatus: 'C',
      totalltr: totalLiter(),
      totalweight: totalWeight(),
      basedocentry: selectedcust!.docentry != null
          ? selectedcust!.docentry.toString()
          : '',
      customerSeriesNum: '',
      editType: 'Edit',
      uOrderDate: selectedcust!.uOrderDate!,
      uOrderType: selectedcust!.uOrderType,
      uGPApproval: selectedcust!.uGPApproval,
      uReceivedTime: selectedcust!.uReceivedTime,
      uDeviceId: selectedcust!.uDeviceId!,
      custRefNo: selectedcust!.custRefNum ?? '',
    );

    await DBOperation.updateSaleOrderheader(
        db, salesHeaderValues1, tbDocEntry.toString(), cancelDocnum.toString());

    for (int i = 0; i < scanneditemData.length; i++) {
      salesLineValues.add(SalesOrderLineTDB(
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        shipDate: '',
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: scanneditemData[i].discountper != null
            ? scanneditemData[i].discountper!.toString()
            : '0',
        discperunit: scanneditemData[i].discount.toString(),
        maxdiscount: scanneditemData[i].maxdiscount.toString(),
        docentry: tbDocEntry.toString(),
        itemcode: scanneditemData[i].itemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        serialbatch: scanneditemData[i].serialBatch,
        taxrate: scanneditemData[i].taxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].itemName,
        basedocentry: scanneditemData[i].basedocentry ?? '',
        baselineID: scanneditemData[i].baselineid ?? '',
        basetype: '23',
      ));

      notifyListeners();
    }

    if (salesLineValues.isNotEmpty) {
      for (int ik = 0; ik < salesLineValues.length; ik++) {
        await DBOperation.updateSalesOrderLine(
            db, salesLineValues, ik, tbDocEntry.toString());
        notifyListeners();
      }
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {}

    notifyListeners();
  }

  callOrderPatchApi(BuildContext context, ThemeData theme, int docEntry) async {
    await getOrderDocList();
    log('sapDocentry:::${sapDocentry}');
    SalesOrdPatchAPI.docLineQout = itemsDocDetails;
    await SalesOrdPatchAPI.gettData(sapDocentry, latitude!, longitude!)
        .then((value) async {
      if (value.statusCode >= 200 && value.statusCode <= 210) {
        await Get.defaultDialog(
                title: "Success",
                middleText: 'Updated Successfully',
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
                            custserieserrormsg = '';
                            onDisablebutton = false;
                            loadingscrn = false;
                            scanneditemData.clear();
                            schemebtnclk = false;
                            selectedcust = null;
                            selectedcust55 = null;
                            paymentWay.clear();
                            newShipAddrsValue = [];
                            itemsDocDetails = [];
                            newBillAddrsValue = [];
                            newCustValues = [];
                            totalPayment = null;
                            mycontroller[50].text = "";
                            discountcontroller = List.generate(
                                100, (i) => TextEditingController());
                            mycontroller = List.generate(
                                150, (i) => TextEditingController());
                            qtymycontroller = List.generate(
                                100, (i) => TextEditingController());
                            remarkcontroller3.text = '';
                            Get.offAllNamed(ConstantRoutes.dashboard);

                            notifyListeners();
                          }),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          injectToDb();

          notifyListeners();
        });
      } else if (value.statusCode >= 400 && value.statusCode <= 410) {
        cancelbtn = false;
        custserieserrormsg = value.erorrs!.message!.value;
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
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
          onDisablebutton = false;

          notifyListeners();
        });
      } else {
        Get.defaultDialog(
                title: "Alert",
                middleText: custserieserrormsg = value.exception.toString(),
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
                            onDisablebutton = false;

                            Get.back();
                          }),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          injectToDb();
          onDisablebutton = false;

          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

  pushRabiMqSO(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Add",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload11 : $ddd");
    //RabitMQ

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),

        //"102.69.167.106"
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

  pushRabiMqSO2(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Add",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload22 : $ddd");
    //RabitMQ

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),

        //"102.69.167.106"
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

  pushRabiMqSO3(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getdSalesOrderPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.getSalesOrderLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesOrderHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    var ddd = json.encode({
      "ObjectType": 10,
      "ActionType": "Edit",
      "SalesOrderHeader": salesHeader,
      "SalesOrderLine": salesLine,
      "SalesOrderPay": salesPAY,
    });
//log("payload : $ddd");
    //RabitMQ

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),

        //"102.69.167.106"
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

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  List<BankListValue> bankList = [];
  String? selectedBankType;

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

  custSeriesApi() async {
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

  callPostApi(BuildContext context, ThemeData theme) async {
    loadingBtn = true;
    await addFiles();
    await sapOrderLoginApi(
      context,
    );

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

  clearSuspendedData(BuildContext context, ThemeData theme) {
    cpyfrmsq = false;
    cashType = '';
    newSeriesCode = null;
    newSeriesName = null;
    whsCode = null;
    whsName = null;
    udfClear();
    selectbankCode = '';
    postingDatecontroller.text = '';
    selectedBankType = null;
    bankhintcolor = false;
    warehousectrl[1].text = '';
    warehousectrl[0].text = '';
    creditType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    addCardCode = '';
    onDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    selectedcust55 = null;
    remarkcontroller3.text = '';
    mycontroller[50].clear();
    paymentWay.clear();
    totalPayment = null;
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    newCustValues = [];
    cashType = '';
    creditType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    cashpayment = null;
    cashpayment = null;

    cqpayment = null;

    transpayment = null;
    chqnum = null;

    transrefff = null;
    addCardCode = '';

    itemListDateCtrl = List.generate(200, (i) => TextEditingController());
    mycontroller = List.generate(500, (i) => TextEditingController());
    qtymycontroller = List.generate(500, (i) => TextEditingController());
    discountcontroller = List.generate(500, (i) => TextEditingController());
    discountcontroller2 = List.generate(500, (i) => TextEditingController());

    notifyListeners();
    Get.defaultDialog(
            title: "Success",
            middleText: " Data Cleared Sucessfully..!!",
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
      notifyListeners();
    });
  }

  viewDbtable() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getdata(db);
    notifyListeners();
  }

  getItemFromDB(Database db) async {
    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasData(db, "");
    for (int i = 0; i < itemMasdata.length; i++) {
      itemData.add(StocksnapModelData(
        branch: itemMasdata[i].branchcode,
        itemCode: itemMasdata[i].itemcode,
        shipDate: '',
        itemName: itemMasdata[i].itemname,
        serialBatch: itemMasdata[i].serialbatch,
        qty: double.parse(itemMasdata[i].quantity!),
        mrp: double.parse(itemMasdata[i].mrpprice.toString()),
        createdUserID: itemMasdata[i].createdUserID.toString(),
        createdateTime: itemMasdata[i].createdateTime,
        lastupdateIp: itemMasdata[i].lastupdateIp,
        purchasedate: itemMasdata[i].purchasedate,
        snapdatetime: itemMasdata[i].snapdatetime,
        specialprice: double.parse(itemMasdata[i].specialprice.toString()),
        updatedDatetime: itemMasdata[i].updatedDatetime,
        updateduserid: itemMasdata[i].updateduserid.toString(),
        sellPrice: double.parse(itemMasdata[i].sellprice!),
        maxdiscount: itemMasdata[i].maxdiscount != null
            ? itemMasdata[i].maxdiscount.toString()
            : '',
        taxRate: itemMasdata[i].taxrate != null
            ? double.parse(itemMasdata[i].taxrate.toString())
            : 00,
        discountper: 0,
        openQty: 0,
        transID: int.parse(itemMasdata[i].transentry != null
            ? itemMasdata[i].transentry.toString()
            : '0'),
        inDate: '',
        cost: 0,
        inType: '',
        liter: itemMasdata[i].liter != null
            ? double.parse(itemMasdata[i].liter.toString())
            : 00,
        weight: itemMasdata[i].weight != null
            ? double.parse(itemMasdata[i].weight.toString())
            : 00,
      ));
      notifyListeners();
    }
    notifyListeners();
  }

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
              name: cusdataDB[i].customername,
              U_CashCust: cusdataDB[i].uCashCust,
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

  postCategory(String value) {
    selectedValue = value;
  }

  int intval = 0;

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].serialBatch == sBatch) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  int i = 1;

  int get geti => i;

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);

    for (int i = 0; i < itemData.length; i++) {
      if (itemData[i].serialBatch == scanneditemData[ind].serialBatch) {
        if (itemData[i].qty! >= qtyctrl) {
          qtyctrl = qtyctrl + 1;
          qtymycontroller[ind].text = qtyctrl.toString();
          FocusScopeNode focus = FocusScope.of(context);
          calCulateDocVal(context, theme);

          if (!focus.hasPrimaryFocus) {
            focus.unfocus();
          }
          focusnode[0].requestFocus();
          notifyListeners();
          break;
        } else {
          qtymycontroller[ind].text = 1.toString();

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

  setstate1() {
    notifyListeners();
  }

  itemIncrement11(int ind, BuildContext context, ThemeData theme) {
    for (int i = 0; i < itemData.length; i++) {
      int qtyctrl = 0;

      if (itemData[i].serialBatch == scanneditemData[ind].serialBatch) {
        if (itemData[i].itemCode == scanneditemData[ind].itemCode) {
          qtyctrl = int.parse(qtymycontroller[ind].text.toString());

          if (qtyctrl != 0) {
            if (itemData[i].qty! >= qtyctrl) {
              qtymycontroller[ind].text = qtyctrl.toString();
              calCulateDocVal(context, theme);

              notifyListeners();
            } else {
              qtymycontroller[ind].text = '';
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
                            content: 'No more qty to add..!!',
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  });
              notifyListeners();
            }
          } else if (qtyctrl == 0) {
            qtymycontroller.removeAt(ind);
            scanneditemData.removeAt(ind);

            calCulateDocVal(context, theme);

            notifyListeners();
          }
        }
      }
    }
    notifyListeners();
  }

  itemdecrement(BuildContext context, ThemeData theme, int ind) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);

    if (qtyctrl > 0) {
      qtyctrl = qtyctrl - 1;
      qtymycontroller[ind].text = qtyctrl.toString();
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      mycontroller[ind].text = '';
      notifyListeners();
    }
    calCulateDocVal(context, theme);
  }

  List<OpenSalesOrderHeaderData> openSalesQuot = [];

  callOpenSalesQuotation(BuildContext context, ThemeData theme) async {
    log('fffffff');
    openSalesQuot = [];
    await SalsesQuotHeaderAPi.getGlobalData(
            AppConstant.branch, selectedcust!.cardCode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openSalesQuot = value.activitiesData!;
        log('openSalesQuotopenSalesQuot::${openSalesQuot.length}');
        for (var i = 0; i < openSalesQuot.length; i++) {
          openSalesQuot[i].invoiceClr = 0;
          openSalesQuot[i].checkBClr = false;
        }
        await callOpenSalesQuotationLine(context, theme);
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingSqBtn = false;
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
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    });
  }

  List<OpenSalesOrderLineData>? openQuotLine;
  List<OpenSalesOrderLineData>? openQuotLineList;

  showopenQuotLines() {
    openQuotLineList = [];

    for (var ij = 0; ij < openSalesQuot.length; ij++) {
      if (openSalesQuot[ij].invoiceClr == 1 &&
          openSalesQuot[ij].checkBClr == true) {
        custNameController.text = openSalesQuot[ij].cardName;
        tinNoController.text = openSalesQuot[ij].uTinNO ?? '';
        vatNoController.text = openSalesQuot[ij].uVATNUMBER ?? '';
        for (var i = 0; i < openQuotLine!.length; i++) {
          if (openQuotLine![i].docEntry.toString() ==
              openSalesQuot[ij].docEntry.toString()) {
            openQuotLineList!.add(OpenSalesOrderLineData(
                itemCode: openQuotLine![i].itemCode,
                lineNum: openQuotLine![i].lineNum,
                uPackSize: openQuotLine![i].uPackSize != null ||
                        openQuotLine![i].uPackSize != 0
                    ? openQuotLine![i].uPackSize
                    : null,
                docEntry: openQuotLine![i].docEntry,
                discPrcnt: openQuotLine![i].discPrcnt,
                description: openQuotLine![i].description,
                openQty: openQuotLine![i].openQty,
                price: openQuotLine![i].price,
                whsCode: openQuotLine![i].whsCode));
          }
          notifyListeners();
        }
      }
    }
    notifyListeners();
    log('openQuotLineListopenQuotLineList::${openQuotLineList!.length}');
    for (var ik = 0; ik < openQuotLineList!.length; ik++) {
      soqtycontroller[ik].text = openQuotLineList![ik].openQty.toString();
      notifyListeners();
    }
  }

  callOpenSalesQuotationLine(BuildContext context, ThemeData theme) async {
    await SalsesQuotLineAPi.getGlobalData(
            AppConstant.branch, selectedcust!.cardCode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openQuotLine = value.activitiesData!;
        loadingSqBtn = false;

        log('openQuotLineopenQuotLine::${openQuotLine!.length}');
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingSqBtn = false;
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
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    });
  }

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    selectedcust = null;
    selectedcust55 = null;
    custNameController.text = '';

    tinNoController.text = '';
    vatNoController.text = '';
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    double? updateCustBal = 0;
    loadingscrn = true;
    holddocentry = '';
    log('message ustomerDetals.taxCode::${customerDetals.taxCode}');

    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        taxCode: customerDetals.taxCode,
        name: '',
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        U_CashCust: customerDetals.U_CashCust,
        point: customerDetals.point,
        address: [],
        accBalance: 0,
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
    addCardCode = customerDetals.cardCode!;
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
          log('selectedcust paymentGroup::${selectedcust!.U_CashCust!}');
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
        name: customerDetals.name,
        taxCode: customerDetals.taxCode,
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
      calCulateDocVal(context, theme);
    }
    await callOpenSalesQuotation(context, theme);
    notifyListeners();
  }

  billaddresslist() {
    billadrrssItemlist = [];
    if (selectedcust != null) {
      for (int i = 0; i < selectedcust!.address!.length; i++) {
        billadrrssItemlist.add(Address(
            addresstype: selectedcust!.address![i].addresstype,
            address1: selectedcust!.address![i].address1,
            address2: selectedcust!.address![i].address2,
            address3: selectedcust!.address![i].address3,
            billCity: selectedcust!.address![i].billCity,
            billCountry: selectedcust!.address![i].billCountry,
            billPincode: selectedcust!.address![i].billPincode,
            billstate: selectedcust!.address![i].billstate));
      }
      notifyListeners();
    }
    notifyListeners();
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];

    if (selectedcust55 != null) {
      for (int i = 0; i < selectedcust55!.address!.length; i++) {
        if (selectedcust55!.address![i].addresstype == "S") {
          shipadrrssItemlist.add(Address(
              addresstype: selectedcust55!.address![i].addresstype,
              address1: selectedcust55!.address![i].address1,
              address2: selectedcust55!.address![i].address2,
              address3: selectedcust55!.address![i].address3,
              billCity: selectedcust55!.address![i].billCity,
              billCountry: selectedcust55!.address![i].billCountry,
              billPincode: selectedcust55!.address![i].billPincode,
              billstate: selectedcust55!.address![i].billstate));
          notifyListeners();
        }
      }

      notifyListeners();
    }
    notifyListeners();
  }

  clearData(BuildContext context, ThemeData theme) {
    holddocentry = '';
    selectedcust = null;
    selectedcust55 = null;
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    postingDatecontroller.text = config.alignDate(DateTime.now().toString());
    if (scanneditemData.isNotEmpty) {
      for (var i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].taxRate = 0.0;
        if (selectedcust != null) {
          if (selectedcust!.taxCode == 'O1') {
            scanneditemData[i].taxRate = 18;
          } else {
            scanneditemData[i].taxRate = 0.0;
          }
          notifyListeners();
        } else {
          scanneditemData[i].taxRate = 0.0;
        }
        calCulateDocVal(context, theme);
      }
    }
    notifyListeners();
  }

  refresCufstList() async {
    filtercustList = custList;

    notifyListeners();
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

  String addCardCode = '';
  createNewBillAdd() async {
    final Database db = (await DBHelper.getInstance())!;
    addCardCode = selectedcust!.cardCode.toString();

    List<CustomerAddressModelDB> createnewcsaddDB =
        await DBOperation.createNewgetCstmMasAddDB(db, addCardCode);
    for (int ia = 0; ia < createnewcsaddDB.length; ia++) {
      if (selectedcust!.cardCode == createnewcsaddDB[ia].custcode) {
        if (createnewcsaddDB[ia].addresstype == "B") {
          selectedcust!.address!.add(Address(
              autoId: int.parse(createnewcsaddDB[ia].autoid.toString()),
              addresstype: createnewcsaddDB[ia].addresstype,
              address1: createnewcsaddDB[ia].address1!,
              address2: createnewcsaddDB[ia].address2!,
              address3: createnewcsaddDB[ia].address3!,
              billCity: createnewcsaddDB[ia].city.toString(),
              billCountry: createnewcsaddDB[ia].countrycode.toString(),
              billPincode: createnewcsaddDB[ia].pincode.toString(),
              billstate: createnewcsaddDB[ia].statecode.toString()));
        }
        if (createnewcsaddDB[ia].addresstype == "S") {
          selectedcust55!.address!.add(Address(
              autoId: int.parse(createnewcsaddDB[ia].autoid.toString()),
              addresstype: createnewcsaddDB[ia].addresstype,
              address1: createnewcsaddDB[ia].address1!,
              address2: createnewcsaddDB[ia].address2!,
              address3: createnewcsaddDB[ia].address3!,
              billCity: createnewcsaddDB[ia].city.toString(),
              billCountry: createnewcsaddDB[ia].countrycode.toString(),
              billPincode: createnewcsaddDB[ia].pincode.toString(),
              billstate: createnewcsaddDB[ia].statecode.toString()));
        }

        selectedBillAdress = (selectedcust!.address!.length - 1);
        selectedShipAdress = (selectedcust55!.address!.length - 1);
        notifyListeners();
      }
    }

    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await await sapOrderLoginApi(context);
    (context);
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
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertsipCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustshipaddresslist(
          context,
        );
        loadingBtn = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await await sapOrderLoginApi(context);
    (context);
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
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        loadingBtn = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");

        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    loadingBtn = true;
    await sapOrderLoginApi(context);
    (context);
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
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await insertsipCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();

        await getcustBilladdresslist(
          context,
        );

        await getcustshipaddresslist(
          context,
        );
        loadingBtn = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        loadingBtn = false;
      }
    });
    notifyListeners();
  }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    loadingBtn = true;
    if (formkeyShipAd.currentState!.validate()) {
      if (checkboxx == true) {
        await callAddressPostApi(context);
        notifyListeners();
      } else {
        await callShipAddressPostApi(context);
        notifyListeners();
      }

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
          }).then((value) {
        loadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  insertnewbiladdresscreation(BuildContext context, ThemeData theme) async {
    loadingBtn = true;

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
          }).then((value) {
        loadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  insertbillCreatenewAddress() async {
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
  }

  insertsipCreatenewAddress() async {
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

  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
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
      mycontroller[20].text = mycontroller[13].text; //country
    } else {
      mycontroller[14].clear();
      mycontroller[15].clear();
      mycontroller[16].clear();
      mycontroller[17].clear();
      mycontroller[18].clear();
      mycontroller[19].clear();
      mycontroller[20].clear();
    }
    notifyListeners();
  }

  shipToBill(bool dat) {
    //checkboxx = dat;
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

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  validateformkey(
    int ij,
  ) {
    if (formkey[ij].currentState!.validate()) {
      notifyListeners();
    }
    notifyListeners();
  }

  createnewchagescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    await addnewCustomer(context, theme, ij);
    await getCustDetFDB();
    await getNewCustandadd(context);
    notifyListeners();
  }

  String vatfileError = '';
  String tinfileError = '';
  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    int sucesss = 0;
    vatfileError = '';
    tinfileError = '';
    textError = '';

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
        tinfileError = "Select a Tin file";
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

      await callPostApi(context, theme);

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
          cardCode: newcusdataDB[i]['customerCode'].toString(),
          taxCode: newcusdataDB[i]['taxCode'].toString(),
          U_CashCust: '',
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
          taxCode: newcusdataDB[i]['taxCode'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          U_CashCust: '',
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

  List<Map<String, dynamic>> newCustAddData = [];

  String? custautoid;
  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    newCustValues = [];
    newCustAddData = [];
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
//

    newCustAddData.add({
      'customerCode': mycontroller[3].text.isNotEmpty
          ? mycontroller[3].text.toString()
          : '', //customerCode
      'customername': mycontroller[6].text.isNotEmpty
          ? mycontroller[6].text
          : '', //customerName
      'premiumid': '', //premiumid
      'customertype': '', //CustomerType
      "taxno": mycontroller[5].text.isNotEmpty
          ? mycontroller[5].text.toString() //taxno
          : '',
      'createdbybranch': '', //createdbybranch
      'balance': '0', //balance

      'points': '0', //points
      'snapdatetime': config.currentDate(), //snapdatetime
      "phoneno1":
          mycontroller[4].text.isNotEmpty ? mycontroller[4].text : '', //ph1
      'phoneno2': '', //ph2
      'emalid':
          mycontroller[21].text.isNotEmpty ? mycontroller[21].text : '', //email
      'createdateTime': config.currentDate(),
      'updatedDatetime': config.currentDate(),
      'createdUserID': UserValues.userID.toString(), //createdUserid
      'updateduserid': UserValues.userID.toString(), //updateduserid
      'lastupdateIp': UserValues.lastUpdateIp.toString(),
      'TaxCode': ''
    });

    newBillAddrsValue.add(CustomerAddressModelDB(
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
      custcode:
          mycontroller[3].text.isEmpty ? custautoid : mycontroller[3].text,
      geolocation1: '',
      geolocation2: '',
      statecode: mycontroller[12].text.isNotEmpty ? mycontroller[12].text : '',
      pincode: mycontroller[11].text.isNotEmpty ? mycontroller[11].text : '',
      branch: UserValues.branch,
      terminal: UserValues.terminal,
      addresstype: 'B',
    ));
    newShipAddrsValue.add(CustomerAddressModelDB(
      custcode:
          mycontroller[3].text.isEmpty ? custautoid : mycontroller[3].text,
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
      await DBOperation.insertCustomer(db, newCustAddData);
      await DBOperation.insertCustomerAddress(db, newBillAddrsValue);
      await DBOperation.insertCustomerAddress(db, newShipAddrsValue);
      List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
      List<CustomerAddressModelDB> newcusAddrssdataDB =
          await DBOperation.getCstmMasAddDB(db);

      await DBOperation.updateCustomerDetailstocrdcode(db, cardCodexx,
          newcusdataDB[newcusdataDB.length - 1].autoid.toString());
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 2].autoid.toString());
      await DBOperation.updateCustAddrsscrdcode(
              db,
              cardCodexx,
              newcusAddrssdataDB[newcusAddrssdataDB.length - 1]
                  .autoid
                  .toString())
          .then((value) {
        config.showDialogSucessB(
            "Customer created successfully ..!!", "Success");
      });
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

    getCustDetFDB();
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
          taxCode: newcusdataDB[i]['taxCode'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
          name: newcusdataDB[i]['customername'].toString(),
          U_CashCust: '',
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
    notifyListeners();

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
          notifyListeners();
        }
      }
    }
    notifyListeners();
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
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[20].clear();
    notifyListeners();
  }

  clearCustomer() {
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[21].clear();
    custNameController.text = '';
    vatNoController.text = '';
    tinNoController.text = '';
    notifyListeners();
  }

  calCulateDocVal2(BuildContext context, ThemeData theme) {
    totalPayment = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;

    for (int iss = 0; iss < scanneditemData2.length; iss++) {
      scanneditemData2[iss].qty = double.parse(
          qtymycontroller2[iss].text.isNotEmpty
              ? qtymycontroller2[iss].text
              : "0");

      notifyListeners();
      String ansbasic =
          (scanneditemData2[iss].sellPrice! * scanneditemData2[iss].qty!)
              .toString();

      scanneditemData2[iss].basic = double.parse(ansbasic);

      scanneditemData2[iss].discount = (scanneditemData2[iss].basic! *
          scanneditemData2[iss].discountper! /
          100);

      scanneditemData2[iss].priceAfDiscBasic =
          scanneditemData2[iss].sellPrice! * 1;
      double priceafd = (scanneditemData2[iss].priceAfDiscBasic! *
          scanneditemData2[iss].discountper! /
          100);

      double priceaftDisc = scanneditemData2[iss].priceAfDiscBasic! - priceafd;
      scanneditemData2[iss].priceAftDiscVal = priceaftDisc;
      scanneditemData2[iss].taxable =
          scanneditemData2[iss].basic! - scanneditemData2[iss].discount!;

      if (scanneditemData2[iss].taxRate != null) {
        scanneditemData2[iss].taxvalue = scanneditemData2[iss].taxable! *
            scanneditemData2[iss].taxRate! /
            100;
      } else {
        scanneditemData2[iss].taxvalue = 0;
      }

      scanneditemData2[iss].netvalue =
          (scanneditemData2[iss].basic! - scanneditemData2[iss].discount!) +
              scanneditemData2[iss].taxvalue!;

      totalPay.subtotal = totalPay.subtotal! + scanneditemData2[iss].basic!;

      totalPay.discount = totalPay.discount! + scanneditemData2[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData2[iss].taxvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;
      totalPay.total =
          totalPay.total! + double.parse(scanneditemData2[iss].qty.toString());

      totalPay.totalDue = totalPay.totalDue! + scanneditemData2[iss].netvalue!;
      totalPayment2 = totalPay;

      notifyListeners();
    }
  }

  calCulateDocVal(BuildContext context, ThemeData theme) {
    totalPayment = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      scanneditemData[iss].qty = double.parse(
          qtymycontroller[iss].text.isNotEmpty
              ? qtymycontroller[iss].text
              : "0");

      totalPay.total =
          totalPay.total! + double.parse(scanneditemData[iss].qty.toString());
      notifyListeners();

      String ansbasic =
          (scanneditemData[iss].sellPrice! * scanneditemData[iss].qty!)
              .toString();
      scanneditemData[iss].basic = double.parse(ansbasic);

      double? mycontlaa = scanneditemData[iss].discountper! ?? 0;
      scanneditemData[iss].discount =
          (scanneditemData[iss].basic! * mycontlaa / 100);
      scanneditemData[iss].priceAfDiscBasic =
          scanneditemData[iss].sellPrice! * 1;
      double priceafd = (scanneditemData[iss].priceAfDiscBasic! *
          scanneditemData[iss].discountper! /
          100);

      double priceaftDisc = scanneditemData[iss].priceAfDiscBasic! - priceafd;
      scanneditemData[iss].priceAftDiscVal = priceaftDisc;

      scanneditemData[iss].taxable =
          scanneditemData[iss].basic! - scanneditemData[iss].discount!;
      if (scanneditemData[iss].taxRate == null ||
          scanneditemData[iss].taxRate == 'null') {
        scanneditemData[iss].taxRate = 0;
      } else {}
      scanneditemData[iss].taxvalue =
          scanneditemData[iss].taxable! * scanneditemData[iss].taxRate! / 100;

      scanneditemData[iss].netvalue =
          (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
              scanneditemData[iss].taxvalue!;

      totalPay.subtotal = totalPay.subtotal! + scanneditemData[iss].basic!;

      totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;

      totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;
      totalPayment = totalPay;

      notifyListeners();

      notifyListeners();
    }
    notifyListeners();
  }

  calculateLineVal(BuildContext context, ThemeData theme, int iss) {
    String ans = (scanneditemData[iss].sellPrice! * scanneditemData[iss].qty!)
        .toString();
    scanneditemData[iss].basic = double.parse(ans);
    scanneditemData[iss].discountper = mycontroller[iss].text.isNotEmpty
        ? double.parse(mycontroller[iss].text.toString())
        : 00;
    scanneditemData[iss].discount =
        (scanneditemData[iss].basic! * scanneditemData[iss].discountper! / 100);

    scanneditemData[iss].taxable =
        scanneditemData[iss].basic! - scanneditemData[iss].discount!;

    scanneditemData[iss].taxvalue =
        scanneditemData[iss].taxable! * scanneditemData[iss].taxRate! / 100;

    scanneditemData[iss].netvalue =
        (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
            scanneditemData[iss].taxvalue!;
    notifyListeners();
  }

  double getSumTotalPaid2() {
    double toalPaid = 0.0;
    if (paymentWay2.isNotEmpty) {
      for (int i = 0; i < paymentWay2.length; i++) {
        if (paymentWay2[i].type != "Credit") {
          toalPaid = toalPaid + paymentWay2[i].amt!;
        }
      }

      return toalPaid;
    } else {
      return 0.00;
    }
  }

  itmecodelistshow(String v) {}
  double getSumTotalPaid55() {
    if (paymentWay2.isNotEmpty) {
      var getTotalPaid = paymentWay2.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getSumTotalPaid() {
    if (paymentWay.isNotEmpty) {
      var getTotalPaid = paymentWay.map((itemdet) => itemdet.amt.toString());
      var getTotalPaidSum = getTotalPaid.map(double.parse).toList();
      var toalPaid = getTotalPaidSum.reduce((a, b) => a + b);
      return toalPaid;
    } else {
      return 0.00;
    }
  }

  double getBalancePaid() {
    if (paymentWay.isNotEmpty) {
      return double.parse(
              totalPayment!.totalDue!.toStringAsFixed(2).replaceAll(',', '')) -
          double.parse(getSumTotalPaid().toStringAsFixed(2));
    }
    return totalPayment != null
        ? double.parse(
            totalPayment!.totalDue!.toStringAsFixed(2).replaceAll(',', ''))
        : 0.00;
  }

  double getBalancePaid2() {
    if (paymentWay2.isNotEmpty) {
      return double.parse(
              totalPayment2!.totalDue!.toStringAsFixed(2).replaceAll(',', '')) -
          double.parse(getSumTotalPaid55().toStringAsFixed(2));
    }
    return totalPayment2 != null
        ? double.parse(
            totalPayment2!.totalDue!.toStringAsFixed(2).replaceAll(',', ''))
        : 0.00;
  }

  addPayAmount(PaymentWay paymt, BuildContext context) {
    if (paymentWay.isEmpty) {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(2)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(2)) >=
              double.parse(paymt.amt!.toStringAsFixed(2))) {
        addToPaymentWay(paymt, context);
      } else {
        msgforAmount = 'Enter Correct amount..!!';

        notifyListeners();
      }
    } else {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(2)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(2)) >=
              double.parse(paymt.amt!.toStringAsFixed(2))) {
        addToPaymentWay(paymt, context);
      } else {
        msgforAmount = 'Enter Correct amount..!!';
        notifyListeners();
      }
    }
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

  addToPaymentWay(
    PaymentWay paymt,
    BuildContext context,
  ) {
    hintcolor = false;
    paymentWay.add(PaymentWay(
        amt: paymt.amt!,
        dateTime: paymt.dateTime,
        reference: paymt.reference ?? '',
        type: paymt.type,
        cardApprno: paymt.cardApprno,
        cardref: paymt.cardref,
        cardterminal: paymt.cardterminal,
        chequedate: paymt.chequedate,
        chequeno: paymt.chequeno,
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

  fullamt(String type, BuildContext context, ThemeData theme) {
    PaymentWay fpaymt = PaymentWay();

    mycontroller[22].text = totalPayment!.totalDue.toString();
    cashpayment = totalPayment!.totalDue!;
    String fullam = getBalancePaid().toString().replaceAll(',', '');
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
  }

  cpyBtnclik(int i) {
    mycontroller[i].text = getBalancePaid().toStringAsFixed(2);
    notifyListeners();
  }

  double? cashpayment = 0;
  double? cqpayment = 0;
  double? transpayment = 0;
  int? chqnum = 0;
  String? transrefff = '';
  String cashType = '';
  String creditType = '';
  String cardType = '';
  String chequeType = '';
  String transferType = '';
  String walletType = '';
  String pointType = '';
  String accType = '';

  addEnteredAmtType(String type, BuildContext context, int i, ThemeData theme) {
    PaymentWay paymt = PaymentWay();
    if (selectedBankType == null && type == 'Cheque') {
      bankhintcolor = true;
      notifyListeners();
    }

    if (formkey[i].currentState!.validate()) {
      if (type == 'Cash') {
        creditType = type;
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        cashType = type;
        cashpayment = paymt.amt!;
      } else if (type == 'Cheque') {
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = mycontroller[24].text;
        paymt.chequeno = mycontroller[23].text.toString();
        paymt.type = type;
        chequeType = type;
        cqpayment = paymt.amt;
        chqnum = int.parse(paymt.chequeno.toString());
      } else if (type == 'Card') {
        paymt.amt = double.parse(
            mycontroller[29].text.toString().trim().replaceAll(',', ''));
        paymt.reference = mycontroller[28].text;
        paymt.cardApprno = mycontroller[27].text;
        paymt.cardref = mycontroller[28].text;
        paymt.cardterminal = paymentterm.toString();
        paymt.type = type;
        cardType = type;
      } else if (type == 'Transfer') {
        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate(); //mycontroller[30],
        paymt.type = type;
        transferType = type;
        transpayment = paymt.amt;
        transrefff = paymt.reference!;
      } else if (type == 'Wallet') {
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        walletType = type;
      } else if (type == 'Account Balance') {
        paymt.type = type;
        accType = type;

        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
      } else if (type == 'Points Redemption') {
        paymt.redeempoint = mycontroller[38].text;
        paymt.availablept = mycontroller[37].text;
        paymt.amt = double.parse(mycontroller[40].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        pointType = type;
      } else if (type == 'Discount') {
        paymt.discountcode = mycontroller[41].text;
        paymt.discounttype = discount;
        paymt.amt = double.parse(mycontroller[42].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.reference = mycontroller[41].text.toString();
        paymt.type = type;
      } else if (type == 'Credit') {
        paymt.recoverydate = mycontroller[44].text;
        paymt.reference = mycontroller[43].text.toString();
        paymt.amt = double.parse(mycontroller[45].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        creditType = type;
      }
    }
    if (selectedType == null && type == 'Transfer') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (paymentterm == null && type == 'Card') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (wallet == null && type == 'Wallet') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (coupon == null && type == 'Coupons') {
      hintcolor = true;
      notifyListeners();
      return;
    }
    if (discount == null && type == 'Discount') {
      hintcolor = true;
      notifyListeners();
      return;
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
                  contentPadding: EdgeInsets.zero,
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you are used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
  }

  int checkAlreadyUsed(String typeofMoney) {
    for (int ip = 0; ip < paymentWay.length; ip++) {
      if (paymentWay[ip].type == "Cash") {
        if (paymentWay[ip].type == typeofMoney) {
          return 1;
        }
      }
      notifyListeners();
    }
    return 0;
  }

  clearPayment() {
    paymentWay.clear();
    getSumTotalPaid();
    getBalancePaid();
    notifyListeners();
  }

  removePayment(int i) {
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();

    notifyListeners();
  }

  udfClear() {
    udfType = '';
    valueSelectedOrder = null;
    valueSelectedGPApproval = null;
    udfController[2].clear();
    udfController[0].clear();
    udfController[1].clear();
    notifyListeners();
  }

  clearTextField() {
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatFiles = null;
    searchcontroller.clear();
    mycontroller[3].clear();
    mycontroller[4].clear();
    mycontroller[5].clear();
    mycontroller[6].clear();
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    mycontroller[14].clear();
    mycontroller[15].clear();
    mycontroller[16].clear();
    mycontroller[17].clear();
    mycontroller[18].clear();
    mycontroller[19].clear();
    mycontroller[13].clear();
    mycontroller[20].clear();
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

    checkboxx = false;
    selectedType = null;
    notifyListeners();
  }

  changecheckout(BuildContext context, ThemeData theme) async {
    if (userTypes == 'user') {
      await scehmeapiforckout(context, theme);
    }
    checkOut(context, theme);
    notifyListeners();
  }

  checkOut(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    onDisablebutton = true;
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
        onDisablebutton = false;
        notifyListeners();
      });
    } else if (scanneditemData.isEmpty) {
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
                      content: 'Choose Product..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else if (getBalancePaid() < 0) {
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
                      content: 'Your balance amount is less than 0',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else if (valueSelectedOrder == null && valueSelectedGPApproval == null) {
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
                      content: 'Please Update a UDF',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else if (paymentWay.isNotEmpty) {
      if ((totalPayment!.totalDue != getSumTotalPaid()) &&
          (getBalancePaid() != 0)) {
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
                        content: 'Pay the full amount..!!',
                        theme: theme,
                      )),
                      buttonName: null));
            }).then((value) {
          disableKeyBoard(context);
        }).then((value) {
          onDisablebutton = false;
          notifyListeners();
        });
      } else {
        await saveValuesTODB("check out", context, theme);

        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteOrderHold(db, holddocentry).then((value) {
            holddocentry = '';
            onHoldFilter = [];
            getdraftindex();
          });
        }
      }
    } else if (paymentWay.isEmpty) {
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
                      content: 'Pay the full amount..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  scehmeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
    notifyListeners();
  }

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log("sapDocentrysapDocentry:::$sapDocentry");
    if (sapDocentry.isNotEmpty) {
      log('step1');
      List<Map<String, Object?>> getheaderData =
          await DBOperation.salesOrderCancellQuery(
        db,
        tbDocEntry.toString(),
      );
      if (getheaderData.isNotEmpty) {
        log('step12');

        if (getheaderData[0]['basedocentry'].toString() ==
            tbDocEntry.toString()) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    content: AlertBox(
                      payMent: 'Alert',
                      errormsg: true,
                      widget: Center(
                          child: ContentContainer(
                        content:
                            'This document is already converted into sales invoice',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            cancelDocnum = '';
            sapDocentry = '';
            sapDocuNumber = '';
            selectedcust2 = null;
            selectedcust25 = null;
            paymentWay2.clear();
            scanneditemData2.clear();
            cancelbtn = false;
            selectedcust2 = null;
            selectedcust = null;
            scanneditemData2.clear();
            paymentWay2.clear();
            totalPayment2 = null;
            injectToDb();
            getdraftindex();
            mycontroller2[50].text = "";
            notifyListeners();
          });
        }
      } else {
        log('step13');

        log('message::Cancel api calling');
        await callSalesOrderCancelAPI(context, theme);
        log('step15');

        notifyListeners();
      }
    } else {
      cancelbtn = false;
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Something went wrong',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust2 = null;
        selectedcust25 = null;
        scanneditemData2.clear();
        paymentWay2.clear();
        totalPayment2 = null;
        custList2.clear();
        injectToDb();
        getdraftindex();
        mycontroller2[50].text = "";
        cancelbtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  sapOrderLoginApi(
    BuildContext context,
  ) async {
    final pref2 = await pref;
    PostOrderLoginAPi.username = AppConstant.sapUserName;
    PostOrderLoginAPi.password = AppConstant.sapPassword;
    await PostOrderLoginAPi.getGlobalData().then((value) async {
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

          custserieserrormsg = value.error!.message!.value.toString();

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
            "Something went wrong !!..",
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

  callSerlaySalesOrderAPI(BuildContext context, ThemeData theme) async {
    await SerlaySalesOrderAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines.isNotEmpty) {
          sapSaleOrderModelData = value.documentLines;
          custserieserrormsg = '';
        } else {}
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
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
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
      } else {}
    });
  }

  callSalesOrderCancelAPI(BuildContext context, ThemeData theme) async {
    if (selectedcust2!.docStatus == 'O') {
      onDisablebutton = false;
      Get.defaultDialog(
          title: 'Warning',
          titleStyle: theme.textTheme.bodyMedium
              ?.copyWith(color: Colors.red, fontSize: 18),
          middleText: 'Do you want to cancel this document ?',
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    child: Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      width: Screens.width(context) * 0.07,
                      height: Screens.padingHeight(context) * 0.05,
                      child: Text(" Yes ",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white)),
                      alignment: Alignment.center,
                    ),
                    onPressed: () async {
                      Get.back();

                      notifyListeners();

                      log('step14');
                      onDisablebutton = true;
                      await callCancelApi(context, theme);
                      notifyListeners();
                    }),
                TextButton(
                  child: Container(
                    decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                    width: Screens.width(context) * 0.07,
                    height: Screens.padingHeight(context) * 0.05,
                    child: Text(
                      "No",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  onPressed: () {
                    onDisablebutton = false;

                    Get.back();
                  },
                ),
              ],
            ),
          ],
          radius: 5);
    } else if (selectedcust2!.docStatus == 'C') {
      cancelbtn = false;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'Document is already cancelled',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;

        notifyListeners();
      });
      notifyListeners();
    }
  }

  callCancelApi(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    await sapOrderLoginApi(
      context,
    );
    await SerlayOrderCancelAPI.getData(sapDocentry.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        cancelbtn = false;

        await DBOperation.updateSalesOrderclosedocsts(
            db, sapDocentry.toString());
        notifyListeners();

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
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          onDisablebutton = false;

          notifyListeners();
        });
        custserieserrormsg = '';
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;

        custserieserrormsg = value.exception!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.zero,
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
          onDisablebutton = false;
          notifyListeners();
        });
      } else {}
    });
    notifyListeners();
  }

  Future<int?> checkCredit(String typpe) {
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == typpe) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      fileterHoldData = holdData
          .where((e) =>
              e.cardName!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.date!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      fileterHoldData = holdData;
      notifyListeners();
    }
  }

  onHoldClicked(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    onDisablebutton = true;
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
        onDisablebutton = false;
        notifyListeners();
      });
    } else {
      selectedcust2 = null;
      scanneditemData2.clear();
      paymentWay2.clear();
      totalPayment2 = null;
      if (userTypes == 'user') {
        if (schemebtnclk == true) {
          await scehmeapiforckout(context, theme);
        }
      }
      await saveValuesTODB("hold", context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteHoldMaped(db, holddocentry).then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
        });
      }
      injectToDb();
      notifyListeners();
    }
    notifyListeners();
  }

  String udfType = '';
  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mycontroller[24].text = config.alignDate(datetype!);
    mycontroller[44].text = config.alignDate(datetype!);
    if (udfType == 'UDF') {
      udfController[2].text = config.alignDate(datetype!);
    }
  }

  recoveryGetDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100));

    datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mycontroller[24].text = config.alignDate(datetype!);
    mycontroller[44].text = config.alignDate(datetype!);
  }

  adjamt(BuildContext context, ThemeData theme) async {
    double availbal = selectedcust!.accBalance!;
    double.parse(mycontroller[36].text);
    if (availbal < 0) {
      if (availbal < 1) {
        addEnteredAmtType('Account Balance', context, 7, theme);
        selectedcust!.accBalance = availbal;
        notifyListeners();
      } else {
        msgforAmount = "Adjustment amount is greater than available amount";
        mycontroller[36].text = '';
        notifyListeners();
      }
      notifyListeners();
    } else {
      msgforAmount = "Adjustment amount is less than available amount";
      mycontroller[36].text = '';
      notifyListeners();
    }

    notifyListeners();
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

  pointconvert() {
    double availPointt = double.parse(mycontroller[37].text);
    double enteredPoint = double.parse(mycontroller[38].text);
    if (availPointt >= enteredPoint) {
      mycontroller[39].text = mycontroller[38].text;
      mycontroller[40].text = mycontroller[39].text;
    } else {
      msgforAmount = "Redeem points is greater than available points";
      mycontroller[38].text = '';
      mycontroller[40].text = '';
      mycontroller[39].text = '';
    }
    notifyListeners();
  }

  String? selectedType;
  List<String> get gettransType => transType;
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  String? paymentterm;
  String? wallet;
  String? coupon;
  double? tottpaid;
  String? baltopay;

  List<String> transType = [
    'NEFT',
    'RTGS',
    'IMPS',
  ];

  List payTerminal = [
    "Terminal - 1",
    "Terminal - 2",
    "Terminal - 3",
    "Terminal - 4",
  ];
  List get getpayTerminal => payTerminal;

  List walletlist = ['GPAY', 'PAYTM', 'PHONEPE', 'BAHRAT PE', 'MOBILE MONEY'];
  List get getwalletlist => walletlist;

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
  clearAllData(BuildContext context, ThemeData theme) {
    vatNoController.text = '';
    tinNoController.text = '';
    newCogsAccount = '';
    newGlAccount = '';
    onhandData = [];
    isLoading = false;
    clickAprList = false;
    newCashAcc = [];
    newSeriesCode = null;
    newSeriesName = null;
    whsName = null;
    whsLists = [];
    whsLists = [];

    whsCode = null;
    cashAcctype = null;
    cashAccCode = null;
    userTypes = '';
    cardAcctype = null;
    cardAccCode = null;
    chequeAcctype = null;
    chequeAccCode = null;
    transAcctype = null;
    transAccCode = null;
    walletAcctype = null;
    walletAccCode = null;
    loadingSqBtn = false;
    newCustAddData = [];
    visibleItemList = false;
    loadingSqBtn = false;
    seriesVal = [];
    filtersearchData = [];
    sapReceiptDocNum = '';
    custNameController.text = '';
    seriesType = '';
    openSalesQuot = [];
    cashpayment = null;
    bankhintcolor = false;

    sapReceiptDocentry = null;
    cashType = '';
    selectedBankType = null;
    selectbankCode = '';
    openQuotLineList = [];
    scanneditemData = [];
    creditType = '';
    udfType = '';
    cardType = '';
    chequeType = '';
    transferType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    accType = '';
    transpayment = null;
    addCardCode = '';
    selectedcust55 = null;
    cancelbtn = false;
    editqty = false;
    cpyfrmsq = false;
    searchcon.text = '';
    remarkcontroller3.text = '';
    catchmsg = [];
    custseriesNo = null;
    soData = [];
    cancelbtn = false;
    schemeData = [];
    schemebtnclk = false;
    pref = SharedPreferences.getInstance();
    loadingscrn = false;
    sapDocentry = '';
    sapDocuNumber = '';
    resSchemeDataList = [];
    formkey = List.generate(500, (i) => GlobalKey<FormState>());
    focusnode = List.generate(500, (i) => FocusNode());
    mycontroller = List.generate(500, (i) => TextEditingController());
    mycontroller2 = List.generate(500, (i) => TextEditingController());
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(500, (ij) => TextEditingController());
    discountcontroller = List.generate(500, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    udfController = List.generate(500, (ij) => TextEditingController());
    selectedcust = null;
    schemebtnclk = false;
    paymentWay.clear();
    billcreateNewAddress = [];
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    newCustValues = [];
    paymentWay2.clear();
    custList.clear();
    filtercustList.clear();
    scanneditemData.clear();
    scanneditemData2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    custList2.clear();
    shipaddress = '';
    msgforAmount = null;
    mycontroller[99].text = '';
    mycontroller[98].text = '';
    onDisablebutton = false;
    searchbool = false;
    totalPayment = null;
    totalPayment2 = null;
    filtersearchData.clear();
    selectedcust2 = null;
    searchData.clear();
    onHoldFilter!.clear();
    onHold.clear();
    totquantity = null;
    discountamt = null;
    totquantity = null;
    discountamt = null;
    newCustValues.clear();
    newBillAddrsValue.clear();
    newShipAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();
    udfClear();
    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    groupValueSelected = 0;
    valueSelectedOrder = null;
    valueSelectedGPApproval = null;
    itemsDocDetails.clear();
    searchAprvlData = [];
    filterAprvlData = [];
    bankList = [];
    isApprove = false;
    tbDocEntry = null;
    notifyListeners();
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

  viewSalesheader() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getSalesHeadHoldvalueDB(db);
    notifyListeners();
  }

  getcustBilladdresslist(
    BuildContext context,
  ) async {
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
          selectedBillAdress = selectedcust!.address!.length - 1;
        }
        notifyListeners();
      }
    }

    notifyListeners();
  }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust55!.cardCode!);

    selectedcust55!.address = [];
    for (int ia = 0; ia < csadresdataDB.length; ia++) {
      if (selectedcust55!.cardCode ==
          csadresdataDB[ia]['custcode'].toString()) {
        if (csadresdataDB[ia]['addresstype'].toString() == "S") {
          selectedcust55!.address!.add(
            Address(
              addresstype: csadresdataDB[ia]['addresstype'].toString(),
              autoId: int.parse(csadresdataDB[ia]['autoid'].toString()),
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

  Invoice? invoice = const Invoice();
  List<Address> address2 = [];

  addressxx() async {
    final Database db = (await DBHelper.getInstance())!;

    address2 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          selectedcust2!.cardCode.toString()) {
        address2.add(Address(
            autoId: int.parse(csadresdataDB[k].autoid.toString()),
            address1: csadresdataDB[k].address1 ?? '',
            address2: csadresdataDB[k].address2 ?? '',
            address3: csadresdataDB[k].address3 ?? '',
            custcode: csadresdataDB[k].custcode ?? '',
            billCity: csadresdataDB[k].city ?? '', //city
            billCountry: csadresdataDB[k].countrycode ?? '', //country
            billPincode: csadresdataDB[k].pincode ?? '', //pinno
            billstate: csadresdataDB[k].statecode ?? ''));
      }
      notifyListeners();
    }
  }

  List<SOCustomerAddModelData>? custDetails;
  List<CompanyAddressMdlData>? cmpnyDetails = [];
  callCompanyAddressApi() {
    CompanyAddressApii.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          cmpnyDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
  }

  soCustAddressApi(String docEntry) async {
    await SOCustAddressApii.getGlobalData(docEntry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          custDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    callCompanyAddressApi();
  }

  printingdoc(BuildContext context, ThemeData theme) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OrderprintLayout()));
    notifyListeners();
  }

  Future<void> callPrintApi(
    BuildContext context,
    ThemeData theme,
  ) async {
    onDisablebutton = true;

    SalesOrderPrintAPi.docEntry = sapDocentry;
    SalesOrderPrintAPi.slpCode = AppConstant.slpCode;

    await SalesOrderPrintAPi.getGlobalData().then((value) {
      if (value == 200) {
        onDisablebutton = false;
      } else {
        onDisablebutton = false;

        showSnackBar('Try again!!..', context);
      }
    });
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

  saveAllExcel(
    String path,
    BuildContext context,
    ThemeData theme,
  ) async {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: Screens.width(context) * 0.3,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text("Successfull Saved..",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.green,
                          )),

                      Text(
                        "Path Name:$path",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      //Buttons
                      SizedBox(
                        height: Screens.bodyheight(context) * 0.05,
                        width: Screens.width(context) * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            minimumSize: const Size(0, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Close',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  mapCallSalesOrderForPDF(preff, BuildContext context, ThemeData theme) async {
    List<InvoiceItem> itemsList = [];
    invoice = null;
    addressxx();

    for (int ihh = 0; ihh < scanneditemData2.length; ihh++) {
      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        itemcode: scanneditemData2[ihh].itemCode,
        descripton: scanneditemData2[ihh].itemName,
        unitPrice:
            double.parse(scanneditemData2[ihh].sellPrice!.toStringAsFixed(2)),
        quantity: scanneditemData2[ihh].qty,
        dics: scanneditemData2[ihh].discountper,
        vat: double.parse(scanneditemData2[ihh].taxvalue!.toStringAsFixed(2)),
      ));
      notifyListeners();
    }
    invoice = Invoice(
      headerinfo: InvoiceHeader(
          custcode: selectedcust2!.cardCode,
          ordReference: selectedcust2!.custRefNum ?? '',
          invDate: config.alignDate(selectedcust2!.invoiceDate.toString()),
          invNum: selectedcust2!.invoicenum,
          vatNo: '',
          companyName: 'companyName',
          //
          address: cmpnyDetails![0].companyAdd ?? '',
          area: 'area',
          pincode: 'pincode',
          mobile: 'mobile',
          gstNo: 'gstNo',
          docEntry: selectedcust2!.docentry,
          salesOrder: selectedcust2!.invoicenum),
      invoiceMiddle: InvoiceMiddle(
        date: selectedcust2!.invoiceDate.toString(),
        //
        time: 'time',
        customerName: selectedcust2!.name ?? '',
        paymentTerms: selectedcust2!.paymentGroup ?? '',
        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
        address: custDetails![0].address ?? '',
        printerName: custDetails![0].printHeadr ?? '',
        city: address2.isEmpty || address2[0].billCity.isEmpty
            ? ''
            : address2[0].billCity.toString(),
        area: address2.isEmpty || address2[0].address3!.isEmpty
            ? ''
            : address2[0].address3.toString(),
        pin: address2.isEmpty || address2[0].billPincode.isEmpty
            ? ''
            : address2[0].billPincode.toString(),
      ),
      items: itemsList,
    );

    notifyListeners();

    OrderprintLayout.subtotal = 0;
    OrderprintLayout.discountval = 0;
    OrderprintLayout.exclTxTotal = 0;
    OrderprintLayout.vatTx = 0;
    OrderprintLayout.inclTxTotal = 0;
    OrderprintLayout.carryoverval = 0;
    OrderprintLayout.discountper = 0;
    if (invoice!.items!.length > 0) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);

        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        OrderprintLayout.subtotal =
            OrderprintLayout.subtotal + invoice!.items![i].basic!;
        OrderprintLayout.discountper =
            OrderprintLayout.discountper + invoice!.items![i].dics!;
        OrderprintLayout.discountval =
            OrderprintLayout.discountval + invoice!.items![i].discountamt!;
        OrderprintLayout.exclTxTotal =
            (OrderprintLayout.exclTxTotal) + (invoice!.items![i].netTotal!);
        OrderprintLayout.vatTx = (OrderprintLayout.vatTx) +
            double.parse(invoice!.items![i].vat.toString());
        OrderprintLayout.carryoverval =
            OrderprintLayout.carryoverval + invoice!.items![i].netTotal!;

        notifyListeners();
      }
      OrderprintLayout.inclTxTotal =
          (OrderprintLayout.exclTxTotal) + (OrderprintLayout.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }

      OrderprintLayout.iinvoicee = invoice;
      await printingdoc(context, theme);
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AlertBox(
                  payMent: 'Alert',
                  errormsg: true,
                  widget: Center(
                      child: ContentContainer(
                    content: 'No Printing Bills',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkItemCode(db, "");
    notifyListeners();
  }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/PosDBV2.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sqlite Backup");
    return Future.value(copyTo);
  }

  Future<bool> getPermissionStorage() async {
    try {
      var statusStorage = await Permission.storage.status;
      if (statusStorage.isDenied) {
        Permission.storage.request();
        return Future.value(false);
      }
      if (statusStorage.isGranted) {
        return Future.value(true);
      }
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return Future.value(false);
  }

  showSnackBars(String e, Color color) {
    Get.showSnackbar(GetSnackBar(
      duration: const Duration(seconds: 3),
      title: "Warning..",
      message: e,
      backgroundColor: Colors.green,
    ));
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = copyTo!.path;
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/PosDBV2.db";
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }
}
