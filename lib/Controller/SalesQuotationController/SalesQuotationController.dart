import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/Service/QueryURL/CreditDaysModelAPI.dart';
import 'package:posproject/Service/QueryURL/CreditLimitModeAPI.dart';
import 'package:posproject/ServiceLayerAPIss/QuotationAPI/QuotationPostAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/SalesQuotationHead.dart';
import '../../DBModel/SalesQuotationLine.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';
import '../../Models/QueryUrlModel/OnhandModel.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/AccountBalModel.dart';
import '../../Models/Service Model/CusotmerSeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotStatusModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/GetQuotsforPutModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/approvals_details.modal.dart';
import '../../Pages/SalesQuotation/Widgets/QuotPrintLayout.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../Service/Printer/QuotationPrint.dart';
import '../../Service/QueryURL/CompanyVatTinApi.dart';
import '../../Service/QueryURL/OnHandApi.dart';
import '../../Service/QueryURL/SoCustomerAddressApi.dart';
import '../../Service/SearchQuery/SearchQuotHeaderApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotPatchAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotPutApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotSchemeApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/SalesQutDetails.dart';
import '../../Widgets/AlertBox.dart';
import '../../Pages/SalesOrder/Widgets/SOBar.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/LoginnAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/GetQuotationAPI.dart';
import '../../ServiceLayerAPIss/QuotationAPI/QuotationCancelAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class SalesQuotationCon extends ChangeNotifier {
  Configure config = Configure();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController custNameController = TextEditingController();
  TextEditingController tinNoController = TextEditingController();
  TextEditingController vatNoController = TextEditingController();

  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  GlobalKey<FormState> formkeyAd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAd = GlobalKey<FormState>();
  List<HoldedHeader> holdData = [];
  List<HoldedHeader> fileterHoldData = [];
  List<String> catchmsg = [];
  List<SalesOrderScheme> schemeData = [];
  List<SchemeOrderModalData> resSchemeDataList = [];
  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> pricemycontroller =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> itemNameController =
      List.generate(150, (i) => TextEditingController());

  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> discountcontroller2 =
      List.generate(100, (ij) => TextEditingController());

  TextEditingController remarkcontroller3 = TextEditingController();
  TextEditingController duedatecontroller = TextEditingController();
  String? filterapiwonDate = '';
  void showfromDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }
      duedatecontroller.clear();
      String chooseddate = value.toString();
      var date = DateTime.parse(chooseddate);
      chooseddate = "";
      chooseddate =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
      filterapiwonDate =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      // print(apiWonFDate);

      duedatecontroller.text = chooseddate;
      notifyListeners();
    });
  }

  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());
  List<TextEditingController> qtymycontroller2 =
      List.generate(100, (ij) => TextEditingController());
  TextEditingController searchcontroller = TextEditingController();
  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;
  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;

  List<StocksnapModelData> scanneditemCheckUpdateData = [];
  List<StocksnapModelData> get getscanneditemCheckUpdateData =>
      scanneditemCheckUpdateData;
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
  List<Map<String, dynamic>> newCustAddData = [];

  bool editqty = false;
  List<searchModel> searchData = [];
  bool searchmapbool = false;
  List<FocusNode> focusnode = List.generate(100, (i) => FocusNode());
  String holddocentry = '';

  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  List<SalesModel> salesmodl = [];
  List<SalesModel> onHold = [];
  List<SalesModel>? onHoldFilter = [];
  String? totquantity;
  double? discountamt;
  List<QuotDocumentLine> sapSsalesQuoline = [];
  List<QuotDocumentLine> sapcancelline = [];
  bool schemebtnclk = false;
  bool cancelbtn = false;
  String? custerrormsg = '';
  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  String sapDocentry = '';
  String sapDocuNumber = '';
  String cancelDocnum = '';
  int? cancelDocEntry;

  String? seriesNumvalue;
  String? custseriesNo;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  bool loadingBtn = false;
  bool addLoadingBtn = true;

  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  bool onDisablebutton = false;

  TextEditingController searchcon = TextEditingController();
  List<CustSeriesModelData> seriesData = [];
  //CustSeriesModelData
  List<ErrorModel> sererrorlist = [];
  double? tottpaid;
  String? baltopay;

  String exception = '';
  bool loading = false;
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;

  FilePickerResult? result;
  List<FilesData> filedata = [];
  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  bool groCustLoad = false;

  String? selectedValue;
  String? get getselectedValue => selectedValue;

  bool searchbool = false;
  double? totwieght = 0.0;
  double? totLiter = 0.0;
  String? shipaddress = "";
  int? tabledocentry;

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;

  bool checkboxx = false;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<AccountBalanceModelData> accBalList = [];
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  String textError = '';
  String vatfileError = '';
  String tinfileError = '';

  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  static List<QuatationLines> itemsDocDetails = [];

  Future<void> init(BuildContext context, ThemeData theme) async {
    clearAllData(context, theme);
    clearAll(context, theme);
    await callGetUserType();

    await injectToDb();
    await getCustDetFDB();
    await getdraftindex();
    await custSeriesApi();
    await callSeriesApi(context);
    notifyListeners();
  }

  clearAll(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    searchcontroller = TextEditingController();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    checkboxx = false;
    selectedcust = null;
    selectedcust2 = null;
    scanneditemData2 = [];
    searchData.clear();
    custList.clear();
    filtercustList.clear();
    custList2.clear();
    selectedBillAdress = 0;
    getSearchedData = [];
    notifyListeners();
    paymentWay.clear();
    itemData.clear();
    scanneditemData.clear();
    getfilterSearchedData = [];
    scanneditemData2.clear();
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    mycontroller[99].clear();
    focusnode = List.generate(100, (i) => FocusNode());
    notifyListeners();
  }

  Future<List<ItemMasterModelDB>> getAllList(String data) async {
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;
    log("getOrderSearchedData ${getSearchedData.length}");
    // searchcon.clear();
    notifyListeners();

    return getSearchedData;
  }

  bool visibleItemList = false;
  Future<List<ItemMasterModelDB>?> getAllListItem(String data) async {
    if (data.isNotEmpty) {
      log('message111');
      final Database db = (await DBHelper.getInstance())!;
      getSearchedData = await DBOperation.getSearchedStockList(db, data);
      getfilterSearchedData = getSearchedData;
      // searchcon.clear();
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

  String userTypes = '';
  callGetUserType() async {
    userTypes = '';
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> userData =
        await DBOperation.getusersvaldata(db, UserValues.username);
    if (userData.isNotEmpty) {
      userTypes = userData[0]['usertype'].toString().toLowerCase();
      log('userTypesuserTypesuserTypes::${userTypes}');
    }
    notifyListeners();
  }

  singleitemsearch(BuildContext context, ThemeData theme, int indx) async {
    // if (scanneditemData.isEmpty) {
    int res = checkhaveQty(indx, 0);

    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
      searchcon.clear();
    }
    // }
    // else {
    //   int result = await checkalreadyScanedd(indx);
    //   if (result != -1) {
    //     int res = checkhaveQty(indx, int.parse(qtymycontroller[result].text));
    //     if (res > 0) {
    //       incrementQty(result, '1', context, theme);
    //       notifyListeners();
    //     } else {
    //       Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
    //     }
    //   } else {
    //     addSannedItem(indx, context, theme);
    //     notifyListeners();
    //   }
    // }
  }

  onselectFst(BuildContext context, ThemeData theme, int indx) async {
    Navigator.pop(context);
    // if (scanneditemData.isEmpty) {
    int res = checkhaveQty(indx, 0);

    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
      searchcon.clear();
    }
    // } else {
    //   int result = await checkalreadyScanedd(indx);
    //   if (result != -1) {
    //     int res = checkhaveQty(indx, int.parse(qtymycontroller[result].text));
    //     if (res > 0) {
    //       incrementQty(result, '1', context, theme);
    //     } else {
    //       Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
    //     }
    //   } else {
    //     addSannedItem(indx, context, theme);
    //   }
    //   notifyListeners();
    // }
    // calCulateDocVal(context, theme);
  }

  int checkhaveQty(int ind, int scanedQty) {
    int res = 0;
    res = 1;
    return res;
  }

  incrementQty(int indxs, String qty, BuildContext context, ThemeData theme) {
    qtychangemtd(indxs, qty, context, theme);
  }

  postincrementQty(
      int indxs, String qty, BuildContext context, ThemeData theme) {
    postqtychangemtd(indxs, qty, context, theme);
  }

  doubleDotMethod(int i, String val, String type) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");
    double? sanitizedValue =
        double.tryParse(modifiedString2.split('.').join('.'));
    if (type == 'Qty') {
      qtymycontroller[i].text = modifiedString2.toString();
      log(qtymycontroller[i].text);
    } // Output: example-text-with-double-dots
    else if (type == 'Price') {
      pricemycontroller[i].text = modifiedString2.toString();
    }
    notifyListeners();
  }

  qtyEdited(int indx, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    log('scanneditemCheckUpdateData update111::${scanneditemCheckUpdateData.length}:::${scanneditemData.length}');
    log("scaQtyyy11 : ${qtymycontroller[indx].text.toString()}");

    if (qtymycontroller[indx].text.isEmpty ||
        double.parse(qtymycontroller[indx].text.toString()) == removeqty) {
      scanneditemData.removeAt(indx);
      discountcontroller.removeAt(indx);
      qtymycontroller.removeAt(indx);
      calCulateDocVal(context, theme);
      notifyListeners();
    } else {
      incrementQty(indx, '0', context, theme);
      notifyListeners();
    }
    log('scanneditemCheckUpdateData update::${scanneditemCheckUpdateData.length}:::${scanneditemData.length}');
    notifyListeners();
  }

  postqtyreadonly() {
    editqty = true;
    notifyListeners();
  }

  postqtyEdited(int indx, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    log("scaQtyyy : ${qtymycontroller2[indx].text.toString()}");

    if (qtymycontroller2[indx].text.isEmpty ||
        double.parse(qtymycontroller2[indx].text.toString()) == removeqty) {
      discountcontroller2.removeAt(indx);
      qtymycontroller2.removeAt(indx);
      scanneditemData2.removeAt(indx);
      calCulateDocVal2(context, theme);
      notifyListeners();
    } else {
      postincrementQty(indx, '0', context, theme);
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

  itemnameChanged(
    int index,
    BuildContext context,
    ThemeData theme,
  ) async {
    scanneditemData[index].itemName = itemNameController[index].text.toString();
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
    log('getfilterSearchedData[ind].uPackSize.toString()::${getfilterSearchedData[ind].uPackSize.toString()}');
    scanneditemData.add(StocksnapModelData(
        transID: 0,
        branch: '',
        itemCode: getfilterSearchedData != null
            ? getfilterSearchedData[ind].itemcode
            : getfilterSearchedData[ind].itemnameshort,
        itemName: getfilterSearchedData[ind].itemnameshort,
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
        maxdiscount: getfilterSearchedData[ind]
            .maxdiscount
            .toString(), // getfilterSearchedData[ind].d,
        createdUserID: '',
        createdateTime: '',
        lastupdateIp: '',
        purchasedate: '',
        snapdatetime: '',
        specialprice: 0,
        updatedDatetime: '',
        uPackSize: getfilterSearchedData[ind].uPackSize.isNotEmpty
            ? double.parse(getfilterSearchedData[ind].uPackSize)
            : null,
        uPackSizeuom: getfilterSearchedData[ind].uPackSizeuom,
        uSpecificGravity:
            double.parse(getfilterSearchedData[ind].uSpecificGravity),
        uTINSPERBOX: getfilterSearchedData[ind].uTINSPERBOX,
        updateduserid: '',
        discountper: 0.0,
        liter: double.parse(getfilterSearchedData[ind].liter.toString()),
        weight: double.parse(getfilterSearchedData[ind].weight.toString())));

    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].transID = i;
      pricemycontroller[i].text = scanneditemData[i].sellPrice.toString();
      discountcontroller[i].text = scanneditemData[i].discountper.toString();
      itemNameController[i].text = scanneditemData[i].itemName.toString();

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
      log('scanneditemData[i].packsize::${scanneditemData[i].uPackSize}');
    }

    qtychangemtd(scanneditemData.length - 1, '1', context, theme);
    searchcon.text = '';
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

  postqtychangemtd(int ind, String qty, BuildContext context, ThemeData theme) {
    String added = (double.parse(qty) +
            double.parse(qtymycontroller2[ind].text.isEmpty
                ? '0'
                : qtymycontroller2[ind].text))
        .toString();
    qtymycontroller2[ind].text = added;
    scanneditemData2[ind].qty = double.parse(added);
    calCulateDocVal2(context, theme);
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

  calculatescheme(BuildContext context, ThemeData theme) async {
    log('discount1::${resSchemeDataList.length}');
    for (int i = 0; i < scanneditemData.length; i++) {
      discountcontroller[i].text = 0.0.toString();
      scanneditemData[i].discountper = 0.0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData.length; i++) {
      for (int ik = 0; ik < resSchemeDataList.length; ik++) {
        if (resSchemeDataList[ik].lineNum == scanneditemData[i].transID) {
          // discountt = discountt + resSchemeDataList[ik].discPer;

          scanneditemData[i].discountper =
              scanneditemData[i].discountper! + resSchemeDataList[ik].discPer;
          discountcontroller[i].text =
              scanneditemData[i].discountper!.toString();
          log(' discountcontroller[i].text ::${scanneditemData[i].discountper}');

          notifyListeners();
        }
      }

      // discountcontroller[i].text = discountt.toString();
    }
    await calCulateDocVal(context, theme);
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

    await sapLoginApi(context);
    log('sessionid::${AppConstant.sapSessionID}');
    await SeriesAPi.getGlobalData('23').then((value) async {
      if (value.stsCode! >= 200 && value.stsCode! <= 210) {
        if (value.seriesvalue != null) {
          seriesVal = value.seriesvalue!;
          log('seriesValseriesVal length::${seriesVal.length}');
          notifyListeners();
          List<Map<String, Object?>> branchdata =
              await DBOperation.getBrnachbyCode(db, AppConstant.branch);
          for (var i = 0; i < seriesVal.length; i++) {
            for (var ik = 0; ik < branchdata.length; ik++) {
              if (branchdata[ik]['WhsName'].toString() == seriesVal[i].name) {
                seriesType = seriesVal[i].series.toString();
                log('seriesType::$seriesType');
                notifyListeners();
              }
              notifyListeners();
            }
          }
        }
      } else {}
    });

    notifyListeners();
  }

  callSchemeOrderAPi() async {
    catchmsg = [];
    resSchemeDataList = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      discountcontroller[i].text = 0.0.toString();
      scanneditemData[i].discountper = 0.0;

      notifyListeners();
    }
    await SchemeQuteAPi.getGlobalData(schemeData).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        resSchemeDataList = [];

        if (value.saleOrder != null) {
          log('value.saleOrder::${value.saleOrder![0].discPer}');

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

  salesOrderSchemeData() async {
    schemeData = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      schemeData.add(SalesOrderScheme(
        itemCode: scanneditemData[i].itemCode.toString(),
        priceBefDi: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
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

  void selectVatattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      vatfileError = "";

      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        vatFiles = filesz[i];
        notifyListeners();
      }
    } else {
      textError = "Select a VAT File";
    }
    notifyListeners();
  }

  clearVatFile() {
    vatFiles = null;
    notifyListeners();
  }

  void selectattachment() async {
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      tinfileError = "";
      for (int i = 0; i < filesz.length; i++) {
        tinFiles = filesz[i];
        notifyListeners();
      }
    } else if (tinFiles == null) {
      tinfileError = "Select a Tin File";
      notifyListeners();
    }
    notifyListeners();
  }

  custSeriesApi() async {
    mycontroller[24].text = AppConstant.slpCode.toString();
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

  clickaEditBtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getheaderData =
        await DBOperation.salesQuoCancellQuery(db, cancelDocEntry.toString());
    if (getheaderData.isNotEmpty) {
      if (getheaderData[0]['basedocentry'].toString() ==
          cancelDocEntry.toString()) {
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
                      content:
                          'This document is already converted into sales order',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          cancelDocnum = '';
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust = null;
          selectedcust55 = null;
          paymentWay.clear();
          scanneditemData.clear();
          cancelbtn = false;
          selectedcust55 = null;
          selectedcust = null;
          scanneditemData.clear();
          totalPayment = null;
          injectToDb();
          getdraftindex();
          remarkcontroller3.text = '';
          searchmapbool = false;
          notifyListeners();
        });
      }
    } else if (sapDocentry.isEmpty) {
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        cancelDocnum = '';
        sapDocentry = '';
        sapDocuNumber = '';
        selectedcust = null;
        selectedcust55 = null;
        paymentWay.clear();
        scanneditemData.clear();
        cancelbtn = false;
        selectedcust55 = null;
        selectedcust = null;
        scanneditemData.clear();
        totalPayment = null;
        injectToDb();
        getdraftindex();
        remarkcontroller3.text = '';
        searchmapbool = false;
        notifyListeners();
      });
    } else {
      // await sapLoginApi(context);
      // await callSerlaySalesQuoAPI(context, theme);
      await checkSAPsts(context, theme);
      notifyListeners();
    }
  }

  checkSAPsts(BuildContext context, ThemeData theme) async {
    if (scanneditemData2.isNotEmpty) {
      // for (int ij = 0; ij < scanneditemData2.length; ij++) {
      if (selectedcust2!.docStatus == "O") {
        newUpdateFixDataMethod(context, theme);

        // await updateFixDataMethod(context, theme);
      } else if (selectedcust2!.docStatus == "C") {
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
                      content: 'Document is already cancelled',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          // sapDocentry = '';
          // sapDocuNumber = '';
          // sapDocentry = '';
          // sapDocuNumber = '';
          // selectedcust2 = null;
          // scanneditemData2.clear();
          // selectedcust25 = null;
          // cancelbtn = false;
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
                contentPadding: const EdgeInsets.all(0),
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

  clickacancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isNotEmpty) {
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getheaderData =
          await DBOperation.salesQuoCancellQuery(db, cancelDocEntry.toString());
      if (getheaderData.isNotEmpty) {
        if (getheaderData[0]['basedocentry'].toString() ==
            cancelDocEntry.toString()) {
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
                        content:
                            'This document is already converted into sales order',
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
            searchmapbool = false;
            notifyListeners();
          });
        }
      } else {
        // await callSerlaySalesQuoAPI(context, theme);
        await callSerlaySalesCancelQuoAPI(context, theme);
        notifyListeners();
      }
    } else {
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
        searchmapbool = false;
        notifyListeners();
      });
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostLoginAPi.getGlobalData().then((value) async {
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
    log("AppConstant.sapSessionID xx::${AppConstant.sapSessionID}");
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");

    await SerlaySalesQuoAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines!.isNotEmpty) {
          sapSsalesQuoline = value.documentLines!;

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
          selectedcust25 = null;
          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
      } else {}
    });
  }

  custCodeReadOnly() {
    log('seriesValueAA $custseriesNo');
    if (custseriesNo.toString().toLowerCase() == '218') {
      seriesValuebool = false;
      notifyListeners();
    } else {
      seriesValuebool = true;
      notifyListeners();
    }
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

  callCustPostApi(BuildContext context) async {
    loadingBtn = true;
    await addFiles();
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");

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
    newCutomerModel.additionalID = mycontroller[22].text;
    newCutomerModel.federalTaxID = mycontroller[23].text;
    newCutomerModel.cellular = mycontroller[4].text;
    newCutomerModel.salesPersonCode =
        mycontroller[24].text.isEmpty ? null : int.parse(mycontroller[24].text);
    newCutomerModel.contactPerson = mycontroller[25].text;
    newCutomerModel.creditLimit = mycontroller[26].text.isEmpty
        ? null
        : int.parse(
            mycontroller[26].text.replaceAll(",", "").replaceAll(".", ""));
    newCutomerModel.notes = mycontroller[27].text;
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
        state: '', // mycontroller[12].text,
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
    newCutomerModel.contEmp = [ContactEmployees(name: mycontroller[25].text)];
    await PostCustCreateAPi.getGlobalData(newCutomerModel).then((value) async {
      loadingBtn = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.cardCode.toString();

        await insertAddNewCusToDB(context);

        config.showDialogSucessB(
            "Customer created successfully ..!!", "Success");
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config
            .showDialogg("Something went wrong try agian..!!", "Failed")
            .then((value) => Navigator.pop(context));
      }
    });
    notifyListeners();
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    notifyListeners();
    if (scanneditemData2.isNotEmpty) {
      // for (int ij = 0; ij < sapSsalesQuoline.length; ij++) {
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
        onDisablebutton = true;

        cancelbtn = false;
        log('Already cancelled');
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
                      content: 'Document is already cancelled',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          // sapDocentry = '';
          // sapDocuNumber = '';
          // sapDocentry = '';
          // sapDocuNumber = '';
          onDisablebutton = false;

          // selectedcust2 = null;
          // scanneditemData2.clear();
          // selectedcust25 = null;
          // cancelbtn = false;
          notifyListeners();
        });
        notifyListeners();
      }
      // }
    }
    notifyListeners();
  }

  callCancelApi(BuildContext context, ThemeData theme) async {
    onDisablebutton = true;

    final Database db = (await DBHelper.getInstance())!;
    await sapLoginApi(context);

    await SerlayCancelQuoAPI.getData(sapDocentry.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 204) {
        cancelbtn = false;
        await DBOperation.updateSalesQuoclosedocsts(db, sapDocentry.toString());
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
          scanneditemData2.clear();
          selectedcust25 = null;
          onDisablebutton = false;
          notifyListeners();
        });
        custserieserrormsg = '';
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        cancelbtn = false;
        log('Already cancelled');
        custserieserrormsg = value.exception!.message.toString();
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
          selectedcust2 = null;
          selectedcust25 = null;
          onDisablebutton = false;

          paymentWay2.clear();
          scanneditemData2.clear();
          notifyListeners();
        });
      } else {}
    });
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

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;
    List<HoldedHeader> holdData = [];
    fileterHoldData = [];
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesQuoHeadHoldvalueDB(db);
    for (int i = 0; i < getholddata.length; i++) {
      holdData.add(HoldedHeader(
          vatNo: getholddata[i]['VatNo'].toString(),
          tinNo: getholddata[i]['TinNo'].toString(),
          cardName: getholddata[i]['customername'].toString(),
          cardcode: getholddata[i]['customercode'].toString(),
          docEntry: int.parse(getholddata[i]['docentry'].toString()),
          docNo: getholddata[i]['documentno'].toString(),
          date: getholddata[i]['createdateTime'].toString()));
      notifyListeners();
    }
    fileterHoldData = holdData;
    notifyListeners();
  }

  mapHoldSelectedValues(
      HoldedHeader holddata, BuildContext context, ThemeData theme) async {
    holddocentry = '';
    loadingscrn = true;

    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>>? getDBholdSalesLine =
        await DBOperation.getSalesQuoLineDB(
            db, int.parse(holddata.docEntry.toString()));

    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, holddata.cardcode.toString());
    callGetUserType();
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(db, holddata.cardcode.toString());

    holddocentry = holddata.docEntry.toString();

    tinNoController.text = holddata.tinNo.toString();
    vatNoController.text = holddata.vatNo.toString();

    await mapCustomer(context, theme, getcustomer, getcustaddd);
    await CustCreditDaysAPI.getGlobalData(
      holddata.cardcode.toString(),
    ).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditDaysData != null) {
          // log('yyyyyyyyyy::${value.creditDaysData![0].creditDays.toString()}');

          selectedcust!.creditDays =
              value.creditDaysData![0].creditDays.toString();
          selectedcust!.paymentGroup =
              value.creditDaysData![0].paymentGroup.toString().toLowerCase();
          log('selectedcust paymentGroup::${selectedcust!.paymentGroup!}');
          if (selectedcust!.paymentGroup!.contains('cash') == true) {
            selectedcust!.name = holddata.cardName;
            custNameController.text = holddata.cardName!;
          } else {
            selectedcust!.name = getcustomer[0]['customername'].toString();
          }
          log('Cash paymentGroup::${selectedcust!.paymentGroup!.contains('cash')}');
          notifyListeners();
        }
        loadingscrn = false;
      }
    });
    mapProdcut(getDBholdSalesLine, context, theme);
    getCustDetFDB();
    calCulateDocVal(context, theme);
    notifyListeners();
  }

  mapCustomer(
      BuildContext context,
      ThemeData theme,
      List<Map<String, Object?>> custData,
      List<Map<String, Object?>> getcustaddd) async {
    final Database db = (await DBHelper.getInstance())!;
    double? updateCustBal1;
    selectedcust = null;
    selectedcust55 = null;
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesQuoHeadHoldvalueDB(db);
    selectedcust = CustomerDetals(
      name: '',
      // custData[0]['customername'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      taxCode: custData[0]['taxCode'].toString(),
      cardCode: custData[0]['customerCode'].toString(),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
      autoId: custData[0]['autoid'].toString(),
    );
    notifyListeners();

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
            notifyListeners();
          }
        }

        if (getholddata[ik]['shipaddresid'].toString().isNotEmpty) {
          if (getholddata[ik]['shipaddresid'].toString() ==
              getcustaddd[i]['autoid'].toString()) {
            selectedcust55 = CustomerDetals(
              name: '',
              // custData[0]['customername'].toString(),
              taxCode: custData[0]['taxCode'].toString(),
              phNo: custData[0]['phoneno1'].toString(),
              cardCode: custData[0]['customerCode'].toString(),
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
            notifyListeners();
          }
        }
      }
    }

    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        updateCustBal1 =
            double.parse(value.accBalanceData![0].balance.toString());

        notifyListeners();
      }
    });
    selectedcust!.accBalance =
        updateCustBal1 ?? double.parse(custData[0]['balance'].toString());
    if (selectedcust55 != null) {
      log('selectedcust55  cardCode:::${selectedcust55!.cardCode.toString()}');
      selectedcust55!.accBalance =
          updateCustBal1 ?? double.parse(custData[0]['balance'].toString());
    }

    notifyListeners();
  }

  mapProdcut(List<Map<String, Object?>> lineData, BuildContext context,
      ThemeData theme) {
    scanneditemData = [];
    for (int i = 0; i < lineData.length; i++) {
      scanneditemData.add(StocksnapModelData(
          basic: lineData[i]['basic'] != null
              ? double.parse(lineData[i]['basic'].toString())
              : 00,
          netvalue: lineData[i]['netlinetotal'] != null
              ? double.parse(lineData[i]['netlinetotal'].toString())
              : null,
          docentry: lineData[i]['docentry'].toString(),
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
          uPackSize: lineData[i]['U_Pack_Size'] == null
              ? 0.0
              : double.parse(lineData[i]['U_Pack_Size'].toString()),
          uPackSizeuom: lineData[i]['U_Pack_Size_uom'] != null
              ? lineData[i]['U_Pack_Size_uom'].toString()
              : '',
          uSpecificGravity: lineData[i]['U_Specific_Gravity'] != null
              ? double.parse(lineData[i]['U_Specific_Gravity'].toString())
              : 0, // double.parse(getfilterSearchedData[ind].maxdiscount.toString()),
          uTINSPERBOX: lineData[i]['U_TINS_PER_BOX'] != null
              ? int.parse(
                  lineData[i]['U_TINS_PER_BOX'].toString(),
                )
              : 0,
          liter: lineData[i]['liter'] == null
              ? 0.0
              : double.parse(lineData[i]['liter'].toString()),
          weight: lineData[i]['weight'] == null
              ? 0.0
              : double.parse(lineData[i]['weight'].toString())));
    }
    notifyListeners();
    for (int ig = 0; ig < scanneditemData.length; ig++) {
      scanneditemData[ig].transID = ig;
      pricemycontroller[ig].text = scanneditemData[ig].sellPrice!.toString();
      discountcontroller[ig].text = scanneditemData[ig].discountper!.toString();
      itemNameController[ig].text = scanneditemData[i].itemName.toString();

      qtymycontroller[ig].text = scanneditemData[ig].openQty!.toString();
      notifyListeners();
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
        couponcode: "", //getDBholdSalespay[i]['couponcode'].toString(),
        coupontype: "", //getDBholdSalespay[i]['coupontype'].toString(),
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
        total = total +
            (scanneditemData2[i].liter! *
                double.parse(scanneditemData2[i].qty.toString()));
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
              e.cardCode.toLowerCase().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()) ||
              e.cardName.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchHeader;
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

  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  List<OpenSalesOrderHeaderData> searchHeader = [];
  List<OpenSalesOrderHeaderData> filtersearchData = [];

  callSearchHeaderApi() async {
    await SerachQuotationHeadAPi.getGlobalData(
            config.alignDate2(mycontroller[100].text),
            config.alignDate2(mycontroller[101].text))
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        searchHeader = value.activitiesData!;

        filtersearchData = searchHeader;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        notifyListeners();
      }
    });
  }

  static ApprovalDetailsPutValue? approvalDetailsValue;

  List<DocumentApprovalPutValue> getdocumentApprovalValue = [];
  List<DocumentApprovalPutValue> getdocitemsDetailsData = [];

  delputHeaderValues() {
    itemsDetailsData = [];
    scanneditemCheckUpdateData = [];
    // getdocumentApprovalValue = ContentEditCreationState.contentitemsDetails;
    // approvalDetailsValue = SalesDetailsQuotState.approvalDetailsValue;
    quotputdataval = QuotPutModel(
      odataMetadata: approvalDetailsValue!.odataMetadata == null ||
              approvalDetailsValue!.odataMetadata == "null"
          ? null
          : approvalDetailsValue!.odataMetadata,
      odataEtag: approvalDetailsValue!.odataEtag == null ||
              approvalDetailsValue!.odataEtag == "null"
          ? null
          : approvalDetailsValue!.odataEtag,
      docEntry: approvalDetailsValue!.docEntry == null ||
              approvalDetailsValue!.docEntry == "null"
          ? null
          : approvalDetailsValue!.docEntry,
      docNum: approvalDetailsValue!.docNum == null ||
              approvalDetailsValue!.docNum == "null"
          ? null
          : approvalDetailsValue!.docNum,
      docType: approvalDetailsValue!.docType == null ||
              approvalDetailsValue!.docType == "null"
          ? null
          : approvalDetailsValue!.docType,
      handWritten: approvalDetailsValue!.handWritten == null ||
              approvalDetailsValue!.handWritten == "null"
          ? null
          : approvalDetailsValue!.handWritten,
      printed: approvalDetailsValue!.printed == null ||
              approvalDetailsValue!.printed == "null"
          ? null
          : approvalDetailsValue!.printed,
      docDate: approvalDetailsValue!.docDate == null ||
              approvalDetailsValue!.docDate == "null"
          ? null
          : approvalDetailsValue!.docDate,
      docDueDate: approvalDetailsValue!.docDueDate == null ||
              approvalDetailsValue!.docDueDate == "null"
          ? null
          : approvalDetailsValue!.docDueDate,
      cardCode: approvalDetailsValue!.cardCode == null ||
              approvalDetailsValue!.cardCode == "null"
          ? null
          : approvalDetailsValue!.cardCode,
      cardName: approvalDetailsValue!.cardName == null ||
              approvalDetailsValue!.cardName == "null"
          ? null
          : approvalDetailsValue!.cardName,
      address: approvalDetailsValue!.address == null ||
              approvalDetailsValue!.address == "null"
          ? null
          : approvalDetailsValue!.address,
      numAtCard: approvalDetailsValue!.numAtCard == null ||
              approvalDetailsValue!.numAtCard == "null"
          ? null
          : approvalDetailsValue!.numAtCard,
      docTotal: approvalDetailsValue!.docTotal == null ||
              approvalDetailsValue!.docTotal == "null"
          ? null
          : approvalDetailsValue!.docTotal,
      attachmentEntry: approvalDetailsValue!.attachmentEntry == null ||
              approvalDetailsValue!.attachmentEntry == "null"
          ? null
          : approvalDetailsValue!.attachmentEntry,
      docCurrency: approvalDetailsValue!.docCurrency == null ||
              approvalDetailsValue!.docCurrency == "null"
          ? null
          : approvalDetailsValue!.docCurrency,
      docRate: approvalDetailsValue!.docRate == null ||
              approvalDetailsValue!.docRate == "null"
          ? null
          : approvalDetailsValue!.docRate,
      reference1: approvalDetailsValue!.reference1 == null ||
              approvalDetailsValue!.reference1 == "null"
          ? null
          : approvalDetailsValue!.reference1,
      reference2: approvalDetailsValue!.reference2 == null ||
              approvalDetailsValue!.reference2 == "null"
          ? null
          : approvalDetailsValue!.reference2,
      comments: approvalDetailsValue!.comments == null ||
              approvalDetailsValue!.comments == "null"
          ? null
          : approvalDetailsValue!.comments,
      journalMemo: approvalDetailsValue!.journalMemo == null ||
              approvalDetailsValue!.journalMemo == "null"
          ? null
          : approvalDetailsValue!.journalMemo,
      paymentGroupCode: approvalDetailsValue!.paymentGroupCode == null ||
              approvalDetailsValue!.paymentGroupCode == "null"
          ? null
          : approvalDetailsValue!.paymentGroupCode,
      docTime: approvalDetailsValue!.docTime == null ||
              approvalDetailsValue!.docTime == "null"
          ? null
          : approvalDetailsValue!.docTime,
      salesPersonCode: approvalDetailsValue!.salesPersonCode == null ||
              approvalDetailsValue!.salesPersonCode == "null"
          ? null
          : approvalDetailsValue!.salesPersonCode,
      transportationCode: approvalDetailsValue!.transportationCode == null ||
              approvalDetailsValue!.transportationCode == "null"
          ? null
          : approvalDetailsValue!.transportationCode,
      confirmed: approvalDetailsValue!.confirmed == null ||
              approvalDetailsValue!.confirmed == "null"
          ? null
          : approvalDetailsValue!.confirmed,
      importFileNum: approvalDetailsValue!.importFileNum == null ||
              approvalDetailsValue!.importFileNum == "null"
          ? null
          : approvalDetailsValue!.importFileNum!,
      summeryType: approvalDetailsValue!.summeryType == null ||
              approvalDetailsValue!.summeryType == "null"
          ? null
          : approvalDetailsValue!.summeryType,
      contactPersonCode: approvalDetailsValue!.contactPersonCode == null ||
              approvalDetailsValue!.contactPersonCode == "null"
          ? null
          : approvalDetailsValue!.contactPersonCode,
      showScn: approvalDetailsValue!.showScn == null ||
              approvalDetailsValue!.showScn == "null"
          ? null
          : approvalDetailsValue!.showScn,
      series: approvalDetailsValue!.series == null ||
              approvalDetailsValue!.series == "null"
          ? null
          : approvalDetailsValue!.series,
      taxDate: approvalDetailsValue!.taxDate == null ||
              approvalDetailsValue!.taxDate == "null"
          ? null
          : approvalDetailsValue!.taxDate,
      partialSupply: approvalDetailsValue!.partialSupply == null ||
              approvalDetailsValue!.partialSupply == "null"
          ? null
          : approvalDetailsValue!.partialSupply,
      docObjectCode: approvalDetailsValue!.docObjectCode == null ||
              approvalDetailsValue!.docObjectCode == "null"
          ? null
          : approvalDetailsValue!.docObjectCode,
      shipToCode: approvalDetailsValue!.shipToCode == null ||
              approvalDetailsValue!.shipToCode == "null"
          ? null
          : approvalDetailsValue!.shipToCode,
      indicator: approvalDetailsValue!.indicator == null ||
              approvalDetailsValue!.indicator == "null"
          ? null
          : approvalDetailsValue!.indicator,
      federalTaxId: approvalDetailsValue!.federalTaxId == null ||
              approvalDetailsValue!.federalTaxId == "null"
          ? null
          : approvalDetailsValue!.federalTaxId,
      discountPercent: approvalDetailsValue!.discountPercent == null ||
              approvalDetailsValue!.discountPercent == "null"
          ? null
          : approvalDetailsValue!.discountPercent,
      paymentReference: approvalDetailsValue!.paymentReference == null ||
              approvalDetailsValue!.paymentReference == "null"
          ? null
          : approvalDetailsValue!.paymentReference,
      creationDate: approvalDetailsValue!.creationDate == null ||
              approvalDetailsValue!.creationDate == "null"
          ? null
          : approvalDetailsValue!.creationDate,
      updateDate: approvalDetailsValue!.updateDate == null ||
              approvalDetailsValue!.updateDate == "null"
          ? null
          : approvalDetailsValue!.updateDate,
      financialPeriod: approvalDetailsValue!.financialPeriod == null ||
              approvalDetailsValue!.financialPeriod == "null"
          ? null
          : approvalDetailsValue!.financialPeriod,
      userSign: approvalDetailsValue!.userSign == null ||
              approvalDetailsValue!.userSign == "null"
          ? null
          : approvalDetailsValue!.userSign,
      transNum: approvalDetailsValue!.transNum == null ||
              approvalDetailsValue!.transNum == "null"
          ? null
          : approvalDetailsValue!.transNum,
      vatSum: approvalDetailsValue!.vatSum == null ||
              approvalDetailsValue!.vatSum == "null"
          ? null
          : approvalDetailsValue!.vatSum,
      vatSumSys: approvalDetailsValue!.vatSumSys == null ||
              approvalDetailsValue!.vatSumSys == "null"
          ? null
          : approvalDetailsValue!.vatSumSys,
      vatSumFc: approvalDetailsValue!.vatSumFc == null ||
              approvalDetailsValue!.vatSumFc == "null"
          ? null
          : approvalDetailsValue!.vatSumFc,
      netProcedure: approvalDetailsValue!.netProcedure == null ||
              approvalDetailsValue!.netProcedure == "null"
          ? null
          : approvalDetailsValue!.netProcedure,
      docTotalFc: approvalDetailsValue!.docTotalFc == null ||
              approvalDetailsValue!.docTotalFc == "null"
          ? null
          : approvalDetailsValue!.docTotalFc,
      docTotalSys: approvalDetailsValue!.docTotalSys == null ||
              approvalDetailsValue!.docTotalSys == "null"
          ? null
          : approvalDetailsValue!.docTotalSys,
      form1099: approvalDetailsValue!.form1099 == null ||
              approvalDetailsValue!.form1099 == "null"
          ? null
          : approvalDetailsValue!.form1099,
      box1099: approvalDetailsValue!.box1099 == null ||
              approvalDetailsValue!.box1099 == "null"
          ? null
          : approvalDetailsValue!.box1099,
      revisionPo: approvalDetailsValue!.revisionPo == null ||
              approvalDetailsValue!.revisionPo == "null"
          ? null
          : approvalDetailsValue!.revisionPo,
      requriedDate: approvalDetailsValue!.requriedDate == null ||
              approvalDetailsValue!.requriedDate == "null"
          ? null
          : approvalDetailsValue!.requriedDate,
      cancelDate: approvalDetailsValue!.cancelDate == null ||
              approvalDetailsValue!.cancelDate == "null"
          ? null
          : approvalDetailsValue!.cancelDate,
      blockDunning: approvalDetailsValue!.blockDunning == null ||
              approvalDetailsValue!.blockDunning == "null"
          ? null
          : approvalDetailsValue!.blockDunning,
      submitted: approvalDetailsValue!.submitted == null ||
              approvalDetailsValue!.submitted == "null"
          ? null
          : approvalDetailsValue!.submitted,
      segment: approvalDetailsValue!.segment == null ||
              approvalDetailsValue!.segment == "null"
          ? null
          : approvalDetailsValue!.segment,
      pickStatus: approvalDetailsValue!.pickStatus == null ||
              approvalDetailsValue!.pickStatus == "null"
          ? null
          : approvalDetailsValue!.pickStatus,
      pick: approvalDetailsValue!.pick == null ||
              approvalDetailsValue!.pick == "null"
          ? null
          : approvalDetailsValue!.pick,
      paymentMethod: approvalDetailsValue!.paymentMethod == null ||
              approvalDetailsValue!.paymentMethod == "null"
          ? null
          : approvalDetailsValue!.paymentMethod,
      paymentBlock: approvalDetailsValue!.paymentBlock == null ||
              approvalDetailsValue!.paymentBlock == "null"
          ? null
          : approvalDetailsValue!.paymentBlock,
      paymentBlockEntry: approvalDetailsValue!.paymentBlockEntry == null ||
              approvalDetailsValue!.paymentBlockEntry == "null"
          ? null
          : approvalDetailsValue!.paymentBlockEntry,
      centralBankIndicator:
          approvalDetailsValue!.centralBankIndicator == null ||
                  approvalDetailsValue!.centralBankIndicator == "null"
              ? null
              : approvalDetailsValue!.centralBankIndicator,
      maximumCashDiscount: approvalDetailsValue!.maximumCashDiscount == null ||
              approvalDetailsValue!.maximumCashDiscount == "null"
          ? null
          : approvalDetailsValue!.maximumCashDiscount,
      reserve: approvalDetailsValue!.reserve == null ||
              approvalDetailsValue!.reserve == "null"
          ? null
          : approvalDetailsValue!.reserve,
      project: approvalDetailsValue!.project == null ||
              approvalDetailsValue!.project == "null"
          ? null
          : approvalDetailsValue!.project,
      exemptionValidityDateFrom:
          approvalDetailsValue!.exemptionValidityDateFrom == null ||
                  approvalDetailsValue!.exemptionValidityDateFrom == "null"
              ? null
              : approvalDetailsValue!.exemptionValidityDateFrom,
      exemptionValidityDateTo:
          approvalDetailsValue!.exemptionValidityDateTo == null ||
                  approvalDetailsValue!.exemptionValidityDateTo == "null"
              ? null
              : approvalDetailsValue!.exemptionValidityDateTo,
      wareHouseUpdateType: approvalDetailsValue!.wareHouseUpdateType == null ||
              approvalDetailsValue!.wareHouseUpdateType == "null"
          ? null
          : approvalDetailsValue!.wareHouseUpdateType,
      rounding: approvalDetailsValue!.rounding == null ||
              approvalDetailsValue!.rounding == "null"
          ? null
          : approvalDetailsValue!.rounding,
      externalCorrectedDocNum:
          approvalDetailsValue!.externalCorrectedDocNum == null ||
                  approvalDetailsValue!.externalCorrectedDocNum == "null"
              ? null
              : approvalDetailsValue!.externalCorrectedDocNum,
      internalCorrectedDocNum:
          approvalDetailsValue!.internalCorrectedDocNum == null ||
                  approvalDetailsValue!.internalCorrectedDocNum == "null"
              ? null
              : approvalDetailsValue!.internalCorrectedDocNum,
      nextCorrectingDocument:
          approvalDetailsValue!.nextCorrectingDocument == null ||
                  approvalDetailsValue!.nextCorrectingDocument == "null"
              ? null
              : approvalDetailsValue!.nextCorrectingDocument,
      deferredTax: approvalDetailsValue!.deferredTax == null ||
              approvalDetailsValue!.deferredTax == "null"
          ? null
          : approvalDetailsValue!.deferredTax,
      taxExemptionLetterNum:
          approvalDetailsValue!.taxExemptionLetterNum == null ||
                  approvalDetailsValue!.taxExemptionLetterNum == "null"
              ? null
              : approvalDetailsValue!.taxExemptionLetterNum,
      wtApplied: approvalDetailsValue!.wtApplied == null ||
              approvalDetailsValue!.wtApplied == "null"
          ? null
          : approvalDetailsValue!.wtApplied,
      wtAppliedFc: approvalDetailsValue!.wtAppliedFc == null ||
              approvalDetailsValue!.wtAppliedFc == "null"
          ? null
          : approvalDetailsValue!.wtAppliedFc,
      billOfExchangeReserved:
          approvalDetailsValue!.billOfExchangeReserved == null ||
                  approvalDetailsValue!.billOfExchangeReserved == "null"
              ? null
              : approvalDetailsValue!.billOfExchangeReserved,
      agentCode: approvalDetailsValue!.agentCode == null ||
              approvalDetailsValue!.agentCode == "null"
          ? null
          : approvalDetailsValue!.agentCode,
      wtAppliedSc: approvalDetailsValue!.wtAppliedSc == null ||
              approvalDetailsValue!.wtAppliedSc == "null"
          ? null
          : approvalDetailsValue!.wtAppliedSc,
      totalEqualizationTax:
          approvalDetailsValue!.totalEqualizationTax == null ||
                  approvalDetailsValue!.totalEqualizationTax == "null"
              ? null
              : approvalDetailsValue!.totalEqualizationTax,
      totalEqualizationTaxFc:
          approvalDetailsValue!.totalEqualizationTaxFc == null ||
                  approvalDetailsValue!.totalEqualizationTaxFc == "null"
              ? null
              : approvalDetailsValue!.totalEqualizationTaxFc,
      totalEqualizationTaxSc:
          approvalDetailsValue!.totalEqualizationTaxSc == null ||
                  approvalDetailsValue!.totalEqualizationTaxSc == "null"
              ? null
              : approvalDetailsValue!.totalEqualizationTaxSc,
      numberOfInstallments:
          approvalDetailsValue!.numberOfInstallments == null ||
                  approvalDetailsValue!.numberOfInstallments == "null"
              ? null
              : approvalDetailsValue!.numberOfInstallments,
      applyTaxOnFirstInstallment:
          approvalDetailsValue!.applyTaxOnFirstInstallment == null ||
                  approvalDetailsValue!.applyTaxOnFirstInstallment == "null"
              ? null
              : approvalDetailsValue!.applyTaxOnFirstInstallment,
      wtNonSubjectAmount: approvalDetailsValue!.wtNonSubjectAmount == null ||
              approvalDetailsValue!.wtNonSubjectAmount == "null"
          ? null
          : approvalDetailsValue!.wtNonSubjectAmount,
      wtNonSubjectAmountSc:
          approvalDetailsValue!.wtNonSubjectAmountSc == null ||
                  approvalDetailsValue!.wtNonSubjectAmountSc == "null"
              ? null
              : approvalDetailsValue!.wtNonSubjectAmountSc,
      wtNonSubjectAmountFc:
          approvalDetailsValue!.wtNonSubjectAmountFc == null ||
                  approvalDetailsValue!.wtNonSubjectAmountFc == "null"
              ? null
              : approvalDetailsValue!.wtNonSubjectAmountFc,
      wtExemptedAmount: approvalDetailsValue!.wtExemptedAmount == null ||
              approvalDetailsValue!.wtExemptedAmount == "null"
          ? null
          : approvalDetailsValue!.wtExemptedAmount,
      wtExemptedAmountSc: approvalDetailsValue!.wtExemptedAmountSc == null ||
              approvalDetailsValue!.wtExemptedAmountSc == "null"
          ? null
          : approvalDetailsValue!.wtExemptedAmountSc,
      wtExemptedAmountFc: approvalDetailsValue!.wtExemptedAmountFc == null ||
              approvalDetailsValue!.wtExemptedAmountFc == "null"
          ? null
          : approvalDetailsValue!.wtExemptedAmountFc,
      baseAmount: approvalDetailsValue!.baseAmount == null ||
              approvalDetailsValue!.baseAmount == "null"
          ? null
          : approvalDetailsValue!.baseAmount,
      baseAmountSc: approvalDetailsValue!.baseAmountSc == null ||
              approvalDetailsValue!.baseAmountSc == "null"
          ? null
          : approvalDetailsValue!.baseAmountSc,
      baseAmountFc: approvalDetailsValue!.baseAmountFc == null ||
              approvalDetailsValue!.baseAmountFc == "null"
          ? null
          : approvalDetailsValue!.baseAmountFc,
      wtAmount: approvalDetailsValue!.wtAmount == null ||
              approvalDetailsValue!.wtAmount == "null"
          ? null
          : approvalDetailsValue!.wtAmount,
      wtAmountSc: approvalDetailsValue!.wtAmountSc == null ||
              approvalDetailsValue!.wtAmountSc == "null"
          ? null
          : approvalDetailsValue!.wtAmountSc,
      wtAmountFc: approvalDetailsValue!.wtAmountFc == null ||
              approvalDetailsValue!.wtAmountFc == "null"
          ? null
          : approvalDetailsValue!.wtAmountFc,
      vatDate: approvalDetailsValue!.vatDate == null ||
              approvalDetailsValue!.vatDate == "null"
          ? null
          : approvalDetailsValue!.vatDate,
      documentsOwner: approvalDetailsValue!.documentsOwner == null ||
              approvalDetailsValue!.documentsOwner == "null"
          ? null
          : approvalDetailsValue!.documentsOwner,
      folioPrefixString: approvalDetailsValue!.folioPrefixString == null ||
              approvalDetailsValue!.folioPrefixString == "null"
          ? null
          : approvalDetailsValue!.folioPrefixString,
      folioNumber: approvalDetailsValue!.folioNumber == null ||
              approvalDetailsValue!.folioNumber == "null"
          ? null
          : approvalDetailsValue!.folioNumber,
      documentSubType: approvalDetailsValue!.documentSubType == null ||
              approvalDetailsValue!.documentSubType == "null"
          ? null
          : approvalDetailsValue!.documentSubType,
      bpChannelCode: approvalDetailsValue!.bpChannelCode == null ||
              approvalDetailsValue!.bpChannelCode == "null"
          ? null
          : approvalDetailsValue!.bpChannelCode,
      bpChannelContact: approvalDetailsValue!.bpChannelContact == null ||
              approvalDetailsValue!.bpChannelContact == "null"
          ? null
          : approvalDetailsValue!.bpChannelContact,
      address2: approvalDetailsValue!.address2 == null ||
              approvalDetailsValue!.address2 == "null"
          ? null
          : approvalDetailsValue!.address2,
      documentStatus: approvalDetailsValue!.documentStatus == null ||
              approvalDetailsValue!.documentStatus == "null"
          ? null
          : approvalDetailsValue!.documentStatus,
      periodIndicator: approvalDetailsValue!.periodIndicator == null ||
              approvalDetailsValue!.periodIndicator == "null"
          ? null
          : approvalDetailsValue!.periodIndicator,
      payToCode: approvalDetailsValue!.payToCode == null ||
              approvalDetailsValue!.payToCode == "null"
          ? null
          : approvalDetailsValue!.payToCode,
      manualNumber: approvalDetailsValue!.manualNumber == null ||
              approvalDetailsValue!.manualNumber == "null"
          ? null
          : approvalDetailsValue!.manualNumber,
      useShpdGoodsAct: approvalDetailsValue!.useShpdGoodsAct == null ||
              approvalDetailsValue!.useShpdGoodsAct == "null"
          ? null
          : approvalDetailsValue!.useShpdGoodsAct,
      isPayToBank: approvalDetailsValue!.isPayToBank == null ||
              approvalDetailsValue!.isPayToBank == "null"
          ? null
          : approvalDetailsValue!.isPayToBank,
      payToBankCountry: approvalDetailsValue!.payToBankCountry == null ||
              approvalDetailsValue!.payToBankCountry == "null"
          ? null
          : approvalDetailsValue!.payToBankCountry,
      payToBankCode: approvalDetailsValue!.payToBankCode == null ||
              approvalDetailsValue!.payToBankCode == "null"
          ? null
          : approvalDetailsValue!.payToBankCode,
      payToBankAccountNo: approvalDetailsValue!.payToBankAccountNo == null ||
              approvalDetailsValue!.payToBankAccountNo == "null"
          ? null
          : approvalDetailsValue!.payToBankAccountNo,
      payToBankBranch: approvalDetailsValue!.payToBankBranch == null ||
              approvalDetailsValue!.payToBankBranch == "null"
          ? null
          : approvalDetailsValue!.payToBankBranch,
      bplIdAssignedToInvoice:
          approvalDetailsValue!.bplIdAssignedToInvoice == null ||
                  approvalDetailsValue!.bplIdAssignedToInvoice == "null"
              ? null
              : approvalDetailsValue!.bplIdAssignedToInvoice,
      downPayment: approvalDetailsValue!.downPayment == null ||
              approvalDetailsValue!.downPayment == "null"
          ? null
          : approvalDetailsValue!.downPayment,
      reserveInvoice: approvalDetailsValue!.reserveInvoice == null ||
              approvalDetailsValue!.reserveInvoice == "null"
          ? null
          : approvalDetailsValue!.reserveInvoice,
      languageCode: approvalDetailsValue!.languageCode == null ||
              approvalDetailsValue!.languageCode == "null"
          ? null
          : approvalDetailsValue!.languageCode,
      trackingNumber: approvalDetailsValue!.trackingNumber == null ||
              approvalDetailsValue!.trackingNumber == "null"
          ? null
          : approvalDetailsValue!.trackingNumber,
      pickRemark: approvalDetailsValue!.pickRemark == null ||
              approvalDetailsValue!.pickRemark == "null"
          ? null
          : approvalDetailsValue!.pickRemark,
      closingDate: approvalDetailsValue!.closingDate == null ||
              approvalDetailsValue!.closingDate == "null"
          ? null
          : approvalDetailsValue!.closingDate,
      sequenceCode: approvalDetailsValue!.sequenceCode == null ||
              approvalDetailsValue!.sequenceCode == "null"
          ? null
          : approvalDetailsValue!.sequenceCode,
      sequenceSerial: approvalDetailsValue!.sequenceSerial == null ||
              approvalDetailsValue!.sequenceSerial == "null"
          ? null
          : approvalDetailsValue!.sequenceSerial,
      seriesString: approvalDetailsValue!.seriesString == null ||
              approvalDetailsValue!.seriesString == "null"
          ? null
          : approvalDetailsValue!.seriesString,
      subSeriesString: approvalDetailsValue!.subSeriesString == null ||
              approvalDetailsValue!.subSeriesString == "null"
          ? null
          : approvalDetailsValue!.subSeriesString,
      sequenceModel: approvalDetailsValue!.sequenceModel == null ||
              approvalDetailsValue!.sequenceModel == "null"
          ? null
          : approvalDetailsValue!.sequenceModel,
      useCorrectionVatGroup:
          approvalDetailsValue!.useCorrectionVatGroup == null ||
                  approvalDetailsValue!.useCorrectionVatGroup == "null"
              ? null
              : approvalDetailsValue!.useCorrectionVatGroup,
      totalDiscount: approvalDetailsValue!.totalDiscount == null ||
              approvalDetailsValue!.totalDiscount == "null"
          ? null
          : approvalDetailsValue!.totalDiscount,
      downPaymentAmount: approvalDetailsValue!.downPaymentAmount == null ||
              approvalDetailsValue!.downPaymentAmount == "null"
          ? null
          : approvalDetailsValue!.downPaymentAmount,
      downPaymentPercentage:
          approvalDetailsValue!.downPaymentPercentage == null ||
                  approvalDetailsValue!.downPaymentPercentage == "null"
              ? null
              : approvalDetailsValue!.downPaymentPercentage,
      downPaymentType: approvalDetailsValue!.downPaymentType == null ||
              approvalDetailsValue!.downPaymentType == "null"
          ? null
          : approvalDetailsValue!.downPaymentType,
      downPaymentAmountSc: approvalDetailsValue!.downPaymentAmountSc == null ||
              approvalDetailsValue!.downPaymentAmountSc == "null"
          ? null
          : approvalDetailsValue!.downPaymentAmountSc,
      downPaymentAmountFc: approvalDetailsValue!.downPaymentAmountFc == null ||
              approvalDetailsValue!.downPaymentAmountFc == "null"
          ? null
          : approvalDetailsValue!.downPaymentAmountFc,
      vatPercent: approvalDetailsValue!.vatPercent == null ||
              approvalDetailsValue!.vatPercent == "null"
          ? null
          : approvalDetailsValue!.vatPercent,
      serviceGrossProfitPercent:
          approvalDetailsValue!.serviceGrossProfitPercent == null ||
                  approvalDetailsValue!.serviceGrossProfitPercent == "null"
              ? null
              : approvalDetailsValue!.serviceGrossProfitPercent,
      openingRemarks: approvalDetailsValue!.openingRemarks == null ||
              approvalDetailsValue!.openingRemarks == "null"
          ? null
          : approvalDetailsValue!.openingRemarks,
      closingRemarks: approvalDetailsValue!.closingRemarks == null ||
              approvalDetailsValue!.closingRemarks == "null"
          ? null
          : approvalDetailsValue!.closingRemarks,
      roundingDiffAmount: approvalDetailsValue!.roundingDiffAmount == null ||
              approvalDetailsValue!.roundingDiffAmount == "null"
          ? null
          : approvalDetailsValue!.roundingDiffAmount,
      roundingDiffAmountFc:
          approvalDetailsValue!.roundingDiffAmountFc == null ||
                  approvalDetailsValue!.roundingDiffAmountFc == "null"
              ? null
              : approvalDetailsValue!.roundingDiffAmountFc,
      roundingDiffAmountSc:
          approvalDetailsValue!.roundingDiffAmountSc == null ||
                  approvalDetailsValue!.roundingDiffAmountSc == "null"
              ? null
              : approvalDetailsValue!.roundingDiffAmountSc,
      cancelled: approvalDetailsValue!.cancelled == null ||
              approvalDetailsValue!.cancelled == "null"
          ? null
          : approvalDetailsValue!.cancelled,
      signatureInputMessage:
          approvalDetailsValue!.signatureInputMessage == null ||
                  approvalDetailsValue!.signatureInputMessage == "null"
              ? null
              : approvalDetailsValue!.signatureInputMessage,
      signatureDigest: approvalDetailsValue!.signatureDigest == null ||
              approvalDetailsValue!.signatureDigest == "null"
          ? null
          : approvalDetailsValue!.signatureDigest,
      certificationNumber: approvalDetailsValue!.certificationNumber == null ||
              approvalDetailsValue!.certificationNumber == "null"
          ? null
          : approvalDetailsValue!.certificationNumber,
      privateKeyVersion: approvalDetailsValue!.privateKeyVersion == null ||
              approvalDetailsValue!.privateKeyVersion == "null"
          ? null
          : approvalDetailsValue!.privateKeyVersion,
      controlAccount: approvalDetailsValue!.controlAccount == null ||
              approvalDetailsValue!.controlAccount == "null"
          ? null
          : approvalDetailsValue!.controlAccount,
      insuranceOperation347:
          approvalDetailsValue!.insuranceOperation347 == null ||
                  approvalDetailsValue!.insuranceOperation347 == "null"
              ? null
              : approvalDetailsValue!.insuranceOperation347,
      archiveNonremovableSalesQuotation:
          approvalDetailsValue!.archiveNonremovableSalesQuotation == null ||
                  approvalDetailsValue!.archiveNonremovableSalesQuotation ==
                      "null"
              ? null
              : approvalDetailsValue!.archiveNonremovableSalesQuotation,
      gtsChecker: approvalDetailsValue!.gtsChecker == null ||
              approvalDetailsValue!.gtsChecker == "null"
          ? null
          : approvalDetailsValue!.gtsChecker,
      gtsPayee: approvalDetailsValue!.gtsPayee == null ||
              approvalDetailsValue!.gtsPayee == "null"
          ? null
          : approvalDetailsValue!.gtsPayee,
      extraMonth: approvalDetailsValue!.extraMonth == null ||
              approvalDetailsValue!.extraMonth == "null"
          ? null
          : approvalDetailsValue!.extraMonth,
      extraDays: approvalDetailsValue!.extraDays == null ||
              approvalDetailsValue!.extraDays == "null"
          ? null
          : approvalDetailsValue!.extraDays,
      cashDiscountDateOffset:
          approvalDetailsValue!.cashDiscountDateOffset == null ||
                  approvalDetailsValue!.cashDiscountDateOffset == "null"
              ? null
              : approvalDetailsValue!.cashDiscountDateOffset,
      startFrom: approvalDetailsValue!.startFrom == null ||
              approvalDetailsValue!.startFrom == "null"
          ? null
          : approvalDetailsValue!.startFrom,
      ntsApproved: approvalDetailsValue!.ntsApproved == null ||
              approvalDetailsValue!.ntsApproved == "null"
          ? null
          : approvalDetailsValue!.ntsApproved,
      eTaxWebSite: approvalDetailsValue!.eTaxWebSite == null ||
              approvalDetailsValue!.eTaxWebSite == "null"
          ? null
          : approvalDetailsValue!.eTaxWebSite,
      eTaxNumber: approvalDetailsValue!.eTaxNumber == null ||
              approvalDetailsValue!.eTaxNumber == "null"
          ? null
          : approvalDetailsValue!.eTaxNumber,
      ntsApprovedNumber: approvalDetailsValue!.ntsApprovedNumber == null ||
              approvalDetailsValue!.ntsApprovedNumber == "null"
          ? null
          : approvalDetailsValue!.ntsApprovedNumber,
      eDocGenerationType: approvalDetailsValue!.eDocGenerationType == null ||
              approvalDetailsValue!.eDocGenerationType == "null"
          ? null
          : approvalDetailsValue!.eDocGenerationType,
      eDocSeries: approvalDetailsValue!.eDocSeries == null ||
              approvalDetailsValue!.eDocSeries == "null"
          ? null
          : approvalDetailsValue!.eDocSeries,
      eDocNum: approvalDetailsValue!.eDocNum == null ||
              approvalDetailsValue!.eDocNum == "null"
          ? null
          : approvalDetailsValue!.eDocNum,
      eDocExportFormat: approvalDetailsValue!.eDocExportFormat == null ||
              approvalDetailsValue!.eDocExportFormat == "null"
          ? null
          : approvalDetailsValue!.eDocExportFormat,
      eDocStatus: approvalDetailsValue!.eDocStatus == null ||
              approvalDetailsValue!.eDocStatus == "null"
          ? null
          : approvalDetailsValue!.eDocStatus,
      eDocErrorCode: approvalDetailsValue!.eDocErrorCode == null ||
              approvalDetailsValue!.eDocErrorCode == "null"
          ? null
          : approvalDetailsValue!.eDocErrorCode,
      eDocErrorMessage: approvalDetailsValue!.eDocErrorMessage == null ||
              approvalDetailsValue!.eDocErrorMessage == "null"
          ? null
          : approvalDetailsValue!.eDocErrorMessage,
      downPaymentStatus: approvalDetailsValue!.downPaymentStatus == null ||
              approvalDetailsValue!.downPaymentStatus == "null"
          ? null
          : approvalDetailsValue!.downPaymentStatus,
      groupSeries: approvalDetailsValue!.groupSeries == null ||
              approvalDetailsValue!.groupSeries == "null"
          ? null
          : approvalDetailsValue!.groupSeries,
      groupNumber: approvalDetailsValue!.groupNumber == null ||
              approvalDetailsValue!.groupNumber == "null"
          ? null
          : approvalDetailsValue!.groupNumber,
      groupHandWritten: approvalDetailsValue!.groupHandWritten == null ||
              approvalDetailsValue!.groupHandWritten == "null"
          ? null
          : approvalDetailsValue!.groupHandWritten,
      reopenOriginalDocument:
          approvalDetailsValue!.reopenOriginalDocument == null ||
                  approvalDetailsValue!.reopenOriginalDocument == "null"
              ? null
              : approvalDetailsValue!.reopenOriginalDocument,
      reopenManuallyClosedOrCanceledDocument: approvalDetailsValue!
                      .reopenManuallyClosedOrCanceledDocument ==
                  null ||
              approvalDetailsValue!.reopenManuallyClosedOrCanceledDocument ==
                  "null"
          ? null
          : approvalDetailsValue!.reopenManuallyClosedOrCanceledDocument,
      createOnlineQuotation:
          approvalDetailsValue!.createOnlineQuotation == null ||
                  approvalDetailsValue!.createOnlineQuotation == "null"
              ? null
              : approvalDetailsValue!.createOnlineQuotation,
      posEquipmentNumber: approvalDetailsValue!.posEquipmentNumber == null ||
              approvalDetailsValue!.posEquipmentNumber == "null"
          ? null
          : approvalDetailsValue!.posEquipmentNumber,
      posManufacturerSerialNumber:
          approvalDetailsValue!.posManufacturerSerialNumber == null ||
                  approvalDetailsValue!.posManufacturerSerialNumber == "null"
              ? null
              : approvalDetailsValue!.posManufacturerSerialNumber,
      posCashierNumber: approvalDetailsValue!.posCashierNumber == null ||
              approvalDetailsValue!.posCashierNumber == "null"
          ? null
          : approvalDetailsValue!.posCashierNumber,
      applyCurrentVatRatesForDownPaymentsToDraw: approvalDetailsValue!
                      .applyCurrentVatRatesForDownPaymentsToDraw ==
                  null ||
              approvalDetailsValue!.applyCurrentVatRatesForDownPaymentsToDraw ==
                  "null"
          ? null
          : approvalDetailsValue!.applyCurrentVatRatesForDownPaymentsToDraw,
      closingOption: approvalDetailsValue!.closingOption == null ||
              approvalDetailsValue!.closingOption == "null"
          ? null
          : approvalDetailsValue!.closingOption,
      specifiedClosingDate:
          approvalDetailsValue!.specifiedClosingDate == null ||
                  approvalDetailsValue!.specifiedClosingDate == "null"
              ? null
              : approvalDetailsValue!.specifiedClosingDate,
      openForLandedCosts: approvalDetailsValue!.openForLandedCosts == null ||
              approvalDetailsValue!.openForLandedCosts == "null"
          ? null
          : approvalDetailsValue!.openForLandedCosts,
      authorizationStatus: approvalDetailsValue!.authorizationStatus == null ||
              approvalDetailsValue!.authorizationStatus == "null"
          ? null
          : approvalDetailsValue!.authorizationStatus,
      totalDiscountFc: approvalDetailsValue!.totalDiscountFc == null ||
              approvalDetailsValue!.totalDiscountFc == "null"
          ? null
          : approvalDetailsValue!.totalDiscountFc,
      totalDiscountSc: approvalDetailsValue!.totalDiscountSc == null ||
              approvalDetailsValue!.totalDiscountSc == "null"
          ? null
          : approvalDetailsValue!.totalDiscountSc,
      relevantToGts: approvalDetailsValue!.relevantToGts == null ||
              approvalDetailsValue!.relevantToGts == "null"
          ? null
          : approvalDetailsValue!.relevantToGts,
      bplName: approvalDetailsValue!.bplName == null ||
              approvalDetailsValue!.bplName == "null"
          ? null
          : approvalDetailsValue!.bplName,
      vatRegNum: approvalDetailsValue!.vatRegNum == null ||
              approvalDetailsValue!.vatRegNum == "null"
          ? null
          : approvalDetailsValue!.vatRegNum,
      annualInvoiceDeclarationReference:
          approvalDetailsValue!.annualInvoiceDeclarationReference == null ||
                  approvalDetailsValue!.annualInvoiceDeclarationReference ==
                      "null"
              ? null
              : approvalDetailsValue!.annualInvoiceDeclarationReference,
      supplier: approvalDetailsValue!.supplier == null ||
              approvalDetailsValue!.supplier == "null"
          ? null
          : approvalDetailsValue!.supplier,
      releaser: approvalDetailsValue!.releaser == null ||
              approvalDetailsValue!.releaser == "null"
          ? null
          : approvalDetailsValue!.releaser,
      receiver: approvalDetailsValue!.receiver == null ||
              approvalDetailsValue!.receiver == "null"
          ? null
          : approvalDetailsValue!.receiver,
      blanketAgreementNumber:
          approvalDetailsValue!.blanketAgreementNumber == null ||
                  approvalDetailsValue!.blanketAgreementNumber == "null"
              ? null
              : approvalDetailsValue!.blanketAgreementNumber,
      isAlteration: approvalDetailsValue!.isAlteration == null ||
              approvalDetailsValue!.isAlteration == "null"
          ? null
          : approvalDetailsValue!.isAlteration,
      cancelStatus: approvalDetailsValue!.cancelStatus == null ||
              approvalDetailsValue!.cancelStatus == "null"
          ? null
          : approvalDetailsValue!.cancelStatus,
      assetValueDate: approvalDetailsValue!.assetValueDate == null ||
              approvalDetailsValue!.assetValueDate == "null"
          ? null
          : approvalDetailsValue!.assetValueDate,
      documentDelivery: approvalDetailsValue!.documentDelivery == null ||
              approvalDetailsValue!.documentDelivery == "null"
          ? null
          : approvalDetailsValue!.documentDelivery,
      authorizationCode: approvalDetailsValue!.authorizationCode == null ||
              approvalDetailsValue!.authorizationCode == "null"
          ? null
          : approvalDetailsValue!.authorizationCode,
      startDeliveryDate: approvalDetailsValue!.startDeliveryDate == null ||
              approvalDetailsValue!.startDeliveryDate == "null"
          ? null
          : approvalDetailsValue!.startDeliveryDate,
      startDeliveryTime: approvalDetailsValue!.startDeliveryTime == null ||
              approvalDetailsValue!.startDeliveryTime == "null"
          ? null
          : approvalDetailsValue!.startDeliveryTime,
      endDeliveryDate: approvalDetailsValue!.endDeliveryDate == null ||
              approvalDetailsValue!.endDeliveryDate == "null"
          ? null
          : approvalDetailsValue!.endDeliveryDate,
      endDeliveryTime: approvalDetailsValue!.endDeliveryTime == null ||
              approvalDetailsValue!.endDeliveryTime == "null"
          ? null
          : approvalDetailsValue!.endDeliveryTime,
      vehiclePlate: approvalDetailsValue!.vehiclePlate == null ||
              approvalDetailsValue!.vehiclePlate == "null"
          ? null
          : approvalDetailsValue!.vehiclePlate,
      atDocumentType: approvalDetailsValue!.atDocumentType == null ||
              approvalDetailsValue!.atDocumentType == "null"
          ? null
          : approvalDetailsValue!.atDocumentType,
      elecCommStatus: approvalDetailsValue!.elecCommStatus == null ||
              approvalDetailsValue!.elecCommStatus == "null"
          ? null
          : approvalDetailsValue!.elecCommStatus,
      elecCommMessage: approvalDetailsValue!.elecCommMessage == null ||
              approvalDetailsValue!.elecCommMessage == "null"
          ? null
          : approvalDetailsValue!.elecCommMessage,
      reuseDocumentNum: approvalDetailsValue!.reuseDocumentNum == null ||
              approvalDetailsValue!.reuseDocumentNum == "null"
          ? null
          : approvalDetailsValue!.reuseDocumentNum,
      reuseNotaFiscalNum: approvalDetailsValue!.reuseNotaFiscalNum == null ||
              approvalDetailsValue!.reuseNotaFiscalNum == "null"
          ? null
          : approvalDetailsValue!.reuseNotaFiscalNum,
      printSepaDirect: approvalDetailsValue!.printSepaDirect == null ||
              approvalDetailsValue!.printSepaDirect == "null"
          ? null
          : approvalDetailsValue!.printSepaDirect,
      fiscalDocNum: approvalDetailsValue!.fiscalDocNum == null ||
              approvalDetailsValue!.fiscalDocNum == "null"
          ? null
          : approvalDetailsValue!.fiscalDocNum,
      posDailySummaryNo: approvalDetailsValue!.posDailySummaryNo == null ||
              approvalDetailsValue!.posDailySummaryNo == "null"
          ? null
          : approvalDetailsValue!.posDailySummaryNo,
      posReceiptNo: approvalDetailsValue!.posReceiptNo == null ||
              approvalDetailsValue!.posReceiptNo == "null"
          ? null
          : approvalDetailsValue!.posReceiptNo,
      pointOfIssueCode: approvalDetailsValue!.pointOfIssueCode == null ||
              approvalDetailsValue!.pointOfIssueCode == "null"
          ? null
          : approvalDetailsValue!.pointOfIssueCode,
      letter: approvalDetailsValue!.letter == null ||
              approvalDetailsValue!.letter == "null"
          ? null
          : approvalDetailsValue!.letter,
      folioNumberFrom: approvalDetailsValue!.folioNumberFrom == null ||
              approvalDetailsValue!.folioNumberFrom == "null"
          ? null
          : approvalDetailsValue!.folioNumberFrom,
      folioNumberTo: approvalDetailsValue!.folioNumberTo == null ||
              approvalDetailsValue!.folioNumberTo == "null"
          ? null
          : approvalDetailsValue!.folioNumberTo,
      interimType: approvalDetailsValue!.interimType == null ||
              approvalDetailsValue!.interimType == "null"
          ? null
          : approvalDetailsValue!.interimType,
      relatedType: approvalDetailsValue!.relatedType == null ||
              approvalDetailsValue!.relatedType == "null"
          ? null
          : approvalDetailsValue!.relatedType,
      relatedEntry: approvalDetailsValue!.relatedEntry == null ||
              approvalDetailsValue!.relatedEntry == "null"
          ? null
          : approvalDetailsValue!.relatedEntry,
      sapPassport: approvalDetailsValue!.sapPassport == null ||
              approvalDetailsValue!.sapPassport == "null"
          ? null
          : approvalDetailsValue!.sapPassport,
      documentTaxId: approvalDetailsValue!.documentTaxId == null ||
              approvalDetailsValue!.documentTaxId == "null"
          ? null
          : approvalDetailsValue!.documentTaxId,
      dateOfReportingControlStatementVat:
          approvalDetailsValue!.dateOfReportingControlStatementVat == null ||
                  approvalDetailsValue!.dateOfReportingControlStatementVat ==
                      "null"
              ? null
              : approvalDetailsValue!.dateOfReportingControlStatementVat,
      reportingSectionControlStatementVat:
          approvalDetailsValue!.reportingSectionControlStatementVat == null ||
                  approvalDetailsValue!.reportingSectionControlStatementVat ==
                      "null"
              ? null
              : approvalDetailsValue!.reportingSectionControlStatementVat,
      excludeFromTaxReportControlStatementVat: approvalDetailsValue!
                      .excludeFromTaxReportControlStatementVat ==
                  null ||
              approvalDetailsValue!.excludeFromTaxReportControlStatementVat ==
                  "null"
          ? null
          : approvalDetailsValue!.excludeFromTaxReportControlStatementVat,
      posCashRegister: approvalDetailsValue!.posCashRegister == null ||
              approvalDetailsValue!.posCashRegister == "null"
          ? null
          : approvalDetailsValue!.posCashRegister,
      updateTime: approvalDetailsValue!.updateTime == null ||
              approvalDetailsValue!.updateTime == "null"
          ? null
          : approvalDetailsValue!.updateTime,
      createQrCodeFrom: approvalDetailsValue!.createQrCodeFrom == null ||
              approvalDetailsValue!.createQrCodeFrom == "null"
          ? null
          : approvalDetailsValue!.createQrCodeFrom,
      priceMode: approvalDetailsValue!.priceMode == null ||
              approvalDetailsValue!.priceMode == "null"
          ? null
          : approvalDetailsValue!.priceMode,
      shipFrom: approvalDetailsValue!.shipFrom == null ||
              approvalDetailsValue!.shipFrom == "null"
          ? null
          : approvalDetailsValue!.shipFrom,
      commissionTrade: approvalDetailsValue!.commissionTrade == null ||
              approvalDetailsValue!.commissionTrade == "null"
          ? null
          : approvalDetailsValue!.commissionTrade,
      commissionTradeReturn:
          approvalDetailsValue!.commissionTradeReturn == null ||
                  approvalDetailsValue!.commissionTradeReturn == "null"
              ? null
              : approvalDetailsValue!.commissionTradeReturn,
      useBillToAddrToDetermineTax:
          approvalDetailsValue!.useBillToAddrToDetermineTax == null ||
                  approvalDetailsValue!.useBillToAddrToDetermineTax == "null"
              ? null
              : approvalDetailsValue!.useBillToAddrToDetermineTax,
      cig: approvalDetailsValue!.cig == null ||
              approvalDetailsValue!.cig == "null"
          ? null
          : approvalDetailsValue!.cig,
      cup: approvalDetailsValue!.cup == null ||
              approvalDetailsValue!.cup == "null"
          ? null
          : approvalDetailsValue!.cup,
      fatherCard: approvalDetailsValue!.fatherCard == null ||
              approvalDetailsValue!.fatherCard == "null"
          ? null
          : approvalDetailsValue!.fatherCard,
      fatherType: approvalDetailsValue!.fatherType == null ||
              approvalDetailsValue!.fatherType == "null"
          ? null
          : approvalDetailsValue!.fatherType,
      shipState: approvalDetailsValue!.shipState == null ||
              approvalDetailsValue!.shipState == "null"
          ? null
          : approvalDetailsValue!.shipState,
      shipPlace: approvalDetailsValue!.shipPlace == null ||
              approvalDetailsValue!.shipPlace == "null"
          ? null
          : approvalDetailsValue!.shipPlace,
      custOffice: approvalDetailsValue!.custOffice == null ||
              approvalDetailsValue!.custOffice == "null"
          ? null
          : approvalDetailsValue!.custOffice,
      fci: approvalDetailsValue!.fci == null ||
              approvalDetailsValue!.fci == "null"
          ? null
          : approvalDetailsValue!.fci,
      addLegIn: approvalDetailsValue!.addLegIn == null ||
              approvalDetailsValue!.addLegIn == "null"
          ? null
          : approvalDetailsValue!.addLegIn,
      legTextF: approvalDetailsValue!.legTextF == null ||
              approvalDetailsValue!.legTextF == "null"
          ? null
          : approvalDetailsValue!.legTextF,
      danfeLgTxt: approvalDetailsValue!.danfeLgTxt == null ||
              approvalDetailsValue!.danfeLgTxt == "null"
          ? null
          : approvalDetailsValue!.danfeLgTxt,
      indFinal: approvalDetailsValue!.indFinal == null ||
              approvalDetailsValue!.indFinal == "null"
          ? null
          : approvalDetailsValue!.indFinal,
      dataVersion: approvalDetailsValue!.dataVersion == null ||
              approvalDetailsValue!.dataVersion == "null"
          ? null
          : approvalDetailsValue!.dataVersion,
      uPurchaseType: approvalDetailsValue!.uPurchaseType == null ||
              approvalDetailsValue!.uPurchaseType == "null"
          ? null
          : approvalDetailsValue!.uPurchaseType,
      uApApprove: approvalDetailsValue!.uApApprove == null ||
              approvalDetailsValue!.uApApprove == "null"
          ? null
          : approvalDetailsValue!.uApApprove,
      uFinalDel: approvalDetailsValue!.uFinalDel == null ||
              approvalDetailsValue!.uFinalDel == "null"
          ? null
          : approvalDetailsValue!.uFinalDel,
      uIncoTerms: approvalDetailsValue!.uIncoTerms == null ||
              approvalDetailsValue!.uIncoTerms == "null"
          ? null
          : approvalDetailsValue!.uIncoTerms,
      uSourceDest: approvalDetailsValue!.uSourceDest == null ||
              approvalDetailsValue!.uSourceDest == "null"
          ? null
          : approvalDetailsValue!.uSourceDest,
      uTransNo: approvalDetailsValue!.uTransNo == null ||
              approvalDetailsValue!.uTransNo == "null"
          ? null
          : approvalDetailsValue!.uTransNo,
      uVehicleNo: approvalDetailsValue!.uVehicleNo == null ||
              approvalDetailsValue!.uVehicleNo == "null"
          ? null
          : approvalDetailsValue!.uVehicleNo,
      uSupplierDt: approvalDetailsValue!.uSupplierDt == null ||
              approvalDetailsValue!.uSupplierDt == "null"
          ? null
          : approvalDetailsValue!.uSupplierDt,
      uQuotNo: approvalDetailsValue!.uQuotNo == null ||
              approvalDetailsValue!.uQuotNo == "null"
          ? null
          : approvalDetailsValue!.uQuotNo,
      uQuotDate: approvalDetailsValue!.uQuotDate == null ||
              approvalDetailsValue!.uQuotDate == "null"
          ? null
          : approvalDetailsValue!.uQuotDate,
      uGovPermit: approvalDetailsValue!.uGovPermit == null ||
              approvalDetailsValue!.uGovPermit == "null"
          ? null
          : approvalDetailsValue!.uGovPermit,
      uGovPermitdt: approvalDetailsValue!.uGovPermitdt == null ||
              approvalDetailsValue!.uGovPermitdt == "null"
          ? null
          : approvalDetailsValue!.uGovPermitdt,
      uCheckNo: approvalDetailsValue!.uCheckNo == null ||
              approvalDetailsValue!.uCheckNo == "null"
          ? null
          : approvalDetailsValue!.uCheckNo,
      uCheckDate: approvalDetailsValue!.uCheckDate == null ||
              approvalDetailsValue!.uCheckDate == "null"
          ? null
          : approvalDetailsValue!.uCheckDate,
      uApprovalDate: approvalDetailsValue!.uApprovalDate == null ||
              approvalDetailsValue!.uApprovalDate == "null"
          ? null
          : approvalDetailsValue!.uApprovalDate,
      uOrderNoRecd: approvalDetailsValue!.uOrderNoRecd == null ||
              approvalDetailsValue!.uOrderNoRecd == "null"
          ? null
          : approvalDetailsValue!.uOrderNoRecd,
      uOrderDate: approvalDetailsValue!.uOrderDate == null ||
              approvalDetailsValue!.uOrderDate == "null"
          ? null
          : approvalDetailsValue!.uOrderDate,
      uClearingAgent: approvalDetailsValue!.uClearingAgent == null ||
              approvalDetailsValue!.uClearingAgent == "null"
          ? null
          : approvalDetailsValue!.uClearingAgent,
      uDateSubAgent: approvalDetailsValue!.uDateSubAgent == null ||
              approvalDetailsValue!.uDateSubAgent == "null"
          ? null
          : approvalDetailsValue!.uDateSubAgent,
      uIdfno: approvalDetailsValue!.uIdfno == null ||
              approvalDetailsValue!.uIdfno == "null"
          ? null
          : approvalDetailsValue!.uIdfno,
      uIdfDate: approvalDetailsValue!.uIdfDate == null ||
              approvalDetailsValue!.uIdfDate == "null"
          ? null
          : approvalDetailsValue!.uIdfDate,
      uInspectionNo: approvalDetailsValue!.uInspectionNo == null ||
              approvalDetailsValue!.uInspectionNo == "null"
          ? null
          : approvalDetailsValue!.uInspectionNo,
      uEta: approvalDetailsValue!.uEta == null ||
              approvalDetailsValue!.uEta == "null"
          ? null
          : approvalDetailsValue!.uEta,
      uAirwayBillNo: approvalDetailsValue!.uAirwayBillNo == null ||
              approvalDetailsValue!.uAirwayBillNo == "null"
          ? null
          : approvalDetailsValue!.uAirwayBillNo,
      uBol: approvalDetailsValue!.uBol == null ||
              approvalDetailsValue!.uBol == "null"
          ? null
          : approvalDetailsValue!.uBol,
      uCotecna: approvalDetailsValue!.uCotecna == null ||
              approvalDetailsValue!.uCotecna == "null"
          ? null
          : approvalDetailsValue!.uCotecna,
      uArrivalDate: approvalDetailsValue!.uArrivalDate == null ||
              approvalDetailsValue!.uArrivalDate == "null"
          ? null
          : approvalDetailsValue!.uArrivalDate,
      uDahacoAgentFees: approvalDetailsValue!.uDahacoAgentFees == null ||
              approvalDetailsValue!.uDahacoAgentFees == "null"
          ? null
          : approvalDetailsValue!.uDahacoAgentFees,
      uPortCharges: approvalDetailsValue!.uPortCharges == null ||
              approvalDetailsValue!.uPortCharges == "null"
          ? null
          : approvalDetailsValue!.uPortCharges,
      uOtherExp: approvalDetailsValue!.uOtherExp == null ||
              approvalDetailsValue!.uOtherExp == "null"
          ? null
          : approvalDetailsValue!.uOtherExp,
      uClearCharges: approvalDetailsValue!.uClearCharges == null ||
              approvalDetailsValue!.uClearCharges == "null"
          ? null
          : approvalDetailsValue!.uClearCharges,
      uHiddenChrges: approvalDetailsValue!.uHiddenChrges == null ||
              approvalDetailsValue!.uHiddenChrges == "null"
          ? null
          : approvalDetailsValue!.uHiddenChrges,
      uGoodsInspBy: approvalDetailsValue!.uGoodsInspBy == null ||
              approvalDetailsValue!.uGoodsInspBy == "null"
          ? null
          : approvalDetailsValue!.uGoodsInspBy,
      uGoodsReport: approvalDetailsValue!.uGoodsReport == null ||
              approvalDetailsValue!.uGoodsReport == "null"
          ? null
          : approvalDetailsValue!.uGoodsReport,
      uPymtStatus: approvalDetailsValue!.uPymtStatus == null ||
              approvalDetailsValue!.uPymtStatus == "null"
          ? null
          : approvalDetailsValue!.uPymtStatus,
      uPymtType: approvalDetailsValue!.uPymtType == null ||
              approvalDetailsValue!.uPymtType == "null"
          ? null
          : approvalDetailsValue!.uPymtType,
      uTtCopyImage: approvalDetailsValue!.uTtCopyImage == null ||
              approvalDetailsValue!.uTtCopyImage == "null"
          ? null
          : approvalDetailsValue!.uTtCopyImage,
      uPfiImage: approvalDetailsValue!.uPfiImage == null ||
              approvalDetailsValue!.uPfiImage == "null"
          ? null
          : approvalDetailsValue!.uPfiImage,
      uSupplierImage: approvalDetailsValue!.uSupplierImage == null ||
              approvalDetailsValue!.uSupplierImage == "null"
          ? null
          : approvalDetailsValue!.uSupplierImage,
      uBolImage: approvalDetailsValue!.uBolImage == null ||
              approvalDetailsValue!.uBolImage == "null"
          ? null
          : approvalDetailsValue!.uBolImage,
      uOrderType: approvalDetailsValue!.uOrderType == null ||
              approvalDetailsValue!.uOrderType == "null"
          ? null
          : approvalDetailsValue!.uOrderType,
      uTruckInternal: approvalDetailsValue!.uTruckInternal == null ||
              approvalDetailsValue!.uTruckInternal == "null"
          ? null
          : approvalDetailsValue!.uTruckInternal,
      uGpApproval: approvalDetailsValue!.uGpApproval == null ||
              approvalDetailsValue!.uGpApproval == "null"
          ? null
          : approvalDetailsValue!.uGpApproval,
      uSupplierName: approvalDetailsValue!.uSupplierName == null ||
              approvalDetailsValue!.uSupplierName == "null"
          ? null
          : approvalDetailsValue!.uSupplierName,
      uVatNumber: approvalDetailsValue!.uVatNumber == null ||
              approvalDetailsValue!.uVatNumber == "null"
          ? null
          : approvalDetailsValue!.uVatNumber,
      uTransferType: approvalDetailsValue!.uTransferType == null ||
              approvalDetailsValue!.uTransferType == "null"
          ? null
          : approvalDetailsValue!.uTransferType,
      uSalesOrder: approvalDetailsValue!.uSalesOrder == null ||
              approvalDetailsValue!.uSalesOrder == "null"
          ? null
          : approvalDetailsValue!.uSalesOrder,
      uReceived: approvalDetailsValue!.uReceived == null ||
              approvalDetailsValue!.uReceived == "null"
          ? null
          : approvalDetailsValue!.uReceived,
      uDriverName: approvalDetailsValue!.uDriverName == null ||
              approvalDetailsValue!.uDriverName == "null"
          ? null
          : approvalDetailsValue!.uDriverName,
      uReserveInvoice: approvalDetailsValue!.uReserveInvoice == null ||
              approvalDetailsValue!.uReserveInvoice == "null"
          ? null
          : approvalDetailsValue!.uReserveInvoice,
      uRefSeries: approvalDetailsValue!.uRefSeries == null ||
              approvalDetailsValue!.uRefSeries == "null"
          ? null
          : approvalDetailsValue!.uRefSeries,
      uReceivedTime: approvalDetailsValue!.uReceivedTime == null ||
              approvalDetailsValue!.uReceivedTime == "null"
          ? null
          : approvalDetailsValue!.uReceivedTime,
      uSkuBatchNo: approvalDetailsValue!.uSkuBatchNo == null ||
              approvalDetailsValue!.uSkuBatchNo == "null"
          ? null
          : approvalDetailsValue!.uSkuBatchNo,
      uInwardNo: approvalDetailsValue!.uInwardNo == null ||
              approvalDetailsValue!.uInwardNo == "null"
          ? null
          : approvalDetailsValue!.uInwardNo,
      uDispatchTime: approvalDetailsValue!.uDispatchTime == null ||
              approvalDetailsValue!.uDispatchTime == "null"
          ? null
          : approvalDetailsValue!.uDispatchTime,
      uReceivedDate: approvalDetailsValue!.uReceivedDate == null ||
              approvalDetailsValue!.uReceivedDate == "null"
          ? null
          : approvalDetailsValue!.uReceivedDate,
      uExpiryDate: approvalDetailsValue!.uExpiryDate == null ||
              approvalDetailsValue!.uExpiryDate == "null"
          ? null
          : approvalDetailsValue!.uExpiryDate,
      uCnType: approvalDetailsValue!.uCnType == null ||
              approvalDetailsValue!.uCnType == "null"
          ? null
          : approvalDetailsValue!.uCnType,
      uTinNo: approvalDetailsValue!.uTinNo == null ||
              approvalDetailsValue!.uTinNo == "null"
          ? null
          : approvalDetailsValue!.uTinNo,
      uLpoNo: approvalDetailsValue!.uLpoNo == null ||
              approvalDetailsValue!.uLpoNo == "null"
          ? null
          : approvalDetailsValue!.uLpoNo,
      uOrderQty: approvalDetailsValue!.uOrderQty == null ||
              approvalDetailsValue!.uOrderQty == "null"
          ? null
          : approvalDetailsValue!.uOrderQty,
      uDispatchDate: approvalDetailsValue!.uDispatchDate == null ||
              approvalDetailsValue!.uDispatchDate == "null"
          ? null
          : approvalDetailsValue!.uDispatchDate,
      uBranch: approvalDetailsValue!.uBranch == null ||
              approvalDetailsValue!.uBranch == "null"
          ? null
          : approvalDetailsValue!.uBranch,
      uSalAppEntry: approvalDetailsValue!.uSalAppEntry == null ||
              approvalDetailsValue!.uSalAppEntry == "null"
          ? null
          : approvalDetailsValue!.uSalAppEntry,
      uDocType: approvalDetailsValue!.uDocType == null ||
              approvalDetailsValue!.uDocType == "null"
          ? null
          : approvalDetailsValue!.uDocType,
      uIntKey: approvalDetailsValue!.uIntKey == null ||
              approvalDetailsValue!.uIntKey == "null"
          ? null
          : approvalDetailsValue!.uIntKey,
      uQrFileLoc: approvalDetailsValue!.uQrFileLoc == null ||
              approvalDetailsValue!.uQrFileLoc == "null"
          ? null
          : approvalDetailsValue!.uQrFileLoc,
      uRctCde: approvalDetailsValue!.uRctCde == null ||
              approvalDetailsValue!.uRctCde == "null"
          ? null
          : approvalDetailsValue!.uRctCde,
      uZno: approvalDetailsValue!.uZno == null ||
              approvalDetailsValue!.uZno == "null"
          ? null
          : approvalDetailsValue!.uZno,
      uVfdIn: approvalDetailsValue!.uVfdIn == null ||
              approvalDetailsValue!.uVfdIn == "null"
          ? null
          : approvalDetailsValue!.uVfdIn,
      uQrPath: approvalDetailsValue!.uQrPath == null ||
              approvalDetailsValue!.uQrPath == "null"
          ? null
          : approvalDetailsValue!.uQrPath,
      uQrValue: approvalDetailsValue!.uQrValue == null ||
              approvalDetailsValue!.uQrValue == "null"
          ? null
          : approvalDetailsValue!.uQrValue,
      uIdate: approvalDetailsValue!.uIdate == null ||
              approvalDetailsValue!.uIdate == "null"
          ? null
          : approvalDetailsValue!.uIdate,
      uItime: approvalDetailsValue!.uItime == null ||
              approvalDetailsValue!.uItime == "null"
          ? null
          : approvalDetailsValue!.uItime,
      uDeviceCode: approvalDetailsValue!.uDeviceCode == null ||
              approvalDetailsValue!.uDeviceCode == "null"
          ? null
          : approvalDetailsValue!.uDeviceCode,
      uDeviceTransId: approvalDetailsValue!.uDeviceTransId == null ||
              approvalDetailsValue!.uDeviceTransId == "null"
          ? null
          : approvalDetailsValue!.uDeviceTransId,
      uRvc: approvalDetailsValue!.uRvc == null ||
              approvalDetailsValue!.uRvc == "null"
          ? null
          : approvalDetailsValue!.uRvc,
      uVrn: approvalDetailsValue!.uVrn == null ||
              approvalDetailsValue!.uVrn == "null"
          ? null
          : approvalDetailsValue!.uVrn,
      uLongitude: approvalDetailsValue!.uLongitude == null ||
              approvalDetailsValue!.uLongitude == "null"
          ? null
          : approvalDetailsValue!.uLongitude,
      uLatitude: approvalDetailsValue!.uLatitude == null ||
              approvalDetailsValue!.uLatitude == "null"
          ? null
          : approvalDetailsValue!.uLatitude,
      uAuditJobGroup: approvalDetailsValue!.uAuditJobGroup == null ||
              approvalDetailsValue!.uAuditJobGroup == "null"
          ? null
          : approvalDetailsValue!.uAuditJobGroup,
      uAuditName: approvalDetailsValue!.uAuditName == null ||
              approvalDetailsValue!.uAuditName == "null"
          ? null
          : approvalDetailsValue!.uAuditName,
      uRequest: approvalDetailsValue!.uRequest == null ||
              approvalDetailsValue!.uRequest == "null"
          ? null
          : approvalDetailsValue!.uRequest,
      uPosDocNo: approvalDetailsValue!.uPosDocNo == null ||
              approvalDetailsValue!.uPosDocNo == "null"
          ? null
          : approvalDetailsValue!.uPosDocNo,
      documentLines: [],
      documentReferences: approvalDetailsValue!.documentReferences!.isNotEmpty
          ? approvalDetailsValue!.documentReferences
          : [],
      taxExtension: approvalDetailsValue!.taxExtension,
      addressExtension: approvalDetailsValue!.addressExtension,
    );

    getdocitemsDetailsData = approvalDetailsValue!.documentLines!;

    for (var i = 0; i < getdocitemsDetailsData.length; i++) {
      scanneditemCheckUpdateData.add(StocksnapModelData(
          branch: AppConstant.branch,
          itemCode: getdocitemsDetailsData[i].itemCode,
          itemName: getdocitemsDetailsData[i].itemDescription,
          serialBatch: '',
          mrp: getdocitemsDetailsData[i].unitPrice,
          sellPrice: getdocitemsDetailsData[i].unitPrice));
    }
    // for (var i = 0; i < scanneditemData.length; i++) {
    //   for (var ik = 0; ik < approvalDetailsValue!.documentLines!.length; ik++) {
    //     if (scanneditemData[i].baselineid.toString() ==
    //         getdocumentApprovalValue[ik].lineNum.toString()) {
    //       getdocitemsDetailsData .add(DocumentApprovalPutValue(U_Pack_Size: getdocumentApprovalValue[ik]. U_Pack_Size,
    //        lineNum:  getdocumentApprovalValue[ik].lineNum, itemCode: getdocumentApprovalValue[ik]. itemCode,
    //        itemDescription:  getdocumentApprovalValue[ik].itemDescription, quantity:  getdocumentApprovalValue[ik].quantity,

    //         shipDate:  getdocumentApprovalValue[ik].shipDate, price:  getdocumentApprovalValue[ik].price, total:  getdocumentApprovalValue[ik].total, currency:  getdocumentApprovalValue[ik].currency,
    //         rate: getdocumentApprovalValue[ik]. rate, discountPercent: getdocumentApprovalValue[ik]. discountPercent, vendorNum: getdocumentApprovalValue[ik]. vendorNum,
    //          serialNum:  getdocumentApprovalValue[ik].serialNum, warehouseCode: getdocumentApprovalValue[ik]. warehouseCode, salesPersonCode: getdocumentApprovalValue[ik]. salesPersonCode, commisionPercent: getdocumentApprovalValue[ik]. commisionPercent, treeType:  getdocumentApprovalValue[ik].treeType, accountCode: accountCode, useBaseUnits: useBaseUnits, supplierCatNum: supplierCatNum, costingCode: costingCode,
    //          projectCode:  getdocumentApprovalValue[ik].projectCode, barCode:  getdocumentApprovalValue[ik].barCode,
    //          vatGroup: getdocumentApprovalValue[ik]. vatGroup, height1: getdocumentApprovalValue[ik]. height1, hight1Unit:  getdocumentApprovalValue[ik].hight1Unit, height2:  getdocumentApprovalValue[ik].height2, height2Unit:  getdocumentApprovalValue[ik]. getdocumentApprovalValue[ik].height2Unit,
    //          lengh1: getdocumentApprovalValue[ik]. lengh1, lengh1Unit: getdocumentApprovalValue[ik]. lengh1Unit, lengh2:  getdocumentApprovalValue[ik].lengh2, lengh2Unit:  getdocumentApprovalValue[ik].lengh2Unit, weight1: getdocumentApprovalValue[ik]. weight1,
    //          weight1Unit:  getdocumentApprovalValue[ik].weight1Unit, weight2: getdocumentApprovalValue[ik]. weight2, weight2Unit:  getdocumentApprovalValue[ik].weight2Unit, factor1: getdocumentApprovalValue[ik]. factor1, factor2: getdocumentApprovalValue[ik]. factor2, factor3: factor3, factor4: factor4, baseType: baseType, baseEntry: baseEntry,
    //           baseLine: baseLine, volume: volume, volumeUnit: volumeUnit,
    //            width1: width1, width1Unit: width1Unit, width2: width2,
    //             width2Unit: width2Unit, address: address, taxCode: taxCode,
    //             taxType: taxType, taxLiable: taxLiable, pickStatus: pickStatus, pickQuantity: pickQuantity, pickListIdNumber: pickListIdNumber, originalItem: originalItem, backOrder: backOrder, freeText: freeText, shippingMethod: shippingMethod, poTargetNum: poTargetNum, poTargetEntry: poTargetEntry, poTargetRowNum: poTargetRowNum, correctionInvoiceItem: correctionInvoiceItem, corrInvAmountToStock: corrInvAmountToStock, corrInvAmountToDiffAcct: corrInvAmountToDiffAcct, appliedTax: appliedTax, appliedTaxFc: appliedTaxFc, appliedTaxSc: appliedTaxSc, wtLiable: wtLiable, deferredTax: deferredTax, equalizationTaxPercent: equalizationTaxPercent, totalEqualizationTax: totalEqualizationTax, totalEqualizationTaxFc: totalEqualizationTaxFc, totalEqualizationTaxSc: totalEqualizationTaxSc, netTaxAmount: netTaxAmount, netTaxAmountFc: netTaxAmountFc, netTaxAmountSc: netTaxAmountSc, measureUnit: measureUnit, unitsOfMeasurment: unitsOfMeasurment, lineTotal: lineTotal, taxPercentagePerRow: taxPercentagePerRow, taxTotal: taxTotal, consumerSalesForecast: consumerSalesForecast, exciseAmount: exciseAmount, taxPerUnit: taxPerUnit, totalInclTax: totalInclTax, countryOrg: countryOrg, sww: sww, transactionType: transactionType, distributeExpense: distributeExpense, rowTotalFc: rowTotalFc, rowTotalSc: rowTotalSc, lastBuyInmPrice: lastBuyInmPrice, lastBuyDistributeSumFc: lastBuyDistributeSumFc, lastBuyDistributeSumSc: lastBuyDistributeSumSc, lastBuyDistributeSum: lastBuyDistributeSum, stockDistributesumForeign: stockDistributesumForeign, stockDistributesumSystem: stockDistributesumSystem, stockDistributesum: stockDistributesum, stockInmPrice: stockInmPrice, pickStatusEx: pickStatusEx, taxBeforeDpm: taxBeforeDpm, taxBeforeDpmfc: taxBeforeDpmfc, taxBeforeDpmsc: taxBeforeDpmsc,
    //          cfopCode: cfopCode, cstCode: cstCode,
    //          usage: usage, taxOnly: taxOnly, visualOrder: visualOrder, baseOpenQuantity: baseOpenQuantity, unitPrice: unitPrice, lineStatus: lineStatus, packageQuantity: packageQuantity, text: text, lineType: lineType, cogsCostingCode: cogsCostingCode, cogsAccountCode: cogsAccountCode, changeAssemlyBoMWarehouse: changeAssemlyBoMWarehouse, grossBuyPrice: grossBuyPrice, grossBase: grossBase, grossProfitTotalBasePrice: grossProfitTotalBasePrice, costingCode2: costingCode2, costingCode3: costingCode3, costingCode4: costingCode4, costingCode5: costingCode5, itemDetails: itemDetails, locationCode: locationCode, actualDeliveryDate: actualDeliveryDate, remainingOpenQuantity: remainingOpenQuantity, openAmount: openAmount, openAmountFc: openAmountFc, openAmountSc: openAmountSc, exLineNo: exLineNo, Date: Date, requiredQuantity: requiredQuantity, cogsCostingCode2: cogsCostingCode2, cogsCostingCode3: cogsCostingCode3, cogsCostingCode4: cogsCostingCode4, cogsCostingCode5: cogsCostingCode5, csTforIpi: csTforIpi, csTforPis: csTforPis, csTforCofins: csTforCofins, creditOriginCode: creditOriginCode, withoutInventoryMovement: withoutInventoryMovement, agreementNo: agreementNo, agreementRowNumber: agreementRowNumber, actualBaseEntry: actualBaseEntry, actualBaseLine: actualBaseLine, docEntry: docEntry, surpluses: surpluses, defectAndBreakup: defectAndBreakup, shortages: shortages, considerQuantity: considerQuantity, partialRetirement: partialRetirement, retirementQuantity: retirementQuantity, retirementApc: retirementApc, thirdParty: thirdParty, poNum: poNum, poItmNum: poItmNum, expenseType: expenseType, receiptNumber: receiptNumber, expenseOperationType: expenseOperationType, federalTaxId: federalTaxId, grossProfit: grossProfit, grossProfitFc: grossProfitFc, grossProfitSc: grossProfitSc, priceSource: priceSource, stgSeqNum: stgSeqNum, stgEntry: stgEntry, stgDesc: stgDesc, uoMEntry: uoMEntry, uoMCode: uoMCode, inventoryQuantity: inventoryQuantity, remainingOpenInventoryQuantity: remainingOpenInventoryQuantity, parentLineNum: parentLineNum, incoterms: incoterms, transportMode: transportMode, natureOfTransaction: natureOfTransaction, destinationCountryForImport: destinationCountryForImport, destinationRegionForImport: destinationRegionForImport, originCountryForExport: originCountryForExport, originRegionForExport: originRegionForExport, itemType: itemType, changeInventoryQuantityIndependently: changeInventoryQuantityIndependently, freeOfChargeBp: freeOfChargeBp, sacEntry: sacEntry, hsnEntry: hsnEntry, grossPrice: grossPrice, grossTotal: grossTotal, grossTotalFc: grossTotalFc, grossTotalSc: grossTotalSc, ncmCode: ncmCode, nveCode: nveCode, indEscala: indEscala, ctrSealQty: ctrSealQty, cnjpMan: cnjpMan, cestCode: cestCode, ufFiscalBenefitCode: ufFiscalBenefitCode, shipToCode: shipToCode, shipToDescription: shipToDescription, externalCalcTaxRate: externalCalcTaxRate, externalCalcTaxAmount: externalCalcTaxAmount, externalCalcTaxAmountFc: externalCalcTaxAmountFc, externalCalcTaxAmountSc: externalCalcTaxAmountSc, standardItemIdentification: standardItemIdentification, commodityClassification: commodityClassification, unencumberedReason: unencumberedReason, cuSplit: cuSplit, uQtyOrdered: uQtyOrdered, uOpenQty: uOpenQty, uTonnage: uTonnage, uPackSize: uPackSize, uProfitCentre: uProfitCentre, uNumberDrums: uNumberDrums, uDrumSize: uDrumSize, uPails: uPails, uCartons: uCartons, uLooseTins: uLooseTins, uNettWt: uNettWt, uGrossWt: uGrossWt, uAppLinId: uAppLinId, uMuQty: uMuQty, uRvc: uRvc, uVrn: uVrn, uIdentifier: uIdentifier))
    //     }
    //   }
    // }
  }

  putcheckitem() async {
    itemsDetailsData = [];
    log("getdocitemsDetailsData::::${getdocitemsDetailsData.length}");
    // for (int i = 0; i < getdocitemsDetailsData.length; i++) {
    await dputItemListData();
    // }
  }

  static List<AddItem2> contentitemsDetails = [];

  getEditQuatationDetails() async {
    contentitemsDetails = [];

    for (int i = 0; i < getdocumentApprovalValue.length; i++) {
      log("Message:::$i");
      print("Total::" + getdocumentApprovalValue[i].total.toString());
      print("Tacode::" + getdocumentApprovalValue[i].taxTotal.toString());
      // // print("Tacode::" + getdocumentApprovalValue[i].toString());
      // final double taxtotall = getdocumentApprovalValue[i].taxTotal == null
      //     ? 0
      //     : getdocumentApprovalValue[i].taxTotal!;
      contentitemsDetails.add(AddItem2(
        warehouse: getdocumentApprovalValue[i].warehouseCode,
        itemCode: getdocumentApprovalValue[i].itemCode,
        itemName: getdocumentApprovalValue[i].itemDescription,
        price: getdocumentApprovalValue[i].unitPrice,

        discount: getdocumentApprovalValue[i].discountPercent,
        qty: double.parse(
            getdocumentApprovalValue[i].quantity!.toStringAsFixed(0)),
        total: getdocumentApprovalValue[i].lineTotal,
        valuechoosed: getdocumentApprovalValue[i].taxCode.toString(),
        discounpercent: getdocumentApprovalValue[i].discountPercent,
        tax: getdocumentApprovalValue[i].taxTotal,
        taxCode: selectedcust!.taxCode,
        lineNoo: i,

        // double.parse( getdocumentApprovalValue[i].TaxCode.toString()) == null ||
        //        double.parse( getdocumentApprovalValue[i].TaxCode) ==0
        // ? isTaxApplied(getdocumentApprovalValue[i].LineTotal!,
        //     getdocumentApprovalValue[i].TaxTotal!)
        //     :     double.parse( getdocumentApprovalValue[i].TaxCode!),
        taxPer: 0,
        // caluclateTaxpercent(
        //     getdocumentApprovalValue[i].lineTotal!, taxtotall),
        // wareHouseCode: GetValues.branch.toString(),
        // // getdocumentApprovalValue[i]
        // //     .warehouseCode,
        // taxName: "",
        // baseline: getdocumentApprovalValue[i].LineNum.toString(),
        // basedocentry: docEntryforSO
        lineNumm: i,
        itemDescription: getdocumentApprovalValue[i].itemDescription,
        quantity: getdocumentApprovalValue[i].quantity,
        shipDate: getdocumentApprovalValue[i].shipDate,
        priceAfterVat: getdocumentApprovalValue[i].total,
        currency: getdocumentApprovalValue[i].currency,
        rate: getdocumentApprovalValue[i].rate,
        discountPercent: getdocumentApprovalValue[i].discountPercent,
        vendorNum: getdocumentApprovalValue[i].vendorNum,
        serialNum: getdocumentApprovalValue[i].serialNum,
        warehouseCode: getdocumentApprovalValue[i].warehouseCode,
        salesPersonCode: getdocumentApprovalValue[i].salesPersonCode,
        commisionPercent: getdocumentApprovalValue[i].commisionPercent,
        treeType: getdocumentApprovalValue[i].treeType,
        accountCode: getdocumentApprovalValue[i].accountCode,
        useBaseUnits: getdocumentApprovalValue[i].useBaseUnits,
        supplierCatNum: getdocumentApprovalValue[i].supplierCatNum,
        costingCode: getdocumentApprovalValue[i].costingCode,
        projectCode: getdocumentApprovalValue[i].projectCode,
        barCode: getdocumentApprovalValue[i].barCode,
        vatGroup: getdocumentApprovalValue[i].vatGroup,
        height1: getdocumentApprovalValue[i].height1,
        hight1Unit: getdocumentApprovalValue[i].hight1Unit,
        height2: getdocumentApprovalValue[i].height2,
        height2Unit: getdocumentApprovalValue[i].height2Unit,
        lengh1: getdocumentApprovalValue[i].lengh1,
        lengh1Unit: getdocumentApprovalValue[i].lengh1Unit,
        lengh2: getdocumentApprovalValue[i].lengh2,
        lengh2Unit: getdocumentApprovalValue[i].lengh2Unit,
        weight1: getdocumentApprovalValue[i].weight1,
        weight1Unit: getdocumentApprovalValue[i].weight1Unit,
        weight2: getdocumentApprovalValue[i].weight2,
        weight2Unit: getdocumentApprovalValue[i].weight2Unit,
        factor1: getdocumentApprovalValue[i].factor1,
        factor2: getdocumentApprovalValue[i].factor2,
        factor3: getdocumentApprovalValue[i].factor3,
        factor4: getdocumentApprovalValue[i].factor4,
        baseType: getdocumentApprovalValue[i].baseType,
        baseEntry: getdocumentApprovalValue[i].baseEntry,
        baseLine: getdocumentApprovalValue[i].baseLine,
        volume: getdocumentApprovalValue[i].volume,
        volumeUnit: getdocumentApprovalValue[i].volumeUnit,
        width1: getdocumentApprovalValue[i].width1,
        width1Unit: getdocumentApprovalValue[i].width1Unit,
        width2: getdocumentApprovalValue[i].width2,
        width2Unit: getdocumentApprovalValue[i].width2Unit,
        address: getdocumentApprovalValue[i].address,
        taxType: getdocumentApprovalValue[i].taxType,
        taxLiable: getdocumentApprovalValue[i].taxLiable,
        pickStatus: getdocumentApprovalValue[i].pickStatus,
        pickQuantity: getdocumentApprovalValue[i].pickQuantity,
        pickListIdNumber: getdocumentApprovalValue[i].pickListIdNumber,
        originalItem: getdocumentApprovalValue[i].originalItem,
        backOrder: getdocumentApprovalValue[i].backOrder,
        freeText: getdocumentApprovalValue[i].freeText,
        shippingMethod: getdocumentApprovalValue[i].shippingMethod,
        poTargetNum: getdocumentApprovalValue[i].poTargetNum,
        poTargetEntry: getdocumentApprovalValue[i].poTargetEntry,
        poTargetRowNum: getdocumentApprovalValue[i].poTargetRowNum,
        correctionInvoiceItem:
            getdocumentApprovalValue[i].correctionInvoiceItem,
        corrInvAmountToStock: getdocumentApprovalValue[i].corrInvAmountToStock,
        corrInvAmountToDiffAcct:
            getdocumentApprovalValue[i].corrInvAmountToDiffAcct,
        appliedTax: getdocumentApprovalValue[i].appliedTax,
        appliedTaxFc: getdocumentApprovalValue[i].appliedTaxFc,
        appliedTaxSc: getdocumentApprovalValue[i].appliedTaxSc,
        wtLiable: getdocumentApprovalValue[i].wtLiable,
        deferredTax: getdocumentApprovalValue[i].deferredTax,
        equalizationTaxPercent:
            getdocumentApprovalValue[i].equalizationTaxPercent,
        totalEqualizationTax: getdocumentApprovalValue[i].totalEqualizationTax,
        totalEqualizationTaxFc:
            getdocumentApprovalValue[i].totalEqualizationTaxFc,
        totalEqualizationTaxSc:
            getdocumentApprovalValue[i].totalEqualizationTaxSc,
        netTaxAmount: getdocumentApprovalValue[i].netTaxAmount,
        netTaxAmountFc: getdocumentApprovalValue[i].netTaxAmountFc,
        netTaxAmountSc: getdocumentApprovalValue[i].netTaxAmountSc,
        measureUnit: getdocumentApprovalValue[i].measureUnit,
        unitsOfMeasurment: getdocumentApprovalValue[i].unitsOfMeasurment,
        lineTotal: getdocumentApprovalValue[i].lineTotal,
        taxPercentagePerRow: getdocumentApprovalValue[i].taxPercentagePerRow,
        taxTotal: getdocumentApprovalValue[i].taxTotal,
        consumerSalesForecast:
            getdocumentApprovalValue[i].consumerSalesForecast,
        exciseAmount: getdocumentApprovalValue[i].exciseAmount,
        taxPerUnit: getdocumentApprovalValue[i].taxPerUnit,
        totalInclTax: getdocumentApprovalValue[i].totalInclTax,
        countryOrg: getdocumentApprovalValue[i].countryOrg,
        sww: getdocumentApprovalValue[i].sww,
        transactionType: getdocumentApprovalValue[i].transactionType,
        distributeExpense: getdocumentApprovalValue[i].distributeExpense,
        rowTotalFc: getdocumentApprovalValue[i].rowTotalFc,
        rowTotalSc: getdocumentApprovalValue[i].rowTotalSc,
        lastBuyInmPrice: getdocumentApprovalValue[i].lastBuyInmPrice,
        lastBuyDistributeSumFc:
            getdocumentApprovalValue[i].lastBuyDistributeSumFc,
        lastBuyDistributeSumSc:
            getdocumentApprovalValue[i].lastBuyDistributeSumSc,
        lastBuyDistributeSum: getdocumentApprovalValue[i].lastBuyDistributeSum,
        stockDistributesumForeign:
            getdocumentApprovalValue[i].stockDistributesumForeign,
        stockDistributesumSystem:
            getdocumentApprovalValue[i].stockDistributesumSystem,
        stockDistributesum: getdocumentApprovalValue[i].stockDistributesum,
        stockInmPrice: getdocumentApprovalValue[i].stockInmPrice,
        pickStatusEx: getdocumentApprovalValue[i].pickStatusEx,
        taxBeforeDpm: getdocumentApprovalValue[i].taxBeforeDpm,
        taxBeforeDpmfc: getdocumentApprovalValue[i].taxBeforeDpmfc,
        taxBeforeDpmsc: getdocumentApprovalValue[i].taxBeforeDpmsc,
        cfopCode: getdocumentApprovalValue[i].cfopCode,
        cstCode: getdocumentApprovalValue[i].cstCode,
        usage: getdocumentApprovalValue[i].usage,
        taxOnly: getdocumentApprovalValue[i].taxOnly,
        visualOrder: getdocumentApprovalValue[i].visualOrder,
        baseOpenQuantity: getdocumentApprovalValue[i].baseOpenQuantity,
        unitPrice: getdocumentApprovalValue[i].unitPrice,
        lineStatus: getdocumentApprovalValue[i].lineStatus,
        packageQuantity: getdocumentApprovalValue[i].packageQuantity,
        text: getdocumentApprovalValue[i].text,
        lineType: getdocumentApprovalValue[i].lineType,
        cogsCostingCode: getdocumentApprovalValue[i].cogsCostingCode,
        cogsAccountCode: getdocumentApprovalValue[i].cogsAccountCode,
        changeAssemlyBoMWarehouse:
            getdocumentApprovalValue[i].changeAssemlyBoMWarehouse,
        grossBuyPrice: getdocumentApprovalValue[i].grossBuyPrice,
        grossBase: getdocumentApprovalValue[i].grossBase,
        grossProfitTotalBasePrice:
            getdocumentApprovalValue[i].grossProfitTotalBasePrice,
        costingCode2: getdocumentApprovalValue[i].costingCode2,
        costingCode3: getdocumentApprovalValue[i].costingCode3,
        costingCode4: getdocumentApprovalValue[i].costingCode4,
        costingCode5: getdocumentApprovalValue[i].costingCode5,
        itemDetails: getdocumentApprovalValue[i].itemDetails,
        locationCode: getdocumentApprovalValue[i].locationCode,
        actualDeliveryDate: getdocumentApprovalValue[i].actualDeliveryDate,
        remainingOpenQuantity:
            getdocumentApprovalValue[i].remainingOpenQuantity,
        openAmount: getdocumentApprovalValue[i].openAmount,
        openAmountFc: getdocumentApprovalValue[i].openAmountFc,
        openAmountSc: getdocumentApprovalValue[i].openAmountSc,
        exLineNo: getdocumentApprovalValue[i].exLineNo,
        Date: getdocumentApprovalValue[i].Date,
        Quantity: getdocumentApprovalValue[i].quantity,
        cogsCostingCode2: getdocumentApprovalValue[i].cogsCostingCode2,
        cogsCostingCode3: getdocumentApprovalValue[i].cogsCostingCode3,
        cogsCostingCode4: getdocumentApprovalValue[i].cogsCostingCode4,
        cogsCostingCode5: getdocumentApprovalValue[i].cogsCostingCode5,
        csTforIpi: getdocumentApprovalValue[i].csTforIpi,
        csTforPis: getdocumentApprovalValue[i].csTforPis,
        csTforCofins: getdocumentApprovalValue[i].csTforCofins,
        creditOriginCode: getdocumentApprovalValue[i].creditOriginCode,
        withoutInventoryMovement:
            getdocumentApprovalValue[i].withoutInventoryMovement,
        agreementNo: getdocumentApprovalValue[i].agreementNo,
        agreementRowNumber: getdocumentApprovalValue[i].agreementRowNumber,
        actualBaseEntry: getdocumentApprovalValue[i].actualBaseEntry,
        actualBaseLine: getdocumentApprovalValue[i].actualBaseLine,
        docEntry: getdocumentApprovalValue[i].docEntry,
        surpluses: getdocumentApprovalValue[i].surpluses,
        defectAndBreakup: getdocumentApprovalValue[i].defectAndBreakup,
        shortages: getdocumentApprovalValue[i].shortages,
        considerQuantity: getdocumentApprovalValue[i].considerQuantity,
        partialRetirement: getdocumentApprovalValue[i].partialRetirement,
        retirementQuantity: getdocumentApprovalValue[i].retirementQuantity,
        retirementApc: getdocumentApprovalValue[i].retirementApc,
        thirdParty: getdocumentApprovalValue[i].thirdParty,
        poNum: getdocumentApprovalValue[i].poNum,
        poItmNum: getdocumentApprovalValue[i].poItmNum,
        expenseType: getdocumentApprovalValue[i].expenseType,
        receiptNumber: getdocumentApprovalValue[i].receiptNumber,
        expenseOperationType: getdocumentApprovalValue[i].expenseOperationType,
        federalTaxId: getdocumentApprovalValue[i].federalTaxId,
        grossProfit: getdocumentApprovalValue[i].grossProfit,
        grossProfitFc: getdocumentApprovalValue[i].grossProfitFc,
        grossProfitSc: getdocumentApprovalValue[i].grossProfitSc,
        priceSource: getdocumentApprovalValue[i].priceSource,
        stgSeqNum: getdocumentApprovalValue[i].stgSeqNum,
        stgEntry: getdocumentApprovalValue[i].stgEntry,
        stgDesc: getdocumentApprovalValue[i].stgDesc,
        uoMEntry: getdocumentApprovalValue[i].uoMEntry,
        uoMCode: getdocumentApprovalValue[i].uoMCode,
        inventoryQuantity: getdocumentApprovalValue[i].inventoryQuantity,
        remainingOpenInventoryQuantity:
            getdocumentApprovalValue[i].remainingOpenInventoryQuantity,
        parentLineNum: getdocumentApprovalValue[i].parentLineNum,
        incoterms: getdocumentApprovalValue[i].incoterms,
        transportMode: getdocumentApprovalValue[i].transportMode,
        natureOfTransaction: getdocumentApprovalValue[i].natureOfTransaction,
        destinationCountryForImport:
            getdocumentApprovalValue[i].destinationCountryForImport,
        destinationRegionForImport:
            getdocumentApprovalValue[i].destinationRegionForImport,
        originCountryForExport:
            getdocumentApprovalValue[i].originCountryForExport,
        originRegionForExport:
            getdocumentApprovalValue[i].originRegionForExport,
        itemType: getdocumentApprovalValue[i].itemType,
        changeInventoryQuantityIndependently:
            getdocumentApprovalValue[i].changeInventoryQuantityIndependently,
        freeOfChargeBp: getdocumentApprovalValue[i].freeOfChargeBp,
        sacEntry: getdocumentApprovalValue[i].sacEntry,
        hsnEntry: getdocumentApprovalValue[i].hsnEntry,
        grossPrice: getdocumentApprovalValue[i].grossPrice,
        grossTotal: getdocumentApprovalValue[i].grossTotal,
        grossTotalFc: getdocumentApprovalValue[i].grossTotalFc,
        grossTotalSc: getdocumentApprovalValue[i].grossTotalSc,
        ncmCode: getdocumentApprovalValue[i].ncmCode,
        nveCode: getdocumentApprovalValue[i].nveCode,
        indEscala: getdocumentApprovalValue[i].indEscala,
        ctrSealQty: getdocumentApprovalValue[i].ctrSealQty,
        cnjpMan: getdocumentApprovalValue[i].cnjpMan,
        cestCode: getdocumentApprovalValue[i].cestCode,
        ufFiscalBenefitCode: getdocumentApprovalValue[i].ufFiscalBenefitCode,
        shipToCode: getdocumentApprovalValue[i].shipToCode,
        shipToDescription: getdocumentApprovalValue[i].shipToDescription,
        externalCalcTaxRate: getdocumentApprovalValue[i].externalCalcTaxRate,
        externalCalcTaxAmount:
            getdocumentApprovalValue[i].externalCalcTaxAmount,
        externalCalcTaxAmountFc:
            getdocumentApprovalValue[i].externalCalcTaxAmountFc,
        externalCalcTaxAmountSc:
            getdocumentApprovalValue[i].externalCalcTaxAmountSc,
        standardItemIdentification:
            getdocumentApprovalValue[i].standardItemIdentification,
        commodityClassification:
            getdocumentApprovalValue[i].commodityClassification,
        unencumberedReason: getdocumentApprovalValue[i].unencumberedReason,
        cuSplit: getdocumentApprovalValue[i].cuSplit,
        uQtyOrdered: getdocumentApprovalValue[i].uQtyOrdered,
        uOpenQty: getdocumentApprovalValue[i].uOpenQty,
        uTonnage: getdocumentApprovalValue[i].uTonnage,
        uPackSize: getdocumentApprovalValue[i].uPackSize,
        uProfitCentre: getdocumentApprovalValue[i].uProfitCentre,
        uNumberDrums: getdocumentApprovalValue[i].uNumberDrums,
        uDrumSize: getdocumentApprovalValue[i].uDrumSize,
        uPails: getdocumentApprovalValue[i].uPails,
        uCartons: getdocumentApprovalValue[i].uCartons,
        uLooseTins: getdocumentApprovalValue[i].uLooseTins,
        uNettWt: getdocumentApprovalValue[i].uNettWt,
        uGrossWt: getdocumentApprovalValue[i].uGrossWt,
        uAppLinId: getdocumentApprovalValue[i].uAppLinId,
        uMuQty: getdocumentApprovalValue[i].uMuQty,
        uRvc: getdocumentApprovalValue[i].uRvc,
        uVrn: getdocumentApprovalValue[i].uVrn,
        uIdentifier: getdocumentApprovalValue[i].uIdentifier,
        U_Pack_Size: getdocumentApprovalValue[i].U_Pack_Size,
      ));
    }
    // //

    for (int ij = 0; ij < contentitemsDetails.length; ij++) {
      mycontroller[1].text = contentitemsDetails[ij].price!.toString();
      mycontroller[3].text = contentitemsDetails[ij].discount!.toString();
      mycontroller[2].text = contentitemsDetails[ij].qty!.toString();

      // await getTaxRate(ij, contentitemsDetails[ij].taxCode.toString());

      //

      // await GetPackANDTinsPerBoxApi.getGlobalData(
      //         contentitemsDetails[ij].itemCode)
      //     .then((value) {
      //   if (value.statusCode! <= 210 && value.statusCode! >= 200) {
      //     log("PackSize::" + value.activitiesData![0].U_Pack_Size.toString());
      //     log("TinPErBox::" +
      //         value.activitiesData![0].U_Tins_Per_Box.toString());
      //     log("controller 4:::" + mycontroller[4].text);

      //     contentitemsDetails[ij].U_Pack_Size =
      //         value.activitiesData![0].U_Pack_Size;
      //     contentitemsDetails[ij].U_Tins_Per_Box =
      //         value.activitiesData![0].U_Tins_Per_Box;
      //     //
      //     final double price = contentitemsDetails[ij].unitPrice!;
      //     // double.parse(mycontroller[1].text);
      //     final double qty = contentitemsDetails[ij].qty!;
      //     // double.parse(mycontroller[2].text);
      //     final double discountper =
      //         double.parse(contentitemsDetails[ij].discounpercent.toString()
      //             // mycontroller[3].text == '' ? '0' : mycontroller[3].text
      //             );
      //     final double discount = (price * qty) * discountper / 100;
      //     final double taxper = taxSelected;
      //     final double tax = ((qty * price) - discount) * taxper / 100;

      //     double total = (price * qty) - discount;
      //     log("total1::::" + total.toString());

      //     log("discount val::::" + discount.toString());
      //     total = total + tax;
      //     log("total2::::" + total.toString());
      //     int carton2 = 0;
      //     if (contentitemsDetails[ij].U_Pack_Size! < 10 &&
      //         contentitemsDetails[ij].U_Tins_Per_Box! > 0) {
      //       carton2 = qty ~/ contentitemsDetails[ij].U_Tins_Per_Box!;
      //       print("cartooooooone" + carton2.toString());
      //       print("cartooooooone" + carton2.toInt().toString());
      //     }
      //     contentitemsDetails[ij].carton = carton2;
      //     contentitemsDetails[ij].valueAF = (price * qty) - discount;
      //     contentitemsDetails[ij].total = total;
      //   }
      //   // contentitemsDetails[i].shipToCode = "";
      //   // contentitemsDetails[i].lineNo = 0;
      // });
    }

    // contentitemsDetails
  }

  dputItemListData() {
    for (int ij = 0; ij < getdocumentApprovalValue.length; ij++) {
      for (var i = 0; i < scanneditemData.length; i++) {
        if (scanneditemData[i].baselineid.toString() ==
            getdocumentApprovalValue[ij].lineNum.toString()) {
          log("getdocumentApprovalValue[ij].lineNo::${getdocumentApprovalValue[ij].lineNum}");
          // log("message:::");
          if (getdocumentApprovalValue[ij].lineNum != null) {
            itemsDetailsData.add(
              DocumentLineData(
                lineNum: getdocumentApprovalValue[ij].lineNum,
                itemCode: getdocumentApprovalValue[ij].itemCode,
                itemDescription: getdocumentApprovalValue[ij].itemDescription,
                quantity: getdocumentApprovalValue[ij].quantity,
                shipDate: getdocumentApprovalValue[ij].shipDate,
                price: getdocumentApprovalValue[ij].price,
                priceAfterVat: getdocumentApprovalValue[ij].total,
                currency: '',
                rate: getdocumentApprovalValue[ij].rate,
                discountPercent: getdocumentApprovalValue[ij].discountPercent,
                vendorNum: getdocumentApprovalValue[ij].vendorNum,
                serialNum: getdocumentApprovalValue[ij].serialNum,
                warehouseCode: getdocumentApprovalValue[ij].warehouseCode,
                salesPersonCode: getdocumentApprovalValue[ij].salesPersonCode,
                commisionPercent: getdocumentApprovalValue[ij].commisionPercent,
                treeType: getdocumentApprovalValue[ij].treeType,
                accountCode: getdocumentApprovalValue[ij].accountCode,
                useBaseUnits: getdocumentApprovalValue[ij].useBaseUnits,
                supplierCatNum: getdocumentApprovalValue[ij].supplierCatNum,
                costingCode: getdocumentApprovalValue[ij].costingCode,
                projectCode: getdocumentApprovalValue[ij].projectCode == null ||
                        getdocumentApprovalValue[ij].projectCode == "null"
                    ? null
                    : getdocumentApprovalValue[ij].projectCode,
                // getdocumentApprovalValue[ij].projectCode,
                barCode: getdocumentApprovalValue[ij].barCode == null ||
                        getdocumentApprovalValue[ij].barCode == "null"
                    ? null
                    : getdocumentApprovalValue[ij].barCode,
                vatGroup: getdocumentApprovalValue[ij].vatGroup,
                height1: getdocumentApprovalValue[ij].height1,
                hight1Unit: getdocumentApprovalValue[ij].hight1Unit == null ||
                        getdocumentApprovalValue[ij].hight1Unit == "null"
                    ? null
                    : getdocumentApprovalValue[ij].hight1Unit,
                height2: getdocumentApprovalValue[ij].height2,
                height2Unit: getdocumentApprovalValue[ij].height2Unit == null ||
                        getdocumentApprovalValue[ij].height2Unit == "null"
                    ? null
                    : getdocumentApprovalValue[ij].height2Unit,
                lengh1: getdocumentApprovalValue[ij].lengh1,
                lengh1Unit: getdocumentApprovalValue[ij].lengh1Unit == null ||
                        getdocumentApprovalValue[ij].lengh1Unit == "null"
                    ? null
                    : getdocumentApprovalValue[ij].lengh1Unit,
                lengh2: getdocumentApprovalValue[ij].lengh2,
                lengh2Unit: getdocumentApprovalValue[ij].lengh2Unit == null ||
                        getdocumentApprovalValue[ij].lengh2Unit == "null"
                    ? null
                    : getdocumentApprovalValue[ij].lengh2Unit,
                weight1: getdocumentApprovalValue[ij].weight1,
                weight1Unit: getdocumentApprovalValue[ij].weight1Unit,
                weight2: getdocumentApprovalValue[ij].weight2,
                weight2Unit: getdocumentApprovalValue[ij].weight2Unit,
                factor1: getdocumentApprovalValue[ij].factor1,
                factor2: getdocumentApprovalValue[ij].factor2,
                factor3: getdocumentApprovalValue[ij].factor3,
                factor4: getdocumentApprovalValue[ij].factor4,
                baseType: getdocumentApprovalValue[ij].baseType,
                baseEntry: getdocumentApprovalValue[ij].baseEntry,
                baseLine: getdocumentApprovalValue[ij].baseLine,
                volume: getdocumentApprovalValue[ij].volume,
                volumeUnit: getdocumentApprovalValue[ij].volumeUnit,
                width1: getdocumentApprovalValue[ij].weight1,
                width1Unit: getdocumentApprovalValue[ij].width1Unit,
                width2: getdocumentApprovalValue[ij].weight2,
                width2Unit: getdocumentApprovalValue[ij].width2Unit,
                address: getdocumentApprovalValue[ij].address,
                taxCode: getdocumentApprovalValue[ij].taxCode,
                taxType: getdocumentApprovalValue[ij].taxType,
                taxLiable: getdocumentApprovalValue[ij].taxLiable,
                pickStatus: getdocumentApprovalValue[ij].pickStatus,
                pickQuantity: getdocumentApprovalValue[ij].pickQuantity,
                pickListIdNumber: getdocumentApprovalValue[ij].pickListIdNumber,
                originalItem: getdocumentApprovalValue[ij].originalItem,
                backOrder: getdocumentApprovalValue[ij].backOrder,
                freeText: getdocumentApprovalValue[ij].freeText,
                shippingMethod: getdocumentApprovalValue[ij].shippingMethod,
                poTargetNum: getdocumentApprovalValue[ij].poTargetNum == null ||
                        getdocumentApprovalValue[ij].poTargetNum == "null"
                    ? null
                    : getdocumentApprovalValue[ij].poTargetNum,
                poTargetEntry: getdocumentApprovalValue[ij].poTargetEntry,
                poTargetRowNum: getdocumentApprovalValue[ij].poTargetRowNum,
                correctionInvoiceItem:
                    getdocumentApprovalValue[ij].correctionInvoiceItem,
                corrInvAmountToStock:
                    getdocumentApprovalValue[ij].corrInvAmountToStock,
                corrInvAmountToDiffAcct:
                    getdocumentApprovalValue[ij].corrInvAmountToDiffAcct,
                appliedTax: getdocumentApprovalValue[ij].appliedTax,
                appliedTaxFc: getdocumentApprovalValue[ij].appliedTaxFc,
                appliedTaxSc: getdocumentApprovalValue[ij].appliedTaxSc,
                wtLiable: getdocumentApprovalValue[ij].wtLiable,
                deferredTax: getdocumentApprovalValue[ij].deferredTax,
                equalizationTaxPercent:
                    getdocumentApprovalValue[ij].equalizationTaxPercent,
                totalEqualizationTax:
                    getdocumentApprovalValue[ij].totalEqualizationTax,
                totalEqualizationTaxFc:
                    getdocumentApprovalValue[ij].totalEqualizationTaxFc,
                totalEqualizationTaxSc:
                    getdocumentApprovalValue[ij].totalEqualizationTaxSc,
                netTaxAmount: getdocumentApprovalValue[ij].netTaxAmount,
                netTaxAmountFc: getdocumentApprovalValue[ij].netTaxAmountFc,
                netTaxAmountSc: getdocumentApprovalValue[ij].netTaxAmountSc,
                measureUnit: getdocumentApprovalValue[ij].measureUnit,
                unitsOfMeasurment:
                    getdocumentApprovalValue[ij].unitsOfMeasurment,
                lineTotal: getdocumentApprovalValue[ij].lineTotal,
                taxPercentagePerRow:
                    getdocumentApprovalValue[ij].taxPercentagePerRow,
                taxTotal: getdocumentApprovalValue[ij].taxTotal,
                consumerSalesForecast:
                    getdocumentApprovalValue[ij].consumerSalesForecast,
                exciseAmount: getdocumentApprovalValue[ij].exciseAmount,
                taxPerUnit: getdocumentApprovalValue[ij].taxPerUnit,
                totalInclTax: getdocumentApprovalValue[ij].totalInclTax,
                countryOrg: getdocumentApprovalValue[ij].countryOrg,
                sww: getdocumentApprovalValue[ij].sww,
                transactionType: getdocumentApprovalValue[ij].transactionType ==
                            null ||
                        getdocumentApprovalValue[ij].transactionType == "null"
                    ? null
                    : getdocumentApprovalValue[ij].transactionType,
                distributeExpense:
                    getdocumentApprovalValue[ij].distributeExpense,
                rowTotalFc: getdocumentApprovalValue[ij].rowTotalFc,
                rowTotalSc: getdocumentApprovalValue[ij].rowTotalSc,
                lastBuyInmPrice: getdocumentApprovalValue[ij].lastBuyInmPrice,
                lastBuyDistributeSumFc:
                    getdocumentApprovalValue[ij].lastBuyDistributeSumFc,
                lastBuyDistributeSumSc:
                    getdocumentApprovalValue[ij].lastBuyDistributeSumSc,
                lastBuyDistributeSum:
                    getdocumentApprovalValue[ij].lastBuyDistributeSum,
                stockDistributesumForeign:
                    getdocumentApprovalValue[ij].stockDistributesumForeign,
                stockDistributesumSystem:
                    getdocumentApprovalValue[ij].stockDistributesumSystem,
                stockDistributesum:
                    getdocumentApprovalValue[ij].stockDistributesum,
                stockInmPrice: getdocumentApprovalValue[ij].stockInmPrice,
                pickStatusEx: getdocumentApprovalValue[ij].pickStatusEx,
                taxBeforeDpm: getdocumentApprovalValue[ij].taxBeforeDpm,
                taxBeforeDpmfc: getdocumentApprovalValue[ij].taxBeforeDpmfc,
                taxBeforeDpmsc: getdocumentApprovalValue[ij].taxBeforeDpmsc,
                cfopCode: getdocumentApprovalValue[ij].cfopCode,
                cstCode: getdocumentApprovalValue[ij].cstCode,
                usage: getdocumentApprovalValue[ij].usage,
                taxOnly: getdocumentApprovalValue[ij].taxOnly,
                visualOrder: getdocumentApprovalValue[ij].visualOrder,
                baseOpenQuantity: getdocumentApprovalValue[ij].baseOpenQuantity,
                unitPrice:
                    double.parse(getdocumentApprovalValue[ij].price.toString()),
                lineStatus: getdocumentApprovalValue[ij].lineStatus,
                packageQuantity: getdocumentApprovalValue[ij].packageQuantity,
                text: getdocumentApprovalValue[ij].text,
                lineType: getdocumentApprovalValue[ij].lineType,
                cogsCostingCode: getdocumentApprovalValue[ij].cogsCostingCode,
                cogsAccountCode: getdocumentApprovalValue[ij].cogsAccountCode,
                changeAssemlyBoMWarehouse:
                    getdocumentApprovalValue[ij].changeAssemlyBoMWarehouse,
                grossBuyPrice: getdocumentApprovalValue[ij].grossBuyPrice,
                grossBase: getdocumentApprovalValue[ij].grossBase,
                grossProfitTotalBasePrice:
                    getdocumentApprovalValue[ij].grossProfitTotalBasePrice,
                costingCode2: getdocumentApprovalValue[ij].costingCode2,
                costingCode3: getdocumentApprovalValue[ij].costingCode3,
                costingCode4: getdocumentApprovalValue[ij].costingCode5,
                costingCode5: getdocumentApprovalValue[ij].costingCode5,
                itemDetails: getdocumentApprovalValue[ij].itemDetails,
                locationCode: getdocumentApprovalValue[ij].locationCode,
                actualDeliveryDate:
                    getdocumentApprovalValue[ij].actualDeliveryDate,
                remainingOpenQuantity: 0,
                openAmount: 0,
                openAmountFc: 0,
                openAmountSc: 0,
                exLineNo: getdocumentApprovalValue[ij].exLineNo,
                Date: getdocumentApprovalValue[ij].Date,
                Quantity: getdocumentApprovalValue[ij].quantity,
                cogsCostingCode2: getdocumentApprovalValue[ij].cogsCostingCode2,
                cogsCostingCode3: getdocumentApprovalValue[ij].cogsCostingCode3,
                cogsCostingCode4: getdocumentApprovalValue[ij].cogsCostingCode4,
                cogsCostingCode5: getdocumentApprovalValue[ij].cogsCostingCode5,
                csTforIpi: getdocumentApprovalValue[ij].csTforIpi,
                csTforPis: getdocumentApprovalValue[ij].csTforPis,
                csTforCofins: getdocumentApprovalValue[ij].csTforCofins,
                creditOriginCode: getdocumentApprovalValue[ij].creditOriginCode,
                withoutInventoryMovement:
                    getdocumentApprovalValue[ij].withoutInventoryMovement,
                agreementNo: getdocumentApprovalValue[ij].agreementNo,
                agreementRowNumber:
                    getdocumentApprovalValue[ij].agreementRowNumber,
                actualBaseEntry: getdocumentApprovalValue[ij].actualBaseEntry,
                actualBaseLine: getdocumentApprovalValue[ij].actualBaseLine,
                docEntry: getdocumentApprovalValue[ij].docEntry,
                surpluses: getdocumentApprovalValue[ij].surpluses,
                defectAndBreakup: getdocumentApprovalValue[ij].defectAndBreakup,
                shortages: getdocumentApprovalValue[ij].shortages,
                considerQuantity: getdocumentApprovalValue[ij].considerQuantity,
                partialRetirement:
                    getdocumentApprovalValue[ij].partialRetirement,
                retirementQuantity:
                    getdocumentApprovalValue[ij].retirementQuantity,
                retirementApc: getdocumentApprovalValue[ij].retirementApc,
                thirdParty: getdocumentApprovalValue[ij].thirdParty,
                poNum: getdocumentApprovalValue[ij].poNum,
                poItmNum: getdocumentApprovalValue[ij].poItmNum,
                expenseType: getdocumentApprovalValue[ij].expenseType,
                receiptNumber: getdocumentApprovalValue[ij].receiptNumber,
                expenseOperationType:
                    getdocumentApprovalValue[ij].expenseOperationType,
                federalTaxId:
                    getdocumentApprovalValue[ij].federalTaxId == null ||
                            getdocumentApprovalValue[ij].federalTaxId == "null"
                        ? null
                        : approvalDetailsValue!.federalTaxId,
                //  getdocumentApprovalValue[ij].federalTaxId,
                grossProfit: getdocumentApprovalValue[ij].grossProfit,
                grossProfitFc: getdocumentApprovalValue[ij].grossProfitFc,
                grossProfitSc: getdocumentApprovalValue[ij].grossProfitSc,
                priceSource: getdocumentApprovalValue[ij].priceSource,
                stgSeqNum: getdocumentApprovalValue[ij].stgSeqNum,
                stgEntry: getdocumentApprovalValue[ij].stgEntry,
                stgDesc: getdocumentApprovalValue[ij].stgDesc,
                uoMEntry: getdocumentApprovalValue[ij].uoMEntry,
                uoMCode: getdocumentApprovalValue[ij].uoMCode,
                inventoryQuantity:
                    getdocumentApprovalValue[ij].inventoryQuantity,
                remainingOpenInventoryQuantity:
                    getdocumentApprovalValue[ij].remainingOpenInventoryQuantity,
                parentLineNum:
                    getdocumentApprovalValue[ij].parentLineNum == null ||
                            getdocumentApprovalValue[ij].parentLineNum == "null"
                        ? null
                        : getdocumentApprovalValue[ij].parentLineNum,
                incoterms: getdocumentApprovalValue[ij].incoterms,
                transportMode: getdocumentApprovalValue[ij].transportMode,
                natureOfTransaction:
                    getdocumentApprovalValue[ij].natureOfTransaction,
                destinationCountryForImport:
                    getdocumentApprovalValue[ij].destinationCountryForImport,
                destinationRegionForImport:
                    getdocumentApprovalValue[ij].destinationRegionForImport,
                originCountryForExport:
                    getdocumentApprovalValue[ij].originCountryForExport,
                originRegionForExport:
                    getdocumentApprovalValue[ij].originRegionForExport,
                itemType: 'dit_Item',
                changeInventoryQuantityIndependently:
                    getdocumentApprovalValue[ij]
                        .changeInventoryQuantityIndependently,
                freeOfChargeBp: getdocumentApprovalValue[ij].freeOfChargeBp,
                sacEntry: getdocumentApprovalValue[ij].sacEntry,
                hsnEntry: getdocumentApprovalValue[ij].hsnEntry,
                grossPrice: getdocumentApprovalValue[ij].grossPrice,
                grossTotal: getdocumentApprovalValue[ij].grossTotal,
                grossTotalFc: getdocumentApprovalValue[ij].grossTotalFc,
                grossTotalSc: getdocumentApprovalValue[ij].grossTotalSc,
                ncmCode: getdocumentApprovalValue[ij].ncmCode,
                nveCode: getdocumentApprovalValue[ij].nveCode,
                indEscala: "tNO",
                ctrSealQty: getdocumentApprovalValue[ij].ctrSealQty,
                cnjpMan: getdocumentApprovalValue[ij].cnjpMan,
                cestCode: getdocumentApprovalValue[ij].cestCode,
                ufFiscalBenefitCode:
                    getdocumentApprovalValue[ij].ufFiscalBenefitCode,
                shipToCode: getdocumentApprovalValue[ij].shipToCode == null ||
                        getdocumentApprovalValue[ij].shipToCode == "null"
                    ? null
                    : getdocumentApprovalValue[ij].shipToCode,
                shipToDescription:
                    getdocumentApprovalValue[ij].shipToDescription,
                externalCalcTaxRate:
                    getdocumentApprovalValue[ij].externalCalcTaxRate,
                externalCalcTaxAmount:
                    getdocumentApprovalValue[ij].externalCalcTaxAmount,
                externalCalcTaxAmountFc:
                    getdocumentApprovalValue[ij].externalCalcTaxAmountFc,
                externalCalcTaxAmountSc:
                    getdocumentApprovalValue[ij].externalCalcTaxAmountSc,
                standardItemIdentification:
                    getdocumentApprovalValue[ij].standardItemIdentification,
                commodityClassification:
                    getdocumentApprovalValue[ij].commodityClassification,
                unencumberedReason:
                    getdocumentApprovalValue[ij].unencumberedReason,
                cuSplit: "tNO",
                uQtyOrdered: getdocumentApprovalValue[ij].uQtyOrdered,
                uOpenQty: getdocumentApprovalValue[ij].uOpenQty,
                uTonnage: getdocumentApprovalValue[ij].uTonnage,
                uPackSize: getdocumentApprovalValue[ij].U_Pack_Size,
                uProfitCentre: getdocumentApprovalValue[ij].uProfitCentre,
                uNumberDrums: getdocumentApprovalValue[ij].uNumberDrums,
                uDrumSize: getdocumentApprovalValue[ij].uDrumSize,
                uPails: getdocumentApprovalValue[ij].uPails,
                uCartons: getdocumentApprovalValue[ij].uCartons,
                uLooseTins: getdocumentApprovalValue[ij].uLooseTins,
                uNettWt: getdocumentApprovalValue[ij].uNettWt,
                uGrossWt: getdocumentApprovalValue[ij].uGrossWt,
                uAppLinId: getdocumentApprovalValue[ij].uAppLinId,
                uMuQty: getdocumentApprovalValue[ij].uMuQty,
                uRvc: getdocumentApprovalValue[ij].uRvc,
                uVrn: getdocumentApprovalValue[ij].uVrn,
                uIdentifier: getdocumentApprovalValue[ij].uIdentifier,
              ),
            );
          }
        }
      }
    }
    notifyListeners();
    log("itemsDetailsData::${itemsDetailsData.length}");
  }
  //  approvalDetailsValue!.documentLines!

  List<AddItem2> contentdocitemsDetails = [];
  // List<AddQuotEditItem> edititemsDetails = [];
  // Future<int?> patchhcheckitem() async {
  //   // edititemsDetails = [];
  //   contentdocitemsDetails = [];
  //   log("getdocitemsDetailsData::::${getdocitemsDetailsData.length}");
  //   // for (int i = 0; i < getdocitemsDetailsData.length; i++) {
  //   // addEditList();
  //   return null;
  //   // }
  // }

  // addEditList() {
  //   log('scanneditemData::${scanneditemData.length}');
  //   for (int im = 0; im < scanneditemData.length; im++) {
  //     if (userTypes == 'corporate') {
  //       for (int i = 0; i < scanneditemData.length; i++) {
  //         scanneditemData[i].sellPrice =
  //             double.parse(pricemycontroller[i].text.toString());
  //       }
  //       notifyListeners();
  //     }
  //     log("IMIMIM:::${scanneditemData[im].itemCode}");
  //     edititemsDetails.add(
  //       AddQuotEditItem(
  //         lineNo: scanneditemData[im].transID,
  //         itemCode: scanneditemData[im].itemCode ?? '',
  //         itemName: scanneditemData[im].itemName ?? '',
  //         price: scanneditemData[im].sellPrice ?? 0,
  //         discount: scanneditemData[im].discount ?? 0,
  //         qty: double.parse(qtymycontroller[im].text.toString()),
  //         valuechoosed: scanneditemData[im].taxCode.toString(),
  //         discounpercent: scanneditemData[im].discountper,
  //         taxCode: scanneditemData[im].taxCode.toString(),
  //         warehouse: AppConstant.branch.toString(),
  //         taxPer: scanneditemData[im].taxRate ?? 0,
  //       ),
  //     );
  //   }

  //   log("edititemsDetails length:::${edititemsDetails.length}");
  // }

  Future<void> validateAndCallApi(
    BuildContext context,
    ThemeData theme,
  ) async {
    onDisablebutton = true;

    await sapLoginApi(context);
    await addDocLineUpdate();
    await delputHeaderValues();
    await putcheckitem();
    // await patchhcheckitem();

    SalesQuotPutAPi.quotputaval = quotputdataval;
    SalesQuotPutAPi.cardCodePost = selectedcust!.cardCode;
    SalesQuotPutAPi.docLineQout = itemsDetailsData;
    SalesQuotPutAPi.uReqdocLineQout = itemsDocDetails;

    SalesQuotPutAPi.docDate = selectedcust!.invoiceDate;
    SalesQuotPutAPi.dueDate = config.currentDate().toString();
    SalesQuotPutAPi.remarks = mycontroller[50].text;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    // SalesQuotPutAPi.method(uuidg);
    log('scanneditemCheckUpdateData::${scanneditemCheckUpdateData.length}::${scanneditemData.length}');
    if (scanneditemCheckUpdateData.length != scanneditemData.length) {
      await SalesQuotPutAPi.getGlobalData(uuidg, int.parse(sapDocentry))
          .then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          await callPatchApi(context, theme, int.parse(sapDocentry));
        }

        if (value.statusCode! >= 400 && value.statusCode! <= 410) {
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
                        content: value.error!.message!.value.toString(),
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            onDisablebutton = false;
            notifyListeners();
          });
        }
      });
    } else if (scanneditemCheckUpdateData.length == scanneditemData.length) {
      await callPatchApi(context, theme, int.parse(sapDocentry));
    }
  }

  // List<DocumentApprovalValue>? documentLines = [];

  bool loadSearch = false;

  getQuotDetails(
    String sapDocEntry,
    BuildContext context,
  ) async {
    sapDocentry = '';
    loadSearch = true;
    await SalesDetailsQtAPi.getGlobalData(sapDocEntry).then((value) {
      getdocumentApprovalValue = [];
      approvalDetailsValue = null;

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        print("cardName: " + value.cardName.toString());
        sapDocentry = value.docEntry.toString();
        approvalDetailsValue = value;
        getdocumentApprovalValue = value.documentLines!;
        loadSearch = false;
      } else if (value.error != null) {
        final snackBar = SnackBar(
          duration: const Duration(seconds: 5),
          backgroundColor: Colors.red,
          content: Text(
            '${value.error}!!..',
            style: const TextStyle(color: Colors.white),
          ),
        );
        loadSearch = false;

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  List<OnHandModelsData> onhandData = [];
  callOnHandApi(String itemCode, int index) async {
    onhandData = [];
    notifyListeners();

    OnhandApi.getGlobalData('$itemCode', '${AppConstant.branch}').then((value) {
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

  getQuotApi(String sapDocEntry, String docstatus, BuildContext context,
      ThemeData theme) async {
    await SerlaySalesQuoAPI.getData(sapDocEntry).then((value) async {
      scanneditemData2 = [];
      editqty = false;
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        mycontroller2[50].text = value.comments.toString();
        remarkcontroller3.text = value.comments.toString();
        tinNoController.text = value.uTinNo.toString();
        vatNoController.text = value.uVatNumber.toString();
        postingDatecontroller.text =
            config.alignDateT(value.docDueDate.toString());
        if (value.documentLines!.isNotEmpty) {
          log('value.documentLines length::${value.documentLines!.length}');
          for (var i = 0; i < value.documentLines!.length; i++) {
            scanneditemData2.add(StocksnapModelData(
                branch: AppConstant.branch,
                itemCode: value.documentLines![i].itemCode,
                transID: value.documentLines![i].lineNum,
                baselineid: value.documentLines![i].lineNum.toString(),
                itemName: value.documentLines![i].itemDescription,
                openRetQty: value.documentLines![i].quantity,
                lineStatus: value.documentLines![i].lineStatus,
                taxCode: value.documentLines![i].taxCode,
                discountper: value.documentLines![i].discountPercent,
                priceAftDiscVal: value.documentLines![i].priceAfterVat,
                uPackSize: value.documentLines![i].uPackSize,
                serialBatch: '',
                mrp: 0,
                sellPrice: value.documentLines![i].unitPrice));
          }
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
              // if (getDBSalesQuoHeader[0]['shipaddresid'].toString().isNotEmpty) {
              //   if (csadresdataDB[k].autoid.toString() ==
              //       getDBSalesQuoHeader[0]['shipaddresid'].toString()) {
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
            taxCode: getcustomer[0]['TaxCode'].toString(),
            cardCode: getcustomer[0]['customerCode'].toString(),
            point: getcustomer[0]['points'].toString(),
            custRefNum: '',
            accBalance: 0,
            tinno: value.uTinNo,
            vatregno: value.uVatNumber,
            address: address2,
            docStatus: docstatus,
            invoiceDate: value.docDate,
            invoicenum: value.docNum.toString(),
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
            tinno: value.uTinNo,
            vatregno: value.uVatNumber,
            invoiceDate: value.docDate,
            invoicenum: value.docNum.toString(),
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
          selectedcust2!.accBalance = updateCustBal ??
              double.parse(getcustomer[0]['balance'].toString());
          selectedcust25!.accBalance = updateCustBal ??
              double.parse(getcustomer[0]['balance'].toString());
          await CustCreditLimitAPi.getGlobalData(value.cardCode.toString())
              .then((value) {
            if (value.statuscode >= 200 && value.statuscode <= 210) {
              if (value.creditLimitData != null) {
                // log('xxxxxxxx::${value.creditLimitData![0].creditLine.toString()}');

                selectedcust2!.creditLimits = double.parse(
                    value.creditLimitData![0].creditLine.toString());
                selectedcust25!.creditLimits = double.parse(
                    value.creditLimitData![0].creditLine.toString());
                notifyListeners();
              }
            }
          });

          await CustCreditDaysAPI.getGlobalData(value.cardCode.toString())
              .then((value2) {
            if (value2.statuscode >= 200 && value2.statuscode <= 210) {
              if (value2.creditDaysData != null) {
                // log('yyyyyyyyyy::${value.creditDaysData![0].creditDays.toString()}');

                selectedcust2!.creditDays =
                    value2.creditDaysData![0].creditDays.toString();
                selectedcust2!.paymentGroup = value2
                    .creditDaysData![0].paymentGroup
                    .toString()
                    .toLowerCase();
                selectedcust25!.creditDays =
                    value2.creditDaysData![0].creditDays.toString();
                selectedcust25!.paymentGroup = value2
                    .creditDaysData![0].paymentGroup
                    .toString()
                    .toLowerCase();
                log('selectedcust paymentGroup::${selectedcust2!.paymentGroup!}');
                if (selectedcust2!.paymentGroup!.contains('cash') == true) {
                  custNameController.text = value.cardName!;
                  tinNoController.text = value.uTinNo!;
                  vatNoController.text = value.uVatNumber!;
                } else {
                  selectedcust2!.name = value.cardName!;
                }
                log('Cash paymentGroup::${selectedcust2!.paymentGroup!.contains('cash')}');
                notifyListeners();
              }
              loadingscrn = false;
            }
          });
          // }
          // }
          // if (scanneditemData2.isNotEmpty) {
          //   for (var i = 0; i < scanneditemData.length; i++) {
          //     scanneditemData2[i].taxRate = 0.0;
          //     if (selectedcust2!.taxCode == 'O1') {
          //       scanneditemData2[i].taxRate = 18;
          //     } else {
          //       scanneditemData2[i].taxRate = 0.0;
          //     }
          //     notifyListeners();
          //   }
          //   calCulateDocVal2(context, theme);

          for (var i = 0; i < scanneditemData2.length; i++) {
            qtymycontroller2[i].text =
                scanneditemData2[i].openRetQty.toString();

            if (selectedcust2!.taxCode == 'O1') {
              scanneditemData2[i].taxRate = 18;
            } else {
              scanneditemData2[i].taxRate = 0;
            }
          }
          calCulateDocVal2(context, theme);
          notifyListeners();
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesquoDateWise(
            db,
            config.alignDate2(fromdate.trim()),
            config.alignDate2(todate.trim()));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          type: "Sales Quotation",
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
          doctotal: getSalesHeader[i]["doctotal"] == null
              ? 0
              : double.parse(getSalesHeader[i]["doctotal"].toString())));
    }
    searchData.addAll(searchdata2);
    // filtersearchData = searchData;

    searchbool = false;
    notifyListeners();
  }

  fixDataMethod(int docentry, BuildContext context, ThemeData theme) async {
    editqty = false;
    searchmapbool = false;
    mycontroller2[50].text = "";
    shipaddress = "";
    sapDocentry = '';
    sapDocuNumber = '';
    cancelDocnum = '';
    cancelDocEntry = null;
    paymentWay2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2 = [];
    totalPayment2 = null;
    selectedcust2 = null;
    salesmodl = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry);

    double? totalQuantity = 0;
    sapDocentry = getDBSalesQuoHeader[0]['sapDocentry'] != null
        ? getDBSalesQuoHeader[0]['sapDocentry'].toString()
        : "";
    cancelDocnum = getDBSalesQuoHeader[0]['documentno'] != null
        ? getDBSalesQuoHeader[0]['documentno'].toString()
        : "";
    cancelDocEntry = int.parse(getDBSalesquotLine[0]['docentry'].toString());
    sapDocuNumber = getDBSalesQuoHeader[0]['sapDocNo'] != null
        ? getDBSalesQuoHeader[0]['sapDocNo'].toString()
        : "";

    mycontroller2[50].text = getDBSalesQuoHeader[0]['remarks'] != null
        ? getDBSalesQuoHeader[0]['remarks'].toString()
        : "";
    totwieght = double.parse(getDBSalesQuoHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesQuoHeader[0]['totalltr'].toString());

    for (int ik = 0; ik < getDBSalesquotLine.length; ik++) {
      scanneditemData2.add(StocksnapModelData(
          basic: getDBSalesquotLine[ik]['basic'] != null
              ? double.parse(getDBSalesquotLine[ik]['basic'].toString())
              : 00,
          netvalue: getDBSalesquotLine[ik]['netlinetotal'] != null
              ? double.parse(getDBSalesquotLine[ik]['netlinetotal'].toString())
              : null,
          transID: int.parse(getDBSalesquotLine[ik]['docentry'].toString()),
          branch: getDBSalesquotLine[ik]['branch'].toString(),
          itemCode: getDBSalesquotLine[ik]['itemcode'].toString(),
          itemName: getDBSalesquotLine[ik]['itemname'].toString(),
          serialBatch: getDBSalesquotLine[ik]['serialbatch'].toString(),
          openQty: double.parse(getDBSalesquotLine[ik]['quantity'].toString()),
          qty: double.parse(getDBSalesquotLine[ik]['quantity'].toString()),
          inDate: getDBSalesquotLine[ik][''].toString(),
          inType: getDBSalesquotLine[ik][''].toString(),
          mrp: 0,
          sellPrice: double.parse(getDBSalesquotLine[ik]['price'].toString()),
          cost: 0,
          discount: getDBSalesquotLine[ik]['discperunit'] != null
              ? double.parse(getDBSalesquotLine[ik]['discperunit'].toString())
              : 00,
          taxvalue: getDBSalesquotLine[ik]['taxtotal'] != null
              ? double.parse(getDBSalesquotLine[ik]['taxtotal'].toString())
              : 00,
          taxRate: double.parse(getDBSalesquotLine[ik]['taxrate'].toString()),
          maxdiscount: getDBSalesquotLine[ik]['maxdiscount'].toString(),
          discountper: getDBSalesquotLine[ik]['discperc'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['discperc'].toString()),
          createdUserID: '',
          createdateTime: '',
          lastupdateIp: '',
          purchasedate: '',
          snapdatetime: '',
          specialprice: 0,
          updatedDatetime: '',
          updateduserid: '',
          liter: getDBSalesquotLine[ik]['liter'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['liter'].toString()),
          weight: getDBSalesquotLine[ik]['weight'] == null
              ? 0.0
              : double.parse(getDBSalesquotLine[ik]['weight'].toString())));

      totquantity = getDBSalesquotLine[ik]['quantity'].toString();
      qtymycontroller2[ik].text = getDBSalesquotLine[ik]['quantity'] == null
          ? "0"
          : getDBSalesquotLine[ik]['quantity'].toString();
      mycontroller2[ik].text = getDBSalesquotLine[ik]['discperc'] == null
          ? "0"
          : getDBSalesquotLine[ik]['discperc'].toString();
      discountamt = getDBSalesquotLine[ik]['discperc'] != null
          ? double.parse(getDBSalesquotLine[ik]['discperc'].toString())
          : 0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData2.length; i++) {
      scanneditemData2[i].qty =
          double.parse(qtymycontroller2[i].text.toString());
      discountcontroller2[i].text = scanneditemData2[i].discountper.toString();
      scanneditemData2[i].transID = i;

      totalQuantity =
          totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

      notifyListeners();
    }
    notifyListeners();

    totalPayment2 = TotalPayment(
      discount2: getDBSalesQuoHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
      discount: getDBSalesQuoHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
      totalTX: double.parse(getDBSalesQuoHeader[0]['taxamount'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['taxamount'].toString().replaceAll(',', '')),

      subtotal: double.parse(getDBSalesQuoHeader[0]['docbasic'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['docbasic']
              .toString()
              .replaceAll(',', '')), //doctotal

      total: totalQuantity,
      totalDue: double.parse(getDBSalesQuoHeader[0]['doctotal'] == null
          ? '0'
          : getDBSalesQuoHeader[0]['doctotal'].toString().replaceAll(',', '')),
    );
    shipaddress = getDBSalesQuoHeader[0]['shipaddresid'].toString();

    calCulateDocVal2(context, theme);

    List<Address>? address2 = [];
    List<Address>? address25 = [];
    List<CustomerAddressModelDB> csadresdataDB =
        await DBOperation.getCstmMasAddDB(
      db,
    );
    for (int k = 0; k < csadresdataDB.length; k++) {
      if (csadresdataDB[k].custcode.toString() ==
          getDBSalesQuoHeader[0]['customercode'].toString()) {
        if (csadresdataDB[k].autoid.toString() ==
            getDBSalesQuoHeader[0]['billaddressid'].toString()) {
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
        if (getDBSalesQuoHeader[0]['shipaddresid'].toString().isNotEmpty) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesQuoHeader[0]['shipaddresid'].toString()) {
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
    SalesModel salesM = SalesModel(
      ordReference: getDBSalesQuoHeader[0]['remarks'].toString(),
      taxCode: getDBSalesQuoHeader[0]['taxCode'].toString(),
      objname: getDBSalesQuoHeader[0]['objname'].toString(),
      objtype: getDBSalesQuoHeader[0]['objtype'].toString(),
      doctype: getDBSalesQuoHeader[0]['doctype'].toString(),
      docentry: int.parse(getDBSalesQuoHeader[0]['docentry'].toString()),
      custName: getDBSalesQuoHeader[0]['customername'].toString(),
      phNo: getDBSalesQuoHeader[0]['customerphono'].toString(),
      cardCode: getDBSalesQuoHeader[0]['customercode'].toString(),
      accBalance: getDBSalesQuoHeader[0]['customeraccbal'].toString(),
      point: getDBSalesQuoHeader[0]['customerpoint'].toString(),
      tarNo: getDBSalesQuoHeader[0]['taxno'].toString(),
      email: getDBSalesQuoHeader[0]['customeremail'].toString(),
      invoceDate: getDBSalesQuoHeader[0]['createdateTime'].toString(),
      invoiceNum: getDBSalesQuoHeader[0]['documentno'].toString(),
      sapInvoiceNum: getDBSalesQuoHeader[0]['sapDocNo'].toString(),
      item: scanneditemData2,
    );

    notifyListeners();

    salesmodl.add(salesM);
    log(salesmodl.length.toString());
    selectedcust2 = CustomerDetals(
      name: getDBSalesQuoHeader[0]["customername"].toString(),
      phNo: getDBSalesQuoHeader[0]["customerphono"].toString(),
      docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
      taxCode: getDBSalesQuoHeader[0]["taxCode"].toString(),

      cardCode: getDBSalesQuoHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance:
          double.parse(getDBSalesQuoHeader[0]["customeraccbal"].toString()),
      point: getDBSalesQuoHeader[0]["customerpoint"].toString(),
      address: address2,
      tarNo: getDBSalesQuoHeader[0]["taxno"].toString(),
      email: getDBSalesQuoHeader[0]["customeremail"].toString(),
      invoicenum: getDBSalesQuoHeader[0]['documentno'] != null
          ? getDBSalesQuoHeader[0]['documentno'].toString()
          : "",
      invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
          ? 0.0
          : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
    );
    selectedcust25 = CustomerDetals(
      name: getDBSalesQuoHeader[0]["customername"]
          .toString(), // customername!.name
      phNo: getDBSalesQuoHeader[0]["customerphono"].toString(),
      docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
      taxCode: getDBSalesQuoHeader[0]["taxCode"].toString(),

      cardCode: getDBSalesQuoHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesQuoHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
      address: address25,
      tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesQuoHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
          ? 0.0
          : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
    );
    notifyListeners();
    log("selectedcust25!.address!length::${selectedcust25!.address!.length}");

    notifyListeners();
    selectedBillAdress = selectedcust2!.address!.length - 1;
    selectedShipAdress = selectedcust25!.address!.length - 1;
    notifyListeners();
    searchmapbool = false;
  }

  newUpdateFixDataMethod(BuildContext context, ThemeData theme) async {
    scanneditemData = scanneditemData2;
    log('scanneditemCheckUpdateDataxxx::${scanneditemCheckUpdateData.length}');
    selectedcust = selectedcust2;
    selectedcust2 = selectedcust25;
    await callGetUserType();

    for (var i = 0; i < scanneditemData.length; i++) {
      await getAllListItem(scanneditemData[i].itemCode.toString());

      for (var ik = 0; ik < getfilterSearchedData.length; ik++) {
        if (getfilterSearchedData[ik].itemcode.toString() ==
            scanneditemData[i].itemCode.toString()) {
          scanneditemData[i].uPackSize =
              getfilterSearchedData[ik].uPackSize.isNotEmpty
                  ? double.parse(getfilterSearchedData[ik].uPackSize)
                  : null;
        }
      }
      pricemycontroller[i].text = scanneditemData[i].sellPrice.toString();
      discountcontroller[i].text = scanneditemData[i].discountper.toString();
      qtymycontroller[i].text = scanneditemData[i].qty.toString();
      itemNameController[i].text = scanneditemData[i].itemName.toString();
      scanneditemData[i].transID = i;
    }

    selectedcust2 = selectedcust25;

    calCulateDocVal(context, theme);
    scanneditemData2 = [];
    selectedcust2 = null;
    selectedcust25 = null;
    searchmapbool = false;
    postqtyreadonly();
    notifyListeners();
  }

  updateFixDataMethod(BuildContext context, ThemeData theme) async {
    mycontroller2[50].text = "";
    paymentWay2.clear();
    totwieght = 0.0;
    totLiter = 0.0;
    scanneditemData2 = [];
    scanneditemData = [];
    totalPayment2 = null;
    totalPayment = null;
    selectedcust2 = null;
    selectedcust = null;
    editqty = false;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, cancelDocEntry!);

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, cancelDocEntry!);

    double? totalQuantity = 0;
    cancelDocEntry = int.parse(getDBSalesquotLine[0]['docentry'].toString());
    mycontroller2[50].text = getDBSalesQuoHeader[0]['remarks'] != null
        ? getDBSalesQuoHeader[0]['remarks'].toString()
        : "";
    totwieght = double.parse(getDBSalesQuoHeader[0]['totalweight'].toString());
    totLiter = double.parse(getDBSalesQuoHeader[0]['totalltr'].toString());
    if ((getDBSalesQuoHeader[0]['sapDocNo'].toString() != null ||
            getDBSalesQuoHeader[0]['sapDocNo'].toString().isNotEmpty) &&
        getDBSalesQuoHeader[0]['qStatus'].toString() == 'C') {
      postqtyreadonly();
      for (int ik = 0; ik < getDBSalesquotLine.length; ik++) {
        scanneditemData.add(StocksnapModelData(
            basic: getDBSalesquotLine[ik]['basic'] != null
                ? double.parse(getDBSalesquotLine[ik]['basic'].toString())
                : 00,
            netvalue: getDBSalesquotLine[ik]['netlinetotal'] != null
                ? double.parse(
                    getDBSalesquotLine[ik]['netlinetotal'].toString())
                : null,
            docentry: getDBSalesquotLine[ik]['docentry'].toString(),
            branch: getDBSalesquotLine[ik]['branch'].toString(),
            itemCode: getDBSalesquotLine[ik]['itemcode'].toString(),
            itemName: getDBSalesquotLine[ik]['itemname'].toString(),
            serialBatch: getDBSalesquotLine[ik]['serialbatch'].toString(),
            openQty:
                double.parse(getDBSalesquotLine[ik]['quantity'].toString()),
            qty: double.parse(getDBSalesquotLine[ik]['quantity'].toString()),
            inDate: getDBSalesquotLine[ik][''].toString(),
            inType: getDBSalesquotLine[ik][''].toString(),
            mrp: 0,
            sellPrice: double.parse(getDBSalesquotLine[ik]['price'].toString()),
            cost: 0,
            discount: getDBSalesquotLine[ik]['discperunit'] != null
                ? double.parse(getDBSalesquotLine[ik]['discperunit'].toString())
                : 00,
            taxvalue: getDBSalesquotLine[ik]['taxtotal'] != null
                ? double.parse(getDBSalesquotLine[ik]['taxtotal'].toString())
                : 00,
            taxRate: double.parse(getDBSalesquotLine[ik]['taxrate'].toString()),
            maxdiscount: getDBSalesquotLine[ik]['maxdiscount'].toString(),
            discountper: getDBSalesquotLine[ik]['discperc'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['discperc'].toString()),
            createdUserID: '',
            createdateTime: '',
            lastupdateIp: '',
            purchasedate: '',
            snapdatetime: '',
            specialprice: 0,
            updatedDatetime: '',
            updateduserid: '',
            liter: getDBSalesquotLine[ik]['liter'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['liter'].toString()),
            weight: getDBSalesquotLine[ik]['weight'] == null
                ? 0.0
                : double.parse(getDBSalesquotLine[ik]['weight'].toString())));

        //discperc
        totquantity = getDBSalesquotLine[ik]['quantity'].toString();
        qtymycontroller[ik].text = getDBSalesquotLine[ik]['quantity'] == null
            ? "0"
            : getDBSalesquotLine[ik]['quantity'].toString();
        discountcontroller[ik].text = getDBSalesquotLine[ik]['discperc'] == null
            ? "0"
            : getDBSalesquotLine[ik]['discperc'].toString();
        discountamt = getDBSalesquotLine[ik]['discperc'] != null
            ? double.parse(getDBSalesquotLine[ik]['discperc'].toString())
            : 0;
        notifyListeners();
      }
      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].qty =
            double.parse(qtymycontroller[i].text.toString());
        discountcontroller[i].text = scanneditemData[i].discountper.toString();
        scanneditemData[i].transID = i;
        itemNameController[i].text = scanneditemData[i].itemName.toString();

        totalQuantity =
            totalQuantity! + int.parse(qtymycontroller[i].text.toString());

        notifyListeners();
      }
      notifyListeners();

      totalPayment = TotalPayment(
        discount2: getDBSalesQuoHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
        discount: getDBSalesQuoHeader[0]['docdiscamt'] == null
            ? 0.00
            : double.parse(getDBSalesQuoHeader[0]['docdiscamt'].toString()),
        totalTX: double.parse(getDBSalesQuoHeader[0]['taxamount'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['taxamount']
                .toString()
                .replaceAll(',', '')),

        subtotal: double.parse(getDBSalesQuoHeader[0]['docbasic'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['docbasic']
                .toString()
                .replaceAll(',', '')), //doctotal

        total: totalQuantity,
        totalDue: double.parse(getDBSalesQuoHeader[0]['doctotal'] == null
            ? '0'
            : getDBSalesQuoHeader[0]['doctotal']
                .toString()
                .replaceAll(',', '')),
      );
      shipaddress = getDBSalesQuoHeader[0]['shipaddresid'].toString();

      List<Address>? address2 = [];
      List<Address>? address25 = [];
      List<CustomerAddressModelDB> csadresdataDB =
          await DBOperation.getCstmMasAddDB(
        db,
      );
      addCardCode = getDBSalesQuoHeader[0]['customercode'].toString();
      for (int k = 0; k < csadresdataDB.length; k++) {
        if (csadresdataDB[k].custcode.toString() ==
            getDBSalesQuoHeader[0]['customercode'].toString()) {
          if (csadresdataDB[k].autoid.toString() ==
              getDBSalesQuoHeader[0]['billaddressid'].toString()) {
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
          if (getDBSalesQuoHeader[0]['shipaddresid'].toString().isNotEmpty) {
            if (csadresdataDB[k].autoid.toString() ==
                getDBSalesQuoHeader[0]['shipaddresid'].toString()) {
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
      selectedcust = CustomerDetals(
        autoId: getDBSalesQuoHeader[0]["billaddressid"].toString(),
        taxCode: getDBSalesQuoHeader[0]["taxCode"].toString(),

        name: getDBSalesQuoHeader[0]["customername"]
            .toString(), // customername!.name
        phNo:
            getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
        cardCode: getDBSalesQuoHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(getDBSalesQuoHeader[0]["customeraccbal"]
            .toString()), //customeraccbal
        point:
            getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
        address: address2,
        tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
        email:
            getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesQuoHeader[0]['documentno'] != null
            ? getDBSalesQuoHeader[0]['documentno'].toString()
            : "",
        invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
            ? 0.0
            : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
      );
      selectedcust55 = CustomerDetals(
        autoId: getDBSalesQuoHeader[0]["shipaddresid"].toString(),
        taxCode: getDBSalesQuoHeader[0]["taxCode"].toString(),

        name: getDBSalesQuoHeader[0]["customername"]
            .toString(), // customername!.name
        phNo:
            getDBSalesQuoHeader[0]["customerphono"].toString(), //customerphono
        docentry: getDBSalesQuoHeader[0]["docentry"].toString(),
        cardCode: getDBSalesQuoHeader[0]["customercode"]
            .toString(), //customercode!.cardCode
        accBalance: double.parse(getDBSalesQuoHeader[0]["customeraccbal"]
            .toString()), //customeraccbal
        point:
            getDBSalesQuoHeader[0]["customerpoint"].toString(), //customerpoint
        address: address25,
        tarNo: getDBSalesQuoHeader[0]["taxno"].toString(), //taxno
        email:
            getDBSalesQuoHeader[0]["customeremail"].toString(), //customeremail
        invoicenum: getDBSalesQuoHeader[0]["documentno"].toString(),
        invoiceDate: getDBSalesQuoHeader[0]["createdateTime"].toString(),
        totalPayment: getDBSalesQuoHeader[0]["doctotal"] == null
            ? 0.0
            : double.parse(getDBSalesQuoHeader[0]["doctotal"].toString()),
      );
      notifyListeners();
      //log("selectedcust25!.address!length::" +
      // selectedcust25!.address!.length.toString());
      // int? totqty;

      notifyListeners();
      selectedBillAdress = selectedcust!.address!.length - 1;
      selectedShipAdress = selectedcust55!.address!.length - 1;
      notifyListeners();
      searchmapbool = false;
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        // onDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesQuoHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesQuoHeaderToDB(docstatus, context, theme);
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

  insertSalesQuoHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesQuotationHeaderModelDB> salesQuoHeaderValues1 = [];
    List<SalesQuotationLineTDB> salesQuoLineValues = [];
    int? counofData = await DBOperation.getcountofTable(
        db, "docentry", "SalesQuotationHeader");
    int? docEntryCreated = 0;
    tabledocentry = null;
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
          db, "docentry", "SalesQuotationHeader");
    }
    await DBOperation.geteriesvlue(db);
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 10);

    List<String> getseriesvalue = await checkingdoc(10);

    int docseries = int.parse(getseriesvalue[1]);
    int nextno = documentN0!;
    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    documentNum = finlDocnum + documentN0.toString();
    salesQuoHeaderValues1.add(SalesQuotationHeaderModelDB(
      doctype: 'Sales Quotation',
      docentry: docEntryCreated.toString(),
      objname: '',
      objtype: '',
      amtpaid: '',
      baltopay: '',
      tinNo: tinNoController.text,
      vatno: vatNoController.text,
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      customercode: selectedcust!.cardCode == null
          ? ""
          : selectedcust!.cardCode.toString(),
      customerSeriesNum: '',
      customername: custNameController.text.isNotEmpty
          ? custNameController.text
          : selectedcust != null
              ? selectedcust!.name
              : "",
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
      docstatus:
          // docstatus == "suspend"
          //     ? "0"
          //     :
          docstatus == "hold"
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
      seresid: "",
      seriesnum: '',
      shipaddresid: selectedcust55 != null &&
              selectedcust55!.address!.isNotEmpty
          ? selectedcust55!.address![selectedShipAdress].autoId.toString()
          // ? '${selectedcust!.address![selectedShipAdress].address1.toString()},${selectedcust!.address![selectedShipAdress].address2.toString()},${selectedcust!.address![selectedShipAdress].address3}'
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
      sapDocNo: null,
      sapDocentry: null,
      qStatus: "No",
      totalltr: totalLiter(),
      totalweight: totalWeight(),
      editType: '',
    ));
    int? docentry2 =
        await DBOperation.insertSaleQuoheader(db, salesQuoHeaderValues1);
    tabledocentry = docentry2;
    await DBOperation.updatenextno(db, 10, nextno);
    for (int i = 0; i < scanneditemData.length; i++) {
      // double? mycontamount = mycontroller[i].text.toString().isNotEmpty
      //     ? double.parse(mycontroller[i].text.toString())
      //     : 00;
      salesQuoLineValues.add(SalesQuotationLineTDB(
        sapdocentry: '',
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        // totalPayment != null
        //     ? totalPayment!.discount.toString().replaceAll(',', '')
        //     : null,mycontroller[iss].text.toString()
        discperc: scanneditemData[i].discountper.toString(),
        discperunit: scanneditemData[i].discount.toString(),
        //     (scanneditemData[i].sellPrice! * mycontamount / 100).toString(),
        maxdiscount: scanneditemData[i].maxdiscount.toString(),
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].itemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        // totalPayment != null
        //     ? totalPayment!.totalDue.toString().replaceAll(',', '')
        //     : null,
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        serialbatch: scanneditemData[i].serialBatch,
        taxrate: scanneditemData[i].taxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        // totalPayment != null
        //     ? totalPayment!.totalTX!.toString().replaceAll(',', '')
        //     : null,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].itemName,
      ));

      notifyListeners();
// salesLineValues.add(salesLine);
    }

    if (salesQuoLineValues.isNotEmpty) {
      DBOperation.insertSalesQuoLine(db, salesQuoLineValues, docentry2!);
      notifyListeners();
    }

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "check out") {
        // pushRabiMqSO(docentry2!);
        await callQuotPostApi(
            context, theme, docentry2!, docstatus, documentNum);
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
        injectToDb();

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
        discountcontroller = List.generate(100, (i) => TextEditingController());
        mycontroller = List.generate(150, (i) => TextEditingController());
        qtymycontroller = List.generate(100, (i) => TextEditingController());
        remarkcontroller3.text = '';
        onDisablebutton = false;

        notifyListeners();
      });
    }

    notifyListeners();
  }

  addDocLine() {
    if (userTypes == 'corporate' || userTypes == 'retail') {
      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].sellPrice =
            double.parse(pricemycontroller[i].text.toString());
        scanneditemData[i].discountper =
            double.parse(discountcontroller[i].text.toString());
        scanneditemData[i].itemName = itemNameController[i].text;
      }
      notifyListeners();
    }

    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      itemsDocDetails.add(QuatationLines(
        currency: "TZS",
        discPrcnt: scanneditemData[i].discountper.toString(),
        itemCode: scanneditemData[i].itemCode,
        lineNo: scanneditemData[i].transID,
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        taxCode: selectedcust!.taxCode,
        unitPrice: scanneditemData[i].sellPrice!.toStringAsFixed(2),
        whsCode: AppConstant.branch,
        itemName: scanneditemData[i].itemName.toString(),
      ));
    }
    for (var ic = 0; ic < itemsDocDetails.length; ic++) {
      log('itemsDocDetails::${itemsDocDetails[ic].discPrcnt}');
    }
    notifyListeners();
  }

  addDocLineUpdate() {
    log('message scanneditemData::${scanneditemData.length}');
    if (userTypes == 'corporate' || userTypes == 'retail') {
      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].sellPrice =
            double.parse(pricemycontroller[i].text.toString());
        scanneditemData[i].discountper =
            double.parse(discountcontroller[i].text.toString());
        scanneditemData[i].itemName = itemNameController[i].text;
      }
      notifyListeners();
    }

    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      itemsDocDetails.add(QuatationLines(
        currency: "TZS",
        discPrcnt: scanneditemData[i].discountper.toString(),
        itemCode: scanneditemData[i].itemCode,
        // lineNo: scanneditemData[i].baselineid != null
        //     ? int.parse(scanneditemData[i].baselineid!)
        //     : scanneditemData[i].transID,
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        taxCode: selectedcust!.taxCode,
        unitPrice: scanneditemData[i].sellPrice!.toStringAsFixed(2),
        whsCode: AppConstant.branch,
        itemName: scanneditemData[i].itemName.toString(),
      ));
    }

    log('itemsDocDetails::${itemsDocDetails.length}');
    notifyListeners();
  }

  callQuotPostApi(BuildContext context, ThemeData theme, int docEntry,
      String docststus, String documentNum) async {
    await sapLoginApi(context);
    await postQuotation(context, theme, docEntry, docststus, documentNum);
    notifyListeners();
  }

  postQuotation(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    SalesQuotPostAPi.seriesType = seriesType;
    SalesQuotPostAPi.cardCodePost = selectedcust!.cardCode;
    SalesQuotPostAPi.cardNamePost = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;

    SalesQuotPostAPi.tinNo = tinNoController.text;
    SalesQuotPostAPi.vatNo = vatNoController.text;
    SalesQuotPostAPi.docLineQout = itemsDocDetails;
    SalesQuotPostAPi.docDate = config.currentDate();
    SalesQuotPostAPi.dueDate = config.alignDate2(postingDatecontroller.text);
    SalesQuotPostAPi.remarks = remarkcontroller3.text;
    var uuid = const Uuid();
    String? uuidg = uuid.v1();
    SalesQuotPostAPi.method(uuidg);
    await SalesQuotPostAPi.getGlobalData(uuidg).then((value) async {
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.docEntry != null) {
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry),
              int.parse(sapDocuNumber), docEntry, 'SalesQuotationHeader');
          await DBOperation.updateSapDocSalesQuoLine(
              db, sapDocentry, docEntry.toString());
          custserieserrormsg = '';
          onDisablebutton = true;
          loadingscrn = false;
          scanneditemData.clear();
          schemebtnclk = false;
          selectedcust = null;
          selectedcust55 = null;
          paymentWay.clear();
          newShipAddrsValue = [];
          itemsDocDetails = [];
          newBillAddrsValue = [];
          postingDatecontroller.text = '';
          custNameController.text = '';
          tinNoController.text = '';
          vatNoController.text = '';
          newCustValues = [];
          totalPayment = null;
          mycontroller[50].text = "";
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          notifyListeners();

          await Get.defaultDialog(
                  title: "Success",
                  middleText: docstatus == "check out"
                      ? 'Successfully Done, Document Number is $sapDocuNumber'
                      : docstatus == "save as order"
                          ? "Sales quotation successfully saved..!!, Document Number is $sapDocuNumber"
                          : docstatus == "hold"
                              ? "Saved as draft"
                              // : docstatus == "suspend"
                              //     ? "This Sales Transaction Suspended Sucessfully..!!"
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
            injectToDb();
            if (docstatus == "check out") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            onDisablebutton = false;

            notifyListeners();
          });
        } else {
          //log("Error11");

          custserieserrormsg = value.error!.message!.value.toString();
          onDisablebutton = true;
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
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          notifyListeners();

          await Get.defaultDialog(
                  title: "Alert",
                  middleText: custserieserrormsg =
                      value.error!.message!.value.toString(),
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
            injectToDb();
            if (docstatus == "check out") {
              Get.offAllNamed(ConstantRoutes.dashboard);
            }
            onDisablebutton = false;

            notifyListeners();
          });
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.error!.message!.value.toString();

        Get.defaultDialog(
                title: "Alert",
                middleText: custserieserrormsg!,
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
      } else {
        cancelbtn = false;
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
          onDisablebutton = false;
          notifyListeners();
        });
        // onDisablebutton = false;
      }
    });
    notifyListeners();
  }

  updateSalesQuoHeaderToDB(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesQuotationLineTDB> salesQuoLineValues = [];
    log("cancelDocEntry:::$cancelDocEntry");
    SalesQuotationHeaderModelDB salesQuoHeaderValues1 =
        SalesQuotationHeaderModelDB(
      doctype: 'Sales Quotation',
      docentry: cancelDocEntry.toString(),
      objname: '',
      objtype: '',
      amtpaid: '',
      baltopay: '',
      billaddressid: selectedcust == null && selectedcust!.address == null ||
              selectedcust!.address!.isEmpty
          ? ''
          : selectedcust!.address![selectedBillAdress].autoId.toString(),
      billtype: null,
      branch: UserValues.branch!,
      createdUserID: UserValues.userID.toString(),
      createdateTime: config.currentDate(),
      createdbyuser: UserValues.userType,
      tinNo: tinNoController.text,
      vatno: vatNoController.text,
      customercode: selectedcust!.cardCode == null
          ? ""
          : selectedcust!.cardCode.toString(),
      customerSeriesNum: '',
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
      documentno: cancelDocnum,
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
      shipaddresid: selectedcust55 != null &&
              selectedcust55!.address!.isNotEmpty
          ? selectedcust55!.address![selectedShipAdress].autoId.toString()
          // ? '${selectedcust!.address![selectedShipAdress].address1.toString()},${selectedcust!.address![selectedShipAdress].address2.toString()},${selectedcust!.address![selectedShipAdress].address3}'
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
      sapDocNo: int.parse(sapDocuNumber.toString()),
      sapDocentry: int.parse(sapDocentry.toString()),
      qStatus: 'C',
      totalltr: totalLiter(),
      totalweight: totalWeight(),
      editType: 'Edit',
    );
    await DBOperation.updateSaleQuoheader(db, salesQuoHeaderValues1,
        cancelDocEntry.toString(), cancelDocnum.toString());

    // List<Map<String, Object?>> getDBUpdateSalesOrdHeader =
    //     await DBOperation.getSaleQuorHeaderDB(
    //         db, int.parse(cancelDocEntry.toString()));

    log("cancelDocEntry222:::$cancelDocEntry");

    for (int i = 0; i < scanneditemData.length; i++) {
      // double? mycontamount = mycontroller[i].text.toString().isNotEmpty
      //     ? double.parse(mycontroller[i].text.toString())
      //     : 00;
      salesQuoLineValues.add(SalesQuotationLineTDB(
        sapdocentry: scanneditemData[i].sapbasedocentry.toString(),
        basic: scanneditemData[i].basic.toString(),
        branch: UserValues.branch,
        createdUser: UserValues.userType,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        discamt: scanneditemData[i].discount.toString(),
        discperc: scanneditemData[i].discountper != null
            ? scanneditemData[i].discountper!.toString()
            : '0',
        discperunit: scanneditemData[i].discount.toString(),
        maxdiscount: scanneditemData[i].maxdiscount.toString(),
        docentry: selectedcust!.docentry,
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
      ));
      notifyListeners();
    }
    log("cancelDocEntry333:::$cancelDocEntry");

    if (salesQuoLineValues.isNotEmpty) {
      for (int im = 0; im < salesQuoLineValues.length; im++) {
        await DBOperation.updateSalesQuoLine(
            db, salesQuoLineValues, im, cancelDocEntry.toString());
        notifyListeners();
      }
    }

    bool? netbool = await config.haveInterNet();
    log("cancelDocEntry444:::$cancelDocEntry");

    if (netbool == true) {}
  }

  pushRabiMqSO(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Add",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    log("payload11 : $ddd");
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    // properties.headers = {"Branch": UserValues.branch};
    // exchange.publish(ddd, "", properties: properties);

    //cs

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabiMqSO2(int? docentry) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    // String salesPAY = json.encode(getDBSalespay);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Add",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    // log("payload22 : $ddd");
    //RabitMQ
    // Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
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

    // properties.headers = {"Branch": "Server"};
    // exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabiMqSO3(int? docentry) async {
    //background service
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBSalesquotLine =
        await DBOperation.getSalesQuoLineDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesQuoHeader =
        await DBOperation.getSaleQuorHeaderDB(db, docentry);
    String salesQuotLine = json.encode(getDBSalesquotLine);
    String salesQuotHeader = json.encode(getDBSalesQuoHeader);
    var ddd = json.encode({
      "ObjectType": 14,
      "ActionType": "Edit",
      "SalesQuotationHeader": salesQuotHeader,
      "SalesQuotationLine": salesQuotLine,
    });
    log("payload 3: $ddd");
    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        // AppConstant.ip,
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

  clearSuspendedData(BuildContext context, ThemeData theme) {
    onDisablebutton = true;
    scanneditemData.clear();
    selectedcust = null;
    selectedcust55 = null;
    remarkcontroller3.text = '';
    mycontroller[50].clear();
    paymentWay.clear();
    totalPayment = null;
    postingDatecontroller.text = '';
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    newCustValues = [];
    mycontroller = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (i) => TextEditingController());
    discountcontroller = List.generate(100, (i) => TextEditingController());
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
      custList.add(CustomerDetals(
        cardCode: cusdataDB[i].customerCode,
        name: cusdataDB[i].customername,
        phNo: cusdataDB[i].phoneno1,
        accBalance: cusdataDB[i].balance,
        taxCode: cusdataDB[i].taxCode,
        point: cusdataDB[i].points.toString(),
        tarNo: cusdataDB[i].taxno,
        email: cusdataDB[i].emalid,
        invoicenum: '',
        invoiceDate: '',
        totalPayment: 00,
        address: [],
        autoId: null,
      ));
      // }
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
              name: cusdataDB[i].customername,
              phNo: cusdataDB[i].phoneno1,
              accBalance: cusdataDB[i].balance,
              point: cusdataDB[i].points.toString(),
              tarNo: cusdataDB[i].taxno,
              email: cusdataDB[i].emalid,
              taxCode: cusdataDB[i].taxCode,
              invoicenum: '',
              invoiceDate: '',
              totalPayment: 00,
              address: []));
        }
      }
    }

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

  List<DocumentLineData> itemsDetailsData = [];
  QuotPutModel? quotputdataval;

  callPatchApi(BuildContext context, ThemeData theme, int docEntry) async {
    addDocLineUpdate();
    var uuid = const Uuid();
    String? uuidg = uuid.v1();
    SerlaySalesQuoPatchAPI.cardCodePost = selectedcust!.cardCode;
    SerlaySalesQuoPatchAPI.cardNamePost = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;

    SerlaySalesQuoPatchAPI.tinNo = tinNoController.text;
    SerlaySalesQuoPatchAPI.vatNo = vatNoController.text;
    SerlaySalesQuoPatchAPI.docLineQout = itemsDocDetails;
    SerlaySalesQuoPatchAPI.docDate = config.currentDate();
    SerlaySalesQuoPatchAPI.dueDate =
        config.alignDate2(postingDatecontroller.text);
    SerlaySalesQuoPatchAPI.remarks = remarkcontroller3.text;

    SerlaySalesQuoPatchAPI.deviceTransID = uuidg;

    await SerlaySalesQuoPatchAPI.getData(sapDocentry).then((value) async {
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        // await updateSalesQuoHeaderToDB(context, theme);
        // await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry),
        //     int.parse(sapDocuNumber), docEntry, 'SalesQuotationHeader');
        onDisablebutton = false;

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
                            onDisablebutton = false;

                            Get.back();
                          }),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          injectToDb();

          custserieserrormsg = '';
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
          discountcontroller =
              List.generate(100, (i) => TextEditingController());
          mycontroller = List.generate(150, (i) => TextEditingController());
          qtymycontroller = List.generate(100, (i) => TextEditingController());
          remarkcontroller3.text = '';
          notifyListeners();
          editqty = false;
          onDisablebutton = false;

          Get.offAllNamed(ConstantRoutes.dashboard);
          notifyListeners();
        });
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        //log("Error22");
        cancelbtn = false;
        onDisablebutton = false;

        custserieserrormsg = value.errorMsg!.message!.value;
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
          Get.defaultDialog(
                  title: "Alert",
                  middleText: custserieserrormsg =
                      value.error!.message!.value.toString(),
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
            injectToDb();
            onDisablebutton = false;

            notifyListeners();
          });
        });
        onDisablebutton = false;
      } else {
        onDisablebutton = false;
      }
    });
    notifyListeners();
  }

  // call api

  postCategory(String value) {
    selectedValue = value;
  }

  // int intval = 0;

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

  refresCufstList() async {
    filtercustList = custList;

    notifyListeners();
  }

  /// customer
  String addCardCode = '';

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    addCardCode = '';
    selectedcust = null;
    selectedcust55 = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    loadingscrn = true;
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    holddocentry = '';
    double? updateCustBal;
    notifyListeners();
    log('customerDetals.taxCode::${customerDetals.taxCode}');
    selectedcust = CustomerDetals(
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        taxCode: customerDetals.taxCode,
        point: customerDetals.point,
        address: [],
        accBalance: 0,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '',
        autoId: customerDetals.autoId);

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        taxCode: customerDetals.taxCode,
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
      // loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        updateCustBal =
            double.parse(value.accBalanceData![0].balance.toString());
        notifyListeners();
      }
    });
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    addCardCode = selectedcust!.cardCode.toString();
    await CustCreditLimitAPi.getGlobalData(customerDetals.cardCode.toString())
        .then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.creditLimitData != null) {
          // log('xxxxxxxx::${value.creditLimitData![0].creditLine.toString()}');

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
          // log('yyyyyyyyyy::${value.creditDaysData![0].creditDays.toString()}');

          selectedcust!.creditDays =
              value.creditDaysData![0].creditDays.toString();
          selectedcust!.paymentGroup =
              value.creditDaysData![0].paymentGroup.toString().toLowerCase();
          log('selectedcust paymentGroup::${selectedcust!.paymentGroup!}');
          if (selectedcust!.paymentGroup!.contains('cash') == true) {
            selectedcust!.name = '';
          } else {
            selectedcust!.name = customerDetals.name!;
          }
          log('Cash paymentGroup::${selectedcust!.paymentGroup!.contains('cash')}');
          notifyListeners();
        }
        loadingscrn = false;
      }
    });

    if (scanneditemData.isNotEmpty) {
      for (var i = 0; i < scanneditemData.length; i++) {
        if (selectedcust!.taxCode == 'O1') {
          scanneditemData[i].taxRate = 18;
        } else {
          scanneditemData[i].taxRate = 0.0;
        }
        notifyListeners();
      }
      calCulateDocVal(context, theme);
    }
  }

  billaddresslist() {
    billadrrssItemlist = [];
    //log("selectedcust address lenght ZZZZ:::${selectedcust!.address!.length}");
    if (selectedcust != null) {
      for (int i = 0; i < selectedcust!.address!.length; i++) {
        //log("selectedcust!.address!.type AAAA::${selectedcust!.address![i].addresstype}");

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
        //log("selectedcust55!.address![i].addresstype::${selectedcust55!.address![i].addresstype.toString()}");

        if (selectedcust55!.address![i].addresstype == "S") {
          //log("selectedcust55!.address!.typeXXbbb::${selectedcust55!.address!.length.toString()}");

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
    loadingscrn = false;
    selectedcust = null;
    selectedcust55 = null;
    selectedcust2 = null;
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    selectedcust25 = null;
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

  filterList(String v) {
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

  callShipAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
    NewAddressModel? newAddModel = NewAddressModel();
    newAddModel.newModel = [
      NewCutomeAdrsModel(
        addressName: mycontroller[14].text,
        addressName2: mycontroller[15].text,
        addressName3: mycontroller[16].text,
        addressType: 'bo_ShipTo',
        city: mycontroller[17].text,
        country: "TZ", //mycontroller[20].text,
        state: '', // mycontroller[19].text,
        street: '',
        zipCode: mycontroller[18].text,
      ),
    ];
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertsipCreatenewAddress();
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
        addLoadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
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
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardCodexx = value.statusCode.toString();
        await insertbillCreatenewAddress();
        await DBOperation.getdata(db);
        await getCustDetFDB();
        await getcustBilladdresslist(
          context,
        );
        addLoadingBtn = false;

        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");

        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        addLoadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
    await sapLoginApi(context);
    log("App constatant fff ::::${AppConstant.sapSessionID}");
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
        state: '', // mycontroller[19].text,
        street: '',
        zipCode: mycontroller[18].text,
      ),
    ];
    final Database db = (await DBHelper.getInstance())!;

    PostAddressCreateAPi.newCutomerAddModel = newAddModel;
    await PostAddressCreateAPi.getGlobalData(selectedcust!.cardCode)
        .then((value) async {
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
        //log('JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ:::${shipcreateNewAddress.length}');

        addLoadingBtn = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        addLoadingBtn = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        addLoadingBtn = false;
      }
    });
    notifyListeners();
  }

  CreateNewBillAdd() async {
    addCardCode = '';
    final Database db = (await DBHelper.getInstance())!;
    addCardCode = selectedcust!.cardCode.toString();
    log("New Created address CardCode:$addCardCode");

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

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    addLoadingBtn = true;
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
        addLoadingBtn = false;
        notifyListeners();
      });
    }
    notifyListeners();
  }

  insertnewbiladdresscreation(BuildContext context, ThemeData theme) async {
    addLoadingBtn = true;
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
        addLoadingBtn = false;
        notifyListeners();
      });
      notifyListeners();
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
        // mycontroller[77].text,
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
    log("(mycontroller[14].text(mycontroller[14].text:::${mycontroller[14].text}");
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

  billToShip(bool dat) async {
    log("GGGGGGGGGGGGGGGGGGGGG");
    shipcreateNewAddress = [];
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

  shipToBill(bool dat) async {
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

  createnewchangescustaddres(
      BuildContext context, ThemeData theme, int ij) async {
    // final Database db = (await DBHelper.getInstance())!;
    await addnewCustomer(context, theme, ij);
    await getCustDetFDB();
    await getNewCustandadd(context);

    notifyListeners();
  }

  addnewCustomer(BuildContext context, ThemeData theme, int ij) async {
    textError = '';
    tinfileError = '';
    vatfileError = '';

    int sucesss = 0;
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
                  contentPadding: const EdgeInsets.all(0),
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
                  contentPadding: const EdgeInsets.all(0),
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
      await callCustPostApi(context);

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
          });
    }
    notifyListeners();
  }

  getNewCustandadd(
    BuildContext context,
  ) async {
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
          customerSeriesNo: custseriesNo,
          autoId: newcusdataDB[i]['autoid'].toString(),
          taxCode: newcusdataDB[i]['taxCode'].toString(),
          cardCode: newcusdataDB[i]['customerCode'].toString(),
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
    //log('step:1.1');
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

  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    log("lastUpdateIp::-----${UserValues.lastUpdateIp}");
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    newCustValues = [];
    newCustAddData = [];
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
        vatregno: ''));
    notifyListeners();
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
      'createdateTime': config.currentDate(), // createddatetime
      'updatedDatetime': config.currentDate(), // updateddatetime
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
          mycontroller[3].text.isEmpty ? '' : mycontroller[3].text.toString(),
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
          mycontroller[3].text.isEmpty ? '' : mycontroller[3].text.toString(),
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
    notifyListeners();
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
      await DBOperation.updateCustAddrsscrdcode(db, cardCodexx,
          newcusAddrssdataDB[newcusAddrssdataDB.length - 1].autoid.toString());
      notifyListeners();
    }
    notifyListeners();
  }

  mapUpdateCustomer(int sInd) async {
    mycontroller[3].text =
        selectedcust!.cardCode != null ? selectedcust!.cardCode! : '';
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
      updateCustomer(context, theme, i, ij);
      Navigator.pop(context);

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
          });
      notifyListeners();
    }
    notifyListeners();
  }

  updateCustomer(BuildContext context, ThemeData theme, int i, int ij) async {
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
          custcode: selectedcust!.cardCode,
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

  getUpdateCustandadd(BuildContext context, String custcode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust!.address = [];
    selectedcust55!.address = [];

    List<Map<String, Object?>> newcusdataDB =
        await DBOperation.getCstmMasDatabyautoid(
            db, selectedcust!.cardCode.toString());
    List<Map<String, Object?>> newaddrssdataDB =
        await DBOperation.addgetCstmMasAddDB(
            db, selectedcust!.cardCode.toString());
    for (int i = 0; i < newcusdataDB.length; i++) {
      selectedcust = CustomerDetals(
          autoId: newcusdataDB[i]['autoid'].toString(),
          taxCode: newcusdataDB[i]['taxCode'].toString(),
          cardCode: newcusdataDB[i]['customercode'].toString(),
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

  clearAddress() {
    mycontroller[7].clear();
    mycontroller[8].clear();
    mycontroller[9].clear();
    mycontroller[10].clear();
    mycontroller[11].clear();
    mycontroller[12].clear();
    mycontroller[13].clear();
    checkboxx = false;
    addLoadingBtn = false;
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
    tinNoController.text = '';
    vatNoController.text = '';
    notifyListeners();
  }
//payment func

  calCulateDocVal(BuildContext context, ThemeData theme) {
    totalPayment = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.total = 0;
    totalPay.totalDue = 0.00;
    double? mycontlaa = 0;
    log("issss length:${scanneditemData.length}");

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      scanneditemData[iss].qty = double.parse(
          qtymycontroller[iss].text.isNotEmpty
              ? qtymycontroller[iss].text
              : "0");

      // log('  totalPay.total   totalPay.total ::${totalPay.total}');
      notifyListeners();
      // if (double.parse(scanneditemData[iss].maxdiscount!) >= mycontlaa) {
      String ansbasic =
          (scanneditemData[iss].sellPrice! * scanneditemData[iss].qty!)
              .toString();
      scanneditemData[iss].basic = double.parse(ansbasic);
      // scanneditemData[iss].discountper = discountcontroller[iss].text.isNotEmpty
      //     ? double.parse(discountcontroller[iss].text.toString())
      //     : 00;
      mycontlaa = scanneditemData[iss].discountper ?? 0;
      scanneditemData[iss].discount =
          (scanneditemData[iss].basic! * mycontlaa / 100);
      scanneditemData[iss].priceAfDiscBasic =
          scanneditemData[iss].sellPrice! * 1;
      double priceafd = (scanneditemData[iss].priceAfDiscBasic! *
          scanneditemData[iss].discountper! /
          100);

      double priceaftDisc = scanneditemData[iss].priceAfDiscBasic! - priceafd;
      scanneditemData[iss].priceAftDiscVal = priceaftDisc;
      // log('priceaftDiscpriceaftDisc::$priceaftDisc');

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

      totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;
      totalPayment = totalPay;
      totalPay.total =
          totalPay.total! + double.parse(scanneditemData[iss].qty.toString());
      notifyListeners();
      // } else if (mycontlaa >= 100) {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: const EdgeInsets.all(0),
      //             content: SizedBox(
      //               width: Screens.width(context) * 0.5,
      //               height: Screens.bodyheight(context) * 0.15,
      //               child: ContentWidgetMob(
      //                   theme: theme,
      //                   msg:
      //                       "Please enter the discount percentage is below 100"),
      //             ));
      //       }).then((value) {
      //     discountcontroller[iss].text = '';
      //     notifyListeners();
      //   });
      // } else {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: const EdgeInsets.all(0),
      //             content: SizedBox(
      //               width: Screens.width(context) * 0.5,
      //               height: Screens.bodyheight(context) * 0.15,
      //               child: ContentWidgetMob(
      //                   theme: theme,
      //                   msg:
      //                       "Discount is greater than Maximum Discount(${scanneditemData[iss].maxdiscount})"),
      //             ));
      //       }).then((value) {
      //     discountcontroller[iss].text = '';
      //     notifyListeners();
      //   });
      // }
    }
    notifyListeners();
  }

  calCulateDocVal2(BuildContext context, ThemeData theme) {
    totalPayment2 = null;
    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    log("issss length:${scanneditemData2.length}");

    for (int iss = 0; iss < scanneditemData2.length; iss++) {
      // double? mycontlaa = discountcontroller2[iss].text.isNotEmpty
      //     ? double.parse(discountcontroller2[iss].text.toString())
      //     : 0;
      scanneditemData2[iss].qty = double.parse(
          qtymycontroller2[iss].text.isNotEmpty
              ? qtymycontroller2[iss].text
              : "0");

      notifyListeners();
      // if (double.parse(scanneditemData2[iss].maxdiscount!) >= mycontlaa) {
      String ansbasic =
          (scanneditemData2[iss].sellPrice! * scanneditemData2[iss].qty!)
              .toString();
      scanneditemData2[iss].basic = double.parse(ansbasic);
      // scanneditemData2[iss].discountper =
      //     discountcontroller2[iss].text.isNotEmpty
      //         ? double.parse(discountcontroller2[iss].text.toString())
      //         : 00;
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
          scanneditemData2[iss].basic! - getScanneditemData2[iss].discount!;

      scanneditemData2[iss].taxvalue =
          scanneditemData2[iss].taxable! * scanneditemData2[iss].taxRate! / 100;

      scanneditemData2[iss].netvalue =
          (scanneditemData2[iss].basic! - scanneditemData2[iss].discount!) +
              scanneditemData2[iss].taxvalue!;

      // totalPay.total = totalPay.total! + int.parse(qtymycontroller2[iss].text);
      totalPay.subtotal = totalPay.subtotal! + scanneditemData2[iss].basic!;
      totalPay.discount = totalPay.discount! + scanneditemData2[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData2[iss].taxvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;
      totalPay.total =
          totalPay.total! + double.parse(scanneditemData2[iss].qty.toString());
      totalPay.totalDue = totalPay.totalDue! + scanneditemData2[iss].netvalue!;
      totalPayment2 = totalPay;
      // log('total qty:::${totalPay.total}');
      notifyListeners();
      // } else if (mycontlaa >= 100) {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: const EdgeInsets.all(0),
      //             content: SizedBox(
      //               width: Screens.width(context) * 0.5,
      //               height: Screens.bodyheight(context) * 0.15,
      //               child: ContentWidgetMob(
      //                   theme: theme,
      //                   msg:
      //                       "Please enter the discount percentage is below 100"),
      //             ));
      //       }).then((value) {
      //     discountcontroller2[iss].text = '';
      //     notifyListeners();
      //   });
      // } else {
      //   showDialog(
      //       context: context,
      //       barrierDismissible: true,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //             contentPadding: const EdgeInsets.all(0),
      //             content: SizedBox(
      //               width: Screens.width(context) * 0.5,
      //               height: Screens.bodyheight(context) * 0.15,
      //               child: ContentWidgetMob(
      //                   theme: theme,
      //                   msg:
      //                       "Discount is greater than Maximum Discount(${scanneditemData2[iss].maxdiscount})"),
      //             ));
      //       }).then((value) {
      //     discountcontroller2[iss].text = '';
      //     notifyListeners();
      //   });
    }
    FocusScopeNode focus = FocusScope.of(context);
    //log("taxRate:${scanneditemData[iss].taxRate}");
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
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

  nullErrorMsg() {
    msgforAmount = null;
    discount = null;
    clearTextField();
    notifyListeners();
  }

  clearTextField() {
    addLoadingBtn = false;
    custseriesNo = null;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    filedata.clear();
    tinFiles = null;
    vatfileError = '';
    tinfileError = '';
    vatFiles = null;
    loadingBtn = false;
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
    newBillAddrsValue = [];
    newShipAddrsValue = [];
    billcreateNewAddress = [];
    shipcreateNewAddress = [];
    checkboxx = false;
    notifyListeners();
  }

//checkout
  changecheckout(BuildContext context, ThemeData theme) async {
    log('checkout userTypesuserTypes::${userTypes}');
    if (userTypes == 'user') {
      log('checkout userTypesuserTypes222::${userTypes}');

      await schemeapiforckout(context, theme);
    }
    log('message Checkoutout');
    await checkOut(context, theme);
    notifyListeners();
  }

  validateUpdate(BuildContext context, ThemeData theme) {
    onDisablebutton = true;
    if (selectedcust == null || scanneditemData.isEmpty) {
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
                    content: 'Please Choose a Dcoument..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    } else {
      updatechangecheckout(context, theme);
      notifyListeners();
    }
    notifyListeners();
  }

  updatechangecheckout(BuildContext context, ThemeData theme) async {
    if (scanneditemData.isNotEmpty) {
      for (int ij = 0; ij < scanneditemData.length; ij++) {
        if (scanneditemData[ij].lineStatus == "bost_Open") {
          if (userTypes == 'user') {
            await schemeapiforckout(context, theme);
          }
          await callPatchApi(context, theme, int.parse(sapDocentry.toString()));

          notifyListeners();
        } else if (scanneditemData[ij].lineStatus == "bost_Close") {
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
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            onDisablebutton = false;
            notifyListeners();
          });
        }
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
                    content: 'Something went wrong..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        onDisablebutton = false;
        notifyListeners();
      });
    }
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
        onDisablebutton = false;
        notifyListeners();
      });
    } else {
      await saveValuesTODB("check out", context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteHoldSalesQuoMaped(db, holddocentry)
            .then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
        });
      }
    }
    notifyListeners();
  }

  schemeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
    notifyListeners();
  }

  Future<int?> checkCredit(String typpe) {
    for (int i = 0; i < paymentWay.length; i++) {
      if (paymentWay[i].type == typpe) {
        //log('Serial batch:$typpe');
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  removeEmptyList(BuildContext context) {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtymycontroller[i].text.isEmpty) {
        // removeI.add(i);
        qtymycontroller.removeAt(i);
        scanneditemData.removeAt(i);
      }
    }
  }

  setvalues() {
    for (int i = 0; i < scanneditemData.length; i++) {
      qtymycontroller[i].text = scanneditemData[i].qty.toString();
    }
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
      selectedcust2 = null;
      scanneditemData2.clear();
      paymentWay2.clear();
      totalPayment2 = null;
      if (userTypes == 'user') {
        if (schemebtnclk == true) {
          await schemeapiforckout(context, theme);
        }
      }
      await saveValuesTODB("hold", context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteHoldSalesQuoMaped(db, holddocentry)
            .then((value) {
          holddocentry = '';
          holdData.clear();
          getdraftindex();
        });
      }
      injectToDb();
      notifyListeners();
    }
    onDisablebutton = false;
    notifyListeners();
  }

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mycontroller[24].text = config.alignDate(datetype!);
    mycontroller[44].text = config.alignDate(datetype!);
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

  String? discount;
  clearAllData(BuildContext context, ThemeData theme) {
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    addCardCode = '';
    seriesType = '';
    postingDatecontroller.text = '';
    userTypes = '';
    scanneditemCheckUpdateData = [];
    filtersearchData = [];
    visibleItemList = false;
    loadSearch = false;
    itemsDocDetails = [];
    newCustAddData = [];
    searchcon.text = '';
    selectedcust55 = null;
    schemebtnclk = false;
    editqty = false;
    cancelbtn = false;
    filedata.clear();
    scanneditemData2 = [];
    remarkcontroller3.text = '';
    catchmsg = [];
    custseriesNo = null;
    schemeData = [];
    resSchemeDataList = [];
    pref = SharedPreferences.getInstance();
    loadingscrn = false;
    sapDocentry = '';
    sapDocuNumber = '';
    formkey = List.generate(100, (i) => GlobalKey<FormState>());
    focusnode = List.generate(100, (i) => FocusNode());
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    selectedcust = null;
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
    salesmodl.clear();
    newCustValues.clear();
    newBillAddrsValue.clear();
    newShipAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();
    addLoadingBtn = false;
    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
    postingDatecontroller.text = config.alignDate(DateTime.now().toString());

    notifyListeners();
  }

  onselectVisibleItem(BuildContext context, ThemeData theme, int indx) async {
    // Navigator.pop(context);
    // if (scanneditemData.isEmpty) {
    int res = checkhaveQty(indx, 0);

    if (res > 0) {
      addSannedItem(indx, context, theme);
    } else {
      Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
      // }
    }
    // else {
    //   int result = await checkalreadyScanedd(indx);
    //   if (result != -1) {
    //     int res = checkhaveQty(indx, int.parse(qtymycontroller[result].text));
    //     if (res > 0) {
    //       incrementQty(result, '1', context, theme);
    //     } else {
    //       Get.defaultDialog(title: 'Alert', middleText: 'No more qty to add');
    //     }
    //   } else {
    //     addSannedItem(indx, context, theme);
    //   }
    // }
    calCulateDocVal(context, theme);
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

    String datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
    postingDatecontroller.text = datetype;
  }

  viewdetails() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.deleteSalesQuot(db);
    log("delete tab");
  }

  viewSalesheader() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getSalesHeadHoldvalueDB(db);
    notifyListeners();
  }

  showItemVisibility(String v) {}

  getcustBilladdresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.getdata(db);
    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust!.cardCode!);

    log("MMMMMMMMM:::${csadresdataDB.length}");
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
      }
    }

    notifyListeners();
  }

  getcustshipaddresslist(
    BuildContext context,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getdata(db);

    List<Map<String, Object?>> csadresdataDB =
        await DBOperation.addgetCstmMasAddDB(db, selectedcust55!.cardCode!);

    log("MMMMMMMMM55:::${selectedcust55!.cardCode}");
    log("textErrortextErrortextErrortextErrortextError::${csadresdataDB.length}");
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
    log("selectedcust55!.address!.lengthRRR:::${selectedcust55!.address!.length}");
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

  List<CompanyTinVatMdlData>? cmpnyDetails = [];

  callCompanyTinVatApii() async {
    cmpnyDetails = [];
    await CompanyTinVatApii.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          cmpnyDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
  }

  List<SOCustomerAddModelData> custDetails = [];

  soCustAddressApi(String docEntry) async {
    await SOCustAddressApii.getGlobalData(docEntry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          custDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    await callCompanyTinVatApii();
  }

  Future<void> callPrintApi(
    BuildContext context,
    ThemeData theme,
  ) async {
    onDisablebutton = true;
    QuotationPrintAPi.docEntry = sapDocentry;
    QuotationPrintAPi.slpCode = AppConstant.slpCode;
    // print("QuotationPrintAPi.slpCode: " + QuotationPrintAPi.slpCode.toString());
    await QuotationPrintAPi.getGlobalData().then((value) {
      notifyListeners();
      if (value == 200) {
        onDisablebutton = false;
        notifyListeners();

        // saveAllExcel(QuotationPrintAPi.path.toString(), context, theme);
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

  mapCallSalesQuotForPDF(preff, BuildContext context, ThemeData theme) async {
    log("FFFFFFFF::${scanneditemData2.length}");
    List<InvoiceItem> itemsList = [];
    invoice = null;
    // for (int ih = 0; ih < salesmodl.length; ih++) {
    await addressxx();
    for (int i = 0; i < scanneditemData2.length; i++) {
      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        descripton: scanneditemData2[i].itemName,
        unitPrice:
            double.parse(scanneditemData2[i].sellPrice!.toStringAsFixed(2)),
        quantity: double.parse((qtymycontroller2[i].text)),
        dics: scanneditemData2[i].discountper ?? 0,
        vat: double.parse(scanneditemData2[i].taxvalue!.toStringAsFixed(2)),
      ));
      notifyListeners();
    }
    invoice = Invoice(
      headerinfo: InvoiceHeader(
          tincode: selectedcust2!.tarNo ?? '',
          vatNo: selectedcust2!.vatregno ?? '',
          ordReference: selectedcust2!.custRefNum ?? '',
          invDate: config.alignDate(selectedcust2!.invoiceDate.toString()),
          invNum: selectedcust2!.invoicenum,
          companyName: 'companyName',
          address: 'address',
          area: 'area',
          pincode: 'pincode',
          mobile: 'mobile',
          gstNo: 'gstNo',
          salesOrder: selectedcust2!.invoicenum),
      invoiceMiddle: InvoiceMiddle(
        tinNo: cmpnyDetails![0].tinNo ?? '',
        vatNo: cmpnyDetails![0].vatNo ?? '',
        date: selectedcust2!.invoiceDate.toString(),
        time: 'time',
        customerName: selectedcust2!.name ?? '',
        address: custDetails[0].address ?? '',
        printerName: custDetails[0].printHeadr ?? '',
        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
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

    PDFQuoApi.exclTxTotal = 0;
    PDFQuoApi.vatTx = 0;
    PDFQuoApi.inclTxTotal = 0;
    if (invoice != null) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        PDFQuoApi.exclTxTotal =
            (PDFQuoApi.exclTxTotal) + (invoice!.items![i].netTotal!);
        PDFQuoApi.vatTx =
            (PDFQuoApi.vatTx) + double.parse(invoice!.items![i].vat.toString());
        PDFQuoApi.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString()) +
                double.parse(invoice!.items![i].vat.toString());
        PDFQuoApi.pdfSubtotal = invoice!.items![i].unitPrice!;
        notifyListeners();
      }
      PDFQuoApi.inclTxTotal = (PDFQuoApi.exclTxTotal) + (PDFQuoApi.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }
      PDFQuoApi.iinvoicee = invoice;
      printingdoc(context, theme);
    } else {
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
                    content: 'Please Choose the Document..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
    notifyListeners();
  }

  printingdoc(BuildContext context, ThemeData theme) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => PDFQuoApi()));
    notifyListeners();
  }

  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkItemCode(db, '');
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
    log(e);
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

class FilesData {
  String fileBytes;
  String fileName;

  FilesData({required this.fileBytes, required this.fileName});
}
