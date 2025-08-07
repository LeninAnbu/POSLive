import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:posproject/Constant/Configuration.dart';
import '../../Models/ReportsModel/SaelsRegisterModel.dart';
import '../../Service/ReportsApi/SalesRegisterApi.dart';

class StRegCon extends ChangeNotifier {
  init() async {
    clearalldata();
    await getCurrentDate();
    await callSalesRegApi();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());
  List<StockRegisterList> salesReg = [];
  List<StockRegisterList> filtersalesReg = [];
  List<StockRegisterList> get getfiltersalesReg => filtersalesReg;

  clearalldata() {
    salesReg = [];
    filtersalesReg = [];
    searchcontroller = List.generate(150, (i) => TextEditingController());
    notifyListeners();
  }

  getDate2(BuildContext context, datetype) async {
    String datetype2 = '';

    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (datetype == "From") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);
      fromDate = datetype2;

      searchcontroller[2].text = datetype!;
    } else if (datetype == "To") {
      datetype = DateFormat('dd-MM-yyyy').format(pickedDate!);
      datetype2 = DateFormat('yyyy-MM-dd').format(pickedDate);
      toDate = datetype2;

      searchcontroller[3].text = datetype!;
    } else {}
  }

  calSsearchBtn() {
    callSalesRegApi();
    notifyListeners();
  }

  Configure config = Configure();
  String? fromDate;
  String? toDate;

  getCurrentDate() {
    searchcontroller[2].text = config.alignDateT(config.currentDate2());
    searchcontroller[3].text = config.alignDateT(config.currentDate2());
    notifyListeners();
  }

  callSalesRegApi() async {
    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);

    await Salesregisterapi.getGlobalData(fromDate!, toDate!).then((value) {
      if (value.stcode! >= 200 && value.stcode! <= 210) {
        if (value.salesRegData.isNotEmpty) {
          salesReg = value.salesRegData;
          filtersalesReg = salesReg;
        }

        notifyListeners();
      } else if (value.stcode! >= 400 && value.stcode! <= 410) {}
    });
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
              e.docno!.toString().toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filtersalesReg = salesReg;
      notifyListeners();
    }
  }
}
