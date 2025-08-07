import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Models/StockListModel/ItemsModels.dart';
import 'package:posproject/Models/StockListModel/MainGroupModel.dart';
import 'package:posproject/Models/StockListModel/SubGroupMdl.dart';
import 'package:posproject/ServiceLayerAPIss/OrderAPI/OrderLoginnAPI.dart';
import 'package:posproject/ServiceLayerAPIss/StocklistApi/ItemsApis.dart';
import 'package:posproject/ServiceLayerAPIss/StocklistApi/MainGroupApi.dart';
import 'package:posproject/ServiceLayerAPIss/StocklistApi/SubGroupApi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/ItemMaster.dart';

class StockController extends ChangeNotifier {
  init(BuildContext context) async {
    clearAllData();
    await callMainAndSubGroupApi(context);
    notifyListeners();
  }

  bool visibleItemList = false;
  bool maingoupload = false;

  Configure config = Configure();
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  List<TextEditingController> mycontroller =
      List.generate(100, (i) => TextEditingController());
  bool listshow = false;
  double values = 0;
  double min = 0;
  double max = 50;

  double get getvalues => values;
  double get getmin => min;
  double get getmax => max;

  List<ItemMasterModelDB> brandList = [];
  List<ItemMasterModelDB> productList = [];
  List<ItemMasterModelDB> segmentList = [];
  List<ItemMasterModelDB> listPriceAvail = [];

  List<ItemMasterModelDB> get getbrandList => brandList;
  List<ItemMasterModelDB> get getproductList => productList;
  List<ItemMasterModelDB> get getsegmentList => segmentList;
  List<ItemMasterModelDB> get getlistPriceAvail => listPriceAvail;

  List<String> isselectedBrandString = [];
  List<String> isselectedProductString = [];
  List<String> isselectedSegmentString = [];
  List<String> get getisselectedBrandString => isselectedBrandString;
  List<String> get getisselectedProductString => isselectedProductString;
  List<String> get getisselectedSegmentString => isselectedSegmentString;

  List<ItemMasterModelDB> viewAll = [];
  List<ItemMasterModelDB> get getviewAll => viewAll;
  List<String> isselectedViewAllString = [];
  List<String> get getisselectedViewAllString => isselectedViewAllString;

  bool viewAllBrandSelected = false;
  bool viewAllProductSelected = false;
  bool viewAllSegementSelected = false;

  bool get getviewAllBrandSelected => viewAllBrandSelected;
  bool get getviewAllProductSelected => viewAllProductSelected;
  bool get getviewAllSegementSelected => viewAllSegementSelected;

  bool isBPSSelected = false;
  bool isBrandViewAllSelected = false;
  bool isProductViewAllSelected = false;
  bool isSegmentViewAllSelected = false;

  bool get getisBPSSelected => isBPSSelected;
  bool get getisBrandViewAllSelected => isBrandViewAllSelected;
  bool get getisProductViewAllSelected => isProductViewAllSelected;
  bool get getisSegmentViewAllSelected => isSegmentViewAllSelected;

  var rageValue = const RangeValues(0, 0);

  RangeValues get getrangevalue => rageValue;

  bool isLoadingListView = false;
  bool get getisLoadingListView => isLoadingListView;

  List<ItemMasterModelDB> filterdataprice = [];

  isSelectedBPS() {
    isBPSSelected = true;
    notifyListeners();
  }

  isSelectedBrandViewAll2() {
    isBrandViewAllSelected = true;
    notifyListeners();
  }

  isSelectedProductViewAll2() {
    isProductViewAllSelected = true;
    notifyListeners();
  }

  isSelectedSegmentViewAll2() {
    isSegmentViewAllSelected = true;
    notifyListeners();
  }

  filterList(String v) {
    if (v.isNotEmpty) {
      listPriceAvail = filterdataprice
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemnameshort!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      listPriceAvail = filterdataprice;
      notifyListeners();
    }
  }

  disableKeyBoard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    notifyListeners();
  }

  validateSearch(BuildContext context) async {
    if (formkey[1].currentState!.validate()) {
      disableKeyBoard(context);
      mycontroller[0].clear();
      Navigator.pop(context);
      final Database db = (await DBHelper.getInstance())!;

      await DBOperation.getSearchData(mycontroller[0].text, db).then((resul) {
        listPriceAvail = resul;
        listshow = true;

        notifyListeners();
      });
    }
  }

  getrange(RangeValues val) {
    rageValue = val;

    onSelectedFilter();
  }

  getDataFromDB() async {
    final Database db = (await DBHelper.getInstance())!;

    brandList = await DBOperation.getFavData("brand", db);
    productList = await DBOperation.getFavData("Itemcode", db);
    segmentList = await DBOperation.getFavData("itemname_short", db);
    log(brandList.length.toString());
    log(productList.length.toString());
    log(segmentList.length.toString());
    notifyListeners();
  }

  bool searchlist = false;
  showSearchDialogBox(BuildContext context) {
    showDialog<dynamic>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              content: SizedBox(
                width: Screens.width(context) * 0.3,
                child: Form(
                  key: formkey[1],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                          controller: mycontroller[0],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Required *";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Search here',
                              border: const UnderlineInputBorder(),
                              enabledBorder: const UnderlineInputBorder(),
                              focusedBorder: const UnderlineInputBorder(),
                              errorBorder: const UnderlineInputBorder(),
                              focusedErrorBorder: const UnderlineInputBorder(),
                              suffixIcon: InkWell(
                                  onTap: () {
                                    context
                                        .read<StockController>()
                                        .validateSearch(context);
                                  },
                                  child: Icon(Icons.search,
                                      color: theme.primaryColor)))),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  changevalue(double value) {
    values = value;
    notifyListeners();
  }

  isselectedBrand(int i) {
    if (brandList[i].isselected == 0) {
      brandList[i].isselected = 1;
      addBrand(brandList[i].brand!);
    } else {
      brandList[i].isselected = 0;
      removeBrand(brandList[i].brand!);
    }
  }

  addBrand(String brand) {
    isselectedBrandString.add("'$brand'");
    onSelectedFilter();
  }

  removeBrand(String brand) {
    isselectedSegmentString.remove("'$brand'");
    onSelectedFilter();
  }

  isselectedProduct(int i) {
    if (productList[i].isselected == 0) {
      productList[i].isselected = 1;
      addProduct(productList[i].itemcode!);
    } else {
      productList[i].isselected = 0;
      removeProduct(productList[i].itemcode!);
    }
  }

  addProduct(String brand) {
    isselectedProductString.add("'$brand'");
    onSelectedFilter();
  }

  removeProduct(String brand) {
    isselectedProductString.remove("'$brand'");
    onSelectedFilter();
  }

  isselectedSegment(int i) {
    if (segmentList[i].isselected == 0) {
      segmentList[i].isselected = 1;
      addSegment(segmentList[i].itemnameshort!);
    } else {
      segmentList[i].isselected = 0;
      removeSegment(segmentList[i].itemnameshort!);
    }
  }

  addSegment(String brand) {
    isselectedSegmentString.add("'$brand'");
    onSelectedFilter();
  }

  removeSegment(String brand) {
    isselectedSegmentString.remove("'$brand'");
    onSelectedFilter();
  }

  isselectedbrandViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = true;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;

    viewAll.clear();
    isselectedViewAllString.clear();
    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("brand", db);

      notifyListeners();
    } else if (isBPSSelected == true) {
      viewAll = brandList;

      notifyListeners();
    }
    notifyListeners();
  }

  isselectedBrandViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].brand!);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].brand!);
    }
  }

  addBrandViewAll(String brand) {
    isselectedViewAllString.add("'$brand'");
    notifyListeners();
  }

  removeBrandViewAll(String brand) {
    isselectedViewAllString.remove("'$brand'");
    notifyListeners();
  }

  isselectedProductViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = true;
    viewAllSegementSelected = false;
    viewAll.clear();
    isselectedViewAllString.clear();

    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("Itemcode", db);
    } else if (isBPSSelected == true) {
      viewAll = productList;
    }
    notifyListeners();
  }

  isselectedProductViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].itemcode!);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].itemcode!);
    }
  }

  addProductViewAll(String category) {
    isselectedViewAllString.add("'$category'");
    notifyListeners();
  }

  removeProductViewAll(String category) {
    isselectedViewAllString.remove("'$category'");
    notifyListeners();
  }

  isselectedSegmentViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = true;
    viewAll.clear();
    isselectedViewAllString.clear();
    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("itemname_short", db);
    } else if (isBPSSelected == true) {
      viewAll = segmentList;
    }
    notifyListeners();
  }

  isselectedSegmentViewAll(int i) {
    if (viewAll[i].isselected == 0) {
      viewAll[i].isselected = 1;
      addBrandViewAll(viewAll[i].itemcode!);
    } else {
      viewAll[i].isselected = 0;
      removeBrandViewAll(viewAll[i].itemcode!);
    }
    notifyListeners();
  }

  addSegmentViewAll(String category) {
    isselectedViewAllString.add("'$category'");
  }

  removeSegmentViewAll(String category) {
    isselectedViewAllString.remove("'$category'");
  }

  clearData() {
    groupmycontroller = List.generate(15, (i) => TextEditingController());
    valueSelectedMain = null;
    visibilityError = '';
    visibleItemList = false;
    valueSelectedSub = null;
    getSearchedData = [];
    getfilterSearchedData = [];
    searchBtnLoading = false;
    itemValue = [];
    filteritemValue = [];
    getSearchedData = [];
    notifyListeners();
  }

  clearAllData() {
    groupmycontroller = List.generate(15, (i) => TextEditingController());
    valueSelectedMain = null;
    itemValue = [];
    mainValueValue = [];

    getfilterSearchedData = [];
    getSearchedData = [];
    searchBtnLoading = false;
    filteritemValue = [];
    subValueValue = [];
    visibilityError = '';
    valueSelectedSub = null;
    listshow = false;
    isselectedBrandString.clear();
    isselectedProductString.clear();
    isselectedSegmentString.clear();
    brandList.clear();
    productList.clear();
    segmentList.clear();
    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;
    isselectedViewAllString.clear();
    viewAll.clear();
    selectstringbarndsw.clear();
    selectstringsegmentsw.clear();
    selectstringproductsw.clear();
    rageValue = const RangeValues(0, 0);
    isBPSSelected = false;
    isBrandViewAllSelected = false;
    isProductViewAllSelected = false;
    isSegmentViewAllSelected = false;
    listPriceAvail.clear();
    notifyListeners();
  }

  String custserieserrormsg = '';
  sapOrderLoginApi(
    BuildContext context,
  ) async {
    final pref2 = await pref;
    PostOrderLoginAPi.username = AppConstant.sapUserName;
    PostOrderLoginAPi.password = AppConstant.sapPassword;
    await PostOrderLoginAPi.getGlobalData().then((value) async {
      if (value.stCode! >= 200 && value.stCode! <= 210) {
        if (value.sessionId != null) {
          AppConstant.sapSessionID = '';

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
        //   custserieserrormsg = value.error!.message!.value.toString();

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
        //     "Something went wrong !!..",
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
    notifyListeners();
  }

  Future<SharedPreferences> pref = SharedPreferences.getInstance();

  List<MainModalValue> mainValueValue = [];
  List<SubModalValue> subValueValue = [];
  String? valueSelectedMain;
  String? valueSelectedSub;
  String? valueSelectedMainName;
  String? valueSelectedSubName;
  List<ItemMasterModelDB> getSearchedData = [];
  List<ItemMasterModelDB> getfilterSearchedData = [];

  Future<List<ItemMasterModelDB>?> getAllListItem(
      String data, String category, String subCategory) async {
    getfilterSearchedData = [];
    getSearchedData = [];
    if (data.isNotEmpty) {
      log('message111');
      final Database db = (await DBHelper.getInstance())!;
      getSearchedData = await DBOperation.getSearchedStockList22(
          db, data, category, subCategory);
      getfilterSearchedData = getSearchedData;
      notifyListeners();
      return getSearchedData;
    } else {
      getSearchedData = [];
    }
    return null;
  }

  Future<List<ItemMasterModelDB>?> getAllListItem22(
      String category, String subCategory) async {
    getfilterSearchedData = [];
    getSearchedData = [];
    log('message111');

    double packsize = groupmycontroller[0].text.isNotEmpty
        ? double.parse(groupmycontroller[0].text)
        : 0;
    String packsize2 = packsize != 0 ? packsize.toStringAsFixed(6) : '_';
    final Database db = (await DBHelper.getInstance())!;
    getSearchedData = await DBOperation.getSearchedStockList33(
        db, category, subCategory, packsize2);
    getfilterSearchedData = getSearchedData;
    notifyListeners();
    return getSearchedData;
  }

  selectedMainGroup(String val) {
    for (var i = 0; i < mainValueValue.length; i++) {
      if (mainValueValue[i].code.toString() == val.toString()) {
        valueSelectedMainName = mainValueValue[i].name.toString();
      }
    }
    notifyListeners();
  }

  selectedSubGroup(String val) {
    for (var i = 0; i < subValueValue.length; i++) {
      if (subValueValue[i].code.toString() == val.toString()) {
        valueSelectedSubName = subValueValue[i].name.toString();
      }
    }
    notifyListeners();
  }

  callMainAndSubGroupApi(BuildContext context) async {
    Get.defaultDialog(
        barrierDismissible: false,
        title: '',
        content: Container(
          child: CircularProgressIndicator(
            color: Colors.blue,
          ),
        ));
    await sapOrderLoginApi(context);

    notifyListeners();
    await MainGroupAPi.getGlobalData().then((value) {
      mainValueValue = value.itemValueValue!;
    });

    await SubGroupAPi.getGlobalData().then((value) {
      value.itemValueValue![0].code;
      subValueValue = value.itemValueValue!;
      Get.back();
    });
    notifyListeners();
  }

  List<ItemValue> itemValue = [];
  List<ItemValue> filteritemValue = [];
  List<TextEditingController> groupmycontroller =
      List.generate(15, (i) => TextEditingController());
  String visibilityError = '';
  bool searchBtnLoading = false;
  Future<void> valuesAdd(BuildContext context) async {
    filteritemValue = [];
    itemValue = [];
    getSearchedData = [];
    getfilterSearchedData = [];
    groupmycontroller[1].text = '';
    visibilityError = '';
    searchBtnLoading = true;
    sapOrderLoginApi(context);
    ItemsAPi.mainGroup = valueSelectedMain ?? 'a';
    ItemsAPi.subGroup = valueSelectedSub ?? 'a';
    ItemsAPi.searchData = groupmycontroller[2].text.trim();
    String packSize =
        groupmycontroller[0].text.isNotEmpty ? groupmycontroller[0].text : '_';

    await ItemsAPi.getGlobalData(packSize).then((value) {
      searchBtnLoading = false;
      if (value.itemValueValue!.isNotEmpty) {
        itemValue = value.itemValueValue!;
        ItemsAPi.nextUrl = value.nextLink;
        log('itemValueitemValue::${itemValue.length}');

        notifyListeners();
      } else if (value.itemValueValue!.isEmpty) {
        visibilityError = 'No Data Found';
        searchBtnLoading = false;
      }
    });
    notifyListeners();
  }

  Future<void> getmoredata() async {
    await ItemsAPi.callNextLink().then((val) {
      if (val.itemValueValue!.isNotEmpty) {
        for (int i = 0; i < val.itemValueValue!.length; i++) {}
      }
    });
  }

  clearViewAllData() {
    viewAll.clear();

    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;

    onSelectedFilter();
  }

  Future<List<ItemMasterModelDB>> brandViewAllData() async {
    List<ItemMasterModelDB> newBrandList = [];
    if (isselectedViewAllString.isNotEmpty) {
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;

          newBrandList.add(ItemMasterModelDB(
              isselected: viewAll[i].isselected,
              autoId: viewAll[i].autoId,
              maximumQty: viewAll[i].maximumQty,
              minimumQty: viewAll[i].minimumQty,
              weight: viewAll[i].weight,
              liter: viewAll[i].liter,
              displayQty: viewAll[i].displayQty,
              searchString: viewAll[i].searchString,
              brand: viewAll[i].brand,
              managedBy: viewAll[i].managedBy,
              category: "null",
              createdUserID: viewAll[i].createdUserID,
              createdateTime: viewAll[i].createdateTime,
              mrpprice: viewAll[i].mrpprice,
              sellprice: viewAll[i].sellprice,
              hsnsac: viewAll[i].hsnsac,
              isActive: viewAll[i].isActive,
              isfreeby: viewAll[i].isfreeby,
              isinventory: viewAll[i].isinventory,
              issellpricebyscrbat: viewAll[i].issellpricebyscrbat,
              isserialBatch: viewAll[i].isserialBatch,
              itemcode: "null",
              itemnamelong: viewAll[i].itemnamelong,
              itemnameshort: "null",
              lastupdateIp: viewAll[i].lastupdateIp,
              maxdiscount: viewAll[i].maxdiscount,
              skucode: viewAll[i].skucode,
              subcategory: "null",
              taxrate: viewAll[i].taxrate,
              updatedDatetime: viewAll[i].updatedDatetime,
              updateduserid: viewAll[i].updateduserid,
              uPackSizeuom: viewAll[i].uPackSizeuom,
              uPackSize: viewAll[i].uPackSize,
              uTINSPERBOX: viewAll[i].uTINSPERBOX,
              uSpecificGravity: viewAll[i].uSpecificGravity,
              quantity: null));
        }
      }
      brandList = newBrandList;
      return Future.value(brandList);
    }
    brandList = newBrandList;
    return Future.value(brandList);
  }

  Future<List<ItemMasterModelDB>> productViewAllData() async {
    List<ItemMasterModelDB> newProductList = [];

    if (isselectedViewAllString.isNotEmpty) {
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newProductList.add(ItemMasterModelDB(
              isselected: viewAll[i].isselected,
              autoId: viewAll[i].autoId,
              maximumQty: viewAll[i].maximumQty,
              minimumQty: viewAll[i].minimumQty,
              managedBy: viewAll[i].managedBy,
              weight: viewAll[i].weight,
              liter: viewAll[i].liter,
              displayQty: viewAll[i].displayQty,
              searchString: viewAll[i].searchString,
              brand: "null",
              category: viewAll[i].category,
              quantity: viewAll[i].quantity,
              createdUserID: viewAll[i].createdUserID,
              createdateTime: viewAll[i].createdateTime,
              mrpprice: viewAll[i].mrpprice,
              sellprice: viewAll[i].sellprice,
              hsnsac: viewAll[i].hsnsac,
              isActive: viewAll[i].isActive,
              isfreeby: viewAll[i].isfreeby,
              isinventory: viewAll[i].isinventory,
              issellpricebyscrbat: viewAll[i].issellpricebyscrbat,
              isserialBatch: viewAll[i].isserialBatch,
              itemcode: viewAll[i].itemcode,
              itemnamelong: viewAll[i].itemnamelong,
              itemnameshort: "null",
              lastupdateIp: viewAll[i].lastupdateIp,
              maxdiscount: viewAll[i].maxdiscount,
              skucode: viewAll[i].skucode,
              subcategory: "null",
              taxrate: viewAll[i].taxrate,
              uPackSizeuom: viewAll[i].uPackSizeuom,
              uPackSize: viewAll[i].uPackSize,
              uTINSPERBOX: viewAll[i].uTINSPERBOX,
              uSpecificGravity: viewAll[i].uSpecificGravity,
              updatedDatetime: viewAll[i].updatedDatetime,
              updateduserid: viewAll[i].updateduserid));
        }
      }
      productList = newProductList;
      return Future.value(productList);
    }
    productList = newProductList;
    return Future.value(productList);
  }

  Future<List<ItemMasterModelDB>> segmentViewAllData() {
    List<ItemMasterModelDB> newSegmentList = [];
    if (isselectedViewAllString.isNotEmpty) {
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newSegmentList.add(ItemMasterModelDB(
              managedBy: viewAll[i].managedBy,
              uPackSizeuom: viewAll[i].uPackSizeuom,
              uPackSize: viewAll[i].uPackSize,
              uTINSPERBOX: viewAll[i].uTINSPERBOX,
              uSpecificGravity: viewAll[i].uSpecificGravity,
              isselected: viewAll[i].isselected,
              autoId: viewAll[i].autoId,
              maximumQty: viewAll[i].maximumQty,
              minimumQty: viewAll[i].minimumQty,
              weight: viewAll[i].weight,
              liter: viewAll[i].liter,
              displayQty: viewAll[i].displayQty,
              searchString: viewAll[i].searchString,
              brand: "null",
              category: "null",
              quantity: viewAll[i].quantity,
              createdUserID: viewAll[i].createdUserID,
              createdateTime: viewAll[i].createdateTime,
              mrpprice: viewAll[i].mrpprice,
              sellprice: viewAll[i].sellprice,
              hsnsac: viewAll[i].hsnsac,
              isActive: viewAll[i].isActive,
              isfreeby: viewAll[i].isfreeby,
              isinventory: viewAll[i].isinventory,
              issellpricebyscrbat: viewAll[i].issellpricebyscrbat,
              isserialBatch: viewAll[i].isserialBatch,
              itemcode: "null",
              itemnamelong: viewAll[i].itemnamelong,
              itemnameshort: viewAll[i].itemnameshort,
              lastupdateIp: viewAll[i].lastupdateIp,
              maxdiscount: viewAll[i].maxdiscount,
              skucode: viewAll[i].skucode,
              subcategory: "null",
              taxrate: viewAll[i].taxrate,
              updatedDatetime: viewAll[i].updatedDatetime,
              updateduserid: viewAll[i].updateduserid));
        }
      }
      segmentList = newSegmentList;
      return Future.value(segmentList);
    }
    segmentList = newSegmentList;
    return Future.value(productList);
  }

  Future<String> checkSelectedValuesBrand() {
    isselectedBrandString.clear();
    selectstringbarndsw.clear();
    for (int i = 0; i < brandList.length; i++) {
      if (brandList[i].isselected == 1) {
        isselectedBrandString.add("'${brandList[i].brand}'");
        selectstringbarndsw.add(brandList[i].brand!);
      }
    }
    String text = isselectedBrandString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  Future<String> checkSelectedValuesProduct() {
    isselectedProductString.clear();
    selectstringproductsw.clear();
    for (int i = 0; i < productList.length; i++) {
      if (productList[i].isselected == 1) {
        isselectedProductString.add("'${productList[i].itemcode}'");
        selectstringproductsw.add(productList[i].itemcode!);
      }
    }

    String text = isselectedProductString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  Future<String> checkSelectedValuesSegment() {
    isselectedSegmentString.clear();
    selectstringsegmentsw.clear();
    for (int i = 0; i < segmentList.length; i++) {
      if (segmentList[i].isselected == 1) {
        isselectedSegmentString.add("'${segmentList[i].itemnameshort!}'");
        selectstringsegmentsw.add(segmentList[i].itemnameshort!);
      }
    }

    String text = isselectedSegmentString
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
    return Future.value(text);
  }

  onSelectedFilter() async {
    final Database db = (await DBHelper.getInstance())!;

    String brand = await checkSelectedValuesBrand();
    String product = await checkSelectedValuesProduct();
    String segment = await checkSelectedValuesSegment();
    await DBOperation.onFieldSeleted(
            brand.isEmpty ? "''" : brand,
            product.isEmpty ? "''" : product,
            segment.isEmpty ? "''" : segment,
            isselectedBrandString.isEmpty ? '' : '1',
            isselectedProductString.isEmpty ? '' : '1',
            isselectedSegmentString.isEmpty ? '' : '1',
            rageValue.start.toString(),
            rageValue.end.toString(),
            db)
        .then((value) async {
      brandList.clear();
      productList.clear();
      segmentList.clear();

      listPriceAvail = value;
      filterdataprice = listPriceAvail;
      brandList = await distinctBrand(value);
      productList = await distinctProduct(value);
      segmentList = await distinctSegment(value);
      notifyListeners();
    });
  }

  setList() {
    listshow = true;
    notifyListeners();
  }

  Future<List<ItemMasterModelDB>> distinctSegment(
      List<ItemMasterModelDB> dataval) {
    List<ItemMasterModelDB> newData = [];
    var segmentdata = dataval.map((e) => e.itemnameshort).toSet().toList();
    for (int i = 0; i < segmentdata.length; i++) {
      int isgot = 0;
      if (selectstringsegmentsw.isNotEmpty) {
        for (int j = 0; j < selectstringsegmentsw.length; j++) {
          if (segmentdata[i] == selectstringsegmentsw[j]) {
            isgot = i;
            break;
          }
        }
        newData.add(ItemMasterModelDB(
            uPackSizeuom: viewAll[i].uPackSizeuom,
            uPackSize: viewAll[i].uPackSize,
            uTINSPERBOX: viewAll[i].uTINSPERBOX,
            managedBy: viewAll[i].managedBy,
            uSpecificGravity: viewAll[i].uSpecificGravity,
            isselected: isgot == i ? 1 : 0,
            autoId: 0,
            maximumQty: '0',
            minimumQty: '0',
            weight: 0.0,
            liter: 0.0,
            displayQty: '0',
            searchString: "",
            brand: "",
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: "",
            itemnamelong: "",
            itemnameshort: segmentdata[i],
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            updatedDatetime: "",
            updateduserid: ""));
      } else {
        newData.add(ItemMasterModelDB(
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            isselected: 0,
            autoId: 0,
            maximumQty: '0',
            managedBy: viewAll[i].managedBy,
            minimumQty: '0',
            displayQty: '0',
            weight: 0.0,
            liter: 0.0,
            searchString: "",
            brand: "",
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: "",
            itemnamelong: "",
            itemnameshort: segmentdata[i],
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            updatedDatetime: "",
            updateduserid: ""));
      }
    }
    return Future.value(newData);
  }

  List<String> selectstringbarndsw = [];
  List<String> selectstringproductsw = [];
  List<String> selectstringsegmentsw = [];

  Future<List<ItemMasterModelDB>> distinctBrand(
      List<ItemMasterModelDB> dataval) async {
    List<ItemMasterModelDB> newData = [];
    var branddata = dataval.map((e) => e.brand).toSet().toList();

    for (int i = 0; i < branddata.length; i++) {
      int isgot = 0;
      if (selectstringbarndsw.isNotEmpty) {
        for (int j = 0; j < selectstringbarndsw.length; j++) {
          if (branddata[i] == selectstringbarndsw[j]) {
            isgot = i;

            break;
          }
        }

        newData.add(ItemMasterModelDB(
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            isselected: isgot == i ? 1 : 0,
            managedBy: viewAll[i].managedBy,
            autoId: 0,
            maximumQty: '0',
            minimumQty: '0',
            displayQty: '0',
            weight: 0.0,
            liter: 0.0,
            searchString: "",
            brand: branddata[i],
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: "",
            itemnamelong: "",
            itemnameshort: "",
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            updatedDatetime: "",
            updateduserid: ""));
      } else {
        newData.add(ItemMasterModelDB(
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            isselected: 0,
            autoId: 0,
            maximumQty: '0',
            minimumQty: '0',
            managedBy: viewAll[i].managedBy,
            displayQty: '0',
            weight: 0.0,
            liter: 0.0,
            searchString: "",
            brand: branddata[i],
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: "",
            itemnamelong: "",
            itemnameshort: "",
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            updatedDatetime: "",
            updateduserid: ""));
      }
    }
    return Future.value(newData);
  }

  Future<List<ItemMasterModelDB>> distinctProduct(
      List<ItemMasterModelDB> dataval) {
    List<ItemMasterModelDB> newData = [];
    var productdata = dataval.map((e) => e.itemcode).toSet().toList();

    for (int i = 0; i < productdata.length; i++) {
      int isgot = 0;
      if (selectstringproductsw.isNotEmpty) {
        for (int j = 0; j < selectstringproductsw.length; j++) {
          if (productdata[i] == selectstringproductsw[j]) {
            isgot = i;
            break;
          }
        }
        newData.add(ItemMasterModelDB(
            isselected: isgot == i ? 1 : 0,
            autoId: 0,
            maximumQty: '0',
            minimumQty: '0',
            displayQty: '0',
            weight: 0.0,
            liter: 0.0,
            searchString: "",
            brand: "",
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            managedBy: viewAll[i].managedBy,
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: productdata[i],
            itemnamelong: "",
            itemnameshort: "",
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            updatedDatetime: "",
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            updateduserid: ""));
      } else {
        newData.add(ItemMasterModelDB(
            isselected: 0,
            autoId: 0,
            maximumQty: '0',
            minimumQty: '0',
            displayQty: '0',
            weight: 0.0,
            liter: 0.0,
            searchString: "",
            managedBy: viewAll[i].managedBy,
            brand: "",
            category: "",
            quantity: 0,
            createdUserID: "",
            createdateTime: "",
            mrpprice: "",
            sellprice: "",
            hsnsac: "",
            isActive: "",
            isfreeby: "",
            isinventory: "",
            issellpricebyscrbat: "",
            isserialBatch: "",
            itemcode: productdata[i],
            itemnamelong: "",
            itemnameshort: "",
            lastupdateIp: "",
            maxdiscount: 0,
            skucode: "",
            subcategory: "",
            taxrate: "",
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            updatedDatetime: "",
            updateduserid: ""));
      }
    }
    return Future.value(newData);
  }

  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;

  File? source1;
  Directory? copyTo;
  Future<File> getPathOFDB() async {
    final dbFolder = await getDatabasesPath();
    File source1 = File('$dbFolder/SellerKit.db');
    return Future.value(source1);
  }

  Future<Directory> getDirectory() async {
    Directory copyTo = Directory("storage/emulated/0/Sqlite Backup");
    return Future.value(copyTo);
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
      title: "Notidy",
      message: e,
    ));
  }

  Future<String> createDirectory() async {
    try {
      await copyTo!.create();
      String newPath = "${copyTo!.path}";
      createDBFile(newPath);
      return newPath;
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
    return 'null';
  }

  createDBFile(String path) async {
    try {
      String getPath = "$path/SellerKit.db";
      await source1!.copy(getPath);
      showSnackBars("Created!!...", Colors.green);
    } catch (e) {
      showSnackBars("$e", Colors.red);
    }
  }

  listDialogue(BuildContext context, ItemValue itemValue, int i) {
    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              content: Container(
                width: Screens.width(context) * 0.8,
                height: Screens.padingHeight(context) * 0.3,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close_outlined,
                                  color: theme.primaryColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: Screens.padingHeight(context) * 0.04,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              width: Screens.width(context) * 0.1,
                              child: Text(
                                "S.No",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.2,
                              child: Text(
                                "Item Name",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              child: Text(
                                "Item Code",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              child: Text(
                                "Serialbatch",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Qty",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Price",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Branch",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${i + 1}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.2,
                            child: Text(
                              "${itemValue.itemName}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${itemValue.itemCode}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${itemValue.itemPrices![0].price}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${AppConstant.branch}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  listDialogue22(BuildContext context, ItemMasterModelDB itemValue, int i) {
    showDialog<dynamic>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            final theme = Theme.of(context);
            return AlertDialog(
              contentPadding: EdgeInsets.all(2),
              content: Container(
                width: Screens.width(context) * 0.8,
                height: Screens.padingHeight(context) * 0.3,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close_outlined,
                                  color: theme.primaryColor,
                                )),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: Screens.padingHeight(context) * 0.04,
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              width: Screens.width(context) * 0.1,
                              child: Text(
                                "S.No",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.2,
                              child: Text(
                                "Item Name",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          Container(
                              alignment: Alignment.center,
                              width: Screens.width(context) * 0.1,
                              child: Text(
                                "Item Code",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.white),
                              )),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Qty",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Price",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                alignment: Alignment.center,
                                width: Screens.width(context) * 0.1,
                                child: Text(
                                  "Branch",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                )),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${i + 1}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.2,
                            child: Text(
                              "${itemValue.itemnameshort}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${itemValue.itemcode}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${itemValue.maximumQty}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${itemValue.sellprice}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: Screens.width(context) * 0.1,
                            child: Text(
                              "${AppConstant.branch}",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
