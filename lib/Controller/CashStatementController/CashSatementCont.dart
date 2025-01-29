import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Models/ReportsModel/CashReportMdl.dart';

import '../../Service/ReportsApi/CashStatementApi.dart';
import 'package:intl/intl.dart';

class CashStateCon extends ChangeNotifier {
  // CashStateCon(){
  //  init();
  // }

  init() async {
    clearalldata();
    // await getStockReg();
    // callCashReportApi();
  }

  List<CashStateData> salesReg = [];
  List<CashStateData> filtersalesReg = [];
  List<CashStateData> get getfiltersalesReg => filtersalesReg;
  clearalldata() {
    salesReg.clear();
    filtersalesReg = [];
    fromDate = '';
    toDate = '';
    isLoading = false;
    expMsg = '';

    notifyListeners();
    searchcontroller = List.generate(150, (i) => TextEditingController());
  }

  // Future<void> getStockReg() async {
  //   final Database db = (await DBHelper.getInstance())!;
  //   List<Map<String, Object?>> data = await DBOperation.getCashstatement(db);

  //   for (int i = 0; i < data.length; i++) {
  //     salesReg.add(CashStateData(
  //         branch: data[i]['branch'].toString(),
  //         cardcode: data[i]['customercode'].toString(),
  //         cardname: data[i]['customername'].toString(),
  //         date: data[i]['transtime'].toString(),
  //         expense: data[i]['Expense'].toString(),
  //         docno: data[i]['documentno'].toString(),
  //         doctype: data[i]['doctype'].toString(),
  //         amount: data[i]['rcamount'].toString(),
  //         terminal: data[i]['terminal'].toString()));
  //   }
  //   filtersalesReg = salesReg;
  //   notifyListeners();
  // }
  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());

  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());

  String? fromDate;
  String? toDate;
  searchBtn() {
    if (formkey[0].currentState!.validate()) {
      callCashReportApi();
    }
    notifyListeners();
  }

  bool isLoading = false;
  String expMsg = '';

  callCashReportApi() {
    salesReg = [];
    filtersalesReg = [];
    isLoading = true;
    expMsg = '';
    Cashreportapi.getGlobalData(fromDate!, toDate!).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        salesReg = value.customerdata!;
        log('salesRegsalesReglenght::${salesReg.length}');
        filtersalesReg = salesReg;
        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        expMsg = '${value.exception}';
      } else {
        expMsg = '${value.exception}';
      }
    });
    notifyListeners();
  }

  getDate2(
    BuildContext context,
    datetype,
  ) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    String datetype2;
    if (datetype == "From") {
      log('message::$pickedDate');
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);

      searchcontroller[2].text = datetype!;
      fromDate = datetype2;
      log('datetype11::$fromDate');
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);
      toDate = datetype2;
      searchcontroller[3].text = datetype!;
      log('To datetype::$fromDate');

      //log(datetype);
    } else {
      //log("Date is not selected");
    }
    notifyListeners();
  }

  filterListSearched(String v) {
    //y
    if (v.isNotEmpty) {
      filtersalesReg = salesReg
          .where((e) =>
              e.doctype!.toLowerCase().contains(v.toLowerCase()) ||
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
