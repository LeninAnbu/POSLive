import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:posproject/Models/QueryUrlModel/DepositsQueryModel/depositsaccmodel.dart';
import 'package:posproject/Models/QueryUrlModel/DepositsQueryModel/depositsdetModel.dart';
import 'package:posproject/Models/QueryUrlModel/NewCashAccount.dart';
import 'package:posproject/Models/QueryUrlModel/cashinhandmodel.dart';
import 'package:posproject/Service/NewCashAccountApi.dart';
import 'package:posproject/Service/QueryURL/DepositsQuery/cashinhandapi.dart';
import 'package:posproject/Service/QueryURL/DepositsQuery/depositsAccApi.dart';
import 'package:posproject/Service/QueryURL/DepositsQuery/depositsDetailsQuery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'package:posproject/Constant/ConstantRoutes.dart';
import 'package:posproject/DBModel/SettlementLineDBModel.dart';
import 'package:posproject/Models/ListMOdelsettled/Modelclasssettled.dart';

import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/Screen.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/SettlementHeader.dart';
import '../../Models/DataModel/CardModel/CardDataModel.dart';
import '../../Models/QueryUrlModel/DepositsQueryModel/ChequeDepositModel.dart';
import '../../Models/QueryUrlModel/DepositsQueryModel/DepositQryModel.dart';
import '../../Models/QueryUrlModel/cashcardaccountsModel.dart';
import '../../Models/ServiceLayerModel/BankListModel/BankListsModels.dart';
import '../../Service/QueryURL/DepositsQuery/CashDepositQueryApi.dart';
import '../../Service/QueryURL/DepositsQuery/ChequeDeposits.dart';
import '../../Service/QueryURL/cashcardaccountdetailsApi.dart';
import '../../ServiceLayerAPIss/BankListApi/BankListsApi.dart';
import '../../ServiceLayerAPIss/Deposits/postdepositapi.dart';
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';

class DepositsController extends ChangeNotifier {
  Configure config = Configure();

  init(BuildContext context) async {
    clearAllData();
    await callDepositDetailsApi();

    // await callDepositsApi();
    await callBankmasterApi(context);
    await callCashCardAccApi();
    await callDepositsAccApi();
    await callNewCashAccountApi();
    notifyListeners();
  }

  List<NewCashCardAccDetailData> newCashAcc = [];
  callNewCashAccountApi() async {
    newCashAcc = [];
    await NewCashCardAccountAPi.getGlobalData(AppConstant.branch).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
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
  NewCashAccSelect(value) async {
    log('value:::${value}');
    for (var i = 0; i < newCashAcc.length; i++) {
      if (newCashAcc[i].uAcctName == value) {
        if (newCashAcc[i].uMode == 'CASH') {
          cashAccCode = newCashAcc[i].uAcctCode.toString();
          await callCashInHandApi(cashAccCode.toString());
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

  List<DepositQueryData> activitiesData = [];

  callDepositsApi() {
    activitiesData = [];
    double netamtt = 0;
    DepositsQueryAPi.getGlobalData(AppConstant.branch).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        activitiesData = value.activitiesData!;

        if (activitiesData.isNotEmpty) {
          for (var i = 0; i < activitiesData.length; i++) {
            mycontroller[4].text = activitiesData[i].cashBal.toString();

            netamtt = activitiesData[i].cashBal +
                activitiesData[i].cardBal +
                activitiesData[i].chequeBal +
                activitiesData[i].walletBal;
          }
          notifyListeners();
        }
        mycontroller[1].text = netamtt.toString();
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<DepositAccountQueryData> acountData = [];
  callDepositsAccApi() async {
    acountData = [];
    await DepositsAccQueryAPi.getGlobalData(AppConstant.branch).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        acountData = value.data;
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  List<CashInHandModelData> cashInHandData = [];
  callCashInHandApi(String accCode) async {
    mycontroller[4].text = '';
    cashInHandData = [];
    await CashInHandQueryAPi.getGlobalData(accCode).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cashInHandData = value.activitiesData!;

        mycontroller[4].text = cashInHandData[0].currentTotal.toString();
        log(' mycontroller[0].text::${mycontroller[0].text}');
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  var preff = SharedPreferences.getInstance();

  sapLoginApi(BuildContext context) async {
    final pref2 = await preff;
    await PostInvoiceLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          pref2.setString("sessionId", value.sessionId.toString());
          pref2.setString("sessionTimeout", value.sessionTimeout.toString());
          await getSession();
        }
      } else if (value.stCode! >= 400 && value.stCode! <= 410) {
        Get.defaultDialog(
            title: 'Alert',
            titleStyle: TextStyle(color: Colors.red),
            middleText:
                "${value.error!.message!.value}\nCheck Your Sap Details !!..",
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Close'))
            ]);
        // if (value.error!.code != null) {
        //   final snackBar = SnackBar(
        //     behavior: SnackBarBehavior.floating,
        //     margin: EdgeInsets.only(
        //       bottom: Screens.bodyheight(context) * 0.3,
        //     ),
        //     duration: const Duration(seconds: 4),
        //     backgroundColor: Colors.red,
        //     content: Text(
        //       "${value.error!.message!.value}\nCheck Your Sap Details !!..",
        //       style: const TextStyle(color: Colors.white),
        //     ),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
        //   Future.delayed(const Duration(seconds: 5), () {
        //     exit(0);
        //   });
        // }
      } else if (value.stCode == 500) {
        Get.defaultDialog(
            title: 'Alert',
            titleStyle: TextStyle(color: Colors.red),
            middleText: "${value.exception}\nCheck Your Sap Details !!..",
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Close'))
            ]);
        // final snackBar = SnackBar(
        //   behavior: SnackBarBehavior.floating,
        //   margin: EdgeInsets.only(
        //     bottom: Screens.bodyheight(context) * 0.3,
        //   ),
        //   duration: const Duration(seconds: 4),
        //   backgroundColor: Colors.red,
        //   content: const Text(
        //     "Opps Something went wrong !!..",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Get.defaultDialog(
            title: 'Alert',
            titleStyle: TextStyle(color: Colors.red),
            middleText: "${value.exception}\nCheck Your Sap Details !!..",
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Close'))
            ]);
        // final snackBar = SnackBar(
        //   behavior: SnackBarBehavior.floating,
        //   margin: EdgeInsets.only(
        //     bottom: Screens.bodyheight(context) * 0.3,
        //   ),
        //   duration: const Duration(seconds: 4),
        //   backgroundColor: Colors.red,
        //   content: const Text(
        //     "Opps Something went wrong !!..",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // );
        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  getSession() async {
    var preff = await SharedPreferences.getInstance();
    AppConstant.sapSessionID = preff.getString('sessionId')!;
//log("  AppConstant.sapSessionID::${AppConstant.sapSessionID}");
    notifyListeners();
  }

  bool loadigBtn = false;
  bool loadigChequeBtn = false;

  List<BankListValue> bankList = [];
  String? selectedBankType;
  String selectbankCode = '';
  bool bankhintcolor = false;
  bool get getbankhintcolor => bankhintcolor;

  getSelectbankCode(BuildContext context, String value) {
    for (var i = 0; i < bankList.length; i++) {
      if (bankList[i].bankName == value) {
        selectbankCode = bankList[i].bankCode.toString();
        log('selectbankCode:::$selectedBankType');
        callChequeDepositsQueryApi(context, selectbankCode);
      }
      notifyListeners();
    }
    notifyListeners();
  }

  List<CashCardAccDetailData>? cardAccDetailaData;
//DepositsDetailsQueryAPi
//
  List<DepositDetailsQueryData> depositDetData = [];
  callDepositDetailsApi() async {
    double unsettle = 0;
    double settle = 0;
    double collection = 0;

    depositDetData = [];
    await DepositsDetailsQueryAPi.getGlobalData(AppConstant.branch)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        depositDetData = value.data;

        for (var i = 0; i < depositDetData.length; i++) {
          // if (depositDetData[i].acctName.toString() == "Cash in Hand (UB)") {
          mycontroller[7].text = depositDetData[i].collected.toString();
          mycontroller[8].text = depositDetData[i].setteled.toString();
          // mycontroller[4].text = depositDetData[i].unSettled.toString();
          // }
          unsettle = unsettle + (depositDetData[i].unSettled);
          collection = collection + (depositDetData[i].collected);
          settle = settle + (depositDetData[i].setteled);
          mycontroller[1].text = collection.toString();
          mycontroller[2].text = settle.toString();
          log('mycontroller[4].text ::${mycontroller[4].text}');
          mycontroller[3].text = unsettle.toString();
        }

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        notifyListeners();
      } else {}
    });
    notifyListeners();
  }

  callCashCardAccApi() async {
    cardAccDetailaData = [];
    await CashCardAccountAPi.getGlobalData(AppConstant.branch)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        cardAccDetailaData = value.activitiesData;
        notifyListeners();

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
      } else {}
    });
    notifyListeners();
  }

//ChequeDepositsQueryAPi
  List<ChequeDepositQueryData>? chequeQueryData = [];

  callChequeDepositsQueryApi(BuildContext context, String bankCode) async {
    chequeQueryData = [];
    loadigChequeBtn = true;
    await sapLoginApi(context);
    log('select bank type::$selectedBankType');
    await ChequeDepositsQueryAPi.getGlobalData(bankCode).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        chequeQueryData = value.activitiesData;
        for (var i = 0; i < chequeQueryData!.length; i++) {
          chequeQueryData![i].checkClr = false;
          chequeQueryData![i].onchanged = 1;
        }
        log('chequeQueryData length::${chequeQueryData!.length}');
        loadigChequeBtn = false;

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadigChequeBtn = false;

        notifyListeners();
      } else {
        Get.defaultDialog(title: 'Alert', content: Text('${value.error}'));

        loadigChequeBtn = false;
      }
    });
    notifyListeners();
  }

  callBankmasterApi(BuildContext context) async {
    loadigBtn = true;
    await sapLoginApi(context);
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
        loadigBtn = false;

        notifyListeners();
      } else if (value.stsCode >= 400 && value.stsCode <= 410) {
        loadigBtn = false;

        notifyListeners();
      } else {
        loadigBtn = false;
      }
    });
    notifyListeners();
  }

  reset() async {
    mycontroller[0].text = currentDate();
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> netAmout =
        await DBOperation.getNetCollectionAmtByDate(
            db, config.alignDate1(mycontroller[0].text));
    List<Map<String, Object?>> totalCash = await DBOperation.getTotalCashByDate(
        db, config.alignDate1(mycontroller[0].text), 'Cash');
    List<Map<String, Object?>> totalCard = await DBOperation.getTotalCashByDate(
        db, config.alignDate1(mycontroller[0].text), 'Card');
    List<Map<String, Object?>> totalcheque =
        await DBOperation.getTotalCashByDate(
            db, config.alignDate1(mycontroller[0].text), 'Cheque');

    List<Map<String, Object?>> totalSettledCheque =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Cheque');
    List<Map<String, Object?>> totalSettledCard =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Card');
    List<Map<String, Object?>> totalSettledCash =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Cash');
    List<Map<String, Object?>> totalNetSettled =
        await DBOperation.getTotalSettledByDate(db, mycontroller[0].text);
    await calculateNetAmount(netAmout);

    await calculateTotalCash(totalCash, 7);
    await calculateTotalCash(totalCard, 10);
    await calculateTotalCash(totalcheque, 13);

    await calculateSettleAmount(totalSettledCash, 8);
    await calculateSettleAmount(totalSettledCard, 11);
    await calculateSettleAmount(totalSettledCheque, 14);
    await calculateSettleAmount(totalNetSettled, 2);
    await calculateUnSettledAmt(
        double.parse(mycontroller[1].text), double.parse(mycontroller[2].text));
    notifyListeners();
  }

  PageController tappage = PageController(initialPage: 0);
  int tappageIndex = 0;
  Future<bool> onbackpress() async {
//log("objectaaaaaaaaaaaaaaaaaaa:::::" + tappageIndex.toString());
    if (tappageIndex == 0) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    } else {
      await tappage.animateToPage(--tappageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);

      mycontroller[0].clear();
      notifyListeners();
    }

    notifyListeners();

    return Future.value(false);
  }

  bool hintcolor = false;
  bool get gethintcolor => hintcolor;
  String? selectedType;

  final GlobalKey<FormState> fomkeySet = GlobalKey<FormState>();
  final GlobalKey<FormState> fomkeySet2 = GlobalKey<FormState>();
  final GlobalKey<FormState> cashform = GlobalKey<FormState>();
  final GlobalKey<FormState> cardform = GlobalKey<FormState>();

  final GlobalKey<FormState> cardvalidate = GlobalKey<FormState>();
  final GlobalKey<FormState> chequevalidate = GlobalKey<FormState>();

  String? tabcontroller;
  String? selectedIndex;

  List<TextEditingController> mycontroller =
      List.generate(100, (i) => TextEditingController());

  TextEditingController jurnelRemarks = TextEditingController();
  TextEditingController transactionID = TextEditingController();

  double receivedamount = 0.00;
  double settledamount = 0.00;
  List<Paylist> paylistdetails = [];
  List<CashList> cashsettled = [];
  List<CashList> finalcashsettled = [];
  List<CardList> cardsettled = [];
  List<CardList> cardsettled2 = [];
  List<CardList> finalcardsettled2 = [];
  List<CardList> finalcardsettled = [];
  List<ChequeList> chequesettled = [];
  List<ChequeList> chequesettled2 = [];
  List<ChequeList> finalchequesettled2 = [];
  List<ChequeList> finalchequesettled = [];
  List<Walletlist> walletsettled = [];
  List<Walletlist> finalwalletsettled = [];
  List<couponcodelist> couponsettled = [];
  List<couponcodelist> finalcouponsettled = [];
  double totalCheque = 0;
  String? forpayentry;
  String? chequeline;
  String? cardListMSG = "";
  bool iscardload = false;
  bool isload = false;
  bool iscouponload = false;
  String? nowaday;
  String? valuechoose;
  String? valuechooseAccNum;

  String? couponvaluechoose;
  String? walletvaluechoose;
  String? paytermvaluechoose;
  bool? valuefirst = true;
  List<CardModel> cardData = [];
  bool isSelectedAllCard = false;
  bool isSelectedAllCheque = false;

  clearAllData() {
    depositDetData = [];
    cashAcctype = null;
    cashAccCode = null;
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    onDisablebutton = false;

    mycontroller = List.generate(100, (i) => TextEditingController());
    tabcontroller = null;
    selectedIndex = null;
    hintcolor = false;
    loadigBtn = false;
    loadigChequeBtn = false;
    selectedType = null;
    paylistdetails = [];
    cashsettled = [];
    finalcashsettled = [];
    cardsettled = [];
    cardsettled2 = [];
    finalcardsettled2 = [];
    finalcardsettled = [];
    chequesettled = [];
    chequesettled2 = [];
    finalchequesettled2 = [];
    finalchequesettled = [];
    walletsettled = [];
    finalwalletsettled = [];
    couponsettled = [];
    finalcouponsettled = [];
    totalCheque = 0;
    forpayentry = null;
    chequeline = null;
    cardListMSG = "";
    iscardload = false;
    isload = false;
    iscouponload = false;
    nowaday = null;
    valuechoose = null;
    couponvaluechoose = null;
    walletvaluechoose = null;
    paytermvaluechoose = null;
    valuefirst = true;
    receivedamount = 0.00;
    settledamount = 0.00;
    isSelectedAllCard = false;
    isSelectedAllCheque = false;
    bankList = [];
    bankhintcolor = false;
    selectedBankType = null;
    selectbankCode = '';
    notifyListeners();
    mycontroller[0].text = currentDate();
  }

  clearTxtField() {
    transactionID.clear();
    jurnelRemarks.clear();
  }

  Future getinserttabular(String paymodetype) async {
    double netsettled = 0.00;

    double unsettled = 0.00;
    double? payamount = 0.00;
    double netsett = 0.00;

    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.getsaveinsertHeader(
            db, config.alignDate1(mycontroller[0].text));

    for (int i = 0; i < getDBholddata5.length; i++) {
      List<Map<String, Object?>> getDBforfirstpage =
          await DBOperation.getsaveinsert(db, paymodetype,
              getDBholddata5[i]["createdateTime"].toString().trim());

      for (int ik = 0; ik < getDBforfirstpage.length; ik++) {
//if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"]){
        if (paymodetype == "Cash") {
          double? mycontrol1;
          double? mycontrol2;
          double? cashcontrol = 0;
          netsett = 0.00;

          payamount = payamount! +
              double.parse(getDBforfirstpage[ik]["payamount"].toString());

          netsett = double.parse(getDBholddata5[i]["amountsettled"].toString());

          mycontroller[7].text = payamount.toString();

          mycontroller[8].text = netsett.toString();

          mycontrol1 = mycontroller[7].text.isEmpty
              ? 0.00
              : double.parse(mycontroller[7].text);
          mycontrol2 = mycontroller[8].text.isEmpty
              ? 0.00
              : double.parse(mycontroller[8].text);

          cashcontrol = mycontrol1 - mycontrol2;
          mycontroller[9].text = cashcontrol.abs().toString();
        }

        notifyListeners();

        if (paymodetype == "Card") {
          double? mycontrol3;
          double? mycontrol4;
          double? cardcontrol = 0.00;

          payamount = payamount! +
              double.parse(getDBforfirstpage[ik]["payamount"].toString());

          mycontroller[11].text = payamount.toString();
          mycontrol3 = double.parse(mycontroller[10].text);
          mycontrol4 = mycontroller[11].text.isEmpty
              ? 0.00
              : double.parse(mycontroller[11].text.toString());
          cardcontrol = mycontrol3 - mycontrol4;
          mycontroller[12].text = cardcontrol.abs().toString();
        }
        notifyListeners();
        if (paymodetype == "Cheque") {
          double? mycontrol5;
          double? mycontrol6;
          double? chequecontrol;

          payamount = payamount! +
              double.parse(getDBforfirstpage[ik]["payamount"].toString());

          mycontroller[13].text =
              payamount.toString().isEmpty ? "0" : payamount.toString();

          mycontroller[14].text = payamount.toString();
          mycontrol5 = double.parse(mycontroller[13].text);
          mycontrol6 = mycontroller[14].text.isEmpty
              ? 0
              : double.parse(mycontroller[14].text.toString());
          chequecontrol = mycontrol5 - mycontrol6;
          mycontroller[15].text = chequecontrol.abs().toString();
        }
        notifyListeners();
        if (paymodetype == "Wallet") {
          int? mycontrol7;
          int mycontrol8;
          int? walletcontrol = 0;

          mycontroller[19].text =
              getDBforfirstpage[i]["commissionamount"].toString().isEmpty
                  ? "0"
                  : getDBforfirstpage[i]["commissionamount"].toString();

          mycontroller[20].text = getDBforfirstpage[i]["payamount"].toString();
          mycontrol7 = int.parse(mycontroller[19].text);
          mycontrol8 = mycontroller[20].text.isEmpty
              ? 0
              : int.parse(mycontroller[20].text.toString());
          walletcontrol = mycontrol7 - mycontrol8;
          mycontroller[21].text = walletcontrol.toString();
        }
        notifyListeners();
        if (paymodetype == "Coupon") {
          double? mycontrol9;
          double? mycontrol10;
          double? couponcontrol = 0;

          mycontroller[16].text =
              getDBforfirstpage[i]["commissionamount"].toString().isEmpty
                  ? "0"
                  : getDBforfirstpage[i]["commissionamount"].toString();

          mycontroller[17].text = getDBforfirstpage[i]["payamount"].toString();
          mycontrol9 = double.parse(mycontroller[16].text);
          mycontrol10 = mycontroller[17].text.isEmpty
              ? 0.00
              : double.parse(mycontroller[17].text.toString());
          couponcontrol = mycontrol9 - mycontrol10;
          mycontroller[18].text = couponcontrol.abs().toString();
        }

        double mycontrol21;
        double mycontrol22;
        double mycontrol31;
        double mycontrol23;
        double mycontrol24;

        mycontrol21 = mycontroller[7].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[7].text);
        mycontrol22 = mycontroller[10].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[10].text);
        mycontrol31 = mycontroller[13].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[13].text);
        mycontrol23 = mycontroller[16].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[16].text);
        mycontrol24 = mycontroller[19].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[19].text);

        notifyListeners();

        double mycontrol41;
        double mycontrol42;
        double mycontrol43;
        double mycontrol44;
        double mycontrol45;

        mycontrol41 = mycontroller[8].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[8].text);
        mycontrol42 = mycontroller[11].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[11].text);
        mycontrol43 = mycontroller[14].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[14].text);
        mycontrol44 = mycontroller[17].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[17].text);
        mycontrol45 = mycontroller[20].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[20].text);
        netsettled =
            mycontrol41 + mycontrol42 + mycontrol43 + mycontrol44 + mycontrol45;
        mycontroller[2].text = netsettled.abs().toString();

        notifyListeners();

        double mycontrol51;
        double mycontrol52;
        double mycontrol53;
        double mycontrol54;
        double mycontrol55;

        mycontrol51 = mycontroller[9].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[9].text);
        mycontrol52 = mycontroller[12].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[12].text);
        mycontrol53 = mycontroller[15].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[15].text);
        mycontrol54 = mycontroller[18].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[18].text);
        mycontrol55 = mycontroller[21].text.isEmpty
            ? 0.00
            : double.parse(mycontroller[21].text);
        unsettled =
            mycontrol51 + mycontrol52 + mycontrol53 + mycontrol54 + mycontrol55;
        mycontroller[3].text = unsettled.abs().toString();
        notifyListeners();
      }
    }

    notifyListeners();
  }

  totalBalance() {
    int collection;
    int cardtotalcollection = 0;

    for (int i = 0; i < finalcardsettled.length; i++) {
      collection = finalcardsettled[i].rupees.isEmpty
          ? 0
          : int.parse(finalcardsettled[i].rupees.toString());
      cardtotalcollection = cardtotalcollection + collection;
    }
    return cardtotalcollection;
  }

  Future<List<String>> checkingdoc(int id) async {
    List<String> listdata = [];
    final Database db = (await DBHelper.getInstance())!;
    String? data = await DBOperation.getnumbSeriesvlue(db, id);
    listdata.add(data.toString());
    listdata.add(data!.substring(8));

//log("datattata doc : " + data.substring(8));
    return listdata;
  }

  validateCheque(ThemeData theme, BuildContext context) {
    if (totalCheque <= 0) {
      Get.defaultDialog(
          title: 'Alert', middleText: 'No cheque selected to post data');
    } else {
      insertsettledheader("Cheque", theme, context);
    }
  }

  validateCashSave(ThemeData theme, BuildContext context) {
//log("what this : " + finalchequesettled.toString());
    if (cashform.currentState!.validate()) {
      log('lllllllllllllllllllll');
      insertsettledheader("Cash", theme, context);
    }
  }

  bool cardSaveClicked = false;
  validateCardSave(ThemeData theme, BuildContext context) {
    if (cardvalidate.currentState!.validate()) {
      if (cardData.isNotEmpty && totalCardAmt > 0 && cardSaveClicked == false) {
        cardSaveClicked = true;
        insertsettledheader("Card", theme, context);
      } else {
        Get.defaultDialog(
                title: 'Alert',
                middleText: 'Select the transactions before save...!!')
            .then((value) {
          cardSaveClicked = false;
        });
      }
    }
  }

  insertsettledheader(
      String depositetype, ThemeData theme, BuildContext context) async {
    int i = 0;
    if (depositetype == "Cheque" && finalchequesettled.isNotEmpty ||
        depositetype == "Card" && cardData.isNotEmpty ||
        depositetype == "Cash" && mycontroller[4].text.toString() != "") {
      final Database db = (await DBHelper.getInstance())!;
      List<DepositHeaderTDB> values = [];
      List<DepositLineTDB> depositLine = [];

      String documentNum = '';
      int? documentN0 =
          await DBOperation.getnumbSer(db, "nextno", "NumberingSeries", 9);

      List<String> getseriesvalue = await checkingdoc(9);

      int docseries = int.parse(getseriesvalue[1]);

      int nextno = documentN0!;

      documentN0 = docseries + documentN0;

      String finlDocnum = getseriesvalue[0].toString().substring(0, 8);

      documentNum = finlDocnum + documentN0.toString();
      int? docEntryCreated = 0;
      int? counofData = await DBOperation.getcountofTable(
          db, "docentry", "tableDepositHeader");

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
            db, "docentry", "tableDepositHeader");
      }

      if (depositetype == "Cash") {
        values.add(DepositHeaderTDB(
            docentry: docEntryCreated,
            docdate: mycontroller[0].text,
            terminal: UserValues.terminal,
            branch: UserValues.branch,
            docnumber: documentNum.toString(),
            series: "",
            seriesnumber: documentNum.toString(),
            transdate: config.currentDate(),
            transtime: config.currentDate(),
            sysdatetime: "",
            typedeposit: depositetype,
            fromaccountcode: "",
            toaccountcode: "",
            amountsettled: mycontroller[5].text,
            remarks: "",
            createdatetime: config.currentDate(),
            updatedDatetime: config.currentDate(),
            createduserid: UserValues.userID.toString(),
            updateduserid: UserValues.userID.toString(),
            lastupdateip: UserValues.lastUpdateIp,
            doctype: 'Deposit',
            sapDocNo: null,
            qStatus: "",
            sapDocentry: null));
      } else {
        values.add(DepositHeaderTDB(
            docentry: docEntryCreated,
            docdate: mycontroller[0].text,
            terminal: UserValues.terminal,
            branch: UserValues.branch,
            docnumber: documentNum.toString(),
            series: "",
            seriesnumber: documentNum.toString(),
            transdate: config.currentDate(),
            transtime: config.currentDate(),
            sysdatetime: "",
            typedeposit: depositetype,
            fromaccountcode: "",
            toaccountcode: "",
            amountsettled: depositetype == 'Card'
                ? totalCardAmt.toStringAsFixed(2)
                : totalChequeAmt.toStringAsFixed(2),
            remarks: "",
            createdatetime: config.currentDate(),
            updatedDatetime: config.currentDate(),
            createduserid: UserValues.userID.toString(),
            updateduserid: UserValues.userID.toString(),
            lastupdateip: UserValues.lastUpdateIp,
            doctype: 'Deposit',
            sapDocNo: null,
            qStatus: "",
            sapDocentry: null));
      }

      int? docentry2 = await DBOperation.insertDepositHeader(db, values);
      await DBOperation.updatenextno(db, 9, nextno);

      if (depositetype == "Cash") {
        for (int iq = 0; iq < finalcashsettled.length; iq++) {
          depositLine.add(DepositLineTDB(
              basedoctype: finalcashsettled[iq].basedoctype,
              basedocentry: finalcashsettled[iq].docentry,
              baselineid: finalcashsettled[iq].baselineid,
              terminal: UserValues.terminal,
              branch: UserValues.branch,
              docentry: docentry2.toString(),
              linenumber: "${i + 1}",
              transactionRefno: "",
              instrumentno: "",
              paymodetype: depositetype,
              payentry: forpayentry,
              paylineno: "",
              payamount: finalcashsettled[iq].rupees,
              ref1: "",
              ref2: "",
              ref3: "",
              paytransdate: "",
              commissionamount: "",
              nettosettle: mycontroller[5].text,
              createdatetime: config.currentDate(),
              updatedDatetime: config.currentDate(),
              createduserid: '1',
              updateduserid: '1',
              lastupdateip: UserValues.lastUpdateIp.toString(),
              jurnelRemarks: '',
              transactionID: '',
              rcDocentry: finalcashsettled[iq].rcdocentry,
              rcDocnum: finalcashsettled[iq].rcdoctno));
        }

        await getinserttabular("Cash");
        Get.defaultDialog(
                title: "Success",
                middleText: "Successfully Saved..!!",
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
                        onPressed: () {
                          Navigator.pop(context);
                          mycontroller[5].clear();
                          mycontroller[4].clear();
                          mycontroller[6].clear();
                          mycontroller[7].clear();
                          notifyListeners();
                        },
                      ),
                    ],
                  ),
                ],
                radius: 5)
            .then((value) {
          mycontroller[5].clear();
          mycontroller[4].clear();
          mycontroller[6].clear();
          mycontroller[7].clear();
          notifyListeners();
        });
      }

      if (depositetype == "Card") {
        double cardtotalcollection = 0.00;
//finalcardsettled
        for (int im = 0; im < cardData.length; im++) {
          if (cardData[im].isSelected == true) {
            depositLine.add(DepositLineTDB(
                basedoctype: cardData[im].doctype,
                basedocentry: cardData[im].docentry.toString(),
                baselineid: cardData[im].lineid.toString(),
                docentry: docentry2.toString(),
                terminal: UserValues.terminal,
                branch: UserValues.branch,
                linenumber: "${i + 1}",
                transactionRefno: "",
                instrumentno: "",
                paymodetype: depositetype,
                payentry: forpayentry,
                paylineno: "",
                payamount: totalCardAmt.toStringAsFixed(2),
                ref1: "",
                ref2: "",
                ref3: "",
                paytransdate: "",
                commissionamount: cardtotalcollection.toString(),
                nettosettle: mycontroller[5].text,
                createdatetime: config.currentDate(),
                updatedDatetime: config.currentDate(),
                createduserid: '1',
                updateduserid: '1',
                lastupdateip: UserValues.lastUpdateIp.toString(),
                jurnelRemarks: jurnelRemarks.text,
                transactionID: transactionID.text,
                rcDocentry: cardData[im].rcdocentry,
                rcDocnum: cardData[im].rcdoctno));
          }
          notifyListeners();
        }
        await getinserttabular("Card");
        Get.defaultDialog(
          title: "Success",
          middleText: "Card Successfully Saved..!!",
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
          clearTxtField();
          cardSaveClicked = false;
          isSelectedAllCard = false;
          forcardlistorder(context, "Card", theme, 0);
        });
      }
      if (depositetype == "Cheque") {
        double chequetotalcollection = 0.00;

        for (int ia = 0; ia < finalchequesettled.length; ia++) {
          if (finalchequesettled[ia].checkClr == true) {
            depositLine.add(DepositLineTDB(
                basedoctype: finalchequesettled[ia].basedoctype,
                basedocentry: finalchequesettled[ia].docentry,
                baselineid: finalchequesettled[ia].baselineid,
                docentry: docentry2.toString(),
                terminal: UserValues.terminal,
                branch: UserValues.branch,
                linenumber: "${i + 1}",
                transactionRefno: finalchequesettled[i].name.toString(),
                instrumentno: "",
                paymodetype: depositetype,
                payentry: forpayentry,
                paylineno: "",
                payamount: totalChequeAmt.toString(),
                ref1: "",
                ref2: "",
                ref3: "",
                paytransdate: "",
                commissionamount: chequetotalcollection.toString(),
                nettosettle: mycontroller[5].text,
                createdatetime: config.currentDate(),
                updatedDatetime: config.currentDate(),
                createduserid: '1',
                updateduserid: '1',
                lastupdateip: UserValues.lastUpdateIp.toString(),
                jurnelRemarks: jurnelRemarks.text,
                transactionID: transactionID.text,
                rcDocentry: finalchequesettled[ia].rcdocentry,
                rcDocnum: finalchequesettled[ia].rcdoctno));
          }

          notifyListeners();
        }
        await getinserttabular("Cheque");
        Get.defaultDialog(
                title: "Success",
                middleText: "Cheque Successfully Saved..!!",
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
          clearTxtField();
          isSelectedAllCheque = false;
          forChequelistorder(context, "Cheque", theme, 0);
        });
      }
      await DBOperation.insertDepositLine(db, depositLine, docentry2!);
      postRabitMqSettle(docentry2, depositetype);
      mycontroller[5].text = '';

      mycontroller[6].text = '';
      mycontroller[7].text = '';
      valuechoose = null;
      notifyListeners();
    }

    if (depositetype == "Cash" && mycontroller[4].text.toString() == "") {
      Get.defaultDialog(
          title: "Alert",
          middleText: "No Data Found..!!",
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
    }
    if (depositetype == "Card" && cardData.isEmpty) {
      Get.defaultDialog(
          title: "Alert",
          middleText: "No Data Found..!!",
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    cardSaveClicked = false;
                    Get.back();
                  },
                ),
              ],
            ),
          ],
          radius: 5);
    }
    if (depositetype == "Cheque" && finalchequesettled.isEmpty) {
      Get.defaultDialog(
          title: "Alert",
          middleText: "No Data Found..!!",
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
    }

    notifyListeners();
  }

  bool onDisablebutton = false;
  void callDepositPostApi(
      BuildContext context, ThemeData theme, String dtType) async {
    onDisablebutton = true;

    sapLoginApi(context);
    notifyListeners();
    PostDepositAPi.depType = dtType;
    PostDepositAPi.totAmount =
        dtType == 'dtCash' ? double.parse(mycontroller[5].text) : 0;

    PostDepositAPi.depAccount = valuechooseAccNum;

    PostDepositAPi.bankAccNum = valuechooseAccNum;

    PostDepositAPi.allocationAcc = cashAccCode.toString();

    // dtType == 'dtCash'
    //     ? cardAccDetailaData![0].uCashAcct
    //     : dtType == 'dtCheque'
    //         ? cardAccDetailaData![0].uChequeAcct
    //         : '';
    PostDepositAPi.remarks =
        dtType == 'dtCash' ? mycontroller[6].text : jurnelRemarks.text;
    PostDepositAPi.depDate = config.alignDate2(mycontroller[0].text);
    // config.currentDate();

    await PostDepositAPi.getGlobalData().then((value) async {
      if (value.statusCode >= 200 && value.statusCode <= 204) {
        // sapDocentry = value.absEntry.toString();
        // sapDocuNumber = value.depositNumber.toString();
        notifyListeners();

        await Get.defaultDialog(
                title: "Success",
                middleText: 'Successfully Done',
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
          selectbankCode = '';
          selectedBankType = null;
          bankhintcolor = false;
          mycontroller[5].text = '';

          onDisablebutton = false;
          init(context);
          Get.back();
          notifyListeners();
        });
      } else if (value.statusCode >= 400 && value.statusCode <= 410) {
        await Get.defaultDialog(
                title: "Alert",
                middleText: "${value.erorrs!.message!.value}",
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
                middleText: "${value.exception}",
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
    notifyListeners();
  }

  setst() {
    notifyListeners();
  }

  postRabitMqSettle(int docentry, String mode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBDepositHeader =
        await DBOperation.getDepositHeadDB(db, docentry);
    List<Map<String, Object?>> getDBDepositLine =
        await DBOperation.getDepositLineDB(db, docentry);

    String depositHeader = json.encode(getDBDepositHeader);
    String depositLine = json.encode(getDBDepositLine);

    String ddd = pushContent(mode, depositHeader, depositLine);

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

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  postRabitMqSettle2(int docentry, String mode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBDepositHeader =
        await DBOperation.getDepositHeadDB(db, docentry);
    List<Map<String, Object?>> getDBDepositLine =
        await DBOperation.getDepositLineDB(db, docentry);

    String depositHeader = json.encode(getDBDepositHeader);
    String depositLine = json.encode(getDBDepositLine);

    String ddd = pushContent(mode, depositHeader, depositLine);

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

    properties.headers = {"Branch": "Server"};
    exchange.publish(ddd, "", properties: properties);
    client1.close();
  }

  String pushContent(String mode, String depositHeader, String depositLine) {
    String result = '';
    if (mode == 'Cash') {
      result = json.encode({
        "ObjectType": 13,
        "ActionType": "Add",
        "DepositCashHeader": depositHeader,
        "DepositCashLine": depositLine,
      });
    } else if (mode == 'Card') {
      result = json.encode({
        "ObjectType": 11,
        "ActionType": "Add",
        "DepositCardHeader": depositHeader,
        "DepositCardLine": depositLine,
      });
    } else {
      result = json.encode({
        "ObjectType": 12,
        "ActionType": "Add",
        "DepositChequeHeader": depositHeader,
        "DepositChequeLine": depositLine,
      });
    }
    return result;
  }

  forwalletlistorder(
      BuildContext context, String rcmode, ThemeData theme) async {
    if (fomkeySet2.currentState!.validate()) {
      notifyListeners();

//log("aagafgafgsf:"+"$indx");
//if(indx !=null){

      savepaylist(rcmode, context, theme, 1);
      notifyListeners();

//}
    }
    notifyListeners();
  }

  checkSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);
    for (int i = 0; i < finalwalletsettled.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalwalletsettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
    }
  }

  currentDatepopUp(ThemeData theme) async {
    if (mycontroller[0].text.toString() !=
        config.alignDate(config.currentDate())) {
      await Get.defaultDialog(
          title: "Alert",
          middleText: "You View Only Current Date Data..!!",
          backgroundColor: Colors.white,
          titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
          middleTextStyle: theme.textTheme.bodyLarge,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: const Text("Close"),
                  onPressed: () {
                    Get.offAllNamed(ConstantRoutes.deposits);
                  },
                ),
              ],
            ),
          ],
          radius: 5);
    }
  }

  forcashlistorder(BuildContext context, String rcmode, ThemeData theme) async {
    savepaylist(rcmode, context, theme, 1);
    notifyListeners();
  }

  checkCashSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);

    for (int i = 0; i < finalcashsettled.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalcashsettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
    }
  }

  forcardlistorder(BuildContext context, String rcmode, ThemeData theme,
      int showdialog) async {
    savepaylist(rcmode, context, theme, showdialog);
    notifyListeners();
    if (paytermvaluechoose == null) {
      hintcolor = true;
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  Future<int?> checkCarlistloop(String cardterminal) {
    for (int i = 0; i < finalcardsettled.length; i++) {
      if (finalcardsettled[i].cardterminal == cardterminal) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> checkChequelistloop(String customername) {
    for (int i = 0; i < finalchequesettled.length; i++) {
      if (finalchequesettled[i].name == customername) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> checkCouponlistloop(String customername) {
    for (int i = 0; i < finalcouponsettled.length; i++) {
      if (finalcouponsettled[i].name == customername) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  checkCardSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);

    for (int i = 0; i < getDBsalespaysettle5.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalcardsettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
    }
  }

  forChequelistorder(BuildContext context, String rcmode, ThemeData theme,
      int showdialog) async {
    savepaylist(rcmode, context, theme, showdialog);
    notifyListeners();
  }

  checkChequeSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);
    for (int i = 0; i < finalchequesettled.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalchequesettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
    }
  }

  forcouponlistorder(
      BuildContext context, String rcmode, ThemeData theme) async {
    if (fomkeySet.currentState!.validate()) {
//log("aagafgafgsf:"+"$indx");
//if(indx !=null){

      savepaylist(rcmode, context, theme, 1);

//}
    }
    notifyListeners();
  }

  checkcouponSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);
    for (int i = 0; i < finalcouponsettled.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalcouponsettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
    }
  }

  finalfotsettle(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBholddata5 =
        await DBOperation.finalforDeposit(db, rcmode);
    log('getDBholddata5getDBholddata5::${getDBholddata5.length}');
  }

  double totalCardAmt = 0.00;
  double totalChequeAmt = 0.00;

  Future savepaylist(String rcmode, BuildContext context, ThemeData theme,
      [int? showdialog]) async {
    cardListMSG = "";
    double rccash = 0.00;
    totalChequeAmt = 0.00;
    totalCardAmt = 0.00;
    double? paycash;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);
    finalcardsettled2.clear();
    finalchequesettled2.clear();
    finalcardsettled.clear();
    finalcashsettled.clear();
    finalchequesettled.clear();
    finalwalletsettled.clear();
    finalcouponsettled.clear();
    totalCheque = 0.00;
    cardData.clear();

    for (int i = 0; i < getDBsalespaysettle5.length; i++) {
      forpayentry = getDBsalespaysettle5[i]['docentry'].toString();
      chequeline = getDBsalespaysettle5[i]["chequeno"].toString();
////rcdocentry,rcnumber
      if (config.alignDate(
              getDBsalespaysettle5[i]["createdateTime"].toString()) ==
          mycontroller[0].text) {
        if (rcmode == "Cash") {
          paycash =
              double.parse(getDBsalespaysettle5[i]["rcamount"].toString());
          rccash = rccash + paycash;
          CashList cashsettled = CashList(
            basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
            basedocentry: getDBsalespaysettle5[i]['docentry'].toString(),
            baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
            docentry: getDBsalespaysettle5[i]['docentry'].toString(),
            rupees: getDBsalespaysettle5[i]["rcamount"].toString(),
            rcdocentry: getDBsalespaysettle5[i]["rcdocentry"].toString(),
            rcdoctno: getDBsalespaysettle5[i]["rcnumber"].toString(),
          );

          finalcashsettled.add(cashsettled);

          mycontroller[4].text = rccash.toString();

          notifyListeners();
        }

        if (rcmode == "Card") {
          if (paytermvaluechoose ==
              getDBsalespaysettle5[i]["cardterminal"].toString()) {
            getAllCardTransactions(getDBsalespaysettle5[i]);
            notifyListeners();
          }
        }
        if (rcmode == "Cheque") {
          if (getDBsalespaysettle5[i]['doctype'].toString() != "Expense") {
            ChequeList chequesettled2 = ChequeList(
              basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
              baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
              docentry: getDBsalespaysettle5[i]['docentry'].toString(),
              name: "",
              PhNo: getDBsalespaysettle5[i]["customerphono"].toString().isEmpty
                  ? 0
                  : int.parse(
                      getDBsalespaysettle5[i]["customerphono"].toString()),
              rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
              chequeNo: getDBsalespaysettle5[i]["chequeno"].toString(),
              chequeDate: getDBsalespaysettle5[i]["chequedate"].toString(),
              checkClr: false,
              onchanged: 1,
              rcdocentry: getDBsalespaysettle5[i]["rcdocentry"].toString(),
              rcdoctno: getDBsalespaysettle5[i]["rcnumber"].toString(),
            );
            finalchequesettled2.add(chequesettled2);
            notifyListeners();

            ChequeList chequesettled = ChequeList(
              basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
              docno: getDBsalespaysettle5[i]['documentno'].toString(),
              baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
              docentry: getDBsalespaysettle5[i]['docentry'].toString(),
              name: "",
              rcmode: getDBsalespaysettle5[i]["rcmode"].toString(),
              PhNo: getDBsalespaysettle5[i]["customerphono"].toString().isEmpty
                  ? 0
                  : int.parse(
                      getDBsalespaysettle5[i]["customerphono"].toString()),
              rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
              chequeNo: getDBsalespaysettle5[i]["chequeno"].toString(),
              chequeDate: config
                  .alignDate(getDBsalespaysettle5[i]["chequedate"].toString()),
              checkClr: false,
              onchanged: 1,
              rcdocentry: getDBsalespaysettle5[i]["rcdocentry"].toString(),
              rcdoctno: getDBsalespaysettle5[i]["rcnumber"].toString(),
            );
            finalchequesettled.add(chequesettled);
            totalChequeAmt = sumofcheque(finalchequesettled);
          }
        }
      }
    }
    if (showdialog == 1) {
      if (rcmode == "Card" && cardData.isEmpty) {
        Get.defaultDialog(
            title: "Alert",
            middleText: "Dose Not Have data..!!",
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
            radius: 5);
      }
      if (rcmode == "Cheque" && finalchequesettled.isEmpty) {
        Get.defaultDialog(
            title: "Alert",
            middleText: "Dose Not Have data..!!",
            backgroundColor: Colors.white,
            titleStyle: theme.textTheme.bodyLarge!.copyWith(color: Colors.red),
            middleTextStyle: theme.textTheme.bodyLarge,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ],
            radius: 5);
      }
    }
    notifyListeners();
  }

  double sumofcheque(List<ChequeList> finalcheques) {
    double value = 0;
    for (int i = 0; i < finalcheques.length; i++) {
      value = value + double.parse(finalcheques[i].rupees);
    }
    return value;
  }

  double sumofcard(List<CardList> finalcards) {
    double value = 0;
    for (int i = 0; i < finalcards.length; i++) {
      value = value + double.parse(finalcards[i].rupees);
    }
    return value;
  }

  carditemDeSelect(int i) {
    if (finalcardsettled[i].checkClr == false) {
      finalcardsettled[i].checkClr = true;

      notifyListeners();
    } else if (finalcardsettled[i].checkClr == true) {
      finalcardsettled[i].checkClr = false;

      notifyListeners();
    }

    notifyListeners();
  }

  chequeitemDeSelect(int i, bool data) {
    chequeQueryData![i].checkClr = data;

    calculateValueofChequeUnselected();

    notifyListeners();
  }

  Future calculateValueofChequeUnselected() async {
    totalCheque = 0.00;
    for (ChequeDepositQueryData datacheq in chequeQueryData!) {
      if (datacheq.checkClr == true) {
        totalCheque = totalCheque + datacheq.chequeAmt;
      }
    }
    notifyListeners();
  }

  selectionChque() async {
    log('isSelectedAllCheque::$isSelectedAllCheque');
    totalCheque = 0.00;
    if (chequeQueryData!.isNotEmpty) {
      if (isSelectedAllCheque == false) {
        for (int i = 0; i < chequeQueryData!.length; i++) {
          chequeQueryData![i].checkClr = true;
          totalCheque = totalCheque + chequeQueryData![i].chequeAmt;
        }
        log('totalChequetotalCheque111:::$totalCheque');

        isSelectedAllCheque = true;
      } else {
        for (int i = 0; i < chequeQueryData!.length; i++) {
          chequeQueryData![i].checkClr = false;
        }
        isSelectedAllCheque = false;
      }
    }
    notifyListeners();
  }

  walletitemDeSelect(int i) {
    if (finalwalletsettled[i].checkClr == false) {
      finalwalletsettled[i].checkClr = true;

      notifyListeners();
    } else if (finalwalletsettled[i].checkClr == true) {
      finalwalletsettled[i].checkClr = false;

      notifyListeners();
    }

    notifyListeners();
  }

  couponitemDeSelect(int i) {
    if (finalcouponsettled[i].checkClr == false) {
      finalcouponsettled[i].checkClr = true;

      notifyListeners();
    } else if (finalcouponsettled[i].checkClr == true) {
      finalcouponsettled[i].checkClr = false;

      notifyListeners();
    }

    notifyListeners();
  }

  ontapisload() {
    isload = true;
    notifyListeners();
  }

  oncoupontapisload() {
    iscouponload = true;
    notifyListeners();
  }

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    nowaday = currentDateTime;
    return currentDateTime;
  }

  getDocDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    // DateTime.now());

    String datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);

    mycontroller[0].text = datetype!;
    final Database db = (await DBHelper.getInstance())!;
    notifyListeners();
  }

  getDate(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime.now());

    datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);

    mycontroller[0].text = datetype!;
    final Database db = (await DBHelper.getInstance())!;
    notifyListeners();

    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[9].text = "";
    mycontroller[12].text = "";
    mycontroller[9].text = "";
    mycontroller[21].text = "";
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[18].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[13].text = "";
    mycontroller[14].text = "";
    mycontroller[15].text = "";
    mycontroller[16].text = "";
    mycontroller[17].text = "";
    mycontroller[19].text = "";
    mycontroller[20].text = "";

    List<Map<String, Object?>> netAmout =
        await DBOperation.getNetCollectionAmtByDate(
            db, config.alignDate1(mycontroller[0].text));
    List<Map<String, Object?>> totalCash = await DBOperation.getTotalCashByDate(
        db, config.alignDate1(mycontroller[0].text), 'Cash');
    List<Map<String, Object?>> totalCard = await DBOperation.getTotalCashByDate(
        db, config.alignDate1(mycontroller[0].text), 'Card');
    List<Map<String, Object?>> totalcheque =
        await DBOperation.getTotalCashByDate(
            db, config.alignDate1(mycontroller[0].text), 'Cheque');

    List<Map<String, Object?>> totalSettledCheque =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Cheque');
    List<Map<String, Object?>> totalSettledCard =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Card');
    List<Map<String, Object?>> totalSettledCash =
        await DBOperation.getTotalSettledByDateMode(
            db, mycontroller[0].text, 'Cash');
    List<Map<String, Object?>> totalNetSettled =
        await DBOperation.getTotalSettledByDate(db, mycontroller[0].text);
    await calculateNetAmount(netAmout);

    await calculateTotalCash(totalCash, 7);
    await calculateTotalCash(totalCard, 10);
    await calculateTotalCash(totalcheque, 13);

    await calculateSettleAmount(totalSettledCash, 8);
    await calculateSettleAmount(totalSettledCard, 11);
    await calculateSettleAmount(totalSettledCheque, 14);
    await calculateSettleAmount(totalNetSettled, 2);
    await calculateUnSettledAmt(
        double.parse(mycontroller[1].text), double.parse(mycontroller[2].text));

    notifyListeners();

    notifyListeners();
  }

  Future calculateNetAmount(List<Map<String, Object?>> netAmout) async {
    double salesAmt = 0.00;

    for (int i = 0; i < netAmout.length; i++) {
      if (netAmout.length > 2 && i == netAmout.length - 1) {
        salesAmt = salesAmt - double.parse(netAmout[i]['totals'].toString());
        notifyListeners();
      } else {
        salesAmt = salesAmt + double.parse(netAmout[i]['totals'].toString());
        notifyListeners();
      }
    }
    mycontroller[1].text = salesAmt.toStringAsFixed(2);
    notifyListeners();
  }

  Future calculateSettleAmount(
      List<Map<String, Object?>> netAmout, int num) async {
    double salesAmt = 0.00;

    for (int i = 0; i < netAmout.length; i++) {
      if (netAmout.length > 2 && i == netAmout.length - 1) {
        salesAmt = salesAmt - double.parse(netAmout[i]['totals'].toString());
        notifyListeners();
      } else {
        salesAmt = salesAmt + double.parse(netAmout[i]['totals'].toString());
        notifyListeners();
      }
    }
    mycontroller[num].text = salesAmt.toStringAsFixed(2);
    notifyListeners();
  }

  Future calculateTotalCash(
      List<Map<String, Object?>> netAmout, int num) async {
    double salesAmt = 0.00;
    for (int i = 0; i < netAmout.length; i++) {
      if (netAmout[i]['doctype'].toString() == "Expense") {
        salesAmt = salesAmt + double.parse(netAmout[i]['rcamount'].toString());
        notifyListeners();
      } else {
        salesAmt = salesAmt + double.parse(netAmout[i]['rcamount'].toString());
        notifyListeners();
      }
    }
    mycontroller[num].text = salesAmt.toStringAsFixed(2);
    notifyListeners();
  }

  Future calculateUnSettledAmt(
      double totalcollection, double totalSettled) async {
    mycontroller[3].text = (totalcollection - totalSettled).toStringAsFixed(2);
    notifyListeners();
  }

  cleartextfield() {
    mycontroller[7].text = "";
    mycontroller[8].text = "";
    mycontroller[10].text = "";
    mycontroller[11].text = "";
    mycontroller[14].text = "";
    mycontroller[15].text = "";
    mycontroller[16].text = "";
    mycontroller[17].text = "";
    mycontroller[19].text = "";
    mycontroller[20].text = "";
    notifyListeners();
  }

//Second Screen

  List listitems = ["CASH", "CARD", "COUPON"];
  dropdownchoose(newvalue) {
    for (var i = 0; i < acountData.length; i++) {
      if (acountData[i].acctName.toString() == newvalue.toString()) {
        valuechooseAccNum = acountData[i].depEntry;
      }
    }
    notifyListeners();
  }

  clearcarddetails() {
    hintcolor = false;
    paytermvaluechoose = null;
    finalcardsettled = [];
    notifyListeners();
  }

  ontapcheckbox(newbool) {
    valuefirst = false;
    notifyListeners();
  }

  List couponlist = [
    'GROUPON',
    'AMAZON PAY',
    'FLIPKART CORPORATE',
    'HDFC GIFTPLUS',
    'ICICI GIFT COUPON',
    'UNILET COUPONS',
    'INSIGNIA COUPONS'
  ];
  coupondropdown(newvalue) {
    couponvaluechoose = newvalue;
    finalcouponsettled.clear();
    notifyListeners();
  }

  walletdropdown(newvalue) {
    walletvaluechoose = newvalue;
    finalwalletsettled.clear();
    notifyListeners();
  }

  List cardpayTerminallist = [
    "Terminal - 1",
    'Terminal - 2',
    'Terminal - 3',
    'Terminal - 4'
  ];

  payTermdropdown(newvalue) {
    paytermvaluechoose = newvalue;
    finalcardsettled.clear();
    notifyListeners();
  }

  deleteDeposittb() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.deleteDeposit(db);
    notifyListeners();
  }

  getAllCardTransactions(Map<String, Object?> cardTransData) {
    cardData.add(CardModel(
      cardApprno: cardTransData['cardApprno'].toString(),
      cardterminal: cardTransData['cardterminal'].toString(),
      createdateTime: cardTransData['"createdatetime"'].toString(),
      docentry: int.parse(cardTransData['docentry'].toString()),
      doctype: cardTransData['doctype'].toString(),
      documentno: cardTransData['documentno'].toString(),
      lineid: int.parse(cardTransData['lineid'].toString()),
      rcamount: double.parse(cardTransData['rcamount'].toString()),
      rcdatetime: cardTransData['rcdatetime'].toString(),
      rcmode: cardTransData['rcmode'].toString(),
      isSelected: false,
      rcdocentry: cardTransData["rcdocentry"].toString(),
      rcdoctno: cardTransData["rcnumber"].toString(),
    ));
  }

  void selectTrans(bool data, int index) {
    cardData[index].isSelected = data;
    calculateTotalCardTransSelectedAmt();
    notifyListeners();
  }

  calculateTotalCardTransSelectedAmt() {
    totalCardAmt = 0.00;
    for (CardModel cardvalue in cardData) {
      if (cardvalue.isSelected == true) {
        totalCardAmt = totalCardAmt + cardvalue.rcamount;
      }
    }
    notifyListeners();
  }

  selectAllCardTransaction() {
    totalCardAmt = 0.00;
    if (cardData.isNotEmpty) {
      if (isSelectedAllCard == false) {
        for (int i = 0; i < cardData.length; i++) {
          cardData[i].isSelected = true;
          totalCardAmt = totalCardAmt + cardData[i].rcamount;
        }
        isSelectedAllCard = true;
      } else {
        for (int i = 0; i < cardData.length; i++) {
          cardData[i].isSelected = false;
        }
        isSelectedAllCard = false;
      }
    }
    notifyListeners();
  }
}
