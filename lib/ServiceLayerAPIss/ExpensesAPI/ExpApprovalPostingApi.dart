import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapExpensModel/ExpePostingList.dart';

import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../url/url.dart';

class PostApprovalExpenseAPi {
  static String? docType;

  static String? cashAccount;
  static String? seriesType;
  static String? reference;

  static String? payTo;
  static String? remarks;
  static String? docDate;
  static String? cashSum;

  static String? uRvc;

  static List<ExpenseListMoel>? paymentAccounts;

  static method(String? deviceTransID) {
    final data = json.encode({
      "DocDate": "$docDate",
      "DocType": "$docType",
      "CashAccount": "$cashAccount",
      "Remarks": "$remarks",
      "JournalRemarks": "$remarks",
      "Address": "$payTo",
      'U_DeviceTransID': deviceTransID,
      "CounterReference": "$reference",
      "CashSum": "$cashSum",
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "U_RVC": '$uRvc',
      "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
    });
    log('PostApprovalExpenseAPi::$data');
  }

  static Future<SalesQuotStatus> getGlobalData(String? deviceTransID) async {
    try {
      log("Step11");
      log("${URL.sapUrl}VendorPayments");
      final response = await http.post(Uri.parse("${URL.sapUrl}VendorPayments"),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
            "Prefer": "return-no-content"
          },
          body: json.encode({
            "DocDate": "$docDate",
            "DocType": "$docType",
            "CashAccount": "$cashAccount",
            "Remarks": "$remarks",
            "JournalRemarks": "$remarks",
            "Address": "$payTo",
            'U_DeviceTransID': deviceTransID,
            "CashSum": "$cashSum",
            "U_PosUserCode": UserValues.userCode,
            "U_PosTerminal": AppConstant.terminal,
            "CounterReference": "$reference",
            "U_RVC": '$uRvc',
            "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
          }));

      log(json.encode({
        "DocDate": "$docDate",
        "DocType": "$docType",
        "CashAccount": "$cashAccount",
        "JournalRemarks": "$remarks",
        "Address": "$payTo",
        "Remarks": "$remarks",
        "CashSum": "$cashSum",
        "CounterReference": "$reference",
        "U_RVC": '$uRvc',
        "U_PosUserCode": UserValues.userCode,
        "U_PosTerminal": AppConstant.terminal,
        "PaymentAccounts": paymentAccounts!.map((e) => e.tojson()).toList(),
      }));

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SalesQuotStatus.fromJson(response.statusCode);
      } else {
        log("Approva Request sts stcode22 ::${response.statusCode}");

        return SalesQuotStatus.fromJson(response.statusCode);
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');

      return SalesQuotStatus.issue(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
