import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../Constant/AppConstant.dart';
import '../../../Models/Service Model/RecoModel/RecoListModel.dart';

class RecoListApi {
  static Future<RecoModel> getGlobalData(String cardCode) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_RecoListApi '$cardCode' "
              }));

      log('message::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select T0.TransType SrcObjTyp,T0.TransId, T1.Line_ID TransRowId, T0.CreatedBy SrcObjAbs,T0.Memo, T0.Ref1, T2.CardCode , T2.CardName, T0.RefDate ,T0.Ref2, Debit-Credit Amount, T1.BalDueDeb - T1. BalDueCred Balance, T1.BalDueDeb - T1. BalDueCred ReconcileAmount, Case When T1.BalDueDeb > 0 Then 'codDebit' Else 'codCredit' End CreditOrDebitT From OJDT T0 Inner Join JDT1 T1  on T0.TransID = T1.TransId  Inner Join OCRD T2 on T2.CardCode = T1.ShortName Where T1.BalDueCred + T1.BalDueDeb  > 0 And CardCode = '$cardCode'"
          })}');

//D1999
      print(response.statusCode);
      if (response.statusCode == 200) {
        return RecoModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return RecoModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('RecoModel:::$e');

      return RecoModel.exception(e.toString(), 500);
    }
  }
}
