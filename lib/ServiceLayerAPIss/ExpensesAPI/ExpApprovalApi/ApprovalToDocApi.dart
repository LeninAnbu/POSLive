import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvalOTODPostApi.dart';
import '../../../url/url.dart';

class ApprovalsExpPostAPi {
  static String? docEntry;

  static Future<ApprovalstoDocModal> getGlobalData() async {
    final data = json.encode({
      "Document": {
        "DocEntry": "$docEntry",
      }
    });

    log("Body Aproval request:" + data);
    try {
      log(
        "api:::" + URL.sapUrl + "/DraftsService_SaveDraftToDocument",
      );
      final response = await http.post(
        Uri.parse(
          "http://102.69.167.106:50001/b1s/v1/PaymentDrafts($docEntry)/SaveDraftToDocument", //&\$filter= DocumentStatus eq 'bost_Open'
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
      );
      log("statucCode: " + response.statusCode.toString());
      log("Approval to Doc Res: " + response.body);
      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return ApprovalstoDocModal.fromJson(
          response.statusCode,
        );
      } else {
        return ApprovalstoDocModal.fromJson2(
          response.statusCode,
          json.decode(response.body),
        );
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
