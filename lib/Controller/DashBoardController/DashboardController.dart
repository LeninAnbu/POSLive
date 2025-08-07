import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:posproject/Constant/Configuration.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/SharedPreference.dart';
import '../../Constant/UserValues.dart';
import '../../Constant/VersionConfiguration.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/NotificationModel.dart';
import '../../DBModel/NumberingSeries.dart';
import '../../DBModel/UserDBModel.dart';
import '../../DBModel/paidfromModel.dart';
import '../../Models/DataModel/OriginalSales/OriginalSales.dart';
import '../../Models/ExpenseModel/paidfrom.dart';
import '../../Service/QueryURL/cashcardaccountdetailsApi.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../LoginController/LoginController.dart';

class DashBoardController extends ChangeNotifier {
  Configure config = Configure();
  double percent = 0.0;
  double get getpercent => percent;
  List<UserValues> userConstVal = [];
  List<String> catchmsg = [];

  void init(BuildContext context) async {
    await getApppDefaultVal();
    getuserVlues();
    insterNumberingSeries();

    getOutOfStockItems();

    getNotification();
    checkpaidfrom();
    refreshQueue();
    await deleteholdmethod();
    showVersion(context);
    log('UserValues.userIDUserValues.userID::${UserValues.userCode}');
  }

  insertNotify() async {
    List<NotificationModel> notifyx = [];
    final Database db = (await DBHelper.getInstance())!;
    notifyx.add(NotificationModel(
      docEntry: 0,
      titile: 'yesterday Pos',
      description: 'Check yesterday notification',
      receiveTime: DateTime.now().subtract(Duration(days: 1)).toString(),
      seenTime: '0',
      imgUrl: 'null',
      naviScn: 'null',
    ));
    await DBOperation.insertNotification(notifyx, db);
    await DBOperation.getNotification(db);
    notifyListeners();
  }

  static const MethodChannel _channel =
      MethodChannel('com.buson.posinsignia/location');

  getLocation(BuildContext context) async {
    Position? position = await checkAndEnableLocation(context);
    if (position != null) {
      log("Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    } else {
      print("Location services are disabled or not available.");
    }
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

    await requestLocationPermission2(context);
  }

  requestLocationPermission2(BuildContext context) async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.accessMediaLocation,
    ].request();
    log('storage request11$statuses');
  }

  Future<Position?> checkAndEnableLocation(BuildContext context) async {
    try {
      final bool isEnabled = await _channel.invokeMethod('isLocationEnabled');
      if (!isEnabled) {
        checkAndPromptLocationService(context);
        return null;
      }
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

  void checkAndPromptLocationService(BuildContext context) async {
    await showDialog(
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
                        getLocation(context);
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

  callCashCardAccApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    await CashCardAccountAPi.getGlobalData(AppConstant.branch)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('ppppppppppppp');
        await preferences.setString(
            'UCashAccount', value.activitiesData![0].uCashAcct);
        await preferences.setString(
            'UCreditAccount', value.activitiesData![0].uCreditAcct);
        await preferences.setString(
            'UCheckAccount', value.activitiesData![0].uChequeAcct);
        await preferences.setString(
            'UTransAccount', value.activitiesData![0].uTransferAcct);
        await preferences.setString(
            'UWalletAccount', value.activitiesData![0].uWalletAcc);
        log('checkacccheckacccheckacc:::${preferences.getString('UCashAccount')}');
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  List<NotificationModel> notify = [];
  List<NotificationModel> get getnotify => notify;

  List<NotificationModel> notifyreverse = [];
  getNotification() async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.getNotification(db);
    notifyreverse =
        await DBOperation.getDateWiseNotification(db, config.currentDate2());
    notify = notifyreverse.reversed.toList();
    notifyListeners();
  }

  final firebaseMessaging = FirebaseMessaging.instance;
  getFCM() async {
    String? tokenFCM = await getTokenn();
    log("FCM tocken: " + tokenFCM!);
  }

  Future<String?> getTokenn() async {
    return firebaseMessaging.getToken();
  }

  refreshQueue() async {
    bool? netbool = await config.haveInterNet();
    if (netbool == true) {
      final Database db = (await DBHelper.getInstance())!;
      List<Map<String, Object?>> getQstatusData =
          await DBOperation.getQstatusData22(db);

      if (getQstatusData.isNotEmpty) {
        for (int i = 0; i < getQstatusData.length; i++) {
          if (getQstatusData[i]["doctype"].toString() == "Sales Invoice") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Sales Order") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesOrderHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Sales Quotation") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesQuotationHeader');

              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Sales Return") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'SalesReturnHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Payment Receipt") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'ReceiptHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Request") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapStkReqHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockReqHDT');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Outward") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockOutHeaderDataDB');
            }
          } else if (getQstatusData[i]["doctype"].toString() ==
              "Stock Inward") {
            await DBOperation.getRabitMqStInDetails(
                db, int.parse(getQstatusData[i]["docentry"].toString()));

            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'StockInHeaderDB');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Expense") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'Expense');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Settlement") {
            if (getQstatusData[i]["sapDocentry"] != null &&
                getQstatusData[i]["sapDocNo"] != null &&
                getQstatusData[i]["qStatus"] == "Y") {
              await DBOperation.updtSapDetSalHead(
                  db,
                  int.parse(getQstatusData[i]["sapDocentry"].toString()),
                  int.parse(getQstatusData[i]["sapDocNo"].toString()),
                  int.parse(getQstatusData[i]["docentry"].toString()),
                  'tableDepositHeader');
              notifyListeners();
            }
          } else if (getQstatusData[i]["doctype"].toString() == "Refund") {
            notifyListeners();
          }
        }
        notifyListeners();
      }
    }
    notifyListeners();
  }

  List<DocumentName> docNameId = [
    DocumentName(docName: 'Sales Order'),
    DocumentName(docName: 'Sales Invoice'),
    DocumentName(docName: 'Sales Return'),
    DocumentName(docName: 'Inventory Transfer Request'),
    DocumentName(docName: 'Stock Inward'),
    DocumentName(docName: 'Stock Outward'),
    DocumentName(docName: 'Payment Receipt'),
    DocumentName(docName: 'Expenses'),
    DocumentName(docName: 'Settlement'),
    DocumentName(docName: 'Sales Quotation'),
  ];

  insterNumberingSeries() async {
    final Database db = (await DBHelper.getInstance())!;

    int? count = await DBOperation.getcountofTable(db, 'id', 'NumberingSeries');
    if (count! < 1) {
      insertNumberingSeries();
    }
  }

  insertNumberingSeries() async {
    final Database db = (await DBHelper.getInstance())!;
    List<NumberingSriesTDB> numberseries = [];

    for (int i = 0; i < docNameId.length; i++) {
      numberseries.add(NumberingSriesTDB(
          id: i + 1,
          docID: i + 1,
          firstNo: 1,
          fromDate: DateTime.now().toString(),
          lastNo: 199999,
          nextNo: 0,
          prefix: prefix(i + 1, AppConstant.branch.substring(0, 2),
              AppConstant.terminal, 100000),
          terminal: AppConstant.terminal,
          toDate: DateTime.now().toString(),
          wareHouse: AppConstant.branch,
          docName: docNameId[i].docName!));
    }
    await DBOperation.insertnumbering(db, numberseries);
  }

  String prefix(int menu, String brnch, String terminal, int value) {
    return '25${menu.toString().padLeft(2, '0')}$brnch$terminal$value';
  }

  refresh() async {
    await getOutOfStockItems();
    await chartMethod();
    await refreshQueue();
    getNotification();
  }

  List<OrdinalSales> chartDataList = [];
  List<SyncData> syncData1 = [];
  List<SyncData> outOfstock = [];
  bool outOfstockBool = false;
  bool syncdataBool = false;
  bool annocementBool = false;

  int noofSales = 0;
  double noofSalesamt = 0.0;
  double cashbalance = 0.0;
  int noofSalesOrder = 0;
  int couponsCount = 0;
  int couponsUsedCount = 0;

  double noofSalesOrderamt = 0.0;

  chartMethod() async {
    syncdataBool = true;
    syncData1.clear();
    noofSales = 0;
    noofSalesamt = 0.0;
    couponsCount = 0;
    couponsUsedCount = 0;
    cashbalance = 0.0;
    noofSalesamt = 0.0;
    noofSalesOrder = 0;
    notifyListeners();
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> chartData = await DBOperation.getChartData(db);
    for (int i = 0; i < chartData.length; i++) {
      chartDataList.add(OrdinalSales(
          chartData[i]["createdatetime"] == null
              ? "a"
              : chartData[i]["createdatetime"].toString(),
          chartData[i]["amtpaid"] == null
              ? 0.0
              : double.parse(chartData[i]["amtpaid"].toString())));
    }

    List<Map<String, Object?>> noOfSalesData =
        await DBOperation.getNoSalesData(db);

    if (noOfSalesData.isNotEmpty) {
      noofSales = noOfSalesData[0]["noofsales"] == null
          ? 0
          : int.parse(noOfSalesData[0]["noofsales"].toString());
      noofSalesamt = noOfSalesData[0]["amtpaid"] == null
          ? 0.00
          : double.parse(noOfSalesData[0]["amtpaid"].toString());
    } else {}
    List<Map<String, Object?>> noOfSalesOrderData =
        await DBOperation.getNoSalesOrderData(db);
    if (noOfSalesOrderData.isNotEmpty) {
      noofSalesOrder = noOfSalesOrderData[0]["noofsales"] == null
          ? 0
          : int.parse(noOfSalesOrderData[0]["noofsales"].toString());
      noofSalesOrderamt = noOfSalesOrderData[0]["doctotal"] == null
          ? 0.00
          : double.parse(noOfSalesOrderData[0]["doctotal"].toString());
    } else {}
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, "Cash");
    if (getDBsalespaysettle5.isNotEmpty) {
      for (int j = 0; j < getDBsalespaysettle5.length; j++) {
        if (formattedDate.toString() ==
            config.alignDate(
                getDBsalespaysettle5[j]["createdateTime"].toString())) {
          cashbalance = cashbalance +
              double.parse(getDBsalespaysettle5[j]["rcamount"].toString());
        }
      }
    } else {}

    List<Map<String, Object?>> getCouponsCountData =
        await DBOperation.getCouponsCount(db);
    List<Map<String, Object?>> getCouponsUsedCountData =
        await DBOperation.getCouponsUsedCount(db);
    couponsCount = getCouponsCountData[0]["count"] == null
        ? 0
        : int.parse(getCouponsCountData[0]["count"].toString());
    couponsUsedCount = getCouponsUsedCountData[0]["count"] == null
        ? 0
        : int.parse(getCouponsUsedCountData[0]["count"].toString());

    notifyListeners();

    List<Map<String, Object?>> getsyncedData =
        await DBOperation.getSynceData(db);
    if (getsyncedData.isNotEmpty) {
      for (int j = 0; j < getsyncedData.length; j++) {
        syncData1.add(SyncData(
          qStatus: getsyncedData[j]["qStatus"].toString(),
          doctype: getsyncedData[j]["doctype"].toString(),
          docNo: getsyncedData[j]["documentno"] == null
              ? "0"
              : getsyncedData[j]["documentno"].toString(),
          docdate: getsyncedData[j]["createdateTime"].toString(),
          sapDate: getsyncedData[j]["UpdatedDatetime"].toString(),
          customername: getsyncedData[j]["customername"].toString(),
          sapNo: getsyncedData[j]["sapDocNo"] == null
              ? 0
              : int.parse(
                  getsyncedData[j]["sapDocNo"].toString().replaceAll(',', '')),
          editType: getsyncedData[j]["editType"].toString(),
        ));
        notifyListeners();
      }
    } else {
      syncdataBool = false;
      notifyListeners();
    }

    notifyListeners();
  }

  deleteholdmethod() async {
    final Database db = (await DBHelper.getInstance())!;
    await DBOperation.holdDeleteQuery(db);
    notifyListeners();
  }

  getOutOfStockItems() async {
    outOfstock.clear();
    outOfstockBool = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getOutOfItemsData =
        await DBOperation.getoutofDataData(db);
    if (getOutOfItemsData.isNotEmpty) {
      for (int j = 0; j < getOutOfItemsData.length; j++) {
        if (getOutOfItemsData[j]["shortageQty"] != 0) {
          outOfstock.add(SyncData(
              itemname: getOutOfItemsData[j]["itemnameshort"] == null
                  ? ''
                  : getOutOfItemsData[j]["itemnameshort"].toString(),
              qty: getOutOfItemsData[j]["shortageQty"] == null
                  ? 0
                  : int.parse(getOutOfItemsData[j]["shortageQty"].toString()),
              customername: '',
              editType: ''));
        }
      }
    } else {
      getOutOfStockItems();
      outOfstockBool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  List<PaidFrom> paidfrom = [
    PaidFrom(accountcode: "account1", accountname: "Petty Cash", balance: ""),
    PaidFrom(accountcode: "account2", accountname: "Petty Card", balance: ""),
    PaidFrom(accountcode: "account3", accountname: "Cash In Hand", balance: ""),
  ];

  insertpaidefrome() async {
    final Database db = (await DBHelper.getInstance())!;

    List<expensepaidfrom> paidfromExpense = [];
    for (int i = 0; i < paidfrom.length; i++) {
      paidfromExpense.add(expensepaidfrom(
          accountcode: paidfrom[i].accountcode,
          accountname: paidfrom[i].accountname,
          balance: paidfrom[i].balance));
    }
    await DBOperation.insertExpensepaidfrom(db, paidfromExpense);

    notifyListeners();
    paidfrom.clear();
  }

  checkpaidfrom() async {
    final Database db = (await DBHelper.getInstance())!;
    int? getval = await DBOperation.getExpaidfromcount(
      db,
    );
    if (getval! < 1) {
      insertpaidefrome();
    } else if (getval > 0) {}
  }

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to exit an app"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text("No"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text("yes"))
            ],
          ),
        )) ??
        false;
  }

  clearData(BuildContext context) async {
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.truncateItemMaster(db);
    await DBOperation.truncateStockSnap(db);
    await DBOperation.truncateBranchMaster(db);
    await DBOperation.truncateCouponDetailsMaster(db);
    await DBOperation.truncateCustomerMasterAddress(db);
    await DBOperation.truncateCustomerMaster(db);
    await DBOperation.deleteNotifyAll(db);
    await DBOperation.truncateUserMaster(db);
    await DBOperation.deleteSalesQuot(db);
    await DBOperation.deleteSalesOrder(db);
    await DBOperation.deleteInvoicewholedata(db);
    await DBOperation.dltsalesret(db);
    await DBOperation.deletereceipt(db);
    await DBOperation.deleteStockreq(db);
    await DBOperation.deleteStOutTable(db);
    await DBOperation.deleteStkInward(db);
    await DBOperation.deleteExpense(db);
    await SharedPref.clearHost();
    await SharedPref.clearLoggedIN();
    await SharedPref.clearSiteCode();
    await SharedPref.clearTerminal();
    await SharedPref.clrBranchSSP();
    await SharedPref.clrUserIdSP();
    await SharedPref.clearDatadonld();
    await SharedPref.clearLoggedINSP();
    await SharedPref.clrdsappassword();
    await SharedPref.clrsapusername();
    context.read<LoginController>().mycontroller[0].text = '';
    context.read<LoginController>().mycontroller[1].text = '';
    context.read<LoginController>().mycontroller[2].text = '';
    context.read<LoginController>().mycontroller[4].text = '';
    context.read<LoginController>().mycontroller[5].text = '';
    notifyListeners();
  }

  bool visibleLoading = true;
  String? plyStoreVersionNumber = '';
  Future<void> showVersion(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    AppConstant.version = packageInfo.version;

    bool? netbool = await config.haveInterNet();

    if (netbool == true) {
      log('messagemmmmm');
      checkVesionNum(context);
    } else {
      showSnackBar('Check your internet !!..', context);
    }
  }

  void showSnackBar(String msg, BuildContext context) {
    final sn = SnackBar(
      content: Text(
        "$msg",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.maybeOf(context)!.showSnackBar(sn);
  }

  void checkVesionNum(BuildContext context) async {
    CheckVersionConfig checkverConfig = CheckVersionConfig();

    visibleLoading = true;
    plyStoreVersionNumber =
        await checkverConfig.getStoreVersion('com.buson.posinsignia');
    log('versionNumber11::$plyStoreVersionNumber::AppVersionversion11::${AppConstant.version}');

    if (plyStoreVersionNumber != null) {
      if (plyStoreVersionNumber == AppConstant.version) {
      } else {
        log('versionNumber22::$plyStoreVersionNumber::AppVersionversion22::${AppConstant.version}');

        await Future.delayed(
          const Duration(seconds: 1),
          () {
            visibleLoading = true;
            updateDialog(context);
          },
        );
      }
    }
  }

  updateDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
              width: Screens.width(context) * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Update available",
                    style: theme.textTheme.titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Text(
                    "There is a new version of the app",
                    style: theme.textTheme.bodyMedium,
                  ),
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          height: Screens.bodyheight(context) * 0.15,
                          width: Screens.width(context) * 0.10,
                          padding: EdgeInsets.all(
                              Screens.bodyheight(context) * 0.008),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[200]),
                          child: Image.asset(
                            'assets/SellerSymbol.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(
                              Screens.bodyheight(context) * 0.008),
                          child: Text(
                            'Version : ${plyStoreVersionNumber}',
                            style: theme.textTheme.bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Screens.width(context) * 0.25,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                            ),
                            onPressed: () async {
                              clearData(context);
                              if (Platform.isAndroid || Platform.isIOS) {
                                final appId = Platform.isAndroid
                                    ? 'com.buson.posinsignia'
                                    : 'com.buson.posinsignia';

                                final url = Uri.parse(
                                  Platform.isAndroid
                                      ? "https://play.google.com/store/apps/details?id=com.buson.posinsignia"
                                      : "https://apps.apple.com/app/id$appId",
                                );
                                await DefaultCacheManager().emptyCache();
                                launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                ).then((value) {});
                              }
                            },
                            child: Text(
                              'Update',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  getApppDefaultVal() async {
    AppConstant.ip = (await SharedPref.getHostDSP())!;
    AppConstant.branch = (await SharedPref.getBranchSSP())!;
    AppConstant.terminal = (await SharedPref.getTerminal())!;
    AppConstant.sapDB = (await SharedPref.getSapDB())!;

    AppConstant.slpCode = (await SharedPref.getslpCode())!;
    AppConstant.sapPassword = await SharedPref.getSapPassword();
    AppConstant.sapUserName = await SharedPref.getSapUserName();

    notifyListeners();
  }

  getuserVlues() async {
    final Database db = (await DBHelper.getInstance())!;

    List<UserModelDB> userModeldb = await DBOperation.userValues(
        db, (await SharedPref.getUSerSP()).toString());
    for (int i = 0; i < userModeldb.length; i++) {
      UserValues.branch = (await SharedPref.getBranchSSP()).toString();
      UserValues.deviceID = (await SharedPref.getDeviceIDSP());
      UserValues.userID = int.parse(userModeldb[i].createdUserID.toString());
      UserValues.userCode = (await SharedPref.getUSerSP()).toString();
      UserValues.salesExce = '';
      UserValues.lastUpdateIp = userModeldb[i].lastupdateIp.toString();
      UserValues.username = userModeldb[i].userName!;
      UserValues.licenseKey = userModeldb[i].licensekey!;
      UserValues.userStaus = userModeldb[i].userstatus.toString();
      UserValues.userType = userModeldb[i].usertype!.toString();
      UserValues.terminal = (await SharedPref.getTerminal()).toString();
      notifyListeners();
    }
    notifyListeners();
  }

  final pagecontroller = PageController(
    initialPage: 0,
  );
}

class SyncData {
  String editType;
  String? docNo;
  String? itemname;
  String? docdate;
  String? qStatus;
  int? qty;
  int? sapNo;
  String? sapDate;
  String? doctype;
  String? customername;
  String? sapStatus;
  String? docentry;
  String? basedocentry;
  String? sapDocentry;
  String? reqfromwhs;
  String? reqtowhs;

  SyncData(
      {this.docNo,
      required this.editType,
      this.itemname,
      this.docdate,
      this.qty,
      this.doctype,
      this.sapNo,
      this.qStatus,
      this.sapStatus,
      this.sapDocentry,
      this.docentry,
      this.basedocentry,
      this.reqfromwhs,
      this.reqtowhs,
      this.customername,
      this.sapDate});
}

class DocumentName {
  String? docName;
  DocumentName({required this.docName});
}
