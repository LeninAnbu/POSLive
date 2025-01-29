import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/Screen.dart';
import '../../Models/Service Model/CreateCustPostModel.dart';
import '../../Models/Service Model/RecoModel/RecoListModel.dart';
import '../../Models/Service Model/RecoModel/RecoPostModel.dart';
import '../../Service/NewReportsApi/RecoApi/CustomerCodeApi.dart';
import '../../Service/NewReportsApi/RecoApi/GetRecoListApi.dart';
import '../../Service/NewReportsApi/RecoApi/RecoPostApi.dart';
import '../../ServiceLayerAPIss/QuotationAPI/LoginnAPI.dart';
import '../../Widgets/AlertBox.dart';
import '../../Widgets/ContentContainer.dart';

class ReconciliationCtrl extends ChangeNotifier {
  init() async {
    clearAllData();
    searchInit();
    await callReportCompoApi();
  }

  Configure config = Configure();
  List<TextEditingController> mycontroller =
      List.generate(1000, (i) => TextEditingController());
  List<TextEditingController> recoAmtcontroller =
      List.generate(1000, (i) => TextEditingController());
  bool showListVal = false;
  bool selectcheckList = false;
  bool onDisablebutton = false;
  String cardName = '';
  String cardCode = '';
  String custCodeError = '';

  double? totalRecoAmt;

  clearAllData() {
    loadingscrn = false;
    showListVal = false;
    cardName = '';
    cardCode = '';
    custCodeError = '';
    loadingscrn = false;
    onDisablebutton = false;
    noDataMsg = '';
    totalRecoAmt = null;
    recoListItemData = [];
    listBoxData = [];
    filterListBoxData = [];
    recoAmtcontroller = List.generate(1000, (i) => TextEditingController());
    mycontroller = List.generate(1000, (i) => TextEditingController());
    notifyListeners();
  }

  searchInit() {
    mycontroller[1].text = config.alignDate(config.currentDate());
    notifyListeners();
  }

  getDate(
    BuildContext context,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    String datetype = DateFormat('yyyy-MM-dd').format(pickedDate!);
    mycontroller[1].text = config.alignDate(datetype);
    notifyListeners();
  }

  bool loadingscrn = false;
  List<cardCodeList> listBoxData = [];
  List<cardCodeList> filterListBoxData = [];
  filterListOnList(String v) {
    if (v.isNotEmpty) {
      filterListBoxData = listBoxData
          .where((e) => e.cardCode
              .toString()
              .trim()
              .toLowerCase()
              .contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterListBoxData = listBoxData;
      notifyListeners();
    }
    log("salesModelsalesModel.length:${listBoxData.length}");
    notifyListeners();
  }

  callReportCompoApi() async {
    cardCode = '';
    loadingscrn = true;
    filterListBoxData = [];
    await CardCodeApi.getGlobalData().then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.cardcodeList.isNotEmpty) {
          listBoxData = value.cardcodeList;

          filterListBoxData = listBoxData;
        }
        loadingscrn = false;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        loadingscrn = false;
        notifyListeners();
      } else {
        loadingscrn = false;
      }
    });
    notifyListeners();
  }

  doubleDotMethodPayTerms(int i, val) {
    String originalString = val;
    String modifiedString = originalString.replaceAll("-", ".");
    String modifiedString2 = modifiedString.replaceAll("..", ".");

    recoAmtcontroller[i].text = modifiedString2.toString();
    log(recoAmtcontroller[i].text); // Output: example-text-with-double-dots
    notifyListeners();
  }

  List<RecoModelData> recoListItemData = [];
  String noDataMsg = '';
  callRecoListApi() async {
    recoListItemData = [];
    loadingscrn = true;
    noDataMsg = '';
    await RecoListApi.getGlobalData(mycontroller[0].text.trim()).then((value) {
      if (value.statuscode >= 200 && value.statuscode <= 210) {
        if (value.recoListData!.isNotEmpty) {
          recoListItemData = value.recoListData!;

          for (var i = 0; i < recoListItemData.length; i++) {
            recoListItemData[i].listclr = false;
            recoAmtcontroller[i].text =
                recoListItemData[i].reconcileAmount.toStringAsFixed(6);
          }
        } else {
          noDataMsg = 'No data found';
          notifyListeners();
        }

        loadingscrn = false;
        notifyListeners();
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        noDataMsg = value.exception!;
        loadingscrn = false;
        notifyListeners();
      } else {
        noDataMsg = 'Something went wrong. Try again';

        loadingscrn = false;
      }
    });
    notifyListeners();
  }

  changeCalculaterList(int i, BuildContext context, ThemeData theme) {
    double chagneVal = double.parse(recoAmtcontroller[i].text).abs();
    if (chagneVal <= (recoListItemData[i].reconcileAmount).abs()) {
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
                    content:
                        'Reconciliation amount is greater than balance due',
                    theme: theme,
                  )),
                  buttonName: null,
                ));
          }).then((value) {
        recoAmtcontroller[i].text =
            recoListItemData[i].reconcileAmount.toString();
        notifyListeners();
      });
    }
    // }
    // totalRecoAmt = 0;
    // for (var ik = 0; ik < recoListItemData.length; ik++) {
    //   if (recoListItemData[ik].listclr == true) {
    //     totalRecoAmt =
    //         totalRecoAmt! + double.parse(recoAmtcontroller[ik].text.toString());
    //   }
    // }
  }

  Future<SharedPreferences> pref = SharedPreferences.getInstance();

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

  List<RecoPostModelData> postRecoList = [];
  callpostRecoList(BuildContext context) async {
    onDisablebutton = true;
    await sapLoginApi(context);
    postRecoList = [];

    for (var i = 0; i < recoListItemData.length; i++) {
      // log('message2');

      if (recoListItemData[i].listclr == true) {
        // log('message3');

        postRecoList.add(RecoPostModelData(
            cashDiscount: null,
            selected: 'tYES',
            creditOrDebit: recoListItemData[i].creditOrDebitT,
            reconcileAmount: double.parse(recoAmtcontroller[i].text).abs(),
            shortName: cardCode,
            srcObjAbs: int.parse(recoListItemData[i].srcObjAbs.toString()),
            srcObjTyp: recoListItemData[i].srcObjTyp,
            transId: int.parse(recoListItemData[i].transId.toString()),
            transRowId: int.parse(recoListItemData[i].transRowId.toString())));
      }
    }
    // log('message4::${postRecoList.length}');

    RecoPostAPi.cardCodePost = cardCode;
    RecoPostAPi.docDate = config.alignDate1(mycontroller[1].text);

    RecoPostAPi.docLineQout = postRecoList;
    // log('message5');

    RecoPostAPi.method();
    notifyListeners();
    await RecoPostAPi.getGlobalData(AppConstant.sapSessionID).then((value) {
      log('messagexxxx');

      if (value.statuscode >= 200 && value.statuscode <= 210) {
        log('message11');
        if (value.reconNum != null) {
          log('message12');
          Get.defaultDialog(
              title: 'Success',
              middleText: 'Successfully Done \n ReconNum ${value.reconNum}',
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      await callRecoListApi();
                      onDisablebutton = false;

                      Get.back();
                    },
                    child: Text(' Close '))
              ]);
        }
        notifyListeners();
      } else if (value.statuscode >= 400 && value.statuscode <= 410) {
        log('message13');

        Get.defaultDialog(
            title: 'Aletr',
            titleStyle: TextStyle(color: Colors.red),
            middleText: '${value.error!.message!.value}',
            actions: [
              ElevatedButton(
                  onPressed: () {
                    onDisablebutton = false;

                    Get.back();
                  },
                  child: Text(' Close '))
            ]);
      } else {
        onDisablebutton = true;
      }
    });
    notifyListeners();
  }

  clearBtn() {
    if (recoListItemData.isNotEmpty) {
      for (var i = 0; i < recoListItemData.length; i++) {
        recoListItemData[i].listclr = false;
        recoAmtcontroller[i].text =
            recoListItemData[i].reconcileAmount.toStringAsFixed(6);
      }
    }
    totalRecoAmt = null;
    notifyListeners();
  }

  itemDeSelect(int i) {
    totalRecoAmt = totalRecoAmt ?? 0;
    if (recoListItemData[i].listclr == false) {
      recoListItemData[i].listclr = true;
      totalRecoAmt = double.parse(totalRecoAmt!.toStringAsFixed(6)) +
          double.parse(recoAmtcontroller[i].text);
      log('totalRecoAmttotalRecoAmt11::${totalRecoAmt}');

      // totalRecoAmt = double.parse(totalduepayx.toString());
      notifyListeners();
    } else if (recoListItemData[i].listclr == true) {
      recoListItemData[i].listclr = false;

      totalRecoAmt = double.parse(totalRecoAmt!.toStringAsFixed(6)) -
          double.parse(recoAmtcontroller[i].text);
      log('totalRecoAmttotalRecoAmt222::${totalRecoAmt}');

      notifyListeners();
    }
    totalRecoAmt = 0;
    for (var ik = 0; ik < recoListItemData.length; ik++) {
      if (recoListItemData[ik].listclr == true) {
        totalRecoAmt =
            totalRecoAmt! + double.parse(recoAmtcontroller[ik].text.toString());
      }
    }
  }

  getCardName() {
    for (var i = 0; i < filterListBoxData.length; i++) {
      if (filterListBoxData[i].cardCode.toString().toLowerCase() ==
          mycontroller[0].text.toString().toLowerCase()) {
        cardName = filterListBoxData[i].cardName!;
      }
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
}
