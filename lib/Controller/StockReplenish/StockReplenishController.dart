import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/ReportsModel/StockReplenishModel.dart';
import '../../Service/ReportsApi/StockReplenishApi.dart';

class StockReplenishController extends ChangeNotifier {
  // StockReplenishController() {
  //   getOutOfStockItems();
  // }
  clearDataAll() {
    outOfstock = [];
    filteroutOfstockList = [];
    outOfstockBool = false;
    notifyListeners();
  }

  init() {
    clearDataAll();
    // getOutOfStockItems();
    callStockRepApi();
    notifyListeners();
  }

  List<StockRepModelData>? stockReplenishData = [];

  callStockRepApi() async {
    outOfstockBool = true;
    filteroutOfstockList = [];
    outOfstock = [];

    await StockcheckAPi.getGlobalData().then((value) async {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        log('stkreplenght::${value.stockRepData!.length}');
        stockReplenishData = value.stockRepData!;
        for (var i = 0; i < stockReplenishData!.length; i++) {
          if (stockReplenishData![i].qty.toString() != '0.0') {
            outOfstock.add(stockCheckList(
                itemname: stockReplenishData![i].itemName,
                itemCode: stockReplenishData![i].itemCode,
                qty: stockReplenishData![i].qty));
          }
        }
        outOfstockBool = false;

        filteroutOfstockList = outOfstock;

        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        outOfstockBool = false;

        notifyListeners();
      } else {
        outOfstockBool = false;
      }
    });
    notifyListeners();
  }

  List<stockCheckList> outOfstock = [];
  List<stockCheckList> filteroutOfstockList = [];
  bool outOfstockBool = false;
  filterListSearched(String v) {
    //y
    outOfstockBool = false;
    if (v.isNotEmpty) {
      filteroutOfstockList = outOfstock
          .where((e) => e.itemname!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filteroutOfstockList = outOfstock;
      notifyListeners();
    }
  }

  getOutOfStockItems() async {
    outOfstock.clear();
    outOfstockBool = true;
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getOutOfItemsData =
        await DBOperation.getoutofDataData(db);
    if (getOutOfItemsData.isNotEmpty) {
      for (int j = 0; j < getOutOfItemsData.length; j++) {
        if (getOutOfItemsData[j]["shortageQty"] != 0) {
          outOfstock.add(stockCheckList(
            // DocNo:getsyncedData[j]["documentno"]==null?0: int.parse(getsyncedData[j]["documentno"].toString()),
            itemname: getOutOfItemsData[j]["itemname_short"] == null
                ? ''
                : getOutOfItemsData[j]["itemname_short"].toString(),
            // Docdate: getsyncedData[j]["createdateTime"].toString(),
            qty: getOutOfItemsData[j]["shortageQty"] == null
                ? 0
                : double.parse(getOutOfItemsData[j]["shortageQty"].toString()),
          ));
        }
      }
      filteroutOfstockList = outOfstock;
    } else {
      getOutOfStockItems();
      outOfstockBool = false;
      notifyListeners();
    }
    notifyListeners();
  }
}

class stockCheckList {
  String? itemname;
  String? itemCode;
  String? serialbatch;
  String? branch;
  double? qty;
  stockCheckList({
    this.branch,
    this.itemCode,
    this.itemname,
    this.qty,
    this.serialbatch,
  });
}
