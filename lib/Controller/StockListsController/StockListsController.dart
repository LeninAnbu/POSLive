// ignore_for_file: unnecessary_string_interpolations

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../DBModel/ItemMaster.dart';

class StockController extends ChangeNotifier {
  init() {
    clearAllData();
    getDataFromDB();
  }

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

//Listview Loading on clicked
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
      //  log(mycontroller[0].text);
      disableKeyBoard(context);
      mycontroller[0].clear();
      Navigator.pop(context);
      final Database db = (await DBHelper.getInstance())!;

      await DBOperation.getSearchData(mycontroller[0].text, db).then((resul) {
        listPriceAvail = resul;
        listshow = true;
        // Get.toNamed(ConstantRoutes.listStockAvailability);
        notifyListeners();
      });
    }
  }

  // String subtractDateTime(String datetime) {
  //   return Jiffy("$datetime", "yyyy-MM-dd hh:mm:ss").fromNow();
  // }

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

  // DBHelper dbHelper = DBHelper();

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
                //  color: Colors.black12,
                // height: Screens.heigth(context) * 0.4,
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

  //selection

  isselectedBrand(int i) {
    if (brandList[i].isselected == 0) {
      brandList[i].isselected = 1;
      addBrand(brandList[i].brand!);
    } else {
      brandList[i].isselected = 0;
      removeBrand(brandList[i].brand!);
    }
    // notifyListeners();
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
    //notifyListeners();
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
    // notifyListeners();
  }

  addSegment(String brand) {
    isselectedSegmentString.add("'$brand'");
    onSelectedFilter();
  }

  removeSegment(String brand) {
    isselectedSegmentString.remove("'$brand'");
    onSelectedFilter();
  }

//// view all

  isselectedbrandViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = true;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;
    // isselectedViewAllString.clear();
    viewAll.clear();
    isselectedViewAllString.clear();
    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("brand", db);
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
      notifyListeners();
    } else if (isBPSSelected == true) {
      viewAll = brandList;
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
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

  //product viw all

  isselectedProductViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = true;
    viewAllSegementSelected = false;
    viewAll.clear();
    isselectedViewAllString.clear();
    // log(viewAll.length.toString());

    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("Itemcode", db);
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
    } else if (isBPSSelected == true) {
      viewAll = productList;
      // log(viewAll.length.toString());
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
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

//segment view all

  isselectedSegmentViewAllPage() async {
    final Database db = (await DBHelper.getInstance())!;

    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = true;
    viewAll.clear();
    isselectedViewAllString.clear();
    if (isBPSSelected == false) {
      viewAll = await DBOperation.getViewAllData("itemname_short", db);
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
    } else if (isBPSSelected == true) {
      viewAll = segmentList;
      // Get.toNamed(ConstantRoutes.stockListOfDetails)!.then(
      //   (value) {
      //     notifyListeners();
      //   },
      // );
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

  ///clear alll

  clearAllData() {
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
    getDataFromDB();
  }

  clearViewAllData() {
    viewAll.clear();

    viewAllBrandSelected = false;
    viewAllProductSelected = false;
    viewAllSegementSelected = false;

    // Get.back();
    // isselectedViewAllString.clear();
    onSelectedFilter();
    //notifyListeners();
  }

  Future<List<ItemMasterModelDB>> brandViewAllData() async {
    List<ItemMasterModelDB> newBrandList = [];
    if (isselectedViewAllString.isNotEmpty) {
      // brandList.clear();
      // isselectedBrandString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          //log("selected: ${viewAll[i].brand!}");
          // log("selected isselected: " + viewAll[i].isselected.toString());
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
      // productList.clear();
      // isselectedProductString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newProductList.add(ItemMasterModelDB(
              isselected: viewAll[i].isselected,
              autoId: viewAll[i].autoId,
              maximumQty: viewAll[i].maximumQty,
              minimumQty: viewAll[i].minimumQty,
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
      // segmentList.clear();
      // isselectedSegmentString.clear();
      for (int i = 0; i < viewAll.length; i++) {
        if (viewAll[i].isselected == 1) {
          isBPSSelected = true;
          newSegmentList.add(ItemMasterModelDB(
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

//filter
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
      //  log("dataprice: : "+value.map((e) => e.price.toString()).toList().toString());
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
            updateduserid: ""
            // itemCode: null,
            // brand: "null",
            // division: "null",
            // category: "null",
            // itemName: "null",
            // segment: segmentdata[i],
            // isselected: isgot == i ? 1 : 0,
            // favorite: "null", // viewAll[i].favorite,
            // mgrPrice: 0.00, //  viewAll[i].mgrPrice,
            // slpPrice: 0.00, // viewAll[i].slpPrice,
            // storeStock: 0.00, // viewAll[i].storeStock,
            // whsStock: 0.00, //  viewAll[i].whsStock
            ));
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
    // log("ssssslength: " + branddata.length.toString());
    for (int i = 0; i < branddata.length; i++) {
      int isgot = 0;
      if (selectstringbarndsw.isNotEmpty) {
        for (int j = 0; j < selectstringbarndsw.length; j++) {
          // log("sssss: "+branddata[i].toString() );
          // print("selelctedss: "+selectstringbarndsw.toString());
          //  print("selelctedss length: "+selectstringbarndsw.length.toString());
          if (branddata[i] == selectstringbarndsw[j]) {
            //  log("branddata: "+branddata[i].toString() );
            //  log("selectstringbarndsw: "+selectstringbarndsw[j].toString() );
            isgot = i;
            // log("iiii: "+[i].toString() );
            //  log("isgot: "+isgot.toString() );
            break;
          }
          //  print("isgiot?: $isgot");
        }

        newData.add(ItemMasterModelDB(
            uPackSize: 0.toString(),
            uPackSizeuom: '',
            uTINSPERBOX: 0,
            uSpecificGravity: '',
            isselected: isgot == i ? 1 : 0,
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
            updateduserid: ""

            // itemCode: null,
            // brand: branddata[i],
            // division: "null",
            // category: "null",
            // itemName: "null",
            // segment: "null",
            // isselected: isgot == i ? 1 : 0,
            // favorite: "null",
            // mgrPrice: 0.0, // viewAll[i].mgrPrice,
            // slpPrice: 0.0, // viewAll[i].slpPrice,
            // storeStock: 0.0, //viewAll[i].storeStock,
            // whsStock: 0.0, //  viewAll[i].whsStock
            ));
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
            updateduserid: ""

            // itemCode: null,
            // brand: branddata[i],
            // division: "null",
            // category: "null",
            // itemName: "null",
            // segment: "null",
            // isselected: 0,
            // favorite: "null",
            // mgrPrice: 0.0, // viewAll[i].mgrPrice,
            // slpPrice: 0.0, // viewAll[i].slpPrice,
            // storeStock: 0.0, //viewAll[i].storeStock,
            // whsStock: 0.0, //  viewAll[i].whsStock
            ));
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
          // log("productdata: "+productdata[i].toString() );
          //  log("selectstringproductsw: "+selectstringproductsw[j].toString() );
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

  ///call price list update api
  String errorMsg = 'Some thing went wrong';
  bool exception = false;
  bool get getException => exception;
  String get getErrorMsg => errorMsg;

  // callItemMasterPriceUpdate(
  //     String itemcode, int tmid, int indexfromList) async {
  //   isLoadingListView = true;
  //   listPriceAvail[indexfromList].isselected = 1;
  //   notifyListeners();
  //   await ItemMasterPriceUpdateApi.getData(itemcode).then((value) {
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       exception = false;
  //       isLoadingListView = false;

  //       if (value.itemPrices != null) {
  //         if (value.itemPrices!.isNotEmpty) {
  //           for (int i = 0; i < value.itemPrices!.length; i++) {
  //             if (value.itemPrices![i].PriceList == 1
  //                 // ||value.itemValueValue![0].itemPrices![i].PriceList == 2
  //                 ) {
  //               listPriceAvail[indexfromList].slpPrice =
  //                   value.itemPrices![i].price!;
  //               //   "1200.00";
  //               // print("list values: "+listPriceAvail[indexfromList].price!+ indexfromList.toString());
  //               value.itemPrices![i].price!.toStringAsFixed(2);
  //               listPriceAvail[indexfromList].isselected = 0;
  //               notifyListeners();
  //             }
  //           }
  //         }
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       exception = true;
  //       isLoadingListView = false;
  //       errorMsg = '${value.error!.message!.value}';
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       exception = true;
  //       isLoadingListView = false;
  //       errorMsg = '${value.exception}';
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  // callItemMasterPriceUpdateNew(
  //     String itemcode, int Itmid, int indexfromList) async {
  //   isLoadingListView = true;
  //   listPriceAvail[indexfromList].isselected = 1;
  //   notifyListeners();
  //   await ItemMasterApiUpdateNew.getData('${ConstantValues.slpcode}', itemcode)
  //       .then((value) async {
  //     final Database db = (await DBHelper.getInstance())!;

  //     print("sapuserid: " + ConstantValues.slpcode.toString());
  //     if (value.stcode! >= 200 && value.stcode! <= 210) {
  //       exception = false;
  //       isLoadingListView = false;

  //       if (value.itemdata != null) {
  //         listPriceAvail[indexfromList].slpPrice = value.itemdata![0].SlpPrice;
  //         listPriceAvail[indexfromList].mgrPrice = value.itemdata![0].MgrPrice;
  //         listPriceAvail[indexfromList].storeStock =
  //             value.itemdata![0].StoreStock;
  //         listPriceAvail[indexfromList].whsStock = value.itemdata![0].WhsStock;
  //         listPriceAvail[indexfromList].refreshedRecordDate =
  //             config.currentDate();

  //         ItemMasterModelDB itemMas = new ItemMasterModelDB(
  //             itemCode: 'itemCode',
  //             brand: 'brand',
  //             division: 'division',
  //             category: 'category',
  //             itemName: 'itemName',
  //             segment: 'segment',
  //             isselected: 0,
  //             favorite: 'favorite',
  //             mgrPrice: listPriceAvail[indexfromList].mgrPrice,
  //             slpPrice: listPriceAvail[indexfromList].slpPrice,
  //             storeStock: listPriceAvail[indexfromList].storeStock,
  //             whsStock: listPriceAvail[indexfromList].whsStock,
  //             refreshedRecordDate:
  //                 listPriceAvail[indexfromList].refreshedRecordDate);

  //         await DBOperation.updateItemMaster(Itmid.toString(), itemMas, db)
  //             .then((value) {
  //           listPriceAvail[indexfromList].isselected = 0;
  //           notifyListeners();
  //         });
  //       } else if (value.itemdata == null) {
  //         exception = true;
  //         isLoadingListView = false;
  //         errorMsg = 'No data found..!!';
  //         listPriceAvail[indexfromList].isselected = 0;
  //         notifyListeners();
  //       }
  //     } else if (value.stcode! >= 400 && value.stcode! <= 410) {
  //       exception = true;
  //       isLoadingListView = false;
  //       errorMsg = '${value.exception}';
  //       listPriceAvail[indexfromList].isselected = 0;
  //       notifyListeners();
  //     } else if (value.stcode == 500) {
  //       exception = true;
  //       isLoadingListView = false;
  //       errorMsg = '${value.exception}';
  //       listPriceAvail[indexfromList].isselected = 0;
  //       notifyListeners();
  //     }
  //   });
  //   notifyListeners();
  // }

  /// view all

  ///get files
  ///
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
}
