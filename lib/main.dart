import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/UserValues.dart';
import 'package:posproject/Controller/DashBoardController/DashboardController.dart';
import 'package:posproject/Controller/DepositController/DepositsReportCtrl.dart';
import 'package:posproject/Controller/LogoutController/LogOutControllers.dart';
import 'package:posproject/Controller/PaymentReceiptController/ReportsCtrl.dart';
import 'package:posproject/Controller/ReportsController.dart';
import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
import 'package:posproject/Controller/TransacationSyncController/TransactionSyncController.dart';
import 'package:posproject/DBModel/StockSnap.dart';
import 'package:posproject/Pages/DashBoard/Screens/DashBoardScreen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Constant/AllRoutes.dart';
import 'Constant/AppConstant.dart';
import 'Constant/Configuration.dart';
import 'Constant/LocalNotification.dart';
import 'Constant/SharedPreference.dart';
import 'Controller/ApiSettingsController/ApiSettingsController.dart';
import 'Controller/CashStatementController/CashSatementCont.dart';
import 'Controller/CustomerController/CustomerController.dart';
import 'Controller/DownLoadController/DownloadController.dart';
import 'Controller/ExpenseController/ExpenseController.dart';
import 'Controller/LoginController/LoginController.dart';
import 'Controller/NumberingSeriesCtrl/NumberingSeriesCtrler.dart';
import 'Controller/PaymentReceiptController/PayReceiptController.dart';
import 'Controller/PendingOrderController/PendingOrderController.dart';
import 'Controller/ReconciliationController/RecoController.dart';
import 'Controller/RefundsController/RefundController.dart';
import 'Controller/ReturnRegisterController/ReturnRegisterCtrl.dart';
import 'Controller/SalesInvoice/SalesInvoiceController.dart';
import 'Controller/SalesOrderController/SalesOrderController.dart';
import 'Controller/SalesQuotationController/SalesQuotationController.dart';
import 'Controller/SalesReturnController/SalesReturnController.dart';
import 'Controller/DepositController/DepositsController.dart';
import 'Controller/StockCheckController/StockCheckController.dart';
import 'Controller/StockInwardController/StockInwardContler.dart';
import 'Controller/StockListsController/StockListsController.dart';
import 'Controller/StockOutwardController/StockOutwardController.dart';
import 'Controller/SalesRegisterController/SalesRegisterCon.dart';
import 'Controller/StockReplenish/StockReplenishController.dart';
import 'DB Helper/DBOperation.dart';
import 'DB Helper/DBhelper.dart';
import 'DBModel/NotificationModel.dart';
import 'Models/Queues/Expense.dart';
import 'Models/Queues/PayReceiptQueue.dart';
import 'Models/Queues/RefundQueueModel.dart';
import 'Models/Queues/SalesOrderQueue.dart';
import 'Models/Queues/SalesQuotationqueue.dart';
import 'Models/Queues/SapConsumeQueue.dart';
import 'Models/Queues/Settlementqueue.dart';
import 'Models/Queues/StockInward.dart';
import 'Models/Queues/StockOutward.dart';
import 'Models/Queues/StockReq.dart';
import 'Models/Queues/Salesinvoice.dart';
import 'Models/Queues/SelesReturn.dart';
import 'Pages/DownloadPage/Screens.dart';
import 'Pages/LoginScreen/LoginScreen.dart';
import 'Themes/theme_manager.dart';
import 'l10n/l10n.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:dart_amqp/dart_amqp.dart' as am;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';

LocalNotificationService localNotificationService =
    new LocalNotificationService();

Configure config = Configure();
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  List<NotificationModel> notify = [];
  final Database db = (await DBHelper.getInstance())!;
  Configure config2 = Configure();

  if (message.notification!.android!.imageUrl != null) {
    notify.add(NotificationModel(
      docEntry: 0,
      titile: message.notification!.title,
      description: message.notification!.body!,
      receiveTime: config2.currentDate(),
      seenTime: '0',
      imgUrl: message.notification!.android!.imageUrl.toString(),
      naviScn: 'null',
    ));
    await DBOperation.insertNotification(notify, db);
  } else {
    notify.add(NotificationModel(
      docEntry: 0,
      titile: message.notification!.title,
      description: message.notification!.body!,
      receiveTime: config2.currentDate(),
      seenTime: '0',
      imgUrl: 'null',
      naviScn: 'null',
    ));
    await DBOperation.insertNotification(notify, db);
  }
}

final firebaseMessaging = FirebaseMessaging.instance;

getFCM() async {
  String? tokenFCM = await getTokenn();
  log("FCM tocken: " + tokenFCM!);
}

Future<String?> getTokenn() async {
  return firebaseMessaging.getToken();
}

onReciveFCM() async {
  final Database dbs = (await DBHelper.getInstance())!;
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    List<NotificationModel> notify = [];

    if (message.notification != null) {
      localNotificationService.showNitification(
          titile: message.notification!.title,
          msg: message.notification!.body,
          message: message);

      if (message.notification!.android!.imageUrl != null) {
        notify.add(NotificationModel(
          docEntry: 0,
          titile: message.notification!.title,
          description: message.notification!.body!,
          receiveTime: config.currentDate(),
          seenTime: '0',
          imgUrl: message.notification!.android!.imageUrl.toString(),
          naviScn: 'null',
        ));
        DBOperation.insertNotification(notify, dbs);
      } else {
        notify.add(NotificationModel(
            docEntry: 0,
            titile: message.notification!.title,
            description: message.notification!.body!,
            receiveTime: config.currentDate(),
            seenTime: '0',
            imgUrl: 'null',
            naviScn: 'null'));
        DBOperation.insertNotification(notify, dbs);
      }
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  await Firebase.initializeApp();
  getFCM();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await localNotificationService.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(localNotificationService.channel);
  onReciveFCM();
  bool? isdonload = await SharedPref.getDatadonld();
  bool? isLog = await SharedPref.getLoggedINSP();
  await initializeService();
  await createDB();
  Provider.debugCheckInvalidValueType = null;

  runApp(MyApp(
    isLogged: isLog,
    isdonload: isdonload,
  ));
}

Future createDB() async {
  await DBHelper.getInstance().then((value) {
    log("Created...");
  });
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  timePeriod(service);
}

void timePeriod(ServiceInstance service) {
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "My App Service",
      content: "Updated at ${DateTime.now()}",
    );
  }

  String? device;

  service.invoke(
    'update',
    {
      "current_date": DateTime.now().toIso8601String(),
      "device": device,
    },
  );

  receivervb();
}

am.Consumer? consumer2;
am.Queue? queue;
am.Client? client;
am.Channel? channel;
String? qname;
int? consumercount;

Future<void> receivervb() async {
  String? ip = await getIP();
  String? branch = await getBranch();
  String? terminal = await getTerminal();
  String? sapPassword = await getSapPassword();
  String? sapUserName = await getSapUserName();
  if (ip != null &&
      ip != 'null' &&
      branch != null &&
      branch != 'null' &&
      terminal != null &&
      terminal != 'null' &&
      sapUserName != null &&
      sapUserName != 'null' &&
      sapPassword != null &&
      sapPassword != 'null') {
    AppConstant.ip = ip;
    AppConstant.branch = branch.toString();
    AppConstant.terminal = terminal.toString();
    AppConstant.sapPassword = sapPassword;
    AppConstant.sapUserName = sapUserName;
    am.ConnectionSettings settings = am.ConnectionSettings(
        host: "${AppConstant.ip.toString().trim()}",
        port: 5672,
        authProvider: am.PlainAuthenticator("buson", "BusOn123"));
    client = am.Client(settings: settings);

    Map<String, Object> data = {"Branch": UserValues.branch.toString()};

    channel = await client!.channel();

    queue = await channel!.queue(
        "Br_${AppConstant.branch.trim()}_${AppConstant.terminal.toString().trim()}",
        durable: true,
        arguments: data);

    await SharedPref.saveQeueName(queue!.name.toString());
    await SharedPref.saveConsumercount(queue!.consumerCount.toString());
    log("queue!.consumerCount::${queue!.consumerCount}");
    if (queue!.consumerCount == 0) {
      consumer2 = await queue!.consume();
      consumer2?.listen((am.AmqpMessage message) {
        log("Consume the rabbitm queue11");

        validateQueue(message);
      });
    } else if (queue!.consumerCount == 1) {
      consumer2?.listen((am.AmqpMessage message) {
        log("Consume the rabbitm queue222");
        log("datata22 : " + jsonDecode(message.payloadAsString).toString());
        validateQueue(message);
      });
    } else {
      await consumer2?.cancel();
      await channel?.close();
      await client?.close();
    }
  }
}

Future<String?> getIP() async {
  String? ip = await SharedPref.getHostDSP();
  return ip;
}

Future<String?> getBranch() async {
  String? branch = await SharedPref.getBranchSSP();
  return branch;
}

Future<String?> getTerminal() async {
  String? terminal = await SharedPref.getTerminal();
  return terminal;
}

Future<String?> getSapDBB() async {
  String? sapDataBase = await SharedPref.getSapDB();
  return sapDataBase;
}

Future<String?> getSapUserName() async {
  String? sapDataBase = await SharedPref.getSapUserName();
  return sapDataBase;
}

Future<String?> getSapPassword() async {
  String? sapDataBase = await SharedPref.getSapPassword();
  return sapDataBase;
}

Future<String?> getSlpCode() async {
  String? slpCodee = await SharedPref.getslpCode();
  return slpCodee;
}

void validateQueue(AmqpMessage message) async {
  var data = jsonDecode(message.payloadAsString);

  if (data["ObjectType"] == 1) {
    if (data["ActionType"] == 'Update') {
      await updateInvoice(message);
    } else if (data["ActionType"] == 'Add') {
      await salesInvoice(message);
    }
  } else if (data["ObjectType"] == 2) {
    if (data["ActionType"] == 'Update') {
      log("Return updated");
      await updateReturn(message);
    } else if (data["ActionType"] == 'Add') {
      log("Return Added");

      await salesReturn(message);
    }
  } else if (data["ObjectType"] == 10) {
    if (data["ActionType"] == 'Update') {
      await updateSalesOrder(message);
    }
    if (data["ActionType"] == 'Edit') {
      await updateSalesOrder(message);
    } else if (data["ActionType"] == 'Add') {
      await salesOrder(message);
    }
  } else if (data["ObjectType"] == 14) {
    if (data["ActionType"] == 'Update') {
      await updatesalesQuotation(message);
    }
    if (data["ActionType"] == 'Edit') {
      await updatesalesQuotation(message);
    } else if (data["ActionType"] == 'Add') {
      salesQuotation(message);
    }
  } else if (data["ObjectType"] == 7) {
    if (data["ActionType"] == 'Update') {
      await updatePayReceipt(message);
    } else if (data["ActionType"] == 'Add') {
      paymentReceipt(message);
    }
  } else if (data["ObjectType"] == 19) {
    if (data["ActionType"] == 'Update') {
      await updateRefund(message);
    } else if (data["ActionType"] == 'Add') {
      await refund(message);
    }
  } else if (data["ObjectType"] == 4) {
    if (data["ActionType"] == 'Update') {
      await updateStockReq(message);
    } else if (data["ActionType"] == 'Add') {
      await stockRequest(message);
    }
  } else if (data["ObjectType"] == 5) {
    if (data["ActionType"] == 'Update') {
      log("data ActionType111::${data["ActionType"]}");
      await updateOutward(message);
    } else if (data["ActionType"] == 'Add') {
      log("data ActionType222::${data["ActionType"]}");
      await stkAddOutward(message);
    }
  } else if (data["ObjectType"] == 6) {
    if (data["ActionType"] == 'Update') {
      await updateINward(message);
    } else if (data["ActionType"] == 'Add') {
      await stkInward(message);
    }
  } else if (data["ObjectType"] == 8) {
    if (data["ActionType"] == 'Update') {
      await updateExpense(message);
      (message);
    } else if (data["ActionType"] == 'Add') {
      await expense(message);
    }
  } else if (data["ObjectType"] == 9) {
    if (data["ActionType"] == 'Update') {
      await updateSettlement(message);
    } else if (data["ActionType"] == 'Add') {
      await settlement(message);
    }
  }
}

expense(message) async {
  final Database db = (await DBHelper.getInstance())!;
  ExpenseQueue salerequest =
      ExpenseQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "Expense",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertExpense(db, salerequest.salesHeader);
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'Expense');
    } else {
      await DBOperation.updtQstatus(
          db, int.parse(salerequest.salesHeader[0].docentry!), 'Expense');
    }
  }
}

updateExpense(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'Expense');
    } else {
      ExpenseController expense = new ExpenseController();
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'Expense');
      expense.postRabitMqExpense2(int.parse(updateData.transId!.toString()));
    }
  } catch (e) {}
}

stkInward(message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockInward stockinw =
      StockInward.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockInHeaderDB",
      int.parse(stockinw.salesHeader[0].docentry.toString()),
      stockinw.salesHeader[0].branch!,
      stockinw.salesHeader[0].terminal);

  if (alrdyhv! < 1) {
    await DBOperation.insertStockInheader(db, stockinw.salesHeader);
    await DBOperation.insertStInLine(db, stockinw.salesLine);
    await DBOperation.insertStInBatch(db, stockinw.stInbatch);
  } else {
    if (stockinw.salesHeader[0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          stockinw.salesHeader[0].sapDocentry!,
          stockinw.salesHeader[0].sapDocNo!,
          int.parse(stockinw.salesHeader[0].docentry.toString()),
          'StockInHeaderDB');
    } else {
      await DBOperation.updtQstatus(
          db, int.parse(stockinw.salesHeader[0].docentry!), 'StockInHeaderDB');
    }
  }
}

updateINward(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'StockInHeaderDB');
    } else {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'StockInHeaderDB');
      List<Map<String, Object?>> getStInDetails =
          await DBOperation.getRabitMqStInDetails(
              db, int.parse(updateData.transId!.toString()));
      await updateInWrdStkSnaptab(int.parse(updateData.transId!.toString()),
          int.parse(getStInDetails[0]["baseDocentry"].toString()));
    }
  } catch (e) {}
}

stkAddOutward(message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockOutward salerequest =
      StockOutward.fromjson(jsonDecode(message.payloadAsString));
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockOutHeaderDataDB",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertStockOutheader(db, salerequest.salesHeader);
    await DBOperation.insertStOutLine(db, salerequest.salesLine);
    await DBOperation.insertStOutBatch(db, salerequest.stoutBatchlist);
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'StockOutHeaderDataDB');
    } else {
      await DBOperation.updtQstatus(
          db,
          int.parse(salerequest.salesHeader[0].docentry!),
          'StockOutHeaderDataDB');
    }
  }
}

updateOutward(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'StockOutHeaderDataDB');
    } else {
      StockOutwardController stOut = new StockOutwardController();

      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'StockOutHeaderDataDB');
      List<Map<String, Object?>> getStOutDetails =
          await DBOperation.getRabitMqStOutDetails(
              db, updateData.transId!.toString());

      await updateOutWrdStkSnaptab(int.parse(updateData.transId!.toString()),
          int.parse(getStOutDetails[0]["baseDocentry"].toString()));

      await stOut.PostRabitMq2(
          int.parse(updateData.transId!.toString()),
          getStOutDetails[0]["baseDocentry"].toString(),
          getStOutDetails[0]["reqfromWhs"].toString());
    }
  } catch (e) {}
}

stockRequest(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  StockRequest salerequest =
      StockRequest.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "StockReqHDT",
      int.parse(salerequest.salesHeader![0].docentry.toString()),
      salerequest.salesHeader![0].branch!,
      salerequest.salesHeader![0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertStkReq(db, salerequest.salesHeader!);
    await DBOperation.insertStkReqLin(db, salerequest.salesLine!,
        int.parse(salerequest.salesHeader![0].docentry!));
  } else {
    if (salerequest.salesHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          salerequest.salesHeader![0].sapDocentry!,
          salerequest.salesHeader![0].sapDocNo!,
          int.parse(salerequest.salesHeader![0].docentry.toString()),
          'StockReqHDT');
    } else {
      await DBOperation.updtQstatus(
          db, int.parse(salerequest.salesHeader![0].docentry!), 'StockReqHDT');
    }
  }
}

updateStockReq(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'StockReqHDT');
    } else {
      StockReqController stockReq = new StockReqController();
      String? whsCode = await DBOperation.getStockReqWhsCode(
          db, int.parse(updateData.transId!.toString()));

      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'StockReqHDT');
      stockReq.postRabitMqStockReq2(
          int.parse(updateData.transId!.toString()), whsCode.toString());
    }
  } catch (e) {
    log(e.toString());
  }
}

salesReturn(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  SalesRetrun saleret =
      SalesRetrun.fromjson(jsonDecode(message.payloadAsString));
  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesReturnHeader",
      int.parse(saleret.salesHeader![0].docentry.toString()),
      saleret.salesHeader![0].branch!,
      saleret.salesHeader![0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleReturnheader(db, saleret.salesHeader!);
    await DBOperation.insertSalesReturnLine(
        db, saleret.salesLine!, int.parse(saleret.salesHeader![0].docentry!));
  } else {
    if (saleret.salesHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          int.parse(saleret.salesHeader![0].sapDocentry!),
          int.parse(saleret.salesHeader![0].sapDocNo!),
          int.parse(saleret.salesHeader![0].docentry.toString()),
          'SalesReturnHeader');
    } else {
      await DBOperation.updtQstatus(
        db,
        int.parse(saleret.salesHeader![0].docentry!),
        'SalesReturnHeader',
      );
    }
  }
}

updateReturn(AmqpMessage message) async {
  List<SyncData> syncData1 = [];

  final Database db = (await DBHelper.getInstance())!;

  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      log("updateData.docEntryis null");
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'SalesReturnHeader');
    } else {
      List<Map<String, Object?>> getdbSaleretheader1 =
          await DBOperation.getSalesRetHeadDB(db, updateData.transId);
      log("updateData.docEntryisNot null::${updateData.docEntry}");
      SalesReturnController salesRet = new SalesReturnController();
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesReturnHeader');
      updateRetStkSnaptab(updateData.transId!);
      await salesRet.postRabitMqSalesRet2(
          int.parse(updateData.transId!.toString()),
          getdbSaleretheader1[0]['basedocentry'].toString());
    }
  } catch (e) {
    log(e.toString());
  }
}

salesQuotation(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;

  SalesQuotationQueue saleQuotation =
      SalesQuotationQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesQuotationHeader",
      int.parse(saleQuotation.salesQuotHeader![0].docentry.toString()),
      saleQuotation.salesQuotHeader![0].branch!,
      saleQuotation.salesQuotHeader![0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleQuoheader(db, saleQuotation.salesQuotHeader!);
    await DBOperation.insertSalesQuoLine(db, saleQuotation.salesQuotLine!,
        int.parse(saleQuotation.salesQuotHeader![0].docentry!));
  } else {
    if (saleQuotation.salesQuotHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          saleQuotation.salesQuotHeader![0].sapDocentry!,
          saleQuotation.salesQuotHeader![0].sapDocNo!,
          int.parse(saleQuotation.salesQuotHeader![0].docentry.toString()),
          'SalesQuotationHeader');
    } else {
      await DBOperation.updtQstatus(
          db,
          int.parse(saleQuotation.salesQuotHeader![0].docentry!),
          'SalesQuotationHeader');
    }
  }
}

updatesalesQuotation(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    log("updateData: doc: " + updateData.docEntry.toString());

    SalesQuotationCon salesQuot = new SalesQuotationCon();

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'SalesQuotationHeader');
    } else if (updateData.docEntry != null && updateData.actionType == "Edit") {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesQuotationHeader');
      await salesQuot.pushRabiMqSO2(int.parse(updateData.transId!.toString()));
    } else if (updateData.actionType == "Update") {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesQuotationHeader');
      await salesQuot.pushRabiMqSO2(int.parse(updateData.transId!.toString()));
    }
  } catch (e) {
    log(e.toString());
  }
}

salesOrder(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;

  SalesOrderQueue saleinvc =
      SalesOrderQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesOrderHeader",
      int.parse(saleinvc.salesOrderHeader![0].docentry.toString()),
      saleinvc.salesOrderHeader![0].branch!,
      saleinvc.salesOrderHeader![0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleOrderheader(db, saleinvc.salesOrderHeader!);
    await DBOperation.insertSalesOrderLine(db, saleinvc.salesOrderLine!,
        int.parse(saleinvc.salesOrderHeader![0].docentry!));
    await DBOperation.insertSalesOrderPay(db, saleinvc.salesOrderPayDB!,
        int.parse(saleinvc.salesOrderHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesOrderHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          saleinvc.salesOrderHeader![0].sapDocentry!,
          saleinvc.salesOrderHeader![0].sapDocNo!,
          int.parse(saleinvc.salesOrderHeader![0].docentry.toString()),
          'SalesOrderHeader');
    } else {
      await DBOperation.updtQstatus(
          db,
          int.parse(saleinvc.salesOrderHeader![0].docentry!),
          'SalesOrderHeader');
    }
  }
}

updateSalesOrder(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));
    SOCon salesOrder = new SOCon();

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'SalesOrderHeader');
    } else if (updateData.docEntry != null && updateData.actionType == "Edit") {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesOrderHeader');
      await salesOrder.pushRabiMqSO2(int.parse(updateData.transId!.toString()));
    } else if (updateData.docEntry != null &&
        updateData.actionType == "Update") {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesOrderHeader');
      await salesOrder.pushRabiMqSO2(int.parse(updateData.transId!.toString()));
    }
  } catch (e) {
    log(e.toString());
  }
}

salesInvoice(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  SalesInvoice saleinvc =
      SalesInvoice.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "SalesHeader",
      int.parse(saleinvc.salesHeader![0].docentry.toString()),
      saleinvc.salesHeader![0].branch!,
      saleinvc.salesHeader![0].terminal);
  if (alrdyhv! < 1) {
    await DBOperation.insertSaleheader(db, saleinvc.salesHeader!);
    await DBOperation.insertSalesLine(
        db, saleinvc.salesLine!, int.parse(saleinvc.salesHeader![0].docentry!));
    await DBOperation.insertSalesPay(db, saleinvc.salesPayDB!,
        int.parse(saleinvc.salesHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          saleinvc.salesHeader![0].sapDocentry!,
          saleinvc.salesHeader![0].sapDocNo!,
          int.parse(saleinvc.salesHeader![0].docentry.toString()),
          'SalesHeader');
    } else {
      await DBOperation.updtQstatus(
          db, int.parse(saleinvc.salesHeader![0].docentry!), 'SalesHeader');
    }
  }
}

updateInvoice(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'SalesHeader');
    } else {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'SalesHeader');
      await updateInvStkSnaptab(updateData.transId!);
    }
  } catch (e) {
    log(e.toString());
  }
}

settlement(message) async {
  final Database db = (await DBHelper.getInstance())!;
  DepositQueue salerequest =
      DepositQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "tableDepositHeader",
      int.parse(salerequest.salesHeader[0].docentry.toString()),
      salerequest.salesHeader[0].branch!,
      salerequest.salesHeader[0].terminal);

  if (alrdyhv! < 1) {
    await DBOperation.insertDepositHeader(db, salerequest.salesHeader);
    await DBOperation.insertDepositLine(db, salerequest.salesLine,
        int.parse(salerequest.salesHeader[0].docentry.toString()));
  } else {
    if (salerequest.salesHeader[0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          salerequest.salesHeader[0].sapDocentry!,
          salerequest.salesHeader[0].sapDocNo!,
          int.parse(salerequest.salesHeader[0].docentry.toString()),
          'tableDepositHeader');
    } else {
      await DBOperation.updtQstatus(
          db,
          int.parse(salerequest.salesHeader[0].docentry!.toString()),
          'tableDepositHeader');
    }
  }
}

updateSettlement(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'tableDepositHeader');
    } else {
      List<Map<String, Object?>> getDBSettlementHeader =
          await DBOperation.getDepositHeadDB(
              db, int.parse(updateData.transId!.toString()));

      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'tableDepositHeader');
    }
  } catch (e) {}
}

paymentReceipt(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  ReceiptQueue saleinvc =
      ReceiptQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "ReceiptHeader",
      int.parse(saleinvc.salesHeader![0].docentry.toString()),
      saleinvc.salesHeader![0].branch!,
      saleinvc.salesHeader![0].terminal);

  if (alrdyhv! < 1) {
    await DBOperation.insertRecieptHeader(db, saleinvc.salesHeader!);
    await DBOperation.insertRecieptLine(db, saleinvc.salesLine!,
        int.parse(saleinvc.salesHeader![0].docentry!.toString()));
    await DBOperation.insertReciepLine2(db, saleinvc.salesPayDB!,
        int.parse(saleinvc.salesHeader![0].docentry.toString()));
  } else {
    if (saleinvc.salesHeader![0].sapDocentry != null) {
      await DBOperation.updtSapDetSalHead(
          db,
          saleinvc.salesHeader![0].sapDocentry!,
          saleinvc.salesHeader![0].sapDocNo!,
          int.parse(saleinvc.salesHeader![0].docentry.toString()),
          'ReceiptHeader');
    } else {
      await DBOperation.updtQstatus(
          db,
          int.parse(saleinvc.salesHeader![0].docentry!.toString()),
          'ReceiptHeader');
    }
  }
}

updatePayReceipt(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'ReceiptHeader');
      await DBOperation.getReceiptHeaderDB(db, updateData.transId!);
    } else {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'ReceiptHeader');
    }
  } catch (e) {}
}

refund(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  RefundQueue saleinvc =
      RefundQueue.fromjson(jsonDecode(message.payloadAsString));

  int? alrdyhv = await DBOperation.getDocAldy(
      db,
      "docentry",
      "RefundHeader",
      int.parse(saleinvc.refundHeader![0].docentry.toString()),
      saleinvc.refundHeader![0].branch!,
      saleinvc.refundHeader![0].terminal);

  if (alrdyhv! < 1) {
    await DBOperation.insertRefundHeader(db, saleinvc.refundHeader!);
    await DBOperation.insertRefundLine(db, saleinvc.refundLine!,
        int.parse(saleinvc.refundHeader![0].docentry!.toString()));
    await DBOperation.insertRefundPay(db, saleinvc.refundPayDB!,
        int.parse(saleinvc.refundHeader![0].docentry.toString()));
  } else {
    await DBOperation.updtQstatus(
        db,
        int.parse(saleinvc.refundHeader![0].docentry!.toString()),
        'RefundHeader');
  }
}

updateInvStkSnaptab(int docentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDBSalesHeader =
      await DBOperation.getSalesHeaderDB(db, docentry);
  List<Map<String, Object?>> getDBSalesLine = await DBOperation.holdSalesLineDB(
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

        int stksnpqty = int.parse(serialbatchCheck[ij]['quantity'].toString()) -
            int.parse(getDBSalesLine[i]['quantity'].toString());

        stkSnpValues.add(StockSnapTModelDB(
          uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
          taxCode: serialbatchCheck[ij]['taxCode'].toString(),
          uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
              ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
              : 0,
          uSpecificGravity: serialbatchCheck[ij]['uSpecificGravity'].toString(),
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
          uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
        ));

        await DBOperation.updateStkSnap(db, stkSnpValues, ij);
      }
    }
  }
}

updateRetStkSnaptab(int docentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDBSalesHeader =
      await DBOperation.getSalesRetHeadDB(db, docentry);
  List<Map<String, Object?>> getDBSalesLine =
      await DBOperation.grtSalesRetLineDB(
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

        int stksnpqty = int.parse(serialbatchCheck[ij]['quantity'].toString()) +
            int.parse(getDBSalesLine[i]['quantity'].toString());

        stkSnpValues.add(StockSnapTModelDB(
          uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
          uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
          taxCode: serialbatchCheck[ij]['taxCode'].toString(),
          uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
              ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
              : 0,
          uSpecificGravity: serialbatchCheck[ij]['uSpecificGravity'].toString(),
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

updateOutWrdStkSnaptab(int docentry, int baseDocentry) async {
  final Database db = (await DBHelper.getInstance())!;

  List<Map<String, Object?>> getDB_StoutHeader =
      await DBOperation.getStockOutHeader(db, docentry);

  List<Map<String, Object?>> getDB_StOutBatch =
      await DBOperation.getStockOutBatch(db, docentry, baseDocentry.toString());
  if (UserValues.branch == AppConstant.branch) {
    for (int i = 0; i < getDB_StOutBatch.length; i++) {
      List<Map<String, Object?>> serialbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              getDB_StOutBatch[i]['serialBatch'].toString(),
              getDB_StOutBatch[i]['itemcode'].toString());
      log(getDB_StOutBatch[i]['serialBatch'].toString());

      for (int ij = 0; ij < serialbatchCheck.length; ij++) {
        if (getDB_StOutBatch[i]['serialBatch'].toString() ==
                serialbatchCheck[ij]['serialbatch'].toString() &&
            getDB_StOutBatch[i]['itemcode'].toString() ==
                serialbatchCheck[ij]['itemcode'].toString()) {
          List<StockSnapTModelDB> stkSnpValues = [];

          int stksnpqty =
              int.parse(serialbatchCheck[ij]['quantity'].toString()) -
                  int.parse(getDB_StOutBatch[i]['quantity'].toString());

          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
            uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchCheck[ij]['uSpecificGravity'].toString(),
            branch: serialbatchCheck[ij]['branch'].toString(),
            taxCode: serialbatchCheck[ij]['taxCode'].toString(),
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
            uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
          ));

          await DBOperation.updateStkSnap(db, stkSnpValues, ij);
        } else {
          log('not outward updated');
        }
      }
    }
  }
}

updateInWrdStkSnaptab(int docentry, int baseDocentry) async {
  final Database db = (await DBHelper.getInstance())!;
  List<Map<String, Object?>> getDB_StInHeader =
      await DBOperation.getStockInHeader(db, docentry);
  List<Map<String, Object?>> getDB_StInLine =
      await DBOperation.holdStInLineDB(db, baseDocentry, docentry);

  List<Map<String, Object?>> getDB_StInBatch =
      await DBOperation.getStockInBatch(db, baseDocentry, docentry);

  List<StockSnapTModelDB> stkSnpValues = [];
  if (getDB_StInHeader[0]['branch'] == AppConstant.branch) {
    for (int i = 0; i < getDB_StInBatch.length; i++) {
      List<Map<String, Object?>> serialbatchCheck =
          await DBOperation.serialBatchCheck(
              db,
              getDB_StInBatch[i]['serialBatch'].toString(),
              getDB_StInBatch[i]['itemcode'].toString());
      log(getDB_StInBatch[i]['serialBatch'].toString());

      if (serialbatchCheck.isNotEmpty) {
        for (int ij = 0; ij < serialbatchCheck.length; ij++) {
          if (getDB_StInBatch[i]['serialBatch'].toString() ==
                  serialbatchCheck[ij]['serialbatch'].toString() &&
              getDB_StInBatch[i]['itemcode'].toString() ==
                  serialbatchCheck[ij]['itemcode'].toString()) {
            int stksnpqty =
                int.parse(serialbatchCheck[ij]['quantity'].toString()) +
                    int.parse(getDB_StInBatch[i]['quantity'].toString());

            stkSnpValues.add(StockSnapTModelDB(
              uPackSize: serialbatchCheck[ij]['uPackSize'].toString(),
              uPackSizeuom: serialbatchCheck[ij]['UPackSizeUom'].toString(),
              uTINSPERBOX: serialbatchCheck[ij]['uTINSPERBOX'] != null
                  ? int.parse(serialbatchCheck[ij]['uTINSPERBOX'].toString())
                  : 0,
              uSpecificGravity:
                  serialbatchCheck[ij]['uSpecificGravity'].toString(),
              branch: serialbatchCheck[ij]['branch'].toString(),
              taxCode: serialbatchCheck[ij]['taxCode'].toString(),
              terminal: serialbatchCheck[ij]['terminal'].toString(),
              itemname: serialbatchCheck[ij]['itemname'].toString(),
              branchcode: serialbatchCheck[ij]['branchcode'].toString(),
              createdUserID:
                  int.parse(serialbatchCheck[ij]['createdUserID'].toString()),
              createdateTime: serialbatchCheck[ij]['createdateTime'].toString(),
              itemcode: serialbatchCheck[ij]['itemcode'].toString(),
              lastupdateIp: serialbatchCheck[ij]['lastupdateIp'].toString(),
              maxdiscount: serialbatchCheck[ij]['maxdiscount'].toString(),
              taxrate: 18.toString(),
              mrpprice: serialbatchCheck[ij]['mrpprice'].toString(),
              sellprice: serialbatchCheck[ij]['sellprice'].toString(),
              purchasedate: serialbatchCheck[ij]['purchasedate'].toString(),
              quantity: stksnpqty.toString(),
              serialbatch: serialbatchCheck[ij]['serialbatch'].toString(),
              snapdatetime: serialbatchCheck[ij]['snapdatetime'].toString(),
              specialprice: serialbatchCheck[ij]['specialprice'].toString(),
              updatedDatetime:
                  serialbatchCheck[ij]['updatedDatetime'].toString(),
              updateduserid:
                  int.parse(serialbatchCheck[ij]['updateduserid'].toString()),
              liter: double.parse(serialbatchCheck[ij]['liter'].toString()),
              weight: double.parse(serialbatchCheck[ij]['weight'].toString()),
            ));

            await DBOperation.updateStkSnap(db, stkSnpValues, ij);
          }
        }
      } else {
        List<Map<String, Object?>> serialbatchItemCheck = [];
        await DBOperation.itemmastercheckitemcode(
            db, getDB_StInBatch[i]['itemcode'].toString());

        if (serialbatchItemCheck.isNotEmpty) {
          stkSnpValues.add(StockSnapTModelDB(
            uPackSize: serialbatchItemCheck[0]['UPackSize'] == null
                ? ''
                : serialbatchItemCheck[0]['UPackSize'].toString(),
            uTINSPERBOX: serialbatchItemCheck[0]['UTINSPERBOX'] != null
                ? int.parse(serialbatchItemCheck[0]['UTINSPERBOX'].toString())
                : 0,
            uSpecificGravity:
                serialbatchItemCheck[0]['USpecificGravity'].toString(),
            branch: AppConstant.branch,
            terminal: AppConstant.terminal.toString(),
            itemname: serialbatchItemCheck[0]['itemname_short'].toString(),
            branchcode: serialbatchItemCheck[0]['branchcode'].toString(),
            taxCode: serialbatchItemCheck[0]['taxCode'].toString(),
            createdUserID: UserValues.userID,
            createdateTime: config.currentDate(),
            itemcode: serialbatchItemCheck[0]['Itemcode'].toString(),
            lastupdateIp: UserValues.lastUpdateIp,
            maxdiscount: serialbatchItemCheck[0]['maxdiscount'].toString(),
            taxrate: serialbatchItemCheck[0]['taxrate'].toString(),
            mrpprice: serialbatchItemCheck[0]['mrpprice'].toString(),
            sellprice: serialbatchItemCheck[0]['sellprice'].toString(),
            purchasedate: serialbatchItemCheck[0]['purchasedate'].toString(),
            quantity: getDB_StInBatch[i]['quantity'].toString(),
            serialbatch: getDB_StInBatch[i]['serialBatch'].toString(),
            snapdatetime: serialbatchItemCheck[0]['snapdatetime'].toString(),
            specialprice: serialbatchItemCheck[0]['specialprice'].toString(),
            updatedDatetime: config.currentDate(),
            updateduserid: UserValues.userID,
            liter: serialbatchItemCheck[0]['liter'] != null
                ? double.parse(serialbatchItemCheck[0]['liter'].toString())
                : 0,
            weight: serialbatchItemCheck[0]['weight'] != null
                ? double.parse(serialbatchItemCheck[0]['weight'].toString())
                : 0,
            uPackSizeuom: serialbatchItemCheck[0]['UPackSizeUom'].toString(),
          ));
          await DBOperation.insertStockSnap(db, stkSnpValues);

          List<Map<String, Object?>> serialbatchCheck =
              await DBOperation.serialBatchCheck(
                  db,
                  stkSnpValues[0].serialbatch.toString(),
                  stkSnpValues[0].itemcode.toString());
        }
      }
    }
  }
}

updateRefund(AmqpMessage message) async {
  final Database db = (await DBHelper.getInstance())!;
  try {
    SapConsumeQueue updateData =
        SapConsumeQueue.fromjson(jsonDecode(message.payloadAsString));

    if (updateData.docEntry == null) {
      await DBOperation.updtExcepSapDetSalHead(db, updateData.transId!,
          updateData.errorMessage!.replaceAll("'", ""), 'RefundHeader');
    } else {
      await DBOperation.updtSapDetSalHead(db, updateData.docEntry!,
          updateData.docNumber!, updateData.transId!, 'RefundHeader');
    }
  } catch (e) {}
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.isLogged, required this.isdonload});
  bool? isLogged;
  bool? isdonload;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if ((widget.isLogged == null || widget.isLogged == false) &&
        (widget.isdonload == null || widget.isdonload == false)) {
      log("aaaaa");
      DefaultCacheManager().emptyCache();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeManager(),
        ),
        ChangeNotifierProvider(create: (_) => DashBoardController()),
        ChangeNotifierProvider(create: (_) => StockReqController()),
        ChangeNotifierProvider(create: (_) => StockOutwardController()),
        ChangeNotifierProvider(create: (_) => StockInwrdController()),
        ChangeNotifierProvider(create: (_) => ExpenseController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => DownLoadController()),
        ChangeNotifierProvider(create: (_) => DepositsController()),
        ChangeNotifierProvider(create: (_) => SalesQuotationCon()),
        ChangeNotifierProvider(create: (_) => SOCon()),
        ChangeNotifierProvider(create: (_) => PosController()),
        ChangeNotifierProvider(create: (_) => SalesReturnController()),
        ChangeNotifierProvider(create: (_) => PayreceiptController()),
        ChangeNotifierProvider(create: (_) => PendingOrderController()),
        ChangeNotifierProvider(create: (_) => PayreceiptController()),
        ChangeNotifierProvider(create: (_) => StRegCon()),
        ChangeNotifierProvider(create: (_) => CustomerController()),
        ChangeNotifierProvider(create: (_) => RetnRegCon()),
        ChangeNotifierProvider(create: (_) => CashStateCon()),
        ChangeNotifierProvider(create: (_) => ApiSettingsController()),
        ChangeNotifierProvider(create: (_) => StockReplenishController()),
        ChangeNotifierProvider(create: (_) => StockCheckController()),
        ChangeNotifierProvider(create: (_) => StockController()),
        ChangeNotifierProvider(create: (_) => ReportController()),
        ChangeNotifierProvider(create: (_) => NumberSeriesCtrl()),
        ChangeNotifierProvider(
          create: (_) => TransactionSyncController(),
        ),
        ChangeNotifierProvider(create: (_) => RefundController()),
        ChangeNotifierProvider(create: (_) => ReconciliationCtrl()),
        ChangeNotifierProvider(create: (_) => LogoutCtrl()),
        ChangeNotifierProvider(create: (_) => IncomingReportCtrl()),
        ChangeNotifierProvider(create: (_) => DepositReportCtrlrs()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: false,
          primarySwatch: Colors.blue,
          fontFamily: 'NunitoRegular',
        ),
        home: (widget.isLogged == null || widget.isLogged == false) &&
                (widget.isdonload == null || widget.isdonload == false)
            ? LoginScreen()
            : (widget.isLogged != null && widget.isLogged != false) &&
                    (widget.isdonload != null && widget.isdonload != false)
                ? DashBoardScreen()
                : DownloadScreen(),
        supportedLocales: L10n.all,
        getPages: Routes.allRoutes,
      ),
    );
  }
}
