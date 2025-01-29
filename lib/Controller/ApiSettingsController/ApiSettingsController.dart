import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Constant/SharedPreference.dart';
import 'package:posproject/main.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/Branch.dart';
import '../../DBModel/CustomerMaster.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockSnap.dart';
import '../../Service/AddressMasterAPI.dart';
import '../../Service/BranchMasterAPI.dart';
import '../../Service/CustomerMasterAPI.dart';
import '../../Service/NewProductMasterApi.dart';
import '../../Service/StockSnapApi.dart';

class ApiSettingsController extends ChangeNotifier {
  init() {
    // reievervb();
    clearAllData();

    getqueueDetails();
    getMasterApiCount();
  }

  clearAllData() {
    progressItemMaster = false;
    progressBranchMaster = false;
    progressCustomerAddressMaster = false;
    progressProductMaster = false;
    progressCustomerMaster = false;
    productapisetting = false;
    customerapisetting = false;
  }

  static bool productapisetting = false;
  static bool customerapisetting = false;

  String? queueName;
  String? countOfCounsumer;
  getqueueDetails() async {
    // await SharedPref.getConsumerCount();
    // await SharedPref.getQueueName();
    queueName = "";
    countOfCounsumer = "";
    // log(qname.toString());
    queueName = await SharedPref.getQueueName();
    countOfCounsumer = await SharedPref.getConsumerCount();

    notifyListeners();
  }

  clearmethod() async {
    queueName = "";
    countOfCounsumer = "";
    await getqueueDetails();
    notifyListeners();
  }

  resetClickEvent() {
    clearmethod();
    receivervb();
    notifyListeners();
  }

//ItemMaster Api-StockSnap Table
  int itemMasterCount = 0;
  int get getitemMasterCount => itemMasterCount;
  bool progressItemMaster = false;
  bool get getprogressItemMaster => progressItemMaster;

//Product Master Api - ItemMaster Table
  int productMasterCount = 0;
  int get getproductMasterCount => productMasterCount;
  bool progressProductMaster = false;
  bool get getprogressProductMaster => progressProductMaster;
//branch Master Api - BranchMaster Table
  int branchMasterCount = 0;
  int get getBranchMasterCount => branchMasterCount;
  bool progressBranchMaster = false;
  bool get getprogressBranchMaster => progressBranchMaster;
//customer Master Api - customerMaster Table
  int customerMasterCount = 0;
  int get getCustomerMasterCount => customerMasterCount;
  bool progressCustomerMaster = false;
  bool get getprogressCustomerMaster => progressCustomerMaster;
//customerAddress Master Api - customerAddressMaster Table
  int customerAddressMasterCount = 0;
  int get getCustomerAddressMasterCount => customerAddressMasterCount;
  bool progressCustomerAddressMaster = false;
  bool get getprogressCustomerAddressMaster => progressCustomerAddressMaster;

  getMasterApiCount() async {
    itemMasterCount = 0;
    productMasterCount = 0;
    branchMasterCount = 0;
    customerMasterCount = 0;
    customerAddressMasterCount = 0;

    final Database db = (await DBHelper.getInstance())!;

    itemMasterCount = (await DBOperation.getItemMasterCount(db))!;

    // List<ItemMasterModelDB> productmaster =
    //     await DBOperation.getItemMasterData(db);
    List<Map<String, Object?>> getItemMaster =
        await DBOperation.getItemMasterData2(db);
    productMasterCount = getItemMaster.length;

    //  (await DBOperation.getProductMasterCount(db))!;
    branchMasterCount = (await DBOperation.getBranchMasterCount(db))!;

    List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
    customerMasterCount = newcusdataDB.length;

    // (await DBOperation.getCustomerMasterCount(db))!;
    customerAddressMasterCount =
        (await DBOperation.getCustomerAddressMasterCount(db))!;
    notifyListeners();
  }

  callItemMasterApi(BuildContext context, ThemeData theme) async {
    progressItemMaster = true;

    List<StockSnapTModelDB> stockSnap = [];
    final Database db = (await DBHelper.getInstance())!;

    await DBOperation.truncateStockSnap(db);
    await StockSnapModelApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.stocksnapitemdata != null) {
          for (int i = 0; i < value.stocksnapitemdata!.length; i++) {
            stockSnap.add(StockSnapTModelDB(
              terminal: UserValues.terminal,
              branchcode: value.stocksnapitemdata![i].branch,
              taxCode: value.stocksnapitemdata![i].taxCode,
              branch: UserValues.branch,
              createdUserID: int.parse(
                  value.stocksnapitemdata![i].createdUserID.toString()),
              createdateTime: value.stocksnapitemdata![i].createdateTime,
              itemcode: value.stocksnapitemdata![i].itemCode,
              lastupdateIp: value.stocksnapitemdata![i].lastupdateIp,
              maxdiscount: value.stocksnapitemdata![i].maxdiscount.toString(),
              taxrate: value.stocksnapitemdata![i].taxRate.toString(),
              mrpprice: value.stocksnapitemdata![i].mrp.toString(),
              purchasedate: value.stocksnapitemdata![i].purchasedate,
              quantity: value.stocksnapitemdata![i].qty.toString(),
              sellprice: value.stocksnapitemdata![i].sellPrice.toString(),
              serialbatch: value.stocksnapitemdata![i].serialBatch,
              snapdatetime: value.stocksnapitemdata![i].snapdatetime,
              specialprice: value.stocksnapitemdata![i].specialprice.toString(),
              updatedDatetime: value.stocksnapitemdata![i].updatedDatetime,
              updateduserid: int.parse(
                  value.stocksnapitemdata![i].updateduserid.toString()),
              itemname: value.stocksnapitemdata![i].itemName.toString(),
              weight: value.stocksnapitemdata![i].weight,
              liter: value.stocksnapitemdata![i].liter,
              uPackSize: value.stocksnapitemdata![i].uPackSize.toString(),
              uTINSPERBOX:
                  int.parse(value.stocksnapitemdata![i].uTINSPERBOX.toString()),
              uSpecificGravity:
                  value.stocksnapitemdata![i].uSpecificGravity.toString(),
              uPackSizeuom: value.stocksnapitemdata![i].uPackSizeuom.toString(),
            ));
          }
          // percent = 0.1;
          notifyListeners();
        } else if (value.stocksnapitemdata == null) {
          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          progressItemMaster = false;
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        progressItemMaster = false;
      } else {
        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      progressItemMaster = false;
    });
    await DBOperation.insertStockSnap(db, stockSnap).then((value) async {
      log("insert stockSnap");
      itemMasterCount = (await DBOperation.getItemMasterCount(db))!;

      progressItemMaster = false;
      notifyListeners();
    });
  }

  getItemMasterData(BuildContext context, ThemeData theme) async {
    if (itemMasterCount == 0) {
      callItemMasterApi(context, theme);
    } else {
      String msg =
          "ItemMaster Already Synced.\nClick 'Continue' to proceed with this data or 'Reset' to start a new process.";

      itemMasterDialog(
        context,
        theme,
        '',
        msg,
      );
      // ignore: prefer_const_constructors
      // var snackBar = SnackBar(
      //     elevation: 1.9,
      //     width: Screens.width(context) * 0.7,
      //     backgroundColor: Colors.grey,
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 1),
      //     // duration: Duration(seconds: 2),
      //     content: const Text('ItemMaster Already Synced..'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  itemMasterDialog(
    BuildContext context,
    ThemeData theme,
    String apiRes,
    String msg,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: const EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  padding: EdgeInsets.zero,
                  width: Screens.width(context) * 0.4,
                  //  height: Screens.bodyheight(context)*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      width: Screens.width(context) * 0.4,
                      height: Screens.bodyheight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.07),
                            width: Screens.width(context) * 0.3,
                            child: Center(
                                child: Text("Warning",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white))),
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  notifyListeners();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02),
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        child: Text(msg),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                )),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: Screens.width(context) * 0.05),
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8),
                                )),
                              ),
                              onPressed: () {
                                st(
                                  () {
                                    Get.back();
                                    callItemMasterApi(context, theme);
                                    notifyListeners();
                                  },
                                );
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ])),
            );
          });
        });
  }

  productMasterDialog(
    BuildContext context,
    ThemeData theme,
    String msg,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: const EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  padding: EdgeInsets.zero,
                  width: Screens.width(context) * 0.4,
                  //  height: Screens.bodyheight(context)*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      width: Screens.width(context) * 0.4,
                      height: Screens.bodyheight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.07),
                            width: Screens.width(context) * 0.3,
                            child: Center(
                                child: Text("Warning",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white))),
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  notifyListeners();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02),
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        child: Text(msg),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                )),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: Screens.width(context) * 0.05),
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8),
                                )),
                              ),
                              onPressed: () {
                                Get.back();

                                callProductMasterApi(context, theme);
                                notifyListeners();
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ])),
            );
          });
        });
  }

  branchMasterDialog(
    BuildContext context,
    ThemeData theme,
    String msg,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: const EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  padding: EdgeInsets.zero,
                  width: Screens.width(context) * 0.4,
                  //  height: Screens.bodyheight(context)*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      width: Screens.width(context) * 0.4,
                      height: Screens.bodyheight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.07),
                            width: Screens.width(context) * 0.3,
                            child: Center(
                                child: Text("Warning",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white))),
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  notifyListeners();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02),
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        child: Text(msg),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                )),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: Screens.width(context) * 0.05),
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8),
                                )),
                              ),
                              onPressed: () {
                                Get.back();

                                callBranchMasterApi(context, theme);
                                notifyListeners();
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ])),
            );
          });
        });
  }

  customerMasterDialog(
    BuildContext context,
    ThemeData theme,
    String msg,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: const EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  padding: EdgeInsets.zero,
                  width: Screens.width(context) * 0.4,
                  //  height: Screens.bodyheight(context)*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      width: Screens.width(context) * 0.4,
                      height: Screens.bodyheight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.07),
                            width: Screens.width(context) * 0.3,
                            child: Center(
                                child: Text("Warning",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white))),
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  notifyListeners();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02),
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        child: Text(msg),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                )),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: Screens.width(context) * 0.05),
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8),
                                )),
                              ),
                              onPressed: () {
                                Get.back();

                                callCustomerMasterApi(context, theme);
                                notifyListeners();
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ])),
            );
          });
        });
  }

  addressMasterDialog(
    BuildContext context,
    ThemeData theme,
    String msg,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              insetPadding: const EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              content: Container(
                  padding: EdgeInsets.zero,
                  width: Screens.width(context) * 0.4,
                  //  height: Screens.bodyheight(context)*0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8))),
                      width: Screens.width(context) * 0.4,
                      height: Screens.bodyheight(context) * 0.06,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: Screens.padingHeight(context) * 0.07),
                            width: Screens.width(context) * 0.3,
                            child: Center(
                                child: Text("Warning",
                                    style: theme.textTheme.bodyLarge!
                                        .copyWith(color: Colors.white))),
                          ),
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                  notifyListeners();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02),
                      child: Container(
                        // padding: const EdgeInsets.all(8),
                        child: Text(msg),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(0),
                                )),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(width: Screens.width(context) * 0.05),
                        SizedBox(
                          width: Screens.width(context) * 0.1,
                          height: Screens.bodyheight(context) * 0.06,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.primaryColor,

                                // primary: theme.primaryColor,
                                textStyle: const TextStyle(color: Colors.white),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(8),
                                )),
                              ),
                              onPressed: () {
                                Get.back();

                                callAddressMasterApi(context, theme);
                                notifyListeners();
                              },
                              child: const Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ],
                    ),
                  ])),
            );
          });
        });
  }

  callProductMasterApi(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    progressProductMaster = true;
    productapisetting = true;
    await DBOperation.truncateItemMaster(db);

    await NewProductsApi.getData(AppConstant.branch, AppConstant.terminal)
        .then((value) {
      // if (value.stcode! >= 200 && value.stcode! <= 210) {
      //   if (value.productItemData.isNotEmpty) {
      //     for (int i = 0; i < value.productItemData.length; i++) {
      //       itemMasterDB.add(ItemMasterModelDB(
      //         isselected: 0,
      //         autoId: value.productItemData[i].autoId,
      //         maximumQty: value.productItemData[i].maximumQty,
      //         minimumQty: value.productItemData[i].minimumQty,
      //         weight: value.productItemData[i].weight,
      //         liter: value.productItemData[i].liter,
      //         displayQty: value.productItemData[i].displayQty,
      //         searchString: value.productItemData[i].searchString,
      //         brand: UserValues.branch,
      //         category: value.productItemData[i].category,
      //         createdUserID: value.productItemData[i].createdUserID.toString(),
      //         createdateTime: value.productItemData[i].createdateTime,
      //         hsnsac: value.productItemData[i].hsnsac,
      //         isActive: value.productItemData[i].isActive,
      //         isfreeby: value.productItemData[i].isfreeby,
      //         isinventory: value.productItemData[i].isinventory,
      //         issellpricebyscrbat: value.productItemData[i].issellpricebyscrbat,
      //         // isserialBatch: value.productItemData[i].serialBatch,
      //         itemcode: value.productItemData[i].itemcode,
      //         itemnamelong: value.productItemData[i].itemnamelong,
      //         itemnameshort: value.productItemData[i].itemnameshort,
      //         lastupdateIp: UserValues.lastUpdateIp,
      //         maxdiscount: value.productItemData[i].maxdiscount == null
      //             ? 0.00
      //             : double.parse(
      //                 value.productItemData[i].maxdiscount.toString()),
      //         skucode: value.productItemData[i].skucode,
      //         subcategory: value.productItemData[i].subcategory,
      //         taxrate: value.productItemData[i].taxrate.toString(),
      //         updatedDatetime: value.productItemData[i].updatedDatetime,
      //         updateduserid: value.productItemData[i].updateduserid.toString(),
      //         mrpprice: value.productItemData[i].mrpprice!.toString(),
      //         sellprice: value.productItemData[i].sellprice!.toString(),
      //         quantity: value.productItemData[i].quantity == null
      //             ? 0
      //             : double.parse(value.productItemData[i].quantity.toString()),
      //         uPackSize: value.productItemData[i].uPackSize.toString(),
      //         uPackSizeuom: value.productItemData[i].uPackSizeuom.toString(),
      //         uTINSPERBOX: value.productItemData[i].uTINSPERBOX != null
      //             ? value.productItemData[i].uTINSPERBOX!
      //             : 0,
      //         uSpecificGravity:
      //             value.productItemData[i].uSpecificGravity != null
      //                 ? value.productItemData[i].uSpecificGravity.toString()
      //                 : '',
      //       ));
      //     }
      //     notifyListeners();
      //   } else if (value.productItemData.isNotEmpty) {
      //     progressProductMaster = false;

      //     var snackBar = SnackBar(
      //         elevation: 1.9,
      //         width: Screens.width(context) * 0.7,
      //         backgroundColor: Colors.grey,
      //         behavior: SnackBarBehavior.floating,
      //         duration: const Duration(seconds: 1),
      //         // duration: Duration(seconds: 2),
      //         content: Text('${value.exception}..'));
      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   }
      // } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      //   progressProductMaster = false;

      //   var snackBar = SnackBar(
      //       elevation: 1.9,
      //       width: Screens.width(context) * 0.7,
      //       backgroundColor: Colors.grey,
      //       behavior: SnackBarBehavior.floating,
      //       duration: const Duration(seconds: 1),
      //       // duration: Duration(seconds: 2),
      //       content: Text('${value.exception}..'));
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // } else {
      //   var snackBar = SnackBar(
      //       elevation: 1.9,
      //       width: Screens.width(context) * 0.7,
      //       backgroundColor: Colors.grey,
      //       behavior: SnackBarBehavior.floating,
      //       duration: const Duration(seconds: 1),
      //       // duration: Duration(seconds: 2),
      //       content: Text('${value.exception}..'));
      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   progressProductMaster = false;
      // }
    });
    await DBOperation.insertItemMaster(db, jsonList).then((value) async {
      log("Inserted Product Master");
      List<Map<String, Object?>> getItemMaster =
          await DBOperation.getItemMasterData2(db);
      productMasterCount = getItemMaster.length;

      notifyListeners();
    });
  }

  getProductMasterData(BuildContext context, ThemeData theme) async {
    if (productMasterCount == 0) {
      callProductMasterApi(context, theme);
    } else {
      String msg =
          "Product Already Synced.\nClick 'Continue' to proceed with this data or 'Reset' to start a new process.";

      productMasterDialog(
        context,
        theme,
        msg,
      );
      // var snackBar = SnackBar(
      //     elevation: 1.9,
      //     width: Screens.width(context) * 0.7,
      //     backgroundColor: Colors.grey,
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 1),
      //     // duration: Duration(seconds: 2),
      //     content: const Text('Product Master Already Synced..'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      progressProductMaster = false;
    }
    notifyListeners();
  }

  callBranchMasterApi(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<BranchTModelDB> branchValues = [];

    await DBOperation.truncateBranchMaster(db);
    progressBranchMaster = true;

    await BranchMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.branchdata != null) {
          for (int i = 0; i < value.branchdata!.length; i++) {
            branchValues.add(BranchTModelDB(
              whsCode: value.branchdata![i].whsCode.toString(),
              whsName: value.branchdata![i].whsName,
              wallerAccount: value.branchdata![i].walletAccount,
              gitWhs: value.branchdata![i].gitWhs,
              location: value.branchdata![i].location.toString(),
              companyName: value.branchdata![i].companyName,
              companyHeader: value.branchdata![i].companyHeader,
              e_Mail: value.branchdata![i].e_Mail,
              cashAccount: value.branchdata![i].cashAccount,
              creditAccount: value.branchdata![i].creditAccount,
              chequeAccount: value.branchdata![i].chequeAccount,
              transFerAccount: value.branchdata![i].transFerAccount,
              // customerAcct: value.branchdata![i].customerAcct,
              // disAcct1: value.branchdata![i].disAcct1,
              // disAcct2: value.branchdata![i].disAcct2,
              // creditCard: value.branchdata![i].creditCard,
              // stateCode: value.branchdata![i].stateCode,
              // gSTNo: value.branchdata![i].gSTNo,
              // location: value.branchdata![i].location,
              // companyName: value.branchdata![i].companyName,
              // companyHeader: value.branchdata![i].companyHeader,
              // e_Mail: value.branchdata![i].e_Mail,
              // cOGSAcct: value.branchdata![i].cOGSAcct,
              // pAN: value.branchdata![i].pAN,
              // address1: value.branchdata![i].address1,
              // address2: value.branchdata![i].address2,
              // city: value.branchdata![i].city,
              // pincode: value.branchdata![i].pincode
            ));
          }
          // percent = 0.3;
          notifyListeners();
        } else if (value.branchdata == null) {
          progressBranchMaster = false;

          var snackBar = SnackBar(
              elevation: 1.9,
              width: Screens.width(context) * 0.7,
              backgroundColor: Colors.grey,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              // duration: Duration(seconds: 2),
              content: Text('${value.exception}..'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        progressBranchMaster = false;

        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        // exception = value.exception!;
      } else {
        progressBranchMaster = false;

        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    await DBOperation.insertBranchTable(db, branchValues).then((value) async {
      log("inseted insertBranchTable");
      progressBranchMaster = false;
      branchMasterCount = (await DBOperation.getBranchMasterCount(db))!;
      notifyListeners();
    });
  }

  getBranchMasterData(BuildContext context, ThemeData theme) async {
    if (branchMasterCount == 0) {
      callBranchMasterApi(context, theme);
    } else {
      String msg =
          "Branch Master Already Synced.\nClick 'Continue' to proceed with this data or 'Reset' to start a new process.";
      branchMasterDialog(context, theme, msg);
      // var snackBar = SnackBar(
      //     elevation: 1.9,
      //     width: Screens.width(context) * 0.7,
      //     backgroundColor: Colors.grey,
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 1),
      //     // duration: Duration(seconds: 2),
      //     content: const Text('Branch Master Already Synced..'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  static List<Map<String, dynamic>> jsonList = [];
  static Future<List<Map<String, dynamic>>> jsonconvertProduct(
      String tabularData) async {
    List<String> lines = tabularData.split('\n');
    List<String> headers = lines[0].split('\t');
    jsonList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> values = lines[i].split('\t');
      if (values.length == headers.length) {
        // log('headersheaders::${headers.length}');
        Map<String, dynamic> jsonItem = {};
        for (int j = 0; j < headers.length; j++) {
          jsonItem[headers[j]] = values[j];
        }
        jsonList.add(jsonItem);
      }
    }
    log('jsonListjsonList::${jsonList.length}');

    return jsonList;
  }

  static List<Map<String, dynamic>> jsonCusotmerList = [];
  static Future<List<Map<String, dynamic>>> jsonconvertCustomer(
      String tabularData) async {
    List<String> lines = tabularData.split('\n');
    List<String> headers = lines[0].split('\t');
    jsonCusotmerList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> values = lines[i].split('\t');
      if (values.length == headers.length) {
        // log('headersheaders::${headers.length}');
        Map<String, dynamic> jsonItem = {};
        for (int j = 0; j < headers.length; j++) {
          jsonItem[headers[j]] = values[j];
        }
        jsonCusotmerList.add(jsonItem);
      }
    }
    log('jsonCusotmerList::${jsonCusotmerList.length}');

    return jsonCusotmerList;
  }

  callCustomerMasterApi(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;

    progressCustomerMaster = true;
    customerapisetting = true;
    await DBOperation.truncateCustomerMaster(db);
    await CustomerMasterApi.getData().then((value) async {
      // if (value.stcode! >= 200 && value.stcode! <= 210) {
      // log("value.customerdata length:::${value.customerdata!.length}");

      // if (value.customerdata != null) {
      //   for (int i = 0; i < value.customerdata!.length; i++) {
      //     custValues.add(CustomerModelDB(
      //       taxCode: value.customerdata![i].taxCode!,
      //       customerCode: value.customerdata![i].cardCode,
      //       createdUserID: value.customerdata![i].createdUserID,
      //       createdateTime: value.customerdata![i].createdateTime,
      //       updatedDatetime: value.customerdata![i].updatedDatetime,
      //       updateduserid:
      //           int.parse(value.customerdata![i].updateduserid.toString()),
      //       balance: value.customerdata![i].accBalance!,
      //       createdbybranch: UserValues.branch.toString(),
      //       customername: value.customerdata![i].name,
      //       customertype: value.customerdata![i].customertype,
      //       emalid: value.customerdata![i].email,
      //       phoneno1: value.customerdata![i].phNo,
      //       phoneno2: value.customerdata![i].Phno2,
      //       points: double.parse(value.customerdata![i].point.toString()),
      //       lastupdateIp: value.customerdata![i].lastupdateIp.toString(),
      //       // != null
      //       //     ? int.parse(value.customerdata![i].lastupdateIp!.toString())
      //       //     : 0,
      //       premiumid: value.customerdata![i].premiumid,
      //       snapdatetime: value.customerdata![i].snapdatetime,
      //       taxno: value.customerdata![i].taxNo,
      //       terminal: UserValues.terminal, tinNo: '', vatregno: '',
      // ));
      // }
      // percent = 0.5;
      //   notifyListeners();
      // } else if (value.customerdata == null) {
      //   progressCustomerMaster = false;

      //   var snackBar = SnackBar(
      //       elevation: 1.9,
      //       width: Screens.width(context) * 0.7,
      //       backgroundColor: Colors.grey,
      //       behavior: SnackBarBehavior.floating,
      //       duration: const Duration(seconds: 1),
      //       // duration: Duration(seconds: 2),
      //       content: Text('${value.exception}..'));

      //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // }
      //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      //     progressCustomerMaster = false;

      //     var snackBar = SnackBar(
      //         elevation: 1.9,
      //         width: Screens.width(context) * 0.7,
      //         backgroundColor: Colors.grey,
      //         behavior: SnackBarBehavior.floating,
      //         duration: const Duration(seconds: 1),
      //         // duration: Duration(seconds: 2),
      //         content: Text('${value.exception}..'));

      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   } else {
      //     progressCustomerMaster = false;

      //     var snackBar = SnackBar(
      //         elevation: 1.9,
      //         width: Screens.width(context) * 0.7,
      //         backgroundColor: Colors.grey,
      //         behavior: SnackBarBehavior.floating,
      //         duration: const Duration(seconds: 1),
      //         // duration: Duration(seconds: 2),
      //         content: Text('${value.exception}..'));

      //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //   }
    });
    // await DBOperation.insertCustomer(db, custValues).then((value) async {
    //   log("inseted CustomerMaster");
    //   progressCustomerMaster = false;
    await DBOperation.insertCustomer(db, jsonCusotmerList).then((value) async {
      log("Inserted Product Master");
      notifyListeners();
      progressCustomerMaster = false;
      List<CustomerModelDB> newcusdataDB = await DBOperation.getCstmMasDB(db);
      customerMasterCount = newcusdataDB.length;

      // customerMasterCount = (await DBOperation.getCustomerMasterCount(db))!;
      notifyListeners();
    });
  }

  getCustomerMasterData(BuildContext context, ThemeData theme) async {
    if (customerMasterCount == 0) {
      callCustomerMasterApi(context, theme);
      progressCustomerMaster = false;
    } else {
      progressCustomerMaster = false;
      String msg =
          "Customer Master Already Synced.\nClick 'Continue' to proceed with this data or 'Reset' to start a new process.";

      customerMasterDialog(context, theme, msg);
      // var snackBar = SnackBar(
      //     elevation: 1.9,
      //     width: Screens.width(context) * 0.7,
      //     backgroundColor: Colors.grey,
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 1),
      //     // duration: Duration(seconds: 2),
      //     content: const Text('Customer Master Already Synced..'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    progressCustomerMaster = false;
    notifyListeners();
  }

  callAddressMasterApi(BuildContext context, ThemeData theme) async {
    final Database db = (await DBHelper.getInstance())!;
    List<CustomerAddressModelDB> addrsvalue = [];
    progressCustomerAddressMaster = true;
    await DBOperation.truncateCustomerMasterAddress(db);
    await AddressMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        // log("value.addressdata length:::${value.addressdata!.length}");
        // print(
        //     " UserValues.branch  address table" + UserValues.branch.toString());
        if (value.addressdata != null) {
          for (int i = 0; i < value.addressdata!.length; i++) {
            addrsvalue.add(CustomerAddressModelDB(
              terminal: UserValues.terminal,
              branch: UserValues.branch,
              createdUserID: value.addressdata![i].createdUserID,
              createdateTime: value.addressdata![i].createdateTime,
              lastupdateIp: value.addressdata![i].lastupdateIp!.isNotEmpty
                  ? value.addressdata![i].lastupdateIp.toString()
                  : "",
              updatedDatetime: value.addressdata![i].updatedDatetime,
              updateduserid: value.addressdata![i].updateduserid.toString(),
              address1: value.addressdata![i].address1,
              address2: value.addressdata![i].address2,
              pincode: value.addressdata![i].billPincode,
              city: value.addressdata![i].billCity,
              countrycode: value.addressdata![i].billCountry,
              custcode: value.addressdata![i].custCode,
              geolocation1: value.addressdata![i].location1,
              geolocation2: value.addressdata![i].location2,
              statecode: value.addressdata![i].billstate,
              address3: '',
              addresstype: value.addressdata![i].addresstype,
            ));
          }
          // percent = 0.4;
          notifyListeners();
        }
      } else if (value.addressdata == null) {
        progressCustomerAddressMaster = false;

        // exception = value.message!;
        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        progressCustomerAddressMaster = false;

        // exception = value.exception!;
        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        progressCustomerAddressMaster = false;

        // exception = value.exception!;
        var snackBar = SnackBar(
            elevation: 1.9,
            width: Screens.width(context) * 0.7,
            backgroundColor: Colors.grey,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            // duration: Duration(seconds: 2),
            content: Text('${value.exception}..'));

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    await DBOperation.insertCustomerAddress(db, addrsvalue).then((value) async {
      log("inseted CustomerAddressMaster");
      progressCustomerAddressMaster = false;
      customerAddressMasterCount =
          (await DBOperation.getCustomerMasterCount(db))!;

      notifyListeners();
    });
  }

  getCustomerAddressMasterData(BuildContext context, ThemeData theme) async {
    if (customerAddressMasterCount == 0) {
      callAddressMasterApi(context, theme);
    } else {
      progressCustomerAddressMaster = false;
      String msg =
          "Address Master Already Synced.\nClick 'Continue' to proceed with this data or 'Reset' to start a new process.";

      addressMasterDialog(context, theme, msg);
      // var snackBar = SnackBar(
      //     elevation: 1.9,
      //     width: Screens.width(context) * 0.7,
      //     backgroundColor: Colors.grey,
      //     behavior: SnackBarBehavior.floating,
      //     duration: const Duration(seconds: 1),
      //     // duration: Duration(seconds: 2),
      //     content: const Text('Customer Address Master Already Synced..'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    progressCustomerAddressMaster = false;
    notifyListeners();
  }
}
