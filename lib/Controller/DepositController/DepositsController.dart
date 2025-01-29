import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import '../../ServiceLayerAPIss/InvoiceAPI/InvoiceLoginnAPI.dart';

class DepositsController extends ChangeNotifier {
  Configure config = Configure();

  init(BuildContext context) async {
    clearAllData();
    // reset();
    await callDepositsApi();
    await callBankmasterApi(context);
    await callCashCardAccApi();
    notifyListeners();
  }

  List<DepositQueryData> activitiesData = [];

  callDepositsApi() {
    activitiesData = [];
    double netamtt = 0;
    DepositsQueryAPi.getGlobalData(AppConstant.branch).then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        activitiesData = value.activitiesData!;
        //
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
        if (value.error!.code != null) {
          // loadingscrn = false;
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

  callCashCardAccApi() async {
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
        // value.error.toString()
        Get.defaultDialog(
            title: 'Alert',
            content: const Text('Something went wrong. Try again.'));

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
      //log("objectbbbbbbbbbb:::::" + tappageIndex.toString());
      await tappage.animateToPage(--tappageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
      // getcustomerMaster();
      mycontroller[0].clear();
      notifyListeners();
      // return Future.value(true);
      //log("object:::::" + tappageIndex.toString());
    }
    // else if(tappageIndex == 1){
    //   //  tappage.animateToPage(--tappageIndex,
    //   //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    // };
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
  String? couponvaluechoose;
  String? walletvaluechoose;
  String? paytermvaluechoose;
  bool? valuefirst = true;
  List<CardModel> cardData = [];
  bool isSelectedAllCard = false;
  bool isSelectedAllCheque = false;

  clearAllData() {
    mycontroller[1].text = "";
    mycontroller[2].text = "";
    mycontroller[3].text = "";
    mycontroller[4].text = "";
    mycontroller[5].text = "";
    // fomkeySet =  List.generate(10, (i) => GlobalKey<FormState>());
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

    //exectueSql();
  }

  // exectueSql()async{
  //  final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> netAmout = await DBOperation.execsettle(db);
  // }

//   pastdata(String paymodetype) async {
//     int totalcollection1 = 0;
//     int totalcollection2 = 0;
//     int totalcollection3 = 0;
//     int totalcollection4 = 0;
//     int totalcollection5 = 0;

//     double netsettled = 0.00;
//     double unsettled = 0.00;
//     double payamount = 0.00;
//     double netsett = 0.00;
//     double? cashsettled = 0.00;
//     int? mycontrol = 0;

//     final Database db = (await DBHelper.getInstance())!;
//     List<Map<String, Object?>> getDBholddata5 =
//         await DBOperation.getsaveinsertHeader(
//             db, config.alignDate1(mycontroller[0].text.toString()));

//     for (int i = 0; i < getDBholddata5.length; i++) {
//       if (config.alignDate(getDBholddata5[i]["createdateTime"].toString()) ==
//           mycontroller[0].text) {
//         List<Map<String, Object?>> getDBforfirstpage =
//             await DBOperation.getsaveinsert(db, paymodetype,
//                 getDBholddata5[i]["createdateTime"].toString());
//         //
//         //  int ij=0;
//         for (int ij = 0; ij < getDBforfirstpage.length; ij++) {
//           if (config.alignDate(
//                   getDBforfirstpage[ij]["createdateTime"].toString()) ==
//               mycontroller[0].text) {
//             if (paymodetype == "Card") {
//               int mycontrol = 0;
//               int collection = 0;
//               int cardcollection = 0;
//               double? mycontrol3;
//               double? mycontrol4;
//               double? cardcontrol = 0.00;
// // collection=int.parse(getDBforfirstpage[i]["commissionamount"].toString());

// //         cardcollection=cardcollection+collection;
//               payamount = payamount +
//                   double.parse(getDBforfirstpage[ij]["payamount"].toString());
// //           mycontrol = mycontrol + payamount;

//               cardcol = payamount;
//               cardset = payamount;

//               mycontroller[10].text = payamount.toString();
//               mycontroller[11].text = payamount.toString();
//               mycontrol3 = double.parse(mycontroller[10].text);
//               mycontrol4 = mycontroller[11].text.isEmpty
//                   ? 0.00
//                   : double.parse(mycontroller[11].text.toString());
//               cardcontrol = mycontrol3 - mycontrol4;
//               mycontroller[12].text = cardcontrol.abs().toString();
//             }
//             if (paymodetype == "Cash") {
//               double? mycontrol = 0.00;
//               double? mycontrol1;
//               double? mycontrol2;
//               double? cashcontrol = 0.00;

//               // for (int i = 0; i < finalcashsettled.length; i++) {
//               // mycontroller[10].text="";

//               payamount = payamount +
//                   double.parse(getDBforfirstpage[ij]["payamount"].toString());
//               netsett = netsett +
//                   double.parse(getDBforfirstpage[ij]["nettosettle"].toString());
//               // mycontrol = mycontrol! + payamount;
//               // }
//               cashcol = payamount;
//               cashset = netsett;
//               mycontroller[7].text = payamount.toString();
//               mycontroller[8].text =
//                   getDBforfirstpage[ij]["nettosettle"].toString();

//               mycontrol1 = double.parse(mycontroller[7].text);
//               mycontrol2 =
//                   getDBforfirstpage[ij]["nettosettle"].toString().isEmpty
//                       ? 0.00
//                       : double.parse(
//                           getDBforfirstpage[ij]["nettosettle"].toString());
//               cashcontrol = mycontrol1 - mycontrol2;
//               mycontroller[9].text = cashcontrol.abs().toString();
//               notifyListeners();
//             }
//             if (paymodetype == "Cheque") {
//               double? payamount;
//               double? mycontrol = 0.00;
//               double Cqcollection = 0.00;
//               double cHEQUEcollection = 0.00;
//               double? mycontrol5;
//               double mycontrol6;
//               double? chequecontrol = 0.00;
//               // for (int i = 0; i < finalchequesettled.length; i++) {
//               //   Cqcollection=int.parse(getDBforfirstpage[i]["payamount"].toString());
//               //   cHEQUEcollection=cHEQUEcollection+Cqcollection;
//               //
//               //   if (finalchequesettled[i].checkClr == true) {
//               payamount =
//                   double.parse(getDBforfirstpage[ij]["payamount"].toString());
//               //     mycontrol = mycontrol! + payamount;
//               //   }
//               // }
//               cheqcol=payamount;
//               cheqset=payamount;
//               //  if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){
//               mycontroller[13].text =
//                   payamount.toString().isEmpty ? "0" : payamount.toString();
//               // totalcollection3=totalcollection3+mycontrol!;

//               mycontroller[14].text = payamount.toString();
//               mycontrol5 = double.parse(mycontroller[13].text);
//               mycontrol6 = mycontroller[14].text.isEmpty
//                   ? 0.00
//                   : double.parse(mycontroller[14].text.toString());
//               chequecontrol = mycontrol5 - mycontrol6;
//               mycontroller[15].text = chequecontrol.abs().toString();
//               notifyListeners();
//             }
//             // if (paymodetype == "Wallet") {
//             //   double? payamount;
//             //   double? mycontrol = 0.00;
//             //   double Wtcollection = 0.00;
//             //   double walletcollection = 0.00;
//             //   double? mycontrol7;
//             //   double mycontrol8;
//             //   double? walletcontrol = 0.00;
//             //   // for (int i = 0; i < finalwalletsettled.length; i++) {
//             //   //   Wtcollection=int.parse(getDBforfirstpage[i]["payamount"].toString());
//             //   //   walletcollection=walletcollection+Wtcollection;
//             //   //
//             //   //   if (finalwalletsettled[i].checkClr == true) {
//             //   //     payamount = int.parse(getDBforfirstpage[i]["payamount"].toString());
//             //   //     mycontrol = mycontrol! + payamount;
//             //   //   }
//             //   // }
//             //   // if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){
//             //   mycontroller[19].text =
//             //       getDBforfirstpage[ij]["commissionamount"].toString().isEmpty
//             //           ? "0"
//             //           : getDBforfirstpage[ij]["commissionamount"].toString();

//             //   mycontroller[20].text =
//             //       getDBforfirstpage[i]["payamount"].toString();
//             //   mycontrol7 = double.parse(mycontroller[19].text);
//             //   mycontrol8 = mycontroller[20].text.isEmpty
//             //       ? 0.00
//             //       : double.parse(mycontroller[20].text.toString());
//             //   walletcontrol = mycontrol7 - mycontrol8;
//             //   mycontroller[21].text = walletcontrol.toString();
//             //                 notifyListeners();

//             // }
//             // if (paymodetype == "Coupon") {
//             //   double? payamount;
//             //   double? mycontrol = 0.00;
//             //   double Cpcollection = 0.00;
//             //   double Couponcollection = 0.00;
//             //   double? mycontrol9;
//             //   double? mycontrol10;
//             //   double? couponcontrol = 0.00;
//             //   // for (int i = 0; i < finalcouponsettled.length; i++) {
//             //   //    Cpcollection=int.parse(getDBforfirstpage[i]["payamount"].toString());
//             //   //   Couponcollection=Couponcollection+Cpcollection;
//             //   //
//             //   //   if (finalcouponsettled[i].checkClr == true) {
//             //   //     payamount = int.parse(getDBforfirstpage[i]["payamount"].toString());
//             //   //     mycontrol = mycontrol! + payamount;
//             //   //   }
//             //   // }
//             //   // if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){
//             //   mycontroller[16].text =
//             //       getDBforfirstpage[i]["commissionamount"].toString().isEmpty
//             //           ? "0"
//             //           : getDBforfirstpage[i]["commissionamount"].toString();

//             //   mycontroller[17].text =
//             //       getDBforfirstpage[i]["payamount"].toString();
//             //   mycontrol9 = double.parse(mycontroller[16].text);
//             //   mycontrol10 = mycontroller[17].text.isEmpty
//             //       ? 0
//             //       : double.parse(mycontroller[17].text.toString());
//             //   couponcontrol = mycontrol9 - mycontrol10;
//             //   mycontroller[18].text = couponcontrol.toString();
//             // }
//             double mycontrol21;
//             double mycontrol22;
//             double mycontrol31;
//             double mycontrol23;
//             double mycontrol24;

//             mycontrol21 = mycontroller[7].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[7].text);
//             mycontrol22 = mycontroller[10].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[10].text);
//             mycontrol31 = mycontroller[13].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[13].text);
//             mycontrol23 = mycontroller[16].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[16].text);
//             mycontrol24 = mycontroller[19].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[19].text);
//             netcollection = mycontrol21 +
//                 mycontrol22 +
//                 mycontrol31 +
//                 mycontrol23 +
//                 mycontrol24;
//             //  mycontroller[1].text = netcollection.toString();
//             notifyListeners();

//             double mycontrol41;
//             double mycontrol42;
//             double mycontrol43;
//             double mycontrol44;
//             double mycontrol45;

//             mycontrol41 = mycontroller[8].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[8].text);
//             mycontrol42 = mycontroller[11].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[11].text);
//             mycontrol43 = mycontroller[14].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[14].text);
//             mycontrol44 = mycontroller[17].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[17].text);
//             mycontrol45 = mycontroller[20].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[20].text);
//             netsettled = mycontrol41 +
//                 mycontrol42 +
//                 mycontrol43 +
//                 mycontrol44 +
//                 mycontrol45;
//             mycontroller[2].text = netsettled.toString();

//             notifyListeners();

//             double mycontrol51;
//             double mycontrol52;
//             double mycontrol53;
//             double mycontrol54;
//             double mycontrol55;

//             mycontrol51 = mycontroller[9].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[9].text);
//             mycontrol52 = mycontroller[12].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[12].text);
//             mycontrol53 = mycontroller[15].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[15].text);
//             mycontrol54 = mycontroller[18].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[18].text);
//             mycontrol55 = mycontroller[21].text.isEmpty
//                 ? 0.00
//                 : double.parse(mycontroller[21].text);
//             unsettled = mycontrol51 +
//                 mycontrol52 +
//                 mycontrol53 +
//                 mycontrol54 +
//                 mycontrol55;
//             mycontroller[3].text = unsettled.toString();
//           }
//         }
//       }
//     }

//     notifyListeners();
//   }

  clearTxtField() {
    transactionID.clear();
    jurnelRemarks.clear();
  }

  Future getinserttabular(String paymodetype) async {
    //  mycontroller[1].text = "";

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

      //  if(getDBforfirstpage[i]["createdateTime"].toString()==mycontroller[0].text){
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
          // }
        }
        //     }
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
          // for (int i = 0; i < getDBforfirstpage.length; i++) {
          // mycontroller[10].text="";

          // if (finalcardsettled[i].checkClr == true) {

          // }
          // }
          //  if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){

          // totalcollection2=totalcollection2+mycontrol == null? 0 : mycontrol;

          //  }
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

          //  }
        }
        notifyListeners();
        if (paymodetype == "Wallet") {
          int? mycontrol7;
          int mycontrol8;
          int? walletcontrol = 0;
          // for (int i = 0; i < finalwalletsettled.length; i++) {
          //   Wtcollection=int.parse(getDBforfirstpage[i]["payamount"].toString());
          //   walletcollection=walletcollection+Wtcollection;
          //
          //   if (finalwalletsettled[i].checkClr == true) {
          //     payamount = int.parse(getDBforfirstpage[i]["payamount"].toString());
          //     mycontrol = mycontrol! + payamount;
          //   }
          // }
          // if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){
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

          // }
        }
        notifyListeners();
        if (paymodetype == "Coupon") {
          double? mycontrol9;
          double? mycontrol10;
          double? couponcontrol = 0;
          // for (int i = 0; i < finalcouponsettled.length; i++) {
          //    Cpcollection=int.parse(getDBforfirstpage[i]["payamount"].toString());
          //   Couponcollection=Couponcollection+Cpcollection;
          //
          //   if (finalcouponsettled[i].checkClr == true) {
          //     payamount = int.parse(getDBforfirstpage[i]["payamount"].toString());
          //     mycontrol = mycontrol! + payamount;
          //   }
          // }
          // if(mycontroller[0].text==getDBforfirstpage[i]["createdateTime"].toString()){
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

          //   }
        }
        // double netcollection = 0;

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
        // netcollection =
        //     mycontrol21 + mycontrol22 + mycontrol31 + mycontrol23 + mycontrol24;
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
    return listdata; // int.parse(data.substring(8));
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
        //! ch finalcardsettled
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
      //   //  collection=int.parse(finalcardsettled[i].rupees);
      // cardcollection=cardcollection+collection;
      final Database db = (await DBHelper.getInstance())!;
      List<DepositHeaderTDB> values = [];
      List<DepositLineTDB> depositLine = [];
      // docnumber generatiom

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
      //  await DBOperation.generateDocentr(db, "docentry", "SalesHeader");
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
      //log("docEntryCreateddocEntryCreated::" + docEntryCreated.toString());
      if (depositetype == "Cash") {
        // fomkeySet -> 5
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
                : totalChequeAmt.toStringAsFixed(2), //change
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
      //await DBOperation.insertDepositHeader(db, values);
      int? docentry2 = await DBOperation.insertDepositHeader(db, values);
      await DBOperation.updatenextno(db, 9, nextno);
      //log("docAAAAA" + docentry2.toString());
      if (depositetype == "Cash") {
        for (int iq = 0; iq < finalcashsettled.length; iq++) {
          // ! ch carddata
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
          // ! carddata finalcardsettled
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
          //
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
        // calculateDiff();
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
                payamount:
                    totalChequeAmt.toString(), //chequecollection.toString(),
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

        //  calculateDiff();
      }
      await DBOperation.insertDepositLine(db, depositLine, docentry2!);
      postRabitMqSettle(docentry2, depositetype);
      mycontroller[5].text = '';
      // mycontroller[4].text = '';
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

  // insertsettledheader(String depositetype, ThemeData theme) async {
  //   int i = 0;

  // if (fomkeySet[5].currentState!.validate()) {

  //  notifyListeners();
  //   if (
  //       depositetype == "Cash" && mycontroller[4].text.toString() != "") {
  //     //   //  collection=int.parse(finalcardsettled[i].rupees);
  //     // cardcollection=cardcollection+collection;
  //     final Database db = (await DBHelper.getInstance())!;
  //     List<DepositHeaderTDB> values = [];
  //     List<DepositLineTDB> DepositLine = [];
  //     //List<cardlist> cardvalue=[];
  //     // await DBOperation.deleteDepositTables(
  //     //     db, mycontroller[0].text, depositetype);
  //     int? documentNum = await DBOperation.getDocNOforsettled(
  //         db, "docnumber", "tableDepositHeader");
  //     print("documentNum:$documentNum");
  //     // await DBOperation.deleteDepositTables(
  //     //   db, mycontroller[0].text, depositetype);

  //     int? docEntryCreated = await DBOperation.generateDocentr(
  //         db, "docentry", "tableDepositHeader");
  // //log("docentry docEntryCreated : $docEntryCreated");
  //     values.add(DepositHeaderTDB(
  //         docentry: docEntryCreated,
  //         docdate: mycontroller[0].text,
  //         terminal: UserValues.terminal,
  //         branch: UserValues.branch,
  //         docnumber: documentNum.toString(),
  //         series: "",
  //         seriesnumber: documentNum.toString(),
  //         transdate: config.currentDate(),
  //         transtime: config.currentDate(),
  //         sysdatetime: "",
  //         typedeposit: depositetype,
  //         fromaccountcode: "",
  //         toaccountcode: "",
  //         amountsettled: mycontroller[5].text,
  //         remarks: "",
  //         createdatetime: config.currentDate(),
  //         updatedDatetime: config.currentDate(),
  //         createduserid: UserValues.userID.toString(),
  //         updateduserid: UserValues.userID.toString(),
  //         lastupdateip: UserValues.lastUpdateIp,
  //         doctype: 'Deposit',
  //         sapDocNo: null,
  //         qStatus: "",
  //         sapDocentry: null));

  //     int? docentry2 = await DBOperation.insertDepositHeader(db, values);
  // //log("docAAAAA" + docentry2.toString());
  //     if (depositetype == "Cash") {
  //       double collection;
  //       double cashtotalcollection = 0.00;
  //       double cardcollection;
  //       double collection1;
  //       double cardtotalcollection2 = 0.00;

  //         for (int il = 0; il < finalcashsettled.length; il++) {
  //           collection = finalcashsettled[il].rupees!.isEmpty
  //               ? 0.00
  //               : double.parse(finalcashsettled[il].rupees.toString());
  //           cashtotalcollection = cashtotalcollection + collection;
  //         }

  //         // }
  //         for (int iq = 0; iq < finalcashsettled.length; iq++) {
  //         DepositLine.add(DepositLineTDB(
  //             basedoctype: finalcashsettled[iq].basedoctype,
  //             basedocentry: finalcashsettled[iq].basedocentry,
  //             baselineid: finalcashsettled[iq].baselineid,
  //             terminal: UserValues.terminal,
  //             branch: UserValues.branch,
  //             docentry: docentry2.toString(),
  //             linenumber: "${iq}",
  //             transactionRefno: "",
  //             instrumentno: "",
  //             paymodetype: depositetype,
  //             payentry: forpayentry,
  //             paylineno: "",
  //             payamount: cashtotalcollection.toString(),
  //             ref1: "",
  //             ref2: "",
  //             ref3: "",
  //             paytransdate: "",
  //             commissionamount: "",
  //             nettosettle: mycontroller[5].text,
  //             createdatetime: config.currentDate(),
  //             updatedDatetime: config.currentDate(),
  //             createduserid: '1',
  //             updateduserid: '1',
  //             lastupdateip: UserValues.lastUpdateIp.toString()));
  //         }
  //          getinserttabular("Cash");
  //         //getinserttabular("Cash");
  //         notifyListeners();

  //         Get.defaultDialog(
  //                 title: "Alert",
  //                 middleText: "Successfully Saved..!!",
  //                 backgroundColor: Colors.white,
  //                 titleStyle:
  //                     theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
  //                 middleTextStyle: theme.textTheme.bodyMedium,
  //                 actions: [
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       TextButton(
  //                         child: Text("Close"),
  //                         onPressed: () => Get.back(),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //                 radius: 5)
  //             .then((value) {

  //           mycontroller[5].text = '';
  //           mycontroller[4].text = '';
  //           mycontroller[6].text = '';
  //           mycontroller[7].text = '';
  //         });
  //       // }
  //     }

  //     await DBOperation.insertDepositLine(db, DepositLine, docentry2!);
  //     // PostRabitMqSalesRet(docentry2);
  //       }
  //   if (depositetype == "Cash" && mycontroller[4].text.toString() == "") {
  //     await Get.defaultDialog(
  //         title: "Alert",
  //         middleText: "No Data Found..!!",
  //         backgroundColor: Colors.white,
  //         titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
  //         middleTextStyle: theme.textTheme.bodyMedium,
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.end,
  //             children: [
  //               TextButton(
  //                 child: Text("Close"),
  //                 onPressed: () => Get.back(),
  //               ),
  //             ],
  //           ),
  //         ],
  //         radius: 5);
  //   }

  // }
  //   notifyListeners();
  //   // calculateDiff();
  // }

//   insertsettledheader2(String depositetype, ThemeData theme) async {
//     int i = 0;
//     if (
//         depositetype == "Card" && finalcardsettled.isNotEmpty
//        ) {
//       //   //  collection=int.parse(finalcardsettled[i].rupees);
//       // cardcollection=cardcollection+collection;
//       final Database db = (await DBHelper.getInstance())!;
//       List<DepositHeaderTDB> values = [];
//       List<DepositLineTDB> DepositLine = [];
//       //List<cardlist> cardvalue=[];
//       // await DBOperation.deleteDepositTables(
//       //     db, mycontroller[0].text, depositetype);
//       int? documentNum = await DBOperation.getDocNOforsettled(
//           db, "docnumber", "tableDepositHeader");
//       print("documentNum:$documentNum");

//       int? docEntryCreated = await DBOperation.generateDocentr(
//           db, "docentry", "tableDepositHeader");
//   //log("docentry docEntryCreated : $docEntryCreated");
//       values.add(DepositHeaderTDB(
//           docentry: docEntryCreated,
//           docdate: mycontroller[0].text,
//           terminal: UserValues.terminal,
//           branch: UserValues.branch,
//           docnumber: documentNum.toString(),
//           series: "",
//           seriesnumber: documentNum.toString(),
//           transdate: config.currentDate(),
//           transtime: config.currentDate(),
//           sysdatetime: "",
//           typedeposit: depositetype,
//           fromaccountcode: "",
//           toaccountcode: "",
//           amountsettled: mycontroller[5].text,
//           remarks: "",
//           createdatetime: config.currentDate(),
//           updatedDatetime: config.currentDate(),
//           createduserid: UserValues.userID.toString(),
//           updateduserid: UserValues.userID.toString(),
//           lastupdateip: UserValues.lastUpdateIp,
//           doctype: 'Deposit',
//           sapDocNo: null,
//           qStatus: "",
//           sapDocentry: null));

//       int? docentry2 = await DBOperation.insertDepositHeader(db, values);
//   //log("docAAAAA" + docentry2.toString());

//       if (depositetype == "Card") {
//         double collection;
//         double cardtotalcollection = 0.00;
//         double cardcollection;
//         double collection1;
//         double cardtotalcollection2 = 0.00;

//         for (int ir = 0; ir < finalcardsettled2.length; ir++) {
//           collection = finalcardsettled2[ir].rupees.isEmpty
//               ? 0
//               : double.parse(finalcardsettled2[ir].rupees.toString());
//           cardtotalcollection = cardtotalcollection + collection;
//         }
//         for (int im = 0; im < finalcardsettled2.length; im++) {
//       //log("lengh:"+finalcardsettled.length.toString());
//         DepositLine.add(DepositLineTDB(
//             basedoctype: finalcardsettled2[im].basedoctype,
//             basedocentry: finalcardsettled2[im].docentry,
//             baselineid: finalcardsettled2[im].baselineid,
//             docentry: docentry2.toString(),
//             terminal: UserValues.terminal,
//             branch: UserValues.branch,
//             linenumber: "${im}",
//             transactionRefno: "",
//             instrumentno: "",
//             paymodetype: depositetype,
//             payentry: forpayentry,
//             paylineno: "",
//             payamount: cardtotalcollection.toString(),
//             ref1: "",
//             ref2: "",
//             ref3: "",
//             paytransdate: "",
//             commissionamount: "",
//             nettosettle: "",
//             createdatetime: config.currentDate(),
//             updatedDatetime: config.currentDate(),
//             createduserid: '1',
//             updateduserid: '1',
//             lastupdateip: UserValues.lastUpdateIp.toString()));
//         }
// getinserttabular("Card");
//         notifyListeners();
//         // }

//         Get.defaultDialog(
//                 title: "Alert",
//                 middleText: "Successfully Saved..!!",
//                 backgroundColor: Colors.white,
//                 titleStyle:
//                     theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//                 middleTextStyle: theme.textTheme.bodyMedium,
//                 actions: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: Text("Close"),
//                         onPressed: () => Get.back(),
//                       ),
//                     ],
//                   ),
//                 ],
//                 radius: 5)
//             .then((value) {
//           hintcolor = false;
//           paytermvaluechoose = null;

//           // finalcardsettled.clear();
//         });
//         // calculateDiff();
//       }

//       await DBOperation.insertDepositLine(db, DepositLine, docentry2!);
//       // PostRabitMqSalesRet(docentry2);

//        }
//     if (depositetype == "Card" && finalcardsettled.isEmpty) {
//       await Get.defaultDialog(
//           title: "Alert",
//           middleText: "No Data Found..!!",
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyMedium,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     }

//     notifyListeners();
//     // calculateDiff();
//   }
//   insertsettledheader3(String depositetype, ThemeData theme) async {
//     int i = 0;
//     if (depositetype == "Cheque" && finalchequesettled.isNotEmpty
//         ) {
//       final Database db = (await DBHelper.getInstance())!;
//       List<DepositHeaderTDB> values = [];
//       List<DepositLineTDB> DepositLine = [];

//       int? documentNum = await DBOperation.getDocNOforsettled(
//           db, "docnumber", "tableDepositHeader");
//       print("documentNum:$documentNum");

//       int? docEntryCreated = await DBOperation.generateDocentr(
//           db, "docentry", "tableDepositHeader");
//   //log("docentry docEntryCreated : $docEntryCreated");
//       values.add(DepositHeaderTDB(
//           docentry: docEntryCreated,
//           docdate: mycontroller[0].text,
//           terminal: UserValues.terminal,
//           branch: UserValues.branch,
//           docnumber: documentNum.toString(),
//           series: "",
//           seriesnumber: documentNum.toString(),
//           transdate: config.currentDate(),
//           transtime: config.currentDate(),
//           sysdatetime: "",
//           typedeposit: depositetype,
//           fromaccountcode: "",
//           toaccountcode: "",
//           amountsettled: mycontroller[5].text,
//           remarks: "",
//           createdatetime: config.currentDate(),
//           updatedDatetime: config.currentDate(),
//           createduserid: UserValues.userID.toString(),
//           updateduserid: UserValues.userID.toString(),
//           lastupdateip: UserValues.lastUpdateIp,
//           doctype: 'Deposit',
//           sapDocNo: null,
//           qStatus: "",
//           sapDocentry: null));

//       int? docentry2 = await DBOperation.insertDepositHeader(db, values);
//   //log("docAAAAA" + docentry2.toString());

//       if (depositetype == "Cheque") {
//         double collection;
//         double chequetotalcollection = 0.00;
//         double collection2;
//         double chequecollection = 0.00;

//         for (int ia = 0; ia < finalchequesettled2.length; ia++) {
//           collection = finalchequesettled2[ia].rupees.isEmpty
//               ? 0
//               : double.parse(finalchequesettled2[ia].rupees.toString());
//           chequetotalcollection = chequetotalcollection + collection;
//         }
//         for (int ia = 0; ia < finalchequesettled2.length; ia++) {
//         //   if (finalchequesettled[ia].checkClr == true) {
//         //     collection2 = finalchequesettled[ia].rupees.isEmpty
//         //         ? 0
//         //         : double.parse(finalchequesettled[ia].rupees.toString());
//         //     chequecollection = chequecollection + collection2;

//         // //log("SSSSSSSSSSS" + finalchequesettled[ia].name.toString());

//         DepositLine.add(DepositLineTDB(
//             basedoctype: finalchequesettled2[ia].basedoctype,
//             basedocentry: finalchequesettled2[ia].docentry,
//             baselineid: finalchequesettled2[ia].baselineid,
//             docentry: docentry2.toString(),
//             terminal: UserValues.terminal,
//             branch: UserValues.branch,
//             linenumber: "${i}",
//             transactionRefno: finalchequesettled2[ia].name.toString(),
//             instrumentno: "",
//             paymodetype: depositetype,
//             payentry: forpayentry,
//             paylineno: "",
//             payamount: chequetotalcollection.toString(),
//             ref1: "",
//             ref2: "",
//             ref3: "",
//             paytransdate: "",
//             commissionamount: "",
//             nettosettle: "",
//             createdatetime: config.currentDate(),
//             updatedDatetime: config.currentDate(),
//             createduserid: '1',
//             updateduserid: '1',
//             lastupdateip: UserValues.lastUpdateIp.toString()));
//         }
//  getinserttabular("Cheque");
//         notifyListeners();
//         // }

//         Get.defaultDialog(
//                 title: "Alert",
//                 middleText: "Successfully Saved..!!",
//                 backgroundColor: Colors.white,
//                 titleStyle:
//                     theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//                 middleTextStyle: theme.textTheme.bodyMedium,
//                 actions: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         child: Text("Close"),
//                         onPressed: () => Get.back(),
//                       ),
//                     ],
//                   ),
//                 ],
//                 radius: 5)
//             .then((value) {
//           // finalchequesettled.clear();
//         });

//         //  calculateDiff();
//       }

//       await DBOperation.insertDepositLine(db, DepositLine, docentry2!);
//       // PostRabitMqSalesRet(docentry2);
//         }
//     if (depositetype == "Cheque" && finalchequesettled.isEmpty) {
//       await Get.defaultDialog(
//           title: "Alert",
//           middleText: "No Data Found..!!",
//           backgroundColor: Colors.white,
//           titleStyle: theme.textTheme.bodyMedium!.copyWith(color: Colors.red),
//           middleTextStyle: theme.textTheme.bodyMedium,
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   child: Text("Close"),
//                   onPressed: () => Get.back(),
//                 ),
//               ],
//             ),
//           ],
//           radius: 5);
//     }

//     notifyListeners();
//     // calculateDiff();
//   }

// amountpaid(){
//   log("Anbufor Deposit");

// receivedamount=double.parse(mycontroller[4].text);
// settledamount=int.parse(mycontroller[5].text);
//    if ( settledamount !=
//                                                           receivedamount
//                                                               .ceil() ||
//                                                       settledamount !=
//                                                         receivedamount
//                                                               .floor()) {
//                                                     return "Enter Correct Amount";
//                                                   }
// else{
//   return null;
// }
// }

  postRabitMqSettle(int docentry, String mode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBDepositHeader =
        await DBOperation.getDepositHeadDB(db, docentry);
    List<Map<String, Object?>> getDBDepositLine =
        await DBOperation.getDepositLineDB(db, docentry);

    String depositHeader = json.encode(getDBDepositHeader);
    String depositLine = json.encode(getDBDepositLine);

    String ddd = pushContent(mode, depositHeader, depositLine);

    //RabitMQ
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

  postRabitMqSettle2(int docentry, String mode) async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> getDBDepositHeader =
        await DBOperation.getDepositHeadDB(db, docentry);
    List<Map<String, Object?>> getDBDepositLine =
        await DBOperation.getDepositLineDB(db, docentry);

    String depositHeader = json.encode(getDBDepositHeader);
    String depositLine = json.encode(getDBDepositLine);

    String ddd = pushContent(mode, depositHeader, depositLine);

    //RabitMQ
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

  String pushContent(String mode, String depositHeader, String depositLine) {
    String result = '';
    if (mode == 'Cash') {
      result = json.encode({
        "ObjectType": 13,
        "ActionType": "Add",
        "DepositCashHeader": depositHeader,
        "DepositCashLine": depositLine,
      });
      //log("payload : $result");
    } else if (mode == 'Card') {
      result = json.encode({
        "ObjectType": 11,
        "ActionType": "Add",
        "DepositCardHeader": depositHeader,
        "DepositCardLine": depositLine,
      });
      //log("payload : $result");
    } else {
      result = json.encode({
        "ObjectType": 12,
        "ActionType": "Add",
        "DepositChequeHeader": depositHeader,
        "DepositChequeLine": depositLine,
      });
      //log("payload : $rsult");
    }
    return result;
  }

  // PostRabitMqSettle2(int docentry) async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> getDBDepositHeader = await DBOperation.getDepositHeadDB(db, docentry);
  //   List<Map<String, Object?>> getDBDepositLine = await DBOperation.getDepositLineDB(db, docentry);

  //   String DepositHeader = json.encode(getDBDepositHeader);
  //   String DepositLine = json.encode(getDBDepositLine);

  // var ddd = json.encode({
  //   "TypeCode": 8,
  //   "TypeName": "Deposit",
  //   "DepositHeader": DepositHeader,
  //   "DepositLine": DepositLine,
  // });
  // log("payload : $ddd");

  // //RabitMQ
  // Client client = Client();
  // ConnectionSettings settings = ConnectionSettings(
  //     host: "${AppConstant.ip.toString().trim()}",
  //     // AppConstant.ip,
  //     //"102.69.167.106"
  //     port: 5672,
  //     authProvider: PlainAuthenticator("buson", "BusOn123"));
  // Client client1 = Client(settings: settings);

  // MessageProperties properties = new MessageProperties();

  // properties.headers = {"Branch": UserValues.branch};
  // Channel channel = await client1.channel(); //Server_CS
  // Exchange exchange =
  //     await channel.exchange("POS", ExchangeType.HEADERS, durable: true);
  // exchange.publish(ddd, "", properties: properties);
  // //cs
  // properties.headers = {"Branch": "Server"};
  // exchange.publish(ddd, "", properties: properties);
  // client1.close();
  // }

  forwalletlistorder(
      BuildContext context, String rcmode, ThemeData theme) async {
    if (fomkeySet2.currentState!.validate()) {
      // fomkeySet 2
      notifyListeners();
      //log("SAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//log("aagafgafgsf:"+"$indx");
//if(indx !=null){
      // if (finalwalletsettled.isEmpty) {
      savepaylist(rcmode, context, theme, 1);
      notifyListeners();
      // } else {
      // //   log("HHHHHHHHHH");

      //   int? arSc = await checkSameSerialBatchScnd(rcmode);
      //   log("arSc $arSc");
      //   if (arSc != null) {
      //     showDialog(
      //         context: context,
      //         barrierDismissible: true,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //               contentPadding: EdgeInsets.all(0),
      //               content: AlertBox(
      //                 payMent: 'Alert',
      //                 errormsg: true,
      //                 widget: Center(
      //                     child: ContentContainer(
      //                   content: 'Wallet No Already scanned..!!',
      //                   theme: theme,
      //                 )),
      //                 buttonName: null,
      //               ));
      //         });
      //   }
      // }
//}
    }
    notifyListeners();
  }

  checkSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    // List<Map<String, Object?>> getDBholddata5 =
    //     await DBOperation.getSalesHeaderDBforsellement(db); //getHoldSalesPayDB
    // for (int ib = 0; ib < getDBholddata5.length; ib++) {
    //   List<Map<String, Object?>> getDBsalespaysettle5 =
    //       await DBOperation.getSalesPaysettleDB(
    //           db, int.parse(getDBholddata5[ib]['docentry'].toString()), rcmode);
    List<Map<String, Object?>> getDBsalespaysettle5 =
        await DBOperation.finalforDeposit(db, rcmode);
    for (int i = 0; i < finalwalletsettled.length; i++) {
      if (getDBsalespaysettle5[i]["docentry"].toString() ==
          finalwalletsettled[i].docentry) {
        return Future.value(i);
      }
      notifyListeners();
      return Future.value(null);
      // }
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

// new Deposit for cash card cheque
  forcashlistorder(BuildContext context, String rcmode, ThemeData theme) async {
    // if (finalcashsettled.isEmpty) {
    savepaylist(rcmode, context, theme, 1);
    notifyListeners();
    // }
//     else {
//   //log("HHHHHHHHHH");

//       int? arSc = await checkCashSameSerialBatchScnd(rcmode);
//   //log("arSc $arSc");
//       // if (arSc != null) {
//       //   showDialog(
//       //       context: context,
//       //       barrierDismissible: true,
//       //       builder: (BuildContext context) {
//       //         return AlertDialog(
//       //             contentPadding: EdgeInsets.all(0),
//       //             content: AlertBox(
//       //               payMent: 'Alert',
//       //               errormsg: true,
//       //               widget: Center(
//       //                   child: ContentContainer(
//       //                 content: 'Card No Already scanned..!!',
//       //                 theme: theme,
//       //               )),
//       //               buttonName: null,
//       //             ));
//       //       });
//       // }
//     }
// //}
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
      // }
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
    // if(finalcardsettled.isNotEmpty){}
    for (int i = 0; i < finalcardsettled.length; i++) {
      if (finalcardsettled[i].cardterminal == cardterminal) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  Future<int?> checkChequelistloop(String customername) {
    // if(finalcardsettled.isNotEmpty){}
    for (int i = 0; i < finalchequesettled.length; i++) {
      if (finalchequesettled[i].name == customername) {
        return Future.value(i);
      }
    }
    notifyListeners();
    return Future.value(null);
  }

  // Future<int?> checkcardvaluelistloop(String cardtype) {
  //   // if(finalcardsettled.isNotEmpty){}
  //   for (int i = 0; i < finalcardsettled.length; i++) {
  //     if (finalcardsettled[i].cardtype == cardtype) {
  //       print('customername:$cardtype');
  //       return Future.value(i);
  //     }
  //   }
  //   notifyListeners();
  //   return Future.value(null);
  // }

  Future<int?> checkCouponlistloop(String customername) {
    // if(finalcardsettled.isNotEmpty){}
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

    // List<Map<String, Object?>> getDBholddata5 =
    //     await DBOperation.getSalesHeaderDBforsellement(db); //getHoldSalesPayDB
    // for (int ib = 0; ib < getDBholddata5.length; ib++) {
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
    // }&&getDBsalespaysettle5[i]["customername"].toString() ==
    // finalcardsettled[i].name
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
      // }
    }
  }

  forcouponlistorder(
      BuildContext context, String rcmode, ThemeData theme) async {
    if (fomkeySet.currentState!.validate()) {
      // fomkeySet
      // notifyListeners();
      // log("SAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
//log("aagafgafgsf:"+"$indx");
//if(indx !=null){
      // if (finalcouponsettled.isEmpty) {
      savepaylist(rcmode, context, theme, 1);
      // } else {
      //   log("HHHHHHHHHH");

      //   int? arSc = await checkcouponSameSerialBatchScnd(rcmode);
      //   log("arSc $arSc");
      //   if (arSc != null) {
      //     showDialog(
      //         context: context,
      //         barrierDismissible: true,
      //         builder: (BuildContext context) {
      //           return AlertDialog(
      //               contentPadding: EdgeInsets.all(0),
      //               content: AlertBox(
      //                 payMent: 'Alert',
      //                 errormsg: true,
      //                 widget: Center(
      //                     child: ContentContainer(
      //                   content: 'Coupon No Already scanned..!!',
      //                   theme: theme,
      //                 )),
      //                 buttonName: null,
      //               ));
      //         });
      //   }
      // }
//}
    }
    notifyListeners();
  }

  checkcouponSameSerialBatchScnd(String rcmode) async {
    final Database db = (await DBHelper.getInstance())!;

    // List<Map<String, Object?>> getDBholddata5 =
    //     await DBOperation.getSalesHeaderDBforsellement(db); //getHoldSalesPayDB
    // for (int ib = 0; ib < getDBholddata5.length; ib++) {
    //   List<Map<String, Object?>> getDBsalespaysettle5 =
    //       await DBOperation.getSalesPaysettleDB(
    //           db, int.parse(getDBholddata5[ib]['docentry'].toString()), rcmode);
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

  // logcheck() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> getDBsalespaysettle5 =
  //       await DBOperation.loggetSalesPay(
  //     db,
  //   );
  //   notifyListeners();
  // }

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
    finalcardsettled2.clear(); //getHoldSalesPayDB
    finalchequesettled2.clear();
    finalcardsettled.clear();
    finalcashsettled.clear();
    finalchequesettled.clear();
    finalwalletsettled.clear();
    finalcouponsettled.clear();
    totalCheque = 0.00;
    cardData.clear();
    // var now = DateTime.now();
    // var formatter = DateFormat('dd-MM-yyyy');
    // String formattedDate = formatter.format(now);
    // ! put this and  sa.createdateTime like '2023-08-18%' this function finalforDeposit();
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
          //log("Cashhhhhhrccc:" + rccash.toString());
          //log("Methooodddddd2:" +
          // getDBsalespaysettle5[i]["rcamount"].toString());
          finalcashsettled.add(cashsettled);
          //log("Methooodddddd2:" + finalcashsettled.length.toString());
          //log("Cashhhhhh:" + rccash.toString());
          mycontroller[4].text = rccash.toString();
          // log("cardterminal" + finalcashsettled[i].docentry.toString());
          // log("aprovelNo" + finalcashsettled[i].rupees.toString());
          notifyListeners();
        }

        if (rcmode == "Card") {
          if (paytermvaluechoose ==
              getDBsalespaysettle5[i]["cardterminal"].toString()) {
            //log("Card inside::::::");

            // cardlist cardsettled2 = cardlist(
            //   basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
            //   //  getDBsalespaysettle5[i]['doctype'].toString() ,

            //   baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
            //   // getDBsalespaysettle5[i]['lineid'].toString() ,

            //   docentry: getDBsalespaysettle5[i]['docentry'].toString(),
            //   //  getDBsalespaysettle5[i]['docentry'].toString(),

            //   cardterminal: getDBsalespaysettle5[i]["cardterminal"].toString(),
            //   ApprovelNo: getDBsalespaysettle5[i]['cardApprno'].toString(),
            //   // getDBsalespaysettle5[0]['cardApprno'].toString(),
            //   Cardref: "",
            //   // getDBsalespaysettle5[i]['cardref'].toString(),
            //   rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
            //   // getDBsalespaysettle5[i]['rcamount'].toString(),
            //   name: "",
            //   // getDBsalespaysettle5[i]['customername'].toString(),
            //   // onchanged: onchanged,
            //   PhNo: getDBsalespaysettle5[i]["customerphono"].toString().isEmpty
            //       ? 0
            //       : int.parse(
            //           getDBsalespaysettle5[i]["customerphono"].toString()),
            //   Date: config
            //       .alignDate(getDBsalespaysettle5[i]['rcdatetime'].toString()),
            //   // config.alignDate(getDBsalespaysettle5[0]['rcdatetime'].toString()),
            //   //  getDBsalespaysettle5[i]['rcdatetime'].toString(),
            //   checkClr: true,
            //   onchanged: 1,
            // );

            // finalcardsettled2.add(cardsettled2);
            // log("ssjjdjsjdjasjssssssfinalsettled2:" +
            //     finalcardsettled.length.toString());

            // if (finalcardsettled.isNotEmpty) {
            //   rccard = rccard +
            //       double.parse(getDBsalespaysettle5[i]['rcamount'].toString());
            //   for (int j = 0; j < finalcardsettled.length; j++) {
            //     paycash = double.parse(
            //         getDBsalespaysettle5[i]["rcamount"].toString());
            //     rccash = double.parse(finalcardsettled[j].rupees.toString()) +
            //         double.parse(
            //             getDBsalespaysettle5[i]["rcamount"].toString());
            //     finalcardsettled[j].rupees = rccash.toString();
            //     totalCardAmt = rccash;
            //   }

            // } else {
            //   cardlist cardsettled = cardlist(
            //     basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
            //     //  getDBsalespaysettle5[i]['doctype'].toString() ,

            //     baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
            //     // getDBsalespaysettle5[i]['lineid'].toString() ,

            //     docentry: getDBsalespaysettle5[i]['docentry'].toString(),
            //     //  getDBsalespaysettle5[i]['docentry'].toString(),

            //     cardterminal:
            //         getDBsalespaysettle5[i]["cardterminal"].toString(),
            //     ApprovelNo: getDBsalespaysettle5[i]['cardApprno'].toString(),
            //     // getDBsalespaysettle5[0]['cardApprno'].toString(),
            //     Cardref: "",
            //     // getDBsalespaysettle5[i]['cardref'].toString(),
            //     rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
            //     // getDBsalespaysettle5[i]['rcamount'].toString(),
            //     name: "",
            //     // getDBsalespaysettle5[i]['customername'].toString(),
            //     // onchanged: onchanged,
            //     PhNo: getDBsalespaysettle5[i]["customerphono"]
            //             .toString()
            //             .isEmpty
            //         ? 0
            //         : int.parse(
            //             getDBsalespaysettle5[i]["customerphono"].toString()),
            //     Date: config.alignDate(
            //         getDBsalespaysettle5[i]['rcdatetime'].toString()),
            //     // config.alignDate(getDBsalespaysettle5[0]['rcdatetime'].toString()),
            //     //  getDBsalespaysettle5[i]['rcdatetime'].toString(),
            //     checkClr: true,
            //     onchanged: 1,
            //   );

            //   finalcardsettled.add(cardsettled);
            //   totalCardAmt = sumofcard(finalcardsettled);
            //   log("totalCardAmt" + totalCardAmt.toString());

            // }
            getAllCardTransactions(getDBsalespaysettle5[i]);
            notifyListeners();

            // }
          }
        }
        if (rcmode == "Cheque") {
          if (getDBsalespaysettle5[i]['doctype'].toString() != "Expense") {
            ChequeList chequesettled2 = ChequeList(
              basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
              // getDBsalespaysettle5[i]['doctype'].toString(),

              baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
              //  getDBsalespaysettle5[i]['lineid'].toString(),

              docentry: getDBsalespaysettle5[i]['docentry'].toString(),
              // getDBsalespaysettle5[i]['docentry'].toString(),

              name: "",
              // getDBsalespaysettle5[i]["customername"].toString(),
              PhNo: getDBsalespaysettle5[i]["customerphono"].toString().isEmpty
                  ? 0
                  : int.parse(
                      getDBsalespaysettle5[i]["customerphono"].toString()),
              rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
              // onchanged: onchanged,
              chequeNo: getDBsalespaysettle5[i]["chequeno"].toString(),
              // getDBsalespaysettle5[0]["chequeno"].toString(),
              chequeDate: getDBsalespaysettle5[i]["chequedate"].toString(),
              // config
              //     .alignDate(getDBsalespaysettle5[0]["chequedate"].toString())==""?"": config
              //     .alignDate(getDBsalespaysettle5[0]["chequedate"].toString()),

              //  getDBsalespaysettle5[i]["chequedate"].toString(),
              checkClr: false,
              onchanged: 1,
              rcdocentry: getDBsalespaysettle5[i]["rcdocentry"].toString(),
              rcdoctno: getDBsalespaysettle5[i]["rcnumber"].toString(),
            );
            finalchequesettled2.add(chequesettled2);
            notifyListeners();

            // if (finalchequesettled.isNotEmpty) {
            //   rccard = rccard +
            //       double.parse(getDBsalespaysettle5[i]['rcamount'].toString());
            //   for (int j = 0; j < finalchequesettled.length; j++) {
            //     paycash = double.parse(
            //         getDBsalespaysettle5[i]["rcamount"].toString());
            //     rccash = double.parse(finalchequesettled[j].rupees.toString()) +
            //         double.parse(
            //             getDBsalespaysettle5[i]["rcamount"].toString());
            //     finalchequesettled[j].rupees = rccash.toString();
            //     totalChequeAmt = rccash;
            //   }
            // } else {
            ChequeList chequesettled = ChequeList(
              basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
              // ,
              docno: getDBsalespaysettle5[i]['documentno'].toString(),
              baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
              //  getDBsalespaysettle5[i]['lineid'].toString(),

              docentry: getDBsalespaysettle5[i]['docentry'].toString(),
              // getDBsalespaysettle5[i]['docentry'].toString(),

              name: "",
              rcmode: getDBsalespaysettle5[i]["rcmode"].toString(),
              // getDBsalespaysettle5[i]["customername"].toString(),
              PhNo: getDBsalespaysettle5[i]["customerphono"].toString().isEmpty
                  ? 0
                  : int.parse(
                      getDBsalespaysettle5[i]["customerphono"].toString()),
              rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
              // onchanged: onchanged,
              chequeNo: getDBsalespaysettle5[i]["chequeno"].toString(),
              // getDBsalespaysettle5[0]["chequeno"].toString(),
              chequeDate: config
                  .alignDate(getDBsalespaysettle5[i]["chequedate"].toString()),
              // config
              //     .alignDate(getDBsalespaysettle5[0]["chequedate"].toString())==""?"": config
              //     .alignDate(getDBsalespaysettle5[0]["chequedate"].toString()),

              //  getDBsalespaysettle5[i]["chequedate"].toString(),
              checkClr: false,
              onchanged: 1,
              rcdocentry: getDBsalespaysettle5[i]["rcdocentry"].toString(),
              rcdoctno: getDBsalespaysettle5[i]["rcnumber"].toString(),
            );
            finalchequesettled.add(chequesettled);
            totalChequeAmt = sumofcheque(finalchequesettled);
            // finalchequesettled.map((e) => totalChequeAmt = double.parse(e.rupees));
            // }
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
// toalcheckAmount() async {
//     double rccheque = 0.00;
//     double? paycash;
//     List<StockSnapTModelDB> stockSnap = [];
//     final Database db = (await DBHelper.getInstance())!;

//     List<Map<String, Object?>> getDBsalespaysettle5 =
//         await DBOperation.finalforDeposit(db, "Cheque"); //getHoldSalesPayDB
//     var now = new DateTime.now();
//     var formatter = new DateFormat('dd-MM-yyyy');
//     String formattedDate = formatter.format(now);

//     for (int i = 0; i < getDBsalespaysettle5.length; i++) {
//       forpayentry = getDBsalespaysettle5[i]['docentry'].toString();
//       chequeline = getDBsalespaysettle5[i]["chequeno"].toString();
//       if (config.alignDateT(getDBsalespaysettle5[i]["rcdatetime"].toString()) ==
//           formattedDate.toString()&&formattedDate.toString()==mycontroller[0].text.toString()) {
//         if (getDBsalespaysettle5[i]['rcmode'].toString() == "Cheque") {
//           if (getDBsalespaysettle5[i]['doctype'].toString() != "Expense") {

//             rccheque = rccheque +
//                 double.parse(getDBsalespaysettle5[i]["rcamount"].toString());

//           }
//         }
//       }
//     }

//     notifyListeners();
//   }

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
    // if (finalchequesettled[i].checkClr == false) {
    //   print("AAAAAA");

    //   finalchequesettled[i].checkClr = true;
    //   totalCheque = 0.00;
    //   notifyListeners();
    // } else if (finalchequesettled[i].checkClr == true) {
    //   print('BBBBBBB');

    //   finalchequesettled[i].checkClr = false;
    //   totalCheque =  double.parse(finalchequesettled[i].rupees);
    calculateValueofChequeUnselected();
    // }

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

  // oncardtapisload() {
  //   iscardload = true;
  //   log("NNNNNNNNNNN" + iscardload.toString());
  //   notifyListeners();
  // }

  oncoupontapisload() {
    iscouponload = true;
    notifyListeners();
  }

  //DateTime datetime=DateTime.now();

  String currentDate() {
    DateTime now = DateTime.now();

    String currentDateTime =
        "${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')}";
    nowaday = currentDateTime;
    return currentDateTime;
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
    // if (mycontroller[0].text != nowaday) {
    //   mycontroller[1].text = "";
    //   mycontroller[2].text = "";
    //   mycontroller[3].text = "";
    //   mycontroller[9].text = "";
    //   mycontroller[12].text = "";
    //   mycontroller[9].text = "";
    //   mycontroller[21].text = "";
    //   mycontroller[18].text = "";

    //   mycontroller[8].text = "";
    //   mycontroller[10].text = "";
    //   mycontroller[11].text = "";
    //   mycontroller[13].text = "";
    //   mycontroller[14].text = "";
    //   mycontroller[15].text = "";
    //   mycontroller[16].text = "";
    //   mycontroller[17].text = "";
    //   mycontroller[19].text = "";
    //   mycontroller[20].text = "";
    //   log("aaaaa" + nowaday.toString());
    //   log("onsubmit" + mycontroller[0].text);
    //   pastdata("Cash");
    //   pastdata("Card");

    //   pastdata("Cheque");
    //   pastdata("Wallet");
    //   pastdata("Coupon");
    //   notifyListeners();
    // }
    //  if (mycontroller[0].txt == nowaday) {
    //log("OOOOOOOOOOOOOOOOOOOOO" + currentDate());

    // pastdata("Wallet");
    // pastdata("Coupon");
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
    // pastdata("Cash");
    // pastdata("Card");
    // pastdata("Cheque");
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
    // } else {
    //   print("Date is not selected");
    // }

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

  //totalSettledCash

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
      // if(netAmout.length>2 && i == netAmout.length -1){
      //   salesAmt =  salesAmt - double.parse( netAmout[i]['rcamount'].toString());
      // }else
      // {
      //   salesAmt =  salesAmt +double.parse( netAmout[i]['rcamount'].toString());
      // }
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
    valuechoose = newvalue;
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

  // List Walletlistt = [
  //   'GPAY',
  //   'PAYTM',
  //   'UPI',
  //   'PHONEPE',
  //   'BAHRAT PE',
  //   'MOBILE MONEY'
  // ];
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
  // "HDFC Machine",
  // 'Pinelabs Machine - 1',
  // 'Pinelabs - Accessories',
  // 'Pinelabs - 2nd Counter'

  payTermdropdown(newvalue) {
    // notifyListeners();
    paytermvaluechoose = newvalue;
    finalcardsettled.clear();
    notifyListeners();
//  if(newvalue!=paytermvaluechoose){
//  x
//   notifyListeners();
//   }
  }
  // deleteDepositheader() async{
  //    final Database db = (await DBHelper.getInstance())!;

  //   DBOperation.forunwantedheader(db);
  //   notifyListeners();
  // }

  deleteDeposittb() async {
    final Database db = (await DBHelper.getInstance())!;

    DBOperation.deleteDeposit(db);
    notifyListeners();
  }

  /// ? card Functions

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

//     basedoctype: getDBsalespaysettle5[i]['doctype'].toString(),
//     //  getDBsalespaysettle5[i]['doctype'].toString() ,
//     baselineid: getDBsalespaysettle5[i]['lineid'].toString(),
//     // getDBsalespaysettle5[i]['lineid'].toString() ,
//     docentry: getDBsalespaysettle5[i]['docentry'].toString(),
//     //  getDBsalespaysettle5[i]['docentry'].toString(),
//     cardterminal:
//         getDBsalespaysettle5[i]["cardterminal"].toString(),
//     ApprovelNo: getDBsalespaysettle5[i]['cardApprno'].toString(),
//     // getDBsalespaysettle5[0]['cardApprno'].toString(),
//     Cardref: "",
//     // getDBsalespaysettle5[i]['cardref'].toString(),
//     rupees: getDBsalespaysettle5[i]['rcamount'].toString(),
//     // getDBsalespaysettle5[i]['rcamount'].toString(),
//     name: "",
//     // getDBsalespaysettle5[i]['customername'].toString(),
//     // onchanged: onchanged,
//     PhNo: getDBsalespaysettle5[i]["customerphono"]
//             .toString()
//             .isEmpty
//         ? 0
//         : int.parse(
//             getDBsalespaysettle5[i]["customerphono"].toString()),
//     Date: config.alignDate(
//         getDBsalespaysettle5[i]['rcdatetime'].toString()),
//     // config.alignDate(getDBsalespaysettle5[0]['rcdatetime'].toString()),
//     //  getDBsalespaysettle5[i]['rcdatetime'].toString(),
//     checkClr: true,
//     onchanged: 1,
//   );
