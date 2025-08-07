import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Models/QueryUrlModel/IncomingReportModel.dart';
import 'package:posproject/Service/QueryURL/IncomingApis/IncomigReportapi.dart';
import 'package:intl/intl.dart';

class IncomingReportCtrl extends ChangeNotifier {
  init() async {
    incomingReportData = [];
    filterReportData = [];
    searchcontroller = List.generate(150, (i) => TextEditingController());
    await getCurrentDate();
    await callIncomingReportApi();
    notifyListeners();
  }

  List<GlobalKey<FormState>> formkey =
      List.generate(100, (i) => GlobalKey<FormState>());
  List<TextEditingController> searchcontroller =
      List.generate(150, (i) => TextEditingController());

  Configure config = Configure();
  String? fromDate;
  String? toDate;
  getCurrentDate() {
    searchcontroller[2].text = config.alignDateT(config.currentDate2());
    searchcontroller[3].text = config.alignDateT(config.currentDate2());

    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);

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

  List<IncomingReportsData> incomingReportData = [];
  List<IncomingReportsData> filterReportData = [];
  bool isloading = false;
  callIncomingReportApi() async {
    incomingReportData = [];
    filterReportData = [];
    isloading = true;
    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);
    await IncomingPaymentReportApi.getGlobalData('ubongo', fromDate!, toDate!)
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
          incomingReportData = value.activitiesData!;
          filterReportData = incomingReportData;
          notifyListeners();
        }
        isloading = false;
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {
        isloading = false;
      }
    });
    notifyListeners();
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      filterReportData = incomingReportData
          .where((e) =>
              e.cusotmerName.toLowerCase().contains(v.toLowerCase()) ||
              e.customerCode.toLowerCase().contains(v.toLowerCase()) ||
              e.paymentDate.toLowerCase().contains(v.toLowerCase()) ||
              e.remarks.toLowerCase().contains(v.toLowerCase()) ||
              e.journalMemo!.toLowerCase().contains(v.toLowerCase()) ||
              e.paymentMode.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterReportData = incomingReportData;
      notifyListeners();
    }
  }
}
