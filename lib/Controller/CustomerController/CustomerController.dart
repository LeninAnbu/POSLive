import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Service/ReportsApi/AddressReportApi.dart';
import 'package:posproject/Service/ReportsApi/CustomerApi.dart';
import 'package:sqflite/sqflite.dart';

import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/ReportsModel/AddressRepModel.dart';
import '../../Models/ReportsModel/CustomerReportModel.dart';

class CustomerController extends ChangeNotifier {
  init() {
    clearalldata();
    // getcustomerMaster();
    callCustReportapi();
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());

  List<CustomerReportData>? customerReportdata = [];
  callCustReportapi() async {
    log('step1');
    customerList = [];
    listbool = true;
    filtercustomerList = [];
    customerReportdata = [];
    await CustomersReportApi.getGlobalData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log('customerdata lenght::${value.customerdata!.length}');
        customerReportdata = value.customerdata!;
        log('customerReportdata![i].cardCode::${customerReportdata![0].cardCode}');
        for (var i = 0; i < customerReportdata!.length; i++) {
          customerList.add(CustomerMasterList(
              customerCode: customerReportdata![i].cardCode,
              customername: customerReportdata![i].name,
              balance: customerReportdata![i].accBalance,
              points: customerReportdata![i].point,
              emalid: customerReportdata![i].email,
              taxno: customerReportdata![i].taxCode,
              phoneno1: customerReportdata![i].phNo,
              customertype: customerReportdata![i].customertype));
        }
        filtercustomerList = customerList;
        listbool = false;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        listbool = false;

        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<AddressReportData>? addressListdata = [];
  callAddresstReportapi(String cardCode) async {
    log('step1');
    customerList = [];
    listbool = true;
    filtercustomerList = [];
    customerReportdata = [];
    await Addressreportapi.getGlobalData(cardCode).then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log('customerdata lenght::${value.customerdata!.length}');
        addressListdata = value.customerdata!;
        if (addressListdata!.isNotEmpty) {
          // log('customerReportdata![i].cardCode::${customerReportdata![0].cardCode}');
          for (var i = 0; i < addressListdata!.length; i++) {
            cutomerdetail.add(AddressReportData(
                address1: addressListdata![i].address1,
                address2: addressListdata![i].address2,
                address3: addressListdata![i].address3,
                pincode: addressListdata![i].pincode,
                city: addressListdata![i].city,
                statecode: addressListdata![i].statecode,
                countrycode: addressListdata![i].countrycode,
                custcode: addressListdata![i].custcode,
                geolocation1: addressListdata![i].geolocation1,
                geolocation2: addressListdata![i].geolocation2));
          }
          listbool = false;

          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        listbool = false;

        notifyListeners();
      }
    });
    notifyListeners();
  }

  List<TextEditingController> mycontroller =
      List.generate(150, (i) => TextEditingController());
  PageController tappage = PageController(initialPage: 0);
  int tappageIndex = 0;

  Future<bool> onbackpress() async {
    log("objectaaaaaaaaaaaaaaaaaaa:::::$tappageIndex");
    if (tappageIndex == 0) {
      Get.offAllNamed(ConstantRoutes.dashboard);
    } else {
      log("objectbbbbbbbbbb:::::$tappageIndex");
      await tappage.animateToPage(--tappageIndex,
          duration: const Duration(milliseconds: 250), curve: Curves.bounceIn);
      getcustomerMaster();
      mycontroller[0].clear();
      notifyListeners();
      // return Future.value(true);
      log("object:::::$tappageIndex");
    }
    // else if(tappageIndex == 1){
    //   //  tappage.animateToPage(--tappageIndex,
    //   //     duration: Duration(milliseconds: 250), curve: Curves.bounceIn);

    // };
    return Future.value(false);
  }

  pageplus() {
    int page = 0;
    // tappageIndex=0;
    if (page == 0) {
      tappage.animateToPage(++tappageIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.linearToEaseOut);
      // Get.toNamed(ConstantRoutes.dashboard);
    }
  }

  routecustome() {
    // if (tappageIndex == 2) {
    tappage.animateToPage(--tappageIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.linearToEaseOut);
    log("page ajajajd::::$tappageIndex");
    return true;

    // }
    // else {
    //   return false;
    // }
  }

  // Future<bool> onWillPop(BuildContext context) async {
  //   return (
  //     await
  //   showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text("Are you sure?"),
  //           content: Text("Do you want to exit an app"),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               child: Text("No"),
  //             ),
  //             TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop(true);
  //                 },
  //                 child: Text("yes"))
  //           ],
  //         ),
  //       )) ??
  //       false;
  // }
  List<CustomerMasterList> customerList = [];
  List<CustomerMasterList> filtercustomerList = [];
  bool listbool = false;
  getcustomerMaster() async {
    listbool = true;
    customerList.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getCustomerData =
        await DBOperation.getCstmMasforcustomerpage(db);
    if (getCustomerData.isNotEmpty) {
      for (int i = 0; i < getCustomerData.length; i++) {
        customerList.add(CustomerMasterList(
          customerCode: getCustomerData[i]["customercode"].toString(),
          customername: getCustomerData[i]["customername"].toString(),
          balance: double.parse(getCustomerData[i]["balance"].toString()),
          points: getCustomerData[i]["points"].toString(),
          emalid: getCustomerData[i]["emalid"].toString(),
          customertype: getCustomerData[i]["customertype"].toString(),
          phoneno1: getCustomerData[i]["phoneno1"].toString(),
          taxno: getCustomerData[i]["taxno"].toString(),
        ));

        //   await AccountBalApi.getData(getCustomerData[i]["customercode"].toString()).then((value) {
        //     // loadingscrn = false;
        //     if (value.statuscode >= 200 && value.statuscode <= 210) {
        //       print("Account Balance");
        //       customerList[i].customerCode = double.parse(value.accBalanceData![0].balance.toString()).toString();
        //       // selectedcust55!.accBalance = double.parse(value.accBalanceData![0].balance.toString());
        //       notifyListeners();
        //     }
        //   });
      }

      filtercustomerList = customerList;
      // notifyListeners();
    } else {
      listbool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    if (v.isNotEmpty) {
      filtercustomerList = customerList
          .where((e) =>
                  e.customername!.toLowerCase().contains(v.toLowerCase()) ||
                  e.customerCode!.toLowerCase().contains(v.toLowerCase())
              // ||
              // e.serialbatch!.toLowerCase().contains(v.toLowerCase())
              )
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtercustomerList = customerList;
      notifyListeners();
    }
  }

  List<AddressReportData> cutomerdetail = [];
  // detailsMetod(String customerCode) async {
  //   cutomerdetail.clear();
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> getCustomerDetails =
  //       await DBOperation.getcustomerdetails(db, customerCode);
  //   if (getCustomerDetails.isEmpty) {
  //     log("Customer details is Empty");
  //   } else {
  //     for (int i = 0; i < getCustomerDetails.length; i++) {
  //       cutomerdetail.add(CustomerMasterDetail(
  //           createdUserID: getCustomerDetails[i]["createdUserID"].toString(),
  //           createdateTime: getCustomerDetails[i]["createdateTime"].toString(),
  //           lastupdateIp: getCustomerDetails[i]["lastupdateIp"].toString(),
  //           updatedDatetime:
  //               getCustomerDetails[i]["UpdatedDatetime"].toString(),
  //           updateduserid: getCustomerDetails[i]["updateduserid"].toString(),
  //           getCustomerDetails[i]["address1"].toString(),
  //           address2: getCustomerDetails[i]["address2"].toString(),
  //           address3: getCustomerDetails[i]["address3"].toString(),
  //           pincode: getCustomerDetails[i]["pincode"].toString(),
  //           city: getCustomerDetails[i]["city"].toString(),
  //           countrycode: getCustomerDetails[i]["countrycode"].toString(),
  //           custcode: getCustomerDetails[i]["custcode"].toString(),
  //           geolocation1: getCustomerDetails[i]["geolocation1"].toString(),
  //           geolocation2: getCustomerDetails[i]["geolocation2"].toString(),
  //           statecode: getCustomerDetails[i]["statecode"].toString()));
  //     }
  //     log("Customer details1:::::::::::::::${getCustomerDetails[0]["custcode"]}");
  //     log("Customer details::::${cutomerdetail[0].custcode}");
  //   }
  //   notifyListeners();
  // }

  // int list_i = 0;
  CustomerMasterList? cusList1;
  listPasss(CustomerMasterList cusList) {
    // cusList=null;
    cusList1 = cusList;
    notifyListeners();
  }

  // morecusdetail() async {
  //   listbool = true;
  //   customerList.clear();
  //   final Database db = (await DBHelper.getInstance())!;

  //   List<Map<String, Object?>> getCustomerData =
  //       await DBOperation.getMoreCstmMasforcuspage(db, mycontroller[0].text);
  //   if (getCustomerData.isNotEmpty) {
  //     for (int i = 0; i < getCustomerData.length; i++) {
  //       customerList.add(CustomerMasterList(
  //         customerCode: getCustomerData[i]["customercode"].toString(),
  //         customername: getCustomerData[i]["customername"].toString(),
  //         balance: double.parse(getCustomerData[i]["balance"].toString()),
  //         points: getCustomerData[i]["points"].toString(),
  //         emalid: getCustomerData[i]["emalid"].toString(),
  //         customertype: getCustomerData[i]["customertype"].toString(),
  //         phoneno1: getCustomerData[i]["phoneno1"].toString(),
  //         taxno: getCustomerData[i]["taxno"].toString(),
  //       ));
  //     }
  //     filtercustomerList = customerList;
  //     mycontroller[0].text = '';
  //     // notifyListeners();
  //   } else {
  //     // customerList.clear();
  //     //  getcustomerMaster();
  //     listbool = false;
  //     notifyListeners();
  //   }
  //   notifyListeners();
  // }

  clearalldata() {
    //  tappage = PageController(initialPage: 0);
    tappageIndex = 0;
    filtercustomerList.clear();
    listbool = false;
    customerList.clear();
    cutomerdetail.clear();
    mycontroller[0].clear();
    notifyListeners();
  }
}

class CustomerMasterList {
  String? customerCode;
  String? customername;
  double? balance;
  String? points;
  String? emalid;
  String? taxno;
  String? phoneno1;
  String? customertype;

  CustomerMasterList({
    required this.customerCode,
    required this.customername,
    required this.balance,
    required this.points,
    required this.emalid,
    required this.taxno,
    required this.phoneno1,
    required this.customertype,
  });
}
