import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../Constant/UserValues.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';
import '../../Models/ServiceLayerModel/SapSalesReturnModel/ReturnPostingListModel.dart';
import '../../url/url.dart';

class SalesReurnPostAPi {
  static String? cardCodePost;
  static List<ReturnPostingtLine>? docLineQout;
  static String? docDate;
  static String? dueDate;
  static String? seriesType;

  static String? remarks;

  static String? cnType;
  static void method(String? deviceTransID) {
    final data = json.encode({
      "CardCode": "$cardCodePost",
      "DocumentStatus": "bost_Open",
      "DocDate": "$docDate",
      "DocDueDate": "$dueDate",
      "Comments": "$remarks",
      "U_CN_Type": 5,
      "U_DeviceTransID": deviceTransID,
      "U_PosUserCode": UserValues.userCode,
      "U_PosTerminal": AppConstant.terminal,
      "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
    });
    log("post return data : $data");
  }

  static Future<SalesQuotStatus> getGlobalData(String? deviceTransID) async {
    try {
      log("${URL.sapUrl}/CreditNotes");
      final response = await http.post(
        Uri.parse(
          "${URL.sapUrl}/CreditNotes",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
          "Prefer": "return-no-content"
        },
        body: json.encode({
          "CardCode": "$cardCodePost",
          "DocumentStatus": "bost_Open",
          "DocDate": "$docDate",
          "DocDueDate": "$dueDate",
          "Comments": "$remarks",
          "U_CN_Type": 5,
          "U_DeviceTransID": deviceTransID,
          "U_PosUserCode": UserValues.userCode,
          "U_PosTerminal": AppConstant.terminal,
          "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
        }),
      );

      log(
        "datatatat: ${json.encode({
              "CardCode": "$cardCodePost",
              "DocumentStatus": "bost_Open",
              "DocDate": "$docDate",
              "DocDueDate": "$dueDate",
              "Comments": "$remarks",
              "U_CN_Type": 5,
              "U_DeviceTransID": deviceTransID,
              "U_PosUserCode": UserValues.userCode,
              "U_PosTerminal": AppConstant.terminal,
              "DocumentLines": docLineQout!.map((e) => e.toJson3()).toList(),
            })}",
      );
      log("Responce: ${response.statusCode}");
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return SalesQuotStatus.fromJson(response.statusCode);
      } else {
        return SalesQuotStatus.fromJson(response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return SalesQuotStatus.issue(
        'Restart the app or contact the admin!!..\n',
        500,
      );
    }
  }
}
