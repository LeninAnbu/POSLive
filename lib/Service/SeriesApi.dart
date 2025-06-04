import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';

import '../Models/DataModel/SeriesMode/SeriesModels.dart';

class SeriesAPi {
  static Future<SeriesListModel> getGlobalData(String seriesType) async {
    try {
      final response = await http.post(
        Uri.parse(
          'http://102.69.167.106:50001/b1s/v1/SeriesService_GetDocumentSeries',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': 'B1SESSION=${AppConstant.sapSessionID}',
        },
        body: json.encode({
          "DocumentTypeParams": {
            "Document": "$seriesType",
          },
        }),
      );

      log(
        'message' +
            json.encode({
              "DocumentTypeParams": {
                "Document": "$seriesType",
              },
            }),
      );
      log("SeriesAPiiiiiiiii: ${response.statusCode}");

      if (response.statusCode <= 210) {
        log(response.statusCode.toString());
        return SeriesListModel.fromJson(
            json.decode(response.body), response.statusCode);
      } else {
        return SeriesListModel.error(
            json.decode(response.body), response.statusCode);
      }
    } catch (e) {
      log('message series api::$e');

      return SeriesListModel.issue(
          'Restart the app or contact the admin!!..', 500);
    }
  }
}
