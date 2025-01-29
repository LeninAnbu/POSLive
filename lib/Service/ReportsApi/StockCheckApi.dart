import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/StockCheckMdl.dart';

class StockcheckAPi {
  static Future<StockCheckModel> getGlobalData() async {
    try {
      log('http://102.69.167.106:1705/api/SellerKit');
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query":
                "EXEC BZ_POS_StockcheckAPi"
                    // "SELECT distinct A.ItemCode,A.ItemName,ISNULL( C.DistNumber,D.BatchNum) [SERIAL/BATCH],Sum(b.Quantity) Over (Partition by ISNULL( C.DistNumber,D.BatchNum),A.LocCode Order by ISNULL( C.DistNumber,D.BatchNum)) [QUANTITY],A.LocCode [BRANCH] ,E.AvgPrice [PRICE]FROM OITL A INNER JOIN ITL1 B ON A.LogEntry = B.LogEntry  lEFT  JOIN  OSRN C ON B.ItemCode = C.ItemCode AND B.SysNumber = C.SysNumber Left Outer Join IBT1 D (nolock)  On D.BaseEntry=A.DocEntry  AND  D.ItemCode=b.ItemCode and D.WhsCode=A.LocCode LEFT OUTER JOIN OITW E(NOLOCK) ON E.ItemCode=A.ItemCode AND E.WhsCode=A.LocCode WHERE E.OnHand <>'0'"
              }));

      log("StockCheckModel Res: ${response.body}");
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body.toString());
        log('datadatadata length::${data.length}');
        return StockCheckModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return StockCheckModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return StockCheckModel.error(e.toString(), 500);
    }
  }
}
