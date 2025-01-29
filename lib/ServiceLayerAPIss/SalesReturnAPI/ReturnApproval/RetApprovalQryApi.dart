import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Models/ServiceLayerModel/SapSalesOrderModel/approvals_order_modal/DynamicAproval.dart';
import '../../../url/url.dart';

class ReturnApprovalAPi {
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
            "EXEC BZ_POS_ReturnApprovalAPi '$slpCode' ,'$fromDate' ,'$toDate' "
              //   '''Select DISTINCT T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime],T0.[DraftEntry],
              // T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocTotal], T3.[DocDate] ,T3.[CardCode], T3.[CardName] From [OWDD] T0 Inner Join [WST1] T1 on 
              // T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on 
              // T3.[DocEntry] = T0.[DraftEntry] Where T0.[Status] = 'Y' and T3.[DocStatus] <> 'C' And T0.[ObjType] = 14 and 
              // T3.[SlpCode] = $slpCode and t3.DocDate  between '$fromDate' and '$toDate' order by T3.[DocDate] desc, T0.[DraftEntry] desc''', //'${GetValues.slpCode}'
          }));

      log(json.encode({
        "constr":
            "Server=INSIGNIAC03313;Database='$dbname';User Id=sa; Password=Insignia@2021#;",
        "query":
            '''Select DISTINCT T0.[WddCode],T0.[WtmCode],T0.[ObjType],T0.[CurrStep],T0.[CreateDate], T0.[CreateTime],T0.[DraftEntry],
              T2.[USER_CODE] [FromUser], T3.[DocNum], T3.[DocTotal], T3.[DocDate] ,T3.[CardCode], T3.[CardName] From [OWDD] T0 Inner Join [WST1] T1 on 
              T0.[CurrStep] = T1.[WstCode] Inner Join [OUSR] T2 on T2.[USERID] = T0.[UserSign] Inner Join [ODRF] T3 on 
              T3.[DocEntry] = T0.[DraftEntry] Where T0.[Status] = 'Y' and T3.[DocStatus] <> 'C' And T0.[ObjType] = 14 and 
              T3.[SlpCode] = $slpCode and t3.DocDate  between '$fromDate' and '$toDate' order by T3.[DocDate] desc''', //'${GetValues.slpCode}'
      }));
      log("Return details Res: ${json.decode(response.body)}");
      log("Ret Approvals statusCode::${response.statusCode}");
      return ApprovaldyModel.fromJson(response.body, response.statusCode);

      // throw Exception("Error!!...");
    } catch (e) {
      //  throw Exception("Exception: $e");
      return ApprovaldyModel.fromJson(e.toString(), 500);
    }
  }
}
