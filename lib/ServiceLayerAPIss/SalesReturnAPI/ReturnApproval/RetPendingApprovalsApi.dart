// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, file_names

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Constant/UserValues.dart';
import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/approvals_modal.dart';
import '../../../url/url.dart';

class ReturnPendingApprovalsAPi {
  static String? sessionID;
  static String? cardCode;
  static String? nextUrl;
  static String url =
      "SQLQueries('ApprovalList')/List?UserID=${UserValues.userID}";
  static Future<ApprovalsModal> getGlobalData(
      String frmDate, String toDate) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                    "EXEC BZ_POS_ReturnPendingApprovalsAPi  '${AppConstant.sapUserName}','$frmDate','$toDate'"
              }));

      log("Ret Pending sts::" + response.statusCode.toString());
      log("Ret Pending res::" + response.body.toString());

      if (response.statusCode == 200) {
        return ApprovalsModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return ApprovalsModal.issue(
            'Restart the app or contact the admin!!..', response.statusCode);
      }
    } catch (e) {
      return ApprovalsModal.issue(
          'Restart the app or contact the admin!!..', 500);
    }
  }

  static Future<ApprovalsModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          URL.url + '/' + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
        },
      );
      if (response.statusCode == 200) {
        return ApprovalsModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
