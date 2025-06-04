import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/PendingInwardModel/OpenPendingModel.dart';

class searchOutWardLineAPi {
  static Future<OpenStockOutLineModl> getGlobalData(
    String docEntry,
  ) async {
    try {
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "EXEC BZ_POS_searchOutWardLineAPi  '$docEntry' "
              }));

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenStockOutLineModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OpenStockOutLineModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');

      return OpenStockOutLineModl.error(e.toString(), 500);
    }
  }
}

// select A.DocEntry,A.DocNum,A.DocDate,A.ToWhsCode,A.Filler 'From whs',A.Comments,B.ItemCode,B.Dscription,B.FromWhsCod,B.WhsCode 'Towhs',B.Quantity,B.Price,C.BatchNum,C.Quantity 'Batch Qty',C.LineNum [BT_Line],D.Quantity [REQUEST QTY] from OWTR A (Nolock)  Inner Join WTR1 B ( Nolock )  On A.docentry=B.docentry   Left Outer Join IBT1 C (nolock)  On C.BaseEntry=A.DocEntry and C.BaseType=A.ObjType and C.ItemCode=B.ItemCode and C.WhsCode=B.FromWhsCod Left Join WTQ1  D (Nolock)  On  D.docentry=B.BaseEntry AND D.LineNum=B.BaseLine AND D.ItemCode=B.ItemCode where A.DocEntry='631506'  order by B.LineNum