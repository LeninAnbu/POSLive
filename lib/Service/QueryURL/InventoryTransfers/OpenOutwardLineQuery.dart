import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../../Constant/AppConstant.dart';
import '../../../Models/QueryUrlModel/openStkQueryModel/StockReqLineModel.dart';

class OpenOutwardLineAPi {
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
                "query": "EXEC BZ_POS_OpenOutwardLineAPi '$docEntry'"
              }));

      log("open req line Data ${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query":
                "Select T0.DocEntry ,T1.LineNum, T1.ItemCode , T1.Dscription , T1.Quantity , T1.Quantity - T1.OpenQty TransferedQty,T1.Price, t3.U_Pack_Size  From OWTQ T0 Inner Join WTQ1 T1 on T0.DocEntry = T1.DocEntry Where T0.DocStatus = 'O' And T1.LineStatus = 'O' And U_ReqWhs is Not Null And T0.DocEntry = $docEntry"
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
