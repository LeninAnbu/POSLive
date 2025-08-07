// ignore_for_file: prefer_single_quotes, prefer_interpolation_to_compose_strings, use_raw_strings, require_trailing_commas

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:posproject/Constant/AppConstant.dart';
import 'package:posproject/Models/StockListModel/ItemsModels.dart';
import 'package:posproject/url/url.dart';

class ItemsAPi {
  static String searchData = '';
  static String? sessionID;
  static String? nextUrl;
  static String? mainGroup;
  static String? subGroup;
  static String maximumfetchValue = '70';
  static Future<ItemModal> getGlobalData(String pack) async {
    log("${URL.sapUrl}/Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices,U_Pack_Size,U_Tins_Per_Box,U_Prd_MainGrp,U_Prd_SubGrp&\$filter=(((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData') or contains(U_Pack_Size,'-') or contains(U_Prd_MainGrp,'$mainGroup')  or contains(U_Prd_SubGrp,'$subGroup'))) and Valid eq 'tYES' )");
    try {
      final response = await http.get(
        Uri.parse(
            "${URL.sapUrl}/Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices,U_Pack_Size,U_Tins_Per_Box,U_Prd_MainGrp,U_Prd_SubGrp&\$filter=(((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData') or contains(U_Pack_Size,'-') or contains(U_Prd_MainGrp,'$mainGroup')  or contains(U_Prd_SubGrp,'$subGroup'))) and Valid eq 'tYES' )"),

        // "${URL.sapUrl}/Items?\$select=ItemCode,ItemName,SalesUnit,ItemPrices,U_Pack_Size,U_Tins_Per_Box&\$filter=((contains(ItemCode,'$searchData') or contains(ItemName,'$searchData')) or contains(U_Pack_Size,'$pack.') or contains(U_Prd_MainGrp,'$mainGroup') or contains(U_Prd_SubGrp,'$subGroup') or Valid eq 'tYES' )"),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          'Prefer': 'odata.maxpagesize=$maximumfetchValue'
        },
      );
      log("maximumfetchValue::" + maximumfetchValue);
      log("response::" + response.body);

      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        // print(response.body);
        return ItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        //  print(json.decode(response.body));
        //    print(json.decode(response.statusCode.toString()));
        throw Exception('Restart the app or contact the admin!!..');
        // return ItemModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception(e);
      //  return ItemModal.issue('Restart the app or contact the admin!!..');
    }
  }

  static Future<ItemModal> callNextLink() async {
    try {
      String url = '${URL.sapUrl}';
      final response = await http.get(
        Uri.parse(
          url + nextUrl.toString(),
        ),
        headers: {
          "content-type": "application/json",
          "cookie": 'B1SESSION=' + AppConstant.sapSessionID.toString(),
          'Prefer': 'odata.maxpagesize=$maximumfetchValue'
        },
      );
      if (response.statusCode == 200) {
        //  print(json.decode(response.body));
        //   print(response.statusCode);
        return ItemModal.fromJson(
            json.decode(response.body) as Map<String, dynamic>);
      } else {
        //  print(json.decode(response.body));
        //  print(response.statusCode);
        throw Exception('Restart the app or contact the admin!!..');
        //  return ItemModal.issue('Restart the app or contact the admin!!..');
      }
    } catch (e) {
      throw Exception('Restart the app or contact the admin!!..');
      //  return ItemModal.issue('Restart the app or contact the admin!!..');
    }
  }
}
