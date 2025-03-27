import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import 'package:posproject/Service/Printer/TransferReqPrint.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockOutwardBatchModel.dart';
import '../../DBModel/StockOutwardHeader.dart';
import '../../DBModel/StockOutwardLineData.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';
import '../../Models/QueryUrlModel/AutoselectModel.dart';
import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';
import '../../Models/QueryUrlModel/FetchFromPdaModel.dart';
import '../../Models/QueryUrlModel/SOCustoAddressModel.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/SalesReqQModel.dart';
import '../../Models/QueryUrlModel/openStkQueryModel/StockReqLineModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/StockOutPostingMidel.dart';
import '../../Models/ServiceLayerModel/SAPOutwardModel/sapOutwardmodel.dart';

import '../../Pages/PrintPDF/invoice.dart';
import '../../Pages/SalesQuotation/Widgets/ItemLists.dart';
import '../../Pages/StockOutward/Widgets/PrintDocument.dart';
import '../../Service/AccountBalanceAPI.dart';
import '../../Service/QueryURL/AutoselectApi.dart';
import '../../Service/QueryURL/CompanyVatTinApi.dart';
import '../../Service/QueryURL/FetchbatchPDAapi.dart';
import '../../Service/QueryURL/InventoryTransfers/OpenOutwardLineQuery.dart';
import '../../Service/QueryURL/InventoryTransfers/OpenOutwardApi.dart';
import '../../Service/QueryURL/SoCustomerAddressApi.dart';
import '../../Service/SearchQuery/SearchOutwardApi.dart';
import '../../Service/SearchQuery/SearchOutwardLineApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/GetOutwardAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutWardPostingAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutwardCancelAPI.dart';
import '../../ServiceLayerAPIss/SAPStockOutwardAPI/OutwardLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class StockOutwardController extends ChangeNotifier {
  void init(BuildContext context) {
    clear2();
    getCustDetFDB();
    callOpenReqAPi(context);
    deletereq();

    gethold();
  }

  TextEditingController searchcon = TextEditingController();
  List<StockSnapTModelDB> getSearchedData = [];
  List<StockSnapTModelDB> getfilterSearchedData = [];
  List<TextEditingController> qtymycontroller =
      List.generate(500, (ij) => TextEditingController());
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  ScrollController scrollController = ScrollController();
  String? sapDocentry = '';
  String? sapDocuNumber = '';
  String? RequestedWarehouse;
  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;
  String custserieserrormsg = '';
  List<StockTransferLine> sapstkoutwarddata = [];
  bool OndDisablebutton = false;

  Configure config = Configure();
  List<String> ScandSerial = [];
  List<List<String>>? test2;
  int scannvalue2 = 0;

  int pageIndex = 0;
  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());

  List<TextEditingController> StOutController =
      List.generate(500, (i) => TextEditingController());
  List<TextEditingController> StOutController2 =
      List.generate(500, (i) => TextEditingController());
  int i_value = 0;
  int get get_i_value => i_value;
  double ScannigVal = 0;
  double get get_ScannigVal => ScannigVal;
  int Scanned_Val = 0;
  int get get_Scanned_Val => Scanned_Val;
  int? selectIndex;
  int? selectIndex2;
  String? msg = '';
  bool? OnclickDisable = false;
  bool? OnScanDisable = false;
  bool autoselectbtndisable = false;
  bool batchselectbtndisable = false;
  bool manualselectbtndisable = false;
  TextEditingController searchcontroller = TextEditingController();

  bool searchbool = false;
  List<searchModel> searchData = [];

  List<StockOutwardList> StockOutward2 = [];
  bool? dbDataTrue = false;
  List<StockOutwardList> savedraftBill = [];
  List<StockOutwardList> SaveBill = [];

  adddlistner() {
    scrollController.addListener(_scrollListener);
  }

  bool isselect = false;
  disposmethod() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
  }

  isselectmethod() {
    isselect = !isselect;
    log("isselect" + isselect.toString());
    notifyListeners();
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {}
  }

  void goToPage(int page) {
    if (page >= 0 && page < 2) {
      pageController.animateToPage(
        page,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      currentPage = page;
      notifyListeners();
    }
  }

  bool selectAll = true;
  selectAllItem() {
    addIndex = [];
    autoselectbtndisable = false;
    manualselectbtndisable = false;
    batchselectbtndisable = false;
    selectItemIndex = null;
    if (selectAll == true) {
      for (var i = 0; i < passdata!.length; i++) {
        passdata![i].listClr = true;
        qtymycontroller[i].text = passdata![i].balQty.toString();
        addIndex.add(i.toString());
      }
      mapItemCodeWiseSoAllData();

      notifyListeners();
    } else {
      for (var i = 0; i < passdata!.length; i++) {
        qtymycontroller[i].text = '';

        passdata![i].listClr = false;

        notifyListeners();

        log('VVpassdata![i].listClr:${passdata![i].listClr}');
      }
    }
    notifyListeners();
  }

  void goToNextPage() {
    print("goToNextPage::" + currentPage.toString());
    goToPage(currentPage + 1);
  }

  void goToPreviousPage() {
    goToPage(currentPage - 1);
  }

  setstatemethod() {
    notifyListeners();
  }

  doubleDotMethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    qtymycontroller[i].text = modifiedString2.toString();
    log(qtymycontroller[i].text);
    notifyListeners();
  }

  doubleDotMethodManualselect(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    manualQtyCtrl[i].text = modifiedString2.toString();
    log(manualQtyCtrl[i].text);
    notifyListeners();
  }

  clear2() {
    autoselectbtndisable = false;
    batchselectbtndisable = false;
    seriesVal = [];
    seriesType = '';
    filtercustList = [];
    custList = [];
    StockOutwardLines = [];
    batchTable = [];
    log("KKKKKKKKKKKK");
    cancelbtn = false;
    submitBool == false;
    selectIndex = null;
    StockOutward.clear();
    StockOutward2.clear();
    openAutoSelect = [];

    StOutController2[50].text = "";
    StOutController[50].clear();
    StOutController2[50].clear();
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    isselect = false;
    OnclickDisable = false;
    cancelbtn = false;
    i_value = 0;
    currentPage = 0;
    pageController = PageController(initialPage: 0);
    batch_datalist = null;
    passdata!.clear();
    StockOutward.clear();
    batch_i = 0;
    notifyListeners();
  }

  passData(ThemeData theme, BuildContext context, int index) {
    log("StockOutward[index].data length:" +
        StockOutward[index].data.length.toString());
    if (StockOutward[index].data.isNotEmpty) {
      selectIndex = index;
      i_value = index;

      notifyListeners();
    } else if (StockOutward[index].data.isEmpty) {
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
                      content: 'This Item Saved in DraftBill..!!',
                      theme: theme,
                    )),
                    buttonName: null));
          });
    }
    notifyListeners();
  }

  clearDataAll() {
    pageIndex = 0;
    selectedcust2 = null;
    StOutController2[50].text = "";
    manualQtyCtrl = List.generate(500, (ij) => TextEditingController());
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    qtymycontroller = List.generate(500, (ij) => TextEditingController());
    passdata = [];
    searchLoading = false;
    StockOutward = [];
    selectIndex = null;

    addIndex = [];
    searchError = '';
    noMsgText = '';
    msg = '';
    serialbatchList = [];
    loadingScrn = false;
    filtersearchData = [];
    fetchBatchData = [];
    serialbatchList = [];
    filterSerialbatchList = [];
    seriesType = '';
    msg = '';
    notifyListeners();
  }

  pagePlus() {
    goToNextPage();
  }

  pageminus() {
    goToPreviousPage();
  }

  String searchError = "";
  gethold() async {
    final Database db = (await DBHelper.getInstance())!;
    getHoldValues(db);
  }

  deletereq() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.deletereq(db).then((value) {});
  }

  Selectindex(int i) {
    selectIndex = i;
    notifyListeners();
  }

  Selectindex2(int i) {
    selectIndex2 = i;
    notifyListeners();
  }

  List<OpenSalesReqHeadersModlData> searchOutData = [];
  List<OpenSalesReqHeadersModlData> filtersearchData = [];
  String u_RequestWhs = '';
  String fromWhsCod = '';

  bool loadingScrn = false;

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

  callSearchOutApi() async {
    u_RequestWhs = '';
    searchOutData = [];
    filtersearchData = [];
    loadingScrn = true;
    await SerachOutwardHeaderAPi.getGlobalData(
            config.alignDate2(StOutController[100].text.toString()),
            config.alignDate2(StOutController[101].text.toString()))
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('ffffff');
        searchOutData = value.activitiesData!;
        filtersearchData = searchOutData;

        notifyListeners();
        loadingScrn = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingScrn = false;
      } else {
        loadingScrn = false;
      }
    });
    notifyListeners();
  }

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
  refresCufstList() async {
    filtercustList = custList;

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

  Future<void> callPrintApi(
    BuildContext context,
    ThemeData theme,
  ) async {
    OnclickDisable = true;
    TransferPrintAPi.docEntry = sapDocentry;
    TransferPrintAPi.slpCode = AppConstant.slpCode;

    TransferPrintAPi.getGlobalData().then((value) {
      notifyListeners();
      if (value == 200) {
        OnclickDisable = false;
      } else {
        OnclickDisable = false;

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

  bool searchLoading = false;
  callSearchLine(String docEntry, int index) async {
    sapDocentry = '';

    List<StockOutwardDetails> stockDetails2 = [];
    List<StockOutSerialbatch>? batchlistData = [];
    List<StockOutwardList> StockOutDATA2 = [];
    StockOutward2 = [];
    StOutController2[50].text = filtersearchData[index].comments.toString();

    sapDocentry = filtersearchData[index].docEntry.toString();
    u_RequestWhs = filtersearchData[index].uwhsCode;
    fromWhsCod = filtersearchData[index].fromWhs.toString();
    sapDocentry = filtersearchData[index].docEntry.toString();

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
            batchlistData.add(StockOutSerialbatch(
                lineno: value.openOutwardData![i].batchLine.toString(),
                docentry: value.openOutwardData![i].docEntry.toString(),
                itemcode: value.openOutwardData![i].itemCode.toString(),
                qty: double.parse(value.openOutwardData![i].qty.toString()),
                serialbatch: value.openOutwardData![i].batchNum.toString()));

            stockDetails2.add(StockOutwardDetails(
                createdUserID: 1,
                createdateTime: '',
                baseDocentry:
                    int.parse(value.openOutwardData![i].docEntry.toString()),
                docentry:
                    int.parse(value.openOutwardData![i].docEntry.toString()),
                dscription: value.openOutwardData![i].description.toString(),
                itemcode: value.openOutwardData![i].itemCode.toString(),
                lastupdateIp: "",
                lineNo: value.openOutwardData![i].batchLine,
                qty: value.openOutwardData![i].qty,
                updatedDatetime: '',
                updateduserid: 1,
                price: value.openOutwardData![i].price,
                serialBatch: value.openOutwardData![i].batchNum,
                taxRate: 0.0,
                taxType: "",
                trans_Qty: value.openOutwardData![i].batchQty,
                baseDocline: value.openOutwardData![i].batchLine,
                serialbatchList: batchlistData));
          }
          notifyListeners();

          StockOutDATA2.add(StockOutwardList(
              cardCode: filtersearchData[index].cardCode,
              cardName: '',
              remarks: filtersearchData[index].comments,
              branch: AppConstant.branch,
              docentry: filtersearchData[index].docEntry.toString(),
              docstatus: '',
              documentno: filtersearchData[index].docNum.toString(),
              reqfromWhs: filtersearchData[index].uwhsCode,
              reqtoWhs: filtersearchData[index].toWhsCode,
              reqtransdate: filtersearchData[index].docDate,
              data: stockDetails2,
              sapbaceDocentry: ''));
          StockOutward2.addAll(StockOutDATA2);
          searchLoading = false;
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

  List<AutoSelectModlData>? openAutoSelect;
  String itemCode = '';
  String noMsgText = '';

  List<FetchFromPdaModelData> fetchBatchData = [];
  List<StockOutSerialbatch>? serialbatchList = [];
  List<StockOutSerialbatch>? filterSerialbatchList = [];

  callFetchFromPdaAllApi(int index, String serialBatch, ThemeData theme,
      BuildContext context) async {
    serialbatchList = [];
    filterSerialbatchList = [];

    serialBatch = searchcon.text.toString();

    OnScanDisable = true;
    batchselectbtndisable = true;
    autoselectbtndisable = false;
    manualselectbtndisable = false;
    noMsgText = '';
    msg = "";
    for (var ix = 0; ix < passdata!.length; ix++) {
      if (passdata![ix].listClr == true) {
        if (selectAll == false) {
          for (var ik = 0; ik < serialbatchList!.length; ik++) {
            if (passdata![ix].itemcode == filterSerialbatchList![ik].itemcode &&
                passdata![ix].lineNo.toString() ==
                    serialbatchList![ik].lineno.toString()) {
              serialbatchList!.removeAt(ik);
            }
          }

          notifyListeners();

          for (var ixx = 0; ixx < filterSerialbatchList!.length; ixx++) {
            if (passdata![ixx].itemcode ==
                    filterSerialbatchList![ixx].itemcode &&
                passdata![ixx].lineNo.toString() ==
                    filterSerialbatchList![ixx].lineno.toString()) {
              filterSerialbatchList!.removeAt(ixx);
            }
          }
        }

        double balQty = double.parse(qtymycontroller[ix].text.toString());
        double scnQty = 0;
        await FetchBatchPdaApi.getGlobalData(
                StockOutward[index].data[ix].baseDocline.toString(),
                StockOutward[index].data[ix].baseDocentry.toString(),
                StockOutward[index].data[ix].balQty.toString(),
                1250000001)
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            fetchBatchData = value.fetchBatchData!;
            log('openAutoSelectopenAutoSelect::${fetchBatchData.length}');
            if (fetchBatchData.isNotEmpty) {
              for (var i = 0; i < fetchBatchData.length; i++) {
                if (balQty >= fetchBatchData[i].pickedQty) {
                  serialbatchList!.add(StockOutSerialbatch(
                    lineno: StockOutward[index].data[ix].lineNo.toString(),
                    baseDocentry:
                        StockOutward[index].data[ix].baseDocentry.toString(),
                    itemcode: StockOutward[index].data[ix].itemcode,
                    qty: fetchBatchData[i].pickedQty,
                    serialbatch: fetchBatchData[i].batchNum.toString(),
                    docstatus: null,
                    docentry: '',
                  ));
                  StockOutward[index].data[ix].serialbatchList =
                      serialbatchList;
                  balQty = balQty - fetchBatchData[i].pickedQty;

                  notifyListeners();
                } else {
                  serialbatchList!.add(StockOutSerialbatch(
                    lineno: StockOutward[index].data[ix].lineNo.toString(),
                    baseDocentry:
                        StockOutward[index].data[ix].baseDocentry.toString(),
                    itemcode: StockOutward[index].data[ix].itemcode,
                    qty: balQty,
                    serialbatch: fetchBatchData[i].batchNum.toString(),
                    docstatus: null,
                    docentry: '',
                  ));
                  StockOutward[index].data[ix].serialbatchList =
                      serialbatchList;
                  notifyListeners();

                  break;
                }
              }
              await mapItemCodeWiseSoItemData(ix);

              if (serialbatchList != null) {
                for (var id = 0; id < serialbatchList!.length; id++) {
                  if (serialbatchList![id].lineno.toString() ==
                          passdata![ix].lineNo.toString() &&
                      serialbatchList![id].itemcode.toString() ==
                          passdata![ix].itemcode.toString()) {
                    scnQty = scnQty +
                        double.parse(serialbatchList![id].qty.toString());

                    qtymycontroller[ix].text = scnQty.toString();
                    passdata![ix].Scanned_Qty = scnQty;
                    passdata![ix].insertValue = true;
                    passdata![ix].serialbatchList = serialbatchList;
                  }
                }
              }
            } else {
              noMsgText = value.error!;
              notifyListeners();
            }
          }
        });
      }
    }
    notifyListeners();

    OnScanDisable = false;
    serialBatch = "";

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  callFetchFromItemApi(int index, String serialBatch, ThemeData theme, int ix,
      BuildContext context) async {
    serialBatch = searchcon.text.toString();

    OnScanDisable = true;
    batchselectbtndisable = true;
    autoselectbtndisable = false;
    manualselectbtndisable = false;
    noMsgText = '';
    msg = "";
    if (selectItemIndex == ix) {
      if (selectAll == false) {
        for (var ik = 0; ik < serialbatchList!.length; ik++) {
          if (passdata![ix].itemcode == filterSerialbatchList![ik].itemcode &&
              passdata![ix].lineNo.toString() ==
                  serialbatchList![ik].lineno.toString()) {
            serialbatchList!.removeAt(ik);
          }
        }

        notifyListeners();

        for (var ix = 0; ix < filterSerialbatchList!.length; ix++) {
          if (passdata![ix].itemcode == filterSerialbatchList![ix].itemcode &&
              passdata![ix].lineNo.toString() ==
                  filterSerialbatchList![ix].lineno.toString()) {
            filterSerialbatchList!.removeAt(ix);
          }
        }
      }

      notifyListeners();
    }

    double balQty = StockOutward[index].data[ix].balQty!;
    double scnQty = 0;
    await FetchBatchPdaApi.getGlobalData(
            StockOutward[index].data[ix].baseDocline.toString(),
            StockOutward[index].data[ix].baseDocentry.toString(),
            StockOutward[index].data[ix].balQty.toString(),
            1250000001)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        fetchBatchData = value.fetchBatchData!;
        log('openAutoSelectopenAutoSelect::${fetchBatchData.length}');
        if (fetchBatchData.isNotEmpty) {
          for (var i = 0; i < fetchBatchData.length; i++) {
            if (balQty >= fetchBatchData[i].pickedQty) {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[i].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[i].baseDocentry.toString(),
                itemcode: StockOutward[index].data[i].itemcode,
                qty: fetchBatchData[i].pickedQty,
                serialbatch: fetchBatchData[i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[ix].serialbatchList = serialbatchList;
              balQty = balQty - fetchBatchData[i].pickedQty;

              notifyListeners();
            } else {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[ix].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[ix].baseDocentry.toString(),
                itemcode: StockOutward[index].data[ix].itemcode,
                qty: balQty,
                serialbatch: fetchBatchData[i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[ix].serialbatchList = serialbatchList;
              notifyListeners();
              break;
            }
          }
          await mapItemCodeWiseSoItemData(ix);

          if (serialbatchList != null) {
            for (var id = 0; id < serialbatchList!.length; id++) {
              if (serialbatchList![id].lineno.toString() ==
                      passdata![ix].lineNo.toString() &&
                  serialbatchList![id].itemcode.toString() ==
                      passdata![ix].itemcode.toString()) {
                scnQty =
                    scnQty + double.parse(serialbatchList![id].qty.toString());

                qtymycontroller[ix].text = scnQty.toString();
                passdata![ix].Scanned_Qty = scnQty;
                passdata![ix].insertValue = true;
                passdata![ix].serialbatchList = serialbatchList;
              }
            }
          }
        } else {
          noMsgText = value.error!;
          notifyListeners();
        }
      }
    });

    notifyListeners();

    OnScanDisable = false;
    serialBatch = "";

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  autoscanmethodAll(int index, String serialBatch) async {
    openAutoSelect = [];
    batchselectbtndisable = false;
    autoselectbtndisable = true;
    manualselectbtndisable = false;
    serialbatchList = [];
    filterSerialbatchList = [];
    double balQty = 0;
    double scnQty = 0;
    print("AAAA1:" + balQty.toString());
    print("AAAA1:" + serialBatch.toString());
    msg = "";
    serialBatch = searchcon.text.toString();
    OnScanDisable = true;

    for (var ix = 0; ix < passdata!.length; ix++) {
      if (passdata![ix].listClr == true) {
        await AutoSelectApi.getGlobalData(passdata![ix].itemcode.toString())
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            if (value.openOutwardData!.isNotEmpty) {
              openAutoSelect = value.openOutwardData!;
            } else {
              msg = "No Qty Does Not Have...!!";
            }
          } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
            autoselectbtndisable = false;
          }
        });

        balQty = double.parse(qtymycontroller[ix].text.toString());
        for (var i = 0; i < openAutoSelect!.length; i++) {
          log('passdata:${passdata![ix].itemcode}::openAutoSelect::${openAutoSelect![i].itemCode}');

          log('openAutoSelect![im].remQty::${ix}::${i}::::${openAutoSelect![i].remQty}');
          log('balQtybalQty::${balQty}');
          if (passdata![ix].itemcode == openAutoSelect![i].itemCode &&
              openAutoSelect![i].remQty > 0) {
            if (balQty >= openAutoSelect![i].remQty) {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: passdata![ix].lineNo.toString(),
                baseDocentry: passdata![ix].baseDocentry.toString(),
                itemcode: passdata![ix].itemcode,
                qty: openAutoSelect![i].remQty,
                serialbatch: openAutoSelect![i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));

              balQty = balQty - openAutoSelect![i].remQty;
              openAutoSelect![i].remQty = 0;
              notifyListeners();
            } else {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: passdata![ix].lineNo.toString(),
                baseDocentry: passdata![ix].baseDocentry.toString(),
                itemcode: passdata![ix].itemcode,
                qty: balQty,
                serialbatch: openAutoSelect![i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));

              openAutoSelect![i].remQty = openAutoSelect![i].remQty - balQty;
              balQty = 0;
              notifyListeners();
              break;
            }
          }
        }
      }
    }
    await mapItemCodeWiseSoAllData();
    autoselectbtndisable = false;
    if (serialbatchList!.isNotEmpty) {
      for (var ix = 0; ix < passdata!.length; ix++) {
        scnQty = 0;
        for (var iz = 0; iz < serialbatchList!.length; iz++) {
          if (serialbatchList![iz].itemcode == passdata![ix].itemcode &&
              serialbatchList![iz].lineno.toString() ==
                  passdata![ix].lineNo.toString()) {
            log('serialbatchList![iz].qty.toString()::${serialbatchList![iz].qty.toString()}');
            scnQty = scnQty + double.parse(serialbatchList![iz].qty.toString());
            passdata![ix].Scanned_Qty = scnQty;
            qtymycontroller[ix].text = scnQty.toString();
            passdata![ix].insertValue = true;
            log(' passdata![ix].Scanned_Qty::${passdata![ix].Scanned_Qty}::qtymycontroller::${qtymycontroller[ix].text}');
          }
        }
        passdata![ix].serialbatchList = serialbatchList;
      }
    }
    notifyListeners();

    OnScanDisable = false;
    serialBatch = "";

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  autoscanmethodItem(int index, String serialBatch, int ix) async {
    openAutoSelect = [];
    batchselectbtndisable = false;
    autoselectbtndisable = true;
    manualselectbtndisable = false;
    double balQty = 0;
    double scnQty = 0;
    print("AAAA1:" + balQty.toString());
    print("AAAA1:" + serialBatch.toString());
    msg = "";
    serialBatch = searchcon.text.toString();

    OnScanDisable = true;
    if (passdata![ix].listClr == true && qtymycontroller[ix].text.isNotEmpty) {
      for (var ik = 0; ik < serialbatchList!.length; ik++) {
        if (passdata![ix].itemcode == serialbatchList![ik].itemcode &&
            passdata![ix].lineNo.toString() ==
                serialbatchList![ik].lineno.toString()) {
          serialbatchList!.removeAt(ik);
        }
      }
      for (var ixx = 0; ixx < filterSerialbatchList!.length; ixx++) {
        if (passdata![ixx].itemcode == filterSerialbatchList![ixx].itemcode &&
            passdata![ixx].lineNo.toString() ==
                filterSerialbatchList![ixx].lineno.toString()) {
          filterSerialbatchList!.removeAt(ixx);
        }
      }
      notifyListeners();
    }
    balQty = double.parse(qtymycontroller[ix].text.toString());

    await AutoSelectApi.getGlobalData(passdata![ix].itemcode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openAutoSelect = value.openOutwardData!;
        log('openAutoSelectopenAutoSelect::${openAutoSelect!.length}');
        if (openAutoSelect!.isNotEmpty) {
          for (var i = 0; i < openAutoSelect!.length; i++) {
            if (balQty >= openAutoSelect![i].qty) {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[ix].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[ix].baseDocentry.toString(),
                itemcode: StockOutward[index].data[ix].itemcode,
                qty: openAutoSelect![i].qty,
                serialbatch: openAutoSelect![i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[ix].serialbatchList = serialbatchList;
              balQty = balQty - openAutoSelect![i].qty;
              notifyListeners();
            } else {
              serialbatchList!.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[ix].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[ix].baseDocentry.toString(),
                itemcode: StockOutward[index].data[ix].itemcode,
                qty: balQty,
                serialbatch: openAutoSelect![i].batchNum.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[ix].serialbatchList = serialbatchList;
              notifyListeners();
              break;
            }
          }
          await mapItemCodeWiseSoItemData(ix);

          if (serialbatchList != null) {
            for (var id = 0; id < serialbatchList!.length; id++) {
              if (serialbatchList![id].lineno.toString() ==
                      passdata![ix].lineNo.toString() &&
                  serialbatchList![id].itemcode.toString() ==
                      passdata![ix].itemcode.toString()) {
                scnQty =
                    scnQty + double.parse(serialbatchList![id].qty.toString());

                qtymycontroller[ix].text = scnQty.toString();
                passdata![ix].Scanned_Qty = scnQty;
                passdata![ix].insertValue = true;
                passdata![ix].serialbatchList = serialbatchList;
              }
            }
          }
        } else {
          msg = "No Qty Does Not Have...!!";
          for (int im = 0;
              im < StockOutward[index].data[ix].serialbatchList!.length;
              im++) {
            if (StockOutward[index].data[ix].serialbatchList![im].serialbatch ==
                serialBatch) {
              qtymycontroller[im].text = 1.toString();
            }
          }
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        autoselectbtndisable = false;
      }
    });

    notifyListeners();

    OnScanDisable = false;
    serialBatch = "";

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  List<TextEditingController> manualQtyCtrl =
      List.generate(500, (ij) => TextEditingController());
  bool extraqty = false;
  int? selectItemIndex;
  mapItemCodeWiseSoAllData() {
    filterSerialbatchList = [];

    log('soScanItemsoScanItem length::${serialbatchList!.length}');
    for (var i = 0; i < serialbatchList!.length; i++) {
      filterSerialbatchList!.add(StockOutSerialbatch(
        lineno: serialbatchList![i].lineno,
        baseDocentry: serialbatchList![i].baseDocentry.toString(),
        itemcode: serialbatchList![i].itemcode,
        qty: serialbatchList![i].qty,
        serialbatch: serialbatchList![i].serialbatch,
        docstatus: null,
        docentry: '',
      ));
    }

    log('soFilterScanItemsoFilterScanItem::${filterSerialbatchList!.length}');
    notifyListeners();
  }

  List<String> addIndex = [];

  selectSameItemCode(int i) {
    if (passdata![i].listClr == true) {
      qtymycontroller[i].text = '';

      passdata![i].listClr = false;
      log('message22222');
      notifyListeners();
    } else if (passdata![i].listClr == false) {
      qtymycontroller[i].text = passdata![i].balQty.toString();

      passdata![i].listClr = true;
      notifyListeners();
      log('message111');
    }
    mapItemCodeWiseSoItemData(i);
    notifyListeners();
  }

  newadditemlistcount() {
    addIndex = [];

    for (var ik = 0; ik < passdata!.length; ik++) {
      if (passdata![ik].listClr == true) {
        addIndex.add(ik.toString());
        notifyListeners();
      }
    }
    notifyListeners();
  }

  mapItemCodeWiseSoItemData(int index) {
    autoselectbtndisable = false;
    manualselectbtndisable = false;
    batchselectbtndisable = false;

    filterSerialbatchList = [];
    log('soScanItemsoScanItem length::${serialbatchList!.length}');
    for (var i = 0; i < serialbatchList!.length; i++) {
      if (passdata![index].itemcode == serialbatchList![i].itemcode &&
          passdata![index].lineNo.toString() ==
              serialbatchList![i].lineno.toString()) {
        filterSerialbatchList!.add(StockOutSerialbatch(
          lineno: serialbatchList![i].lineno,
          baseDocentry: serialbatchList![i].baseDocentry.toString(),
          itemcode: serialbatchList![i].itemcode,
          qty: serialbatchList![i].qty,
          serialbatch: serialbatchList![i].serialbatch,
          docstatus: null,
          docentry: '',
        ));
      }
    }

    log('soFilterScanItemsoFilterScanItem::${filterSerialbatchList!.length}');
    notifyListeners();
  }

  manualscanmethod(int ih, String serialBatch, int ix, ThemeData theme,
      BuildContext context) async {
    manualQtyCtrl = List.generate(500, (ij) => TextEditingController());
    openAutoSelect = [];
    batchselectbtndisable = false;
    autoselectbtndisable = false;
    manualselectbtndisable = true;
    double balQty = 0;
    print("AAAA1:" + balQty.toString());
    print("AAAA1:" + serialBatch.toString());
    msg = "";
    serialBatch = searchcon.text.toString();

    OnScanDisable = true;
    if (selectItemIndex == ix) {
      for (var ik = 0; ik < serialbatchList!.length; ik++) {
        if (passdata![ix].itemcode == serialbatchList![ik].itemcode &&
            passdata![ix].lineNo.toString() ==
                serialbatchList![ik].lineno.toString()) {
          serialbatchList!.removeAt(ik);
        }
      }

      for (var ixx = 0; ixx < filterSerialbatchList!.length; ixx++) {
        if (passdata![ixx].itemcode == filterSerialbatchList![ixx].itemcode &&
            passdata![ixx].lineNo.toString() ==
                filterSerialbatchList![ixx].lineno.toString()) {
          filterSerialbatchList!.removeAt(ixx);
        }
      }

      notifyListeners();
    }
    balQty = double.parse(qtymycontroller[ix].text.toString());

    await AutoSelectApi.getGlobalData(passdata![ix].itemcode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openAutoSelect = value.openOutwardData!;
        log('openAutoSelectopenAutoSelect::${openAutoSelect!.length}');
        if (openAutoSelect!.isNotEmpty) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  title: Container(
                    width: Screens.width(context) * 0.5,
                    padding: EdgeInsets.only(
                      left: Screens.width(context) * 0.02,
                    ),
                    alignment: Alignment.centerRight,
                    height: Screens.padingHeight(context) * 0.05,
                    color: theme.primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Requested Qty ${passdata![ix].balQty!}',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        IconButton(
                            onPressed: () {
                              autoselectbtndisable = false;
                              manualselectbtndisable = false;
                              batchselectbtndisable = false;
                              Get.back();
                              notifyListeners();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            )),
                      ],
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: Screens.padingHeight(context) * 0.55,
                          width: Screens.width(context) * 0.5,
                          child: ListView.builder(
                              itemCount: openAutoSelect!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: GestureDetector(
                                    onTap: () async {},
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 3, right: 3),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(openAutoSelect![index]
                                                    .itemCode),
                                                Text(openAutoSelect![index]
                                                    .qty
                                                    .toString()),
                                                Container(
                                                    width:
                                                        Screens.width(context) *
                                                            0.056,
                                                    height:
                                                        Screens.padingHeight(
                                                                context) *
                                                            0.053,
                                                    child: TextFormField(
                                                      onTap: () {
                                                        manualQtyCtrl[index]
                                                                .text =
                                                            manualQtyCtrl[index]
                                                                .text;

                                                        manualQtyCtrl[index]
                                                                .selection =
                                                            TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset:
                                                              manualQtyCtrl[
                                                                      index]
                                                                  .text
                                                                  .length,
                                                        );
                                                      },
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (val) {
                                                        doubleDotMethodManualselect(
                                                            index, val);
                                                      },
                                                      inputFormatters: [
                                                        DecimalInputFormatter()
                                                      ],
                                                      onEditingComplete: () {
                                                        disableKeyBoard(
                                                            context);
                                                      },
                                                      controller:
                                                          manualQtyCtrl[index],
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 15),
                                                        hintText: "",
                                                        hintStyle: theme
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey[600]),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                              child: Row(
                                            children: [
                                              Text(
                                                  '${openAutoSelect![index].batchNum}  |  '),
                                              Text(openAutoSelect![index]
                                                  .itemName
                                                  .toString()),
                                            ],
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              double scnQty = 0;
                              await onTapSoBtn(ih);
                              log('extraqtyextraqty222::$extraqty');
                              if (extraqty == true) {
                                await showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                            payMent: 'Alert',
                                            errormsg: true,
                                            widget: Center(
                                                child: ContentContainer(
                                              content:
                                                  'Allocation qty is grater than requested qty',
                                              theme: theme,
                                            )),
                                            buttonName: null,
                                          ));
                                    }).then((value) {
                                  extraqty = false;
                                });
                                notifyListeners();
                              } else {
                                for (var xx = 0;
                                    xx < openAutoSelect!.length;
                                    xx++) {
                                  log('manualQtyCtrl[xx].text::${manualQtyCtrl[xx].text}');
                                  if (manualQtyCtrl[xx].text.isNotEmpty) {
                                    if (manualQtyCtrl[xx].text != '0') {
                                      serialbatchList!.add(StockOutSerialbatch(
                                        lineno: StockOutward[ih]
                                            .data[ix]
                                            .lineNo
                                            .toString(),
                                        baseDocentry: StockOutward[ih]
                                            .data[ix]
                                            .baseDocentry
                                            .toString(),
                                        itemcode:
                                            StockOutward[ih].data[ix].itemcode,
                                        qty: double.parse(
                                            manualQtyCtrl[xx].text),
                                        serialbatch: openAutoSelect![xx]
                                            .batchNum
                                            .toString(),
                                        docstatus: null,
                                        docentry: '',
                                      ));
                                      StockOutward[ih]
                                          .data[ix]
                                          .serialbatchList = serialbatchList;
                                      balQty = balQty - openAutoSelect![xx].qty;
                                      notifyListeners();
                                    }
                                  }
                                }
                                mapItemCodeWiseSoItemData(ix);

                                if (serialbatchList!.isNotEmpty) {
                                  for (var iz = 0;
                                      iz < serialbatchList!.length;
                                      iz++) {
                                    if (serialbatchList![iz].itemcode ==
                                            passdata![ix].itemcode &&
                                        serialbatchList![iz]
                                                .lineno
                                                .toString() ==
                                            StockOutward[ih]
                                                .data[ix]
                                                .lineNo
                                                .toString()) {
                                      scnQty = scnQty +
                                          double.parse(serialbatchList![iz]
                                              .qty
                                              .toString());
                                      passdata![ix].Scanned_Qty = scnQty;
                                      passdata![ix].insertValue = true;

                                      qtymycontroller[ix].text =
                                          scnQty.toString();
                                      passdata![ix].serialbatchList =
                                          serialbatchList;
                                      log(' passdata![ix].Scanned_Qty::${passdata![ix].Scanned_Qty}::qtymycontroller::${qtymycontroller[iz].text}');
                                    }
                                  }
                                }
                                disableKeyBoard(context);
                              }
                              Get.back();
                            },
                            child: Container(
                                width: Screens.width(context) * 0.5,
                                alignment: Alignment.center,
                                height: Screens.padingHeight(context) * 0.05,
                                child: const Text('OK')))
                      ],
                    ),
                  ),
                );
              });
        } else {
          msg = "No Qty Does Not Have...!!";
          for (int im = 0;
              im < StockOutward[ih].data[ix].serialbatchList!.length;
              im++) {
            if (StockOutward[ih].data[ix].serialbatchList![im].serialbatch ==
                serialBatch) {
              qtymycontroller[im].text = 1.toString();
            }
          }
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        autoselectbtndisable = false;
      }
    });

    notifyListeners();

    OnScanDisable = false;
    serialBatch = "";

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  onTapSoBtn(
    int ih,
  ) {
    double qty = 0;
    double qty2 = 0;

    for (var xx = 0; xx < openAutoSelect!.length; xx++) {
      qty = 0;

      if (manualQtyCtrl[xx].text.isNotEmpty) {
        if (manualQtyCtrl[xx].text != '0') {
          qty = double.parse(manualQtyCtrl[xx].text.toString());
          qty2 = qty2 + qty;

          if (qty2 <= double.parse(qtymycontroller[ih].text.toString())) {
            extraqty = false;
          } else {
            log('qtyqtyqtyqty22:$qty2');
            extraqty = true;
            break;
          }
        }
        notifyListeners();
      }
    }

    log('extraqtyextraqtyextraqty:$extraqty');
  }

  getBatchData(int index, int list_i) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBStOutBatchData =
        await DBOperation.stOutCheckScanData(
            //com
            db,
            StockOutward[index].data[list_i].baseDocentry,
            StockOutward[index].data[list_i].docentry,
            StockOutward[index].data[list_i].lineNo,
            StockOutward[index].data[list_i].itemcode);
    print(getDBStOutBatchData.length);
    if (getDBStOutBatchData.isNotEmpty) {
      StockOutward[index].data[list_i].serialbatchList = [];
      for (int i = 0; i < getDBStOutBatchData.length; i++) {
        StockOutward[index]
            .data[list_i]
            .serialbatchList!
            .add(StockOutSerialbatch(
              lineno: getDBStOutBatchData[i]["lineno"].toString(),
              baseDocentry: getDBStOutBatchData[i]["baseDocentry"].toString(),
              itemcode: getDBStOutBatchData[i]["itemcode"].toString(),
              qty: getDBStOutBatchData[i]["quantity"] == null
                  ? 0
                  : double.parse(getDBStOutBatchData[i]["quantity"].toString()),
              scanbool: true,
              serialbatch: getDBStOutBatchData[i]["serialBatch"].toString(),
            ));
      }
      OnScanDisable = false;
      notifyListeners();
    } else {
      StockOutward[index].data[list_i].serialbatchList = [];
    }

    notifyListeners();
  }

  Future stoutLineRefersh(
      int index, List<StockOutSerialbatch>? serialbatchList2) async {
    double totalscannedQty = 0;

    for (var ix = 0; ix < passdata!.length; ix++) {
      StockOutward[index].data[ix].serialbatchList = serialbatchList;

      if (StockOutward[index].data[ix].serialbatchList != null) {
        totalscannedQty = 0;
        for (int i = 0;
            i < StockOutward[index].data[ix].serialbatchList!.length;
            i++) {
          if (StockOutward[index].data[ix].serialbatchList![i].itemcode ==
              StockOutward[index].data[ix].itemcode) {
            qtymycontroller[i].text = StockOutward[index]
                .data[ix]
                .serialbatchList![i]
                .qty!
                .toString();
            totalscannedQty = totalscannedQty +
                StockOutward[index].data[ix].serialbatchList![i].qty!;
          }

          StockOutward[index].data[ix].serialbatchList = serialbatchList2;
          StockOutward[index].data[ix].Scanned_Qty = totalscannedQty;
        }
      }
    }
    searchcon.clear();
    notifyListeners();
  }

  Future<List<StockSnapTModelDB>> getAllList(String data) async {
    getSearchedData = [];
    getfilterSearchedData = [];
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockListBatch(db, data);
    if (getSearchedData.isNotEmpty) {
      searchError = "";
      getfilterSearchedData = getSearchedData;

      return getSearchedData;
    } else {
      searchError = "No data Found..!!";
      getSearchedData = [];
      getfilterSearchedData = [];
      searchcon.clear();
      return getSearchedData;
    }
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      getfilterSearchedData = getSearchedData
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemname!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      getfilterSearchedData = getSearchedData;
      notifyListeners();
    }
  }

  Future scanqtyRemove(int index, int list_i, int batchI) async {
    StockOutward[index].data[list_i].serialbatchList![batchI].qty =
        StockOutward[index].data[list_i].serialbatchList![batchI].qty! - 1;
    msg = "";
    notifyListeners();
    if (StockOutward[index].data[list_i].serialbatchList![batchI].qty! == 0) {
      StockOutward[index].data[list_i].serialbatchList!.removeAt(batchI);
    }
    notifyListeners();
  }

  searchInitMethod() {
    StOutController[100].text = config.alignDate(config.currentDate());
    StOutController[101].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchOutData
          .where((e) =>
              e.docNum.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.docDate.toString().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersearchData = searchOutData;
      notifyListeners();
    }
  }

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockoutHeader =
        await DBOperation.getStockOutHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();

    if (getStockoutHeader.isNotEmpty) {
      for (int i = 0; i < getStockoutHeader.length; i++) {
        searchdata2.add(searchModel(
            username: UserValues.username,
            terminal: AppConstant.terminal,
            type: getStockoutHeader[i]["docstatus"] == null
                ? ""
                : getStockoutHeader[i]["docstatus"] == "2"
                    ? "Against Order"
                    : getStockoutHeader[i]["docstatus"] == "3"
                        ? "Against Stock"
                        : "",
            qStatus: getStockoutHeader[i]["qStatus"] == null
                ? ""
                : getStockoutHeader[i]["qStatus"].toString(),
            docentry: getStockoutHeader[i]["docentry"] == null
                ? 0
                : int.parse(getStockoutHeader[i]["docentry"].toString()),
            docNo: getStockoutHeader[i]["reqdocno"] == null
                ? '0'
                : getStockoutHeader[i]["reqdocno"].toString(),
            docDate: getStockoutHeader[i]["createdateTime"].toString(),
            sapNo: getStockoutHeader[i]["sapDocNo"] == null
                ? 0
                : int.parse(getStockoutHeader[i]["sapDocNo"].toString()),
            sapDate: getStockoutHeader[i]["createdateTime"] == null
                ? ""
                : getStockoutHeader[i]["createdateTime"].toString(),
            customeraName: getStockoutHeader[i]["reqfromWhs"].toString(),
            doctotal: getStockoutHeader[i][""] == null
                ? 0
                : double.parse(getStockoutHeader[i][""].toString())));
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

  fixDataMethod(int docentry) async {
    StockOutward2.clear();
    StOutController2[50].text = "";
    if (isselect == true) {
      isselect = false;
    }
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader2(db, docentry);
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.stOutLineDB(db, docentry);
    List<StockOutwardList> StockOutDATA2 = [];
    List<StockOutwardDetails> stockDetails2 = [];

    for (int j = 0; j < getDB_StoutLine.length; j++) {
      List<StockOutSerialbatch> stoutSeralBatchList = [];

      stockDetails2.add(StockOutwardDetails(
          createdUserID: 1,
          createdateTime: getDB_StoutLine[j]["createdateTime"].toString(),
          baseDocentry:
              int.parse(getDB_StoutLine[j]["baseDocentry"].toString()),
          docentry: int.parse(getDB_StoutLine[j]["docentry"].toString()),
          dscription: getDB_StoutLine[j]["description"].toString(),
          itemcode: getDB_StoutLine[j]["itemcode"].toString(),
          lastupdateIp: "",
          lineNo: getDB_StoutLine[j]["lineno"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["lineno"].toString()),
          qty: getDB_StoutLine[j]["quantity"] == null
              ? 0
              : double.parse(getDB_StoutLine[j]["quantity"].toString()),
          status: getDB_StoutLine[j]["createdateTime"].toString(),
          updatedDatetime: getDB_StoutLine[j]["createdateTime"].toString(),
          updateduserid: 1,
          price: 1,
          serialBatch: getDB_StoutLine[j]["serialBatch"].toString(),
          taxRate: 0.0,
          taxType: "",
          trans_Qty: getDB_StoutLine[j]["transferQty"] == null
              ? 0
              : double.parse(getDB_StoutLine[j]["transferQty"].toString()),
          Scanned_Qty: getDB_StoutLine[j]["scannedQty"] == null
              ? 0
              : double.parse(getDB_StoutLine[j]["scannedQty"].toString()),
          baseDocline: getDB_StoutLine[j]["baseDocline"] == null
              ? 0
              : int.parse(getDB_StoutLine[j]["baseDocline"].toString()),
          serialbatchList: stoutSeralBatchList));
    }
    StOutController2[50].text = getDB_StoutHeader[0]["remarks"].toString();
    StockOutDATA2.add(StockOutwardList(
        cardCode: getDB_StoutHeader[0]["CardCode"].toString(),
        cardName: '',
        remarks: getDB_StoutHeader[0]["remarks"].toString(),
        branch: getDB_StoutHeader[0]["branch"].toString(),
        docentry: getDB_StoutHeader[0]["docentry"].toString(),
        baceDocentry: getDB_StoutHeader[0]["baceDocentry"].toString(),
        docstatus: getDB_StoutHeader[0]["baceDocentry"].toString(),
        documentno: getDB_StoutHeader[0]["documentno"] == null
            ? "0"
            : getDB_StoutHeader[0]["documentno"].toString(),
        reqfromWhs: getDB_StoutHeader[0]["reqfromWhs"].toString(),
        reqtoWhs: getDB_StoutHeader[0]["reqtoWhs"].toString(),
        reqtransdate: getDB_StoutHeader[0]["transdate"].toString(),
        data: stockDetails2,
        sapbaceDocentry: ''));

    StockOutward2.addAll(StockOutDATA2);
    notifyListeners();
  }

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      StOutController[100].text = datetype!;
      print(datetype);
    } else if (datetype == "To") {
      print(pickedDate);
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      StOutController[101].text = datetype!;
      print(datetype);
    } else {
      print("Date is not selected");
    }
  }

  int qqqttyy = 0;
  qqqqq(int index, String serialBatch, int list_i, String itemcode, im) {
    qqqttyy = 0;

    for (int im = 0;
        im < StockOutward[index].data[list_i].serialbatchList!.length;
        im++) {
      if (StockOutward[index].data[list_i].itemcode ==
          StockOutward[index].data[list_i].serialbatchList![im].itemcode) {
        qqqttyy = qqqttyy + int.parse(qtymycontroller[im].text);
        //log("qqqttyyqqqttyy:::${qqqttyy}");
        notifyListeners();
      }
    }
    notifyListeners();
  }

  stkOutEditQty(
      int index, String serialBatch, int list_i, String itemcode, im) async {
    final Database db = (await DBHelper.getInstance())!;
    msg = '';
    List<Map<String, Object?>> serailbatchCheck =
        await DBOperation.serialBatchCheck(
            db,
            serialBatch.toString().trim(), //com
            StockOutward[index].data[list_i].itemcode.toString());
    if (serailbatchCheck.isNotEmpty) {
      if (int.parse(serailbatchCheck[0]["quantity"].toString()) != 0) {
        if (int.parse(qtymycontroller[im].text) != 0) {
          int editqqty = int.parse(qtymycontroller[im].text);
          qqqqq(index, serialBatch, list_i, itemcode, im);
          if (qqqttyy <=
              int.parse(serailbatchCheck[0]["quantity"].toString())) {
            if (qqqttyy <= StockOutward[index].data[list_i].balQty!) {
              qtymycontroller[im].text = editqqty.toString();
              StockOutward[get_i_value]
                  .data[batch_i!]
                  .serialbatchList![im]
                  .qty = double.parse(qtymycontroller[im].text);

              notifyListeners();
            } else {
              qtymycontroller[im].text = 1.toString();
              msg = "No Qty Does Not Have...!!";

              notifyListeners();
            }
          } else {
            qtymycontroller[im].text = 1.toString();
            msg = "No Qty Does Not Have...!!";
            notifyListeners();
          }
        } else {
          qtymycontroller.removeAt(im);
          StockOutward[index].data[list_i].serialbatchList!.removeAt(im);
          notifyListeners();
        }
      }
    }
    notifyListeners();
  }

  scanmethod(int index, String serialBatch, int list_i, String itemcode) async {
    print("AAAA1:" + index.toString());
    print("AAAA1:" + serialBatch.toString());
    print("AAAA1:" + list_i.toString());
    print("AAAA1:" + itemcode.toString());
    msg = "";
    serialBatch = searchcon.text.toString();
    if (itemcode == StockOutward[index].data[list_i].itemcode.toString()) {
      print("AAAA2:" + list_i.toString());
      OnScanDisable = true;

      final Database db = (await DBHelper.getInstance())!;
      msg = "";
      List<Map<String, Object?>> serailbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              serialBatch.toString().trim(), //com
              StockOutward[index].data[list_i].itemcode.toString());
      if (serailbatchCheck.isNotEmpty) {
        if (int.parse(serailbatchCheck[0]["quantity"].toString()) != 0) {
          print("AAAA3:" + serialBatch);

          int totalqty = int.parse(serailbatchCheck[0]["quantity"].toString());
          double separateBatchQty = 0;
          double totalscanqty =
              StockOutward[index].data[list_i].trans_Qty!; //newchange
          bool AlreadyScan = false;

          if (StockOutward[index].data[list_i].serialbatchList != null) {
            for (int i = 0;
                i < StockOutward[index].data[list_i].serialbatchList!.length;
                i++) {
              if (serialBatch ==
                  StockOutward[index]
                      .data[list_i]
                      .serialbatchList![i]
                      .serialbatch) {
                separateBatchQty =
                    StockOutward[index].data[list_i].serialbatchList![i].qty!;
                qtymycontroller[i].text =
                    (int.parse(qtymycontroller[i].text.toString()) + 1)
                        .toString();
              }

              totalscanqty = totalscanqty +
                  StockOutward[index].data[list_i].serialbatchList![i].qty!;
              AlreadyScan = true;
              notifyListeners();
            }
          }
          if ((totalqty > separateBatchQty) &&
              (StockOutward[index].data[list_i].qty != totalscanqty)) {
            print("AAAA4:");
            List<StockOutSerialbatch> serialbatchList = [];

            msg = "";
            if (AlreadyScan == false) {
              print("AAAA5:");

              serialbatchList.add(StockOutSerialbatch(
                lineno: StockOutward[index].data[list_i].lineNo.toString(),
                baseDocentry:
                    StockOutward[index].data[list_i].baseDocentry.toString(),
                itemcode: StockOutward[index].data[list_i].itemcode,
                qty: 1,
                serialbatch: serialBatch.toString(),
                docstatus: null,
                docentry: '',
              ));
              StockOutward[index].data[list_i].serialbatchList =
                  serialbatchList;

              for (int im = 0;
                  im < StockOutward[index].data[list_i].serialbatchList!.length;
                  im++) {
                qtymycontroller[im].text = StockOutward[index]
                    .data[list_i]
                    .serialbatchList![im]
                    .qty!
                    .toString();
              }
            } else {
              int? count = await ExistingBatchCheck(index, list_i, serialBatch);

              if (count != null) {
                StockOutward[index].data[list_i].serialbatchList![count].qty =
                    StockOutward[index]
                            .data[list_i]
                            .serialbatchList![count]
                            .qty! +
                        1;
              } else {
                StockOutward[index]
                    .data[list_i]
                    .serialbatchList!
                    .add(StockOutSerialbatch(
                      lineno:
                          StockOutward[index].data[list_i].lineNo.toString(),
                      baseDocentry: StockOutward[index]
                          .data[list_i]
                          .baseDocentry
                          .toString(),
                      itemcode: StockOutward[index].data[list_i].itemcode,
                      qty: 1,
                      serialbatch: serialBatch.toString(),
                      docstatus: null,
                      docentry: '',
                    ));
                for (int im = 0;
                    im <
                        StockOutward[index]
                            .data[list_i]
                            .serialbatchList!
                            .length;
                    im++) {
                  if (StockOutward[index]
                          .data[list_i]
                          .serialbatchList![im]
                          .serialbatch ==
                      serialBatch) {
                    qtymycontroller[im].text = StockOutward[index]
                        .data[list_i]
                        .serialbatchList![im]
                        .qty!
                        .toString();
                  }
                }
              }
            }
          } else {
            msg = 'No More Qty to add...!!';
            for (int im = 0;
                im < StockOutward[index].data[list_i].serialbatchList!.length;
                im++) {
              if (StockOutward[index]
                      .data[list_i]
                      .serialbatchList![im]
                      .serialbatch ==
                  serialBatch) {
                qtymycontroller[im].text = 1.toString();
              }
            }
          }
        } else {
          msg = "No Qty Does Not Have...!!";
          for (int im = 0;
              im < StockOutward[index].data[list_i].serialbatchList!.length;
              im++) {
            if (StockOutward[index]
                    .data[list_i]
                    .serialbatchList![im]
                    .serialbatch ==
                serialBatch) {
              qtymycontroller[im].text = 1.toString();
            }
          }
        }

        notifyListeners();
      } else {
        msg = 'Wrong BatchCode Scan...!!';
      }
      OnScanDisable = false;
      serialBatch = "";
    } else {
      msg = "Itemcode Does not Matched...!!";
      notifyListeners();
    }

    searchcon.clear();
    OnScanDisable = false;
    notifyListeners();
  }

  Future<int?> ExistingBatchCheck(int index, int list_i, String serialBatch) {
    for (int i = 0;
        i < StockOutward[index].data[list_i].serialbatchList!.length;
        i++) {
      if (StockOutward[index].data[list_i].serialbatchList![i].serialbatch ==
              serialBatch.toString().trim() &&
          StockOutward[index].data[list_i].itemcode ==
              StockOutward[index].data[list_i].serialbatchList![i].itemcode) {
        return Future.value(i);
      }
    }
    return Future.value(null);
  }

  suspendedbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
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
                  child: Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
          radius: 5);
    } else if (scannedtottal != 0) {
      StOutController[50].clear();

      for (int i = 0; i < StockOutward[index].data.length; i++) {
        StockOutward[index].data[i].Scanned_Qty = 0;
        StockOutward[index].data[i].serialbatchList = [];

        notifyListeners();
      }
      i_value = index;
    }
    notifyListeners();
  }

  submitbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;

    OnclickDisable = true;
    if (data!.isEmpty) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Please Scan Items..!!',
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 0)
          .then((value) {
        OnclickDisable = false;
        notifyListeners();
      });
    } else if (selectedcust == null) {
      Get.defaultDialog(
              title: "Alert",
              middleText: 'Choose Customers',
              backgroundColor: Colors.white,
              titleStyle:
                  theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
              middleTextStyle: theme.textTheme.bodyLarge,
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ],
              radius: 0)
          .then((value) {
        OnclickDisable = false;
        notifyListeners();
      });
    } else {
      double? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        totalscanqty = data[i].Scanned_Qty!;
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
                        child: Text("Close"),
                        onPressed: () => Get.back(),
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          OnclickDisable = false;
          notifyListeners();
        });
      } else if (totalscanqty != 0) {
        bool? netbool = await config.haveInterNet();

        await DBOperation.deletAlreadyHoldData(
            //com
            db,
            int.parse(StockOutward[index].baceDocentry.toString()));

        if (netbool == true) {
          log('StockOutward[index]1111:::${StockOutward[index].data.length}');

          postingStockOutward(
              '',
              index,
              int.parse(StockOutward[index].baceDocentry!),
              data,
              datatotal,
              context,
              theme);
        }
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

  bool submitBool = false;
  savepartialData(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    OnclickDisable = true;
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = []; //headersss
    List<StockOutLineDataDB> StOutLine = [];
    List<StockOutBatchDataDB> StOutBatch = [];
    submitBool = false;
    double scanToatal = 0;
    double qtyToatal = 0;

    for (int i = 0; i < StockOutward[index].data.length; i++) {
      scanToatal = scanToatal + StockOutward[index].data[i].Scanned_Qty!;
      qtyToatal = qtyToatal + StockOutward[index].data[i].qty!;
      if (scanToatal == qtyToatal) {
        submitBool = true;
        notifyListeners();
      }
    }

    int? counofData = await DBOperation.getcountofTable(
        db, "docentry", "StockOutHeaderDataDB");
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
          db, "docentry", "StockOutHeaderDataDB");
    }

    String docmntNo = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 5);
    List<String> getseriesvalue = await checkingdoc(5);
    int docseries = int.parse(getseriesvalue[1]);

    int nextno = documentN0!;

    documentN0 = docseries + documentN0;

    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

    docmntNo = finlDocnum + documentN0.toString();
    DBOperation.getSaleHeadSapDet(
        db, int.parse(StockOutward[index].baceDocentry!), 'SalesHeader');

    List<Map<String, Object?>> sapdetails = await DBOperation.getSaleHeadSapDet(
        db,
        int.parse(StockOutward[index].baceDocentry.toString()),
        'StockReqHDT');
    log("From warehouse::${StockOutward[index].reqfromWhs}");
    log("to warehouse::${StockOutward[index].reqtoWhs}");

    StOutHeader.add(StockOutHeaderDataDB(
        docentry: docEntryCreated.toString(),
        documentno: docmntNo,
        terminal: AppConstant.terminal,
        branch: AppConstant.branch,
        baseDocentry: StockOutward[index].baceDocentry,
        createdUserID: UserValues.userID,
        createdateTime: config.currentDate(),
        docstatus: '3',
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: StockOutward[index].documentno.toString(),
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: StockOutward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: "",
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
        sapStockReqdocentry: sapdetails[0]['sapDocentry'].toString(),
        sapStockReqdocnum: sapdetails[0]['sapDocNo'].toString(),
        remarks: StOutController[50].text.isEmpty
            ? ""
            : StOutController[50].text.toString(),
        cardCode: selectedcust!.cardCode ?? '',
        cardName: selectedcust!.name ?? ''));

    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);

    await DBOperation.updatenextno(db, 5, nextno);

    for (int i = 0; i < StockOutward[index].data.length; i++) {
      StOutBatch.clear();

      String concatenatedText = '';
      int totalbatchQty = 0;

      if (StockOutward[index].data[i].docentry != null) {
        await DBOperation.deletAlreadyHoldDataLine(
          db,
          int.parse(StockOutward[index].baceDocentry.toString()),
          int.parse(StockOutward[index].docentry.toString()),
          StockOutward[index].data[i].itemcode.toString(),
        );
      }
      if (StockOutward[index].data[i].serialbatchList != null) {
        if (StockOutward[index].data[i].docentry != null) {
          await DBOperation.deleteBatch(
            db,
            int.parse(StockOutward[index].data[i].baseDocentry.toString()),
            int.parse(StockOutward[index].data[i].docentry.toString()),
            StockOutward[index].data[i].itemcode!,
          );
        }
        for (int l = 0;
            l < StockOutward[index].data[i].serialbatchList!.length;
            l++) {
          StOutBatch.add(StockOutBatchDataDB(
            lineno: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .lineno
                .toString(),
            baseDocentry: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .baseDocentry
                .toString(),
            itemcode: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .itemcode
                .toString(),
            qty: StockOutward[index].data[i].serialbatchList![l].qty == null
                ? 0
                : double.parse(StockOutward[index]
                    .data[i]
                    .serialbatchList![l]
                    .qty
                    .toString()),
            serialbatch: StockOutward[index]
                .data[i]
                .serialbatchList![l]
                .serialbatch
                .toString(),
            docentry: docentry2.toString(),
            docstatus: '3',
          ));
          concatenatedText = '';
          concatenatedText += StockOutward[index]
                  .data[i]
                  .serialbatchList![l]
                  .serialbatch
                  .toString() +
              '/';
          totalbatchQty = totalbatchQty +
              int.parse(StockOutward[index]
                  .data[i]
                  .serialbatchList![l]
                  .qty
                  .toString());
        }
      }
      print("Scanned QTY Submit::" +
          StockOutward[index].data[i].Scanned_Qty.toString());
      if (StockOutward[index].data[i].Scanned_Qty != 0) {
        StOutLine.add(StockOutLineDataDB(
          lineno: StockOutward[index].data[i].lineNo.toString(),
          docentry: docentry2.toString(),
          itemcode: StockOutward[index].data[i].itemcode.toString(),
          description: StockOutward[index].data[i].dscription,
          qty: double.parse(StockOutward[index].data[i].qty.toString()),
          inStkQty: double.parse(StockOutward[index].data[i].stock.toString()),
          baseDocentry: StockOutward[index].data[i].baseDocentry.toString(),
          baseDocline: StockOutward[index].data[i].lineNo.toString(),
          status: StockOutward[index].data[i].status,
          traansferQty: 0,
          scannedQty: StockOutward[index].data[i].Scanned_Qty,
          serialBatch: concatenatedText.toString(),
          branch: AppConstant.branch,
          terminal: AppConstant.terminal,
        ));
      }
    }

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      postingStockOutward(
          docstatus,
          index,
          int.parse(StockOutward[index].baceDocentry!),
          data,
          datatotal,
          context,
          theme);
    }
    notifyListeners();
  }

  postingStockOutward(
      String docstatus,
      int index,
      int baseentry,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    await sapLoginApi(context);
    await postOutwardData(
        docstatus, index, baseentry, data, datatotal, context, theme);
    notifyListeners();
  }

  List<StockOutLineModel>? StockOutwardLines = [];
  List<StockOutbatch>? batchTable;
  addBatchtable(
    int index,
  ) {
    batchTable = [];

    for (int ik = 0; ik < serialbatchList!.length; ik++) {
      if (passdata![index].itemcode == serialbatchList![ik].itemcode &&
          passdata![index].lineNo.toString() ==
              serialbatchList![ik].lineno.toString()) {
        batchTable!.add(StockOutbatch(
            quantity: double.parse(serialbatchList![ik].qty.toString()),
            batchNumberProperty: serialbatchList![ik].serialbatch.toString()));
        notifyListeners();
      }
      log('s batch qty' + serialbatchList![ik].qty.toString());
    }

    log('batchTablebatchTable::${batchTable!.length.toString()}');
    notifyListeners();
  }

  addOutLinedata(int index) {
    log('passdatapassdata::${passdata!.length}');
    StockOutwardLines = [];
    batchTable = [];
    for (int i = 0; i < passdata!.length; i++) {
      if (passdata![i].insertValue == true) {
        addBatchtable(i);

        StockOutwardLines!.add(StockOutLineModel(
            fromWarehouseCode: UserValues.branch.toString(),
            itemCode: passdata![i].itemcode.toString(),
            itemDescription: passdata![i].dscription.toString(),
            quantity: double.parse(passdata![i].Scanned_Qty.toString()),
            unitPrice: double.parse(passdata![i].price.toString()),
            toWarehouseCode: StockOutward[index].reqtoWhs.toString(),
            lineNum: i,
            baseDocentry: StockOutward[index].sapbaceDocentry != i
                ? int.parse(StockOutward[index].sapbaceDocentry.toString())
                : 0,
            baseline: passdata![i].baseDocline.toString(),
            batchNumbers: batchTable!,
            baseType: '1250000001'));
      }
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

  postOutwardData(
      String docstatus,
      int index,
      int baseentry,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal,
      BuildContext context,
      ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    var uuid = Uuid();
    String? uuidg = uuid.v1();
    log('message index:::$index');
    seriesType = '';
    await callSeriesApi(context, '67');
    await addOutLinedata(index);
    PostStkOutwardAPi.cardCodePost = selectedcust!.cardCode;
    PostStkOutwardAPi.seriesType = seriesType.toString();
    PostStkOutwardAPi.fromWarehouse = UserValues.branch;
    PostStkOutwardAPi.toWarehouse = StockOutward[index].reqtoWhs;
    PostStkOutwardAPi.ureqWarehouse = StockOutward[index].u_reqWhs;
    PostStkOutwardAPi.comments = StOutController[50].text.toString();
    PostStkOutwardAPi.docDate = config.currentDate();
    PostStkOutwardAPi.dueDate = config.currentDate();
    PostStkOutwardAPi.stockTransferLines = StockOutwardLines;

    PostStkOutwardAPi.method(uuidg);
    notifyListeners();
    await PostStkOutwardAPi.getGlobalData(uuidg).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();

        await DBOperation.updtSapDetSalHead(
            db,
            int.parse(sapDocentry!),
            int.parse(sapDocuNumber!),
            int.parse(sapDocentry!),
            'StockOutHeaderDataDB');

        await updateOutWrdStkSnaptab(
            int.parse(sapDocentry.toString()), int.parse(baseentry.toString()));

        await Get.defaultDialog(
          title: "Success",
          middleText: 'Sucessfully Done \n'
              "Document number $sapDocuNumber",
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          radius: 5,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () {
                    OnclickDisable = false;
                    if (submitBool == true) {
                      StockOutward.clear();

                      StockOutward.remove(datatotal);
                      StockOutward[index].data.clear();
                      data!.clear();
                      StOutController[50].text = "";
                      qtymycontroller =
                          List.generate(500, (ij) => TextEditingController());

                      notifyListeners();
                    } else {
                      submitBool == false;
                    }
                    Get.offAllNamed(ConstantRoutes.dashboard);
                  },
                ),
              ],
            ),
          ],
        ).then((value) {
          OnclickDisable = false;
          if (submitBool == true) {
            selectedcust = null;
            StockOutward.remove(datatotal);
            data!.clear();
            StOutController[50].text = "";
            StockOutward.remove(index);
            StockOutward[index].data.clear();
            notifyListeners();
          } else {
            submitBool == false;
          }
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
          OnclickDisable = false;
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
          OnclickDisable = false;
        });
        notifyListeners();
      }

      notifyListeners();
    });
  }

  Future myFuture(BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data) async {
    if (data!.isEmpty) {
      Get.defaultDialog(
          title: "Alert",
          middleText: 'Please Select Items..!!',
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
          radius: 5);
    } else {
      double? scannedtottal = 0;
      double? totalReqQty = 0;
      double? totalscanqty = 0;

      for (int i = 0; i < data.length; i++) {
        scannedtottal =
            scannedtottal! + data[i].Scanned_Qty! + data[i].trans_Qty!;
        totalReqQty = totalReqQty! + data[i].qty!;
        totalscanqty = totalscanqty! + data[i].Scanned_Qty!;
        notifyListeners();
      }

      if (totalscanqty == 0) {
        Get.defaultDialog(
            title: "Alert",
            middleText: 'Please Select Items..!!',
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
            ],
            radius: 5);
      } else if (totalscanqty != 0) {}
    }
  }

  List<OpenSalesReqHeadersModlData> openSalesReq = [];
  List<OpenStockLineModlData> openReqLineList = [];

  callOpenReqAPi(
    BuildContext context,
  ) async {
    final theme = Theme.of(context);
    await OpenOutwardAPi.getGlobalData(
      AppConstant.branch,
    ).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openSalesReq = value.activitiesData!;
        if (openSalesReq.isNotEmpty) {
          for (var i = 0; i < openSalesReq.length; i++) {
            StockOutward.add(StockOutwardList(
                cardCode: openSalesReq[i].cardCode,
                cardName: '',
                branch: UserValues.branch,
                baceDocentry: openSalesReq[i].docEntry.toString(),
                documentno: openSalesReq[i].docNum.toString(),
                sapbaceDocentry: openSalesReq[i].docEntry.toString(),
                reqfromWhs: UserValues.branch,
                remarks: '',
                reqtoWhs: openSalesReq[i].toWhsCode,
                u_reqWhs: openSalesReq[i].uwhsCode,
                reqtransdate: openSalesReq[i].docDate,
                data: []));

            openSalesReq[i].invoiceClr = 0;
            openSalesReq[i].checkBClr = false;
          }
        } else {
          dbDataTrue = true;
        }
        log('openSalesReqopenSalesReq::${openSalesReq.length}');
        notifyListeners();
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
                    widget: Center(
                        child: ContentContainer(
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
        dbDataTrue = false;
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
                      content: 'Something went wrong. Try again',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
        dbDataTrue = false;
        notifyListeners();
      }
    });
  }

  callOpenReqLineAPi(BuildContext context, ThemeData theme, String docEntry,
      String cardCode) async {
    final Database db = (await DBHelper.getInstance())!;
    selectedcust = null;
    openReqLineList = [];
    List<StockOutwardDetails> listData = [];

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
    await OpenOutwardLineAPi.getGlobalData(docEntry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openReqLineList = value.activitiesData!;
        if (openReqLineList.isNotEmpty) {
          passdata = [];
          listData = [];
          for (var i = 0; i < openReqLineList.length; i++) {
            for (var ik = 0; ik < StockOutward.length; ik++) {
              if (StockOutward[ik].baceDocentry.toString() ==
                  openReqLineList[i].docEntry.toString()) {
                log('StockOutwardStockOutward length::${StockOutward.length}');
                selectIndex = ik;
                listData.add(StockOutwardDetails(
                  baseDocline: openReqLineList[i].lineNum,
                  dscription: openReqLineList[i].description,
                  itemcode: openReqLineList[i].itemCode,
                  qty: openReqLineList[i].qty,
                  stock: openReqLineList[i].stock,
                  listClr: false,
                  insertValue: false,
                  balQty: openReqLineList[i].openQty,
                  baseDocentry: openReqLineList[i].docEntry,
                  price: openReqLineList[i].unitPrice,
                  trans_Qty:
                      double.parse(openReqLineList[i].transQty.toString()),
                  Scanned_Qty: 0,
                ));

                notifyListeners();
              }
              StockOutward[ik].data = listData;
              passdata = StockOutward[ik].data;
            }
          }
        }
        if (passdata!.isNotEmpty) {
          for (var i = 0; i < passdata!.length; i++) {
            if (selectAll == true) {
              notifyListeners();
              selectAllItem();
            } else {
              mapItemCodeWiseSoItemData(i);
            }
          }
          serialbatchList = [];
          filtersearchData = [];
          isselectmethod();
        }
        log('passdatapassdatapassdata::${passdata!.length}');
        notifyListeners();
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
                    widget: Center(
                        child: ContentContainer(
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
        notifyListeners();
      }
    });
  }

  deleteoutdata() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.deletAllOutHoldData(db);
    notifyListeners();
  }

  holdbutton(int index, BuildContext context, ThemeData theme,
      List<StockOutwardDetails>? data, StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
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
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text("Close"),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ],
          radius: 5);
    } else if (scannedtottal != 0) {
      print("object");

      await DBOperation.deletAlreadyHoldData(
          db, int.parse(StockOutward[index].baceDocentry.toString()));

      await HoldValueInsertToDB('hold', context, theme, index, data, datatotal);

      notifyListeners();
    }

    notifyListeners();
  }

  HoldValueInsertToDB(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = [];
    List<StockOutLineDataDB> StOutLine = [];

    int? docEntryCreated = await DBOperation.generateDocentr(
        db, "docentry", "StockOutHeaderDataDB");

    StOutHeader.add(StockOutHeaderDataDB(
        terminal: AppConstant.terminal,
        docentry: docEntryCreated.toString(),
        branch: AppConstant.branch,
        cardCode: selectedcust != null && selectedcust!.cardCode != null
            ? selectedcust!.cardCode!
            : '',
        cardName: selectedcust != null && selectedcust!.name != null
            ? selectedcust!.name.toString()
            : "",
        createdUserID: UserValues.userID,
        baseDocentry: StockOutward[index].baceDocentry,
        createdateTime: config.currentDate(),
        docstatus: "1",
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: StockOutward[index].documentno,
        docseries: "",
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: UserValues.branch,
        systime: config.currentDate(),
        reqtoWhs: StockOutward[index].reqtoWhs,
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
        remarks: StOutController[50].text.isEmpty
            ? ""
            : StOutController[50].text.toString()));
    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);
    StockOutward[index].data = passdata!;
    for (int i = 0; i < StockOutward[index].data.length; i++) {
      List<StockOutBatchDataDB>? serialbatchList2 = [];
      if (StockOutward[index].data[i].serialbatchList != null) {
        if (StockOutward[index].data[i].docentry != null) {
          await DBOperation.deleteBatch(
            db,
            int.parse(StockOutward[index].data[i].baseDocentry.toString()),
            int.parse(StockOutward[index].data[i].docentry.toString()),
            StockOutward[index].data[i].itemcode!,
          );
        }
        log('StockOutward[index].data[i].serialbatchList length::${StockOutward[index].data[i].serialbatchList!.length}');
        for (int j = 0;
            j < StockOutward[index].data[i].serialbatchList!.length;
            j++) {
          print("test zero::" +
              StockOutward[index].data[i].serialbatchList![j].qty.toString());
          serialbatchList2.add(StockOutBatchDataDB(
              lineno: StockOutward[index].data[i].serialbatchList![j].lineno,
              itemcode:
                  StockOutward[index].data[i].serialbatchList![j].itemcode,
              qty: StockOutward[index].data[i].serialbatchList![j].qty,
              baseDocentry:
                  StockOutward[index].data[i].serialbatchList![j].baseDocentry,
              serialbatch:
                  StockOutward[index].data[i].serialbatchList![j].serialbatch,
              docstatus: "1",
              docentry: docentry2!.toString()));
        }
      }
      await DBOperation.insertStOutBatch(db, serialbatchList2);

      if (StockOutward[index].data[i].docentry != null) {
        await DBOperation.deletAlreadyHoldDataLine(
            db,
            int.parse(StockOutward[index].baceDocentry.toString()),
            int.parse(StockOutward[index].docentry.toString()),
            StockOutward[index].data[i].itemcode.toString());
      }

      StOutLine.add(StockOutLineDataDB(
        lineno: StockOutward[index].data[i].lineNo.toString(),
        docentry: docentry2.toString(),
        itemcode: StockOutward[index].data[i].itemcode.toString(),
        description: StockOutward[index].data[i].dscription,
        qty: double.parse(StockOutward[index].data[i].qty.toString()),
        inStkQty: StockOutward[index].data[i].stock != null
            ? double.parse(StockOutward[index].data[i].stock.toString())
            : 0,
        baseDocentry: StockOutward[index].baceDocentry.toString(),
        baseDocline: StockOutward[index].data[i].lineNo.toString(),
        status: StockOutward[index].data[i].status,
        traansferQty: StockOutward[index].data[i].trans_Qty,
        scannedQty: StockOutward[index].data[i].Scanned_Qty,
        serialBatch: StockOutward[index].data[i].serialBatch.toString(),
        branch: AppConstant.branch,
        terminal: AppConstant.terminal,
      ));
    }

    await DBOperation.insertStOutLine(db, StOutLine);

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
                child: Text("Close"),
                onPressed: () {
                  OnclickDisable = false;

                  Get.back();
                  notifyListeners();
                }),
          ],
        ),
      ],
    ).then((value) {
      StOutController[50].clear();
      OndDisablebutton = false;
      selectedcust = null;
      OnclickDisable = false;
      passdata = [];
      StockOutward = [];
      StockOutward.remove(datatotal);
      data!.clear();
    });

    notifyListeners();
  }

  SuspendDBInsert(
      String docstatus,
      BuildContext context,
      ThemeData theme,
      int index,
      List<StockOutwardDetails>? data,
      StockOutwardList? datatotal) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockOutHeaderDataDB> StOutHeader = [];

    StOutHeader.add(StockOutHeaderDataDB(
        branch: AppConstant.branch,
        createdUserID: UserValues.userID,
        baseDocentry: StockOutward[index].baceDocentry,
        createdateTime: config.currentDate(),
        docstatus: "0",
        lastupdateIp: UserValues.lastUpdateIp,
        reqdocno: "0",
        docseries: "",
        cardCode: selectedcust!.cardCode ?? '',
        cardName: selectedcust!.name ?? '',
        docseriesno: 0,
        doctime: config.currentDate(),
        reqfromWhs: StockOutward[index].reqfromWhs,
        systime: config.currentDate(),
        reqtoWhs: StockOutward[index].reqtoWhs,
        transdate: config.currentDate(),
        salesexec: "",
        totalitems: 0,
        totalltr: 0,
        totalqty: 0,
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID,
        terminal: AppConstant.terminal,
        sapDocNo: null,
        sapDocentry: null,
        qStatus: 'N',
        sapStockReqdocentry: '',
        sapStockReqdocnum: '',
        remarks: ''));
    int? docentry2 = await DBOperation.insertStockOutheader(db, StOutHeader);

    for (int i = 0; i < StockOutward[index].data.length; i++) {
      StockOutward[index].data[i].Scanned_Qty = 0;
      notifyListeners();
    }
    await Get.defaultDialog(
      title: "Alert",
      middleText: "Data Cleared  Sucessfully..!!",
      backgroundColor: Colors.white,
      titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
      middleTextStyle: theme.textTheme.bodyLarge,
      radius: 5,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              child: Text("Close"),
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
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalqty = totalqty! + StockOutward[index].data[i].qty!;
    }
    return totalqty;
  }

  double? totalValdationqty(int? index) {
    double? totalqty = 0;
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalqty = totalqty! + StockOutward[index].data[i].Scanned_Qty!;
    }
    return totalqty;
  }

  double? totalscannedqty(int? index) {
    double? totalscanqty = 0;
    for (int i = 0; i < StockOutward[index!].data.length; i++) {
      totalscanqty = totalscanqty! + StockOutward[index].data[i].Scanned_Qty!;
    }
    return totalscanqty;
  }

  String a = "";
  Future getHoldValues(Database db) async {
    List<Map<String, Object?>> getDBStOutHead =
        await DBOperation.getHoldStOutHeadDB(db);
    savedraftBill = [];
    List<StockOutwardDetails> Stout_Line = [];
    List<StockOutSerialbatch> Stout_Batch = [];
    for (int i = 0; i < getDBStOutHead.length; i++) {
      List<Map<String, Object?>> getDBStOutLine =
          await DBOperation.holdStOutLineDB2(
              db, int.parse(getDBStOutHead[i]["docentry"].toString()));
      Stout_Line = [];
      for (int j = 0; j < getDBStOutLine.length; j++) {
        List<Map<String, Object?>> getDBStOutBatch =
            await DBOperation.holdStOutBatchDB2(
                db,
                int.parse(getDBStOutLine[j]["baseDocentry"].toString()),
                int.parse(getDBStOutLine[j]["docentry"].toString()),
                getDBStOutLine[j]["itemcode"].toString());

        if (double.parse(getDBStOutLine[j]["scannedQty"].toString()) != 0) {
          Stout_Batch = [];
          for (int k = 0; k < getDBStOutBatch.length; k++) {
            Stout_Batch.add(
              StockOutSerialbatch(
                lineno: getDBStOutBatch[k]["lineno"].toString(),
                baseDocentry: getDBStOutBatch[k]["baseDocentry"].toString(),
                itemcode: getDBStOutBatch[k]["itemcode"].toString(),
                qty: double.parse(getDBStOutBatch[k]["quantity"].toString()),
                serialbatch: getDBStOutBatch[k]["serialBatch"].toString(),
                docentry: getDBStOutBatch[k]["baseDocentry"].toString(),
                docstatus: "",
              ),
            );
          }
        } else {
          Stout_Batch = [];
        }
        log('message:::${getDBStOutLine[j]["baseDocline"].toString()}');
        Stout_Line.add(StockOutwardDetails(
            lineNo: getDBStOutLine[j]["lineno"] == null ||
                    getDBStOutLine[j]["lineno"] == 'null'
                ? 0
                : int.parse(getDBStOutLine[j]["lineno"].toString()),
            docentry: int.parse(getDBStOutLine[j]["docentry"].toString()),
            baseDocentry:
                int.parse(getDBStOutLine[j]["baseDocentry"].toString()),
            itemcode: getDBStOutLine[j]["itemcode"].toString(),
            dscription: getDBStOutLine[j]["description"].toString(),
            qty: double.parse(getDBStOutLine[j]["quantity"].toString()),
            status: getDBStOutLine[j]["status"].toString(),
            serialBatch: getDBStOutLine[j]["serialBatch"].toString(),
            createdUserID: 0,
            taxRate: 0.0,
            taxType: "",
            balQty: double.parse(getDBStOutLine[j]["quantity"].toString()) -
                double.parse(getDBStOutLine[j]["transferQty"].toString()),
            baseDocline: getDBStOutLine[j]["baseDocline"] == null ||
                    getDBStOutLine[j]["baseDocline"] == 'null'
                ? 0
                : int.parse(getDBStOutLine[j]["baseDocline"].toString()),
            trans_Qty:
                double.parse(getDBStOutLine[j]["transferQty"].toString()),
            Scanned_Qty:
                double.parse(getDBStOutLine[j]["scannedQty"].toString()),
            createdateTime: "",
            updatedDatetime: "",
            updateduserid: 0,
            price: 0,
            lastupdateIp: "",
            serialbatchList: Stout_Batch));
      }

      savedraftBill.add(StockOutwardList(
        cardCode: getDBStOutHead[i]["CardCode"].toString(),
        cardName: '',
        remarks: getDBStOutHead[i]["remarks"].toString(),
        docentry: getDBStOutHead[i]["docentry"].toString(),
        baceDocentry: getDBStOutHead[i]["baseDocentry"].toString(),
        branch: getDBStOutHead[i]["branch"].toString(),
        docstatus: getDBStOutHead[i]["docstatus"].toString(),
        reqfromWhs: getDBStOutHead[i]["reqfromWhs"].toString(),
        reqtoWhs: getDBStOutHead[i]["reqtoWhs"].toString(),
        reqtransdate: getDBStOutHead[i]["transdate"].toString(),
        documentno: getDBStOutHead[i]["reqdocno"].toString(),
        data: Stout_Line,
        sapbaceDocentry: getDBStOutHead[i]["baseDocentry"].toString(),
      ));
    }
  }

  valPass(double scanQty) {
    msg = "";
    notifyListeners();
  }

  PageIndexvalue(int? index) {
    pageIndex = index!;
    notifyListeners();
  }

  passINDEX(int? index) {
    i_value = index!;
    notifyListeners();
  }

  int? listI = 0;
  int? batch_i = 0;

  StockOutwardDetails? batch_datalist;
  passindexBachPage(
    int? index,
    int i,
    StockOutwardDetails? datalist,
  ) {
    listI = index!;
    batch_i = i;
    batch_datalist = datalist;
    StockOutward[index].data[i] = datalist!;
    if (StockOutward[index].data[i].serialbatchList != null) {
      for (int ik = 0;
          ik < StockOutward[index].data[i].serialbatchList!.length;
          ik++) {
        qtymycontroller[ik].text =
            StockOutward[index].data[i].serialbatchList![ik].qty.toString();
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
      print("object");
    } else if (pageIndex == 2) {
      notifyListeners();
    }
    return Future.value(false);
  }

  Future<bool> onbackpress2() async {
    return Future.value(false);
  }

  List<StockOutwardDetails>? passdata = [];
  passList(List<StockOutwardDetails>? data) {
    passdata = data!;

    notifyListeners();
  }

  List<StockOutwardList> StockOutward = [];

  clearmsg() {
    msg = "";
    notifyListeners();
  }

  DateTime? currentBackPressTime;
  Future<bool> onWillPop() {
    return Future.value(false);
  }

  mapvalue(List<StockOutwardList> StockOut, int index) async {
    StockOutward2.clear();
    StOutController2[50].text = "";
    if (isselect == true) {
      isselect = false;
    }
    selectIndex = null;
    passdata = [];
    List<StockOutwardDetails> stoutDetails = [];
    List<StockOutwardList> stoutList = [];
    final Database db = (await DBHelper.getInstance())!;
    for (int j = 0; j < StockOut[index].data.length; j++) {
      List<StockOutSerialbatch> stoutSeralBatchList = [];
      print("Stockline Length in hold:::" +
          StockOut[index].data[j].serialbatchList!.length.toString());

      for (int k = 0;
          k < StockOut[index].data[j].serialbatchList!.length;
          k++) {
        stoutSeralBatchList.add(StockOutSerialbatch(
          lineno: StockOut[index].data[j].lineNo.toString(),
          baseDocentry: StockOut[index].data[j].baseDocentry.toString(),
          itemcode: StockOut[index].data[j].itemcode.toString(),
          qty: StockOut[index].data[j].serialbatchList![k].qty,
          serialbatch: StockOut[index]
              .data[j]
              .serialbatchList![k]
              .serialbatch
              .toString(),
        ));
      }
      serialbatchList = stoutSeralBatchList;
      StockOut[index].data[j].serialbatchList = stoutSeralBatchList;
      log('StockOut[index].data[j].dscription::${StockOut[index].data[j].dscription}');
      stoutDetails.add(StockOutwardDetails(
          createdUserID: StockOut[index].data[j].createdUserID,
          createdateTime: StockOut[index].data[j].createdateTime,
          baseDocentry: StockOut[index].data[j].baseDocentry,
          docentry: StockOut[index].data[j].docentry,
          dscription: StockOut[index].data[j].dscription,
          itemcode: StockOut[index].data[j].itemcode,
          lastupdateIp: StockOut[index].data[j].lastupdateIp,
          lineNo: StockOut[index].data[j].lineNo,
          qty: StockOut[index].data[j].qty,
          status: StockOut[index].data[j].status,
          updatedDatetime: StockOut[index].data[j].updatedDatetime,
          updateduserid: StockOut[index].data[j].updateduserid,
          price: StockOut[index].data[j].price,
          serialBatch: StockOut[index].data[j].serialBatch,
          taxRate: StockOut[index].data[j].taxRate,
          taxType: StockOut[index].data[j].taxType,
          trans_Qty: StockOut[index].data[j].trans_Qty,
          Scanned_Qty: StockOut[index].data[j].Scanned_Qty,
          balQty:
              StockOut[index].data[j].qty! - StockOut[index].data[j].trans_Qty!,
          baseDocline: StockOut[index].data[j].baseDocline,
          serialbatchList: stoutSeralBatchList));
    }
    StOutController[50].text = StockOut[index].remarks.toString();
    stoutList.add(StockOutwardList(
      data: stoutDetails,
      branch: StockOut[index].branch,
      remarks: StockOut[index].remarks.toString(),
      docentry: StockOut[index].docentry,
      baceDocentry: StockOut[index].baceDocentry,
      docstatus: StockOut[index].docstatus,
      documentno: StockOut[index].documentno,
      reqfromWhs: StockOut[index].reqfromWhs,
      reqtoWhs: StockOut[index].reqtoWhs,
      reqtransdate: StockOut[index].reqtransdate,
      sapbaceDocentry: StockOut[index].sapbaceDocentry,
    ));

    int? count = await dupilicateHoldDataCheck(stoutList);

    if (count != null) {
      StockOutward.removeAt(count);
      StockOutward.addAll(stoutList);
    } else {
      StockOutward.addAll(stoutList);
    }

    log(StockOutward.length.toString());

    for (var i = 0; i < StockOutward.length; i++) {
      passdata = StockOutward[i].data;

      i_value = i;
    }
    for (var i = 0; i < passdata!.length; i++) {
      passdata![i].insertValue = true;
    }
    selectIndex = null;
    List<Map<String, Object?>> getcustomer =
        await DBOperation.getCstmMasDatabyautoid(
            db, StockOut[index].cardCode.toString());
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(
            db, StockOut[index].cardCode.toString());

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

  Future<int?> dupilicateHoldDataCheck(List<StockOutwardList> stoutList) {
    for (int i = 0; i < StockOutward.length; i++) {
      if (StockOutward[i].baceDocentry == stoutList[0].baceDocentry) {
        return Future.value(i);
      }
    }
    return Future.value(null);
  }

  dupilicateDRAFTDataCheck(StockOutwardList stoutList) {
    for (int i = 0; i < savedraftBill.length; i++) {
      if (savedraftBill[i].baceDocentry == stoutList.baceDocentry) {
        return i;
      }
    }
  }

  int balQtity = 0;
  getStockReqData() async {
    log("step1");
    StockOutward = [];
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getStockReqValues =
        await DBOperation.getStockReq(db);

    if (getStockReqValues.isNotEmpty) {
      for (int i = 0; i < getStockReqValues.length; i++) {
        if (getStockReqValues[i]["reqtoWhs"].toString() == AppConstant.branch) {
          dbDataTrue = false;

          List<Map<String, Object?>> getStockReqLineData =
              await DBOperation.getTrasferQty(
                  db, int.parse(getStockReqValues[i]["docentry"].toString()));
          print("stock docE::" + getStockReqValues.toString());
          List<StockOutwardDetails> stockDetails = [];
          for (int j = 0; j < getStockReqLineData.length; j++) {
            if (getStockReqValues[i]["reqfromWhs"].toString() ==
                getStockReqLineData[j]["branch"].toString()) {
              print("loop 1");
              stockDetails.add(StockOutwardDetails(
                  baseDocentry:
                      int.parse(getStockReqLineData[j]["docentry"].toString()),
                  baseDocline:
                      int.parse(getStockReqLineData[j]["lineNo"].toString()),
                  createdUserID: int.parse(
                      getStockReqLineData[j]["createdUserID"].toString()),
                  createdateTime:
                      getStockReqLineData[j]["createdateTime"].toString(),
                  dscription: "",
                  itemcode: getStockReqLineData[j]["itemcode"].toString(),
                  lastupdateIp:
                      getStockReqLineData[j]["lastupdateIp"].toString(),
                  lineNo:
                      int.parse(getStockReqLineData[j]["lineNo"].toString()),
                  qty: double.parse(
                      getStockReqLineData[j]["quantity"].toString()),
                  status: "",
                  updatedDatetime:
                      getStockReqLineData[j]["UpdatedDatetime"].toString(),
                  updateduserid: int.parse(
                      getStockReqLineData[j]["createdUserID"].toString()),
                  price:
                      double.parse(getStockReqLineData[j]["price"].toString()),
                  serialBatch: getStockReqLineData[j]["serialBatch"].toString(),
                  taxRate: 0.0,
                  balQty:
                      double.parse(getStockReqLineData[j]["balqty"].toString()),
                  Scanned_Qty: double.parse(
                      getStockReqLineData[j]["scanndQty"].toString()),
                  trans_Qty:
                      double.parse(getStockReqLineData[j]["quantity"].toString()) -
                          int.parse(getStockReqLineData[j]["balqty"].toString()),
                  taxType: ""));
            }
          }
          print(
            " getStockReqValues reqfromWhs ::" +
                getStockReqValues[i]["reqfromWhs"].toString(),
          );
          StockOutward.add(StockOutwardList(
              remarks: "",
              branch: getStockReqValues[i]["branch"].toString(),
              baceDocentry: getStockReqValues[i]["docentry"].toString(),
              docstatus: getStockReqValues[i]["docstatus"].toString(),
              documentno: getStockReqValues[i]["documentno"].toString(),
              reqfromWhs: getStockReqValues[i]["reqfromWhs"].toString(),
              reqtoWhs: getStockReqValues[i]["reqtoWhs"].toString(),
              reqtransdate: getStockReqValues[i]["reqtransdate"].toString(),
              data: stockDetails,
              sapbaceDocentry: getStockReqValues[i]['sapDocentry'].toString()));
          RequestedWarehouse = getStockReqValues[i]["reqfromWhs"].toString();
        } else {
          dbDataTrue = true;
          notifyListeners();
        }
      }

      notifyListeners();
    } else {
      dbDataTrue = true;
      notifyListeners();
    }
    print("object::==" + StockOutward.length.toString());
    notifyListeners();
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode focus = FocusScope.of(context);
    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    if (sapDocentry == null) {
      await sapLoginApi(context);
      await callSerlaySalesQuoAPI(context, theme);

      if (sapstkoutwarddata.isNotEmpty) {
        for (int i = 0; i < sapstkoutwarddata.length; i++) {
          await callSerlaySalesCancelQuoAPI(context, theme);
          notifyListeners();
        }
      }
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
        StockOutward.clear();
        StockOutward2.clear();
        StOutController2[50].text = "";
        getStockReqData();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  sapLoginApi(BuildContext context) async {
    final pref2 = await pref;

    await PostOutwardLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          print("sessionID: " + value.sessionId.toString());
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
            duration: Duration(seconds: 4),
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
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Something went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      } else {
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: Screens.bodyheight(context) * 0.3,
          ),
          duration: Duration(seconds: 4),
          backgroundColor: Colors.red,
          content: Text(
            "Opps Something went wrong !!..",
            style: const TextStyle(color: Colors.white),
          ),
        );
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
    log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
  }

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    log("sapDocentrysapDocentrysapDocentry:::$sapDocentry");
    await SerlaySalesOutwardAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.stockTransferLines.isNotEmpty) {
          sapstkoutwarddata = value.stockTransferLines;

          List<StockOutwardList> StockOutDATA2 = [];
          List<StockOutwardDetails> stockDetails2 = [];

          for (var i = 0; i < sapstkoutwarddata.length; i++) {
            stockDetails2.add(StockOutwardDetails(
                docentry: sapstkoutwarddata[i].docEntry,
                itemcode: sapstkoutwarddata[i].itemCode,
                dscription: sapstkoutwarddata[i].itemDescription,
                qty: sapstkoutwarddata[i].quantity));
          }
          StOutController2[50].text = value.comments.toString();
          StockOutDATA2.add(StockOutwardList(
              branch: AppConstant.branch,
              baceDocentry: value.docEntry.toString(),
              documentno: value.docNum.toString(),
              sapbaceDocentry: value.docNum.toString(),
              reqfromWhs: fromWhsCod,
              remarks: value.comments,
              reqtoWhs: '',
              reqtransdate: value.docDate.toString(),
              data: stockDetails2));
          custserieserrormsg = '';
        } else {}
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
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
                      content: custserieserrormsg.toString(),
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          sapDocentry = '';
          sapDocuNumber = '';
          StockOutward.clear();
          StockOutward2.clear();
          StOutController2[50].text = "";
          getStockReqData();
          notifyListeners();
        });
      } else {}
    });
  }

  ErrorModel? errorModel = ErrorModel();
  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    if (sapstkoutwarddata.isNotEmpty) {
      for (int ij = 0; ij < sapstkoutwarddata.length; ij++) {
        if (sapstkoutwarddata[ij].lineStatus == "bost_Open") {
          await SerlayvOutwardCancelAPI.getData(sapDocentry.toString())
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
                        contentPadding: EdgeInsets.all(0),
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
                StockOutward.clear();
                StockOutward2.clear();
                StOutController2[50].text = "";
                getStockReqData();
                notifyListeners();
              });

              custserieserrormsg = '';
            } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
              cancelbtn = false;
              custserieserrormsg = errorModel!.message!.value.toString();
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
                            content: value.exception!.message!.value.toString(),
                            theme: theme,
                          )),
                          buttonName: null,
                        ));
                  }).then((value) {
                sapDocentry = '';
                sapDocuNumber = '';
                StockOutward.clear();
                StockOutward2.clear();
                StOutController2[50].text = "";
                getStockReqData();
                notifyListeners();
              });
            } else {}
          });
        } else if (sapstkoutwarddata[ij].lineStatus == "bost_Close") {
          cancelbtn = false;
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                    contentPadding: EdgeInsets.all(0),
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
            StockOutward.clear();
            StockOutward2.clear();
            StOutController2[50].text = "";
            getStockReqData();
            notifyListeners();
          });
          notifyListeners();
        }
      }
    }
  }

  PostRabitMq(int docentry, int baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader(db, docentry);
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.holdStOutLineDB(
            db, docentry, baseDocentry.toString());
    List<Map<String, Object?>> getDB_StOutBatch =
        await DBOperation.getStockOutBatch(
            db, docentry, baseDocentry.toString());
    String stOutHeader = json.encode(getDB_StoutHeader);
    String stOutLine = json.encode(getDB_StoutLine);
    String stOutBatch = json.encode(getDB_StOutBatch);

    var ddd = json.encode({
      "ObjectType": 5,
      "ActionType": "Add",
      "StockOutwardHeader": stOutHeader,
      "StockOutwardLine": stOutLine,
      "StockOutwardBatch": stOutBatch,
    });
    log("payload : $ddd");

    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);

    //to

    client1.close();
  }

  PostRabitMq2(int docentry, String baseDocentry, String toWhs) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDB_StoutHeader =
        await DBOperation.getStockOutHeader(db, docentry);
    List<Map<String, Object?>> getDB_StoutLine =
        await DBOperation.holdStOutLineDB(
            db, docentry, baseDocentry.toString());
    List<Map<String, Object?>> getDB_StOutBatch =
        await DBOperation.getStockOutBatch(db, docentry, baseDocentry);
    String stOutHeader = json.encode(getDB_StoutHeader);
    String stOutLine = json.encode(getDB_StoutLine);
    String stOutBatch = json.encode(getDB_StOutBatch);
    log("stOutLinevstOutLine::$stOutLine");
    var ddd = json.encode({
      "ObjectType": 5,
      "ActionType": "Add",
      "StockOutwardHeader": stOutHeader,
      "StockOutwardLine": stOutLine,
      "StockOutwardBatch": stOutBatch,
    });
    log("payload : $ddd");

    Client client = Client();
    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(), //"102.69.167.106"
        port: 5672,
        authProvider: PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();
    properties.headers = {"Branch": AppConstant.branch};
    Channel channel = await client1.channel();
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

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

  mapCallOutwardForPDF(preff, BuildContext context, ThemeData theme) async {
    List<InvoiceItem> itemsList = [];
    invoice = null;

    for (int i = 0; i < StockOutward2[0].data.length; i++) {
      log('StockOutward2[0].data.length:::${StockOutward2[0].data.length}');

      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        descripton: StockOutward2[0].data[i].dscription,
        unitPrice:
            double.parse(StockOutward2[0].data[i].price!.toStringAsFixed(2)),
        quantity: double.parse((StockOutward2[0].data[i].qty.toString())),
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
        //custDetails[0].address ?? '',

        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
      ),
      items: itemsList,
    );

    notifyListeners();

    PDFOutwardpi.exclTxTotal = 0;
    PDFOutwardpi.vatTx = 0;
    PDFOutwardpi.inclTxTotal = 0;
    log('invoice!.items!.::${invoice!.items!.length}');
    if (invoice!.items!.isNotEmpty) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);

        invoice!.items![i].netTotal = (invoice!.items![i].basic!);

        PDFOutwardpi.exclTxTotal =
            (PDFOutwardpi.exclTxTotal) + (invoice!.items![i].netTotal!);

        PDFOutwardpi.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString());

        PDFOutwardpi.pails = 0;

        PDFOutwardpi.tonnage = 0;

        notifyListeners();
      }
      PDFOutwardpi.totalPack =
          PDFOutwardpi.pails! + PDFOutwardpi.cartons! + PDFOutwardpi.looseTins!;
      PDFOutwardpi.inclTxTotal =
          (PDFOutwardpi.exclTxTotal) + (PDFOutwardpi.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }
      PDFOutwardpi.iinvoicee = invoice;
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
        context, MaterialPageRoute(builder: (context) => PDFOutwardpi()));
    notifyListeners();
  }
}
