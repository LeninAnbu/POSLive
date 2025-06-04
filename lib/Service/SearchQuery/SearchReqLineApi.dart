import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/openStkQueryModel/StockReqLineModel.dart';

class SearchRequestLineAPi {
  static Future<OpenStockLineModl> getGlobalData(
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
                "query": "EXEC BZ_POS_SearchRequestLineAPi  '$docEntry'"
              }));

      log("search req line Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select T0.DocEntry ,T1.LineNum, T1.ItemCode , T1.Dscription , T1.Quantity , T1.Quantity - T1.OpenQty TransferedQty,T1.OpenQty,T1.Price,T2.ONHAND STOCK From OWTQ T0 Inner Join WTQ1 T1 on T0.DocEntry = T1.DocEntry INNER JOIN OITW T2 ON T2.ITEMCODE = T1.ITEMCODE AND T2.WHSCODE = T1.FROMWHSCOD inner join oitm t3 on t3.itemcode=T1.ITEMCODE Where  T0.DocEntry = $docEntry"
          })}");

      log("OpenReqline Res: ${json.decode(response.body)}");
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        return OpenStockLineModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return OpenStockLineModl.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('message::$e');

      return OpenStockLineModl.error(e.toString(), 500);
    }
  }
}
