import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ReportsModel/PendingOrderModel.dart';

class PendingOrderAPi {
  static Future<PendingOrdersModel> getGlobalData(
    String fromDate,
    String toDate,
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
                "query":
                "EXEC BZ_POS_PendingOrderAPi  '$fromDate','$toDate'"
                    // " SELECT  A.DocNum [Document Number],A.CardName [CustomerName],A.CardCode [Customer Code],A.DocDate [date],A.DocTotal [Total],B.ItemCode [ItemCode], B.Dscription [ItemName],B.Quantity [Total Qty],b.OpenQty [Balance Qty] FROM ORDR A INNER jOIN RDR1 B ON A.DocEntry=B.DocEntry where a.DocDate between '$fromDate' and '$toDate' Order by A.DocNum"
              }));

      log("PendingOrders Res: ${json.decode(response.body)}");
      if (response.statusCode == 200) {
        return PendingOrdersModel.fromJson(response.body, response.statusCode);
      } else {
        // throw Exception("Error!!...");
        return PendingOrdersModel.fromJson(response.body, response.statusCode);
      }
    } catch (e) {
      log('exp::${e.toString()}');
      //  throw Exception("Exception: $e");
      return PendingOrdersModel.error(e.toString(), 500);
    }
  }
}
