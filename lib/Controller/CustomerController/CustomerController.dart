import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posproject/Service/ReportsApi/AddressReportApi.dart';
import 'package:posproject/Service/ReportsApi/ApprovalReqExcelApi.dart';
import 'package:posproject/Service/ReportsApi/ApprovalReqPdfApi.dart';
import 'package:posproject/Service/ReportsApi/CustomerApi.dart';
import 'package:sqflite/sqflite.dart';
import '../../Constant/AppConstant.dart';
import '../../Constant/ConstantRoutes.dart';
import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/ReportsModel/AddressRepModel.dart';
import '../../Models/ReportsModel/CustomerReportModel.dart';
import '../../Service/ReportsApi/AgeingExcelReport.dart';
import '../../Service/ReportsApi/AgeingPdfAPI.dart';
import '../../Service/ReportsApi/SubGroupYTDPdf.dart';
import '../../Service/ReportsApi/SubGruopYTDExcel.dart';
import '../../Service/ReportsApi/customerStatementApi.dart';

class CustomerController extends ChangeNotifier {
  init() {
    clearalldata();
    callCustReportapi();
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(50, (i) => GlobalKey<FormState>());
  List<GlobalKey<FormState>> formkeyaging =
      List.generate(50, (j) => GlobalKey<FormState>());
  bool isScreenLoad = false;
  List<CustomerReportData>? customerReportdata = [];
  callCustReportapi() async {
    log('step1');
    customerList = [];
    listbool = true;
    filtercustomerList = [];
    customerReportdata = [];
    notifyListeners();

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

  String salesApiToVDate = '';
  String apiFromDate = '';
  String apiToDate = '';
  nowCurrentDate() {
    isScreenLoad = true;

    final date = DateTime.parse(DateTime.now().toString());
    salesApiToVDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    log('salesApiToVDatesalesApiToVDate::$salesApiToVDate');
  }

  DateTime findPreviousYear2(DateTime dateTime) {
    var dateTimeWithOffset = dateTime;

    log('dateTimeWithOffset Firstyear::$dateTimeWithOffset');
    return DateTime(dateTimeWithOffset.year - 1, 1);
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

  Future<void> callSubGroupSalesPdfApi(
      String methodname, BuildContext context) async {
    log('methodnamemethodname::${findPreviousYear2(DateTime.now()).toString().replaceAll('00:00:00.000', '')}:::${cusList1!.customerCode}:::$methodname');
    SubGroupSalesPdfReportAPi.fromDate = findPreviousYear2(DateTime.now())
        .toString()
        .replaceAll(' 00:00:00.000', '')
        .trim();

    SubGroupSalesPdfReportAPi.toDate = salesApiToVDate;
    SubGroupSalesPdfReportAPi.slpCode = AppConstant.slpCode;
    SubGroupSalesPdfReportAPi.methodName = methodname;
    SubGroupSalesPdfReportAPi.cardCode = cusList1!.customerCode;
    // mycontroller[9].text;
    // isFromSalesinDay = false;
    SubGroupSalesPdfReportAPi.getGlobalData().then((value) {
      if (value == 200) {
        isScreenLoad = false;
        notifyListeners();
      } else {
        isScreenLoad = false;
        showSnackBar('Try again!!..', context);
      }
    });
    notifyListeners();
  }

  Future<void> callSubGroupSalesExcelApi(
      String methodname, BuildContext context) async {
    log('methodnamemethodname::$methodname');
    isScreenLoad = true;
    SubGroupsSaleExcelReportAPi.fromDate = findPreviousYear2(DateTime.now())
        .toString()
        .replaceAll(' 00:00:00.000', '')
        .trim();
    SubGroupsSaleExcelReportAPi.toDate = salesApiToVDate;
    SubGroupsSaleExcelReportAPi.slpCode = AppConstant.slpCode;
    SubGroupsSaleExcelReportAPi.cardCode = cusList1!.customerCode;
    //  mycontroller[9].text;
    SubGroupsSaleExcelReportAPi.reportName = '${methodname}Excel';

    SubGroupsSaleExcelReportAPi.getGlobalData().then((value) {
      if (value == 200) {
        isScreenLoad = false;
        notifyListeners();
      } else {
        isScreenLoad = false;
        showSnackBar('Try again!!..', context);
      }
      // Navigator.pop(context);
    });

    notifyListeners();
  }

  Future<void> callApprovalReqPdfApi(BuildContext context) async {
    ApprovalReqApi.getGlobalData(cusList1!.customerCode).then((value) {
      if (value == 200) {
        isScreenLoad = false;
        notifyListeners();
      } else {
        isScreenLoad = false;
        showSnackBar('Try again!!..', context);
      }
    });
    notifyListeners();
  }

  Future<void> callApprovalReqExcelApi(BuildContext context) async {
    isScreenLoad = true;

    ApprovalReqExcelAPi.getGlobalData(cusList1!.customerCode!).then((value) {
      if (value == 200) {
        isScreenLoad = false;
        notifyListeners();
      } else {
        isScreenLoad = false;
        showSnackBar('Try again!!..', context);
      }
      // Navigator.pop(context);
    });

    notifyListeners();
  }

  Future<void> callApi(BuildContext context) async {
    if (formkey[0].currentState!.validate()) {
      isScreenLoad = true;
      //  isLoading = true;

      CustomerStatementApi.getGlobalData(
              cusList1!.customerCode, apiFromDate, apiToDate)
          .then((value) {
        if (value == 200) {
          isScreenLoad = false;
          notifyListeners();

          //isLoading = false;
        } else {
          isScreenLoad = false;
          //  isLoading = false;
          showSnackBar('Try again!!..', context);
        }
      });
      Get.back();
    }
    notifyListeners();
  }

  DateTime? currentBackPressTime;

  Future<bool> onbackpress3() {
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;

      Get.offAllNamed<dynamic>(ConstantRoutes.customer);
      listbool = true;

      notifyListeners();

      return Future.value(true);
    } else {
      notifyListeners();

      return Future.value(false);
    }
  }

  List<AddressReportData>? addressListdata = [];
  callAddresstReportapi(String cardCode) async {
    log('step1');
    customerList = [];
    listbool = true;
    filtercustomerList = [];
    customerReportdata = [];
    addressListdata = [];
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
  List<TextEditingController> searchmycontroller =
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
          customerCode: getCustomerData[i]["customerCode"].toString(),
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
    addressListdata = [];
    filtercustomerList.clear();
    listbool = false;
    customerList.clear();
    isScreenLoad = false;
    cutomerdetail.clear();
    mycontroller[0].clear();
    notifyListeners();
  }

  void showAgeingDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2050),
    ).then((value) {
      if (value == null) {
        return;
      }

      searchmycontroller[3].text = value.toString();
      var date = DateTime.parse(searchmycontroller[3].text);
      searchmycontroller[3].text = '';
      searchmycontroller[3].text =
          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";
      apiAgeingDate =
          "${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}";
      log('apiAgeingDate:$apiAgeingDate');
    });
    notifyListeners();
  }

  String apiAgeingDate = '';
  String apiCustCode = '';

  Future<void> callAgeingApi(BuildContext context) async {
    isScreenLoad = true;
    log('AgeingAPi.date::$apiAgeingDate');
    AgeingAPi.date = apiAgeingDate;
    AgeingAPi.custCode = searchmycontroller[4].text;
    AgeingAPi.slpCode = AppConstant.slpCode;

    await AgeingAPi.getGlobalData().then((value) {
      isScreenLoad = false;

      if (value == 200) {
        isScreenLoad = false;
        notifyListeners();
      } else {
        isScreenLoad = false;
        showSnackBar('Try again!!..', context);
        notifyListeners();
      }
    });
    Get.back();
    isScreenLoad = false;
    notifyListeners();
  }

  Future<void> callAgeingExcelApi(BuildContext context) async {
    if (formkeyaging[0].currentState!.validate()) {
      isScreenLoad = true;

      AgeingExcelAPi.date = apiAgeingDate;
      AgeingExcelAPi.slpCode = AppConstant.slpCode;
      AgeingExcelAPi.custCode = searchmycontroller[4].text;
      // print("SalesOnDayAPi.slpCode: " + AgeingExcelAPi.slpCode.toString());
      // isFromSalesinDay = false;
      await AgeingExcelAPi.getGlobalData().then((value) {
        isScreenLoad = false;
        notifyListeners();
        if (value == 200) {
        } else {
          showSnackBar('Try again!!..', context);
          notifyListeners();
        }
      });
      Get.back();
    }
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
