import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

import '../../DB Helper/DBOperation.dart';
import '../../DB Helper/DBhelper.dart';
import '../../Models/ReportsModel/StockCheckMdl.dart';
import '../../Service/ReportsApi/StockCheckApi.dart';

class StockCheckController extends ChangeNotifier {
  // StockCheckController() {
  //   getStockSnap();
  // }

  void init() {
    // getStockSnap();
    callStockCheckApi();
  }

  clearDataAll() {
    stockSnapList.clear();
    filterStockSnapList.clear();
    listbool = false;
    expMsg = '';
    notifyListeners();
  }

  List<StockCheckList> stockSnapList = [];
  List<StockCheckList> filterStockSnapList = [];
  bool listbool = false;
  getStockSnap() async {
    listbool = true;
    stockSnapList.clear();
    final Database db = (await DBHelper.getInstance())!;

    List<Map<String, Object?>> getStocksnapData =
        await DBOperation.getStockSnapFullData(db);
    if (getStocksnapData.isNotEmpty) {
      //log(  "branch::"+ getStocksnapData[0]["branch"].toString());
      for (int i = 0; i < getStocksnapData.length; i++) {
        stockSnapList.add(StockCheckList(
            branch: getStocksnapData[i]["branch"].toString(),
            itemCode: getStocksnapData[i]["itemcode"].toString(),
            itemname: getStocksnapData[i]["itemname"].toString(),
            qty: double.parse(getStocksnapData[i]["quantity"].toString()),
            serialbatch: getStocksnapData[i]["serialbatch"].toString(),
            price: getStocksnapData[i]["sellprice"] == null ||
                    getStocksnapData[i]["sellprice"] == 'null'
                ? 0
                : double.parse(getStocksnapData[i]["sellprice"]
                    .toString()
                    .replaceAll(',', ''))));
      }
      filterStockSnapList = stockSnapList;

      notifyListeners();
    } else {
      listbool = false;
      notifyListeners();
    }
    notifyListeners();
  }

  String expMsg = '';

  callStockCheckApi() async {
    log('step1');
    listbool = true;
    stockSnapList = [];
    expMsg = '';
    filterStockSnapList = [];
    await StockcheckAPi.getGlobalData().then((value) async {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        log('customerdata lenght::${value.customerdata!.length}');
        stockSnapList = value.customerdata!;
        filterStockSnapList = stockSnapList;
        listbool = false;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        listbool = false;
        expMsg = value.exception!;
        notifyListeners();
      } else {
        listbool = false;
        expMsg = value.exception!;
        notifyListeners();
      }
    });
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    listbool = false;
    if (v.isNotEmpty) {
      filterStockSnapList = stockSnapList
          .where((e) =>
              e.itemname!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemCode!.toLowerCase().contains(v.toLowerCase()) ||
              e.serialbatch!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterStockSnapList = stockSnapList;
      notifyListeners();
    }
  }
}
