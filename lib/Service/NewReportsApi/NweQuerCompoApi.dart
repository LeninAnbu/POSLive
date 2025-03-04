import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Controller/ReportsController.dart';
import '../../Models/NewReportsModel/SalesDaysReportMdl.dart';
import 'NewReportQuery2.dart';

class NewReportCompoApi {
  static List<SplitLeadData> splitdataaa = [];
  static List<SplitLeadData> splitdataaa22 = [];
  static List<SplitLeadData> splitdataaa55 = [];
  static List<TestReportMod> leadReportTestt = [];
  static Future<SalesInDay> getGlobalData(
    String compoApi,
  ) async {
    try {
      log('messagemmm::$compoApi');
      final response =
          await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
              headers: {
                'content-type': 'application/json',
              },
              body: json.encode({
                "constr":
                    "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
                "query": "$compoApi"
              }));

      log('response.body::${response.statusCode}');
      if (response.statusCode == 200) {
        var responseBody = response.body;

        Map<String, dynamic> parsedResponse = json.decode(responseBody);

        splitdataaa22 = [];
        leadReportTestt = [];

        String xxx = '';

        var leadListReport = json.decode(parsedResponse['data']);

        var leadListReport2 = leadListReport.toSet().toList();
        for (var i = 0; i < leadListReport2.length; i++) {
          if (leadListReport2[i].toString() != '[' ||
              leadListReport2[i].toString() != '{' ||
              leadListReport2[i].toString() != '}' ||
              leadListReport2[i].toString() != ']') {
            splitdataaa
                .add(SplitLeadData(leadReportData: leadListReport2[i].keys));
          }
        }
        List<String> propertiesaa = [];

        log('splitdataaasplitdataaa:${splitdataaa.length}::::${splitdataaa[0].leadReportData.toString()}');
        for (var i = 0; i < splitdataaa.length; i++) {
          xxx = splitdataaa[i].leadReportData!.toString().replaceAll(']', '');
        }
        String zzz = xxx.toString().replaceAll(',', '').toString();
        List<String> properties = zzz.split(' ').map((e) => e.trim()).toList();

        for (var i = 0; i < properties.length; i++) {
          splitdataaa55
              .add(SplitLeadData(leadReportData: properties[i].toString()));
        }
        log('splitdataaa55:${splitdataaa55.length}::::${splitdataaa55[0].leadReportData.toString()}');

        for (var i = 0; i < leadListReport2.length; i++) {
          splitdataaa22.add(SplitLeadData(
              leadReportData: leadListReport2[i]
                  .values
                  .toList()
                  .toString()
                  .replaceAll('[', '')));
        }
        propertiesaa = [];

        for (var i = 0; i < splitdataaa22.length; i++) {
          xxx = splitdataaa22[i].leadReportData!.toString().replaceAll(']', '');

          String aaaa = xxx.toString();
          propertiesaa.addAll(aaaa.split(',').map((e) => e.trim()).toList());
        }
        log('propertiesaapropertiesaa::${propertiesaa.length}::${propertiesaa[0].toString()}');

        ReportController.listBoxData = propertiesaa;

        return SalesInDay.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      } else {
        return SalesInDay.fromJson(
            json.decode(response.body) as Map<String, dynamic>,
            response.statusCode);
      }
    } catch (e) {
      log('NewReportCompoApi:::$e');
      //  throw Exception("Exception: $e");
      return SalesInDay.error(e.toString(), 500);
    }
  }
}
