import 'package:flutter/material.dart';
import 'package:posproject/Constant/Configuration.dart';
import 'package:posproject/Models/QueryUrlModel/DepositsQueryModel/DepositReportModel.dart';
import 'package:posproject/Service/QueryURL/DepositsQuery/DepositsReportApi.dart';
import 'package:intl/intl.dart';

class DepositReportCtrlrs extends ChangeNotifier {
  init() async {
    depositsReportData = [];
    filterReportData = [];
    isloading = false;
    searchcontroller = List.generate(150, (i) => TextEditingController());
    await getCurrentDate();
    await callDepositsReportApi();
    notifyListeners();
  }

  bool isloading = false;
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

  List<DepositsReportsData> depositsReportData = [];
  List<DepositsReportsData> filterReportData = [];

  callDepositsReportApi() async {
    depositsReportData = [];
    filterReportData = [];
    fromDate = config.alignDate1(searchcontroller[2].text);
    toDate = config.alignDate1(searchcontroller[3].text);
    await DepositsReportAPi.getGlobalData('ubongo', fromDate!, toDate!)
        .then((value) {
      if (value.statusCode! >= 200 && value.statusCode! <= 210) {
        if (value.activitiesData != null) {
          depositsReportData = value.activitiesData!;
          filterReportData = depositsReportData;
          notifyListeners();
        }
        notifyListeners();
      } else if (value.statusCode! >= 400 && value.statusCode! <= 410) {}
    });
    notifyListeners();
  }

  filterListSearched(String v) {
    if (v.isNotEmpty) {
      filterReportData = depositsReportData
          .where((e) =>
              e.creditActName.toLowerCase().contains(v.toLowerCase()) ||
              e.debitActName.toLowerCase().contains(v.toLowerCase()) ||
              e.creditAmount
                  .toString()
                  .toLowerCase()
                  .contains(v.toLowerCase()) ||
              e.debitAmt.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.deposNum.toString().toLowerCase().contains(v.toLowerCase()) ||
              e.paymentMode.toLowerCase().contains(v.toLowerCase()))
          .toList();
      notifyListeners();
    } else if (v.isEmpty) {
      filterReportData = depositsReportData;
      notifyListeners();
    }
  }
}
