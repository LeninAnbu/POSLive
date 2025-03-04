import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/ServiceLayerModel/SapSalesOrderModel/OrderModelForPutModel.dart';
import '../../url/url.dart';

class GetOrderDetailsAPI {
  static Future<GetOrderDetails> getData(String sapDocEntry) async {
    log("AppConstant.sapSessionIDxx:::${AppConstant.sapSessionID}");
    try {
      log("sapDocNum sapDocNum::$sapDocEntry");
      final response = await http.get(
        Uri.parse('${URL.sapUrl}/Orders($sapDocEntry)'),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=${AppConstant.sapSessionID}',
        },
      );
      // ressCode = response.statusCode;
      log("SalesOrder stscode::${response.statusCode}");
      // log("SalesQuo::${response.body}");

      if (response.statusCode >= 200 && response.statusCode <= 204) {
        return GetOrderDetails.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        log("SalesQuo Exception: Error");
        // throw Exception("Errorrrrr");
        return GetOrderDetails.issue(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log("GetOrderException:: $e");
      // throw Exception("Error");
      return GetOrderDetails.issue(json.decode(e.toString()), 500);
    }
  }
}
