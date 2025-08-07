import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Models/ReportsModel/CashReportMdl.dart';

import '../../Service/ReportsApi/CashStatementApi.dart';
import 'package:intl/intl.dart';

class CashStateCon extends ChangeNotifier {
  init() async {
    clearalldata();
    await getCurrentDate();
    await callCashReportApi();
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

  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());

  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());

  String? fromDate;
  String? toDate;
  Configure config = Configure();
  getCurrentDate() {
    searchcontroller[2].text = config.alignDateT(config.currentDate2());
    searchcontroller[3].text = config.alignDateT(config.currentDate2());

    notifyListeners();
  }

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
    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);
    Cashreportapi.getGlobalData(fromDate!, toDate!).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.customerdata != null) {
          salesReg = value.customerdata!;
          log('salesRegsalesReglenght::${salesReg.length}');
          filtersalesReg = salesReg;
        }

        if (filtersalesReg.isEmpty) {
          expMsg = 'No Data found';
        }
        isLoading = false;

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {
        expMsg = '${value.exception}';
        isLoading = false;
      } else {
        expMsg = '${value.exception}';
        isLoading = false;
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
    } else {}
    notifyListeners();
  }

  filterListSearched(String v) {
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
