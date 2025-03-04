import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/NewReportsModel/CollectionReportModel.dart';

class CollectionReportApi {
  static Future<CollectionReport> getGlobalData(
    String frmDate,
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
                    "[BZ_POS_DAILY COLLECTION REPORT_R1] '$frmDate' , '$toDate' , '${AppConstant.branch}'"
              }));

      log("collection  Data Res: ${json.decode(response.body)}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        // var responseBody = response.body;
        // Map<String, dynamic> parsedResponse = json.decode(responseBody);
        // String leadList = parsedResponse['data'].toString();
        // List<String> keys = parsedResponse.keys.toList();

        // String jsonString = responseBody.toString();
        // Map<String, dynamic> decoded = jsonDecode(jsonString);
        // log('message:::$keys');
        // List<SplitLeadData> splitdataaa = [];
        // List<SplitLeadData> splitdataaa22 = [];

        // List<dynamic> parsedResponse2 = json.decode(leadList.toString());
        // List<dynamic> dataList = jsonDecode(decoded["data"]);

        // // Step 4: Iterate through the list and print keys and values
        // for (var item in dataList) {
        //   item.forEach((key, value) {
        //     print('$key: $value');
        //   });
        // }
        // log('messagemmmm::${splitdataaa[0].toString()}');
        // for (var i = 0; i < parsedResponse2.length; i++) {
        //   splitdataaa22.add(SplitLeadData(
        //       leadReportData: parsedResponse2[i]
        //           .values
        //           .toList()
        //           .toString()
        //           .replaceAll('[', '')));
        // }
        // log('splitdataaa:::${splitdataaa.length}');

        // log('splitdataaa222:::${splitdataaa22.length}');

        return CollectionReport.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return CollectionReport.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('CollectionReport:::$e');
      //  throw Exception("Exception: $e");
      return CollectionReport.error(e.toString(), 500);
    }
  }
}
