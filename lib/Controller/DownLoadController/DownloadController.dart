import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/Configuration.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../Constant/SharedPreference.dart';
import '../../Constant/UserValues.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/Branch.dart';
import '../../DBModel/CouponDetailsDBModel.dart';
import '../../DBModel/CustomerMasterAddress.dart';
import '../../DBModel/StockSnap.dart';
import '../../Models/DataModel/CouponsDetailsModel/CouponDetModel.dart';
import '../../Service/AddressMasterAPI.dart';
import '../../Service/BranchMasterAPI.dart';
import '../../Service/CustomerMasterAPI.dart';
import '../../Service/NewProductMasterApi.dart';
import '../../Service/QueryURL/CashCardAccountDetailsApi.dart';
import '../../Service/StockSnapApi.dart';
import '../../main.dart';

class DownLoadController extends ChangeNotifier {
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;
  String loadingMsg = '';
  Configure config = Configure();
  int count = 0;

  double percent = 0.0;
  double get getpercent => percent;

  void init() {
    percent = 0.0;
    getIP().then((value) async {
      await callApi();
      await callCashCardAccApi();
    });
  }

  Future getIP() async {
    String? ip = await SharedPref.getHostDSP();
    String? branch = await getBranch();
    String? terminal = await getTerminal();
    String? slpCode = await getSlpCode();
    String? sapPassword =
        // 'ub@17';
        await getSapPassword();

    String? sapUserName =
        // 'Ubongo';
        await getSapUserName();
    String? sapDB = await getSapDBB();
    // 'InsigniaLimited';

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
      AppConstant.branch = branch.toString();
      AppConstant.terminal = terminal.toString();
      AppConstant.slpCode = slpCode.toString();
      AppConstant.sapDB = sapDB.toString();
      AppConstant.ip = ip;

      AppConstant.sapPassword = sapPassword;
      AppConstant.sapUserName = sapUserName;
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
    // log('headersheaders::${headers.toString()}');

    jsonCusotmerList = [];
    for (int i = 1; i < lines.length; i++) {
      List<String> values = lines[i].split('\t');

      // log('valuesvalues::${values.length}');

      if (values.length == headers.length) {
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

  callCashCardAccApi() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await CashCardAccountAPi.getGlobalData(AppConstant.branch)
        .then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
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
        log('checkacccheckacccheckacc:::${preferences.getString('UTransAccount')}');
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  callApi() async {
    final Database db = (await DBHelper.getInstance())!;
    List<StockSnapTModelDB> stockSnap = [];
    List<BranchTModelDB> branchValues = [];
    List<CouponDetailDB> coupondetlsMaster = [];
    List<CustomerAddressModelDB> addrsvalue = [];

    List<String> catchmsg = [];
    loadingMsg = '';
    await DBOperation.truncateItemMaster(db);
    await DBOperation.truncateStockSnap(db);
    await DBOperation.truncateBranchMaster(db);
    await DBOperation.truncateCouponDetailsMaster(db);
    await DBOperation.truncateCustomerMasterAddress(db);
    await DBOperation.truncateCustomerMaster(db);
    loadingMsg = "Loading Item Master";
    notifyListeners();
    await StockSnapModelApi.getData().then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.stocksnapitemdata != null) {
          for (int i = 0; i < value.stocksnapitemdata!.length; i++) {
            stockSnap.add(StockSnapTModelDB(
              terminal: AppConstant.terminal,
              branchcode: value.stocksnapitemdata![i].branch,
              branch: AppConstant.branch,
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
              uPackSizeuom: value.stocksnapitemdata![i].uPackSizeuom.toString(),
              uTINSPERBOX: value.stocksnapitemdata![i].uTINSPERBOX != null
                  ? value.stocksnapitemdata![i].uTINSPERBOX!
                  : 0,
              uSpecificGravity:
                  value.stocksnapitemdata![i].uSpecificGravity != null
                      ? value.stocksnapitemdata![i].uSpecificGravity.toString()
                      : '',
            ));
          }
          percent = 0.1;
          notifyListeners();
        } else if (value.stocksnapitemdata == null) {
          // catchmsg.add("Stock details: " + value.message!);
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        // catchmsg.add("Stock details: " + value.exception!);
      } else {
        // catchmsg.add("Stcok details: " + value.exception!);
      }
    });
    loadingMsg = "Loading Product Master";

    await NewProductsApi.getData(AppConstant.branch, AppConstant.terminal)
        .then((value) {
      // Stopwatch s = Stopwatch();
      // sleep(const Duration(seconds: 1));
      // s.start();
      // sleep(const Duration(seconds: 1));
// //jsonList

//       for (var i = 0; i < jsonList.length; i++) {}
      //   if (value.stcode! >= 200 && value.stcode! <= 210) {
      //     if (value.productItemData.isNotEmpty) {
      //       for (int i = 0; i < value.productItemData.length; i++) {
      //         itemMasterDB.add(ItemMasterModelDB(
      //           isselected: 0,
      //           autoId: value.productItemData[i].autoId,
      //           maximumQty: value.productItemData[i].maximumQty,
      //           minimumQty: value.productItemData[i].minimumQty,
      //           weight: value.productItemData[i].weight,
      //           liter: value.productItemData[i].liter,
      //           displayQty: value.productItemData[i].displayQty,
      //           searchString: value.productItemData[i].searchString,
      //           brand: value.productItemData[i].brand,
      //           category: value.productItemData[i].category,
      //           createdUserID: value.productItemData[i].createdUserID.toString(),
      //           createdateTime: value.productItemData[i].createdateTime,
      //           hsnsac: value.productItemData[i].hsnsac,
      //           isActive: value.productItemData[i].isActive,
      //           isfreeby: value.productItemData[i].isfreeby,
      //           isinventory: value.productItemData[i].isinventory,
      //           issellpricebyscrbat: value.productItemData[i].issellpricebyscrbat,
      //       // isserialBatch: value.productItemData[i].serialBatch,
      //           itemcode: value.productItemData[i].itemcode,
      //           itemnamelong: value.productItemData[i].itemnamelong,
      //           itemnameshort: value.productItemData[i].itemnameshort,
      //           lastupdateIp: UserValues.lastUpdateIp,
      //           maxdiscount: value.productItemData[i].maxdiscount == null
      //               ? 0.00
      //               : double.parse(
      //                   value.productItemData[i].maxdiscount.toString()),
      //           skucode: value.productItemData[i].skucode,
      //           subcategory: value.productItemData[i].subcategory,
      //           taxrate: value.productItemData[i].taxrate.toString(),
      //           updatedDatetime: value.productItemData[i].updatedDatetime,
      //           updateduserid: value.productItemData[i].updateduserid.toString(),
      //           mrpprice: value.productItemData[i].mrpprice!.toString(),
      //           sellprice: value.productItemData[i].sellprice!.toString(),
      //           quantity: value.productItemData[i].quantity == null
      //               ? 0
      //               : int.parse(value.productItemData[i].quantity.toString()),
      //           uPackSize: value.productItemData[i].uPackSize.toString(),
      //           uPackSizeuom: value.productItemData[i].uPackSizeuom.toString(),
      //           uTINSPERBOX: value.productItemData[i].uTINSPERBOX != null
      //               ? value.productItemData[i].uTINSPERBOX!
      //               : 0,
      //           uSpecificGravity:
      //               value.productItemData[i].uSpecificGravity != null
      //                   ? value.productItemData[i].uSpecificGravity.toString()
      //                   : '',
      //         ));
      //       }
      //       percent = 0.2;
      //       notifyListeners();
      //     } else if (value.productItemData == null) {
      //       // exception = value.message!;
      //       catchmsg.add("Product details: ${value.exception!}");
      //     }
      //   } else if (value.stcode! >= 400 && value.stcode! <= 410) {
      //     catchmsg.add("Product details: ${value.exception!}");
      //   } else {
      //     catchmsg.add("Product details: ${value.exception!}");
      //   }
    });
    //
    loadingMsg = "Loading Branch Master";
    await BranchMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.branchdata != null) {
          for (int i = 0; i < value.branchdata!.length; i++) {
            branchValues.add(BranchTModelDB(
              whsCode: value.branchdata![i].whsCode.toString(),
              whsName: value.branchdata![i].whsName,
              cashAccount: value.branchdata![i].cashAccount,
              creditAccount: value.branchdata![i].creditAccount,
              chequeAccount: value.branchdata![i].chequeAccount,
              transFerAccount: value.branchdata![i].transFerAccount,
              wallerAccount: value.branchdata![i].walletAccount,
              gitWhs: value.branchdata![i].gitWhs,
              location: value.branchdata![i].location.toString(),
              companyName: value.branchdata![i].companyName,
              companyHeader: value.branchdata![i].companyHeader,
              e_Mail: value.branchdata![i].e_Mail,
            ));
          }
          percent = 0.3;

          notifyListeners();
        } else if (value.branchdata == null) {
          catchmsg.add("BranchMaster details: ${value.exception!}");
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        catchmsg.add("BranchMaster details: ${value.exception!}");
      } else {
        catchmsg.add("BranchMaster details: ${value.exception!}");
      }
    });

    for (int i = 0; i < coupondetails.length; i++) {
      coupondetlsMaster.add(CouponDetailDB(
          status: coupondetails[i].status,
          //
          doctype: coupondetails[i].doctype,
          cardcode: coupondetails[i].cardcode,
          coupontype: coupondetails[i].coupontype,
          couponno: coupondetails[i].couponcode,
          couponamt: coupondetails[i].couponamt));
    }

    //
    loadingMsg = "Loading Address Master";

    await AddressMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.addressdata != null) {
          for (int i = 0; i < value.addressdata!.length; i++) {
            addrsvalue.add(CustomerAddressModelDB(
              terminal: AppConstant.terminal,
              branch: AppConstant.branch,
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
          percent = 0.4;

          notifyListeners();
        }
      } else if (value.addressdata == null) {
        catchmsg.add("AddressMaster details: ${value.exception!}");
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        catchmsg.add("AddressMaster details: ${value.exception!}");
      } else {
        catchmsg.add("AddressMaster details: ${value.exception!}");
      }
    });
    loadingMsg = "Loading Customer Master";

    await CustomerMasterApi.getData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        //   if (value.customerdata != null) {
        //     for (int i = 0; i < value.customerdata!.length; i++) {
        //       custValues.add(CustomerModelDB(
        //         customerCode: value.customerdata![i].cardCode,
        //         createdUserID: value.customerdata![i].createdUserID,
        //         createdateTime: value.customerdata![i].createdateTime,
        //         updatedDatetime: value.customerdata![i].updatedDatetime,
        //         updateduserid:
        //             int.parse(value.customerdata![i].updateduserid.toString()),
        //         balance: value.customerdata![i].accBalance!,
        //         createdbybranch: UserValues.branch.toString(),
        //         customername: value.customerdata![i].name,
        //         customertype: value.customerdata![i].customertype,
        //         emalid: value.customerdata![i].email,
        //         phoneno1: value.customerdata![i].phNo,
        //         phoneno2: value.customerdata![i].Phno2,
        //         points: double.parse(value.customerdata![i].point.toString()),
        //         lastupdateIp: value.customerdata![i].lastupdateIp.toString(),
        //         premiumid: value.customerdata![i].premiumid,
        //         snapdatetime: value.customerdata![i].snapdatetime,
        //         taxno: value.customerdata![i].taxNo,
        //         taxCode: value.customerdata![i].taxCode!,
        //         terminal: UserValues.terminal,
        //         tinNo: '',
        //         vatregno: '',
        //       ));
        //     }
        //     percent = 0.5;

        //     notifyListeners();
        //   } else if (value.customerdata == null) {
        //     catchmsg.add("CustomerMaster details: ${value.exception!}");
        //   }
        // } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        //   catchmsg.add("CustomerMaster details: ${value.exception!}");
        // } else {
        //   catchmsg.add("CustomerMaster details: ${value.exception!}");
      }
    });
    loadingMsg = "Loading Users Masters";

    await DBOperation.insertStockSnap(db, stockSnap).then((value) {
      percent = 0.6;
      loadingMsg = "Inserted Item Master";

      notifyListeners();
    });
    await DBOperation.insertItemMaster(db, jsonList).then((value) {
      log("Inserted Product Master");
      percent = 0.7;
      loadingMsg = "Inserted Product Master";

      notifyListeners();
    });
    await DBOperation.insertBranchTable(db, branchValues).then((value) {
      percent = 0.7;
      loadingMsg = "Inserted Branch Master";

      notifyListeners();
    });

    await DBOperation.insertCustomer(db, jsonCusotmerList).then((value) {
      percent = 0.8;
      loadingMsg = "Inserted Customer Master";
      log("Inserted Product Master");
      notifyListeners();
    });
    await DBOperation.insertCouponmaster(db, coupondetlsMaster)
        .then((value) => {log("---------------5 coupondetlsMaster")});
    percent = 0.8;
    notifyListeners();

    await DBOperation.insertCustomerAddress(db, addrsvalue).then((value) {
      percent = 0.95;
      loadingMsg = "Inserted Address Master";

      notifyListeners();
    });

    if (catchmsg.isEmpty) {
      Get.defaultDialog(
        title: 'Alert',
        middleText: 'These data are not downloaded please manualy download it',
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Get.back();
                  notifyListeners();
                }),
          ])
        ],
      ).then((value) async {
        await SharedPref.saveDatadonld(true);
        Get.offAllNamed(ConstantRoutes.dashboard);
      });
    } else {
      await SharedPref.saveDatadonld(true);
      Get.offAllNamed(ConstantRoutes.dashboard);
    }
    notifyListeners();
  }

  List<CouponDetModel> coupondetails = [
    CouponDetModel(
        coupontype: "GroupOn",
        createdUserID: UserValues.userID,
        couponcode: '12356',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 500,
        updateduserid: UserValues.userID,
        cardcode: 'B1111',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "AMAZON PAY",
        createdUserID: UserValues.userID,
        couponcode: '1234',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 1000,
        updateduserid: UserValues.userID,
        cardcode: 'B2222',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "FLIPKART CORPORATE",
        createdUserID: UserValues.userID,
        couponcode: '12347',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 2000,
        updateduserid: UserValues.userID,
        cardcode: 'B5555',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "HDFC Gift Plus",
        createdUserID: UserValues.userID,
        couponcode: '12346',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 2200,
        updateduserid: UserValues.userID,
        cardcode: 'B1111',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "ICICI GIFT COUPON",
        createdUserID: UserValues.userID,
        couponcode: '1256',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 1000,
        updateduserid: UserValues.userID,
        cardcode: 'B3333',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "UNILET COUPONS",
        createdUserID: UserValues.userID,
        couponcode: '43245',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 900,
        updateduserid: UserValues.userID,
        cardcode: 'B1111',
        doctype: 'SalesInvoice',
        status: 'Open'),
    CouponDetModel(
        coupontype: "INSIGNIA COUPONS",
        createdUserID: UserValues.userID,
        couponcode: '432456',
        lastupdateIp: UserValues.lastUpdateIp,
        couponamt: 1000,
        updateduserid: UserValues.userID,
        cardcode: 'B2222',
        doctype: 'SalesInvoice',
        status: 'Open'),
  ];
}
