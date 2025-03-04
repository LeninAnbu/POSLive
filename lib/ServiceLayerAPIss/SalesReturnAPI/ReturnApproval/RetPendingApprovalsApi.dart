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
                // "Select distinct T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime], T0.[DraftEntry],T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocDate] , T3.[CardCode], T3.[CardName], T3.DocTotal  From [OWDD] T0 Inner Join [WST1] T1 on T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on T3.[DocEntry] = T0.[DraftEntry] Where  T0.[Status] = 'W' And T3.ObjType = 14  And Lower(T2.[USER_CODE]) = Lower('${AppConstant.sapUserName}') and  t3.DocDate Between '$frmDate' and '$toDate' Order by T0.[CreateDate] Desc,T0.[CreateTime] Desc"
              }));

      // log("ApprovalListpending:${json.encode({
      //       "constr":
      //           "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
      //       "query":
      //           "Select distinct T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime], T0.[DraftEntry],T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocDate] , T3.[CardCode], T3.[CardName], T3.DocTotal  From [OWDD] T0 Inner Join [WST1] T1 on T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on T3.[DocEntry] = T0.[DraftEntry] Where  T0.[Status] = 'W' And T3.ObjType = 14  And Lower(T2.[USER_CODE]) = Lower('${AppConstant.sapUserName}') and  t3.DocDate Between '$frmDate' and '$toDate' Order by T0.[CreateDate] Desc,T0.[CreateTime] Desc"
      //     })}");
      log("Ret Pending sts::" + response.statusCode.toString());
      log("Ret Pending res::" + response.body.toString());

      if (response.statusCode == 200) {
        return ApprovalsModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
        // throw Exception('Restart the app or contact the admin!!..');
        return ApprovalsModal.issue(
            'Restart the app or contact the admin!!..', response.statusCode);
      }
    } catch (e) {
      //throw Exception('$e');
      return ApprovalsModal.issue(
          'Restart the app or contact the admin!!..', 500);
    }
  }

  static Future<ApprovalsModal> callNextLink() async {
    try {
      final response = await http.get(
        Uri.parse(
          //http://102.69.164.12:50001/b1s/v1/DeliveryNotes(10)
          URL.url + '/' + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          // 'Prefer': 'odata.maxpagesize=${GetValues.maximumfetchValue}',
        },
      );
      if (response.statusCode == 200) {
        //  print(json.decode(response.body));
        return ApprovalsModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        throw Exception('Restart the app or contact the admin!!..');
        //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('$e');
      //  return SalesOrderModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
