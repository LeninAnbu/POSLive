import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../../Constant/AppConstant.dart';
import '../../Models/QueryUrlModel/FetchFromPdaModel.dart';

class FetchBatchPdaApi {
  static Future<FetchBatchFromPdaModel> getGlobalData(
      String lineNo, String docEntry, String qty, int objType) async {
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
                    "[BZ_PDA_Get_BATCHES] '$docEntry','$lineNo',$objType,'$qty'"
              }));
      log('Fetchfrom pda::' +
          json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query": "[BZ_PDA_Get_BATCHES] '$docEntry','$lineNo',17,'$qty'"
          }));
      log("Fetchfrom pda Res: ${response.body}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        return FetchBatchFromPdaModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return FetchBatchFromPdaModel.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('FetchBatchFromPdaModel:::$e');
      //  throw Exception("Exception: $e");
      return FetchBatchFromPdaModel.error(e.toString(), 500);
    }
  }
}
