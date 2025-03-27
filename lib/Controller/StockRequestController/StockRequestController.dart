import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Models/DataModel/StockReqModel/branchModel.dart';
import 'package:posproject/Models/DataModel/StockReqModel/orderModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/ItemMaster.dart';
import '../../DBModel/StockReqLine.dart';
import '../../DBModel/StockRequestHD.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/DataModel/StockReqModel/warehouseModel.dart';
import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/SapStkRequestModel.dart';
import '../../Models/ServiceLayerModel/SAPStockRequest/StockReqPostringModel.dart';
import '../../Pages/PrintPDF/invoice.dart';
import '../../Pages/StockRequest/Widget/ReqPrintDoc.dart';
import '../../Service/AccountBalanceAPI.dart';

import '../../Service/Printer/InventoryPrint.dart';
import '../../Service/QueryURL/CompanyVatTinApi.dart';
import '../../Service/QueryURL/SoCustomerAddressApi.dart';
import '../../Service/SearchQuery/SearchReqLineApi.dart';
import '../../Service/SearchQuery/SearchStockReqApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/STockRequest/PostRequestAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../ServiceLayerAPIss/STockRequest/GetRequestAPI.dart';
import '../../ServiceLayerAPIss/STockRequest/RequestCancelAPI.dart';
import '../../ServiceLayerAPIss/STockRequest/RequestLoginnAPI.dart';
import '../../Service/StockSnapApi.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class StockReqController extends ChangeNotifier {
  Configure config = Configure();
  TextEditingController searchcontroller = TextEditingController();

  List<TextEditingController> mycontroller =
      List.generate(500, (i) => TextEditingController());
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController remarkscontroller2 = TextEditingController();

  List<TextEditingController> qtyCont =
      List.generate(500, (i) => TextEditingController());
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;
  FocusNode inven = FocusNode();
  String holddocentry = '';
  TextEditingController searchcon = TextEditingController();
  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;
  bool? onclickDisable = false;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<WhsDetails> filsterwhsList = [];
  List<WhsDetails> whsList = [];
  String sapDocentry = '';
  String sapDocuNumber = '';
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;
  String? seriesValue;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<ErrorModel> sererrorlist = [];
  List<StockTransferReqLine> sapReaqModelData = [];

  void init() {
    searchclear();
    callList();
    callDB();
    getCustDetFDB();
  }

  WhsDetails? fromAddressList;
  WhsDetails? get getFromAddressList => fromAddressList;
  WhsDetails? fromAddressList2;
  WhsDetails? get getFromAddressList2 => fromAddressList2;

  callDB() async {
    final Database db = (await DBHelper.getInstance())!;
    await getBranchValues(db);
    await getHoldStReq(db);
  }

  bool visibleItemList = false;

  Future getHoldStReq(Database db) async {
    holddocentry = '';
    savedraftBill = [];
    whssSlectedList = null;
    selectedcust2 = null;
    List<Map<String, Object?>> holdDataHD =
        await DBOperation.getStockHDReqHold(db);

    WhsDetails? whsDet;

    for (int i = 0; i < holdDataHD.length; i++) {
      List<StocksnapModelData> scannData = [];

      List<Map<String, Object?>> branchdata = await DBOperation.getBrnachbyCode(
          db, holdDataHD[i]['reqtoWhs'].toString());
      List<Map<String, Object?>> holdDataLn =
          await DBOperation.getStockLReqHold(
              db, int.parse(holdDataHD[i]['docentry'].toString()));

      for (int j = 0; j < branchdata.length; j++) {
        WhsDetails whs = WhsDetails(
            dbDocEntry: int.parse(holdDataHD[i]['docentry'].toString()),
            whsName: branchdata[j]['WhsName'].toString(),
            whsCode: branchdata[j]['WhsCode'].toString(),
            gitWhs: branchdata[j]['GITWhs'].toString(),
            whsmailID: branchdata[j]['E_Mail'].toString(),
            companyName: branchdata[i]['CompanyName'].toString(),
            whsPhoNo: '',
            whsGst: branchdata[j]['GSTNo'].toString(),
            whsAddress: branchdata[j]['Address1'].toString(),
            whsDistric: branchdata[j]['DisAcct1'].toString(),
            pinCode: branchdata[j]['Pincode'].toString(),
            whsState: branchdata[j]['StateCode'].toString(),
            whsCity: branchdata[j]['City'].toString(),
            createdateTime: holdDataHD[i]['createdateTime'].toString());
        whsDet = whs;
      }

      for (int k = 0; k < holdDataLn.length; k++) {
        if (holdDataLn[k]['docentry'].toString() ==
            holdDataHD[i]['docentry'].toString()) {
          scannData.add(StocksnapModelData(
            transID: int.parse(holdDataLn[k]['docentry'].toString()),
            branch: holdDataLn[k][''].toString(),
            itemCode: holdDataLn[k]['itemcode'].toString(),
            itemName: holdDataLn[k]['dscription'].toString(),
            serialBatch: holdDataLn[k]['serialBatch'].toString(),
            openQty: double.parse(holdDataLn[k]['quantity'] == null
                ? '0'
                : holdDataLn[k]['quantity'].toString()),
            qty: double.parse(holdDataLn[k]['quantity'] == null
                ? '0'
                : holdDataLn[k]['quantity'].toString()),
            inDate: holdDataLn[k][''].toString(),
            inType: holdDataLn[k][''].toString(),
            mrp: 0,
            sellPrice: double.parse(holdDataLn[k]['price'] == null
                ? '0'
                : holdDataLn[k]['price'].toString()),
            cost: 0,
            taxRate: double.parse(holdDataLn[k]['taxRate'] == null
                ? '0'
                : holdDataLn[k]['taxRate'].toString()),
            displayQty: holdDataLn[k]['DisplayQty'].toString(),
            maxdiscount: '',
            liter: holdDataLn[k]['liter'] == null
                ? 0.0
                : double.parse(holdDataLn[k]['liter'].toString()),
            weight: holdDataLn[k]['weight'] == null
                ? 0.0
                : double.parse(holdDataLn[k]['weight'].toString()),
          ));
        }
      }
      savedraftBill.add(Orderdetails(
          cardCode: holdDataHD[i]['CardCode'].toString(),
          cardname: holdDataHD[i]['CardName'].toString(),
          whsAdd: whsDet,
          orderType: "Hold",
          scannData: scannData,
          remarks: holdDataHD[i]['remarks'].toString()));
    }

    await calculateDetails();

    notifyListeners();
  }

  filterList(String v) {
    log(whsList.length.toString());
    if (v.isNotEmpty) {
      filsterwhsList = whsList
          .where((e) =>
              e.whsCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.whsName!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filsterwhsList = whsList;
      notifyListeners();
    }
  }

  filterbranchList(String v) {}

  WhsDetails? whssSlectedList;
  WhsDetails? get get_whssSlectedList => whssSlectedList;
  whsSelected(WhsDetails whsDetails, BuildContext context) {
    WhsDetails whssSlectedList2 = WhsDetails(
        gitWhs: whsDetails.gitWhs,
        whsName: whsDetails.whsName,
        companyName: whsDetails.companyName,
        whsCode: whsDetails.whsCode,
        whsPhoNo: whsDetails.whsPhoNo,
        whsmailID: whsDetails.whsmailID,
        whsGst: whsDetails.whsGst,
        whsAddress: whsDetails.whsAddress,
        whsDistric: whsDetails.whsDistric,
        pinCode: whsDetails.pinCode,
        whsState: whsDetails.whsState,
        whsCity: whsDetails.whsCity);
    whssSlectedList = whssSlectedList2;
    notifyListeners();
  }

  branchSelected(ShipAddresss branchDetails, BuildContext context) {
    ShipAddresss shipSelectedList2 = ShipAddresss(
        billAddress: branchDetails.billAddress,
        billCity: branchDetails.billCity,
        billCountry: branchDetails.billCountry,
        billPincode: branchDetails.billPincode,
        billstate: branchDetails.billstate);
    ShipSelectedList = shipSelectedList2;
    notifyListeners();
  }

  callList() {
    filsterwhsList = whsList;

    notifyListeners();
  }

  clearData() {
    whssSlectedList = null;
    seriesVal = [];

    notifyListeners();
  }

  filterCustList(String v) async {
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

  List<searchModel> searchData = [];
  bool searchbool = false;
  searchInitMethod() {
    mycontroller[100].text = config.alignDate(config.currentDate());
    mycontroller[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  String addCardCode = '';

  CustomerDetals? selectedcust;
  CustomerDetals? selectedcust2;

  TextEditingController custNameController = TextEditingController();
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;
  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  List<CustomerDetals> custList = [];

  List<CustomerDetals> custList2 = [];
  refresCufstList() async {
    filtercustList = custList;

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

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    selectedcust = null;
    selectedcust55 = null;
    custNameController.text = '';
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    double? updateCustBal = 0;
    loadingscrn = true;
    holddocentry = '';
    log('message ustomerDetals.taxCode::${customerDetals.taxCode}');

    selectedcust = CustomerDetals(
        autoId: customerDetals.autoId,
        taxCode: customerDetals.taxCode,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        point: customerDetals.point,
        accBalance: 0,
        address: [],
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

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
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

  onselectVisibleItem(BuildContext context, ThemeData theme,
      ItemMasterModelDB selectdata) async {
    if (whssSlectedList == null) {
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
                    content: 'Choose warehuse address..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    } else if (whssSlectedList != null) {
      addScannedData2(selectdata, context, theme);
    }
  }

  filterContactList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchReqData
          .where((e) =>
              e.docNum.toString().contains(v.toLowerCase()) ||
              e.docEntry.toString().contains(v.toLowerCase()) ||
              e.uwhsCode.toString().contains(v.toLowerCase()) ||
              e.fromWhs.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchReqData;
      notifyListeners();
    }
  }

  doubleDotMethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    qtyCont[i].text = modifiedString2.toString();
    log(qtyCont[i].text);
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

  WhsDetails? whssSlectedList2;
  WhsDetails? get getWhssSlectedList2 => whssSlectedList2;
  double? totwieght = 0.0;
  double? totLiter = 0.0;

  fixDataMethod(int docentry) async {
    sapDocentry = '';
    sapDocuNumber = '';
    final Database db = (await DBHelper.getInstance())!;
    scanneditemData2.clear();
    whssSlectedList2 = null;
    totwieght = 0.0;
    totLiter = 0.0;
    remarkscontroller2.text = "";
    fromAddressList2 = null;
    List<Map<String, Object?>> getDBSaleReqHeader2 =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDBSaleReqLine2 =
        await DBOperation.getStockLReqHold(db, docentry);
    if (getDBSaleReqHeader2.isNotEmpty) {
      sapDocentry = getDBSaleReqHeader2[0]["sapDocentry"] != null
          ? getDBSaleReqHeader2[0]["sapDocentry"].toString()
          : '';
      sapDocuNumber = getDBSaleReqHeader2[0]["sapDocNo"] != null
          ? getDBSaleReqHeader2[0]["sapDocNo"].toString()
          : '';

      remarkscontroller2.text = getDBSaleReqHeader2[0]["remarks"].toString();
      totwieght =
          double.parse(getDBSaleReqHeader2[0]["totalweight"].toString());
      totLiter = double.parse(getDBSaleReqHeader2[0]["totalltr"].toString());

      for (int i = 0; i < getDBSaleReqLine2.length; i++) {
        scanneditemData2.add(StocksnapModelData(
          maxdiscount: "",
          branch: "",
          itemCode: getDBSaleReqLine2[i]["itemcode"].toString(),
          itemName: getDBSaleReqLine2[i]["dscription"].toString(),
          serialBatch: getDBSaleReqLine2[i]["serialBatch"].toString(),
          qty: double.parse(getDBSaleReqLine2[i]["quantity"].toString()),
          mrp: 0.0,
          sellPrice: double.parse(getDBSaleReqLine2[i]["price"].toString()),
          taxRate: 0.0,
          liter: getDBSaleReqLine2[i]['liter'] == null
              ? 0.0
              : double.parse(getDBSaleReqLine2[i]['liter'].toString()),
          weight: getDBSaleReqLine2[i]['weight'] == null
              ? 0.0
              : double.parse(getDBSaleReqLine2[i]['weight'].toString()),
        ));
      }

      List<Map<String, Object?>> branchData = await DBOperation.getBranch(db);
      for (int i = 0; i < branchData.length; i++) {
        if (getDBSaleReqHeader2[0]["reqtoWhs"].toString() ==
            branchData[i]['WhsCode'].toString()) {
          whssSlectedList2 = WhsDetails(
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
              whsCity: branchData[i]['City'].toString());
        }

        if (UserValues.branch == branchData[i]['WhsCode'].toString()) {
          WhsDetails whssSlectedList3 = WhsDetails(
              whsName: branchData[i]['WhsName'].toString(),
              whsCode: branchData[i]['WhsCode'].toString(),
              gitWhs: branchData[i]['GITWhs'].toString(),
              companyName: branchData[i]['CompanyName'].toString(),
              whsmailID: branchData[i]['E_Mail'].toString(),
              whsPhoNo: '',
              whsGst: branchData[i]['GSTNo'].toString(),
              whsAddress: branchData[i]['Address1'].toString(),
              whsDistric: branchData[i]['DisAcct1'].toString(),
              pinCode: branchData[i]['Pincode'].toString(),
              whsState: branchData[i]['StateCode'].toString(),
              whsCity: branchData[i]['City'].toString());
          fromAddressList2 = whssSlectedList3;
        }
      }
    } else if (getDBSaleReqHeader2.isEmpty) {
      scanneditemData2.clear();
    }
    notifyListeners();
  }

  List<OpenSalesReqHeadersModlData> searchReqData = [];
  List<OpenSalesReqHeadersModlData> filtersearchData = [];
  String u_RequestWhs = '';
  callSearchReqApi() async {
    u_RequestWhs = '';
    searchReqData = [];
    filtersearchData = [];

    await SerachReqHeaderAPi.getGlobalData(
            config.alignDate2(mycontroller[100].text.toString()),
            config.alignDate2(mycontroller[101].text.toString()))
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('ffffff');
        searchReqData = value.activitiesData!;
        filtersearchData = searchReqData;

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  setstate1() {
    notifyListeners();
  }

  bool loadSearch = false;

  callSearchLineApi(String docEntry, int index) async {
    final Database db = (await DBHelper.getInstance())!;
    scanneditemData2 = [];
    sapDocentry = '';

    await SearchRequestLineAPi.getGlobalData(docEntry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (filtersearchData.isNotEmpty) {
          u_RequestWhs = filtersearchData[index].uwhsCode;
        }
        sapDocentry = filtersearchData[index].docEntry.toString();
        log('filtersearchData::${filtersearchData[index].uwhsCode}:::${filtersearchData[index].fromWhs}');
        selectedcust2 = CustomerDetals(
            name: filtersearchData[index].cardName,
            reqFrom: filtersearchData[index].uwhsCode,
            reqTo: filtersearchData[index].fromWhs,
            cardCode: filtersearchData[index].cardCode,
            accBalance: 0,
            invoiceDate: filtersearchData[index].docDate,
            invoicenum: filtersearchData[index].docNum.toString(),
            docentry: filtersearchData[index].docEntry.toString(),
            email: '',
            phNo: '');
        if (value.activitiesData!.isNotEmpty) {
          remarkscontroller2.text = filtersearchData[index].comments.toString();
          for (var i = 0; i < value.activitiesData!.length; i++) {
            scanneditemData2.add(StocksnapModelData(
                maxdiscount: "",
                branch: "",
                itemCode: value.activitiesData![i].itemCode.toString(),
                itemName: value.activitiesData![i].description,
                serialBatch: '',
                qty: value.activitiesData![i].qty,
                openRetQty: value.activitiesData![i].qty,
                mrp: 0.0,
                sellPrice: value.activitiesData![i].unitPrice,
                taxRate: 0.0,
                liter: 0.0,
                weight: 0.0));
          }
          List<Map<String, Object?>> branchData =
              await DBOperation.getBranch(db);
          for (int i = 0; i < branchData.length; i++) {
            if (filtersearchData[index].fromWhs.toString() ==
                branchData[i]['WhsCode'].toString()) {
              whssSlectedList2 = WhsDetails(
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
                  whsCity: branchData[i]['City'].toString());
            }

            if (UserValues.branch == branchData[i]['WhsCode'].toString()) {
              WhsDetails whssSlectedList3 = WhsDetails(
                  whsName: branchData[i]['WhsName'].toString(),
                  whsCode: branchData[i]['WhsCode'].toString(),
                  gitWhs: branchData[i]['GITWhs'].toString(),
                  companyName: branchData[i]['CompanyName'].toString(),
                  whsmailID: branchData[i]['E_Mail'].toString(),
                  whsPhoNo: '',
                  whsGst: branchData[i]['GSTNo'].toString(),
                  whsAddress: branchData[i]['Address1'].toString(),
                  whsDistric: branchData[i]['DisAcct1'].toString(),
                  pinCode: branchData[i]['Pincode'].toString(),
                  whsState: branchData[i]['StateCode'].toString(),
                  whsCity: branchData[i]['City'].toString());
              fromAddressList2 = whssSlectedList3;
            }
          }
        }

        loadSearch = false;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadSearch = false;
        notifyListeners();
      } else {
        loadSearch = false;
      }
    });
    notifyListeners();
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    log(fromdate);
    log(todate);

    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockReqHeader =
        await DBOperation.getStockReqHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();

    if (getStockReqHeader.isNotEmpty) {
      for (int i = 0; i < getStockReqHeader.length; i++) {
        searchdata2.add(searchModel(
            username: UserValues.username,
            terminal: AppConstant.terminal,
            type: getStockReqHeader[i]["docstatus"] == null
                ? ""
                : getStockReqHeader[i]["docstatus"].toString() == "2"
                    ? "Against Order"
                    : getStockReqHeader[i]["docstatus"].toString() == "3"
                        ? "Save"
                        : "",
            qStatus: getStockReqHeader[i]["qStatus"] == null
                ? ""
                : getStockReqHeader[i]["qStatus"].toString(),
            docentry: getStockReqHeader[i]["docentry"] == null
                ? 0
                : int.parse(getStockReqHeader[i]["docentry"].toString()),
            docNo: getStockReqHeader[i]["documentno"] == null
                ? "0"
                : getStockReqHeader[i]["documentno"].toString(),
            docDate: getStockReqHeader[i]["createdateTime"].toString(),
            sapNo: getStockReqHeader[i]["sapDocNo"] == null
                ? 0
                : int.parse(getStockReqHeader[i]["sapDocNo"].toString()),
            sapDate: getStockReqHeader[i]["createdateTime"] == null
                ? ""
                : getStockReqHeader[i]["createdateTime"].toString(),
            customeraName: getStockReqHeader[i]["reqtoWhs"].toString(),
            doctotal: getStockReqHeader[i][""] == null
                ? 0
                : double.parse(getStockReqHeader[i][""].toString())));
        notifyListeners();
      }
      searchData.addAll(searchdata2);
    } else {
      searchbool = false;
      searchData.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isNotEmpty) {
      await sapLoginApi(context);
      await callSerlaySalesQuoAPI(context, theme);
      await callSerlaySalesCancelQuoAPI(context, theme);
      notifyListeners();
    } else {
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
        scanneditemData2 = [];
        fromAddressList2 = null;
        totwieght = null;
        whssSlectedList2 = null;
        totLiter = null;
        searchclear();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostRequestLoginAPi.getGlobalData().then((value) async {
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
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    await sapLoginApi(context);
    final Database db = (await DBHelper.getInstance())!;

    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");
    scanneditemData2 = [];
    await SerlayStkRequestAPI.getData(sapDocentry.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.stockTransferReqLines.isNotEmpty) {
          sapReaqModelData = value.stockTransferReqLines;

          custserieserrormsg = '';
          for (var i = 0; i < sapReaqModelData.length; i++) {
            scanneditemData2.add(StocksnapModelData(
                branch: AppConstant.branch,
                itemCode: sapReaqModelData[i].itemCode,
                itemName: sapReaqModelData[i].itemDescription,
                openRetQty: sapReaqModelData[i].quantity,
                serialBatch: '',
                mrp: 0,
                sellPrice: sapReaqModelData[i].unitPrice ?? 0));
          }
          List<Map<String, Object?>> branchData =
              await DBOperation.getBranch(db);
          for (int i = 0; i < branchData.length; i++) {
            if (u_RequestWhs.toString() ==
                branchData[i]['WhsCode'].toString()) {
              whssSlectedList2 = WhsDetails(
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
                  whsCity: branchData[i]['City'].toString());
            }

            if (UserValues.branch == branchData[i]['WhsCode'].toString()) {
              WhsDetails whssSlectedList3 = WhsDetails(
                  whsName: branchData[i]['WhsName'].toString(),
                  whsCode: branchData[i]['WhsCode'].toString(),
                  gitWhs: branchData[i]['GITWhs'].toString(),
                  companyName: branchData[i]['CompanyName'].toString(),
                  whsmailID: branchData[i]['E_Mail'].toString(),
                  whsPhoNo: '',
                  whsGst: branchData[i]['GSTNo'].toString(),
                  whsAddress: branchData[i]['Address1'].toString(),
                  whsDistric: branchData[i]['DisAcct1'].toString(),
                  pinCode: branchData[i]['Pincode'].toString(),
                  whsState: branchData[i]['StateCode'].toString(),
                  whsCity: branchData[i]['City'].toString());
              fromAddressList2 = whssSlectedList3;
            }
          }
          notifyListeners();
        } else {}
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        custserieserrormsg = value.error!.message!.value.toString();
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: const EdgeInsets.all(0),
                  content: AlertBox(
                    payMent: 'Success',
                    errormsg: true,
                    widget: Center(
                        child: ContentContainer(
                      content: value.error!.message!.value.toString(),
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          scanneditemData2 = [];
          fromAddressList2 = null;
          whssSlectedList2 = null;
          totwieght = null;
          totLiter = null;
          notifyListeners();
        });
        notifyListeners();

        custserieserrormsg = '';
      } else {}
    });
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapReaqModelData.isNotEmpty) {
      for (int i = 0; i < sapReaqModelData.length; i++) {
        if (sapReaqModelData[i].lineStatus == "bost_Open") {
          await SerlayRequestCancelAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;

              await DBOperation.updateStkReqclosedocsts(
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
                scanneditemData2 = [];
                fromAddressList2 = null;
                whssSlectedList2 = null;
                totwieght = null;
                totLiter = null;
                notifyListeners();
              });
              custserieserrormsg = '';
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;
              custserieserrormsg = value.exception!.message!.value.toString();

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
                whssSlectedList2 = null;
                sapDocuNumber = '';
                scanneditemData2 = [];
                fromAddressList2 = null;
                totwieght = null;
                whssSlectedList2 = null;
                totLiter = null;
                notifyListeners();
              });

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
                whssSlectedList2 = null;
                sapDocuNumber = '';
                scanneditemData2 = [];
                fromAddressList2 = null;
                totwieght = null;
                whssSlectedList2 = null;
                totLiter = null;
                notifyListeners();
              });
            } else {}
          });
        } else if (sapReaqModelData[i].lineStatus == "bost_Close") {
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
                        content: 'Document is already closed..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            whssSlectedList2 = null;
            scanneditemData2 = [];
            fromAddressList2 = null;
            totwieght = null;
            totLiter = null;
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }

  Future getBranchValues(Database db) async {
    filsterwhsList = [];
    whsList = [];
    List<Map<String, Object?>> branchData = await DBOperation.getBranch(db);
    for (int i = 0; i < branchData.length; i++) {
      if (UserValues.branch != branchData[i]['WhsCode'].toString()) {
        whsList.add(WhsDetails(
            whsName: branchData[i]['WhsName'].toString(),
            whsCode: branchData[i]['WhsCode'].toString(),
            gitWhs: branchData[i]['GITWhs'].toString(),
            whsmailID: branchData[i]['E_Mail'].toString(),
            companyName: branchData[i]['CompanyName'].toString(),
            whsPhoNo: '',
            whsGst: branchData[i]['GSTNo'].toString(),
            whsAddress: branchData[i]['Address1'].toString(),
            whsDistric: branchData[i]['DisAcct1'].toString(),
            pinCode: branchData[i]['Pincode'].toString(),
            whsState: branchData[i]['StateCode'].toString(),
            whsCity: branchData[i]['City'].toString()));
      } else {
        WhsDetails whssSlectedList3 = WhsDetails(
            whsName: branchData[i]['WhsName'].toString(),
            gitWhs: branchData[i]['GITWhs'].toString(),
            whsCode: branchData[i]['WhsCode'].toString(),
            companyName: branchData[i]['CompanyName'].toString(),
            whsmailID: branchData[i]['E_Mail'].toString(),
            whsPhoNo: '',
            whsGst: branchData[i]['GSTNo'].toString(),
            whsAddress: branchData[i]['Address1'].toString(),
            whsDistric: branchData[i]['DisAcct1'].toString(),
            pinCode: branchData[i]['Pincode'].toString(),
            whsState: branchData[i]['StateCode'].toString(),
            whsCity: branchData[i]['City'].toString());
        fromAddressList = whssSlectedList3;
      }
    }
    if (fromAddressList != null) {
      log('fromAddressListfromAddressList::${fromAddressList!.gitWhs}');
    }

    filsterwhsList = whsList;
    notifyListeners();
  }

  ShipAddresss? ShipSelectedList;
  ShipAddresss? get get_ShipSelectedList => ShipSelectedList;
  List<ShipAddresss> filterShipAddressList = [];

  String exception = '';
  getAllData() async {
    StockSnapModelApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.stocksnapitemdata != null) {
          itemData = value.stocksnapitemdata!;
        } else if (value.stocksnapitemdata == null) {
          exception = value.message!;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        exception = value.exception!;
      } else {
        exception = value.exception!;
      }
    });
  }

  List<ItemMasterModelDB> getSearchedData = [];
  List<ItemMasterModelDB> getfilterSearchedData = [];

  List<ItemMasterModelDB> getAllSelect = [];

  Future<List<ItemMasterModelDB>> getAllList(String data) async {
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList(db, data);
    getfilterSearchedData = getSearchedData;
    notifyListeners();
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

  bool? loadLastSoldItemsbool = false;
  String? loadLastSoldItemsmsg = "";
  loadLastSoldItemsData(ThemeData theme) async {
    if (whssSlectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadLastSoldItemsbool = true;
      loadLastSoldItemsmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getLastdaySoldData(db);
      if (getShelfReqData.isNotEmpty) {
        loadLastSoldItemsbool = false;
        loadLastSoldItemsmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          scanneditemData.add(StocksnapModelData(
              transID: 1,
              branch: "",
              itemCode: getShelfReqData[i]["itemcode"].toString(),
              itemName: getShelfReqData[i]["itemname"].toString(),
              serialBatch: getShelfReqData[i]["serialbatch"].toString(),
              openQty: 1,
              qty: getShelfReqData[i]["quantity"] == null
                  ? 0
                  : double.parse(getShelfReqData[i]["quantity"].toString()),
              inDate: '',
              inType: '',
              mrp: 0,
              sellPrice: 0.0,
              cost: 0,
              taxRate: 0,
              maxdiscount: '',
              liter: getShelfReqData[i]["totalltr"] == null
                  ? 0.0
                  : double.parse(getShelfReqData[i]["totalltr"].toString()),
              weight: getShelfReqData[i]["totalweight"] == null
                  ? 0
                  : double.parse(
                      getShelfReqData[i]["totalweight"].toString())));
          qtyCont[scanneditemData.length - 1].text =
              getShelfReqData[i]["quantity"] == null
                  ? "0"
                  : getShelfReqData[i]["quantity"].toString();
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadLastSoldItemsmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadLastSoldItemsbool = false;
        loadLastSoldItemsmsg = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

  bool? loadMiniMaxbool = false;
  String? loadMiniMaxmsg = "";
  loadMiniMaxData(ThemeData theme) async {
    if (whssSlectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadMiniMaxbool = true;
      loadMiniMaxmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getoutofDataData(db);
      if (getShelfReqData.isNotEmpty) {
        loadMiniMaxbool = false;
        loadMiniMaxmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          if (getShelfReqData[i]["shortageQty"] != 0) {
            scanneditemData.add(StocksnapModelData(
                transID: 1,
                branch: "",
                itemCode: getShelfReqData[i]["Itemcode"].toString(),
                itemName: getShelfReqData[i]["itemname_short"].toString(),
                serialBatch: getShelfReqData[i]["serialbatch"].toString(),
                openQty: 1,
                qty: getShelfReqData[i]["shortageQty"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["shortageQty"].toString()),
                inDate: '',
                inType: '',
                mrp: 0,
                sellPrice: 0.0,
                cost: 0,
                taxRate: 0,
                maxdiscount: '',
                liter: getShelfReqData[i]["totalltr"] == null
                    ? 0.0
                    : double.parse(getShelfReqData[i]["totalltr"].toString()),
                weight: getShelfReqData[i]["totalweight"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["totalweight"].toString())));
            qtyCont[scanneditemData.length - 1].text =
                getShelfReqData[i]["shortageQty"] == null
                    ? "0"
                    : getShelfReqData[i]["shortageQty"].toString();
          }
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadMiniMaxmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadMiniMaxbool = false;
        loadMiniMaxmsg = "";
        notifyListeners();
      });
      notifyListeners();
    }
  }

  bool? loadShelfReqbool = false;
  String? loadShelfReqmsg = "";
  loadShelfReqData(ThemeData theme) async {
    if (whssSlectedList == null && scanneditemData.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      loadShelfReqbool = true;
      loadShelfReqmsg = "";
      scanneditemData.clear();
      final Database db = (await DBHelper.getInstance())!;

      List<Map<String, Object?>> getShelfReqData =
          await DBOperation.getShelfReqData(db);
      if (getShelfReqData.isNotEmpty) {
        loadShelfReqbool = false;
        loadShelfReqmsg = "";
        for (int i = 0; i < getShelfReqData.length; i++) {
          if (getShelfReqData[i]["shortageQty"] != 0) {
            scanneditemData.add(StocksnapModelData(
                transID: 1,
                branch: "",
                itemCode: getShelfReqData[i]["Itemcode"].toString(),
                itemName: getShelfReqData[i]["itemname_short"].toString(),
                serialBatch: getShelfReqData[i]["serialbatch"].toString(),
                openQty: 1,
                qty: getShelfReqData[i]["shortageQty"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["shortageQty"].toString()),
                inDate: '',
                inType: '',
                mrp: 0,
                sellPrice: 0.0,
                cost: 0,
                taxRate: 0,
                maxdiscount: '',
                liter: getShelfReqData[i]["totalltr"] == null
                    ? 0.0
                    : double.parse(getShelfReqData[i]["totalltr"].toString()),
                weight: getShelfReqData[i]["totalweight"] == null
                    ? 0
                    : double.parse(
                        getShelfReqData[i]["totalweight"].toString())));
            qtyCont[scanneditemData.length - 1].text =
                getShelfReqData[i]["shortageQty"] == null
                    ? "0"
                    : getShelfReqData[i]["shortageQty"].toString();
          }
        }

        notifyListeners();
        calculateDetails();
      } else {
        scanneditemData = [];
        loadShelfReqmsg = "Does Not Have No data..!!";
        notifyListeners();
      }
      Future.delayed(const Duration(seconds: 5), () {
        loadShelfReqbool = false;
        loadShelfReqmsg = "";
        notifyListeners();
      });
    }
    notifyListeners();
  }

  onseletFst(BuildContext context, ThemeData theme,
      ItemMasterModelDB selectdata) async {
    if (whssSlectedList == null) {
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
                    content: 'Choose warehuse address..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    } else if (whssSlectedList != null) {
      addScannedData2(selectdata, context, theme);
    }
    notifyListeners();
  }

  addScannedData2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) async {
    allselectedData(data);
    if (scanneditemData.isEmpty) {
      onselectedItemasFst(data);
    } else {
      addScndData2(data, context, theme);
    }
    restartFocus(context);
  }

  restartFocus(BuildContext context) {
    searchcon.clear();
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
    inven.requestFocus();
    notifyListeners();
  }

  allselectedData(ItemMasterModelDB data) async {
    getAllSelect.add(data);
    notifyListeners();
  }

  addScndData2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameSerialBatchScnd(
        data.itemcode.toString().toUpperCase().trim());

    if (ins != null) {
      itemIncrement2(data, context, theme);
      notifyListeners();
    } else {
      onselectedItemasFst(data);
      notifyListeners();
    }
    notifyListeners();
  }

  itemIncrement2(
      ItemMasterModelDB data, BuildContext context, ThemeData theme) {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].itemCode == data.itemcode) {
        scanneditemData[i].qty = (scanneditemData[i].qty! + 1);
        qtyCont[i].text = scanneditemData[i].qty.toString();

        notifyListeners();
      }
    }
    calculateDetails();
    notifyListeners();
  }

  itemIncrementClick(int ind, BuildContext context, ThemeData theme) {
    log("getAllSelect: ${getAllSelect.length}");
    for (int i = 0; i < getAllSelect.length; i++) {
      if (getAllSelect[i].isserialBatch == scanneditemData[ind].serialBatch) {
        scanneditemData[ind].qty = scanneditemData[ind].qty! + 1;
        notifyListeners();
      }
    }
    calculateDetails();
    notifyListeners();
  }

  editqty(int indx) {
    log("message");
    if (qtyCont[indx].text.isEmpty || double.parse(qtyCont[indx].text) == 0) {
      scanneditemData.removeAt(indx);
      qtyCont.removeAt(indx);

      notifyListeners();
    } else {
      scanneditemData[indx].qty = double.parse(qtyCont[indx].text);
      notifyListeners();
    }
  }

  double totalLiter() {
    double total = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        total = total +
            (scanneditemData[i].liter! *
                double.parse(scanneditemData[i].qty.toString()));
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
        totalWeight = totalWeight +
            (scanneditemData[i].weight! *
                double.parse(scanneditemData[i].qty.toString()));
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

  onselectedItemasFst(ItemMasterModelDB selectdata) {
    scanneditemData.add(StocksnapModelData(
        tonnage: 1,
        branch: "",
        itemCode: selectdata.itemcode,
        itemName: selectdata.itemnameshort,
        inDate: '',
        inType: '',
        serialBatch: selectdata.isserialBatch,
        openQty: 1,
        qty: 1,
        displayQty: '',
        minimumQty: '',
        mrp: 0,
        sellPrice: 0.0,
        cost: 0,
        taxRate: 0,
        maximumQty: '',
        maxdiscount: '',
        liter: selectdata.liter!,
        weight: selectdata.weight!));
    qtyCont[scanneditemData.length - 1].text = '1';
    notifyListeners();
    calculateDetails();
  }

  scannBAtch(BuildContext context, ThemeData theme) async {
    if (whssSlectedList == null) {
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
                    content: 'Choose warehuse address..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    } else if (whssSlectedList != null) {
      int? indx = await checkBatchAvail(
          mycontroller[0].text.toString().toUpperCase().trim());
      if (indx != null) {
        addScannedData(indx, context, theme);
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
                      content: 'Wrong batch scanned..!!',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    }
  }

  Future<int?> checkBatchAvail(String sBatch) {
    for (int i = 0; i < itemData.length; i++) {
      if (itemData[i].itemCode == sBatch || itemData[i].itemName == sBatch) {
        return Future.value(i);
        break;
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  addScannedData(int ind, BuildContext context, ThemeData theme) async {
    if (scanneditemData.isEmpty) {
      addScndDataFst(ind);
    } else {
      addScndData(ind, context, theme);
    }
  }

  addScndData(int indx, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameSerialBatchScnd(
        mycontroller[0].text.toString().toUpperCase().trim());

    if (ins != null) {
      itemIncrement(ins, context, theme);
      notifyListeners();
    } else {
      addScndDataFst(indx);
      notifyListeners();
    }
    notifyListeners();
  }

  Future<int?> checkSameSerialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].itemCode == sBatch ||
          scanneditemData[i].itemName == sBatch) {
        return Future.value(i);
        break;
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  addScndDataFst(int ind) {
    scanneditemData.add(StocksnapModelData(
        transID: itemData[ind].transID,
        branch: itemData[ind].branch,
        itemCode: itemData[ind].itemCode,
        itemName: itemData[ind].itemName,
        inDate: itemData[ind].inDate,
        inType: itemData[ind].inType,
        serialBatch: itemData[ind].serialBatch,
        openQty: itemData[ind].openQty,
        qty: 1,
        displayQty: itemData[ind].displayQty,
        maximumQty: itemData[ind].maximumQty,
        mrp: itemData[ind].mrp,
        sellPrice: itemData[ind].sellPrice,
        cost: itemData[ind].cost,
        taxRate: itemData[ind].taxRate,
        minimumQty: itemData[ind].minimumQty,
        maxdiscount: '',
        liter: itemData[ind].liter,
        weight: itemData[ind].weight));
    notifyListeners();
    calculateDetails();
  }

  CalCulteStReq? calCulteStReq;
  calculateDetails() {
    if (scanneditemData.isEmpty) {
      CalCulteStReq totalPay =
          CalCulteStReq(qty: 0, totalItem: 0, totalLiter: 0, totalweight: 0);
      calCulteStReq = totalPay;
      notifyListeners();
    } else {
      CalCulteStReq totalPay = CalCulteStReq(
          qty: getNoOfQty(),
          totalItem: double.parse(scanneditemData.length.toString()),
          totalLiter: totalLiter(),
          totalweight: totalWeight());
      calCulteStReq = totalPay;
      notifyListeners();
    }
  }

  double getNoOfQty() {
    double totalqty2 = 0.0;
    if (scanneditemData.isNotEmpty) {
      for (int i = 0; i < scanneditemData.length; i++) {
        if (qtyCont[i].text.isNotEmpty) {
          totalqty2 = totalqty2 +
              double.parse(qtyCont[i].text.isEmpty
                  ? "0.00"
                  : qtyCont[i].text.toString());
        } else {
          totalqty2 = 0.00;
        }
      }

      return totalqty2;
    }
    return 0;
  }

  removeEmptyList(BuildContext context) {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (qtyCont[i].text.isEmpty) {
        qtyCont.removeAt(i);
        scanneditemData.removeAt(i);
      }
    }
  }

  double getNoOfQty2() {
    if (scanneditemData2.isNotEmpty) {
      var getQty =
          scanneditemData2.map((itemdet) => itemdet.openRetQty.toString());
      var getSum = getQty.map(double.parse).toList();
      var totalqty = getSum.reduce((a, b) => a + b);
      return totalqty;
    }
    return 0;
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
    double totalQty = getNoOfQty();
    double totalPrice = getSumPrice();
    double sumTotal = (totalQty * totalPrice);
    return sumTotal;
  }

  double getTotalTax() {
    double totalQty = getNoOfQty();
    double totalPrice = getSumPrice();
    double tax = getSumTotalTax();
    double totalTax = ((totalQty * totalPrice) * (tax / 100));
    return totalTax;
  }

  double getDiscount() {
    return 0;
  }

  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    for (int i = 0; i < itemData.length; i++) {
      if (itemData[i].serialBatch == scanneditemData[ind].serialBatch) {
        scanneditemData[ind].qty = scanneditemData[ind].qty! + 1;
        notifyListeners();
      }
    }
    calculateDetails();
    notifyListeners();
  }

  itemdecrement(int ind) {
    if (scanneditemData[ind].qty! > 1) {
      scanneditemData[ind].qty = scanneditemData[ind].qty! - 1;
      qtyCont[ind].text = scanneditemData[ind].qty.toString();
      notifyListeners();
    } else {
      scanneditemData.removeAt(ind);
      notifyListeners();
    }
    calculateDetails();
  }

  suspendMethodDB(
      BuildContext context, ThemeData theme, String ordertype) async {
    clearSuspendedData(context, theme);
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  clearSuspendedData(BuildContext context, ThemeData theme) {
    onclickDisable = true;
    scanneditemData2.clear();
    scanneditemData.clear();
    fromAddressList2 = null;
    fromAddressList = null;
    whssSlectedList = null;
    whssSlectedList2 = null;
    remarkscontroller2.text = "";
    remarkscontroller.text = "";
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
      onclickDisable = false;
      notifyListeners();

      callList();
      callDB();
      notifyListeners();
    });
  }

  searchclear() {
    seriesVal = [];
    stockReqLines = [];
    searchcon.text = '';
    onclickDisable = false;
    seriesType = '';
    visibleItemList = false;
    selectedcust2 = null;
    cancelbtn = false;
    selectedcust2 = null;
    searchcontroller.text = '';
    selectedcust = null;
    custList = [];
    scanneditemData2.clear();
    scanneditemData.clear();
    fromAddressList2 = null;
    whssSlectedList = null;
    whssSlectedList2 = null;
    holddocentry = '';
    savedraftBill = [];
    remarkscontroller2.text = "";
    remarkscontroller.text = "";
    callList();
  }

  List<Orderdetails> savedraftBill = [];
  Orderdetails? orderDetailsList;

  saveButton(BuildContext context, ThemeData theme, String ordertype) async {
    onclickDisable = true;
    final Database db = (await DBHelper.getInstance())!;
    if (whssSlectedList == null || scanneditemData.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Please Choose All details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
        onclickDisable = false;
        notifyListeners();
      });
    } else if (selectedcust == null) {
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
      onclickDisable = false;
    } else if (whssSlectedList != null && scanneditemData.isNotEmpty) {
      saveValuesTODB(ordertype, whssSlectedList!, db, context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deletereqHold(db, holddocentry.toString());
        await getHoldStReq(db);
      }
      holddocentry = '';
    }

    notifyListeners();
  }

  holdButton(BuildContext context, ThemeData theme) async {
    onclickDisable = true;
    if (whssSlectedList == null) {
      Get.defaultDialog(
              title: "Alert",
              middleText: "Choose WareHouse details..!!",
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
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
        onclickDisable = false;
        notifyListeners();
      });
    } else {
      final Database db = (await DBHelper.getInstance())!;

      saveValuesTODB("hold", whssSlectedList!, db, context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deletereqHold(db, holddocentry.toString());
        await getHoldStReq(db);
      }
      holddocentry = '';
      onclickDisable = false;
    }
    notifyListeners();
  }

  mapCustomer(List<Map<String, Object?>> custData,
      List<Map<String, Object?>> getcustaddd) async {
    final Database db = (await DBHelper.getInstance())!;

    selectedcust = null;
    selectedcust55 = null;
    List<Map<String, Object?>> getholddata =
        await DBOperation.getSalesOrderHeadHoldvalueDB(db);
    selectedcust = CustomerDetals(
      name: custData[0]['customername'].toString(),
      taxCode: custData[0]['taxCode'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      cardCode: custData[0]['customerCode'].toString(),
      accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
    );

    for (int ik = 0; ik < getholddata.length; ik++) {
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

  mapData(List<Orderdetails> orderdetails, int i, BuildContext context,
      ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    searchclear();
    scanneditemData = [];
    onclickDisable = false;
    WhsDetails map_WhsList = WhsDetails(
        dbDocEntry: orderdetails[i].whsAdd!.dbDocEntry,
        whsName: orderdetails[i].whsAdd!.whsName,
        whsCode: orderdetails[i].whsAdd!.whsCode,
        companyName: orderdetails[i].whsAdd!.companyName,
        gitWhs: orderdetails[i].whsAdd!.gitWhs,
        whsPhoNo: orderdetails[i].whsAdd!.whsPhoNo,
        whsmailID: orderdetails[i].whsAdd!.whsmailID,
        whsGst: orderdetails[i].whsAdd!.whsGst,
        whsAddress: orderdetails[i].whsAdd!.whsAddress,
        whsDistric: orderdetails[i].whsAdd!.whsDistric,
        pinCode: orderdetails[i].whsAdd!.pinCode,
        whsState: orderdetails[i].whsAdd!.whsState,
        whsCity: orderdetails[i].whsAdd!.whsCity);
    whssSlectedList = map_WhsList;
    remarkscontroller.text = orderdetails[i].remarks;
    if (orderdetails[i].scannData.isNotEmpty) {
      for (int ij = 0; ij < orderdetails[i].scannData.length; ij++) {
        scanneditemData.add(StocksnapModelData(
          transID: orderdetails[i].scannData[ij].transID,
          branch: orderdetails[i].scannData[ij].branch,
          itemCode: orderdetails[i].scannData[ij].itemCode,
          itemName: orderdetails[i].scannData[ij].itemName,
          serialBatch: orderdetails[i].scannData[ij].serialBatch,
          openQty: orderdetails[i].scannData[ij].openQty,
          qty: orderdetails[i].scannData[ij].qty,
          inDate: orderdetails[i].scannData[ij].inDate,
          inType: orderdetails[i].scannData[ij].inType,
          displayQty: orderdetails[i].scannData[ij].displayQty,
          maxdiscount: orderdetails[i].scannData[ij].maxdiscount,
          mrp: orderdetails[i].scannData[ij].mrp,
          sellPrice: orderdetails[i].scannData[ij].sellPrice,
          cost: orderdetails[i].scannData[ij].cost,
          taxRate: orderdetails[i].scannData[ij].taxRate,
          minimumQty: orderdetails[i].scannData[ij].minimumQty,
          liter: orderdetails[i].scannData[ij].liter == null
              ? 0.0
              : orderdetails[i].scannData[ij].liter,
          weight: orderdetails[i].scannData[ij].weight == null
              ? 0.0
              : orderdetails[i].scannData[ij].weight,
        ));
      }
    }

    for (int ik = 0; ik < scanneditemData.length; ik++) {
      qtyCont[ik].text = scanneditemData[ik].qty.toString();
    }
    holddocentry = whssSlectedList!.dbDocEntry!.toString();
    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, orderdetails[i].cardCode.toString());
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(
            db, orderdetails[i].cardCode.toString());

    calculateDetails();

    notifyListeners();
  }

  Future getItemFromDB(Database db) async {
    List<ItemMasterModelDB> itemMasdata =
        await DBOperation.getItemMasData2(db, "");

    for (int i = 0; i < itemMasdata.length; i++) {
      itemData.add(StocksnapModelData(
          transID: 1,
          branch: "",
          itemCode: itemMasdata[i].itemcode,
          itemName: itemMasdata[i].itemnameshort,
          inDate: '',
          inType: '',
          serialBatch: itemMasdata[i].isserialBatch,
          openQty: 1,
          qty: 1,
          displayQty: '',
          maxdiscount: '',
          mrp: 0,
          sellPrice: 0.0,
          cost: 0,
          taxRate: 0,
          taxCode: '',
          liter: itemMasdata[i].liter!,
          weight: itemMasdata[i].weight!));
    }
  }

  saveValuesTODB(String docstatus, WhsDetails whsDetails, Database db,
      BuildContext context, ThemeData theme) async {
    if (docstatus == "hold") {
      insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    } else if (docstatus == "Save") {
      insdertStockReqdata(docstatus, whsDetails, db, context, theme);
    }
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

    log("datattata doc : ${data.substring(8)}");
    return listdata;
  }

  insdertStockReqdata(String docstatus, WhsDetails whsDetails, Database db,
      BuildContext context, ThemeData theme) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      scanneditemData[i].qty = double.parse(qtyCont[i].text.toString());

      notifyListeners();
    }

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "StockReqHDT");
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
          await DBOperation.generateDocentr(db, "docentry", "StockReqHDT");
    }

    String docmntNo = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 4);

    List<String> getseriesvalue = await checkingdoc(4);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    docmntNo = finlDocnum + documentN0.toString();

    List<StockReqHDTDB> stckReqDB = [];
    stckReqDB.add(StockReqHDTDB(
      doctype: "Stock Request",
      docentry: docEntryCreated.toString(),
      branch: UserValues.branch,
      createdUserID: UserValues.userID,
      createdateTime: config.currentDate(),
      docstatus: docstatus == "suspend"
          ? "0"
          : docstatus == "hold"
              ? '1'
              : docstatus == "Save"
                  ? '3'
                  : "null",
      documentno: docmntNo,
      isagainstorder: '',
      isagainststock: docstatus == "Save" ? "Y" : "N",
      lastupdateIp: UserValues.lastUpdateIp.toString(),
      reqdocno: 0,
      reqdocseries: "null",
      reqdocseriesno: 0,
      reqdoctime: config.currentDate(),
      reqfromWhs: UserValues.branch,
      reqsystime: config.currentDate(),
      reqtoWhs: whsDetails.whsCode,
      reqtransdate: config.currentDate(),
      salesexec: UserValues.salesExce,
      seresid: 0,
      seriesnum: 0,
      sysdatetime: config.currentDate(),
      totalitems: getScanneditemData.length,
      totalltr: totalLiter(),
      totalqty: getNoOfQty(),
      totalweight: totalWeight(),
      transactiondate: config.currentDate(),
      transtime: config.currentDate(),
      updatedDatetime: config.currentDate(),
      updateduserid: UserValues.userID,
      terminal: UserValues.terminal,
      sapDocNo: null,
      sapDocentry: null,
      qStatus: "No",
      remarks: remarkscontroller.text.toString(),
      cardCode: selectedcust!.cardCode ?? '',
      cardName: selectedcust!.name ?? '',
    ));

    List<StockReqLineTDB> stkReqLTDB = [];
    for (int i = 0; i < getScanneditemData.length; i++) {
      if (getScanneditemData[i].qty != 0 ||
          getScanneditemData[i].qty.toString().isNotEmpty) {
        stkReqLTDB.add(StockReqLineTDB(
            createdUserID: UserValues.userID,
            createdateTime: config.currentDate(),
            docentry: 0,
            dscription: getScanneditemData[i].itemName,
            itemcode: getScanneditemData[i].itemCode,
            lastupdateIp: UserValues.userID.toString(),
            lineNo: i,
            qty: double.parse(getScanneditemData[i].qty.toString()),
            status: docstatus == "hold"
                ? '1'
                : docstatus == "Save"
                    ? '3'
                    : "null",
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID,
            price: double.parse(getScanneditemData[i].sellPrice.toString()),
            taxRate: double.parse(getScanneditemData[i].taxRate.toString()),
            taxType: getScanneditemData[i].taxCode,
            serialBatch: getScanneditemData[i].serialBatch,
            branch: UserValues.branch,
            terminal: UserValues.terminal));
      }
    }

    int docEntry = await DBOperation.insertStkReq(db, stckReqDB);
    await DBOperation.updatenextno(db, 4, nextno);
    if (stkReqLTDB.isNotEmpty) {
      await DBOperation.insertStkReqLin(db, stkReqLTDB, docEntry);
    }
    if (docstatus == "Save") {
      bool? netbool = await config.haveInterNet();
      if (netbool == true) {
        await postingStockRequest(
            whsDetails, docstatus, docEntry, context, theme);

        notifyListeners();
      }
    }
    if (docstatus == "hold") {
      await getHoldStReq(db);
      onclickDisable = true;

      whssSlectedList = null;
      remarkscontroller.text = "";
      ShipSelectedList = null;
      calCulteStReq = null;
      mycontroller[0].text = "";
      notifyListeners();
      await Get.defaultDialog(
        title: "Success",
        middleText: docstatus == "hold" ? "Saved as draft" : "null",
        backgroundColor: Colors.white,
        titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
        middleTextStyle: theme.textTheme.bodyLarge,
        radius: 5,
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
      ).then((value) async {
        scanneditemData.clear();
        selectedcust = null;
        onclickDisable = false;
        notifyListeners();
      });
    }
  }

  postingStockRequest(WhsDetails whsDetails, String docstatus, int docEntry,
      BuildContext context, ThemeData theme) async {
    await sapLoginApi(context);
    await postRequestData(whsDetails, docstatus, docEntry, context, theme);
    notifyListeners();
  }

  List<StockReqPostiModel>? stockReqLines = [];
  addReqLinedata(WhsDetails whsDetails) {
    stockReqLines = [];
    for (int i = 0; i < getScanneditemData.length; i++) {
      stockReqLines!.add(StockReqPostiModel(
        currency: "TZS",
        itemDescription: getScanneditemData[i].itemName.toString(),
        itemCode: getScanneditemData[i].itemCode.toString(),
        quantity: getScanneditemData[i].qty!,
        fromWarehouseCode: whsDetails.whsCode!,
        toWarehouseCode: UserValues.branch.toString(),
        lineNum: i,
        gitWarehouseCode: fromAddressList!.gitWhs,
      ));
    }
    notifyListeners();
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

  postRequestData(WhsDetails whsDetails, String docstatus, int docEntryId,
      BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    var uuid = const Uuid();
    String? uuidg = uuid.v1();

    await addReqLinedata(whsDetails);
    PostRequestAPi.cardCodePost = selectedcust!.cardCode;
    PostRequestAPi.fromWarehouse = whsDetails.whsCode;
    PostRequestAPi.gitWarehouse = fromAddressList!.gitWhs;
    PostRequestAPi.uReqWarehouse = UserValues.branch;
    PostRequestAPi.seriesType = seriesType;
    PostRequestAPi.comments = remarkscontroller.text;
    PostRequestAPi.docDate = config.currentDate();
    PostRequestAPi.dueDate = config.currentDate();
    PostRequestAPi.stockTransferLines = stockReqLines;
    PostRequestAPi.method(uuidg);
    notifyListeners();
    await PostRequestAPi.getGlobalData(uuidg).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        await DBOperation.updtSapStkReqHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntryId, 'StockReqHDT');

        scanneditemData.clear();
        whssSlectedList = null;
        remarkscontroller.text = "";
        ShipSelectedList = null;
        calCulteStReq = null;
        mycontroller[0].text = "";
        stockReqLines = [];
        notifyListeners();

        await Get.defaultDialog(
          title: "Success",
          middleText: docstatus == "Save"
              ? "Stock Sucessfully Placed, Document Number $sapDocuNumber"
              : docstatus == "hold"
                  ? "Saved as draft"
                  : "null",
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          radius: 5,
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
        ).then((value) async {
          if (docstatus == "Save") {
            onclickDisable = false;
            Get.offAllNamed(ConstantRoutes.dashboard);

            notifyListeners();
          }

          scanneditemData.clear();
          whssSlectedList = null;
          selectedcust = null;

          remarkscontroller.text = "";
          ShipSelectedList = null;
          calCulteStReq = null;
          mycontroller[0].text = "";
          onclickDisable = false;

          notifyListeners();
        });
      }
      if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        onclickDisable = false;

        await Get.defaultDialog(
          title: "Alert",
          middleText: value.error!.message!.value.toString(),
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          radius: 5,
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
        );
      }
    });
  }

  postRabitMqStockReq(int docentry, String toWhs) async {
    log("From Whs----${UserValues.branch}");
    log("To Whs----$toWhs");

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_SaleReqHeader =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDB_SaleReqLine =
        await DBOperation.getStockLReqHold(db, docentry);
    String salesReqHeader = json.encode(getDB_SaleReqHeader);
    String salesReqLine = json.encode(getDB_SaleReqLine);

    var ddd = json.encode({
      "ObjectType": 4,
      "ActionType": "Add",
      "StockRequestHeader": salesReqHeader,
      "StockRequestLine": salesReqLine,
    });
    log("payload : $ddd");

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

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  postRabitMqStockReq2(int docentry, String toWhs) async {
    log("From Whs----${UserValues.branch}");
    log("To Whs----$toWhs");

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_SaleReqHeader =
        await DBOperation.getStockHDReq(db, docentry);
    List<Map<String, Object?>> getDB_SaleReqLine =
        await DBOperation.getStockLReqHold(db, docentry);
    String salesReqHeader = json.encode(getDB_SaleReqHeader);
    String salesReqLine = json.encode(getDB_SaleReqLine);
    var ddd = json.encode({
      "ObjectType": 4,
      "ActionType": "Add",
      "StockRequestHeader": salesReqHeader,
      "StockRequestLine": salesReqLine,
    });
    log("payload : $ddd");

    Client client = Client();
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

    properties.headers = {"Branch": toWhs};
    exchange.publish(ddd, "", properties: properties);

    client1.close();
  }

  Invoice? invoice = const Invoice();
  List<Address> address2 = [];
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
    onclickDisable = true;

    InventoryReqPrintAPi.docEntry = sapDocentry;
    InventoryReqPrintAPi.slpCode = AppConstant.slpCode;

    InventoryReqPrintAPi.getGlobalData().then((value) {
      notifyListeners();
      if (value == 200) {
        onclickDisable = false;
        notifyListeners();
      } else {
        onclickDisable = false;

        showSnackBar('Try again!!..', context);
      }
    });
    notifyListeners();
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

  mapCallOutwardForPDF(preff, BuildContext context, ThemeData theme) async {
    List<InvoiceItem> itemsList = [];
    invoice = null;

    for (int i = 0; i < scanneditemData2.length; i++) {
      log('scanneditemData2.length:::${scanneditemData2.length}');

      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        descripton: scanneditemData2[i].itemName,
        itemcode: scanneditemData2[i].itemCode,
        unitPrice:
            double.parse(scanneditemData2[i].sellPrice!.toStringAsFixed(2)),
        quantity: double.parse((scanneditemData2[i].openRetQty.toString())),
      ));
      notifyListeners();
    }
    log('itemsList len:::${itemsList.length}');

    invoice = Invoice(
      headerinfo: InvoiceHeader(
          tincode: selectedcust2!.tarNo ?? '',
          vatNo: selectedcust2!.vatregno ?? '',
          ordReference: selectedcust2!.custRefNum ?? '',
          invDate: config.alignDate(selectedcust2!.invoiceDate.toString()),
          invNum: selectedcust2!.invoicenum,
          reqFrom: selectedcust2!.reqFrom,
          reqTo: selectedcust2!.reqTo,
          docEntry: selectedcust2!.docentry,
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
        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
      ),
      items: itemsList,
    );

    notifyListeners();

    ReqPrintLayout.exclTxTotal = 0;
    ReqPrintLayout.vatTx = 0;
    ReqPrintLayout.inclTxTotal = 0;
    log('invoice!.items!.::${invoice!.items!.length}');
    if (invoice!.items!.isNotEmpty) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);

        invoice!.items![i].netTotal = (invoice!.items![i].basic!);

        ReqPrintLayout.exclTxTotal =
            (ReqPrintLayout.exclTxTotal) + (invoice!.items![i].netTotal!);

        ReqPrintLayout.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString());

        notifyListeners();
      }

      ReqPrintLayout.inclTxTotal =
          (ReqPrintLayout.exclTxTotal) + (ReqPrintLayout.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }
      ReqPrintLayout.iinvoicee = invoice;
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
        context, MaterialPageRoute(builder: (context) => ReqPrintLayout()));
    notifyListeners();
  }
}
