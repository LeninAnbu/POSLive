import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/DynamicAproval.dart';
import '../../../url/url.dart';

class ExpApprovalAPi {
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
                "EXEC BZ_POS_ExpApprovalAPi '${AppConstant.sapUserName}' ,'$fromDate' ,'$toDate'"
          }));

      log(json.encode({
        "constr":
            "Server=INSIGNIAC03313;Database='$dbname';User Id=sa; Password=Insignia@2021#;",
        "query":
            "Select Distinct T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime],T0.[DraftEntry],[USER_CODE] [FromUser], T3.[DocNum], T3.[DocTotal], T3.[DocDate] ,T3.[CardCode], T3.[CardName] ,T3.U_DeviceTransID From [OWDD] T0 Inner Join [WST1] T1 on  T0.[CurrStep] = T1.[WstCode]  Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [OPDF] T3 on T3.[DocEntry] = T0.[DraftEntry]  Where T0.[Status] = 'Y' And T0.DocEntry is Null And T0.[ObjType] = 46 and [USER_CODE] = '${AppConstant.sapUserName}' and t3.DocDate  between '$fromDate' and '$toDate' order by T3.[DocDate] desc,T3.[DocNum] desc"
      }));

      log("exp details Res: ${json.decode(response.body)}");
      log("exp Approvals statusCode::${response.statusCode}");
      return ApprovaldyModel.fromJson(response.body, response.statusCode);
    } catch (e) {
      return ApprovaldyModel.fromJson(e.toString(), 500);
    }
  }
}
