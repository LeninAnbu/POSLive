import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/StockListModel/MainGroupModel.dart';
import 'package:posproject/url/url.dart';

class MainGroupAPi {
  static Future<MainModal> getGlobalData() async {
    try {
      log('MainGroup Url::${"${URL.sapUrl}/U_PRDMAINGRP?\$orderby=Name"}');
      final response = await http.get(
        Uri.parse(
          "${URL.sapUrl}/U_PRDMAINGRP?\$orderby=Name",
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          'Prefer': 'odata.maxpagesize=1000',
        },
      );
      log("MAINGRP statusCode::" + response.statusCode.toString());

      // log("MAINGRP res::" + json.decode(response.body).toString());
      if (response.statusCode == 200) {
        return MainModal.fromJson(
          json.decode(response.body) as Map<String, dynamic>,
        );
      } else {
        // print(json.decode(response.body));
        // print(json.decode(response.statusCode.toString()));
        // throw Exception('Restart the app or contact the admin!!..');
        return MainModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      // throw Exception(e);
      return MainModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
