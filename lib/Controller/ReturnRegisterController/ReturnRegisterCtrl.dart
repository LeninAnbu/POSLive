import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/DB%20Helper/DBOperation.dart';
import 'package:sqflite/sqflite.dart';
import '../../DB Helper/DBhelper.dart';
import 'package:intl/intl.dart';

import '../../Models/ReportsModel/ReturnRegisterModel.dart';

import '../../Service/ReportsApi/RetrunRegisterApi.dart';

class RetnRegCon extends ChangeNotifier {
  init() async {
    clearalldata();
    await getCurrentDate();
    await callCashReportApi();
  }

  List<ReturnRegisterList> salesReg = [];
  List<ReturnRegisterList> filtersalesReg = [];
  List<ReturnRegisterList> get getfiltersalesReg => filtersalesReg;
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());

  clearalldata() {
    searchcontroller = List.generate(150, (i) => TextEditingController());
    salesReg.clear();
    filtersalesReg.clear();
    isloading = false;
    fromDate = '';
    toDate = '';
    notifyListeners();
  }

  Configure config = Configure();
  getCurrentDate() {
    searchcontroller[2].text = config.alignDateT(config.currentDate2());
    searchcontroller[3].text = config.alignDateT(config.currentDate2());

    notifyListeners();
  }

  callSearchBtn() {
    if (formkey[0].currentState!.validate()) {
      callCashReportApi();
    }
    notifyListeners();
  }

  bool isloading = false;
  String fromDate = '';
  String toDate = '';
  callCashReportApi() {
    salesReg = [];
    filtersalesReg = [];
    isloading = true;
    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);
    Retrunregisterapi.getGlobalData(fromDate, toDate).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.returnRegdata != null) {
          salesReg = value.returnRegdata!;
          log('salesRegsalesReglenght::${salesReg.length}');
          filtersalesReg = salesReg;
          isloading = false;
          notifyListeners();
        }
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        isloading = false;
      } else {
        isloading = false;
      }
    });
    notifyListeners();
  }

  getDate2(BuildContext context, datetype) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      searchcontroller[2].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      searchcontroller[3].text = datetype!;
    } else {}
  }

  Future<void> getStockReg() async {
    final Database db = (await DBHelper.getInstance())!;
    List<Map<String, Object?>> data = await DBOperation.getRetunrRegister(db);

    for (int i = 0; i < data.length; i++) {
      salesReg.add(ReturnRegisterList(
          branch: data[i]['branch'].toString(),
          cardcode: data[i]['customercode'].toString(),
          cardname: data[i]['customername'].toString(),
          date: data[i]['transtime'].toString(),
          docEntry: int.parse(data[i]['docentry'].toString()),
          docno: data[i]['documentno'].toString(),
          itemcode: data[i]['itemcode'].toString(),
          itemname: data[i]['itemname'].toString(),
          terminal: data[i]['terminal'].toString()));
    }
    filtersalesReg = salesReg;
    notifyListeners();
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      filtersalesReg = salesReg
          .where((e) =>
              e.itemcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.itemname!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardcode!.toLowerCase().contains(v.toLowerCase()) ||
              e.cardname!.toLowerCase().contains(v.toLowerCase()) ||
              e.docno!.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersalesReg = salesReg;
      notifyListeners();
    }
  }
}
