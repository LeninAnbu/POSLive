import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Service/Printer/TransferReqPrint.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockInwardBatchModel.dart';
import '../../DBModel/StockinwardHeader.dart';
import '../../DBModel/StockinwardLineData.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/DataModel/StockInwardModel/StockInwardListModel.dart';

import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';
import '../../Models/QueryUrlModel/PendingInwardModel/OpenPendingModel.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/StockOpenOutward.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/InwardPostList.dart';
import '../../Models/ServiceLayerModel/SAPInwardModel/SapInwardModel.dart';
import 'package:intl/intl.dart';
import '../../Pages/PrintPDF/invoice.dart';
import '../../Pages/StockInward/Widgets/InwardPrintDoc.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../Service/QueryURL/CompanyVatTinApi.dart';
import '../../Service/QueryURL/InventoryTransfers/OpenInwardLineApi.dart';
import '../../Service/QueryURL/InventoryTransfers/OpenInwardsApi.dart';
import '../../Service/QueryURL/SoCustomerAddressApi.dart';
import '../../Service/SearchQuery/SearchInwardApi.dart';
import '../../Service/SearchQuery/SearchOutwardLineApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/StockInwardAPI/GetInwardAPI.dart';
import '../../ServiceLayerAPIss/StockInwardAPI/IntwardLoginnAPI.dart';
import '../../ServiceLayerAPIss/StockInwardAPI/InwardCancelAPI.dart';
import '../../ServiceLayerAPIss/StockInwardAPI/InwardPostAPI.dart';
import '../../Widgets/ContentContainer.dart';
import '../../main.dart';

class StockInwrdController extends ChangeNotifier {
  void init() async {
    clearDataAll();
    clear();
    getCustDetFDB();
    await callPendingInwardApi();
    gethold();
  }

  bool selectAll = true;

  List<TextEditingController> sinqtycontroller =
      List.generate(100, (ij) => TextEditingController());
  bool isselect = false;
  String sapDocentry = '';
  String sapDocuNumber = '';
  String frmWhsCode = '';

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool loadingListScrn = false;

  bool cancelbtn = false;
  String? seriesValue;
  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<ErrorModel> sererrorlist = [];
  List<StockTransferInwrddLine> sapInwardModelData = [];
  String? stkreqfromwhs;
  String holddocentry = '';
  ErrorModel? errmodel = ErrorModel();
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
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;
  List<CustomerDetals> custList2 = [];
  isselectmethod() {
    isselect = !isselect;

    log("isselect::::$isselect");
    notifyListeners();
  }

  clear() async {
    stInController2[50].text = "";
    stockInward2.clear();
    stockInward.clear();
    frmWhsCode = '';

    stockOutDATA.clear();
    isselect = false;
    loadingListScrn = false;
    passdata!.clear();
    cancelbtn = false;
    i_value = 0;
    batch_datalist = null;
    batch_i = 0;
    tappage = PageController(initialPage: 0);

    notifyListeners();
  }

  pagePlus() {
    tappageIndex = 0;
    tappage.jumpToPage(1);

    notifyListeners();
  }

  pageminus() {
    tappageIndex = 1;

    tappage.animateToPage(--tappageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linearToEaseOut);
    notifyListeners();
  }

  selecetAllItems(BuildContext context, ThemeData theme) {
    if (selectAll == true) {
      passData(theme, context, get_i_value);

      for (var i = 0; i < passdata!.length; i++) {
        passdata![i].Scanned_Qty = passdata![i].trans_Qty!;
        passdata![i].listClr = true;
      }
      // isselectmethod();
      notifyListeners();
    } else {
      for (var i = 0; i < passdata!.length; i++) {
        passdata![i].Scanned_Qty = 0;
        passdata![i].listClr = false;
      }
    }
    notifyListeners();
  }

  clearDataAll() {
    page = PageController(initialPage: 0);
    tappage = PageController(initialPage: 0);
    pageIndex = 0;
    seriesType = '';
    selectedcust2 = null;
    searchLoading = false;
    sapDocentry = '';
    sapDocuNumber = '';
    sapStockReqdocnum = '';
    sapStockReqdocentry = '';
    seriesVal = [];
    selectAll = true;
    searchcontroller.text = '';
    selectedcust = null;
    selectedcust2 = null;
    custList = [];
    custList2 = [];
    filtercustList = [];
    tappageIndex = 0;
    stInController2[50].text = "";
    passdata = [];
    stockInward = [];
    selectIndex = null;
    onClickDisable = false;
    loadingListScrn = false;
    notifyListeners();
  }

  deletereq() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.deletereq(db);
    notifyListeners();
  }

  Configure config = Configure();

  PageController page = PageController(initialPage: 0);
  PageController tappage = PageController(initialPage: 0);

  int pageIndex = 0;
  int tappageIndex = 0;
  bool onDisablebutton = false;

  List<TextEditingController> stInController =
      List.generate(150, (i) => TextEditingController());

  List<TextEditingController> stInController2 =
      List.generate(150, (i) => TextEditingController());

  int i_value = 0;
  int get get_i_value => i_value;
  double scannigVal = 0;
  double get getScannigVal => scannigVal;
  int scannedVal = 0;
  int get getScannedVal => scannedVal;
  int? selectIndex;
  int selectIndex2 = 0;
  String? msg = '';
  bool? onClickDisable = false;
  bool? onScanDisable = false;

  selectindex(int i) {
    selectIndex = i;
    notifyListeners();
  }

  selectindex2(int i) {
    selectIndex2 = i;
    notifyListeners();
  }

  List<List<String>>? test2;
  int scannvalue2 = 0;

  searchInitMethod() {
    stInController[100].text = config.alignDate(config.currentDate());
    stInController[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  List<searchModel> searchData = [];

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

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchInwData
          .where((e) =>
              e.docEntry.toString().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchInwData;
      notifyListeners();
    }
  }

  bool searchbool = false;
  TextEditingController searchcontroller = TextEditingController();
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

  refresCufstList() async {
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
    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    // await CustCreditLimitAPi.getGlobalData(customerDetals.cardCode.toString())
    //     .then((value) {
    //   if (value.statuscode >= 200 && value.statuscode <= 210) {
    //     if (value.creditLimitData != null) {
    //       // log('xxxxxxxx::${value.creditLimitData![0].creditLine.toString()}');

    //       selectedcust!.creditLimits =
    //           double.parse(value.creditLimitData![0].creditLine.toString());
    //       notifyListeners();
    //     }
    //   }
    // });

    // await CustCreditDaysAPI.getGlobalData(customerDetals.cardCode.toString())
    //     .then((value) {
    //   if (value.statuscode >= 200 && value.statuscode <= 210) {
    //     if (value.creditDaysData != null) {
    //       // log('yyyyyyyyyy::${value.creditDaysData![0].creditDays.toString()}');

    //       selectedcust!.creditDays =
    //           value.creditDaysData![0].creditDays.toString();
    //       selectedcust!.paymentGroup =
    //           value.creditDaysData![0].paymentGroup.toString().toLowerCase();
    //       log('selectedcust paymentGroup::${selectedcust!.paymentGroup!}');
    //       if (selectedcust!.paymentGroup!.contains('cash') == true) {
    //         selectedcust!.name = '';
    //       } else {
    //         selectedcust!.name = customerDetals.name!;
    //       }
    //       log('Cash paymentGroup::${selectedcust!.paymentGroup!.contains('cash')}');
    //       notifyListeners();
    //     }
    //     loadingscrn = false;
    //   }
    // });
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

    notifyListeners();
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockinHeader =
        await DBOperation.getStockInHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    if (getStockinHeader.isNotEmpty) {
      for (int i = 0; i < getStockinHeader.length; i++) {
        searchdata2.add(searchModel(
            username: UserValues.username,
            terminal: AppConstant.terminal,
            qStatus: getStockinHeader[i]["qStatus"] == null
                ? ""
                : getStockinHeader[i]["qStatus"].toString(),
            docentry: getStockinHeader[i]["docentry"] == null
                ? 0
                : int.parse(getStockinHeader[i]["docentry"].toString()),
            docNo: getStockinHeader[i]["reqdocno"] == null
                ? "0"
                : getStockinHeader[i]["reqdocno"].toString(),
            docDate: getStockinHeader[i]["createdateTime"].toString(),
            sapNo: getStockinHeader[i]["sapDocNo"] == null
                ? 0
                : int.parse(getStockinHeader[i]["sapDocNo"].toString()),
            sapDate: getStockinHeader[i]["createdateTime"] == null
                ? ""
                : getStockinHeader[i]["createdateTime"].toString(),
            customeraName: getStockinHeader[i]["reqtoWhs"] == null
                ? ""
                : getStockinHeader[i]["reqtoWhs"].toString(),
            doctotal: getStockinHeader[i][""] == null
                ? 0
                : double.parse(getStockinHeader[i][""].toString())));
        notifyListeners();
      }
      searchData.addAll(searchdata2);
      // filtersearchData = searchData;
    } else {
      searchbool = false;
      searchData.clear();
      notifyListeners();
    }
    notifyListeners();
  }

  List<OpenSalesReqHeadersModlData> searchInwData = [];
  List<OpenSalesReqHeadersModlData> filtersearchData = [];
  String u_RequestWhs = '';
  callsearchInwApi() async {
    u_RequestWhs = '';
    searchInwData = [];
    filtersearchData = [];
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> branchdata =
        await DBOperation.getBrnachbyCode(db, AppConstant.branch);

    await SerachInwardHeaderAPi.getGlobalData(
            config.alignDate2(stInController[100].text.toString()),
            config.alignDate2(stInController[101].text.toString()),
            branchdata[0]['GITWhs'].toString())
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('ffffff');
        searchInwData = value.activitiesData!;
        filtersearchData = searchInwData;
        if (searchInwData.isNotEmpty) {
          sapDocentry = searchInwData[0].docEntry.toString();
          u_RequestWhs = searchInwData[0].uwhsCode;
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  bool searchLoading = false;

  callSearchLine(String docEntry, int index) async {
    stockInward2.clear();
    stInController2[50].text = "";
    sapDocentry = '';
    sapDocuNumber = '';
    List<StockInwardList> stockOutDATA2 = [];
    List<StockInwardDetails> stockDetails2 = [];

    sapDocentry = filtersearchData[index].docEntry.toString();
    u_RequestWhs = filtersearchData[index].uwhsCode;

    selectedcust2 = CustomerDetals(
        name: filtersearchData[index].cardName,
        cardCode: filtersearchData[index].cardCode,
        accBalance: 0,
        invoiceDate: filtersearchData[index].docDate,
        invoicenum: filtersearchData[index].docNum.toString(),
        email: '',
        phNo: '');

    await searchOutWardLineAPi.getGlobalData(docEntry).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('Step1::${value.openOutwardData!.length}');
        if (value.openOutwardData!.isNotEmpty) {
          for (var i = 0; i < value.openOutwardData!.length; i++) {
            List<StockInSerialbatch> stoutSeralBatchList = [];
            stockDetails2.add(StockInwardDetails(
                createdUserID: 1,
                baseDocNum: '',
                createdateTime: '',
                baseDocentry: value.openOutwardData![i].docEntry,
                docentry: value.openOutwardData![i].docEntry,
                dscription: value.openOutwardData![i].description,
                itemcode: value.openOutwardData![i].itemCode,
                lastupdateIp: "",
                lineNo: value.openOutwardData![i].batchLine,
                qty: value.openOutwardData![i].qty,
                status: '',
                updatedDatetime: '',
                updateduserid: 1,
                price: value.openOutwardData![i].price,
                serialBatch: value.openOutwardData![i].batchNum,
                taxRate: 0.0,
                taxType: "",
                trans_Qty: value.openOutwardData![i].batchQty,
                // Scanned_Qty:,
                baseDocline: value.openOutwardData![i].batchLine,
                serialbatchList: stoutSeralBatchList));
          }
          stInController2[50].text =
              filtersearchData[index].comments.toString();
          stockOutDATA2.add(StockInwardList(
              cardCode: filtersearchData[index].cardCode,
              remarks: filtersearchData[index].comments.toString(),
              branch: AppConstant.branch,
              docentry: filtersearchData[index].docEntry.toString(),
              baceDocentry: filtersearchData[index].docEntry.toString(),
              docstatus: '',
              documentno: filtersearchData[index].docNum.toString(),
              reqfromWhs: filtersearchData[index].fromWhs,
              reqtoWhs: filtersearchData[index].fromWhs,
              reqtransdate: filtersearchData[index].docDate.toString(),
              data: stockDetails2));
          sapDocentry = filtersearchData[index].docEntry.toString();
          sapDocuNumber = filtersearchData[index].docNum.toString();
          stockInward2.addAll(stockOutDATA2);
          searchLoading = false;
          log('filtersearchData[index].toWhsCode::${filtersearchData[index].toWhsCode}');
          notifyListeners();
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        searchLoading = false;
        notifyListeners();
      } else {
        searchLoading = false;
        notifyListeners();
      }
    });
    Get.back();
    notifyListeners();
  }

  List<OpenStkOutwardModlData> openStockOutList = [];
  List<OpenStockOutLineModlData> lineData = [];
  callPendingInwardApi() async {
    stockInward = [];
    loadingscrn = true;
    log('kkkkkkkkkk');
    await OpenInwardAPi.getGlobalData(
      AppConstant.branch,
    ).then((value) async {
      log('kkkkkkkkkk22222');
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        stockInward = [];
        openStockOutList = value.activitiesData!;
        log('openStockOutListopenStockOutList::${openStockOutList.length}');
        loadingscrn = false;
        dbDataTrue = false;
        if (openStockOutList.isNotEmpty) {
          for (var i = 0; i < openStockOutList.length; i++) {
            log('openStockOutList[i].fromwhsCode::${openStockOutList[i].fromwhsCode}::::${openStockOutList[i].tomwhsCode}');
            stockInward.add(StockInwardList(
              cardCode: openStockOutList[i].cardCode,
              branch: AppConstant.branch,
              docentry: openStockOutList[i].docEntry.toString(),
              documentno: openStockOutList[i].docNum.toString(),
              reqfromWhs: openStockOutList[i].fromwhsCode,
              data: [],
              baceDocentry: openStockOutList[i].docEntry.toString(),
              reqtransdate: openStockOutList[i].docDate,
            ));
            notifyListeners();
          }
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
        dbDataTrue = true;
      } else {
        loadingscrn = false;
        dbDataTrue = true;
      }
    });
    log('stockInwardstockInward length::${stockInward.length}');
    notifyListeners();
  }

  callInwardLineApi(String docEntry, String cardCode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    List<StockInwardDetails> listData = [];
    List<StOutSerialbatch> batchlistData = [];
    passdata = [];
    loadingListScrn = true;
    for (var ij = 0; ij < stockInward.length; ij++) {
      stockInward[ij].data = [];
      notifyListeners();
    }

    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(db, cardCode.toString());

    selectedcust = CustomerDetals(
      name: getcustomer[0]['customername'].toString(),
      phNo: getcustomer[0]['phoneno1'].toString(),
      taxCode: getcustomer[0]['TaxCode'].toString(),
      cardCode: getcustomer[0]['customerCode'].toString(),
      point: getcustomer[0]['points'].toString(),
      custRefNum: '',
      accBalance: 0,
      email: getcustomer[0]['emalid'].toString(),
      tarNo: getcustomer[0]['taxno'].toString(),
      autoId: getcustomer[0]['autoid'].toString(),
    );
    notifyListeners();
    await OpenInWardLineAPi.getGlobalData(docEntry).then((value) {
      listData = [];
      batchlistData = [];

      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        lineData = value.openOutwardData!;
        for (var i = 0; i < lineData.length; i++) {
          for (var ij = 0; ij < stockInward.length; ij++) {
            if (stockInward[ij].docentry.toString() ==
                lineData[i].docEntry.toString()) {
              frmWhsCode = lineData[i].towhsCode;
              batchlistData = [];
              batchlistData.add(StOutSerialbatch(
                  lineno: lineData[i].batchLine.toString(),
                  docentry: lineData[i].docEntry.toString(),
                  baseDocentry: lineData[i].docEntry.toString(),
                  itemcode: lineData[i].itemCode,
                  qty: lineData[i].qty,
                  serialbatch: lineData[i].batchNum));
              listData.add(StockInwardDetails(
                  baseDocNum: '',
                  baseDocline: lineData[i].batchLine,
                  docentry: lineData[i].docEntry,
                  dscription: lineData[i].description,
                  itemcode: lineData[i].itemCode,
                  lineNo: lineData[i].batchLine,
                  qty: lineData[i].requestQty,
                  frmWhs: lineData[i].frmWhs,
                  listClr: false,
                  towhs: lineData[i].towhsCode,
                  baseDocentry: lineData[i].docEntry,
                  price: lineData[i].price,
                  StOutSerialbatchList: batchlistData,
                  serialBatch: lineData[i].batchNum,
                  trans_Qty: lineData[i].batchQty,
                  Scanned_Qty: 0));
              notifyListeners();
            }
            stockInward[ij].data = listData;

            // passdata = listData;

            for (var i = 0; i < stockInward[ij].data!.length; i++) {
              log('stockInward[ij].data ::${stockInward[ij].data![i].StOutSerialbatchList!.length}');
            }
            notifyListeners();
          }

          notifyListeners();
        }

        loadingListScrn = false;

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingListScrn = false;
      } else {
        loadingListScrn = false;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<StockInwardList> stockInward2 = [];

  fixDataMethod(int docentry) async {
    stockInward2.clear();
    stInController2[50].text = "";
    sapDocentry = '';
    sapDocuNumber = '';
    if (isselect == true) {
      isselect = false;
    }
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBstInHeader =
        await DBOperation.getStockInHeader(db, docentry);
    List<Map<String, Object?>> getDBStInLine =
        await DBOperation.stInLineDB(db, docentry);
    List<StockInwardList> stockOutDATA2 = [];
    List<StockInwardDetails> stockDetails2 = [];
    for (int j = 0; j < getDBStInLine.length; j++) {
      List<StockInSerialbatch> stoutSeralBatchList = [];

      stockDetails2.add(StockInwardDetails(
          baseDocNum: '',
          createdUserID: 1,
          createdateTime: getDBStInLine[j]["createdateTime"].toString(),
          baseDocentry: int.parse(getDBStInLine[j]["baseDocentry"].toString()),
          docentry: int.parse(getDBStInLine[j]["docentry"].toString()),
          dscription: getDBStInLine[j]["description"].toString(),
          itemcode: getDBStInLine[j]["itemcode"].toString(),
          lastupdateIp: "",
          lineNo: getDBStInLine[j]["lineno"] == null
              ? 0
              : int.parse(getDBStInLine[j]["lineno"].toString()),
          qty: getDBStInLine[j]["quantity"] == null
              ? 0
              : double.parse(getDBStInLine[j]["quantity"].toString()),
          status: getDBStInLine[j]["createdateTime"].toString(),
          updatedDatetime: getDBStInLine[j]["createdateTime"].toString(),
          updateduserid: 1,
          price: 1,
          serialBatch: getDBStInLine[j]["serialBatch"].toString(),
          taxRate: 0.0,
          taxType: "",
          trans_Qty: getDBStInLine[j]["transferQty"] == null
              ? 0
              : double.parse(getDBStInLine[j]["transferQty"].toString()),
          Scanned_Qty: getDBStInLine[j]["scannedQty"] == null
              ? 0
              : double.parse(getDBStInLine[j]["scannedQty"].toString()),
          baseDocline: getDBStInLine[j]["baseDocline"] == null
              ? 0
              : int.parse(getDBStInLine[j]["baseDocline"].toString()),
          serialbatchList: stoutSeralBatchList));
    }
    stInController2[50].text = getDBstInHeader[0]["remarks"].toString();
    stockOutDATA2.add(StockInwardList(
        remarks: getDBstInHeader[0]["remarks"].toString(),
        branch: getDBstInHeader[0]["branch"].toString(),
        docentry: getDBstInHeader[0]["docentry"].toString(),
        baceDocentry: getDBstInHeader[0]["baceDocentry"].toString(),
        docstatus: getDBstInHeader[0]["baceDocentry"].toString(),
        documentno: getDBstInHeader[0]["sapDocNo"] == null
            ? "0"
            : getDBstInHeader[0]["sapDocNo"].toString(),
        reqfromWhs: getDBstInHeader[0]["reqfromWhs"].toString(),
        reqtoWhs: getDBstInHeader[0]["reqtoWhs"].toString(),
        reqtransdate: getDBstInHeader[0]["transdate"].toString(),
        data: stockDetails2));
    sapDocentry = getDBstInHeader[0]["sapDocentry"].toString();
    sapDocuNumber = getDBstInHeader[0]["sapDocNo"].toString();
    stockInward2.addAll(stockOutDATA2);
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      stInController[100].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      stInController[101].text = datetype!;
    } else {}
  }

  Future stInLineRefersh(
      int index, int list_i, List<StockInSerialbatch>? serialbatchList2) async {
    double totalscannedQty = 0;
    if (stockInward[index].data![list_i].serialbatchList != null) {
      for (int i = 0;
          i < stockInward[index].data![list_i].serialbatchList!.length;
          i++) {
        totalscannedQty = totalscannedQty +
            stockInward[index].data![list_i].serialbatchList![i].qty!;
      }
      stockInward[index].data![list_i].serialbatchList = serialbatchList2;
      stockInward[index].data![list_i].Scanned_Qty = totalscannedQty;
    }

    stInController[0].clear();
    notifyListeners();
  }

  setstatemethod() {
    notifyListeners();
  }

  passData(ThemeData theme, BuildContext context, int index) {
    // log("stockInward[index].data! length:${stockInward[index].data![0].StOutSerialbatchList!.length}");
    passdata = [];
    if (stockInward[index].data!.isNotEmpty) {
      selectIndex = index;
      i_value = index;

      passdata = stockInward[index].data!;
      for (var i = 0; i < passdata!.length; i++) {
        log('passdatapassdata::${passdata![i].StOutSerialbatchList!.length}');
      }
      notifyListeners();
    }

    notifyListeners();
  }

  Future scanqtyRemove(int index, int list_i, int batchI) async {
    final Database db = (await DBHelper.getInstance())!;

    if (stockInward[index].data![list_i].trans_Qty! !=
        stockInward[index].data![list_i].serialbatchList![batchI].qty!) {
      stockInward[index].data![list_i].serialbatchList![batchI].qty =
          stockInward[index].data![list_i].serialbatchList![batchI].qty! - 1;
      msg = "";
      notifyListeners();
      if (stockInward[index].data![list_i].serialbatchList![batchI].qty! == 0) {
        await DBOperation.deleteBatchStIn(
            db,
            int.parse(stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .baseDocentry!
                .toString()),
            int.parse(stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .lineno
                .toString()),
            stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .itemcode
                .toString());
        stockInward[index].data![list_i].serialbatchList!.removeAt(batchI);
      } else if (stockInward[index]
              .data![list_i]
              .serialbatchList![batchI]
              .qty! >=
          1) {
        await DBOperation.updateQTYBatchsStIn(
            db,
            int.parse(stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .baseDocentry!
                .toString()),
            int.parse(stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .lineno
                .toString()),
            stockInward[index]
                .data![list_i]
                .serialbatchList![batchI]
                .itemcode
                .toString());
      }
    } else if (stockInward[index].data![list_i].trans_Qty ==
        stockInward[index].data![list_i].serialbatchList![batchI].qty) {
      msg = 'Alreaty This Item is Submited...!!';
    }
    notifyListeners();
  }

  int qqqttyy = 0;
  qqqqq(int index, String serialBatch, int list_i, String itemcode, im) {
    qqqttyy = 0;
    for (int im = 0;
        im < stockInward[index].data![list_i].serialbatchList!.length;
        im++) {
      if (stockInward[index].data![list_i].itemcode ==
          stockInward[index].data![list_i].serialbatchList![im].itemcode) {
        qqqttyy = qqqttyy + int.parse(sinqtycontroller[im].text);

        notifyListeners();
      }
    }
    notifyListeners();
  }

  stkInEditQty(
      int index, String serialBatch, int list_i, String itemcode, im) async {
    msg = '';
    log("serialbatchList MM::${stockInward[index].data![list_i].trans_Qty}");
    if (int.parse(sinqtycontroller[im].text) != 0) {
      int editqqty = int.parse(sinqtycontroller[im].text);
      qqqqq(index, serialBatch, list_i, itemcode, im);

      if (qqqttyy <= stockInward[index].data![list_i].trans_Qty!) {
        sinqtycontroller[im].text = editqqty.toString();
        stockInward[get_i_value].data![batch_i!].serialbatchList![im].qty =
            int.parse(sinqtycontroller[im].text);

        notifyListeners();
      } else {
        sinqtycontroller[im].text = 1.toString();
        stockInward[get_i_value].data![batch_i!].serialbatchList![im].qty = 1;
        msg = "No Qty Does Not Have...!!";

        notifyListeners();
      }
    } else {
      sinqtycontroller.removeAt(im);
      stockInward[index].data![list_i].serialbatchList!.removeAt(im);
      notifyListeners();
    }

    notifyListeners();
  }

  scanmethod(int index, StockInwardDetails? data, int list_i) async {
    onScanDisable = true;
    String serialBatch = "";
    double qty = 0;

    if (stInController[0].text.isNotEmpty) {
      for (int k = 0; k < data!.StOutSerialbatchList!.length; k++) {
        if (data.StOutSerialbatchList![k].serialbatch ==
            stInController[0].text.trim()) {
          serialBatch = data.StOutSerialbatchList![k].serialbatch.toString();
          qty = data.StOutSerialbatchList![k].qty!;
        }
      }

      // if (serialBatch.isNotEmpty) {
      int totalscanqty = 0;

      if (stockInward[index].data![list_i].serialbatchList != null) {
        bool alreadyScan = false;
        int alreadyScanQty = 0;
        for (int i = 0;
            i < stockInward[index].data![list_i].serialbatchList!.length;
            i++) {
          totalscanqty = totalscanqty +
              stockInward[index].data![list_i].serialbatchList![i].qty!;
          log('totalscanqtytotalscanqty::$totalscanqty');
          if (serialBatch ==
              stockInward[index]
                  .data![list_i]
                  .serialbatchList![i]
                  .serialbatch) {
            alreadyScan = true;
            alreadyScanQty =
                stockInward[index].data![list_i].serialbatchList![i].qty!;
          }
          notifyListeners();
        }

        if (stockInward[index].data![list_i].trans_Qty! >= totalscanqty) {
          if (alreadyScan == true) {
            if (alreadyScanQty < qty) {
              for (int k = 0;
                  k < stockInward[index].data![list_i].serialbatchList!.length;
                  k++) {
                if (serialBatch ==
                    stockInward[index]
                        .data![list_i]
                        .serialbatchList![k]
                        .serialbatch) {
                  stockInward[index].data![list_i].serialbatchList![k].qty =
                      stockInward[index]
                              .data![list_i]
                              .serialbatchList![k]
                              .qty! +
                          1;
                  sinqtycontroller[k].text =
                      (int.parse(sinqtycontroller[k].text.toString()) + 1)
                          .toString();

                  notifyListeners();
                }
                notifyListeners();
              }
            } else {
              // msg = 'Please Scan Other SerialBatch...!!';
            }
            notifyListeners();
          } else {
            stockInward[index]
                .data![list_i]
                .serialbatchList!
                .add(StockInSerialbatch(
                  lineno: stockInward[index].data![list_i].lineNo.toString(),
                  itemName:
                      stockInward[index].data![list_i].dscription.toString(),
                  baseDocentry:
                      stockInward[index].data![list_i].baseDocentry.toString(),
                  itemcode: stockInward[index].data![list_i].itemcode,
                  qty: 1,
                  serialbatch: serialBatch.toString().trim(),
                  docstatus: null,
                  docentry:
                      stockInward[index].data![list_i].docentry.toString(),
                ));
            for (int im = 0;
                im < stockInward[index].data![list_i].serialbatchList!.length;
                im++) {
              sinqtycontroller[im].text = stockInward[index]
                  .data![list_i]
                  .serialbatchList![im]
                  .qty!
                  .toString();
            }
            notifyListeners();
          }
        } else {
          msg = 'No More Qty to add...!!';
          for (int im = 0;
              im < stockInward[index].data![list_i].serialbatchList!.length;
              im++) {
            sinqtycontroller[im].text = 1.toString();
          }
        }
      } else {
        List<StockInSerialbatch> stInBatch = [];
        stInBatch.add(StockInSerialbatch(
          lineno: stockInward[index].data![list_i].lineNo.toString(),
          baseDocentry:
              stockInward[index].data![list_i].baseDocentry.toString(),
          itemcode: stockInward[index].data![list_i].itemcode,
          itemName: stockInward[index].data![list_i].dscription,
          qty: 1,
          serialbatch: serialBatch.toString().trim(),
          docstatus: null,
          docentry: stockInward[index].data![list_i].docentry.toString(),
        ));
        stockInward[index].data![list_i].serialbatchList = stInBatch;
        for (int im = 0;
            im < stockInward[index].data![list_i].serialbatchList!.length;
            im++) {
          sinqtycontroller[im].text = stockInward[index]
              .data![list_i]
              .serialbatchList![im]
              .qty!
              .toString();
        }
      }
      // } else {
      //   msg = 'Wrong BatchCode Scan...!!';
      // }

      notifyListeners();
    } else {
      msg = "Please Enter the Scancode..";
    }
    onScanDisable = false;
    stInController[0].clear();
    notifyListeners();
  }

  suspendedbutton(int index, BuildContext context, ThemeData theme,
      List<StockInwardDetails>? data, StockInwardList? datatotal) async {
    double? scannedtottal = 0;
    double? totalReqQty = 0;
    double? totalTransQty = 0;

    for (int i = 0; i < data!.length; i++) {
      scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
      totalTransQty = totalTransQty! + data[i].trans_Qty!;
      totalReqQty = totalReqQty! + data[i].qty!;
      notifyListeners();
    }
    passdata = [];
    sapStockReqdocnum = '';
    sapStockReqdocentry = '';
    savedraftBill = [];
    selectAll = true;
    gethold();
    callPendingInwardApi();

    if (scannedtottal == 0) {
      Get.defaultDialog(
          title: "Alert",
          middleText: 'Items Already Suspended..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
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
          radius: 5);
    } else if (scannedtottal != 0) {
      if (stockInward.isNotEmpty) {
        for (int i = 0; i < stockInward[index].data!.length; i++) {
          stockInward[index].data![i].Scanned_Qty = 0;
          stockInward[index].data![i].serialbatchList = [];
          notifyListeners();
        }
        i_value = index;
      }
    }
    notifyListeners();
  }

  submitbutton(int index, BuildContext context, ThemeData theme,
      List<StockInwardDetails>? data, StockInwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;

    onClickDisable = true;
    if (data!.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Please Select Items..!!',
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
        onClickDisable = false;
        notifyListeners();
      });
    } else if (selectedcust == null) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Please Select Customer..!!',
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
        onClickDisable = false;
        notifyListeners();
      });
    } else {
      double? scannedtottal = 0;
      double? totalTransQty = 0;
      double? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        scannedtottal =
            scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
        totalTransQty = totalTransQty! + data[i].trans_Qty!;
        totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
        notifyListeners();
      }

      if (totalscanqty == 0) {
        Get.defaultDialog(
                title: "Alert",
                middleText: 'Please Select Items..!!',
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
          onClickDisable = false;
          notifyListeners();
        });
      } else if (totalscanqty != totalTransQty) {
        Get.defaultDialog(
                title: "Alert",
                middleText: 'Please Scan All Items..!!',
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
          onClickDisable = false;
          notifyListeners();
        });
      } else if (totalscanqty == totalTransQty) {
        await DBOperation.deletAlreadyHoldDataStIN(
            db, int.parse(stockInward[index].baceDocentry.toString()));

        savepartialData('submit', context, theme, index, data, datatotal);
      }
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

  savepartialData(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockInwardDetails>? data,
      StockInwardList? datatotal) async {
    onClickDisable = true;
    final Database db = (await DBHelper.getInstance())!;
    List<StockInHeaderDataDB> stInHeader = [];
    List<StockInLineDataDB> stInLine = [];

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "StockInHeaderDB");
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
          await DBOperation.generateDocentr(db, "docentry", "StockInHeaderDB");
    }

    String docmntNo = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 6);

    List<String> getseriesvalue = await checkingdoc(6);

    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    docmntNo = finlDocnum + documentN0.toString();
    log('tockInward[index].baceDocentry.::${stockInward[index].baceDocentry.toString()}');
    List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
        db,
        int.parse(stockInward[index].baceDocentry.toString()),
        'StockReqHDT');

    log("stockInward[index].reqfromWhs:::${stockInward[index].reqfromWhs}");

    stInHeader.add(StockInHeaderDataDB(
        cardCode: selectedcust!.cardCode ?? '',
        cardName: selectedcust!.name ?? '',
        documentno: docmntNo.toString(),
        branch: UserValues.branch,
        docentry: docEntryCreated.toString(),
        baseDocentry: stockInward[index].docentry,
        createdUserID: UserValues.userID,
        createdateTime: config.currentDate(),
        docstatus: '3',
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: stockInward[index].reqdocumentno.toString(),
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: stockInward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: stockInward[index].reqtoWhs,
        transdate: config.currentDate(),
        salesexec: "",
        totalitems: 0,
        totalltr: 0,
        totalqty: 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        terminal: UserValues.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: sapStockReqdocentry,
        // sapdetails.isEmpty ? "" : sapdetails[0]['sapDocentry'].toString(),
        sapStockReqdocnum: sapStockReqdocnum,
        // sapdetails.isEmpty ? "" : sapdetails[0]['sapDocNo'].toString(),
        remarks: stInController[50].text.toString()));
    int? docentry2 = await DBOperation.insertStockInheader(db, stInHeader);
    await DBOperation.updatenextno(db, 6, nextno);
    stockInward[index].data = passdata;
    for (int i = 0; i < stockInward[index].data!.length; i++) {
      List<StockInBatchDataDB>? stInbatch = [];

      await DBOperation.deletAlreadyHoldDataLineSTIN(
          db,
          int.parse(stockInward[index].baceDocentry.toString()),
          stockInward[index].data![i].itemcode.toString());

      if (stockInward[index].data![i].serialbatchList != null) {
        if (stockInward[index].data![i].docentry != null) {
          await DBOperation.deleteBatch(
            db,
            int.parse(stockInward[index].data![i].baseDocentry.toString()),
            int.parse(stockInward[index].data![i].docentry.toString()),
            stockInward[index].data![i].itemcode!,
          );
        }
        // log('stockInward[index].data![i].serialbatchList::${stockInward[index].data![i].serialbatchList!.length}');
        for (int l = 0;
            l < stockInward[index].data![i].StOutSerialbatchList!.length;
            l++) {
          stInbatch.add(StockInBatchDataDB(
              lineno: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![l]
                  .lineno
                  .toString(),
              baseDocentry: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![l]
                  .docentry
                  .toString(),
              itemcode: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![l]
                  .itemcode
                  .toString(),
              qty: stockInward[index].data![i].StOutSerialbatchList![l].qty ==
                      null
                  ? 0
                  : double.parse(stockInward[index]
                      .data![i]
                      .StOutSerialbatchList![l]
                      .qty
                      .toString()),
              serialbatch: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![l]
                  .serialbatch
                  .toString(),
              docentry: docentry2.toString(),
              docstatus: ''));
        }
      }
      await DBOperation.insertStInBatch(db, stInbatch);

      stInLine.add(StockInLineDataDB(
          lineno: stockInward[index].data![i].lineNo.toString(),
          docentry: docentry2.toString(),
          itemcode: stockInward[index].data![i].itemcode.toString(),
          description: stockInward[index].data![i].dscription,
          qty: double.parse(stockInward[index].data![i].qty.toString()),
          baseDocentry: stockInward[index].data![i].docentry.toString(),
          baseDocline: stockInward[index].data![i].lineNo.toString(),
          status: stockInward[index].data![i].status,
          traansferQty: stockInward[index].data![i].Scanned_Qty,
          scannedQty: stockInward[index].data![i].Scanned_Qty,
          serialBatch: stockInward[index].data![i].serialBatch,
          branch: UserValues.branch,
          terminal: UserValues.terminal));
    }

    await DBOperation.insertStInLine(db, stInLine);

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      postingStockInward(
          docstatus,
          docentry2!,
          index,
          int.parse(stockInward[index].docentry!),
          data,
          datatotal,
          context,
          theme);
    }

    notifyListeners();
  }

  postingStockInward(
      String docstatus,
      int docEntry,
      int index,
      int baseentry,
      List<StockInwardDetails>? data,
      StockInwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    await sapLoginApi(context);
    await postInwardData(
        docstatus, docEntry, index, baseentry, data, datatotal, context, theme);
    notifyListeners();
  }

  List<StockInLineModel>? stockInwardLines = [];
  List<StockInbatch>? batchTable;
  addBatchtable(int index, int ik) {
    batchTable = [];
    for (int i = 0; i < passdata![ik].StOutSerialbatchList!.length; i++) {
      batchTable!.add(StockInbatch(
        quantity: double.parse(passdata![ik].Scanned_Qty.toString()),
        batchNumberProperty:
            passdata![ik].StOutSerialbatchList![i].serialbatch.toString(),
      ));
    }
    notifyListeners();
    log('message::${batchTable!.length}');
  }

  addOutLinedata(int index) {
    stockInwardLines = [];
    for (int i = 0; i < stockInward[index].data!.length; i++) {
      addBatchtable(index, i);
      stockInwardLines!.add(StockInLineModel(
        fromWarehouseCode: frmWhsCode,
        itemCode: stockInward[index].data![i].itemcode.toString(),
        itemDescription: stockInward[index].data![i].dscription.toString(),
        quantity:
            double.parse(stockInward[index].data![i].Scanned_Qty.toString()),
        unitPrice: double.parse(stockInward[index].data![i].price.toString()),
        toWarehouseCode: AppConstant.branch,
        baseDocentry: stockInward[index].data![i].baseDocentry,
        baseline: stockInward[index].data![i].lineNo.toString(),
        lineNum: i,
        batchNumbers: batchTable!,
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

  postInwardData(
      String docstatus,
      int docEntryId,
      int index,
      int baseentry,
      List<StockInwardDetails>? data,
      StockInwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    log("baseentry:::$baseentry");
    seriesType = '';

    await callSeriesApi(context, '67');
    await addOutLinedata(index);
    PostStkInwardAPi.cardCodePost = selectedcust!.cardCode;
    PostStkInwardAPi.fromWarehouse = frmWhsCode.toString();
    PostStkInwardAPi.toWarehouse = AppConstant.branch;
    PostStkInwardAPi.seriesType = seriesType.toString();
    PostStkInwardAPi.comments = stInController[50].text.toString();
    PostStkInwardAPi.docDate = config.currentDate();
    PostStkInwardAPi.dueDate = config.currentDate();
    PostStkInwardAPi.stockTransferLines = stockInwardLines;
    PostStkInwardAPi.method();
    notifyListeners();
    await PostStkInwardAPi.getGlobalData().then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();

        await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry),
            int.parse(sapDocuNumber), docEntryId, 'StockInHeaderDB');

        await updateInWrdStkSnaptab(
            int.parse(docEntryId.toString()), int.parse(baseentry.toString()));

        await Get.defaultDialog(
                title: "Success",
                middleText: ' Sucessfully Done \n'
                    "Document number $sapDocuNumber",
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
          onClickDisable = false;
          onClickDisable = false;
          selectedcust = null;
          stInController[50].text = "";
          stInController2[50].text = "";
          isselect = false;
          stockInward.remove(datatotal);
          data!.clear();
          data.clear();
          Get.offAllNamed(ConstantRoutes.dashboard);
          notifyListeners();
        });
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
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
        ).then((value) {
          onClickDisable = false;
        });
      } else {
        await Get.defaultDialog(
          title: "Alert",
          middleText: 'Something went Wrong..!!',
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
        ).then((value) {
          onClickDisable = false;
          stockInward[index].data!.clear();
        });
        notifyListeners();
      }

      notifyListeners();
    });
  }

  Future myFuture(
      BuildContext context, theme, List<StockInwardDetails>? data) async {
    if (data!.isEmpty) {
      Get.defaultDialog(
          title: "Alert",
          middleText: 'Please Select Items..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyMedium,
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
          radius: 5);
    } else {
      double? scannedtottal = 0;
      double? totalTransQty = 0;
      double? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        scannedtottal =
            scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
        totalTransQty = totalTransQty! + data[i].trans_Qty!;
        totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
        notifyListeners();
      }
      if (totalscanqty == totalTransQty) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  holdbutton(int index, BuildContext context, ThemeData theme,
      List<StockInwardDetails>? data, StockInwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    onClickDisable = true;
    double? scannedtottal = 0;
    double? totalReqQty = 0;
    double? totalTransQty = 0;

    for (int i = 0; i < data!.length; i++) {
      scannedtottal = scannedtottal! + data[i].Scanned_Qty!;
      totalTransQty = totalTransQty! + data[i].trans_Qty!;
      totalReqQty = totalReqQty! + data[i].qty!;
      notifyListeners();
    }

    if (scannedtottal == 0) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Please Scan Minimum One Item..!!',
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
        onClickDisable = true;
        notifyListeners();
      });
    } else if (scannedtottal != 0) {
      await DBOperation.deletAlreadyHoldDataStIN(
          db, int.parse(stockInward[index].baceDocentry.toString()));

      await holdValueInsertToDB('hold', context, theme, index, data, datatotal);

      notifyListeners();
    }
    notifyListeners();
  }

  String sapStockReqdocnum = '';
  String sapStockReqdocentry = '';

  holdValueInsertToDB(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockInwardDetails>? data,
      StockInwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockInHeaderDataDB> stInHeader = [];
    List<StockInLineDataDB> stInLine = [];

    int? docEntryCreated =
        await DBOperation.generateDocentr(db, "docentry", "StockInHeaderDB");

    stInHeader.add(StockInHeaderDataDB(
        cardCode: selectedcust != null && selectedcust!.cardCode!.isNotEmpty
            ? selectedcust!.cardCode!
            : '',
        cardName: selectedcust != null && selectedcust!.name!.isNotEmpty
            ? selectedcust!.name!
            : '',
        branch: UserValues.branch,
        docentry: docEntryCreated.toString(),
        createdUserID: UserValues.userID,
        baseDocentry: stockInward[index].baceDocentry,
        createdateTime: config.currentDate(),
        docstatus: '1',
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: stockInward[index].documentno,
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: stockInward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: stockInward[index].reqtoWhs,
        transdate: config.currentDate(),
        salesexec: "",
        totalitems: 0,
        totalltr: 0,
        totalqty: 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        terminal: UserValues.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: sapStockReqdocentry,
        sapStockReqdocnum: sapStockReqdocnum,
        remarks: stInController[50].text.toString()));
    int? docentry2 = await DBOperation.insertStockInheader(db, stInHeader);
    stockInward[index].data = passdata;

    for (int i = 0; i < stockInward[index].data!.length; i++) {
      List<StockInBatchDataDB>? stInbatch = [];
      await DBOperation.deleteBatch2_STIN(
          db,
          stockInward[index].data![i].baseDocentry!,
          stockInward[index].data![i].lineNo!,
          stockInward[index].data![i].itemcode!);
      log('stockInward[index].data![i].serialbatchList::${stockInward[index].data![i].StOutSerialbatchList!.length}');

      if (stockInward[index].data![i].StOutSerialbatchList != null ||
          stockInward[index].data![i].StOutSerialbatchList!.isNotEmpty) {
        for (int k = 0;
            k < stockInward[index].data![i].StOutSerialbatchList!.length;
            k++) {
          stInbatch.add(StockInBatchDataDB(
              lineno:
                  stockInward[index].data![i].StOutSerialbatchList![k].lineno,
              baseDocentry: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![k]
                  .baseDocentry,
              itemcode:
                  stockInward[index].data![i].StOutSerialbatchList![k].itemcode,
              qty: stockInward[index].data![i].StOutSerialbatchList![k].qty,
              serialbatch: stockInward[index]
                  .data![i]
                  .StOutSerialbatchList![k]
                  .serialbatch,
              docentry: stockInward[index].data![i].docentry.toString(),
              docstatus: ''));
        }
      }
      await DBOperation.insertStInBatch(db, stInbatch);
      await DBOperation.deletAlreadyHoldDataLineSTIN(
          db,
          int.parse(stockInward[index].baceDocentry.toString()),
          stockInward[index].data![i].itemcode.toString());
      stInLine.add(StockInLineDataDB(
          lineno: stockInward[index].data![i].lineNo.toString(),
          docentry: docentry2.toString(),
          itemcode: stockInward[index].data![i].itemcode.toString(),
          description: stockInward[index].data![i].dscription,
          qty: double.parse(stockInward[index].data![i].qty.toString()),
          baseDocentry: stockInward[index].baceDocentry.toString(),
          baseDocline: stockInward[index].data![i].lineNo.toString(),
          status: stockInward[index].data![i].status,
          traansferQty: stockInward[index].data![i].trans_Qty,
          scannedQty: stockInward[index].data![i].Scanned_Qty,
          serialBatch: stockInward[index].data![i].serialBatch,
          branch: UserValues.branch,
          terminal: UserValues.terminal));
    }
    await DBOperation.insertStInLine(db, stInLine);
    getHoldValues(db);
    await Get.defaultDialog(
      title: "Alert",
      middleText: "Saved as draft",
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
    ).then((value) {
      stInController[50].clear();
      stockInward.remove(datatotal);
      data!.clear();
      onClickDisable = false;
    });

    notifyListeners();
  }

  gethold() async {
    final Database db = (await DBHelper.getInstance())!;

    getHoldValues(db);
  }

  SuspendDBInsert(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockInwardDetails>? data,
      StockInwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockInHeaderDataDB> stInHeader = [];

    stInHeader.add(StockInHeaderDataDB(
        cardCode: selectedcust!.cardCode ?? '',
        cardName: selectedcust!.name ?? '',
        branch: UserValues.branch,
        terminal: UserValues.terminal,
        createdUserID: UserValues.userID,
        baseDocentry: stockInward[index].baceDocentry,
        createdateTime: config.currentDate(),
        docstatus: "0",
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: "0",
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: stockInward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: stockInward[index].reqtoWhs,
        transdate: config.currentDate(),
        salesexec: "",
        totalitems: 0,
        totalltr: 0,
        totalqty: 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: '',
        sapStockReqdocnum: '',
        remarks: ''));

    await DBOperation.deleteSuspendBatchStIn(
        db, int.parse(stockInward[index].baceDocentry!));

    for (int i = 0; i < stockInward[index].data!.length; i++) {
      stockInward[index].data![i].Scanned_Qty = 0;

      notifyListeners();
    }
    await Get.defaultDialog(
      title: "Alert",
      middleText: " Data Cleared Sucessfully..!!",
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
    ).then((value) {});

    notifyListeners();
  }

  double? totalqty(int? index) {
    double? totalqty = 0;
    for (int i = 0; i < stockInward[index!].data!.length; i++) {
      totalqty = totalqty! + stockInward[index].data![i].qty!;
    }
    return totalqty;
  }

  double? totalValdationqty(int? index) {
    double? totalqty = 0;
    for (int i = 0; i < stockInward[index!].data!.length; i++) {
      totalqty = totalqty! + stockInward[index].data![i].Scanned_Qty!;
    }
    return totalqty;
  }

  double? totalscannedqty(int? index) {
    double? totalscanqty = 0;
    for (int i = 0; i < stockInward[index!].data!.length; i++) {
      totalscanqty = totalscanqty! + stockInward[index].data![i].Scanned_Qty!;
    }
    return totalscanqty;
  }

  String a = "";
  Future getHoldValues(Database db) async {
    List<Map<String, Object?>> getDBStInHead =
        await DBOperation.getHoldStInHeadDB(db);
    savedraftBill = [];

    List<StockInwardDetails> stInLine = [];
    List<StockInSerialbatch> stInBatch = [];
    for (int i = 0; i < getDBStInHead.length; i++) {
      List<Map<String, Object?>> getOutWrdHead =
          await DBOperation.stockHeaderCheck(
              db, int.parse(getDBStInHead[i]["baseDocentry"].toString()));
      log('getOutWrdHead[i]["sapStockReqdocnum"].toString()::${getDBStInHead[i]["sapStockReqdocnum"].toString()}');

      List<Map<String, Object?>> getDBstInLine =
          await DBOperation.holdStInLineDB(
              db,
              int.parse(getDBStInHead[i]["baseDocentry"].toString()),
              int.parse(getDBStInHead[i]["docentry"].toString()));
      stInLine = [];
      for (int j = 0; j < getDBstInLine.length; j++) {
        List<Map<String, Object?>> getDBStInBatch =
            await DBOperation.holdStInBatchDB(
                db,
                int.parse(getDBstInLine[j]["baseDocentry"].toString()),
                getDBstInLine[j]["itemcode"].toString());

        stInBatch = [];
        if (int.parse(getDBstInLine[j]["scannedQty"].toString()) != 0) {
          for (int k = 0; k < getDBStInBatch.length; k++) {
            stInBatch.add(
              StockInSerialbatch(
                lineno: getDBStInBatch[k]["lineno"].toString(),
                itemName: getDBStInBatch[k]["itemName"].toString(),
                baseDocentry: getDBStInBatch[k]["baseDocentry"].toString(),
                itemcode: getDBStInBatch[k]["itemcode"].toString(),
                qty: int.parse(getDBStInBatch[k]["quantity"].toString()),
                serialbatch: getDBStInBatch[k]["serialBatch"].toString(),
                docentry: getDBStInBatch[k]["docentry"].toString(),
              ),
            );
          }
        } else {
          stInBatch = [];
        }

        stInLine.add(StockInwardDetails(
            lineNo: int.parse(getDBstInLine[j]["lineno"].toString()),
            docentry: int.parse(getDBstInLine[j]["docentry"].toString()),
            baseDocNum: getDBStInHead[i]["sapStockReqdocnum"].toString(),
            baseDocentry:
                int.parse(getDBstInLine[j]["baseDocentry"].toString()),
            itemcode: getDBstInLine[j]["itemcode"].toString(),
            dscription: getDBstInLine[j]["description"].toString(),
            qty: double.parse(getDBstInLine[j]["quantity"].toString()),
            status: getDBstInLine[j]["status"].toString(),
            serialBatch: getDBstInLine[j]["serialBatch"].toString(),
            createdUserID: 0,
            taxRate: 0.0,
            taxType: "",
            baseDocline: int.parse(getDBstInLine[j]["baseDocline"].toString()),
            trans_Qty: getDBstInLine[j]["transferQty"] == null
                ? 0
                : double.parse(getDBstInLine[j]["transferQty"].toString()),
            Scanned_Qty:
                double.parse(getDBstInLine[j]["scannedQty"].toString()),
            createdateTime: "",
            updatedDatetime: "",
            updateduserid: 0,
            price: 0,
            lastupdateIp: "",
            serialbatchList: stInBatch));
      }

      savedraftBill.add(StockInwardList(
        remarks: getDBStInHead[i]["remarks"].toString(),
        cardCode: getDBStInHead[i]["CardCode"].toString(),
        docentry: getDBStInHead[i]["docentry"].toString(),
        baceDocentry: getDBStInHead[i]["baseDocentry"].toString(),
        branch: getDBStInHead[i]["branch"].toString(),
        docstatus: getDBStInHead[i]["docstatus"].toString(),
        reqfromWhs: getDBStInHead[i]["reqfromWhs"].toString(),
        reqtoWhs: getDBStInHead[i]["reqtoWhs"].toString(),
        reqtransdate: getDBStInHead[i]["transdate"].toString(),
        reqdocumentno: getDBStInHead[i]["reqdocno"].toString(),
        documentno: getDBStInHead.isNotEmpty &&
                getDBStInHead[i]["sapStockReqdocnum"] != null
            ? getDBStInHead[i]["sapStockReqdocnum"].toString()
            : '',
        data: stInLine,
      ));
    }
  }

  valPass(double scanQty) {
    msg = "";

    notifyListeners();
  }

  pageIndexvalue(int? index) {
    pageIndex = index!;
    notifyListeners();
  }

  passINDEX(int? index) {
    i_value = index!;
    notifyListeners();
  }

  int? listI = 0;
  int? batch_i = 0;

  StockInwardDetails? batch_datalist;
  passindexBachPage(
    int? index,
    int i,
    StockInwardDetails? datalist,
  ) {
    listI = index!;
    batch_i = i;

    batch_datalist = datalist;
    if (stockInward[index].data![i].serialbatchList != null) {
      for (int ik = 0;
          ik < stockInward[index].data![i].serialbatchList!.length;
          ik++) {
        sinqtycontroller[ik].text =
            stockInward[index].data![i].serialbatchList![ik].qty.toString();
      }
      notifyListeners();
    }
    notifyListeners();
  }

  Future<bool> onbackpress3() {
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

  Future<bool> onbackpress() async {
    if (pageIndex == 1) {
      page.animateToPage(--pageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
    } else if (pageIndex == 2) {
      notifyListeners();
      page.animateToPage(--pageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
    }
    return Future.value(false);
  }

  List<StockInwardDetails>? passdata = [];
  passList(List<StockInwardDetails>? data) {
    passdata = data!;
    log("passdata!.length::${passdata![0].StOutSerialbatchList!.length}");

    notifyListeners();
  }

  List<StockInwardList> stockInward = [];
  StockInwardList? stockInwarddd;
  clearmsg() {
    msg = "";

    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    page.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
    return Future.value(false);
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry.isNotEmpty) {
      await sapLoginApi(context);
      await callgetStkinwardAPI(context, theme);
      await callStkInwardCancelQuoAPI(context, theme);
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
        stInController2[50].text = '';
        stockInward2.clear();

        stockInward.clear();
        notifyListeners();
      });

      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;
    await PostInwardLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          getSession();
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

  void getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    // log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
  }

  callgetStkinwardAPI(BuildContext context, ThemeData theme) async {
    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");
    await sapLoginApi(context);
    await SerlayInwardAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.StockTransferInwrddLines.isNotEmpty) {
          sapInwardModelData = value.StockTransferInwrddLines;
          List<StockInwardList> stockOutDATA2 = [];
          List<StockInwardDetails> stockDetails2 = [];
          List<StockInSerialbatch> stoutSeralBatchList = [];

          for (var i = 0; i < sapInwardModelData.length; i++) {
            for (var ij = 0;
                ij < sapInwardModelData[i].batchNumbers.length;
                ij++) {
              stoutSeralBatchList.add(StockInSerialbatch(
                  serialbatch:
                      sapInwardModelData[i].batchNumbers[ij].batchNumber,
                  itemName: '',
                  qty: int.parse(sapInwardModelData[i]
                      .batchNumbers[ij]
                      .quantity
                      .toString()
                      .replaceAll('.0', '')),
                  lineno: sapInwardModelData[i]
                      .batchNumbers[ij]
                      .baseLineNumber
                      .toString(),
                  itemcode: sapInwardModelData[i].itemCode));
            }
            stockDetails2.add(StockInwardDetails(
                createdUserID: 1,
                baseDocNum: '',
                baseDocentry:
                    int.parse(sapInwardModelData[i].docEntry.toString()),
                docentry: int.parse(sapInwardModelData[i].docEntry.toString()),
                dscription: sapInwardModelData[i].itemDescription.toString(),
                itemcode: sapInwardModelData[i].itemCode.toString(),
                lastupdateIp: "",
                lineNo: sapInwardModelData[i].lineNum,
                qty: sapInwardModelData[i].quantity,
                status: sapInwardModelData[i].lineStatus.toString(),
                updatedDatetime: '',
                updateduserid: 1,
                price: 1,
                serialBatch: '',
                taxRate: 0.0,
                taxType: "",
                baseDocline: sapInwardModelData[i].lineNum,
                // trans_Qty: getDBStInLine[j]["transferQty"] == null
                //     ? 0
                //     : double.parse(getDBStInLine[j]["transferQty"].toString()),
                // Scanned_Qty: getDBStInLine[j]["scannedQty"] == null
                //     ? 0
                //     : double.parse(getDBStInLine[j]["scannedQty"].toString()),
                // baseDocline: getDBStInLine[j]["baseDocline"] == null
                //     ? 0
                //     : int.parse(getDBStInLine[j]["baseDocline"].toString()),
                serialbatchList: stoutSeralBatchList));
          }
          stInController2[50].text = value.comments;
          stockOutDATA2.add(StockInwardList(
              remarks: value.comments,
              branch: AppConstant.branch,
              docentry: value.docEntry.toString(),
              baceDocentry: value.docEntry.toString(),
              // docstatus: value..toString(),
              documentno: value.docNum.toString(),
              // reqfromWhs: getDBstInHeader[0]["reqfromWhs"].toString(),
              // reqtoWhs: getDBstInHeader[0]["reqtoWhs"].toString(),
              reqtransdate: value.docDate,
              data: stockDetails2));
          sapDocentry = value.docEntry.toString();
          sapDocuNumber = value.docNum.toString();
          stockInward2.addAll(stockOutDATA2);
          custserieserrormsg = '';
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
                      content: value.error!.message!.value.toString(),
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          stInController2[50].text = '';
          stockInward2.clear();

          stockInward.clear();
          notifyListeners();
        });
      } else {}
    });
  }

  callStkInwardCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapInwardModelData.isNotEmpty) {
      for (int ij = 0; ij < sapInwardModelData.length; ij++) {
        if (sapInwardModelData[ij].lineStatus == "bost_Open") {
          await SerlayvInwardCancelAPI.getData(sapDocentry.toString())
              .then((value) async {
            if (value.statusCode! >= 200 && value.statusCode! <= 204) {
              cancelbtn = false;

              await DBOperation.updateSalesQuoclosedocsts(
                  db, sapDocentry.toString());

              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        contentPadding: const EdgeInsets.all(0),
                        content: AlertBox(
                          payMent: 'Success',
                          errormsg: true,
                          widget: Center(
                              child: ContentContainer(
                            content: 'Document is successfully cancelled ..!!',
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                sapDocuNumber = '';
                stInController2[50].text = '';
                stockInward2.clear();

                stockInward.clear();
                notifyListeners();
              });

              custserieserrormsg = '';
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;

              custserieserrormsg = errmodel!.message!.value.toString();

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
                            content: value.exception!.message!.value.toString(),
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                sapDocuNumber = '';
                stInController2[50].text = '';
                stockInward2.clear();

                stockInward.clear();
                notifyListeners();
              });
            } else {}
          });
        } else if (sapInwardModelData[ij].lineStatus == "bost_Close") {
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
                        content: 'Document is already cancelled',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {
            sapDocentry = '';
            sapDocuNumber = '';
            stInController2[50].text = '';
            stockInward2.clear();
            stInController2[50].text = "";

            stockInward.clear();
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }

  mapvalue(List<StockInwardList> stockOut, int index) async {
    onDisablebutton = false;
    final Database db = (await DBHelper.getInstance())!;
    List<StOutSerialbatch>? stOutSerialbatchList2 = [];
    stockInward2.clear();
    stInController2[50].text = "";

    if (isselect == true) {
      isselect = false;
    }

    List<StockInwardDetails> stInDetails = [];
    List<StockInwardList> stInList = [];

    for (int j = 0; j < stockOut[index].data!.length; j++) {
      stOutSerialbatchList2 = [];
      List<StockInSerialbatch> stInSeralBatchList = [];
      if (stockOut[index].data![j].serialbatchList != null) {
        for (int k = 0;
            k < stockOut[index].data![j].serialbatchList!.length;
            k++) {
          stInSeralBatchList.add(StockInSerialbatch(
            lineno: stockOut[index].data![j].lineNo.toString(),
            baseDocentry: stockOut[index].data![j].baseDocentry.toString(),
            itemcode: stockOut[index].data![j].itemcode.toString(),
            itemName: stockOut[index].data![j].dscription.toString(),
            qty: stockOut[index].data![j].serialbatchList![k].qty,
            serialbatch: stockOut[index]
                .data![j]
                .serialbatchList![k]
                .serialbatch
                .toString(),
            docentry: stockOut[index].data![j].docentry.toString(),
          ));
        }
      }
      await DBOperation.getbatchList(db);
      List<Map<String, Object?>> getStockOutBatchListData =
          await DBOperation.getBatchInOutwardStIn(
              db,
              int.parse(stockOut[index].data![j].baseDocentry.toString()),
              stockOut[index].data![j].itemcode.toString());

      for (int k = 0; k < getStockOutBatchListData.length; k++) {
        stOutSerialbatchList2.add(StOutSerialbatch(
            lineno: getStockOutBatchListData[k]['linene'].toString(),
            docentry: getStockOutBatchListData[k]['docentry'].toString(),
            baseDocentry:
                getStockOutBatchListData[k]['baseDocentry'].toString(),
            itemcode: getStockOutBatchListData[k]['itemcode'].toString(),
            qty: double.parse(
                getStockOutBatchListData[k]['quantity'].toString()),
            serialbatch:
                getStockOutBatchListData[k]['serialBatch'].toString()));
      }

      stInDetails.add(StockInwardDetails(
          createdUserID: stockOut[index].data![j].createdUserID,
          createdateTime: stockOut[index].data![j].createdateTime,
          baseDocentry: stockOut[index].data![j].baseDocentry,
          docentry: stockOut[index].data![j].docentry,
          baseDocNum: '',
          dscription: stockOut[index].data![j].dscription,
          itemcode: stockOut[index].data![j].itemcode,
          lastupdateIp: stockOut[index].data![j].lastupdateIp,
          lineNo: stockOut[index].data![j].lineNo,
          qty: stockOut[index].data![j].qty,
          status: stockOut[index].data![j].status,
          updatedDatetime: stockOut[index].data![j].updatedDatetime,
          updateduserid: stockOut[index].data![j].updateduserid,
          price: stockOut[index].data![j].price,
          serialBatch: stockOut[index].data![j].serialBatch,
          taxRate: stockOut[index].data![j].taxRate,
          taxType: stockOut[index].data![j].taxType,
          trans_Qty: stockOut[index].data![j].trans_Qty,
          Scanned_Qty: stockOut[index].data![j].Scanned_Qty,
          baseDocline: stockOut[index].data![j].baseDocline,
          serialbatchList: stInSeralBatchList,
          StOutSerialbatchList: stOutSerialbatchList2));
    }

    log("stInDetails:${stInDetails.length}:${stInDetails[0].StOutSerialbatchList!.length}");
    stInController[50].text = stockOut[index].remarks.toString();

    stInList.add(StockInwardList(
        cardCode: stockOut[index].cardCode,
        branch: stockOut[index].branch,
        docentry: stockOut[index].docentry,
        baceDocentry: stockOut[index].baceDocentry,
        docstatus: stockOut[index].docstatus,
        documentno: stockOut[index].documentno,
        reqdocumentno: stockOut[index].reqdocumentno,
        reqfromWhs: stockOut[index].reqfromWhs,
        reqtoWhs: stockOut[index].reqtoWhs,
        reqtransdate: stockOut[index].reqtransdate,
        data: stInDetails,
        remarks: stockOut[index].remarks));
    int? count = await dupilicateHoldDataCheck(stInList);

    if (count != null) {
      stockInward.removeAt(count);
    } else {}
    stockInward = stInList;

    log("stockInward::" + stockInward.length.toString());
    selectAll = true;
    passdata = stockInward[stockInward.length - 1].data!;

    for (var i = 0; i < passdata!.length; i++) {
      passdata![i].listClr = true;
    }
    i_value = stockInward.length - 1;
    selectIndex = stockInward.length - 1;

    getHoldValues(db);
    notifyListeners();
  }

  Future<int?> dupilicateHoldDataCheck(List<StockInwardList> stInList) {
    for (int i = 0; i < stockInward.length; i++) {
      if (stockInward[i].baceDocentry == stInList[0].baceDocentry) {
        return Future.value(i);
      }
    }
    return Future.value(null);
  }

  double mainTranTotal = 0;
  double mainScannedTotal = 0;

  mainaValidation(List<StockInwardDetails> stockInward, StockInwardList stock) {
    mainTranTotal = 0;
    mainScannedTotal = 0;
    notifyListeners();

    for (int i = 0; i < stockInward.length; i++) {
      mainScannedTotal = mainScannedTotal + stockInward[i].Scanned_Qty!;
      mainTranTotal = mainTranTotal + stockInward[i].trans_Qty!;

      notifyListeners();
    }

    notifyListeners();
  }

  List<StockInwardList> savedraftBill = [];
  List<StockInwardList> saveBill = [];
  List<StockInwardList> stockOutDATA = [];
  bool? dbDataTrue = false;
  bool? scandbDataTrue = false;
  bool? scanListTrue = false;

  // getStockOutData() async {
  //   stockInward.clear();
  //   stockOutDATA.clear();
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> getStockOutValues =
  //       await DBOperation.getStockOut(db);
  //   if (getStockOutValues.isNotEmpty) {
  //     for (int i = 0; i < getStockOutValues.length; i++) {
  //       if (getStockOutValues[i]["reqfromWhs"].toString() ==
  //           AppConstant.branch) {
  //         stockOutDATA = [];
  //         stkreqfromwhs = getStockOutValues[i]["reqfromWhs"].toString();

  //         dbDataTrue = false;

  //         List<Map<String, Object?>> getStockOutLineData =
  //             await DBOperation.getTrasferQtyStIn(
  //                 db,
  //                 int.parse(getStockOutValues[i]["docentry"].toString()),
  //                 int.parse(getStockOutValues[i]["baseDocentry"].toString()));
  //         List<StockInwardDetails> stockDetails = [];
  //         List<StOutSerialbatch>? stOutSerialbatchList2 = [];

  //         for (int j = 0; j < getStockOutLineData.length; j++) {
  //           if (getStockOutValues[i]["reqtoWhs"].toString() == "HOGIT") {
  //             stOutSerialbatchList2 = [];

  //             List<Map<String, Object?>> getStockOutBatchListData =
  //                 await DBOperation.getBatchInOutwardStIn2(
  //                     db,
  //                     int.parse(getStockOutLineData[j]["docentry"].toString()),
  //                     int.parse(
  //                         getStockOutLineData[j]["baseDocentry"].toString()),
  //                     getStockOutLineData[j]["itemcode"].toString());

  //             for (int k = 0; k < getStockOutBatchListData.length; k++) {
  //               if (getStockOutBatchListData[k]['docentry'].toString() ==
  //                   getStockOutLineData[j]["docentry"].toString()) {
  //                 stOutSerialbatchList2.add(StOutSerialbatch(
  //                     lineno: getStockOutBatchListData[k]['lineno'].toString(),
  //                     docentry:
  //                         getStockOutBatchListData[k]['docentry'].toString(),
  //                     baseDocentry: getStockOutBatchListData[k]['baseDocentry']
  //                         .toString(),
  //                     itemcode:
  //                         getStockOutBatchListData[k]['itemcode'].toString(),
  //                     qty: double.parse(
  //                         getStockOutBatchListData[k]['quantity'].toString()),
  //                     serialbatch: getStockOutBatchListData[k]['serialBatch']
  //                         .toString()));
  //                 notifyListeners();
  //               }
  //             }

  //             stockDetails.add(StockInwardDetails(
  //                 baseDocentry: int.parse(
  //                     getStockOutLineData[j]["baseDocentry"].toString()),
  //                 baseDocline:
  //                     int.parse(getStockOutLineData[j]["lineno"].toString()),
  //                 createdUserID: getStockOutLineData[j]["createdUserID"] == null
  //                     ? 0
  //                     : int.parse(
  //                         getStockOutLineData[j]["createdUserID"].toString()),
  //                 createdateTime:
  //                     getStockOutLineData[j]["createdateTime"].toString(),
  //                 docentry:
  //                     int.parse(getStockOutLineData[j]["docentry"].toString()),
  //                 dscription: "",
  //                 baseDocNum: '',
  //                 itemcode: getStockOutLineData[j]["itemcode"].toString(),
  //                 lastupdateIp:
  //                     getStockOutLineData[j]["lastupdateIp"].toString(),
  //                 lineNo:
  //                     int.parse(getStockOutLineData[j]["lineno"].toString()),
  //                 qty: double.parse(
  //                     getStockOutLineData[j]["quantity"].toString()),
  //                 status: "",
  //                 updatedDatetime:
  //                     getStockOutLineData[j]["UpdatedDatetime"].toString(),
  //                 updateduserid: getStockOutLineData[j]["updateduserid"] == null
  //                     ? 0
  //                     : int.parse(
  //                         getStockOutLineData[j]["updateduserid"].toString()),
  //                 price: getStockOutLineData[j]["price"] == null
  //                     ? 0.0
  //                     : double.parse(getStockOutLineData[j]["price"].toString()),
  //                 serialBatch: getStockOutLineData[j]["serialBatch"].toString(),
  //                 taxRate: 0.0,
  //                 Scanned_Qty: double.parse(getStockOutLineData[j]["scanndQty"].toString()),
  //                 trans_Qty: double.parse(getStockOutLineData[j]["balqty"].toString()),
  //                 taxType: "",
  //                 StOutSerialbatchList: stOutSerialbatchList2));
  //           }
  //           notifyListeners();

  //           notifyListeners();
  //         }

  //         stockOutDATA.add(StockInwardList(
  //             branch: getStockOutValues[i]["branch"].toString(),
  //             docentry: getStockOutValues[i]["docentry"].toString(),
  //             baceDocentry: getStockOutValues[i]["baseDocentry"].toString(),
  //             docstatus: getStockOutValues[i]["docstatus"].toString(),
  //             reqdocumentno: getStockOutValues[i]["reqdocno"] == null
  //                 ? "0"
  //                 : getStockOutValues[i]["reqdocno"].toString(),
  //             documentno: getStockOutValues[i]["documentno"] == null
  //                 ? "0"
  //                 : getStockOutValues[i]["documentno"].toString(),
  //             reqfromWhs: getStockOutValues[i]["reqfromWhs"].toString(),
  //             reqtoWhs: getStockOutValues[i]["branch"].toString(),
  //             reqtransdate: getStockOutValues[i]["transdate"].toString(),
  //             data: stockDetails));
  //       } else {
  //         notifyListeners();
  //       }
  //       notifyListeners();
  //     }
  //   } else {
  //     dbDataTrue = true;
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  postRabitMq(int docentry, int baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBstInHeader =
        await DBOperation.getStockInHeader(db, docentry);
    List<Map<String, Object?>> getDBStInLine = await DBOperation.holdStInLineDB(
        db, int.parse(getDBstInHeader[0]['baseDocentry'].toString()), docentry);

    List<Map<String, Object?>> getDBStInBatch =
        await DBOperation.getStockInBatch(db,
            int.parse(getDBstInHeader[0]['baseDocentry'].toString()), docentry);
    String stInHeader = json.encode(getDBstInHeader);
    String stInLine = json.encode(getDBStInLine);
    String stInBatch = json.encode(getDBStInBatch);
    log("getDBStInLine length::${getDBStInLine.length}");

    var ddd = json.encode({
      "ObjectType": 6,
      "ActionType": "Add",
      "StockInwardHeader": stInHeader,
      "StockInwardLine": stInLine,
      "StockInwardBatch": stInBatch,
    });
    log("payload : $ddd");

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

  postRabitMq2(int docentry, int baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBstInHeader =
        await DBOperation.getStockInHeader(db, docentry);
    List<Map<String, Object?>> getDBStInLine =
        await DBOperation.holdStInLineDB(db, baseDocentry, docentry);
    List<Map<String, Object?>> getDBStInBatch =
        await DBOperation.getStockInBatch(db, baseDocentry, docentry);
    String stInHeader = json.encode(getDBstInHeader);
    String stInLine = json.encode(getDBStInLine);
    String stInBatch = json.encode(getDBStInBatch);

    var ddd = json.encode({
      "ObjectType": 6,
      "ActionType": "Add",
      "StockInwardHeader": stInHeader,
      "StockInwardLine": stInLine,
      "StockInwardBatch": stInBatch,
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
    onClickDisable = true;

    TransferPrintAPi.docEntry = sapDocentry;
    TransferPrintAPi.slpCode = AppConstant.slpCode;
    // print("TransferPrintAPi.slpCode: " + TransferPrintAPi.slpCode.toString());
    await TransferPrintAPi.getGlobalData().then((value) {
      notifyListeners();
      if (value == 200) {
        onClickDisable = false;
        // saveAllExcel(TransferPrintAPi.path.toString(), context, theme);
      } else {
        onClickDisable = false;

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
    // await saveToExcel(valuesddd1, keysList1);
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
                      // const SizedBox(height: 15),
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

  mapCallInwardForPDF(preff, BuildContext context, ThemeData theme) async {
    List<InvoiceItem> itemsList = [];
    invoice = null;
    // for (int ih = 0; ih < salesmodl.length; ih++) {
    // await addressxx();
    log('StockOutward2[0].data.length:::${stockInward2[0].data!.length}');

    for (int i = 0; i < stockInward2[0].data!.length; i++) {
      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        descripton: stockInward2[0].data![i].dscription,
        unitPrice:
            double.parse(stockInward2[0].data![i].price!.toStringAsFixed(2)),
        quantity: double.parse((stockInward2[0].data![i].qty.toString())),
        // dics: scanneditemData2[i].discountper ?? 0,
        // vat: double.parse(scanneditemData2[i].taxvalue!.toStringAsFixed(2)),
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
        address: '',
        //  custDetails[0].address ?? '',
        // printerName: custDetails[0].printHeadr ?? '',
        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
        // city: address2.isEmpty || address2[0].billCity.isEmpty
        //     ? ''
        //     : address2[0].billCity.toString(),
        // area: address2.isEmpty || address2[0].address3!.isEmpty
        //     ? ''
        //     : address2[0].address3.toString(),
        // pin: address2.isEmpty || address2[0].billPincode.isEmpty
        //     ? ''
        //     : address2[0].billPincode.toString(),
      ),
      items: itemsList,
    );

    notifyListeners();

    PDFInwardapi.exclTxTotal = 0;
    PDFInwardapi.vatTx = 0;
    PDFInwardapi.inclTxTotal = 0;
    log('invoice!.items!.::${invoice!.items!.length}');
    if (invoice!.items!.isNotEmpty) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt = 0;
        //     (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        PDFInwardapi.exclTxTotal =
            (PDFInwardapi.exclTxTotal) + (invoice!.items![i].netTotal!);
        // PDFInwardapi.vatTx = (PDFInwardapi.vatTx) +
        //     double.parse(invoice!.items![i].vat.toString());
        PDFInwardapi.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString());
        //  + double.parse(invoice!.items![i].vat.toString());
        PDFInwardapi.pails = 0;
        //  PDFInwardapi.pails! + invoice!.items![i].pails!;
        PDFInwardapi.cartons = 0;
        // PDFInwardapi.cartons! + invoice!.items![i].cartons!;
        PDFInwardapi.looseTins = 0;
        // PDFInwardapi.looseTins! + invoice!.items![i].looseTins!;
        PDFInwardapi.tonnage = 0;
        // PDFInwardapi.tonnage! + invoice!.items![i].tonnage!;
        notifyListeners();
      }
      PDFInwardapi.totalPack =
          PDFInwardapi.pails! + PDFInwardapi.cartons! + PDFInwardapi.looseTins!;
      PDFInwardapi.inclTxTotal =
          (PDFInwardapi.exclTxTotal) + (PDFInwardapi.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }
      PDFInwardapi.iinvoicee = invoice;
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
        context, MaterialPageRoute(builder: (context) => PDFInwardapi()));
    notifyListeners();
  }
}
