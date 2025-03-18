import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:posproject/Controller/SalesQuotationController/SalesQuotationController.dart';
import 'package:posproject/Models/Service%20Model/GroupCustModel.dart';
import 'package:posproject/Models/Service%20Model/PamentGroupModel.dart';
import 'package:posproject/Models/Service%20Model/TeriTeriModel.dart';
import 'package:posproject/Pages/PrintPDF/PDFInVoiceApi.dart';
import 'package:posproject/Pages/PrintPDF/invoice.dart';
import 'package:posproject/Service/NewCustCodeCreate/CreatecustPostApi%20copy.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerGropApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/CustomerSeriesApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/FileUploadApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/PaymentGroupApi.dart';
import 'package:posproject/Service/NewCustCodeCreate/TeritoryApi.dart';
import 'package:posproject/ServiceLayerAPIss/BankListApi/BankListsApi.dart';
import 'package:uuid/uuid.dart';
import '../../Constant/ConstantRoutes.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/DB Helper/DBhelper.dart';
import 'package:posproject/DBModel/SalesHeader.dart';
import 'package:posproject/DBModel/SalesLineDBModel.dart';
import 'package:posproject/DBModel/SalesPay.dart';
import 'package:posproject/Models/DataModel/SalesOrderModel.dart';
import 'package:posproject/Service/AccountBalanceAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../DB Helper/DBOperation.dart';
import "package:dart_amqp/dart_amqp.dart";
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CustomerModel/CustomerModel.dart';
import '../../Models/DataModel/SeriesMode/SeriesModels.dart';
import '../../Models/DataModel/itemCode/Itemcodelist.dart';
import '../../Models/DataModel/PaymentModel/PaymentModel.dart';
import '../../Models/QueryUrlModel/AutoselectModel.dart';
import '../../Models/QueryUrlModel/CompanyTinVatModel.dart';
import '../../Models/QueryUrlModel/FetchFromPdaModel.dart';
import '../../Models/QueryUrlModel/InvCustomerAddModel.dart';
import '../../Models/QueryUrlModel/NewCashAccount.dart';
import '../../Models/QueryUrlModel/OnhandModel.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderHeader_Model.dart';
import '../../Models/QueryUrlModel/SalesOrderQueryModel/OpenSalesOrderLineModel.dart';
import '../../Models/SchemeOrderModel/SchemeOrderModel.dart';
import '../../Models/SearBox/SearchModel.dart';
import '../../Models/Service Model/CusotmerSeriesModel.dart';
import '../../Models/Service Model/StockSnapModelApi.dart';
import '../../Models/ServiceLayerModel/BankListModel/BankListsModels.dart';
import '../../Models/ServiceLayerModel/ErrorModell/ErrorModelSl.dart';
import '../../Models/ServiceLayerModel/ReceiptModel/PostReceiptLineMode.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/InvPostingLineModel.dart';
import '../../Models/ServiceLayerModel/SapInvoiceModel/Sapinvoicesmodel.dart';
import '../../Pages/Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';
import '../../Pages/SalesQuotation/Widgets/ItemLists.dart';
import '../../Service/NewCashAccountApi.dart';
import '../../Service/NewCustCodeCreate/NewAddCreatePatchApi.dart';
import '../../Service/Printer/InvoicePrint.dart';
import '../../Service/QueryURL/AutoselectApi.dart';
import '../../Service/QueryURL/CompanyVatTinApi.dart';
import '../../Service/QueryURL/CreditDaysModelAPI.dart';
import '../../Service/QueryURL/CreditLimitModeAPI.dart';
import '../../Service/QueryURL/FetchbatchPDAapi.dart';
import '../../Service/QueryURL/InvCustomerAddApi.dart';
import '../../Service/QueryURL/OnHandApi.dart';
import '../../Service/QueryURL/OpenSalesOrderHeaderApi.dart';
import '../../Service/QueryURL/OpenSalesOrderLineApi.dart';
import '../../Service/SearchQuery/SearchInvHeaderApi.dart';
import '../../Service/SeriesApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/DirectInvoicePostApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/EInvoiceApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoicePatchApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/PostOrdertoInvoiceApi.dart';
import '../../ServiceLayerAPIss/Paymentreceipt/PostpaymentDataAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Service/SchemeOrderApi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/GetInvoicerAPI.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceCancelAPI.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';
import '../../Widgets/ContentContainer.dart';
import 'package:intl/intl.dart';

class PosController extends ChangeNotifier {
  Configure config = Configure();
  final GlobalKey<ScaffoldState> scaffoldKeyy = GlobalKey<ScaffoldState>();
  List<GlobalKey<FormState>> formkeyy =
      List.generate(100, (i) => GlobalKey<FormState>());
  List<TextEditingController> udfController =
      List.generate(100, (ij) => TextEditingController());
  GlobalKey<FormState> formkeyAdd = GlobalKey<FormState>();
  GlobalKey<FormState> formkeyShipAdd = GlobalKey<FormState>();

  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());

  bool listVisible = false;

  List<TextEditingController> qtymycontroller =
      List.generate(100, (ij) => TextEditingController());

  List<TextEditingController> discountcontroller =
      List.generate(100, (ij) => TextEditingController());

  List<StocksnapModelData> itemData = [];
  List<StocksnapModelData> get getitemData => itemData;

  List<StocksnapModelData> scanneditemData = [];
  List<StocksnapModelData> get getScanneditemData => scanneditemData;
  List<StocksnapModelData> scanneditemData2 = [];
  List<StocksnapModelData> get getScanneditemData2 => scanneditemData2;

  List<TextEditingController> mycontroller2 =
      List.generate(150, (i) => TextEditingController());

  TextEditingController remarkcontroller3 = TextEditingController();

  TextEditingController searchcontroller = TextEditingController();
  List<TextEditingController> qtymycontroller2 =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> manualQtyCtrl =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> soqtycontroller =
      List.generate(100, (ij) => TextEditingController());
  List<TextEditingController> soListController =
      List.generate(100, (ij) => TextEditingController());
  List<CustomerAddressModelDB> newBillAddrsValue = [];
  List<CustomerAddressModelDB> newShipAddrsValue = [];
  List<CustomerAddressModelDB> billcreateNewAddress = [];
  List<CustomerAddressModelDB> shipcreateNewAddress = [];
  List<searchModel> searchData = [];
  List<FocusNode> focusnode = List.generate(100, (i) => FocusNode());

  double soTotal = 0;
  String cpyfrmso = '';
  List<ItemCodeListModel> itemcodelistitem = [];
  List<ItemCodeListModel> soitemcodelistitem = [];
  List<ItemCodeListModel> soitemcodelistitem55 = [];
  List<StocksnapModelData> soScanItem = [];

  List<ItemCodeListModel> itemcodelistitem55 = [];

  ItemCodeListModel? itemcodeitem;
  List<StocksnapModelData> soData = [];
  List<StocksnapModelData> get getsoData => soData;
  List<SalesModel> salesmodl = [];
  List<SalesModel> soSalesmodl = [];
  List<SalesModel> onHold = [];
  List<SalesModel> onHoldFilter = [];
  String? totquantity;
  double? discountamt;
  CustomerDetals? selectedcust2;
  CustomerDetals? get getselectedcust2 => selectedcust2;
  CustomerDetals? selectedcust25;
  CustomerDetals? get getselectedcust25 => selectedcust25;
  TotalPayment? totalPayment2;
  TotalPayment? get gettotalPayment2 => totalPayment2;
  List<PaymentWay> paymentWay = [];
  List<PaymentWay> get getpaymentWay => paymentWay;
  List<PaymentWay> paymentWay2 = [];
  List<PaymentWay> get getpaymentWay2 => paymentWay2;
  bool ondDisablebutton = false;
  bool schemebtnclk = false;
  bool searchbool = false;
  bool searchmapbool = false;
  List<CustomerDetals> custList2 = [];
  TotalPayment? totalPayment;
  TotalPayment? get gettotalPayment => totalPayment;
  String holddocentry = '';

  String? msgforAmount;
  String? get getmsgforAmount => msgforAmount;

  String? shipaddress = "";
  String? custNameerror = "";

  double? totwieght = 0.0;
  double? totLiter = 0.0;
  List<Address> billadrrssItemlist = [];
  List<Address> shipadrrssItemlist = [];
  List<Address> billadrrssItemlist5 = [];
  List<Address> shipadrrssItemlist5 = [];
  List<String> catchmsg = [];
  List<SalesOrderScheme> schemeData = [];
  List<SchemeOrderModalData> resSchemeDataList = [];
  bool valuefirst = false;

  Future<SharedPreferences> pref = SharedPreferences.getInstance();
  bool loadingscrn = false;
  bool cancelbtn = false;

  String? custseriesNo;

  String? custserieserrormsg = '';
  bool seriesValuebool = true;
  List<ErrorModel> sererrorlist = [];
  List<CustSeriesModelData> seriesData = [];
  bool? fileValidation = false;
  File? tinFiles;
  File? vatFiles;
  String? teriteriValue;
  String? codeValue;
  String? paygrpValue;
  FilePickerResult? result;
  List<FilesData> filedata = [];
  bool loadingBtn = false;
  String? sapDocentry = '';
  String sapDocuNumber = '';
  String? sapReceiptDocentry = '';
  String? sapReceiptDocNum = '';

  String cancelDocnum = '';

  List<GroupCustData> groupcData = [];
  List<GetTeriteriData> teriteritData = [];
  List<GetPayGrpData>? paygroupData = [];
  String? custerrormsg = '';
  bool groCustLoad = false;
  List<InvoiceDocumentLine> sapInvocieModelData = [];

  String exception = '';
  bool loading = false;

  String vatfileError = '';
  String tinfileError = '';
//dropdown
  String? selectedValue;
  String? get getselectedValue => selectedValue;

  List<CustomerDetals> custList = [];
  List<CustomerDetals> filtercustList = [];
  List<CustomerDetals> get getfiltercustList => filtercustList;

  int selectedCustomer = 0;
  int get getselectedCustomer => selectedCustomer;

  bool loadSearch = false;
  CustomerDetals? selectedcust;
  CustomerDetals? get getselectedcust => selectedcust;
  CustomerDetals? selectedcust55;
  CustomerDetals? get getselectedcust55 => selectedcust55;
  bool checkboxx = false;
  int selectedBillAdress = 0;
  int? get getselectedBillAdress => selectedBillAdress;

  int selectedShipAdress = 0;
  int? get getselectedShipAdress => selectedShipAdress;
  String? autoidddd;
  int? selectIndex;

  List<CustomerAddressModelDB> createNewAddress = [];
  List<CustomerModelDB> newCustValues = [];
  List<Map<String, dynamic>> newCustAddData = [];

  List<CustomerAddressModelDB> newAddrsValue = [];
  String textError = '';
  init(BuildContext context, ThemeData theme) async {
    clearAllData(context, theme);
    injectToDb();
    getdraftindex();
    getCustSeriesApi();

    await sapLoginApi(context);
    await callBankmasterApi();
  }

  injectToDb() async {
    await getCustDetFDB();
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

  doubleDotMethodPayTerms(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    mycontroller[i].text = modifiedString2.toString();
    log(mycontroller[i].text);
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

  checkspinkit() async {
    ondDisablebutton = true;
    await Future.delayed(const Duration(seconds: 5)).then((value) {
      ondDisablebutton = false;
      notifyListeners();
    });
  }

  getdraftindex() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getSalesHeadHoldvalueDB(db);
    for (int i = 0; i < getDBholddata5.length; i++) {
      getdraft(i);
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

  filterSearchBoxList(String v) {
    if (v.isNotEmpty) {
      filtersearchData = searchHeader
          .where((e) =>
              e.cardName.toLowerCase().contains(v.toLowerCase()) ||
              e.cardCode.toString().contains(v.toLowerCase()) ||
              e.docNum.toString().contains(v.toLowerCase()))
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

  getSalesDataDatewise(String fromdate, String todate) async {
    searchbool = true;
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getSalesHeader =
        await DBOperation.getSalesHeaderDateWise(
            db, config.alignDate2(fromdate), config.alignDate2(todate));

    List<searchModel> searchdata2 = [];
    searchData.clear();
    filtersearchData.clear();
    for (int i = 0; i < getSalesHeader.length; i++) {
      searchdata2.add(searchModel(
          username: UserValues.username,
          terminal: AppConstant.terminal,
          type: getSalesHeader[i]["docstatus"] == null
              ? ''
              : getSalesHeader[i]["docstatus"].toString() == '2'
                  ? "Order"
                  : getSalesHeader[i]["docstatus"].toString() == '3'
                      ? "Invoice"
                      : '',
          sapDocNo: getSalesHeader[i]["sapDocNo"] == null
              ? 0
              : int.parse(getSalesHeader[i]["sapDocNo"].toString()),
          qStatus: getSalesHeader[i]["qStatus"] == null
              ? ''
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
              ? ''
              : getSalesHeader[i]["createdateTime"].toString(),
          customeraName: getSalesHeader[i]["customername"].toString(),
          doctotal: getSalesHeader[i]["doctotal"] == null
              ? 0
              : double.parse(getSalesHeader[i]["doctotal"].toString())));
    }
    searchData.addAll(searchdata2);

    searchbool = false;
    notifyListeners();
  }

  fixDataMethod(int docentry) async {
    searchmapbool = false;
    totwieght = 0.0;
    totLiter = 0.0;
    shipaddress = "";
    paymentWay2.clear();
    scanneditemData2.clear();
    totalPayment2 = null;
    selectedcust2 = null;
    sapDocentry = '';
    cancelDocnum = '';
    salesmodl = [];
    sapDocuNumber = '';
    //background service
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);

    List<PaymentWay> payment = [];
    double? totalQuantity = 0;

    sapDocentry = getDBSalesHeader[0]['sapDocentry'] != null
        ? getDBSalesHeader[0]['sapDocentry'].toString()
        : "";
    sapDocuNumber = getDBSalesHeader[0]['sapDocNo'] != null
        ? getDBSalesHeader[0]['sapDocNo'].toString()
        : "";
    cancelDocnum = getDBSalesHeader[0]['documentno'] != null
        ? getDBSalesHeader[0]['documentno'].toString()
        : "";
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
      }
      notifyListeners();
    }
    totwieght = double.parse(getDBSalesHeader[0]["totalweight"].toString());
    totLiter = double.parse(getDBSalesHeader[0]["totalltr"].toString());

    mycontroller2[50].text = getDBSalesHeader[0]['remarks'] != null
        ? getDBSalesHeader[0]['remarks'].toString()
        : "";

    for (int ik = 0; ik < getDBSalesLine.length; ik++) {
      scanneditemData2.add(StocksnapModelData(
          pails: getDBSalesLine[ik]['pails'] != null
              ? double.parse(getDBSalesLine[ik]['pails'].toString())
              : 00,
          cartons: getDBSalesLine[ik]['cartons'] != null
              ? int.parse(getDBSalesLine[ik]['cartons'].toString())
              : 00,
          looseTins: getDBSalesLine[ik]['looseTins'] != null
              ? double.parse(getDBSalesLine[ik]['looseTins'].toString())
              : 00,
          tonnage: getDBSalesLine[ik]['tonnage'] != null
              ? double.parse(getDBSalesLine[ik]['tonnage'].toString())
              : 00,
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

      qtymycontroller2[ik].text = getDBSalesLine[ik]['quantity'] == null
          ? "0"
          : getDBSalesLine[ik]['quantity'].toString();

      mycontroller2[ik].text = getDBSalesLine[ik]['discperc'] == null
          ? "0"
          : getDBSalesLine[ik]['discperc'].toString();
      discountamt = getDBSalesLine[ik]['discperc'] != null
          ? double.parse(getDBSalesLine[ik]['discperc'].toString())
          : 0;
      notifyListeners();
    }
    for (int i = 0; i < scanneditemData2.length; i++) {
      scanneditemData2[i].priceAfDiscBasic = scanneditemData2[i].sellPrice! * 1;
      double priceafd = (scanneditemData2[i].priceAfDiscBasic! *
          scanneditemData2[i].discountper! /
          100);
      double priceaftDisc = scanneditemData2[i].priceAfDiscBasic! - priceafd;
      scanneditemData2[i].priceAftDiscVal = priceaftDisc;

      scanneditemData2[i].taxable =
          scanneditemData2[i].basic! - getScanneditemData2[i].discount!;

      totalQuantity =
          totalQuantity! + int.parse(qtymycontroller2[i].text.toString());

      notifyListeners();
    }

    totalPayment2 = TotalPayment(
      balance: getDBSalesHeader[0]['baltopay'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['baltopay'].toString()),

      discount2: getDBSalesHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),

      discount: getDBSalesHeader[0]['docdiscamt'] == null
          ? 0.00
          : double.parse(getDBSalesHeader[0]['docdiscamt'].toString()),
      totalTX: double.parse(getDBSalesHeader[0]['taxamount'] == null
          ? '0'
          : getDBSalesHeader[0]['taxamount'].toString().replaceAll(',', '')),

      subtotal: double.parse(getDBSalesHeader[0]['docbasic'] == null
          ? '0'
          : getDBSalesHeader[0]['docbasic']
              .toString()
              .replaceAll(',', '')), //doctotal

      total: totalQuantity,
      totalDue: double.parse(getDBSalesHeader[0]['doctotal'] == null
          ? '0'
          : getDBSalesHeader[0]['doctotal'].toString().replaceAll(',', '')),
      totpaid: double.parse(getDBSalesHeader[0]['amtpaid'] == null
          ? '0'
          : getDBSalesHeader[0]['amtpaid'].toString().replaceAll(',', '')),
    );
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
          notifyListeners();
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
            notifyListeners();
          }
        }
      }
    }
    SalesModel salesM = SalesModel(
      ordReference: getDBSalesHeader[0]['remarks'].toString(),
      objname: getDBSalesHeader[0]['objname'].toString(),
      objtype: getDBSalesHeader[0]['objtype'].toString(),
      doctype: getDBSalesHeader[0]['doctype'].toString(),
      docentry: int.parse(getDBSalesHeader[0]['docentry'].toString()),
      custName: getDBSalesHeader[0]['customername'].toString(),
      phNo: getDBSalesHeader[0]['customerphono'].toString(),
      cardCode: getDBSalesHeader[0]['customercode'].toString(),
      accBalance: getDBSalesHeader[0]['customeraccbal'].toString(),
      point: getDBSalesHeader[0]['customerpoint'].toString(),
      tarNo: getDBSalesHeader[0]['taxno'].toString(),
      taxCode: getDBSalesHeader[0]['taxCode'].toString(),
      email: getDBSalesHeader[0]['customeremail'].toString(),
      invoceDate: getDBSalesHeader[0]['createdateTime'].toString(),
      invoiceNum: getDBSalesHeader[0]['documentno'].toString(),
      sapOrderNum: getDBSalesHeader[0]['basedocentry'].toString(),
      sapInvoiceNum: getDBSalesHeader[0]['sapDocNo'].toString(),
      item: scanneditemData2,
    );

    notifyListeners();

    salesmodl.add(salesM);

    selectedcust2 = CustomerDetals(
      name: getDBSalesHeader[0]["customername"].toString(),
      phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      U_CashCust: getDBSalesHeader[0]["U_CASHCUST"].toString(),

      cardCode: getDBSalesHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
      address: address2,
      tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      taxCode: getDBSalesHeader[0]["taxCode"].toString(),

      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    notifyListeners();

    selectedcust25 = CustomerDetals(
      taxCode: getDBSalesHeader[0]["taxCode"].toString(),
      U_CashCust: getDBSalesHeader[0]["U_CASHCUST"].toString(),

      name: getDBSalesHeader[0]["customername"].toString(),
      phNo: getDBSalesHeader[0]["customerphono"].toString(), //customerphono
      docentry: getDBSalesHeader[0]["docentry"].toString(),
      cardCode: getDBSalesHeader[0]["customercode"]
          .toString(), //customercode!.cardCode
      accBalance: double.parse(
          getDBSalesHeader[0]["customeraccbal"].toString()), //customeraccbal
      point: getDBSalesHeader[0]["customerpoint"].toString(), //customerpoint
      address: address25,
      tarNo: getDBSalesHeader[0]["taxno"].toString(), //taxno
      email: getDBSalesHeader[0]["customeremail"].toString(), //customeremail
      invoicenum: getDBSalesHeader[0]["documentno"].toString(),
      invoiceDate: getDBSalesHeader[0]["createdateTime"].toString(),
      totalPayment: getDBSalesHeader[0][""] == null
          ? 0.0
          : double.parse(getDBSalesHeader[0][""].toString()),
    );
    notifyListeners();

    notifyListeners();

    searchmapbool = false;
    notifyListeners();
  }

  saveValuesTODB(
      String docstatus, BuildContext context, ThemeData theme) async {
    if (docstatus.toLowerCase() == "hold") {
      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "save as order") {
      insertSalesHeaderToDB(docstatus, context, theme);
    } else if (docstatus.toLowerCase() == "check out") {
      insertSalesHeaderToDB(docstatus, context, theme);
    }

    notifyListeners();
  }

  updateStkSnaptab(int docentry) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(
            db, int.parse(getDBSalesHeader[0]['docentry'].toString()));

    for (int i = 0; i < getDBSalesLine.length; i++) {
      List<Map<String, Object?>> serialbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              getDBSalesLine[i]['serialbatch'].toString(),
              getDBSalesLine[i]['itemcode'].toString());
      for (int ij = 0; ij < serialbatchCheck.length; ij++) {
        if (getDBSalesLine[i]['serialbatch'].toString() ==
                serialbatchCheck[ij]['serialbatch'].toString() &&
            getDBSalesLine[i]['itemcode'].toString() ==
                serialbatchCheck[ij]['itemcode'].toString()) {
          List<StockSnapTModelDB> stkSnpValues = [];

          int stksnpqty =
              int.parse(serialbatchCheck[ij]['quantity'].toString()) -
                  int.parse(getDBSalesLine[i]['quantity'].toString());
          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
            uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchCheck[ij]['uSpecificGravity'].toString(),
            uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
            branch: serialbatchCheck[ij]['branch'].toString(),
            terminal: serialbatchCheck[ij]['terminal'].toString(),
            itemname: serialbatchCheck[ij]['itemname'].toString(),
            branchcode: serialbatchCheck[ij]['branchcode'].toString(),
            createdUserID:
                int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
            createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
            itemcode: serialbatchCheck[ij]['itemcode'].toString(),
            lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
            maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
            taxrate: serialbatchCheck[ij]['taxrate'].toString(),
            mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
            sellprice: serialbatchCheck[ij]['sellprice'].toString(),
            purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
            quantity: stksnpqty.toString(),
            serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
            snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
            specialprice: serialbatchCheck[ij]['specialprice'].toString(),
            updatedDatetime: serialbatchCheck[ij]['updatedDatetime'].toString(),
            updateduserid:
                int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
            liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
            weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
          ));

          await DBOperation.updateStkSnap(db, stkSnpValues, ij);
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

    return listdata;
  }

  insertSalesHeaderToDB(
      String docstatus, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<SalesHeaderTModelDB> salesHeaderValues1 = [];
    List<SalesPayTDB> salesPayValues = [];
    List<SalesLineTDB> salesLineValues = [];

    int? counofData =
        await DBOperation.getcountofTable(db, "docentry", "SalesHeader");
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
          await DBOperation.generateDocentr(db, "docentry", "SalesHeader");
    }
    String documentNum = '';
    int? documentN0 =
        await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 2);
    List<String> getseriesvalue = await checkingdoc(2);
    int docseries = int.parse(getseriesvalue[1]);
    int nextno = documentN0!;
    documentN0 = docseries + documentN0;
    String finlDocnum = getseriesvalue[0].toString().substring(0, 8);
    documentNum = finlDocnum + documentN0.toString();
    salesHeaderValues1.add(SalesHeaderTModelDB(
        doctype: 'Sales Invoice',
        docentry: docEntryCreated.toString(),
        objname: '',
        objtype: '',
        tinNo: tinNoController.text,
        vatNo: vatNoController.text,
        amtpaid: totalPayment != null
            ? getSumTotalPaid().toString().replaceAll(',', '')
            : null,
        baltopay: totalPayment != null
            ? getBalancePaid().toString().replaceAll(',', '')
            : null,
        billaddressid: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ""
            : selectedcust!.address![selectedBillAdress].autoId.toString(),
        billtype: null,
        branch: UserValues.branch!,
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        createdbyuser: UserValues.userType,
        customercode: selectedcust!.cardCode != null
            ? selectedcust!.cardCode.toString()
            : '',
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
        docdiscuntpercen: discountcontroller[i].text.isNotEmpty
            ? discountcontroller[i].text.toString()
            : '0',
        documentno: (documentNum).toString(),
        docstatus: docstatus == "suspend"
            ? "0"
            : docstatus == "hold"
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
        shipaddresid: selectedcust55!.address!.isNotEmpty
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
        customeremail: selectedcust!.email ?? '',
        customerphono: selectedcust!.phNo ?? '',
        customerpoint: selectedcust != null ? selectedcust!.point : '',
        city: selectedcust == null && selectedcust!.address == null ||
                selectedcust!.address!.isEmpty
            ? ''
            : selectedcust!.address![selectedBillAdress].billCity,
        gst: selectedcust!.tarNo ?? '',
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
        basedocentry:
            selectedcust!.docentry != null ? selectedcust!.docentry.toString() : ''));
    int? docentry2 = await DBOperation.insertSaleheader(db, salesHeaderValues1);

    await DBOperation.updatenextno(db, 2, nextno);

    for (int i = 0; i < scanneditemData.length; i++) {
      salesLineValues.add(SalesLineTDB(
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
        docentry: docentry2.toString(),
        itemcode: scanneditemData[i].itemCode,
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        lineID: i.toString(),
        linetotal: scanneditemData[i].basic.toString(),
        netlinetotal: scanneditemData[i].netvalue!.toStringAsFixed(2),
        price: scanneditemData[i].sellPrice.toString(),
        quantity: cpyfrmso == 'CopyfromSo'
            ? scanneditemData[i].openRetQty.toString()
            : scanneditemData[i].qty.toString(),
        serialbatch: scanneditemData[i].serialBatch,
        taxrate: scanneditemData[i].taxRate.toString(),
        taxtotal: scanneditemData[i].taxvalue!.toStringAsFixed(2),
        updatedDatetime: config.currentDate(),
        updateduserid: UserValues.userID.toString(),
        terminal: UserValues.terminal,
        itemname: scanneditemData[i].itemName,
        basedocentry: scanneditemData[i].basedocentry,
        baselineID: scanneditemData[i].baselineid,
        pails: scanneditemData[i].pails,
        cartons: scanneditemData[i].cartons,
        looseTins: scanneditemData[i].looseTins != null
            ? double.parse(scanneditemData[i].looseTins!.toString())
            : 0,
        tonnage: scanneditemData[i].tonnage != null
            ? double.parse(scanneditemData[i].tonnage.toString())
            : 0,
        totalPack: scanneditemData[i].totalPack != null
            ? double.parse(scanneditemData[i].totalPack.toString())
            : 0,
      ));

      notifyListeners();
    }
    for (int ij = 0; ij < getpaymentWay.length; ij++) {
      salesPayValues.add(SalesPayTDB(
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
    if (salesPayValues.isNotEmpty) {
      await DBOperation.insertSalesPay(db, salesPayValues, docentry2!);
      notifyListeners();
    }
    if (salesLineValues.isNotEmpty) {
      await DBOperation.insertSalesLine(db, salesLineValues, docentry2!);
      notifyListeners();
    }

    if (docstatus == "hold") {
      await getdraftindex();
      mycontroller = List.generate(150, (i) => TextEditingController());
      qtymycontroller = List.generate(150, (i) => TextEditingController());
      discountcontroller = List.generate(100, (i) => TextEditingController());
      selectedcust = null;
      schemebtnclk = false;
      paymentWay.clear();
      totalPayment = null;
      cpyfrmso = '';
      newAddrsValue = [];
      newCustValues = [];
      remarkcontroller3.text = "";
      scanneditemData.clear();
      cashpayment = null;
      cashpayment = null;
      cqpayment = null;
      transpayment = null;
      tinNoController.text = '';
      custNameController.text = '';

      vatNoController.text = '';
      chqnum = null;
      transrefff = null;
      injectToDb();
      notifyListeners();
      await Get.defaultDialog(
              title: "Success",
              middleText: docstatus == "check out"
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
        ondDisablebutton = false;
        custNameController.text = '';
        tinNoController.text = '';
        vatNoController.text = '';
        notifyListeners();
      });
    }
    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      if (docstatus == "check out") {
        callInvoicePostApi(context, theme, docentry2!, docstatus, documentNum);
        notifyListeners();
      }
    }

    notifyListeners();
  }

  List<AutoSelectModlData>? openAutoSelect = [];

  bool autoselectbtndisable = false;
  bool manualselectbtndisable = false;

  bool batchselectbtndisable = false;

  List<StocksnapModelData> soFilterScanItem = [];

  List<String> addIndex = [];

  mapItemCodeWiseSoItemData(int index) {
    soFilterScanItem = [];
    double qty2 = 0;

    for (var i = 0; i < soScanItem.length; i++) {
      if (openOrdLineList![index].itemCode == soScanItem[i].itemCode &&
          openOrdLineList![index].lineNum.toString() ==
              soScanItem[i].baselineid.toString()) {
        soFilterScanItem.add(StocksnapModelData(
          branch: AppConstant.branch,
          baselineid: openOrdLineList![index].lineNum.toString(),
          basedocentry: openOrdLineList![index].docEntry.toString(),
          itemCode: soScanItem[i].itemCode,
          itemName: soScanItem[i].itemName,
          serialBatch: soScanItem[i].serialBatch,
          inDate: soScanItem[i].inDate,
          openRetQty: soScanItem[i].openRetQty,
          maxdiscount: '0',
          discountper: 0,
          mrp: 0,
          sellPrice: soScanItem[i].sellPrice,
        ));
        qty2 = qty2 + double.parse(soScanItem[i].openRetQty.toString());

        soListController[index].text = qty2.toString();
      }
    }
    log('soFilterScanItemsoFilterScanItem::${soFilterScanItem.length}');
    notifyListeners();
  }

  mapItemCodeWiseSoAllData() {
    soFilterScanItem = [];
    log('soScanItemsoScanItem length::${soScanItem.length}');
    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      for (var i = 0; i < soScanItem.length; i++) {
        if (openOrdLineList![ih].checkBClr == true &&
            openOrdLineList![ih].itemCode.toString() ==
                soScanItem[i].itemCode.toString() &&
            openOrdLineList![ih].lineNum.toString() ==
                soScanItem[i].baselineid.toString()) {
          soFilterScanItem.add(StocksnapModelData(
            shipDate: '',
            branch: AppConstant.branch,
            baselineid: openOrdLineList![ih].lineNum.toString(),
            basedocentry: openOrdLineList![ih].docEntry.toString(),
            itemCode: soScanItem[i].itemCode,
            itemName: soScanItem[i].itemName,
            serialBatch: soScanItem[i].serialBatch,
            inDate: soScanItem[i].inDate,
            openRetQty: soScanItem[i].openRetQty,
            maxdiscount: '0',
            discountper: 0,
            mrp: 0,
            sellPrice: soScanItem[i].sellPrice,
          ));
        }
      }
    }
    log('soFilterScanItemsoFilterScanItem::${soFilterScanItem.length}');
    notifyListeners();
  }

  List<OpenSalesOrderHeaderData> searchHeader = [];
  List<OpenSalesOrderHeaderData> filtersearchData = [];

  doubleDotMethodsoqty(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");
    double? sanitizedValue =
        double.tryParse(modifiedString2.split('.').join('.'));

    soListController[i].text = modifiedString2.toString();
    log(soListController[i].text);
    notifyListeners();
  }

  doubleDotMethodautomethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");
    double? sanitizedValue =
        double.tryParse(modifiedString2.split('.').join('.'));

    manualQtyCtrl[i].text = modifiedString2.toString();
    log(manualQtyCtrl[i].text);
    notifyListeners();
  }

  doubleDotMethod(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");
    double? sanitizedValue =
        double.tryParse(modifiedString2.split('.').join('.'));

    qtymycontroller[i].text = modifiedString2.toString();
    log(qtymycontroller[i].text);
    notifyListeners();
  }

  callSearchHeaderApi() async {
    searchHeader = [];
    filtersearchData = [];
    await SerachInvoiceHeadAPi.getGlobalData(
            config.alignDate2(mycontroller[100].text),
            config.alignDate2(mycontroller[101].text))
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData!.isNotEmpty) {
          searchHeader = value.activitiesData!;
          filtersearchData = searchHeader;
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
  }

  getInvoiceApi(
      String sapDocEntry, BuildContext context, ThemeData theme) async {
    sapDocentry = '';

    await sapLoginApi(context);
    await SerlaySalesInvoiceAPI.getData(sapDocEntry).then((value) async {
      scanneditemData2 = [];
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();

        mycontroller2[50].text = value.comments.toString();
        remarkcontroller3.text = value.comments.toString();
        if (value.documentLines.isNotEmpty) {
          log('value.documentLines length::${value.documentLines.length}');
          for (var i = 0; i < value.documentLines.length; i++) {
            scanneditemData2.add(StocksnapModelData(
                branch: AppConstant.branch,
                itemCode: value.documentLines[i].itemCode,
                itemName: value.documentLines[i].itemDescription,
                openRetQty: value.documentLines[i].quantity,
                lineStatus: value.documentLines[i].lineStatus,
                taxCode: value.documentLines[i].taxCode,
                discountper: value.documentLines[i].discountPercent,
                serialBatch: '',
                mrp: 0,
                sellPrice: value.documentLines[i].unitPrice,
                shipDate: ''));
          }
          notifyListeners();

          for (var i = 0; i < scanneditemData2.length; i++) {
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
        log('U_ZnoU_Zno::${value.uZno.toString()}');
        if (getcustomer.isNotEmpty) {
          selectedcust2 = CustomerDetals(
            name: value.cardName,
            phNo: getcustomer[0]['phoneno1'].toString(),
            U_CashCust: getcustomer[0]["U_CASHCUST"].toString(),
            taxCode: getcustomer[0]['TaxCode'].toString(),
            cardCode: getcustomer[0]['customerCode'].toString(),
            point: getcustomer[0]['points'].toString(),
            accBalance: 0,
            tinno: value.uTinNo ?? '',
            vatregno: value.uVatNumber ?? '',
            address: address2,
            invoiceDate: value.docDate,
            invoicenum: value.docNum.toString(),
            email: getcustomer[0]['emalid'].toString(),
            tarNo: getcustomer[0]['taxno'].toString(),
            autoId: getcustomer[0]['autoid'].toString(),
            U_QRPath: value.uQrPath ?? '',
            U_VfdIn: value.uVfdIn ?? '',
            U_QRValue: value.uQrValue ?? '',
            U_Zno: value.uZno ?? '',
            U_idate: value.uIdate ?? '',
            U_itime: value.uItime ?? '',
            U_rctCde: value.uRctCde ?? '',
          );
          selectedcust25 = CustomerDetals(
            name: getcustomer[0]['customername'].toString(),
            phNo: getcustomer[0]['phoneno1'].toString(),
            taxCode: getcustomer[0]['TaxCode'].toString(),
            U_CashCust: getcustomer[0]["U_CASHCUST"].toString(),
            cardCode: getcustomer[0]['customerCode'].toString(),
            point: getcustomer[0]['points'].toString(),
            address: address25,
            invoiceDate: value.docDate,
            invoicenum: value.docNum.toString(),
            accBalance: 0,
            email: getcustomer[0]['emalid'].toString(),
            tarNo: getcustomer[0]['taxno'].toString(),
            autoId: getcustomer[0]['autoid'].toString(),
            U_QRPath: value.uQrPath ?? '',
            U_VfdIn: value.uVfdIn ?? '',
            U_QRValue: value.uQrValue ?? '',
            U_Zno: value.uZno ?? '',
            U_idate: value.uIdate ?? '',
            U_itime: value.uItime ?? '',
            U_rctCde: value.uRctCde ?? '',
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

          if (scanneditemData2.isNotEmpty) {
            for (var i = 0; i < scanneditemData.length; i++) {
              scanneditemData2[i].taxRate = 0.0;
              if (selectedcust2!.taxCode == 'O1') {
                scanneditemData2[i].taxRate = 18;
              } else {
                scanneditemData2[i].taxRate = 0.0;
              }
              notifyListeners();
            }
            calCulateDocVal2(context, theme);
          }
        }
        loadSearch = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadSearch = false;
      } else {
        loadSearch = false;
      }
    });
    Get.back();
    notifyListeners();
  }

  List<FetchFromPdaModelData> fetchBatchData = [];
  String noMsgText = '';

  callFetchFromPdaAllApi(ThemeData theme, BuildContext context) async {
    batchselectbtndisable = true;
    autoselectbtndisable = false;
    manualselectbtndisable = false;

    selectionBtnLoading = true;
    noMsgText = '';
    soScanItem = [];
    fetchBatchData = [];
    double soListqty = 0;

    for (var im = 0; im < openOrdLineList!.length; im++) {
      if (openOrdLineList![im].checkBClr == true) {
        double balQty = double.parse(soListController[im].text);

        await FetchBatchPdaApi.getGlobalData(
                openOrdLineList![im].lineNum.toString(),
                openOrdLineList![im].docEntry.toString(),
                openOrdLineList![im].openQty.toString(),
                17)
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            fetchBatchData = value.fetchBatchData!;
            selectionBtnLoading = false;

            if (fetchBatchData.isNotEmpty) {
              for (var i = 0; i < fetchBatchData.length; i++) {
                if (balQty != 0) {
                  if (balQty >= fetchBatchData[i].pickedQty) {
                    soScanItem.add(StocksnapModelData(
                        branch: AppConstant.branch,
                        baselineid: openOrdLineList![im].lineNum.toString(),
                        basedocentry: openOrdLineList![im].docEntry.toString(),
                        itemCode: fetchBatchData[i].itemCode,
                        itemName: openOrdLineList![im].description.toString(),
                        serialBatch: fetchBatchData[i].batchNum,
                        openRetQty: fetchBatchData[i].pickedQty,
                        maxdiscount: '0',
                        discountper: 0,
                        mrp: 0,
                        sellPrice: 0,
                        shipDate: ''));
                    balQty = balQty - fetchBatchData[i].pickedQty;

                    notifyListeners();
                  } else {
                    soScanItem.add(StocksnapModelData(
                        branch: AppConstant.branch,
                        baselineid: openOrdLineList![im].lineNum.toString(),
                        basedocentry: openOrdLineList![im].docEntry.toString(),
                        itemCode: fetchBatchData[i].itemCode,
                        itemName: openOrdLineList![im].description.toString(),
                        serialBatch: fetchBatchData[i].batchNum,
                        openRetQty: balQty,
                        maxdiscount: '0',
                        discountper: 0,
                        mrp: 0,
                        sellPrice: 0,
                        shipDate: ''));

                    notifyListeners();

                    break;
                  }
                }
              }
              await mapItemCodeWiseSoAllData();

              openOrdLineList![im].valueInsert = true;
              soListqty = 0;
              if (soScanItem.isNotEmpty) {
                for (var i = 0; i < soScanItem.length; i++) {
                  if (openOrdLineList![im].itemCode == soScanItem[i].itemCode &&
                      openOrdLineList![im].lineNum.toString() ==
                          soScanItem[i].baselineid.toString()) {
                    soListqty = soListqty + soScanItem[i].openRetQty!;
                    soListController[im].text = soListqty.toString();

                    notifyListeners();
                  }
                }
              }
            } else {
              noMsgText = value.error!;
              batchselectbtndisable = false;
              autoselectbtndisable = false;
              noMsgText = value.error!;
              notifyListeners();
              log('${noMsgText}');
            }
            selectionBtnLoading = false;
          } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
            batchselectbtndisable = false;
            autoselectbtndisable = false;
            manualselectbtndisable = false;

            selectionBtnLoading = false;
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
                          content: '${value.error}',
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {});
            notifyListeners();
          } else {
            batchselectbtndisable = false;
            autoselectbtndisable = false;
            manualselectbtndisable = false;

            selectionBtnLoading = false;
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
                          content: '${value.error}',
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {});
            notifyListeners();
          }
        });
      }
    }
    batchselectbtndisable = false;
  }

  callFetchFromPdaItemApi(
      int index, ThemeData theme, BuildContext context) async {
    batchselectbtndisable = true;
    autoselectbtndisable = false;
    manualselectbtndisable = false;

    selectionBtnLoading = true;
    noMsgText = '';
    fetchBatchData = [];
    double soListqty = 0;
    for (var ik = 0; ik < soScanItem.length; ik++) {
      if (openOrdLineList![index].itemCode == soScanItem[ik].itemCode) {
        soScanItem.removeAt(ik);
      }
      notifyListeners();
    }
    for (var ix = 0; ix < soFilterScanItem.length; ix++) {
      if (openOrdLineList![index].itemCode == soFilterScanItem[ix].itemCode) {
        soFilterScanItem.removeAt(ix);
      }
    }
    if (openOrdLineList![index].checkBClr == true) {
      double balQty = double.parse(soListController[index].text);

      await FetchBatchPdaApi.getGlobalData(
              openOrdLineList![index].lineNum.toString(),
              openOrdLineList![index].docEntry.toString(),
              openOrdLineList![index].openQty.toString(),
              17)
          .then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          fetchBatchData = value.fetchBatchData!;
          selectionBtnLoading = false;

          if (fetchBatchData.isNotEmpty) {
            for (var i = 0; i < fetchBatchData.length; i++) {
              if (balQty != 0) {
                if (balQty >= fetchBatchData[i].pickedQty) {
                  soScanItem.add(StocksnapModelData(
                      branch: AppConstant.branch,
                      baselineid: openOrdLineList![index].lineNum.toString(),
                      basedocentry: openOrdLineList![index].docEntry.toString(),
                      itemCode: fetchBatchData[i].itemCode,
                      itemName: openOrdLineList![index].description.toString(),
                      serialBatch: fetchBatchData[i].batchNum,
                      openRetQty: fetchBatchData[i].pickedQty,
                      maxdiscount: '0',
                      discountper: 0,
                      mrp: 0,
                      shipDate: '',
                      sellPrice: 0));
                  balQty = balQty - fetchBatchData[i].pickedQty;
                  notifyListeners();
                } else {
                  soScanItem.add(StocksnapModelData(
                      branch: AppConstant.branch,
                      shipDate: '',
                      baselineid: openOrdLineList![index].lineNum.toString(),
                      basedocentry: openOrdLineList![index].docEntry.toString(),
                      itemCode: fetchBatchData[i].itemCode,
                      itemName: openOrdLineList![index].description.toString(),
                      serialBatch: fetchBatchData[i].batchNum,
                      openRetQty: balQty,
                      maxdiscount: '0',
                      discountper: 0,
                      mrp: 0,
                      sellPrice: 0));

                  notifyListeners();

                  break;
                }
              }
            }
            if (soScanItem.isNotEmpty) {
              await mapItemCodeWiseSoItemData(index);
              openOrdLineList![index].valueInsert = true;
              for (var i = 0; i < soScanItem.length; i++) {
                if (openOrdLineList![index].itemCode ==
                        soScanItem[i].itemCode &&
                    openOrdLineList![index].lineNum.toString() ==
                        soScanItem[i].baselineid.toString()) {
                  soListqty = soListqty + soScanItem[i].openRetQty!;
                  soListController[index].text = soListqty.toString();
                  notifyListeners();
                }
              }
            }
          } else {
            batchselectbtndisable = false;
            autoselectbtndisable = false;
            manualselectbtndisable = false;

            selectionBtnLoading = false;
            noMsgText = value.error!;
            notifyListeners();
          }
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          batchselectbtndisable = false;
          autoselectbtndisable = false;
          manualselectbtndisable = false;

          selectionBtnLoading = false;
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
                        content: '${value.error}',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {});
          notifyListeners();
        } else {
          manualselectbtndisable = false;

          selectionBtnLoading = false;
          batchselectbtndisable = false;
          autoselectbtndisable = false;
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
                        content: '${value.error}',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {});
          notifyListeners();
        }
      });
    }
    batchselectbtndisable = false;
  }

  bool selectionBtnLoading = false;

  newAutoselectAllMethod(
    ThemeData theme,
    BuildContext context,
  ) async {
    openAutoSelect = [];
    double soListqty = 0;
    autoselectbtndisable = true;
    batchselectbtndisable = false;
    manualselectbtndisable = false;
    selectionBtnLoading = true;
    notifyListeners();
    noMsgText = '';
    String tempItem = '';
    String tempItem2 = '';
    String tempItem3 = '';

    List<String> itemCodeList = [];
    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      if (openOrdLineList![ih].checkBClr == true) {
        if (selectAll == false) {
          for (var ik = 0; ik < soScanItem.length; ik++) {
            if (openOrdLineList![ih].itemCode == soScanItem[ik].itemCode &&
                openOrdLineList![ih].lineNum.toString() ==
                    soScanItem[ik].baselineid.toString()) {
              soScanItem.removeAt(ik);
            }
          }

          notifyListeners();
        }

        if (selectAll == false) {
          for (var ix = 0; ix < soFilterScanItem.length; ix++) {
            if (openOrdLineList![ih].itemCode ==
                    soFilterScanItem[ix].itemCode &&
                openOrdLineList![ih].lineNum.toString() ==
                    soFilterScanItem[ix].baselineid.toString()) {
              soFilterScanItem.removeAt(ix);
            }
          }
        }
      }
    }
    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      if (openOrdLineList![ih].checkBClr == true) {
        itemCodeList.add(openOrdLineList![ih].itemCode);

        tempItem = itemCodeList.toString().replaceAll('[', '');
        tempItem2 = tempItem.toString().replaceAll(']', '');

        tempItem3 = tempItem2.toString().replaceAll(' ', '');
      }
    }
    await AutoSelectApi.getGlobalData(tempItem3).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openAutoSelect = value.openOutwardData!;
        selectionBtnLoading = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        batchselectbtndisable = false;
        autoselectbtndisable = false;
        manualselectbtndisable = false;

        selectionBtnLoading = false;
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
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    });
    double balQty = 0;
    for (var i = 0; i < openOrdLineList!.length; i++) {
      if (openOrdLineList![i].checkBClr == true) {
        balQty = double.parse(soListController[i].text);

        for (var im = 0; im < openAutoSelect!.length; im++) {
          if (openOrdLineList![i].itemCode == openAutoSelect![im].itemCode &&
              openAutoSelect![im].remQty > 0) {
            log('itemode::${openAutoSelect![im].itemCode}');
            if (balQty >= openAutoSelect![im].remQty && balQty != 0) {
              soScanItem.add(StocksnapModelData(
                branch: AppConstant.branch,
                shipDate: '',
                baselineid: openOrdLineList![i].lineNum.toString(),
                basedocentry: openOrdLineList![i].docEntry.toString(),
                itemCode: openAutoSelect![im].itemCode,
                itemName: openAutoSelect![im].itemName,
                serialBatch: openAutoSelect![im].batchNum,
                inDate: openAutoSelect![im].inDate,
                openRetQty: openAutoSelect![im].remQty,
                maxdiscount: '0',
                discountper: 0,
                mrp: 0,
                sellPrice: openAutoSelect![im].price,
              ));
              balQty = balQty - openAutoSelect![im].remQty;
              openAutoSelect![im].remQty = 0;
              notifyListeners();
            } else {
              if (balQty != 0) {
                soScanItem.add(StocksnapModelData(
                  branch: AppConstant.branch,
                  shipDate: '',
                  baselineid: openOrdLineList![i].lineNum.toString(),
                  basedocentry: openOrdLineList![i].docEntry.toString(),
                  itemCode: openAutoSelect![im].itemCode,
                  itemName: openAutoSelect![im].itemName,
                  serialBatch: openAutoSelect![im].batchNum,
                  inDate: openAutoSelect![im].inDate,
                  openRetQty: balQty,
                  maxdiscount: '0',
                  discountper: 0,
                  mrp: 0,
                  sellPrice: openAutoSelect![im].price,
                ));

                openAutoSelect![im].remQty =
                    openAutoSelect![im].remQty - balQty;
                balQty = 0;
                notifyListeners();
                break;
              }
            }
          }
        }
      }
    }
    await mapItemCodeWiseSoAllData();

    for (var i = 0; i < openOrdLineList!.length; i++) {
      if (openOrdLineList![i].checkBClr == true) {
        soListqty = 0;

        for (var iv = 0; iv < soScanItem.length; iv++) {
          if (openOrdLineList![i].itemCode == soScanItem[iv].itemCode &&
              openOrdLineList![i].lineNum.toString() ==
                  soScanItem[iv].baselineid.toString()) {
            soListqty = soListqty + soScanItem[iv].openRetQty!;
            openOrdLineList![i].valueInsert = true;

            soListController[i].text = soListqty.toString();
            notifyListeners();
          }
        }
      }
    }
    autoselectbtndisable = false;

    notifyListeners();
  }

  manualQtyChange(int index, int ih, BuildContext context, ThemeData theme) {
    double manualqty = double.parse(manualQtyCtrl[index].text);
    double soListqty = double.parse(soListController[ih].text);

    if (manualqty <= soListqty) {
      manualQtyCtrl[index].text = manualqty.toString();
    } else {
      manualQtyCtrl[index].text = 1.toString();

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
    }
  }

  bool extraqty = false;

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

          if (qty2 <= double.parse(soListController[ih].text)) {
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

  manualselectItemMethod(
    int ih,
    ThemeData theme,
    BuildContext context,
  ) async {
    openAutoSelect = [];
    double soListqty = 0;
    autoselectbtndisable = false;
    manualselectbtndisable = true;
    batchselectbtndisable = false;
    selectionBtnLoading = true;
    manualQtyCtrl = List.generate(100, (ij) => TextEditingController());

    notifyListeners();
    noMsgText = '';

    if (selectIndex == ih) {
      for (var ik = 0; ik < soScanItem.length; ik++) {
        if (openOrdLineList![ih].itemCode == soScanItem[ik].itemCode &&
            openOrdLineList![ih].lineNum.toString() ==
                soScanItem[ik].baselineid.toString()) {
          soScanItem.removeAt(ik);
        }
      }

      notifyListeners();
    }
    if (selectIndex == ih) {
      for (var ix = 0; ix < soFilterScanItem.length; ix++) {
        if (openOrdLineList![ih].itemCode == soFilterScanItem[ix].itemCode &&
            openOrdLineList![ih].lineNum.toString() ==
                soFilterScanItem[ix].baselineid.toString()) {
          soFilterScanItem.removeAt(ix);
        }
      }
    }

    if (openOrdLineList![ih].checkBClr == true) {
      await AutoSelectApi.getGlobalData(openOrdLineList![ih].itemCode)
          .then((value) async {
        if (value.statusCode! >= 200 && value.statusCode! <= 210) {
          openAutoSelect = value.openOutwardData!;
          selectionBtnLoading = false;
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
                            'S.O Qty ${soListController[ih].text}',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                manualselectbtndisable = false;
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
                                                      width: Screens.width(
                                                              context) *
                                                          0.08,
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.053,
                                                      child: TextFormField(
                                                        onTap: () {
                                                          manualQtyCtrl[index]
                                                                  .text =
                                                              manualQtyCtrl[
                                                                      index]
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
                                                        inputFormatters: [
                                                          DecimalInputFormatter()
                                                        ],
                                                        onChanged: (val) {
                                                          doubleDotMethodautomethod(
                                                              index, val);
                                                        },
                                                        onEditingComplete: () {
                                                          disableKeyBoard(
                                                              context);
                                                        },
                                                        controller:
                                                            manualQtyCtrl[
                                                                index],
                                                        decoration:
                                                            InputDecoration(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      15),
                                                          hintText: "",
                                                          hintStyle: theme
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
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
                                await onTapSoBtn(ih);
                                log('extraqtyextraqty222::$extraqty');
                                if (extraqty == true) {
                                  showDialog(
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
                                                    'Allocation qty is grater than sales order qty',
                                                theme: theme,
                                              )),
                                              buttonName: null,
                                            ));
                                      }).then((value) {
                                    extraqty = false;
                                  });
                                } else {
                                  for (var xx = 0;
                                      xx < openAutoSelect!.length;
                                      xx++) {
                                    log('manualQtyCtrl[xx].text::${manualQtyCtrl[xx].text}');
                                    if (manualQtyCtrl[xx].text.isNotEmpty) {
                                      if (manualQtyCtrl[xx].text != '0') {
                                        soScanItem.add(StocksnapModelData(
                                          branch: AppConstant.branch,
                                          shipDate: '',
                                          baselineid: openOrdLineList![ih]
                                              .lineNum
                                              .toString(),
                                          basedocentry: openOrdLineList![ih]
                                              .docEntry
                                              .toString(),
                                          itemCode:
                                              openAutoSelect![xx].itemCode,
                                          itemName:
                                              openAutoSelect![xx].itemName,
                                          serialBatch:
                                              openAutoSelect![xx].batchNum,
                                          inDate: openAutoSelect![xx].inDate,
                                          openRetQty: double.parse(
                                              manualQtyCtrl[xx].text),
                                          maxdiscount: '0',
                                          discountper: 0,
                                          mrp: 0,
                                          sellPrice: openAutoSelect![xx].price,
                                        ));
                                        notifyListeners();
                                      }
                                    } else {}
                                  }
                                  await mapItemCodeWiseSoItemData(ih);
                                  openOrdLineList![ih].valueInsert = true;
                                  manualselectbtndisable = false;
                                  Get.back();
                                }
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

            soListqty = 0;

            for (var iv = 0; iv < soScanItem.length; iv++) {
              if (openOrdLineList![ih].itemCode == soScanItem[iv].itemCode &&
                  openOrdLineList![ih].lineNum.toString() ==
                      soScanItem[iv].baselineid.toString()) {
                soListqty = soListqty + soScanItem[iv].openRetQty!;
                openOrdLineList![ih].valueInsert = true;

                soListController[ih].text = soListqty.toString();
                notifyListeners();
              }
            }
          } else {
            noMsgText = value.error!;
            batchselectbtndisable = false;
            manualselectbtndisable = false;

            autoselectbtndisable = false;
          }
        } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
          batchselectbtndisable = false;
          autoselectbtndisable = false;
          manualselectbtndisable = false;
          selectionBtnLoading = false;
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
                        content: '${value.error}',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              }).then((value) {});
          notifyListeners();
        } else {
          batchselectbtndisable = false;
          autoselectbtndisable = false;
          selectionBtnLoading = false;
          manualselectbtndisable = false;
        }
        notifyListeners();
      });
    }
    notifyListeners();
  }

  newAutoselectItemMethod(
    ThemeData theme,
    BuildContext context,
  ) async {
    double soListqty = 0;
    openAutoSelect = [];
    autoselectbtndisable = true;
    batchselectbtndisable = false;
    manualselectbtndisable = false;
    selectionBtnLoading = true;
    String tempItem = '';
    String tempItem2 = '';
    String tempItem3 = '';

    List<String> itemCodeList = [];
    notifyListeners();
    noMsgText = '';
    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      if (openOrdLineList![ih].checkBClr == true) {
        itemCodeList.add(openOrdLineList![ih].itemCode);

        tempItem = itemCodeList.toString().replaceAll('[', '');
        tempItem2 = tempItem.toString().replaceAll(']', '');
        log('tempItem2tempItem2::${tempItem2.toString()}');

        tempItem3 = tempItem2.toString().replaceAll(' ', '');

        log('tempItem3tempItem3::${tempItem3.toString()}');
        if (selectAll == false) {
          for (var ik = 0; ik < soScanItem.length; ik++) {
            if (openOrdLineList![ih].itemCode == soScanItem[ik].itemCode &&
                openOrdLineList![ih].lineNum.toString() ==
                    soScanItem[ik].baselineid.toString()) {
              soScanItem.removeAt(ik);
            }

            notifyListeners();
          }

          if (selectAll == false) {
            for (var ix = 0; ix < soFilterScanItem.length; ix++) {
              if (openOrdLineList![ih].itemCode ==
                      soFilterScanItem[ix].itemCode &&
                  openOrdLineList![ih].lineNum.toString() ==
                      soFilterScanItem[ix].baselineid.toString()) {
                soFilterScanItem.removeAt(ix);
              }
            }
          }
        }
      }
    }

    await AutoSelectApi.getGlobalData(tempItem3).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.openOutwardData!.isNotEmpty) {
          openAutoSelect = value.openOutwardData!;
        } else {
          noMsgText = value.error!;
          batchselectbtndisable = false;
          autoselectbtndisable = false;
          manualselectbtndisable = false;
        }
        selectionBtnLoading = false;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        batchselectbtndisable = false;
        autoselectbtndisable = false;
        manualselectbtndisable = false;

        selectionBtnLoading = false;
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
                      content: '${value.error}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            });
      }
    });

    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      if (openOrdLineList![ih].checkBClr == true) {
        double balQty = double.parse(soListController[ih].text);
        for (var im = 0; im < openAutoSelect!.length; im++) {
          if (openOrdLineList![ih].itemCode == openAutoSelect![im].itemCode &&
              openAutoSelect![im].remQty > 0) {
            if (balQty >= openAutoSelect![im].remQty) {
              log('itemcode:111:${openAutoSelect![im].itemCode}');

              soScanItem.add(StocksnapModelData(
                branch: AppConstant.branch,
                baselineid: openOrdLineList![ih].lineNum.toString(),
                basedocentry: openOrdLineList![ih].docEntry.toString(),
                itemCode: openAutoSelect![im].itemCode,
                itemName: openAutoSelect![im].itemName,
                shipDate: '',
                serialBatch: openAutoSelect![im].batchNum,
                inDate: openAutoSelect![im].inDate,
                openRetQty: openAutoSelect![im].remQty,
                maxdiscount: '0',
                discountper: 0,
                mrp: 0,
                sellPrice: openAutoSelect![im].price,
              ));
              balQty = balQty - openAutoSelect![im].remQty;
              openAutoSelect![im].remQty = 0;
              notifyListeners();
            } else {
              log('itemcode::${openAutoSelect![im].itemCode}');

              soScanItem.add(StocksnapModelData(
                branch: AppConstant.branch,
                shipDate: '',
                baselineid: openOrdLineList![ih].lineNum.toString(),
                basedocentry: openOrdLineList![ih].docEntry.toString(),
                itemCode: openAutoSelect![im].itemCode,
                itemName: openAutoSelect![im].itemName,
                serialBatch: openAutoSelect![im].batchNum,
                inDate: openAutoSelect![im].inDate,
                openRetQty: balQty,
                maxdiscount: '0',
                discountper: 0,
                mrp: 0,
                sellPrice: openAutoSelect![im].price,
              ));

              openAutoSelect![im].remQty = openAutoSelect![im].remQty - balQty;
              balQty = 0;
              notifyListeners();
              break;
            }
          }
        }
      }
    }
    await mapItemCodeWiseSoAllData();

    for (var ih = 0; ih < openOrdLineList!.length; ih++) {
      if (openOrdLineList![ih].checkBClr == true) {
        soListqty = 0;

        for (var iv = 0; iv < soScanItem.length; iv++) {
          if (openOrdLineList![ih].itemCode == soScanItem[iv].itemCode &&
              openOrdLineList![ih].lineNum.toString() ==
                  soScanItem[iv].baselineid.toString()) {
            soListqty = soListqty + soScanItem[iv].openRetQty!;
            openOrdLineList![ih].valueInsert = true;

            soListController[ih].text = soListqty.toString();
            notifyListeners();
          }
        }

        notifyListeners();
      }
    }
  }

  String expMsg = '';

  callEInvoiceApi(BuildContext context, ThemeData theme) async {
    ondDisablebutton = true;

    expMsg = '';
    await AREinvoiceAPI.getGlobalData(sapDocentry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('value.message ::${value.message}');
        if (value.message.toString() == 'Success') {
          if (value.fetchBatchData != null) {
            InvoicePatchAPI.U_rctCde = value.fetchBatchData!.rctCde.toString();
            InvoicePatchAPI.U_QRPath = value.fetchBatchData!.qrPath;
            InvoicePatchAPI.U_QRValue = value.fetchBatchData!.qrValue;
            InvoicePatchAPI.U_VfdIn = value.fetchBatchData!.vfdIn;
            InvoicePatchAPI.U_Zno = value.fetchBatchData!.zno;
            InvoicePatchAPI.U_idate = value.fetchBatchData!.idate;
            InvoicePatchAPI.U_itime = value.fetchBatchData!.itime;
            InvoicePatchAPI.method();
            await InvoicePatchAPI.getGlobalData(sapDocentry)
                .then((value) async {
              if (value.statusCode >= 200 && value.statusCode <= 210) {
                getInvoiceApi(sapDocentry.toString(), context, theme);
                notifyListeners();
              }
            });
            notifyListeners();
            await Get.defaultDialog(
                title: "Success",
                middleText:
                    'Successfully Done,\nE-Invoice Generated Successfully',
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
                ]);
          }
        } else if (value.message.toString() == 'IsPosted') {
          await Get.defaultDialog(
              title: "Success",
              middleText:
                  'Successfully Done\nAlready - E-Invoice is generated for this document',
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
              ]);
          notifyListeners();
        } else if (value.message.toString() == 'Failed') {
          expMsg = value.error.toString();

          await Get.defaultDialog(
              title: "Failed",
              middleText: '$expMsg',
              backgroundColor: Colors.white,
              titleStyle: const TextStyle(color: Colors.red),
              middleTextStyle: const TextStyle(color: Colors.black),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: const Text("Close"),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
              ]);
          notifyListeners();
        } else {
          expMsg = value.error.toString();

          await Get.defaultDialog(
              title: "Success",
              middleText: 'Successfully Done,\n$expMsg',
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
              ]);
        }
        ondDisablebutton = false;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        expMsg = value.error.toString();

        await Get.defaultDialog(
            title: "Success",
            middleText: 'Successfully Done,\n$expMsg',
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
            ]);
      } else {
        expMsg = value.error.toString();

        await Get.defaultDialog(
            title: "Alert",
            middleText: '$expMsg',
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
            ]);
        ondDisablebutton = false;
      }
    });
    notifyListeners();
  }

  callInvoicePostApi(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    seriesType = '';
    sapDocentry = '';
    sapDocuNumber = '';
    sapReceiptDocNum = '';
    sapReceiptDocentry = '';
    await sapLoginApi(context);
    if (cpyfrmso == "CopyfromSo") {
      await callSeriesApi(context, '13');

      await postingOrdertoInvoice(
          context, theme, docEntry, docstatus, documentNum);

      notifyListeners();
    } else {
      await callSeriesApi(context, '13');

      await postingDirectInvoice(
          context, theme, docEntry, docstatus, documentNum);

      notifyListeners();
    }

    notifyListeners();
  }

  List<Invbatch>? batchTable;
  List<Invbatch> soBatchTable = [];

  addBatchtable(int ik) {
    batchTable = [];
    if (cpyfrmso == 'CopyfromSo') {
      for (var i = 0; i < soBatchTable.length; i++) {
        if (scanneditemData[ik].itemCode == soBatchTable[i].itemCode &&
            scanneditemData[ik].baselineid.toString() ==
                soBatchTable[i].lineId.toString()) {
          batchTable!.add(Invbatch(
              quantity: soBatchTable[i].quantity,
              batchNumberProperty: soBatchTable[i].batchNumberProperty));
        }
        notifyListeners();
      }
    } else {
      batchTable!.add(Invbatch(
        quantity: double.parse(scanneditemData[ik].qty.toString()),
        batchNumberProperty: scanneditemData[ik].serialBatch.toString(),
      ));
      notifyListeners();
    }
  }

  List<PostingInvoiceLines> itemsDocDetails = [];

  addDocLine() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      addBatchtable(i);
      itemsDocDetails.add(PostingInvoiceLines(
        currency: "TZS",
        discPrcnt: scanneditemData[i].discountper.toString(),
        itemCode: scanneditemData[i].itemCode,
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].qty.toString(),
        taxCode: selectedcust!.taxCode,
        unitPrice: scanneditemData[i].sellPrice!.toStringAsFixed(2),
        whsCode: UserValues.branch,
        itemName: scanneditemData[i].itemName.toString(),
        batchNumbers: batchTable!,
        baseType: scanneditemData[i].basedocentry != null ? 17 : null,
        basedocentry: scanneditemData[i].basedocentry,
        baseline: scanneditemData[i].baselineid,
      ));
      notifyListeners();
    }
  }

  addDocLineOrderToInvoice() {
    itemsDocDetails = [];
    for (int i = 0; i < scanneditemData.length; i++) {
      addBatchtable(i);
      itemsDocDetails.add(PostingInvoiceLines(
        currency: "TZS",
        discPrcnt: scanneditemData[i].discountper.toString(),
        itemCode: scanneditemData[i].itemCode,
        price: scanneditemData[i].sellPrice.toString(),
        quantity: scanneditemData[i].openRetQty.toString(),
        taxCode: selectedcust!.taxCode,
        unitPrice: scanneditemData[i].sellPrice!.toStringAsFixed(2),
        whsCode: UserValues.branch,
        itemName: scanneditemData[i].itemName.toString(),
        batchNumbers: batchTable!,
        baseType: scanneditemData[i].basedocentry != null ? 17 : null,
        basedocentry: scanneditemData[i].basedocentry,
        baseline: scanneditemData[i].baselineid,
      ));
      notifyListeners();
    }
  }

//
  List<PostPaymentCheck> itemsPaymentCheckDet = [];
  List<PostPaymentInvoice> itemsPaymentInvDet = [];
  List<PostPaymentCard> itemcardPayment = [];
  double chequeSum = 0;

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
        chequeSum = paymentWay[i].amt!;
      }

      notifyListeners();
    }
    notifyListeners();
  }

  postingReceipt22(
    BuildContext context,
    ThemeData theme,
    int docEntry,
  ) async {
    final Database db = (await DBHelper.getInstance())!;

    log('message payreceipt');
    seriesType = '';

    await callSeriesApi(context, '24');

    await addChequeValues22();
    await addCardValues();
    await addInvoiceLine();
    ReceiptPostAPi.transferAccount = null;
    ReceiptPostAPi.seriesType = seriesType;

    ReceiptPostAPi.transferSum = null;
    ReceiptPostAPi.cashSum = null;
    ReceiptPostAPi.transferReference = '';
    ReceiptPostAPi.docType = "rCustomer";
    ReceiptPostAPi.checkAccount = chequeAccCode;
    ReceiptPostAPi.cardCodePost = selectedcust!.cardCode;
    ReceiptPostAPi.docPaymentChecks = itemsPaymentCheckDet;
    ReceiptPostAPi.docPaymentInvoices = itemsPaymentInvDet;
    ReceiptPostAPi.docPaymentCards = itemcardPayment;
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

    ReceiptPostAPi.method(); //24-20268
    await ReceiptPostAPi.getGlobalData().then((value) async {
      if (value.stscode == null) {
        return;
      }
      if (value.stscode! >= 200 && value.stscode! <= 210) {
        if (value.docNum != null) {
          sapReceiptDocentry = value.docEntry.toString();
          sapReceiptDocNum = value.docNum.toString();
          await DBOperation.updateRcSapDetSalpay(
              db,
              docEntry,
              int.parse(value.docNum.toString()),
              int.parse(value.docEntry.toString()),
              "SalesPay");
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
        }
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
                      content: '${value.error!.message!.value}',
                      theme: theme,
                    )),
                    buttonName: null,
                  ));
            }).then((value) {
          mycontroller = List.generate(150, (i) => TextEditingController());
          selectedcust = null;
          paymentWay.clear();
          remarkcontroller3.text = "";
          scanneditemData.clear();
          ondDisablebutton = false;
          notifyListeners();
        });
      }
    });
    notifyListeners();
  }

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
            creditcardCode: 1,
            voucherNum: paymentWay[i].reference.toString(),
            creditCardNum: paymentWay[i].cardApprno.toString()));
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

  addInvoiceLine() {
    itemsPaymentInvDet = [];
    if (scanneditemData.isNotEmpty) {
      double? cashamt = cashpayment ?? 0;
      double? chequeamt = cqpayment ?? 0;
      double? transamt = transpayment ?? 0;
      double creditcrdamt = creditCardAmt ?? 0;
      itemsPaymentInvDet.add(PostPaymentInvoice(
          docEntry: int.parse(sapDocentry.toString()),
          docNum: int.parse(sapDocuNumber.toString()),
          sumApplied: cashamt + chequeamt + transamt + creditcrdamt,
          invoiceType: 'it_Invoice'));
    }
    notifyListeners();
  }

  postingOrdertoInvoice(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    expMsg = '';

    final Database db = (await DBHelper.getInstance())!;
    addDocLineOrderToInvoice();
    OrderToInvoicesPostAPI.docType = 'dDocument_Items';
    OrderToInvoicesPostAPI.seriesType = seriesType.toString();
    OrderToInvoicesPostAPI.cardCodePost = selectedcust!.cardCode;
    OrderToInvoicesPostAPI.cardName = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;
    OrderToInvoicesPostAPI.docLineQout = itemsDocDetails;
    OrderToInvoicesPostAPI.tinNo = tinNoController.text;
    OrderToInvoicesPostAPI.VATNo = vatNoController.text;
    OrderToInvoicesPostAPI.docDate = config.currentDate();
    OrderToInvoicesPostAPI.dueDate = config.currentDate().toString();
    OrderToInvoicesPostAPI.remarks = remarkcontroller3.text;
    OrderToInvoicesPostAPI.uTruckInternal =
        int.parse(selectedTruckType.toString());

    var uuid = const Uuid();
    String? uuidg = uuid.v1();
    OrderToInvoicesPostAPI.method(uuidg);
    await OrderToInvoicesPostAPI.getGlobalData(uuidg).then((value) async {
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        if (cashType == 'Cash' ||
            chequeType == "Cheque" ||
            cardType == "Card" ||
            transferType == "Transfer" ||
            walletType == "Wallet" ||
            pointType == 'Points Redemption') {
          log("mycontroller[22].text:::$cashpayment");
        }

        await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry!),
            int.parse(sapDocuNumber), docEntry, 'SalesHeader');

        notifyListeners();
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done,\nDocument Number $sapDocuNumber'
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
          if (docstatus == "check out") {
            mycontroller = List.generate(150, (i) => TextEditingController());
            qtymycontroller =
                List.generate(150, (i) => TextEditingController());
            discountcontroller =
                List.generate(100, (i) => TextEditingController());
            selectedcust = null;
            schemebtnclk = false;
            paymentWay.clear();
            custNameController.text = '';
            tinNoController.text = '';
            vatNoController.text = '';
            cashAccCode = '';
            cardAcctype = '';
            cardAccCode = '';
            chequeAcctype = '';
            chequeAccCode = '';
            transAcctype = '';
            transAccCode = '';
            walletAcctype = '';
            walletAccCode = '';
            totalPayment = null;
            udfController = List.generate(100, (ij) => TextEditingController());
            cpyfrmso = '';
            newAddrsValue = [];
            newCustValues = [];
            itemsDocDetails = [];
            fetchBatchData = [];
            openAutoSelect = [];
            remarkcontroller3.text = "";
            scanneditemData.clear();
            ondDisablebutton = false;
            cashType = '';
            chequeType = '';
            cardType = '';
            transferType = '';
            walletType = '';
            selectedTruckType = null;
            isSelectTruckType = false;
            pointType = '';
            injectToDb();
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          ondDisablebutton = false;
          notifyListeners();
        });
        custserieserrormsg = '';
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
          ondDisablebutton = false;
          notifyListeners();
        });
      } else {
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
      }
    });

    notifyListeners();
  }

  List<InvCustomerAddModelData>? custDetails;
  List<CompanyTinVatMdlData>? cmpnyDetails = [];
  callCompanyTinVatApii() {
    CompanyTinVatApii.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 200) {
        if (value.openOutwardData!.isNotEmpty) {
          cmpnyDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 400) {}
    });
  }

  invCustAddressApi(String docEntry) async {
    await InvAddressApi.getGlobalData(docEntry).then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 200) {
        if (value.openOutwardData!.isNotEmpty) {
          custDetails = value.openOutwardData!;
        }
      } else if (value.statusCode! >= 400 && value.statusCode! <= 400) {}
    });
    callCompanyTinVatApii();
  }

  postingDirectInvoice(BuildContext context, ThemeData theme, int docEntry,
      String docstatus, String documentNum) async {
    final Database db = (await DBHelper.getInstance())!;
    addDocLine();
    expMsg = '';
    DirectInvoicePostAPI.docType = 'dDocument_Items';
    DirectInvoicePostAPI.seriesType = seriesType.toString();
    DirectInvoicePostAPI.cardCodePost = selectedcust!.cardCode;
    DirectInvoicePostAPI.cardName = custNameController.text.isNotEmpty
        ? custNameController.text
        : selectedcust!.name;
    DirectInvoicePostAPI.docLineQout = itemsDocDetails;
    DirectInvoicePostAPI.tinNo = tinNoController.text;
    DirectInvoicePostAPI.docDate = config.currentDate();
    DirectInvoicePostAPI.dueDate = config.currentDate().toString();
    DirectInvoicePostAPI.remarks = remarkcontroller3.text;
    DirectInvoicePostAPI.uTruckInternal =
        int.parse(selectedTruckType.toString());
    var uuid = const Uuid();
    String? uuidg = uuid.v1();
    DirectInvoicePostAPI.method(uuidg);
    await DirectInvoicePostAPI.getGlobalData(uuidg).then((value) async {
      if (value.statusCode == null) {
        return;
      }
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        sapDocentry = value.docEntry.toString();
        sapDocuNumber = value.docNum.toString();
        if (cashType == 'Cash' ||
            chequeType == "Cheque" ||
            cardType == "Card" ||
            transferType == "Transfer" ||
            walletType == "Wallet" ||
            pointType == 'Points Redemption') {
          log("mycontroller[22].text:::$cashpayment");
        }

        await DBOperation.updtSapDetSalHead(db, int.parse(sapDocentry!),
            int.parse(sapDocuNumber), docEntry, 'SalesHeader');

        notifyListeners();
        await Get.defaultDialog(
                title: "Success",
                middleText: docstatus == "check out"
                    ? 'Successfully Done,\nDocument Number $sapDocuNumber'
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
          if (docstatus == "check out") {
            mycontroller = List.generate(150, (i) => TextEditingController());
            qtymycontroller =
                List.generate(150, (i) => TextEditingController());
            discountcontroller =
                List.generate(100, (i) => TextEditingController());
            udfController = List.generate(100, (ij) => TextEditingController());
            selectedcust = null;
            schemebtnclk = false;
            paymentWay.clear();
            cashAccCode = '';
            cardAcctype = '';
            cardAccCode = '';
            chequeAcctype = '';
            tinNoController.text = '';
            vatNoController.text = '';
            custNameController.text = '';

            chequeAccCode = '';
            transAcctype = '';
            transAccCode = '';
            walletAcctype = '';
            walletAccCode = '';
            totalPayment = null;
            cashType = '';
            transpayment = null;
            transrefff = '';
            chequeType = '';
            cardType = '';
            transferType = '';
            walletType = '';
            pointType = '';
            cpyfrmso = '';
            newAddrsValue = [];
            itemsDocDetails = [];
            fetchBatchData = [];
            openAutoSelect = [];
            newCustValues = [];
            remarkcontroller3.text = "";
            scanneditemData.clear();
            ondDisablebutton = false;
            custNameController.text = '';
            tinNoController.text = '';
            vatNoController.text = '';
            injectToDb();
            Get.offAllNamed(ConstantRoutes.dashboard);
          }
          ondDisablebutton = false;
          notifyListeners();
        });
        custserieserrormsg = '';
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
          ondDisablebutton = false;
          notifyListeners();
        });
      } else {
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
      }
    });

    notifyListeners();
  }

  pushRabitmqSales(int? docentry) async {
    //background service

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    var ddd = json.encode({
      "ObjectType": 1,
      "ActionType": "Add",
      "InvoiceHeader": salesHeader,
      "InvoiceLine": salesLine,
      "InvoicePay": salesPAY,
    });

    //RabitMQ

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);

    //cs

    properties.headers = {"branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  pushRabitmqSales2(int? docentry) async {
    //background service

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBSalespay =
        await DBOperation.getHoldSalesPayDB(db, docentry!);
    List<Map<String, Object?>> getDBSalesLine =
        await DBOperation.holdSalesLineDB(db, docentry);
    List<Map<String, Object?>> getDBSalesHeader =
        await DBOperation.getSalesHeaderDB(db, docentry);
    String salesPAY = json.encode(getDBSalespay);
    String salesLine = json.encode(getDBSalesLine);
    String salesHeader = json.encode(getDBSalesHeader);

    var ddd = json.encode({
      "ObjectType": 1,
      "ActionType": "Add",
      "InvoiceHeader": salesHeader,
      "InvoiceLine": salesLine,
      "InvoicePay": salesPAY,
    });

    ConnectionSettings settings = ConnectionSettings(
        host: AppConstant.ip.toString().trim(),

        //"102.69.167.106"
        port: 5672,
        authProvider: const PlainAuthenticator("buson", "BusOn123"));
    Client client1 = Client(settings: settings);

    MessageProperties properties = MessageProperties();

    properties.headers = {"branch": UserValues.branch};
    Channel channel = await client1.channel(); //Server_CS
    Exchange exchange =
        await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
    exchange.publish(ddd, "", properties: properties);

    //cs

    client1.close();
  }

  viewDbtable() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getdata(db);
    notifyListeners();
  }

  viewSalesRet() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.viewsalesret(db);
  }

  getCustDetFDB() async {
    custList.clear();
    custList2.clear();

    log('come inside the get cust det');
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

  clickItemcode(
      ItemCodeListModel aaa, BuildContext context, ThemeData theme, int inddd) {
    itemcodeitem = null;
    itemcodeitem = ItemCodeListModel(
      branch: aaa.branch,
      itemCode: aaa.itemCode,
      itemName: aaa.itemName,
      serialBatch: aaa.serialBatch,
      qty: aaa.qty,
      mrp: double.parse(aaa.mrp.toString()),
      createdUserID: aaa.createdUserID.toString(),
      createdateTime: aaa.createdateTime,
      lastupdateIp: aaa.lastupdateIp,
      purchasedate: aaa.purchasedate,
      snapdatetime: aaa.snapdatetime,
      specialprice: double.parse(aaa.specialprice.toString()),
      updatedDatetime: aaa.updatedDatetime,
      updateduserid: aaa.updateduserid.toString(),
      sellPrice: double.parse(aaa.sellPrice.toString()),
      maxdiscount: aaa.maxdiscount != null ? aaa.maxdiscount.toString() : '',
      taxRate: aaa.taxRate != null ? double.parse(aaa.taxRate.toString()) : 00,
      discountper: 0,
      openQty: 0,
      inDate: '',
      cost: 0,
      inType: '',
      uPackSize: aaa.uPackSize,
      uTINSPERBOX: aaa.uTINSPERBOX,
      uSpecificGravity: aaa.uSpecificGravity,
    );

    itemcodelistitem55.add(itemcodeitem!);
    aaaabbb(context, theme, inddd);
    notifyListeners();
  }

  aaaabbb(BuildContext context, ThemeData theme, int i) {
    itemcodedataaa(context, theme, i);
    mycontroller[99].clear();

    calCulateDocVal(context, theme);
    notifyListeners();
  }

  itemcodedataaa(BuildContext context, ThemeData theme, int i) {
    if (itemcodelistitem[i].qty! > 0) {
      log('itemcodelistitem[i].uPackSize::${itemcodelistitem[i].uPackSize.toString()}');
      scanneditemData.add(StocksnapModelData(
        branch: itemcodelistitem[i].branch,
        itemCode: itemcodelistitem[i].itemCode,
        itemName: itemcodelistitem[i].itemName,
        shipDate: '',
        serialBatch: itemcodelistitem[i].serialBatch,
        inStockQty: 0,
        qty: 1,
        mrp: double.parse(itemcodelistitem[i].mrp.toString()),
        createdUserID: itemcodelistitem[i].createdUserID.toString(),
        createdateTime: itemcodelistitem[i].createdateTime,
        lastupdateIp: itemcodelistitem[i].lastupdateIp,
        purchasedate: itemcodelistitem[i].purchasedate,
        snapdatetime: itemcodelistitem[i].snapdatetime,
        specialprice: double.parse(itemcodelistitem[i].specialprice.toString()),
        updatedDatetime: itemcodelistitem[i].updatedDatetime,
        updateduserid: itemcodelistitem[i].updateduserid.toString(),
        sellPrice: double.parse(itemcodelistitem[i].sellPrice.toString()),
        maxdiscount: itemcodelistitem[i].maxdiscount != null
            ? itemcodelistitem[i].maxdiscount.toString()
            : '',
        uPackSize: itemcodelistitem[i].uPackSize ?? 0,
        uSpecificGravity: itemcodelistitem[i].uSpecificGravity ?? 0,
        uTINSPERBOX: itemcodelistitem[i].uTINSPERBOX ?? 0,
        discountper: 0,
        openQty: itemcodelistitem[i].qty,
        inDate: '',
        cost: 0,
        inType: '',
        liter: itemcodelistitem[i].liter != null
            ? double.parse(itemcodelistitem[i].liter.toString())
            : 0.0,
        weight: itemcodelistitem[i].weight != null
            ? double.parse(itemcodelistitem[i].weight.toString())
            : 0.0,
      ));

      for (int i = 0; i < scanneditemData.length; i++) {
        scanneditemData[i].transID = i;
        scanneditemData[i].discountper = 0.00;

        discountcontroller[i].text = 0.0.toString();
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
      }

      FocusScopeNode focus = FocusScope.of(context);

      if (!focus.hasPrimaryFocus) {
        focus.unfocus();
      }
      notifyListeners();

      qtychangemtd(
        scanneditemData.length - 1,
        context,
        theme,
      );
      calCulateDocVal(context, theme);
      focusnode[0].requestFocus();
    }
  }

  getCustSeriesApi() async {
    mycontroller[48].text = AppConstant.slpCode.toString();
    //GetValues.slpCode!;
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
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();
      for (int i = 0; i < filesz.length; i++) {
        vatFiles = filesz[i];
        notifyListeners();
      }
    }
  }

  void selectattachment() async {
    log('xxxxxxx');
    result = await FilePicker.platform.pickFiles();

    if (result != null) {
      //filedata.clear();
      List<File> filesz = result!.paths.map((path) => File(path!)).toList();

      for (int i = 0; i < filesz.length; i++) {
        tinFiles = filesz[i];
        notifyListeners();
      }
    }
    log('xxxxxxx222222:::$tinFiles');
  }

  Future<int?> checkBatchAvail(
    String sBatch,
    BuildContext context,
    ThemeData theme,
  ) async {
    final Database db = (await DBHelper.getInstance())!;
    itemcodelistitem.clear();
    itemcodeitem = null;

    List<Map<String, Object?>> itemcodelist =
        await DBOperation.itemcodeserialbatch(db, sBatch);

    for (int ia = 0; ia < itemcodelist.length; ia++) {
      itemcodelistitem.add(ItemCodeListModel(
          itemCode: itemcodelist[ia]['itemcode'].toString(),
          itemName: itemcodelist[ia]['itemname'].toString(),
          serialBatch: itemcodelist[ia]['serialbatch'].toString(),
          qty: double.parse(itemcodelist[ia]['quantity'].toString()),
          mrp: itemcodelist[ia]['mrpprice'] != null
              ? double.parse(itemcodelist[ia]['mrpprice'].toString())
              : null,
          createdUserID: itemcodelist[ia]['createdUserID'].toString(),
          createdateTime: itemcodelist[ia]['itecreatedateTimemname'].toString(),
          lastupdateIp: itemcodelist[ia]['lastupdateIp'].toString(),
          purchasedate: itemcodelist[ia]['purchasedate'].toString(),
          snapdatetime: itemcodelist[ia]['snapdatetime'].toString(),
          specialprice: itemcodelist[ia]['specialprice'] == null ||
                  itemcodelist[ia]['specialprice'] == 'null'
              ? 0
              : double.parse(
                  itemcodelist[ia]['specialprice'].toString(),
                ),
          updatedDatetime: itemcodelist[ia]['UpdatedDatetime'].toString(),
          updateduserid: itemcodelist[ia]['updateduserid'].toString(),
          sellPrice: itemcodelist[ia]['sellprice'] != null
              ? double.parse(
                  itemcodelist[ia]['sellprice'].toString(),
                )
              : null,
          maxdiscount: itemcodelist[ia]['maxdiscount'] != null
              ? itemcodelist[ia]['maxdiscount'].toString()
              : '',
          taxRate: itemcodelist[ia]['taxrate'] != null
              ? double.parse(
                  itemcodelist[ia]['taxrate'].toString(),
                )
              : 00,
          discountper: 0,
          openQty: 0,
          inDate: '',
          cost: 0,
          inType: '',
          weight: itemcodelist[ia]['weight'] != null
              ? double.parse(itemcodelist[ia]['weight'].toString())
              : null,
          liter: itemcodelist[ia]['liter'] != null
              ? double.parse(itemcodelist[ia]['liter'].toString())
              : null,
          uPackSize: double.parse(itemcodelist[ia]['UPackSize'].toString()),
          uTINSPERBOX: int.parse(itemcodelist[ia]['UTINSPERBOX'].toString()),
          uSpecificGravity:
              double.parse(itemcodelist[ia]['USpecificGravity'].toString())));
    }
    if (itemcodelistitem.isNotEmpty) {
      if (itemcodelistitem.length == 1) {
        aaaabbb(context, theme, 0);
        notifyListeners();
      } else {
        foritemCodecheck(
          context,
          theme,
        );
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
                    content: 'Wrong batch scanned..!!',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
      notifyListeners();
      mycontroller[99].clear();
    }
    return null;
  }

  foritemCodecheck(BuildContext context, ThemeData theme) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AlertBox(
                  payMent: "itemCode",
                  widget: checkItemcode(context, theme),
                  buttonName: null));
        });
    notifyListeners();
  }

  Widget checkItemcode(BuildContext context, ThemeData theme) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.bodyheight(context) * 0.5,
      width: Screens.width(context) * 1,
      child: ListView.builder(
          itemCount: itemcodelistitem.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  clickItemcode(itemcodelistitem[index], context, theme, index);
                  Navigator.pop(context);
                  notifyListeners();
                },
                title: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          itemcodelistitem[index].itemCode.toString(),
                        ),
                        const Text(" - "),
                        SizedBox(
                            width: Screens.width(context) * 0.45,
                            child: Text(
                              itemcodelistitem[index].itemName.toString(),
                            )),
                      ],
                    ),
                    Text(
                      itemcodelistitem[index].serialBatch.toString(),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  addScndData(int indx, BuildContext context, ThemeData theme) async {
    int? ins = await checkSameserialBatchScnd(
        mycontroller[99].text.toString().trim().toUpperCase());
    if (ins != null) {
      if (itemcodeitem != null) {
        int? inssx = await checkSameItemcode();
        if (inssx != null) {
          itemIncrement(inssx, context, theme);
        } else if (inssx == null) {
          itemcodedataaa(context, theme, indx);
          notifyListeners();
        }
      } else {
        itemIncrement(ins, context, theme);
      }
    } else {
      itemcodedataaa(context, theme, indx);
      notifyListeners();
    }
  }

  Future<int?> checkSameserialBatchScnd(String sBatch) async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].serialBatch == sBatch) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> checkSameItemcode() async {
    for (int i = 0; i < scanneditemData.length; i++) {
      if (scanneditemData[i].serialBatch == itemcodeitem!.serialBatch) {
        if (scanneditemData[i].itemCode == itemcodeitem!.itemCode) {
          return Future.value(i);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  int? adddiscperunit;

  qtychangemtd(int ind, BuildContext context, ThemeData theme) {
    qtymycontroller[ind].text = scanneditemData[ind].qty.toString();
    notifyListeners();
  }

  int i = 1;

  int get geti => i;
  itemIncrement(int ind, BuildContext context, ThemeData theme) {
    int qtyctrl = int.parse(qtymycontroller[ind].text);

    for (int i = 0; i < itemcodelistitem.length; i++) {
      if (itemcodelistitem[i].serialBatch == scanneditemData[ind].serialBatch) {
        if (scanneditemData[ind].openQty! >= qtyctrl) {
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
          calCulateDocVal(context, theme);

          break;
        }
      }
    }

    notifyListeners();
  }

  int qqqttyy = 0;

  qqqqq(int ix) {
    qqqttyy = 0;
    for (int ij = 0; ij < soScanItem.length; ij++) {
      if (soScanItem[ij].basedocentry.toString() ==
              openOrdLineList![ix].docEntry.toString() &&
          soScanItem[ij].baselineid.toString() ==
              openOrdLineList![ix].lineNum.toString() &&
          soScanItem[ij].itemCode.toString() ==
              openOrdLineList![ix].itemCode.toString()) {
        qqqttyy = qqqttyy + int.parse(soqtycontroller[ij].text);
        notifyListeners();
      }
    }
    notifyListeners();
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

  mapsoqty(int ij, BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasDataItemcd(
            db,
            soScanItem[ij].serialBatch.toString(),
            soScanItem[ij].itemCode.toString());

    for (int ix = 0; ix < openOrdLineList!.length; ix++) {
      if (soScanItem[ij].basedocentry.toString() ==
              openOrdLineList![ix].docEntry.toString() &&
          soScanItem[ij].baselineid.toString() ==
              openOrdLineList![ix].lineNum.toString() &&
          soScanItem[ij].itemCode.toString() ==
              openOrdLineList![ix].itemCode.toString()) {
        if (itemMasdata[0].serialbatch.toString() ==
            soScanItem[ij].serialBatch.toString()) {
          qqqqq(ix);
          if (int.parse(soqtycontroller[ij].text) > 0) {
            if (openOrdLineList![ix].openQty >= qqqttyy &&
                (int.parse(itemMasdata[0].quantity.toString()) >=
                    int.parse(soqtycontroller[ij].text))) {
              soScanItem[ij].qty = double.parse(soqtycontroller[ij].text);
              notifyListeners();
            } else {
              soqtycontroller[ij].text = 1.toString();
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
            }
          } else if (int.parse(soqtycontroller[ij].text) == 0) {
            soScanItem.removeAt(ij);
            soqtycontroller.removeAt(ij);
          }
        }

        notifyListeners();
      }
    }
  }

  itemIncrement11(int ind, BuildContext context, ThemeData theme) async {
    double removeqty = 0;
    double qtyctrl = 0;
    qtyctrl = double.parse(qtymycontroller[ind].text.toString());

    if (qtyctrl != 0) {
      if (scanneditemData[ind].openQty! >=
          double.parse(qtymycontroller[ind].text.toString())) {
        calCulateDocVal(context, theme);
        FocusScopeNode focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus) {
          focus.unfocus();
        }
        notifyListeners();
      } else {
        qtymycontroller[ind].text = (1.0).toString();
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
        calCulateDocVal(context, theme);

        notifyListeners();
      }
    } else if (double.parse(qtymycontroller[ind].text.toString()) ==
            removeqty ||
        qtymycontroller[ind].text.isEmpty) {
      qtymycontroller.removeAt(ind);
      scanneditemData.removeAt(ind);

      calCulateDocVal(context, theme);

      notifyListeners();
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

  soItemDecrement(
    BuildContext context,
    ThemeData theme,
    int ind,
  ) {
    int soqtyctrl = int.parse(soqtycontroller[ind].text);

    if (soqtyctrl > 0) {
      soqtyctrl = soqtyctrl - 1;
      soqtycontroller[ind].text = soqtyctrl.toString();
      notifyListeners();
    } else if (soqtyctrl == 0) {
      soqtycontroller[ind].text = '';
      notifyListeners();
    }
    notifyListeners();
  }

  TextEditingController custNameController = TextEditingController();
  TextEditingController tinNoController = TextEditingController();
  TextEditingController vatNoController = TextEditingController();

  custSelected(CustomerDetals customerDetals, BuildContext context,
      ThemeData theme) async {
    selectedcust = null;
    selectedcust55 = null;
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    double? updateCustBal = 0;
    loadingscrn = true;
    holddocentry = '';
    custNameController.text = '';
    List<Address> address22 = [];
    List<Address> address55 = [];

    for (int i = 0; i < customerDetals.address!.length; i++) {
      if (customerDetals.address![i].addresstype == "B") {
        address22.add(Address(
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
        address55.add(Address(
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
    selectedcust = CustomerDetals(
        taxCode: customerDetals.taxCode,
        autoId: customerDetals.autoId,
        name: '',
        accBalance: 0,
        phNo: customerDetals.phNo,
        cardCode: customerDetals.cardCode,
        U_CashCust: customerDetals.U_CashCust,
        point: customerDetals.point,
        address: address22,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');

    selectedcust55 = CustomerDetals(
        autoId: customerDetals.autoId,
        name: customerDetals.name,
        phNo: customerDetals.phNo,
        taxCode: customerDetals.taxCode,
        U_CashCust: customerDetals.U_CashCust,
        cardCode: customerDetals.cardCode,
        point: customerDetals.point,
        address: address55,
        email: customerDetals.email ?? '',
        tarNo: customerDetals.tarNo ?? '');

    notifyListeners();
    await AccountBalApi.getData(selectedcust!.cardCode.toString())
        .then((value) {
      loadingscrn = false;
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.accBalanceData != null) {
          updateCustBal =
              double.parse(value.accBalanceData![0].balance.toString());
        } else {
          updateCustBal = 0.00;
        }

        notifyListeners();
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        loadingscrn = false;
        notifyListeners();
      } else {
        loadingscrn = false;
        notifyListeners();
      }
    });

    selectedcust!.accBalance = updateCustBal ?? customerDetals.accBalance!;
    selectedcust55!.accBalance = updateCustBal ?? customerDetals.accBalance!;
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
    callOpenSalesOrder(context, theme);

    notifyListeners();
  }

  billaddresslist() {
    billadrrssItemlist = [];
    for (int i = 0; i < selectedcust!.address!.length; i++) {
      if (selectedcust!.address![i].addresstype == "B") {
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
  }

  shippinfaddresslist() {
    shipadrrssItemlist = [];
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
      }
      notifyListeners();
    }
    notifyListeners();
  }

  careateNewBillAdd() async {
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

  clearData(BuildContext context, ThemeData theme) {
    selectedcust = null;
    selectedcust55 = null;
    selectedcust25 = null;
    openSalesOrd = [];
    openOrdLine = [];
    selectAll = true;
    holddocentry = '';
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
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

  refreshfiltercust() {
    filtercustList = custList;
    notifyListeners();
  }

  callBillAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;
    ondDisablebutton = true;
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

        ondDisablebutton = false;

        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        ondDisablebutton = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        config.showDialogg("Something went wrong try agian..!!", "Failed");
        ondDisablebutton = false;
      }
    });
    notifyListeners();
  }

  callShipAddressPostApi(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    loadingBtn = true;
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
        ondDisablebutton = false;

        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        ondDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  callAddressPostApi(BuildContext context) async {
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
        ondDisablebutton = false;
        config.showDialogSucessB(
            "Address Created Successfully ..!!", "Success");
        Navigator.pop(context);

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        ondDisablebutton = false;
        config
            .showDialogg("${value.errorMsg!.message!.value}..!!", "Failed")
            .then((value) => Navigator.pop(context));
      } else {
        ondDisablebutton = false;

        config.showDialogg("Something went wrong try agian..!!", "Failed");
      }
    });
    notifyListeners();
  }

  insertnewbilladdresscreation(BuildContext context, ThemeData theme) async {
    ondDisablebutton = true;

    if (formkeyAdd.currentState!.validate()) {
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
        ondDisablebutton = false;
        notifyListeners();
      });
      notifyListeners();
    }
    notifyListeners();
  }

  bool selectAll = true;
  selectAllItem() {
    addIndex = [];
    selectIndex = null;
    for (var i = 0; i < openOrdLineList!.length; i++) {
      if (selectAll == true) {
        soListController[i].text = openOrdLineList![i].openQty.toString();
        openOrdLineList![i].checkBClr = true;
        openOrdLineList![i].invoiceClr = 1;
        addIndex.add('${i}');

        notifyListeners();
      } else {
        soListController[i].text = '';
        autoselectbtndisable = false;
        openOrdLineList![i].checkBClr = false;
        openOrdLineList![i].invoiceClr = 0;
        addIndex = [];
        notifyListeners();
      }
    }
    mapItemCodeWiseSoAllData();
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
          selectedBillAdress = selectedcust!.address!.length - 1;
        }
      }
    }

    notifyListeners();
  }

  insertnewshipaddresscreation(BuildContext context, ThemeData theme) async {
    ("objectobjectobject ship");

    if (formkeyShipAdd.currentState!.validate()) {
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
        ondDisablebutton = false;
        notifyListeners();
      });
    }
    notifyListeners();
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
        }
      }
      notifyListeners();
    }
    selectedShipAdress = selectedcust55!.address!.length - 1;
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

  changeBillAddress(int slcAdrs) {
    selectedBillAdress = slcAdrs;
    notifyListeners();
  }

  changeShipAddress(int slcAdrs) {
    selectedShipAdress = slcAdrs;
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

  billToShip(bool dat) {
    //checkboxx = dat;
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
      mycontroller[20].text = '';
    }
    notifyListeners();
  }

  validateformkey(
    int ij,
  ) {
    if (formkeyy[ij].currentState!.validate()) {
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
    textError = '';
    if (formkeyy[ij].currentState!.validate()) {
      sucesss = sucesss + 1;
    }

    if (formkeyAdd.currentState!.validate()) {
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
      await callCustPostApi(context, theme);

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
          name: newcusdataDB[i]['customername'].toString(),
          U_CashCust: '',
          phNo: newcusdataDB[i]['phoneno1'].toString(),
          accBalance: double.parse(newcusdataDB[i]['balance'].toString()),
          point: newcusdataDB[i]['points'].toString(),
          tarNo: newcusdataDB[i]['taxno'].toString(),
          taxCode: newcusdataDB[i]['taxCode'].toString(),
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

  insertAddNewCusToDB(
    BuildContext context,
  ) async {
    newBillAddrsValue = [];
    newCustAddData = [];

    newShipAddrsValue = [];
    newCustValues = [];
    final Database db = (await DBHelper.getInstance())!;
    newCustValues.add(CustomerModelDB(
        customerCode:
            mycontroller[3].text.isNotEmpty ? mycontroller[3].text : '',
        createdUserID: UserValues.userID.toString(),
        createdateTime: config.currentDate(),
        lastupdateIp: UserValues.lastUpdateIp.toString(),
        uCashCust: '',
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
        taxCode: ''));
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
      'createdateTime': config.currentDate(),
      'updatedDatetime': config.currentDate(),
      'createdUserID': UserValues.userID.toString(), //createdUserid
      'updateduserid': UserValues.userID.toString(), //updateduserid
      'lastupdateIp': UserValues.lastUpdateIp.toString(),
      'TaxCode': ''
    });
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
      await DBOperation.insertCustomerAddress(db, newShipAddrsValue)
          .then((value) {});

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
    if (formkeyy[6].currentState!.validate()) {
      updateCustomer(context, i, ij);
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
          cardCode: newcusdataDB[i]['customercode'].toString(),
          taxCode: newcusdataDB[i]['taxCode'].toString(),
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
    vatNoController.text = '';
    tinNoController.text = '';

    openSalesOrd = [];
    openOrdLine = [];
    custNameController.text = '';

    notifyListeners();
  }

  calculateTons(int iss) {
    for (int iss = 0; iss < scanneditemData.length; iss++) {}
  }

  calCulateDocVal(BuildContext context, ThemeData theme) {
    totalPayment = null;

    TotalPayment totalPay = TotalPayment();
    totalPay.total = 0;
    totalPay.discount = 0.00;
    totalPay.subtotal = 0.00;
    totalPay.totalTX = 0.00;
    totalPay.totalDue = 0.00;
    String ansbasic = '';
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      if (cpyfrmso == 'CopyfromSo') {
        scanneditemData[iss].openRetQty = double.parse(
            qtymycontroller[iss].text.isNotEmpty
                ? qtymycontroller[iss].text
                : "0");

        totalPay.total = totalPay.total! +
            double.parse(qtymycontroller[iss].text.toString());
        ansbasic =
            (scanneditemData[iss].sellPrice! * scanneditemData[iss].openRetQty!)
                .toString();
      } else {
        scanneditemData[iss].qty = double.parse(
            qtymycontroller[iss].text.isNotEmpty
                ? qtymycontroller[iss].text
                : "0");

        totalPay.total =
            totalPay.total! + double.parse(scanneditemData[iss].qty.toString());
        ansbasic = (scanneditemData[iss].sellPrice! * scanneditemData[iss].qty!)
            .toString();
      }

      scanneditemData[iss].basic = double.parse(ansbasic);

      double? mycontlaa = scanneditemData[iss].discountper! ?? 0;
      scanneditemData[iss].discount =
          (scanneditemData[iss].basic! * mycontlaa / 100);

      scanneditemData[iss].taxable =
          scanneditemData[iss].basic! - scanneditemData[iss].discount!;

      scanneditemData[iss].priceAfDiscBasic =
          scanneditemData[iss].sellPrice! * 1;
      double priceafd = (scanneditemData[iss].priceAfDiscBasic! *
          scanneditemData[iss].discountper! /
          100);

      double priceaftDisc = scanneditemData[iss].priceAfDiscBasic! - priceafd;
      scanneditemData[iss].priceAftDiscVal = priceaftDisc;

      scanneditemData[iss].taxvalue =
          scanneditemData[iss].taxable! * scanneditemData[iss].taxRate! / 100;

      scanneditemData[iss].netvalue =
          (scanneditemData[iss].basic! - scanneditemData[iss].discount!) +
              scanneditemData[iss].taxvalue!;

      if (scanneditemData[iss].uPackSize! >= 10) {
        scanneditemData[iss].pails =
            scanneditemData[iss].qty != null ? scanneditemData[iss].qty! : 0;
        notifyListeners();
      }
      if (scanneditemData[iss].uTINSPERBOX! > 0) {
        if (scanneditemData[iss].uPackSize! < 10) {
          scanneditemData[iss].cartons = int.parse(
              (scanneditemData[iss].qty! / scanneditemData[iss].uTINSPERBOX!)
                  .round()
                  .toString());
          notifyListeners();
        }
      }
      if (scanneditemData[iss].uTINSPERBOX! > 0) {
        int crts = scanneditemData[iss].cartons ?? 0;
        int utins = (scanneditemData[iss].uTINSPERBOX! * crts);
        scanneditemData[iss].looseTins =
            double.parse((scanneditemData[iss].qty! - utins).toString());
        notifyListeners();
      }
      if (scanneditemData[iss].uSpecificGravity! > 0) {
        if (scanneditemData[iss].uPackSize != 0) {
          notifyListeners();

          scanneditemData[iss].tonnage =
              (scanneditemData[iss].uSpecificGravity! *
                  scanneditemData[iss].uPackSize! *
                  scanneditemData[iss].qty!);
          notifyListeners();
        } else {
          scanneditemData[iss].tonnage =
              (scanneditemData[iss].uPackSize! * scanneditemData[iss].qty!);
          notifyListeners();
        }
        notifyListeners();
      }
      double pailsss = scanneditemData[iss].pails ?? 0;
      int crts = scanneditemData[iss].cartons ?? 0;
      double loosetins = scanneditemData[iss].looseTins != null
          ? scanneditemData[iss].looseTins!
          : 0;

      scanneditemData[iss].totalPack = pailsss + crts + loosetins;
      totalPay.subtotal = totalPay.subtotal! + scanneditemData[iss].basic!;
      totalPay.discount = totalPay.discount! + scanneditemData[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData[iss].taxvalue!;
      totalPay.totalDue = totalPay.totalDue! + scanneditemData[iss].netvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;

      notifyListeners();

      totalPayment = totalPay;

      notifyListeners();
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
    totalPay.balance = 0.00;

    String ansbasic = '';
    for (int iss = 0; iss < scanneditemData2.length; iss++) {
      scanneditemData2[iss].qty = double.parse(
          qtymycontroller2[iss].text.isNotEmpty
              ? qtymycontroller2[iss].text
              : "0");

      totalPay.total =
          totalPay.total! + double.parse(scanneditemData2[iss].qty.toString());
      ansbasic = (scanneditemData2[iss].sellPrice! * scanneditemData2[iss].qty!)
          .toString();

      scanneditemData2[iss].basic = double.parse(ansbasic);

      double? mycontlaa = scanneditemData2[iss].discountper! ?? 0;
      scanneditemData2[iss].discount =
          (scanneditemData2[iss].basic! * mycontlaa / 100);

      scanneditemData2[iss].taxable =
          scanneditemData2[iss].basic! - scanneditemData2[iss].discount!;

      scanneditemData2[iss].priceAfDiscBasic =
          scanneditemData2[iss].sellPrice! * 1;
      double priceafd = (scanneditemData2[iss].priceAfDiscBasic! *
          scanneditemData2[iss].discountper! /
          100);

      double priceaftDisc = scanneditemData2[iss].priceAfDiscBasic! - priceafd;
      scanneditemData2[iss].priceAftDiscVal = priceaftDisc;
      log('priceaftDiscpriceaftDisc::$priceaftDisc');
      scanneditemData2[iss].taxvalue =
          scanneditemData2[iss].taxable! * scanneditemData2[iss].taxRate! / 100;

      scanneditemData2[iss].netvalue =
          (scanneditemData2[iss].basic! - scanneditemData2[iss].discount!) +
              scanneditemData2[iss].taxvalue!;
      if (scanneditemData2[iss].uPackSize != null) {
        if (scanneditemData2[iss].uPackSize! >= 10) {
          scanneditemData2[iss].pails = scanneditemData2[iss].qty!;
          notifyListeners();
        }
      }
      if (scanneditemData2[iss].uTINSPERBOX != null) {
        if (scanneditemData2[iss].uTINSPERBOX! > 0) {
          if (scanneditemData2[iss].uPackSize! < 10) {
            scanneditemData2[iss].cartons = int.parse(
                (scanneditemData2[iss].qty! /
                        scanneditemData2[iss].uTINSPERBOX!)
                    .round()
                    .toString());
            notifyListeners();
          }
        }
      }
      if (scanneditemData2[iss].uTINSPERBOX != null) {
        if (scanneditemData2[iss].uTINSPERBOX! > 0) {
          int crts = scanneditemData2[iss].cartons ?? 0;
          int utins = (scanneditemData2[iss].uTINSPERBOX! * crts);
          scanneditemData2[iss].looseTins =
              double.parse((scanneditemData2[iss].qty! - utins).toString());
          notifyListeners();
        }
      }
      if (scanneditemData2[iss].uSpecificGravity != null) {
        if (scanneditemData2[iss].uSpecificGravity! > 0) {
          if (scanneditemData2[iss].uPackSize != 0) {
            notifyListeners();

            scanneditemData2[iss].tonnage =
                (scanneditemData2[iss].uSpecificGravity! *
                    scanneditemData2[iss].uPackSize! *
                    scanneditemData2[iss].qty!);
            notifyListeners();
          } else {
            scanneditemData2[iss].tonnage =
                (scanneditemData2[iss].uPackSize! * scanneditemData2[iss].qty!);
            notifyListeners();
          }
          notifyListeners();
        }
      }
      double pailsss = scanneditemData2[iss].pails ?? 0;
      int crts = scanneditemData2[iss].cartons ?? 0;
      double loosetins = scanneditemData2[iss].looseTins != null
          ? scanneditemData2[iss].looseTins!
          : 0;

      scanneditemData2[iss].totalPack = pailsss + crts + loosetins;
      totalPay.subtotal = totalPay.subtotal! + scanneditemData2[iss].basic!;
      totalPay.discount = totalPay.discount! + scanneditemData2[iss].discount!;
      totalPay.totalTX = totalPay.totalTX! + scanneditemData2[iss].taxvalue!;
      totalPay.totalDue = totalPay.totalDue! + scanneditemData2[iss].netvalue!;
      totalPay.taxable = totalPay.subtotal! - totalPay.discount!;

      totalPay.balance = totalPay.balance! + scanneditemData2[iss].netvalue!;
      notifyListeners();

      totalPayment2 = totalPay;

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

  double getNoSubTotal() {
    double totalqty = 0;
    double totalPrice = 0; //getSumPrice();
    double sumTotal = 0; //(totalqty * totalPrice);

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].sellPrice.toString());
      totalqty = scanneditemData[iss].qty!;
      sumTotal = (sumTotal + (totalqty * totalPrice));
    }

    return sumTotal;
  }

  double getTotalTax() {
    //bala sir//=(H10-N10)*I10/100=
    double totalqty = 0;
    double totalPrice = 0; //getSumPrice();
    double tax = 0; //getSumTotalTax();
    double totalTax = 0;
    double disamt = getDiscount();
    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].sellPrice.toString());
      totalqty = scanneditemData[iss].qty!;
      tax = double.parse(scanneditemData[iss].taxRate.toString());

      var basic = (totalqty * totalPrice);

      var taxable = basic - disamt;
      scanneditemData[iss].taxType = (taxable * tax / 100).toString();
    }

    return totalTax;
  }

  double getDiscount() {
    double totaldisc = 0;
    double totalqty = 0;
    double totalPrice = 0; //getSumPrice();
    double itemdisc = 0; //getSumTotalTax();

    for (int iss = 0; iss < scanneditemData.length; iss++) {
      totalPrice = double.parse(scanneditemData[iss].sellPrice.toString());
      totalqty = scanneditemData[iss].qty!;
      itemdisc = double.parse(scanneditemData[iss].maxdiscount.toString());

      var basic = totalqty * totalPrice;
      scanneditemData[iss].cost =
          int.parse((basic * itemdisc / 100).toString());
    }
    return totaldisc;
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

  addPayAmount(PaymentWay paymt, BuildContext context) {
    if (paymentWay.isEmpty) {
      if (double.parse(totalPayment!.totalDue!
                  .toStringAsFixed(2)
                  .replaceAll(',', '')) >
              getSumTotalPaid() &&
          double.parse(getBalancePaid().toStringAsFixed(2)) >=
              double.parse(paymt.amt!.toStringAsFixed(2))) {
        addToPaymentWay(paymt, context);
        if (paymt.type == "Account Balance") {
          selectedcust!.accBalance = selectedcust!.accBalance! - paymt.amt!;
          notifyListeners();
        } else if (paymt.type == "Points Redemption") {
          selectedcust!.point =
              (double.parse(selectedcust!.point!.toString()) - paymt.amt!)
                  .toString();
        }
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

  cpyBtnclik(int i) {
    mycontroller[i].text = getBalancePaid().toStringAsFixed(2);
    notifyListeners();
  }

  double? cashpayment = 0;
  double? cqpayment = 0;
  double? transpayment = 0;
  double creditCardAmt = 0;

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

    if (formkeyy[i].currentState!.validate()) {
      if (type == 'Cash') {
        paymt.amt = double.parse(mycontroller[22].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        cashpayment = paymt.amt;
        cashType = paymt.type!;
      } else if (type == 'Cheque') {
        paymt.amt = double.parse(mycontroller[25].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.chequedate = config.alignDate2(mycontroller[24].text);
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
        creditCardAmt = paymt.amt!;
      } else if (type == 'Transfer') {
        paymt.transtype = selectedType.toString();
        paymt.reference = mycontroller[30].text;
        paymt.amt = double.parse(mycontroller[31].text.toString().trim());
        paymt.dateTime = config.currentDate(); //mycontroller[30],
        paymt.type = type;
        transferType = paymt.type!;
        transpayment = paymt.amt;
        transrefff = paymt.reference!;
      } else if (type == 'Wallet') {
        walletType = type;
        paymt.reference = mycontroller[33].text;
        paymt.walletid = mycontroller[32].text;
        paymt.wallettype = wallet;
        paymt.amt = double.parse(mycontroller[34].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
      } else if (type == 'Account Balance') {
        paymt.type = type;
        paymt.amt = double.parse(mycontroller[36].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
        accType = type;
        selectcustaccbal(paymt);
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
        paymt.recoverydate = config.alignDate2(mycontroller[44].text);
        paymt.reference = mycontroller[43].text.toString();
        paymt.amt = double.parse(mycontroller[45].text.toString().trim());
        paymt.dateTime = config.currentDate();
        paymt.type = type;
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
                  contentPadding: const EdgeInsets.all(0),
                  content: ContentWidgetMob(
                      theme: theme,
                      msg:
                          "Already you are used ${paymt.type!} mode of payment..!!"));
            });
      }
    }
    disableKeyBoard(context);
  }

  selectcustaccbal(PaymentWay paymt) {
    if (selectedcust!.accBalance! < 0) {
      selectedcust!.accBalance = selectedcust!.accBalance! + paymt.amt!;
      selectedcust55!.accBalance = selectedcust!.accBalance! + paymt.amt!;
    } else {
      selectedcust!.accBalance = selectedcust!.accBalance! - paymt.amt!;
      selectedcust55!.accBalance = selectedcust!.accBalance! + paymt.amt!;

      notifyListeners();
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
    if (selectedcust != null) {
      if (paymentWay[i].type == "Account Balance") {
        selectedcust!.accBalance =
            selectedcust!.accBalance! - paymentWay[i].amt!;
      } else if (paymentWay[i].type == "Points Redemption") {
        selectedcust!.point =
            (double.parse(selectedcust!.point.toString()) + paymentWay[i].amt!)
                .toString();
      }
    }
    if (paymentWay[i].type == "Cash") {
      cashType = '';
    } else if (paymentWay[i].type == "Transfer") {
      transferType = '';
    } else if (paymentWay[i].type == "Cheque") {
      chequeType = '';
    } else if (paymentWay[i].type == "Wallet") {
      walletType = '';
    } else if (paymentWay[i].type == "Account Balance") {
      accType = '';
    } else if (paymentWay[i].type == "Credit") {
      creditType = '';
    } else if (paymentWay[i].type == "Card") {
      cardType = '';
    } else if (paymentWay[i].type == "Points Redemption") {
      pointType = '';
    }
    paymentWay.removeAt(i);
    getSumTotalPaid();
    getBalancePaid();

    notifyListeners();
  }

  clearTextField() {
    ondDisablebutton = false;
    checkboxx = false;
    custseriesNo = null;
    loadingBtn = false;
    teriteriValue = null;
    paygrpValue = null;
    codeValue = null;
    loadingscrn = false;
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

  changecheckout(BuildContext context, ThemeData theme) async {
    if (schemebtnclk == true) {
      await scehmeapiforckout(context, theme);
    }
    checkOut(context, theme);
  }

  scehmeapiforckout(BuildContext context, ThemeData theme) async {
    await salesOrderSchemeData();
    await callSchemeOrderAPi();
    await calculatescheme(context, theme);
    notifyListeners();
  }

  checkOut(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    ondDisablebutton = true;

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
        ondDisablebutton = false;
        disableKeyBoard(context);
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
        ondDisablebutton = false;
        disableKeyBoard(context);
        notifyListeners();
      });
    } else if (getBalancePaid() < 0) {
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
                      content: 'Your balance amount is less than 0',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
        notifyListeners();
      });
    } else if (selectedTruckType == null) {
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
                      content: 'Please Update the UDF',
                      theme: theme,
                    )),
                    buttonName: null));
          }).then((value) {
        ondDisablebutton = false;
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
          disableKeyBoard(context);
        }).then((value) {
          ondDisablebutton = false;
          notifyListeners();
        });
      } else {
        saveValuesTODB("check out", context, theme);

        if (holddocentry.isNotEmpty) {
          await DBOperation.deleteHold(db, holddocentry).then((value) {
            holddocentry = '';
            onHoldFilter.clear();
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

  salesOrderClicked(BuildContext context, ThemeData theme) {
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
        disableKeyBoard(context);
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
        disableKeyBoard(context);
      });
    } else {
      saveValuesTODB("save as order", context, theme);

      notifyListeners();
    }
  }

  filterListOnHold(String v) {
    if (v.isNotEmpty) {
      onHoldFilter = salesmodl
          .where((e) =>
              e.cardCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.custName!.toLowerCase().contains(v.toLowerCase()) ||
              e.invoceDate!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      onHoldFilter = salesmodl;
      notifyListeners();
    }
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
        disableKeyBoard(context);
        ondDisablebutton = false;
      });
    } else {
      selectedcust2 = null;
      scanneditemData2.clear();
      paymentWay2.clear();
      totalPayment2 = null;
      saveValuesTODB("hold", context, theme);
      if (holddocentry.isNotEmpty) {
        await DBOperation.deleteHold(db, holddocentry).then((value) {
          holddocentry = '';
          onHoldFilter.clear();
          getdraftindex();
        });
      }
      notifyListeners();
    }
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

  adjamt(BuildContext context, ThemeData theme) async {
    double availbal = selectedcust!.accBalance!;
    double adjamtt = double.parse(mycontroller[36].text);
    if (availbal < 0) {
      availbal = availbal + adjamtt;
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

  double cashAmt = 00.00;
  double get getcashAmt => cashAmt;
  bool boolCash = false;
  bool get getboolCash => boolCash;
  String? paymentterm;
  String? coupon;
  String? wallet;
  String? selectedType;
  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  double? tottpaid;
  String? baltopay;
  List<String> transType = [
    'NEFT',
    'RTGS',
    'IMPS',
  ];
  List<String> get gettransType => transType;

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

  getdraft(int ji) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesHeadHoldvalueDB(
      db,
    );

    remarkcontroller3.text = "";
    List<StocksnapModelData> scannData = [];
    List<PaymentWay> payment = [];
    salesmodl.clear();
    onHoldFilter = [];
    List<Map<String, Object?>>? getDBholdSalesLine =
        await DBOperation.holdSalesLineDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));

    List<Map<String, Object?>> getDBholdSalespay =
        await DBOperation.getHoldSalesPayDB(
            db, int.parse(getDBholddata1[ji]['docentry'].toString()));

    for (int kk = 0; kk < getDBholdSalespay.length; kk++) {
      if (getDBholddata1[ji]['docentry'] == getDBholdSalespay[kk]['docentry']) {
        payment.add(PaymentWay(
          amt: double.parse(getDBholdSalespay[kk]['rcamount'].toString()),
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
          couponcode: "",
          coupontype: "",
          discountcode: getDBholdSalespay[kk]['discountcode'].toString(),
          discounttype: getDBholdSalespay[kk]['discounttype'].toString(),
          recoverydate: getDBholdSalespay[kk]['recoverydate'].toString(),
          redeempoint: getDBholdSalespay[kk]['redeempoint'].toString(),
          availablept: getDBholdSalespay[kk]['availablept'].toString(),
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
        scannData.add(StocksnapModelData(
            basic: getDBholdSalesLine[ik]['basic'] != null
                ? double.parse(getDBholdSalesLine[ik]['basic'].toString())
                : 00,
            shipDate: getDBholdSalesLine[ik]['ShipDate'].toString(),
            netvalue: getDBholdSalesLine[ik]['netlinetotal'] != null
                ? double.parse(
                    getDBholdSalesLine[ik]['netlinetotal'].toString())
                : null,
            transID: int.parse(getDBholdSalesLine[ik]['docentry'].toString()),
            branch: getDBholdSalesLine[ik]['branch'].toString(),
            itemCode: getDBholdSalesLine[ik]['itemcode'].toString(),
            itemName: getDBholdSalesLine[ik]['itemname'].toString(),
            serialBatch: getDBholdSalesLine[ik]['serialbatch'].toString(),
            openQty:
                double.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            qty: double.parse(getDBholdSalesLine[ik]['quantity'].toString()),
            inDate: getDBholdSalesLine[ik][''].toString(),
            inType: getDBholdSalesLine[ik][''].toString(),
            mrp: 0,
            sellPrice: double.parse(getDBholdSalesLine[ik]['price'].toString()),
            cost: 0,
            discount: getDBholdSalesLine[ik]['discperunit'] != null
                ? double.parse(getDBholdSalesLine[ik]['discperunit'].toString())
                : 00,
            taxvalue: getDBholdSalesLine[ik]['taxtotal'] != null
                ? double.parse(getDBholdSalesLine[ik]['taxtotal'].toString())
                : 00,
            taxRate: double.parse(getDBholdSalesLine[ik]['taxrate'].toString()),
            taxType: getDBholdSalesLine[ik]['taxtype'].toString(),
            maxdiscount: getDBholdSalesLine[ik]['maxdiscount'].toString(),
            discountper: getDBholdSalesLine[ik]['discperc'] == null
                ? 0.0
                : double.parse(getDBholdSalesLine[ik]['discperc'].toString()),
            basedocentry: getDBholdSalesLine[ik]['basedocentry'] != null
                ? getDBholdSalesLine[ik]['basedocentry'].toString()
                : "",
            baselineid: getDBholdSalesLine[ik]['baselineID'] != null
                ? getDBholdSalesLine[ik]['baselineID'].toString()
                : "",
            createdUserID: '',
            createdateTime: '',
            lastupdateIp: '',
            purchasedate: '',
            snapdatetime: '',
            specialprice: 0,
            updatedDatetime: '',
            updateduserid: '',
            liter: getDBholdSalesLine[ik]['liter'] != null
                ? double.parse(getDBholdSalesLine[ik]['liter'].toString())
                : 00,
            weight: getDBholdSalesLine[ik]['weight'] != null
                ? double.parse(getDBholdSalesLine[ik]['weight'].toString())
                : 00)); //discperc
        totquantity = getDBholdSalesLine[ik]['quantity'].toString();
        discountamt = getDBholdSalesLine[ik]['discperc'] != null
            ? double.parse(getDBholdSalesLine[ik]['discperc'].toString())
            : 0;
      }
      notifyListeners();
    }

    SalesModel salesM = SalesModel(
        objname: getDBholddata1[ji]['objname'].toString(),
        objtype: getDBholddata1[ji]['objtype'].toString(),
        taxCode: getDBholddata1[ji]['taxCode'].toString(),
        doctype: getDBholddata1[ji]['doctype'].toString(),
        docentry: int.parse(getDBholddata1[ji]['docentry'].toString()),
        custName: getDBholddata1[ji]['customername'].toString(),
        phNo: getDBholddata1[ji]['customerphono'].toString(),
        cardCode: getDBholddata1[ji]['customercode'].toString(),
        accBalance: getDBholddata1[ji]['customeraccbal'].toString(),
        point: getDBholddata1[ji]['customerpoint'].toString(),
        tarNo: getDBholddata1[ji]['taxno'].toString(),
        email: getDBholddata1[ji]['customeremail'].toString(),
        invoceDate: getDBholddata1[ji]['createdateTime'].toString(),
        invoiceNum: getDBholddata1[ji]['documentno'].toString(),
        address: [
          Address(
              address1: getDBholddata1[ji]['billaddressid'].toString(),
              billCity: getDBholddata1[ji]['city'].toString(),
              billCountry: getDBholddata1[ji]['country'].toString(),
              billPincode: getDBholddata1[ji]['pinno'].toString(),
              billstate: getDBholddata1[ji]['state'].toString())
        ],
        totalPayment: TotalPayment(
          balance: getDBholddata1[ji]['baltopay'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['baltopay'].toString()),

          discount2: getDBholddata1[ji]['docdiscamt'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
          discount: getDBholddata1[ji]['docdiscamt'] == null
              ? 0.00
              : double.parse(getDBholddata1[ji]['docdiscamt'].toString()),
          totalTX: double.parse(getDBholddata1[ji]['taxamount'] == null
              ? '0'
              : getDBholddata1[ji]['taxamount'].toString().replaceAll(',', '')),

          subtotal: double.parse(getDBholddata1[ji]['docbasic'] == null
              ? '0'
              : getDBholddata1[ji]['docbasic']
                  .toString()
                  .replaceAll(',', '')), //doctotal

          total: totalPayment == null
              ? 0
              : double.parse(totalPayment!.total!.toString()),
          totalDue: double.parse(getDBholddata1[ji]['doctotal'] == null
              ? '0'
              : getDBholddata1[ji]['doctotal'].toString().replaceAll(',', '')),
          totpaid: double.parse(getDBholddata1[ji]['amtpaid'] == null
              ? '0'
              : getDBholddata1[ji]['amtpaid'].toString().replaceAll(',', '')),
        ),
        item: scannData,
        paymentway: payment);

    notifyListeners();

    salesmodl.add(salesM);

    notifyListeners();

    onHoldFilter = salesmodl;
    notifyListeners();
  }

  viewSalesheader() async {
    final Database db = (await DBHelper.getInstance())!;
    DBOperation.getSalesHeadHoldvalueDB(db);
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
      }
      notifyListeners();
    }
    notifyListeners();
  }

  mapHoldValues(BuildContext context, ThemeData theme, int ih) async {
    scanneditemData = [];
    final Database db = (await DBHelper.getInstance())!;
    loadingscrn = true;
    paymentWay = [];
    cpyfrmso = '';
    cancelbtn = false;
    remarkcontroller3.text = "";
    List<Map<String, Object?>> getDBholddata1 =
        await DBOperation.getSalesHeadHoldvalueddDB(
            db, salesmodl[ih].docentry.toString());
    List<Map<String, Object?>> getcustaddd =
        await DBOperation.addgetCstmMasAddDB(
            db, salesmodl[ih].cardCode.toString());
    List<Map<String, Object?>> custData =
        await DBOperation.getCstmMasDatabyautoid(
            db, salesmodl[ih].cardCode.toString());
    selectedcust = CustomerDetals(
      name: '',
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
    selectedcust55 = CustomerDetals(
      name: custData[0]['customername'].toString(),
      U_CashCust: custData[0]['U_CASHCUST'].toString(),
      taxCode: custData[0]['taxCode'].toString(),
      phNo: custData[0]['phoneno1'].toString(),
      cardCode: custData[0]['customerCode'].toString(),
      accBalance: double.parse(custData[0]['balance'].toString()),
      point: custData[0]['points'].toString(),
      address: [],
      email: custData[0]['emalid'].toString(),
      tarNo: custData[0]['taxno'].toString(),
    );

    await CustCreditDaysAPI.getGlobalData(
            custData[0]['customerCode'].toString().toString())
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
            selectedcust!.name = custData[0]['customername'].toString();
          }
          notifyListeners();
        }
        loadingscrn = false;
      }
    });

    for (int ik = 0; ik < getDBholddata1.length; ik++) {
      custNameController.text = getDBholddata1[ik]['customername'].toString();
      tinNoController.text = getDBholddata1[ik]['TinNo'].toString();
      vatNoController.text = getDBholddata1[ik]['VatNo'].toString();

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
          }
        }
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

    for (int i = 0; i < salesmodl[ih].item!.length; i++) {
      scanneditemData.add(StocksnapModelData(
          uPackSize: salesmodl[ih].item![i].uPackSize ?? 0,
          shipDate: '',
          uTINSPERBOX: salesmodl[ih].item![i].uTINSPERBOX ?? 0,
          uSpecificGravity: salesmodl[ih].item![i].uSpecificGravity ?? 0,
          maxdiscount: salesmodl[ih].item![i].maxdiscount,
          discountper: salesmodl[ih].item![i].discountper,
          branch: salesmodl[ih].item![i].branch,
          itemCode: salesmodl[ih].item![i].itemCode,
          itemName: salesmodl[ih].item![i].itemName,
          serialBatch: salesmodl[ih].item![i].serialBatch,
          qty: salesmodl[ih].item![i].qty,
          openQty: salesmodl[ih].item![i].openQty,
          mrp: salesmodl[ih].item![i].mrp,
          sellPrice: salesmodl[ih].item![i].sellPrice,
          taxRate: salesmodl[ih].item![i].taxRate,
          weight: salesmodl[ih].item![i].weight,
          liter: salesmodl[ih].item![i].liter));
      notifyListeners();
    }

    for (int ij = 0; ij < salesmodl[ih].paymentway!.length; ij++) {
      paymentWay.add(PaymentWay(
          amt: salesmodl[ih].paymentway![ij].amt!,
          dateTime: salesmodl[ih].paymentway![ij].dateTime,
          reference: salesmodl[ih].paymentway![ij].reference ?? '',
          type: salesmodl[ih].paymentway![ij].type,
          cardApprno: salesmodl[ih].paymentway![ij].cardApprno,
          cardref: salesmodl[ih].paymentway![ij].cardref,
          cardterminal: salesmodl[ih].paymentway![ij].cardterminal,
          chequedate: salesmodl[ih].paymentway![ij].chequedate,
          chequeno: salesmodl[ih].paymentway![ij].chequeno,
          discountcode: salesmodl[ih].paymentway![ij].discountcode,
          discounttype: salesmodl[ih].paymentway![ij].discounttype,
          recoverydate: salesmodl[ih].paymentway![ij].recoverydate,
          redeempoint: salesmodl[ih].paymentway![ij].redeempoint,
          availablept: salesmodl[ih].paymentway![ij].availablept,
          remarks: salesmodl[ih].paymentway![ij].remarks,
          transtype: salesmodl[ih].paymentway![ij].transtype,
          walletid: salesmodl[ih].paymentway![ij].walletid,
          wallettype: salesmodl[ih].paymentway![ij].wallettype));
      notifyListeners();
    }

    for (int ib = 0; ib < scanneditemData.length; ib++) {
      scanneditemData[ib].transID = ib;
      qtymycontroller[ib].text = scanneditemData[ib].qty!.toString();
      discountcontroller[ib].text = scanneditemData[ib].discountper!.toString();

      notifyListeners();
    }

    if (selectedcust != null) {
      log('custData customercode::${custData[0]['customerCode'].toString()}');
      await AccountBalApi.getData(custData[0]['customerCode'].toString())
          .then((value) {
        loadingscrn = false;
        if (value.statuscode >= 200 && value.statuscode <= 210) {
          if (value.accBalanceData != null) {
            selectedcust!.accBalance =
                double.parse(value.accBalanceData![0].balance.toString());
            notifyListeners();
          }
        }
      });
      holddocentry = salesmodl[ih].docentry.toString();
      notifyListeners();

      notifyListeners();
      calCulateDocVal(context, theme);
    }
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
          log(' discountcontroller[i].text ::${scanneditemData[i].discountper}');

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
      discountcontroller[i].text = 0.0.toString();
      scanneditemData[i].discountper = 0.0;

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

  openSalesOrdItemDeSelect(int i) {
    if (openSalesOrd[i].invoiceClr == 0 && openSalesOrd[i].checkBClr == false) {
      openSalesOrd[i].invoiceClr = 1;
      openSalesOrd[i].checkBClr = true;

      notifyListeners();
    } else if (openSalesOrd[i].invoiceClr == 1 &&
        openSalesOrd[i].checkBClr == true) {
      openSalesOrd[i].invoiceClr = 0;
      openSalesOrd[i].checkBClr = false;

      notifyListeners();
    }

    notifyListeners();
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

  salesorderheader() {
    for (int i = 0; i < soSalesmodl.length; i++) {
      soSalesmodl[i].invoiceClr = 0;
      soSalesmodl[i].checkBClr = false;
      notifyListeners();
    }
  }

  selctIndex(int i) {
    for (int ix = 0; ix < soData.length; ix++) {
      soData[ix].checkBClr = false;
    }
    selectIndex = i;
    if (selectIndex == null) {
    } else if (selectIndex == i) {
      tickListBox(i);
      notifyListeners();
    }
    notifyListeners();
  }

  newadditemlistcount() {
    addIndex = [];
    for (var ik = 0; ik < openOrdLineList!.length; ik++) {
      if (openOrdLineList![ik].checkBClr == true) {
        addIndex.add(ik.toString());
        notifyListeners();
      }
    }
    if (addIndex.isNotEmpty) {
      for (var ik = 0; ik < addIndex.length; ik++) {}
      notifyListeners();
    }
  }

  selectSameItemCode(String itemCode) {
    for (var i = 0; i < openOrdLineList!.length; i++) {
      if (openOrdLineList![i].itemCode == itemCode) {
        if (openOrdLineList![i].checkBClr == true &&
            openOrdLineList![i].invoiceClr == 1) {
          openOrdLineList![i].checkBClr = false;
          openOrdLineList![i].invoiceClr = 0;

          soListController[i].text = '';
          log('message22222');
          notifyListeners();
        } else if (openOrdLineList![i].checkBClr == false &&
            openOrdLineList![i].invoiceClr == 0) {
          openOrdLineList![i].checkBClr = true;
          openOrdLineList![i].invoiceClr = 1;
          soListController[i].text = openOrdLineList![i].openQty.toString();

          notifyListeners();
          log('message111');
        }
      }
    }

    mapItemCodeWiseSoAllData();
    notifyListeners();
  }

  openSoSelctIndex(int i) {
    for (int ix = 0; ix < openOrdLineList!.length; ix++) {
      openOrdLineList![ix].checkBClr = false;
      openOrdLineList![ix].invoiceClr = 0;
    }
    selectIndex = i;
    if (selectIndex == null) {
    } else if (selectIndex == i) {
      tickListBox(i);
      notifyListeners();
    }
    mapItemCodeWiseSoItemData(i);
    notifyListeners();
  }

  bool checktick = false;

  Future<bool> getmockdata(int i) {
    notifyListeners();
    return Future.value(true);
  }

  Future<bool> getstatus(int i) async {
    bool stringfuture = await getmockdata(i);
    bool message = stringfuture;
    notifyListeners();
    return (message);
  }

  tickListBox(int i) async {
    openOrdLineList![i].checkBClr = await getstatus(i);
    openOrdLineList![i].invoiceClr = 1;

    log(' soData[i].checkBClr soData[i].checkBClr:::${openOrdLineList![i].checkBClr}');
    notifyListeners();
  }

  soItemDeSelect(int i) {
    textError = '';

    if (soData[i].invoiceClr == 0 && soData[i].checkBClr == false) {
      soData[i].invoiceClr = 1;
      soData[i].checkBClr = true;
      notifyListeners();
    } else if (soData[i].invoiceClr == 1 && soData[i].checkBClr == true) {
      soData[i].invoiceClr = 0;
      soData[i].checkBClr = false;

      notifyListeners();
    }

    notifyListeners();
  }

  clickcancelbtn(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    if (sapDocentry!.isNotEmpty) {
      List<Map<String, Object?>> getsalheadertosalr =
          await DBOperation.salesInvtoRetCancellQuery(db, cancelDocnum);
      List<Map<String, Object?>> getsalheadertoRec =
          await DBOperation.salesInvtoReceiptcancel(db, cancelDocnum);

      if (getsalheadertosalr.isNotEmpty) {
        if (getsalheadertosalr[0]['basedocnum'].toString() == cancelDocnum) {
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
                            'This document is already converted into sales return',
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
      } else if (getsalheadertoRec.isNotEmpty) {
        if (getsalheadertoRec[0]['transdocnum'].toString() == cancelDocnum) {
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
                            'This document is already converted into Payment Receipt',
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
        await sapLoginApi(context);
        await callSerlaySalesQuoAPI(context, theme);
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

  callSerlaySalesQuoAPI(BuildContext context, ThemeData theme) async {
    cancelbtn = false;

    await SerlaySalesInvoiceAPI.getData(sapDocentry.toString()).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.documentLines.isNotEmpty) {
          sapInvocieModelData = value.documentLines;

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
      }
    });
  }

  callSerlaySalesCancelQuoAPI(BuildContext context, ThemeData theme) async {
    custserieserrormsg = '';
    final Database db = (await DBHelper.getInstance())!;
    if (sapInvocieModelData.isNotEmpty) {
      if (sapInvocieModelData[0].lineStatus == "bost_Open") {
        await SerlayInvoiceCancelAPI.getData(sapDocentry.toString())
            .then((value) async {
          if (value.statusCode! >= 200 && value.statusCode! <= 210) {
            cancelbtn = false;

            await DBOperation.updateSaleInvoiceclosedocsts(
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
              paymentWay2.clear();
              selectedcust25 = null;
              notifyListeners();
            });
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
                          content: value.exception!.message!.value.toString(),
                          theme: theme,
                        )),
                        buttonName: null,
                      ));
                }).then((value) {
              sapDocentry = '';
              sapDocuNumber = '';
              selectedcust2 = null;
              scanneditemData2.clear();
              selectedcust25 = null;
              paymentWay2.clear();

              notifyListeners();
            });
            notifyListeners();
          } else {}
        });
      } else if (sapInvocieModelData[0].lineStatus == "bost_Close") {
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
          sapDocentry = '';
          sapDocuNumber = '';
          selectedcust2 = null;
          scanneditemData2.clear();
          selectedcust25 = null;
          paymentWay2.clear();
          notifyListeners();
        });
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future callgetSOValue() async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getheaderData =
        await DBOperation.getSalesOrdervalueDB(db);
    soScanItem = [];
    soSalesmodl = [];
    List<StocksnapModelData> scannData = [];

    if (selectedcust != null) {
      soSalesmodl = [];
      for (int ik = 0; ik < getheaderData.length; ik++) {
        if (selectedcust!.cardCode.toString() ==
            getheaderData[ik]['customercode'].toString()) {
          if (getheaderData[ik]['sapDocentry'] != null) {
            List<Map<String, Object?>> lineData =
                await DBOperation.getSalesOrderLinevalueDB(
                    db, getheaderData[ik]['docentry'].toString());
            for (int i = 0; i < lineData.length; i++) {
              if (getheaderData[ik]['docentry'].toString() ==
                  lineData[i]['docentry'].toString()) {
                scannData.add(StocksnapModelData(
                    basedocentry: lineData[i]['docentry'].toString(),
                    shipDate: lineData[i]['ShipDate'].toString(),
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
                    taxType: lineData[i]['taxtype'].toString(),
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
              }
            }

            SalesModel salesM = SalesModel(
              objname: getheaderData[ik]['objname'].toString(),
              objtype: getheaderData[ik]['objtype'].toString(),
              doctype: getheaderData[ik]['doctype'].toString(),
              taxCode: getheaderData[ik]['taxCode'].toString(),
              docentry: int.parse(getheaderData[ik]['docentry'].toString()),
              custName: getheaderData[ik]['customername'].toString(),
              phNo: getheaderData[ik]['customerphono'].toString(),
              cardCode: getheaderData[ik]['customercode'].toString(),
              accBalance: getheaderData[ik]['customeraccbal'].toString(),
              point: getheaderData[ik]['customerpoint'].toString(),
              tarNo: getheaderData[ik]['taxno'].toString(),
              email: getheaderData[ik]['customeremail'].toString(),
              checkBClr: false,
              invoiceClr: 0,
              invoceAmount:
                  double.parse(getheaderData[ik]['doctotal'].toString()),
              invoceDate: config
                  .alignDate(getheaderData[ik]['createdateTime'].toString()),
              invoiceNum: getheaderData[ik]['documentno'].toString(),
              sapOrderNum: getheaderData[ik]['sapDocNo'].toString(),
              address: [
                Address(
                    address1: getheaderData[ik]['billaddressid'].toString(),
                    billCity: getheaderData[ik]['city'].toString(),
                    billCountry: getheaderData[ik]['country'].toString(),
                    billPincode: getheaderData[ik]['pinno'].toString(),
                    billstate: getheaderData[ik]['state'].toString())
              ],
              totalPayment: TotalPayment(
                balance: getheaderData[ik]['baltopay'] == null
                    ? 0.00
                    : double.parse(getheaderData[ik]['baltopay'].toString()),

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

            soSalesmodl.add(salesM);
            soTotal = double.parse(getheaderData[ik]['baltopay'].toString());
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }

    notifyListeners();
  }

  Widget checksoItemcode(
      BuildContext context, ThemeData theme, int ins, String sbatch) {
    final theme = Theme.of(context);
    return SizedBox(
      height: Screens.bodyheight(context) * 0.5,
      width: Screens.width(context) * 1,
      child: ListView.builder(
          itemCount: soitemcodelistitem.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.pop(context);
                  clicksoItemcode(
                      soitemcodelistitem[index], context, theme, ins, sbatch);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      soitemcodelistitem[index].itemCode.toString(),
                    ),
                    const Text(" - "),
                    SizedBox(
                        width: Screens.width(context) * 0.45,
                        child: Text(
                          soitemcodelistitem[index].itemName.toString(),
                        )),
                  ],
                ),
              ),
            );
          }),
    );
  }

  List<ItemCodeListModel> sssoitemcodelistitem55 = [];
  clicksoItemcode(ItemCodeListModel aaa, BuildContext context, ThemeData theme,
      int ins, String sbatch) {
    ItemCodeListModel? ssoitemcodeitem;

    ssoitemcodeitem = null;
    soitemcodelistitem = [];
    ssoitemcodeitem = ItemCodeListModel(
      branch: aaa.branch,
      itemCode: aaa.itemCode,
      itemName: aaa.itemName,
      serialBatch: aaa.serialBatch,
      qty: aaa.qty,
      mrp: double.parse(aaa.mrp.toString()),
      createdUserID: aaa.createdUserID.toString(),
      createdateTime: aaa.createdateTime,
      lastupdateIp: aaa.lastupdateIp,
      purchasedate: aaa.purchasedate,
      snapdatetime: aaa.snapdatetime,
      specialprice: double.parse(aaa.specialprice.toString()),
      updatedDatetime: aaa.updatedDatetime,
      updateduserid: aaa.updateduserid.toString(),
      sellPrice: double.parse(aaa.sellPrice.toString()),
      maxdiscount: aaa.maxdiscount != null ? aaa.maxdiscount.toString() : '',
      taxRate: aaa.taxRate != null ? double.parse(aaa.taxRate.toString()) : 00,
      discountper: 0,
      openQty: 0,
      inDate: '',
      cost: 0,
      inType: '',
      uPackSize: aaa.uPackSize,
      uTINSPERBOX: aaa.uTINSPERBOX,
      uSpecificGravity: aaa.uSpecificGravity,
    );
    sssoitemcodelistitem55.add(ssoitemcodeitem);

    for (int ik = 0; ik < sssoitemcodelistitem55.length; ik++) {
      if (sssoitemcodelistitem55[ik].itemCode.toString() ==
              soData[ins].itemCode.toString() &&
          sbatch == sssoitemcodelistitem55[ik].serialBatch.toString()) {
        cccddd(context, theme, ik, ins);
        notifyListeners();
      }
    }
    notifyListeners();
  }

  forsoitemCodecheck(
      BuildContext context, ThemeData theme, int ins, String sbatch) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: AlertBox(
                  payMent: "itemCode",
                  //
                  widget: checksoItemcode(context, theme, ins, sbatch),
                  buttonName: null));
        });
    notifyListeners();
  }

  cccddd(BuildContext context, ThemeData theme, int ik, int soins) async {
    log('soScanItemsoScanItem::${soScanItem.length}');

    if (soScanItem.isEmpty) {
      soqtycontroller[0].text = 1.toString();
      await soitemcodedataaa(context, theme, ik, soins);
      mycontroller[79].clear();
      notifyListeners();
    } else {
      //log('step2');
      await soaddScndData(
        ik,
        soins,
        context,
        theme,
      );
      mycontroller[79].clear();
    }
  }

  soaddScndData(
    int indx,
    int soins,
    BuildContext context,
    ThemeData theme,
  ) async {
    log("KKKK soitemcodelistitem:${soitemcodelistitem.length}");

    if (soitemcodelistitem.isNotEmpty) {
      int? inssx = await socheckSameItemcode(
        context,
        theme,
        soitemcodelistitem[indx].itemCode.toString(),
        indx,
      );

      if (inssx != null) {
        await soitemIncrement(
          inssx,
          soins,
          context,
          theme,
        );
      } else if (inssx == null) {
        await soitemcodedataaa(context, theme, indx, soins);
        notifyListeners();
      }
    } else {
      log("QQQQQQQQQQQQQQQQQQ");
    }
  }

  Future<int?> socheckSameItemcode(
    BuildContext context,
    ThemeData theme,
    String itemcode,
    ind,
  ) async {
    for (int i = 0; i < soScanItem.length; i++) {
      if (soScanItem[i].basedocentry.toString() ==
              soitemcodelistitem[ind].docEntry.toString() &&
          soScanItem[i].baselineid.toString() ==
              soitemcodelistitem[ind].baselineid.toString() &&
          soScanItem[i].itemCode.toString() == itemcode.toString()) {
        if (mycontroller[79].text.toString().toUpperCase().trim() ==
            soScanItem[i].serialBatch.toString()) {
          return Future.value(ind);
        }
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  soitemIncrement(
    int soScaniss,
    int sodatind,
    BuildContext context,
    ThemeData theme,
  ) async {
    for (int ik = 0; ik < soScanItem.length; ik++) {
      log("openOrdLineList![sodatind].openQty:::${openOrdLineList![sodatind].openQty}");
      if (soScanItem[ik].basedocentry.toString() ==
              openOrdLineList![sodatind].docEntry.toString() &&
          soitemcodelistitem[soScaniss].baselineid.toString() ==
              soScanItem[ik].baselineid.toString() &&
          soScanItem[ik].baselineid.toString() ==
              openOrdLineList![sodatind].lineNum.toString()) {
        int soqtyctrl = int.parse(soqtycontroller[ik].text);

        if (soitemcodelistitem[soScaniss].serialBatch.toString() ==
            soScanItem[ik].serialBatch.toString()) {
          if (soitemcodelistitem[soScaniss].itemCode ==
                  openOrdLineList![sodatind].itemCode &&
              openOrdLineList![sodatind].openQty > soqtyctrl) {
            soqtyctrl = soqtyctrl + 1;
            soqtycontroller[ik].text = soqtyctrl.toString();
            log('soqtycontroller[ik].text1111::${soqtycontroller[ik].text}');

            log(" soScanItem[ik].qty::${soScanItem[ik].qty}");
            FocusScopeNode focus = FocusScope.of(context);

            if (!focus.hasPrimaryFocus) {
              focus.unfocus();
            }
            focusnode[0].requestFocus();
            notifyListeners();
          } else {
            log('xxxxxxxxxxxx');
            soqtycontroller[ik].text = 1.toString();
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
          }
          break;
        }
      }
    }

    notifyListeners();
  }

  soitemcodedataaa(
    BuildContext context,
    ThemeData theme,
    int i,
    int soind,
  ) {
    log("soitemcodelistitemxxx length::$i");

    soScanItem.add(StocksnapModelData(
      basedocentry: soitemcodelistitem[i].docEntry,
      baselineid: soitemcodelistitem[i].baselineid.toString(),
      branch: soitemcodelistitem[i].branch,
      itemCode: soitemcodelistitem[i].itemCode,
      itemName: soitemcodelistitem[i].itemName,
      serialBatch: soitemcodelistitem[i].serialBatch,
      qty: 1,
      mrp: double.parse(soitemcodelistitem[i].mrp.toString()),
      createdUserID: soitemcodelistitem[i].createdUserID.toString(),
      createdateTime: soitemcodelistitem[i].createdateTime,
      lastupdateIp: soitemcodelistitem[i].lastupdateIp,
      purchasedate: soitemcodelistitem[i].purchasedate,
      snapdatetime: soitemcodelistitem[i].snapdatetime,
      specialprice: double.parse(soitemcodelistitem[i].specialprice.toString()),
      updatedDatetime: soitemcodelistitem[i].updatedDatetime,
      updateduserid: soitemcodelistitem[i].updateduserid.toString(),
      sellPrice: double.parse(soitemcodelistitem[i].sellPrice.toString()),
      maxdiscount: soitemcodelistitem[i].maxdiscount != null
          ? soitemcodelistitem[i].maxdiscount.toString()
          : '',
      taxRate: soitemcodelistitem[i].taxRate != null
          ? double.parse(soitemcodelistitem[i].taxRate.toString())
          : 0.0,
      discountper: 0,
      openQty: openOrdLineList![soind].openQty,
      inDate: '',
      cost: 0,
      inType: '',
      liter: soitemcodelistitem[i].liter != null
          ? double.parse(soitemcodelistitem[i].liter.toString())
          : 0.0,
      weight: soitemcodelistitem[i].weight != null
          ? double.parse(soitemcodelistitem[i].weight.toString())
          : 0.0,
    ));
    notifyListeners();

    if (soScanItem.length > 1) {
      soqtycontroller[soScanItem.length - 1].text =
          soScanItem[soScanItem.length - 1].qty.toString();
    }

    FocusScopeNode focus = FocusScope.of(context);

    if (!focus.hasPrimaryFocus) {
      focus.unfocus();
    }
    notifyListeners();

    focusnode[0].requestFocus();
    log("soScanItemsoScanItemsoScanItem::${soScanItem.length.toString()}");
  }

  Future<int?> selectsalesorderlist() {
    for (int ins = 0; ins < openOrdLineList!.length; ins++) {
      if (selectIndex == ins) {
        log("insss55:::$ins");
        return Future.value(ins);
      }
      notifyListeners();
    }
    notifyListeners();

    return Future.value(null);
  }

  soInvoiceScan(String sBatch, BuildContext context, ThemeData theme) async {
    int? indx = await selectsalesorderlist();

    if (indx != null) {
      int? sindx = await soScanBatch(sBatch, context, theme, indx);

      if (sindx != null) {
        cccddd(context, theme, sindx, indx);
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
                      content: 'Wrong Batch Scanned',
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
                    content: 'Select Item List',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
    }
  }

  newSoScanBatch(
      String sBatch, BuildContext context, ThemeData theme, int ins) async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasDataItemcd(
            db, sBatch.toString(), openOrdLineList![ins].itemCode.toString());

    int soqtyyy = soqtycontroller[ins].text.isNotEmpty
        ? int.parse(soqtycontroller[ins].text)
        : 0;
    soqtycontroller[ins].text = soqtyyy.toString();
    for (int ia = 0; ia < itemMasdata.length; ia++) {
      if (openOrdLineList![ins].itemCode.toString() ==
              itemMasdata[ia].itemcode.toString() &&
          openOrdLineList![ins].openQty >
              double.parse(soqtycontroller[ins].text)) {
        for (int ih = 0; ih < openSalesOrd.length; ih++) {
          if (openSalesOrd[ih].docEntry.toString() ==
              openOrdLineList![ins].docEntry.toString()) {
            textError = '';
            soitemcodelistitem.add(ItemCodeListModel(
              uPackSize: double.parse(itemMasdata[ia].uPackSize.toString()),
              uTINSPERBOX: int.parse(itemMasdata[ia].uTINSPERBOX.toString()),
              uSpecificGravity:
                  double.parse(itemMasdata[ia].uSpecificGravity.toString()),
              docEntry: openOrdLineList![ins].docEntry.toString(),
              baselineid: int.parse(openOrdLineList![ins].lineNum.toString()),
              itemCode: itemMasdata[ia].itemcode.toString(),
              itemName: itemMasdata[ia].itemname.toString(),
              serialBatch: itemMasdata[ia].serialbatch.toString(),
              qty: double.parse(itemMasdata[ia].quantity.toString()),
              mrp: itemMasdata[ia].mrpprice != null
                  ? double.parse(itemMasdata[ia].mrpprice.toString())
                  : null,
              createdUserID: itemMasdata[ia].createdUserID.toString(),
              createdateTime: itemMasdata[ia].createdateTime.toString(),
              lastupdateIp: itemMasdata[ia].lastupdateIp.toString(),
              purchasedate: itemMasdata[ia].purchasedate.toString(),
              snapdatetime: itemMasdata[ia].snapdatetime.toString(),
              specialprice: itemMasdata[ia].specialprice != null
                  ? double.parse(
                      itemMasdata[ia].specialprice.toString(),
                    )
                  : null,
              updatedDatetime: itemMasdata[ia].updatedDatetime.toString(),
              updateduserid: itemMasdata[ia].updateduserid.toString(),
              sellPrice: itemMasdata[ia].sellprice != null
                  ? double.parse(
                      itemMasdata[ia].sellprice.toString(),
                    )
                  : null,
              maxdiscount: itemMasdata[ia].maxdiscount != null
                  ? itemMasdata[ia].maxdiscount.toString()
                  : '',
              taxRate: itemMasdata[ia].taxrate != null
                  ? double.parse(
                      itemMasdata[ia].taxrate.toString(),
                    )
                  : 00,
              discountper: 0,
              openQty: 0,
              inDate: '',
              cost: 0,
              inType: '',
              weight: itemMasdata[ia].weight != null
                  ? double.parse(itemMasdata[ia].weight.toString())
                  : 0,
              liter: itemMasdata[ia].liter != null
                  ? double.parse(itemMasdata[ia].liter.toString())
                  : 0,
            ));
          }
        }
      }
    }
  }

  Future<int?> soScanBatch(
      String sBatch, BuildContext context, ThemeData theme, int ins) async {
    final Database db = (await DBHelper.getInstance())!;
    int soqtyyy = 0;
    soitemcodelistitem = [];

    List<StockSnapTModelDB> itemMasdata =
        await DBOperation.getItemMasDataItemcd(
            db, sBatch.toString(), openOrdLineList![ins].itemCode.toString());
    if (itemMasdata.isNotEmpty) {
      for (int ia = 0; ia < itemMasdata.length; ia++) {
        soqtyyy = soqtycontroller[ins].text.isNotEmpty
            ? int.parse(soqtycontroller[ins].text)
            : 0;
        if (openOrdLineList![ins].itemCode.toString() ==
                itemMasdata[ia].itemcode.toString() &&
            openOrdLineList![ins].openQty > soqtyyy) {
          for (int ih = 0; ih < openSalesOrd.length; ih++) {
            if (openSalesOrd[ih].docEntry.toString() ==
                openOrdLineList![ins].docEntry.toString()) {
              textError = '';
              soitemcodelistitem.add(ItemCodeListModel(
                uPackSize: double.parse(itemMasdata[ia].uPackSize.toString()),
                uTINSPERBOX: int.parse(itemMasdata[ia].uTINSPERBOX.toString()),
                uSpecificGravity:
                    double.parse(itemMasdata[ia].uSpecificGravity.toString()),
                docEntry: openOrdLineList![ins].docEntry.toString(),
                baselineid: int.parse(openOrdLineList![ins].lineNum.toString()),
                itemCode: itemMasdata[ia].itemcode.toString(),
                itemName: itemMasdata[ia].itemname.toString(),
                serialBatch: itemMasdata[ia].serialbatch.toString(),
                qty: double.parse(itemMasdata[ia].quantity.toString()),
                mrp: itemMasdata[ia].mrpprice != null
                    ? double.parse(itemMasdata[ia].mrpprice.toString())
                    : null,
                createdUserID: itemMasdata[ia].createdUserID.toString(),
                createdateTime: itemMasdata[ia].createdateTime.toString(),
                lastupdateIp: itemMasdata[ia].lastupdateIp.toString(),
                purchasedate: itemMasdata[ia].purchasedate.toString(),
                snapdatetime: itemMasdata[ia].snapdatetime.toString(),
                specialprice: itemMasdata[ia].specialprice != null
                    ? double.parse(
                        itemMasdata[ia].specialprice.toString(),
                      )
                    : null,
                updatedDatetime: itemMasdata[ia].updatedDatetime.toString(),
                updateduserid: itemMasdata[ia].updateduserid.toString(),
                sellPrice: itemMasdata[ia].sellprice != null
                    ? double.parse(
                        itemMasdata[ia].sellprice.toString(),
                      )
                    : null,
                maxdiscount: itemMasdata[ia].maxdiscount != null
                    ? itemMasdata[ia].maxdiscount.toString()
                    : '',
                taxRate: itemMasdata[ia].taxrate != null
                    ? double.parse(
                        itemMasdata[ia].taxrate.toString(),
                      )
                    : 00,
                discountper: 0,
                openQty: 0,
                inDate: '',
                cost: 0,
                inType: '',
                weight: itemMasdata[ia].weight != null
                    ? double.parse(itemMasdata[ia].weight.toString())
                    : 0,
                liter: itemMasdata[ia].liter != null
                    ? double.parse(itemMasdata[ia].liter.toString())
                    : 0,
              ));
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
                        content: 'No more qty to add..!!',
                        theme: theme,
                      )),
                      buttonName: null,
                    ));
              });
        }
        log("GGGGGGGGGGGGGGGGGGGGG1111::${soitemcodelistitem.length}");
        return Future.value(ia);
      }
    }
    return Future.value(null);
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

  soOrderdata() {
    soData.clear();
    soitemcodelistitem = [];
    soScanItem = [];
    clearsoaqty();

    for (int ih = 0; ih < soSalesmodl.length; ih++) {
      if (soSalesmodl[ih].invoiceClr == 1 &&
          soSalesmodl[ih].checkBClr == true) {
        for (int ik = 0; ik < soSalesmodl[ih].item!.length; ik++) {
          if (soSalesmodl[ih].item![ik].basedocentry.toString() ==
              soSalesmodl[ih].docentry.toString()) {
            if (soSalesmodl[ih].item![ik].qty != 0) {
              soData.add(StocksnapModelData(
                checkBClr: false,
                invoiceClr: 0,
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

  sBatchFrmStksnap(int index) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> serialbatchCheck =
        await DBOperation.cfoserialBatchCheck(
            db, soData[index].itemCode.toString());
    for (int i = 0; i < serialbatchCheck.length; i++) {
      if (soData[index].itemCode ==
          serialbatchCheck[i]['itemcode'].toString()) {
        soData[index].serialBatch =
            serialbatchCheck[i]['serialbatch'].toString();

        notifyListeners();
      }
    }
    notifyListeners();
    return i;
  }

  clearsoaqty() {
    soqtycontroller = List.generate(100, (ij) => TextEditingController());
  }

  List<OpenSalesOrderHeaderData> openSalesOrd = [];
  List<OpenSalesOrderLineData>? openOrdLine = [];
  List<OpenSalesOrderLineData>? openOrdLineList;

  callOpenSalesOrder(BuildContext context, ThemeData theme) async {
    openSalesOrd = [];
    await SalsesOrderHeaderAPi.getGlobalData(
            AppConstant.branch, selectedcust!.cardCode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openSalesOrd = value.activitiesData!;

        for (var i = 0; i < openSalesOrd.length; i++) {
          openSalesOrd[i].invoiceClr = 0;
          openSalesOrd[i].checkBClr = false;
        }
        await callOpenSalesOrderLine(context, theme);
        notifyListeners();
        log('openSalesOrdopenSalesOrd::${openSalesOrd.length}');
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
      }
    });
  }

  callOpenSalesOrderLine(BuildContext context, ThemeData theme) async {
    await SalesOrderLineApi.getGlobalData(
            AppConstant.branch, selectedcust!.cardCode.toString())
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        openOrdLine = value.activitiesData!;
        log('openOrdLineListopenOrdLineList::${openOrdLine!.length}');
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
      }
    });
  }

  String orderCustname = '';
  showopenOrderLines() {
    openOrdLineList = [];
    for (var ij = 0; ij < openSalesOrd.length; ij++) {
      if (openSalesOrd[ij].invoiceClr == 1 &&
          openSalesOrd[ij].checkBClr == true) {
        //
        custNameController.text = openSalesOrd[ij].cardName;
        tinNoController.text = openSalesOrd[ij].uTinNO ?? '';
        vatNoController.text = openSalesOrd[ij].uVATNUMBER ?? '';
        orderCustname = openSalesOrd[ij].cardName.toString();
        for (var i = 0; i < openOrdLine!.length; i++) {
          if (openOrdLine![i].docEntry == openSalesOrd[ij].docEntry) {
            openOrdLineList!.add(OpenSalesOrderLineData(
                price: openOrdLine![i].price,
                stock: openOrdLine![i].stock,
                itemCode: openOrdLine![i].itemCode,
                discPrcnt: openOrdLine![i].discPrcnt,
                valueInsert: false,
                checkBClr: false,
                lineNum: openOrdLine![i].lineNum,
                uPackSize: openOrdLine![i].uPackSize != null ||
                        openOrdLine![i].uPackSize != 0
                    ? openOrdLine![i].uPackSize
                    : null,
                docEntry: openOrdLine![i].docEntry,
                description: openOrdLine![i].description,
                openQty: openOrdLine![i].openQty,
                whsCode: openOrdLine![i].whsCode));
          }
          notifyListeners();
        }
      }
    }

    notifyListeners();

    notifyListeners();
    log('openOrdLineListListopenOrdLineListList::${openOrdLineList!.length}');
  }

  soOrderListQtychange(int i, BuildContext context, ThemeData theme) {
    double solistQty = double.parse(soListController[i].text);

    if (solistQty == 0) {
      if (soScanItem.isNotEmpty) {
        for (var im = 0; im < soScanItem.length; im++) {
          if (openOrdLineList![i].lineNum.toString() ==
              soScanItem[im].baselineid.toString()) {
            soFilterScanItem.removeAt(im);
            soScanItem.removeAt(im);
          }
          notifyListeners();
        }
      }
      autoselectbtndisable = false;
      manualselectbtndisable = false;
      openOrdLineList![i].valueInsert = false;
    } else if (openOrdLineList![i].openQty >= solistQty) {
      soListController[i].text = solistQty.toString();
      notifyListeners();
    } else {
      soListController[i].text = openOrdLineList![i].openQty.toString();
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
                    content: 'Allocation qty is grater than Sales order qty',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          });
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
          log('step12::$cardAccCode');
        } else if (newCashAcc[i].uMode == 'CHEQUE') {
          chequeAccCode = newCashAcc[i].uAcctCode.toString();
          log('step13::$chequeAccCode');
        } else if (newCashAcc[i].uMode == 'WALLET') {
          walletAccCode = newCashAcc[i].uAcctCode.toString();
          log('step14::$walletAccCode');
        } else if (newCashAcc[i].uMode == 'TRANSFER') {
          transAccCode = newCashAcc[i].uAcctCode.toString();
          log('step15::$transAccCode');
        }
      }
      notifyListeners();
    }
    notifyListeners();
  }

  mapsodata(
    BuildContext context,
    ThemeData theme,
  ) async {
    mycontroller[50].text = "";
    selectedBillAdress = 0;
    selectedShipAdress = 0;
    soBatchTable = [];
    scanneditemData = [];
    cpyfrmso = "CopyfromSo";
    selectedcust!.name = orderCustname;
    custNameController.text = orderCustname.toString();

    for (int ihk = 0; ihk < openOrdLineList!.length; ihk++) {
      log('openOrdLineList![ihk].valueInsert ::${openOrdLineList![ihk].valueInsert}');

      if (openOrdLineList![ihk].valueInsert == true &&
          soListController[ihk].text.isNotEmpty) {
        scanneditemData.add(StocksnapModelData(
          branch: openOrdLineList![ihk].whsCode,
          itemCode: openOrdLineList![ihk].itemCode,
          itemName: openOrdLineList![ihk].description,
          uPackSize: openOrdLineList![ihk].uPackSize != null ||
                  openOrdLineList![ihk].uPackSize != 0
              ? openOrdLineList![ihk].uPackSize!
              : null,
          basedocentry: openOrdLineList![ihk].docEntry.toString(),
          baselineid: openOrdLineList![ihk].lineNum.toString(),
          openQty: double.parse(openOrdLineList![ihk].stock.toString()),
          serialBatch: '',
          openRetQty: soListController[ihk].text.isNotEmpty
              ? double.parse(soListController[ihk].text)
              : 0.0,
          discountper: openOrdLineList![ihk].discPrcnt,
          mrp: 0,
          sellPrice: openOrdLineList![ihk].price,
          inDate: '',
          cost: 0,
          uPackSizeuom: '0',
          uSpecificGravity: 0,
          uTINSPERBOX: 0,
          inType: '',
        ));
      }

      notifyListeners();
    }
    log("SO scanneditemData.length::${scanneditemData.length}");

    for (int il = 0; il < scanneditemData.length; il++) {
      scanneditemData[il].transID = il;
      discountcontroller[il].text = scanneditemData[il].discountper.toString();

      qtymycontroller[il].text = scanneditemData[il].openRetQty.toString();
      if (selectedcust != null && selectedcust!.taxCode != null) {
        log('somapdata taxCode:::${selectedcust!.taxCode}');
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
    }
    log('soScanItemsoScanItem::${soScanItem.length}');

    for (int ik = 0; ik < soScanItem.length; ik++) {
      soBatchTable.add(Invbatch(
          itemCode: soScanItem[ik].itemCode,
          lineId: int.parse(soScanItem[ik].baselineid.toString()),
          quantity: double.parse(soScanItem[ik].openRetQty.toString()),
          batchNumberProperty: soScanItem[ik].serialBatch.toString()));
      notifyListeners();
    }
    for (var i = 0; i < soBatchTable.length; i++) {}
    log('soBatchTablesoBatchTable::${soBatchTable.length}');
    notifyListeners();
    await calCulateDocVal(context, theme);

    Get.back();

    notifyListeners();
  }

  validateUDF(BuildContext context) {
    if (selectedTruckType == null) {
      isSelectTruckType = true;
      notifyListeners();
    } else {
      Navigator.pop(context);
      notifyListeners();
    }
    notifyListeners();
  }

  String? selectedTruckType;
  bool isSelectTruckType = false;
  List<Map<String, String>> internalTruckType = [
    {"name": "NO", "value": '1'},
    {"name": "YES", "value": '2'},
    {"name": "N/A", "value": '3'},
  ];
  List get getinternalTruckType => internalTruckType;
  checkstocksetqty() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.checkItemCode(db, "");
    notifyListeners();
  }

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/Verifyt.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("/storage/emulated/0/sqbackup");
    return Future.value(copyTo);
  }

  Future<void> copyDatabaseToExternalStorage() async {
    await getPermissionStorage();

    final internalDbPath = await getDatabasesPath();
    final dbFile = File('$internalDbPath/PosDBV2.db');

    final externalDir = await getExternalStorageDirectory();
    final externalDbPath = '${externalDir?.path}/PosDBV2.db';

    if (await dbFile.exists()) {
      await dbFile.copy(externalDbPath);
      showSnackBars("$externalDbPath db saved Successfully", Colors.green);
    } else {}
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
      duration: const Duration(seconds: 5),
      title: "Notify",
      message: e,
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

  clearSuspendedData(BuildContext context, ThemeData theme) {
    mycontroller = List.generate(150, (i) => TextEditingController());
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    ondDisablebutton = true;
    selectbankCode = '';
    selectedBankType = null;
    bankhintcolor = false;
    scanneditemData.clear();
    remarkcontroller3.text = '';
    selectedcust = null;
    selectedcust55 = null;
    newAddrsValue = [];
    newCustValues = [];
    billadrrssItemlist = [];
    shipadrrssItemlist = [];
    billadrrssItemlist5 = [];
    shipadrrssItemlist5 = [];
    mycontroller[50].clear();
    custNameController.text = '';
    tinNoController.text = '';
    vatNoController.text = '';
    cpyfrmso = '';
    paymentWay.clear();
    totalPayment = null;
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

    mycontroller = List.generate(150, (i) => TextEditingController());
    getdraftindex();
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
      ondDisablebutton = false;
      notifyListeners();
    });
  }

  Invoice? invoice = const Invoice();
  List<Address> address2 = [];
  String? remark;
  double exclTxTotal = 0;
  double inclTxTotal = 0;
  double vatTx = 0;
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

  callEinvoicebtn(BuildContext context, ThemeData theme) {
    if (sapDocentry != null || sapDocentry!.isNotEmpty) {
      callEInvoiceApi(context, theme);
    }
    notifyListeners();
  }

  setstate1() {
    notifyListeners();
  }

  Future<void> callPrintApi(
    BuildContext context,
    ThemeData theme,
  ) async {
    ondDisablebutton = true;

    SalesInvoicePrintAPi.docEntry = sapDocentry;
    SalesInvoicePrintAPi.slpCode = AppConstant.slpCode;

    await SalesInvoicePrintAPi.getGlobalData().then((value) {
      if (value == 200) {
        ondDisablebutton = false;
        notifyListeners();
      } else {
        showSnackBar('Try again!!..', context);
        ondDisablebutton = false;
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

  mapCallSalesInfoApiForPDF(
      preff, BuildContext context, ThemeData theme) async {
    List<InvoiceItem> itemsList = [];
    invoice = null;

    addressxx();
    for (int i = 0; i < scanneditemData2.length; i++) {
      itemsList.add(InvoiceItem(
        slNo: '${i + 1}',
        //
        descripton: scanneditemData2[i].itemName,
        unitPrice:
            double.parse(scanneditemData2[i].sellPrice!.toStringAsFixed(2)),
        quantity: scanneditemData2[i].qty ?? 0,
        dics: scanneditemData2[i].discountper ?? 0,
        vat: scanneditemData2[i].taxvalue != null
            ? double.parse(scanneditemData2[i].taxvalue!.toStringAsFixed(2))
            : 0,
        pails: scanneditemData2[i].pails != null
            ? int.parse(scanneditemData2[i].pails!.toString())
            : 0,
        cartons: scanneditemData2[i].cartons != null
            ? int.parse(scanneditemData2[i].cartons!.toString())
            : 0,
        looseTins: scanneditemData2[i].looseTins != null
            ? double.parse(scanneditemData2[i].looseTins!.toString())
            : 0,
        tonnage: scanneditemData2[i].tonnage != null
            ? double.parse(scanneditemData2[i].tonnage!.toString())
            : 0,
      ));
      notifyListeners();
    }
    invoice = Invoice(
      headerinfo: InvoiceHeader(
          ordReference: selectedcust2!.custRefNum ?? '',
          invDate: config.alignDate(selectedcust2!.invoiceDate.toString()),
          invNum: selectedcust2!.invoicenum ?? '',
          tincode: custDetails![0].U_TinNO ?? '',
          vatNo: custDetails![0].U_VAT_NUMBER ?? '',
          companyName: 'companyName',
          address: custDetails![0].address ?? '',
          area: 'area',
          pincode: 'pincode',
          mobile: 'mobile',
          gstNo: 'gstNo',
          U_QRPath: selectedcust2!.U_QRPath ?? '',
          U_VfdIn: selectedcust2!.U_VfdIn ?? '',
          U_QRValue: selectedcust2!.U_QRValue ?? '',
          U_Zno: selectedcust2!.U_Zno ?? '',
          U_idate: selectedcust2!.U_idate ?? '',
          U_itime: selectedcust2!.U_itime ?? '',
          U_rctCde: selectedcust2!.U_rctCde ?? '',
          salesOrder: selectedcust2!.invoicenum),
      invoiceMiddle: InvoiceMiddle(
        tinNo: cmpnyDetails![0].tinNo ?? '',
        vatNo: cmpnyDetails![0].vatNo ?? '',
        date: selectedcust2!.invoiceDate.toString(),
        time: 'time',
        customerName: selectedcust2!.name ?? '',
        mobile:
            selectedcust2!.phNo!.isEmpty ? '' : selectedcust2!.phNo.toString(),
        address: address2.isEmpty || address2[0].address1!.isEmpty
            ? ''
            : address2[0].address1.toString(),
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

    PdfInvoiceApiii.exclTxTotal = 0;
    PdfInvoiceApiii.vatTx = 0;
    PdfInvoiceApiii.inclTxTotal = 0;
    if (invoice!.items!.isNotEmpty) {
      for (int i = 0; i < invoice!.items!.length; i++) {
        invoice!.items![i].basic =
            (invoice!.items![i].quantity!) * (invoice!.items![i].unitPrice!);
        invoice!.items![i].discountamt =
            (invoice!.items![i].basic! * invoice!.items![i].dics! / 100);
        invoice!.items![i].netTotal =
            (invoice!.items![i].basic!) - (invoice!.items![i].discountamt!);
        PdfInvoiceApiii.exclTxTotal =
            (PdfInvoiceApiii.exclTxTotal) + (invoice!.items![i].netTotal!);
        PdfInvoiceApiii.vatTx = (PdfInvoiceApiii.vatTx) +
            double.parse(invoice!.items![i].vat.toString());
        PdfInvoiceApiii.inclTxTotal =
            double.parse(invoice!.items![i].unitPrice.toString()) +
                double.parse(invoice!.items![i].vat.toString());
        PdfInvoiceApiii.pails =
            PdfInvoiceApiii.pails! + invoice!.items![i].pails!;
        PdfInvoiceApiii.cartons =
            PdfInvoiceApiii.cartons! + invoice!.items![i].cartons!;
        PdfInvoiceApiii.looseTins =
            PdfInvoiceApiii.looseTins! + invoice!.items![i].looseTins!;
        PdfInvoiceApiii.tonnage =
            PdfInvoiceApiii.tonnage! + invoice!.items![i].tonnage!;
        notifyListeners();
      }
      PdfInvoiceApiii.totalPack = PdfInvoiceApiii.pails! +
          PdfInvoiceApiii.cartons! +
          PdfInvoiceApiii.looseTins!;
      PdfInvoiceApiii.inclTxTotal =
          (PdfInvoiceApiii.exclTxTotal) + (PdfInvoiceApiii.vatTx);
      int length = invoice!.items!.length;
      if (length > 0) {
        notifyListeners();
      }

      PdfInvoiceApiii.iinvoicee = invoice;
      await printingdoc(context, theme);
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
                    content: 'No Printing Bills',
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
        context,
        MaterialPageRoute(
            builder: (context) => PdfInvoiceApiii(
                  'Printing Document',
                  theme,
                )));
    notifyListeners();
  }

  clearAllData(BuildContext context, ThemeData theme) {
    formkeyy = List.generate(100, (i) => GlobalKey<FormState>());
    focusnode = List.generate(100, (i) => FocusNode());
    manualQtyCtrl = List.generate(100, (ij) => TextEditingController());
    soScanItem = [];
    itemsDocDetails = [];
    fetchBatchData = [];
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
    selectionBtnLoading = false;
    addIndex = [];
    openSalesOrd = [];
    vatNoController.text = '';
    tinNoController.text = '';
    custNameController.text = '';
    newCustAddData = [];
    manualselectbtndisable = false;
    filtersearchData = [];
    seriesType = '';
    custNameController.text = '';

    openAutoSelect = [];
    noMsgText = '';
    custseriesNo = null;
    schemebtnclk = false;
    cancelbtn = false;
    autoselectbtndisable = false;
    batchselectbtndisable = false;
    isSelectTruckType = false;
    textError = '';
    bankList = [];
    bankhintcolor = false;
    cashType = '';
    transpayment = null;
    transrefff = '';
    chequeType = '';
    cardType = '';
    transferType = '';
    walletType = '';
    pointType = '';
    cpyfrmso = '';
    selectedBankType = null;
    selectbankCode = '';
    loadingscrn = false;
    newAddrsValue = [];
    newCustValues = [];
    billadrrssItemlist = [];
    shipadrrssItemlist = [];
    billadrrssItemlist5 = [];
    shipadrrssItemlist5 = [];
    cpyfrmso = '';
    remarkcontroller3.text = '';
    formkeyAdd = GlobalKey<FormState>();
    mycontroller = List.generate(150, (i) => TextEditingController());
    mycontroller2 = List.generate(150, (i) => TextEditingController());
    remarkcontroller3 = TextEditingController();
    qtymycontroller = List.generate(100, (ij) => TextEditingController());
    discountcontroller = List.generate(100, (ij) => TextEditingController());
    qtymycontroller2 = List.generate(100, (ij) => TextEditingController());
    soqtycontroller = List.generate(100, (ij) => TextEditingController());
    searchcontroller = TextEditingController();
    selectedcust = null;
    paymentWay.clear();
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
    ondDisablebutton = false;
    searchbool = false;
    searchmapbool = false;
    totalPayment = null;
    totalPayment2 = null;
    filtersearchData.clear();
    selectedcust2 = null;
    searchData.clear();
    soTotal = 0;
    soSalesmodl.clear();
    cpyfrmso = '';
    itemcodelistitem.clear();
    onHoldFilter.clear();
    onHold.clear();
    totquantity = null;
    discountamt = null;
    totquantity = null;
    discountamt = null;
    cashpayment = null;
    cashpayment = null;

    cqpayment = null;

    transpayment = null;
    chqnum = null;

    transrefff = null;
    salesmodl.clear();
    soData.clear();
    newCustValues.clear();
    newAddrsValue.clear();
    clearTextField();
    clearCustomer();
    clearAddress();
    itemData.clear();
    selectedShipAdress = 0;
    selectedBillAdress = 0;
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
}
