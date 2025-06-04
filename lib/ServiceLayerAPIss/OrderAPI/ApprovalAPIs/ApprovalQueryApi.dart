import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/DynamicAproval.dart';
import '../../../url/url.dart';

class GetDyApprovalAPi {
  static String? slpCode;
  static String? dbname;

  static Future<ApprovaldyModel> getGlobalData(
      String fromDate, String toDate) async {
    try {
      final response = await http.post(Uri.parse(URL.dynamicUrl),
          headers: {
            'content-type': 'application/json',
          },
          body: json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database='$dbname';User Id=sa; Password=Insignia@2021#;",
            "query":
                "EXEC BZ_POS_GetDyApprovalAPi '$slpCode' ,'$fromDate' ,'$toDate'"
          }));

      log("Approvals statusCode::${response.statusCode}");
      return ApprovaldyModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      return ApprovaldyModel.fromJson(e.toString(), 500);
    }
  }
}
