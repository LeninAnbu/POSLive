import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../url/url.dart';

class PostDepositAPi {
  static String? depType;

  static String? depDate;
  static String? bankAccNum;
  static String? depAccount;

  static String? allocationAcc;
  static String? remarks;
  static double? totAmount;

  static method(String? deviceTransID) {
    final data = json.encode({
      "DepositType": "$depType",
      "DepositDate": depDate,
      "DepositCurrency": "TZS",
      "DepositAccount": "$depAccount",
      "AllocationAccount": "$allocationAcc",
      "BankAccountNum": "$bankAccNum",
      "JournalRemarks": "$remarks",
      "TotalLC": totAmount,
    });
    log('PostApprovalExpenseAPi::$data');
  }

  static Future<ApprovalstoDocModal> getGlobalData() async {
    try {
      log("Step11");
      log("${URL.sapUrl}/Deposits");
      final response = await http.post(Uri.parse("${URL.sapUrl}/Deposits"),
          headers: {
            "content-type": "application/json",
            "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
            "Prefer": "return-no-content"
          },
          body: json.encode({
            "DepositType": "$depType",
            "DepositDate": depDate,
            "DepositCurrency": "TZS",
            "DepositAccount": "$depAccount",
            "AllocationAccount": "$allocationAcc",
            "BankAccountNum": "$bankAccNum",
            "JournalRemarks": "$remarks",
            "TotalLC": totAmount,
          }));

      log(json.encode({
        "DepositType": "$depType",
        "DepositDate": depDate,
        "DepositCurrency": "TZS",
        "DepositAccount": "$depAccount",
        "AllocationAccount": "$allocationAcc",
        "BankAccountNum": "$bankAccNum",
        "JournalRemarks": "$remarks",
        "TotalLC": totAmount,
      }));
      log('PostDepositAPi sts::${response.statusCode}');

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalstoDocModal.fromJson(response.statusCode);
      } else {
        log("Approva Request sts stcode22 ::${response.body}");

        return ApprovalstoDocModal.fromJson2(
          response.statusCode,
          json.decode(response.body),
        );
      }
    } catch (e) {
      log('Exception PostRequestAPi: $e');

      return ApprovalstoDocModal.issue('$e', 500);
    }
  }
}
