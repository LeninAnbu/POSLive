import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/ExpePostingList.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/SapExpensesModell.dart';
import '../../url/url.dart';

class PostExpenseAPi {
  static String? docType;

  static String? cashAccount;

  static String? payTo;
  static String? seriesType;
  static String? reference;
  static String? remarks;
  static String? docDate;
  static String? cashSum;
  static String? uVAT;

  static String? uRvc;
  static List<ExpenseListMoel>? paymentAccounts;

  static method(String? deviceTransID) {
    final data = json.encode({
      "DocDate": "$docDate",
      "DocType": "$docType",
      "CashAccount": "$cashAccount",
      "JournalRemarks": "$remarks",
      "Address": "$payTo",
      "Remarks": "$remarks",
      "CounterReference": "$reference",
      "Reference2": "$reference",
      "CashSum": "$cashSum",
      'U_DeviceTransID': deviceTransID,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "U_RVC": '$uRvc',
      "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList()
    });

    log('Exp datadatadata::$data');
  }

  static Future<SapExpenseModel> getGlobalData(String? deviceTransID) async {
// acc code-debit acc
// cash acc- credit

    try {
      log("Step11");
      final response = await http.post(Uri.parse("${URL.sapUrl}VendorPayments"),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          },
          body: json.encode({
            "DocDate": "$docDate",
            "DocType": "$docType",
            "CashAccount": "$cashAccount",
            "JournalRemarks": "$remarks",
            "Address": "$payTo",
            "Remarks": "$remarks",
            "CounterReference": "$reference",
            "Reference2": "$reference",
            "CashSum": "$cashSum",
            "U_RVC": '$uRvc',
            'U_DeviceTransID': deviceTransID,
            "U_PosUserCode": UserValues.userCode,
            "U_PosTerminal": AppConstant.terminal,
            "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
          }));
      log('Exp resp::${json.decode(response.body)}');
      log(json.encode({
        "DocDate": "$docDate",
        "DocType": "$docType",
        "CashAccount": "$cashAccount",
        "JournalRemarks": "$remarks",
        "Address": "$payTo",
        "Remarks": "$remarks",
        "CashSum": "$cashSum",
        "CounterReference": "$reference",
        "Reference2": "$reference",
        "U_RVC": '$uRvc',
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
      }));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SapExpenseModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("PostRequestAPi stcode22 ::${response.statusCode}");

        return SapExpenseModel.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');

      return SapExpenseModel.error(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
