import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../../Constant/AppConstant.dart';
import '../../Models/ServiceLayerModel/SapSalesQuotation/SalesQuotPostModel.dart';

class NewReportApi2 {
  static List<SplitLeadData> splitdataaa = [];
  static List<SplitLeadData> splitdataaa22 = [];
  static List<SplitLeadData> splitdataaa55 = [];
  static List<TestReportMod> leadReportTestt = [];
  static List<newvaluedynamic> values = [];

  static Future<SalesQuotStatus> getGlobalData(
    String reportQeury,
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
                "query": "$reportQeury"
              }));
      log('New Report query::${json.encode({
            "constr":
                "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
            "query": "$reportQeury"
          })}');
      // log("New Report details: ${json.decode(response.body)}");

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        values = [];
        var responseBody = response.body;
        // final parsedData = await compute(parseJson, response.body);
        // log('message33');

        Map<String, dynamic> parsedResponse = json.decode(responseBody);
        // log('message44');

        splitdataaa22 = [];
        leadReportTestt = [];
        if (parsedResponse['data'] != "No data found") {
          // log('message111');
          List<dynamic> leadListReport2 = json.decode(parsedResponse['data']);

          // log('leadListReport2WWWW::${leadListReport2}');
          values.clear();
          separateKeysAndValues(
            json.decode(parsedResponse['data']).cast<Map<String, dynamic>>(),
          );
          if (leadListReport2.length > 0) {
            leadListReport2[0].keys.toList();

            // reportDataList = leadListReport2
            //     .map((data) => LeadAnalysisReportData.fromJson(data, columnNames))
            //     .toList();
          }

          for (int i = 0; i < leadListReport2.length; i++) {
            values.add(newvaluedynamic(data: leadListReport2[i]));
            // log("leadListReport2::" + values.length.toString());
            // log("First Item in List: ${values[0].data}");
          }

          return SalesQuotStatus.issue(
            '',
            response.statusCode,
          );
        } else {
          log('message22');
          return SalesQuotStatus.fromJson(response.statusCode);
        }
      } else {
        // throw Exception('Restart the app or contact the admin!!..');
        return SalesQuotStatus.fromJson(response.statusCode);
      }
    } catch (e) {
      log(e.toString());
      // throw Exception(e);
      return SalesQuotStatus.issue(
          'Restart the app or contact the admin!!..\n', 500);
    }
    //   } else {
    //     return "";
    //   }
    // } catch (e) {
    //   log('NewReportApi2:::$e');
    //   //  throw Exception("Exception: $e");
    //   return "TestReportMod.error('')";
    //   // SalesInDay.error(e.toString(), 500);
    // }
  }

  static separateKeysAndValues(
    List<Map<String, dynamic>> data,
  ) {
    for (var map in data) {
      // Extract keys
      map.keys.toList();
      // Extract values
      map.values.toList();

      // Print or process keys and values
      // print('Keys: $keys');
      // print('Values: $values');
      // print('---'); // Separator for clarity
    }
  }
}

class newvaluedynamic {
  Map<String, dynamic> data;
  newvaluedynamic({required this.data});

  dynamic getFieldValue(String key) {
    return data[key];
  }
}

class SplitLeadData {
  var leadReportData;
  SplitLeadData({required this.leadReportData});
}

class TestReportMod {
  String title;
  List<TestReportValues> testReportValList;
  TestReportMod({required this.testReportValList, required this.title});
}

class TestReportValues {
  int? lineid;
  String? titleVal;
  String? reportValues;
  TestReportValues({
    this.lineid,
    this.titleVal,
    this.reportValues,
  });
  // Map<String, Object?> toMap() => {
  //       LeadTestReportDB.title: titleVal,
  //       LeadTestReportDB.testValues: reportValues,
  //     };
}

class LeadAnalysisReportData {
  String title;
  String value;

  LeadAnalysisReportData({required this.value, required this.title});
  factory LeadAnalysisReportData.fromJson(dynamic json, List<String> titles) {
    List<TestReportValues> insertTestValues = [];
    log('titles.length::${titles.length}');
    for (int i = 0; i < titles.length; i++) {
      print('Answser11:' + titles[i].toString());
      print('Answser22:' + json[titles[i]].toString());
      insertTestValues.add(TestReportValues(
          reportValues: json[titles[i]].toString(),
          titleVal: titles[i].toString()));
      // print('Answser22:' + json[titles[i]].toString());
    }
    return LeadAnalysisReportData(
      value: json["AssignedTo"],
      title: json["LeadDate"] ?? '',
    );
  }
}
// class TestReportValues {
//   int? lineid;

//   TestReportValues({
//     this.lineid,
//   });
// }
// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import '../../Constant/AppConstant.dart';
// import '../../Controller/ReportsController.dart';
// import '../../Models/NewReportsModel/SalesDaysReportMdl.dart';

// class NewReportApi2 {
//   static List<SplitLeadData> splitdataaa = [];
//   static List<SplitLeadData> splitdataaa22 = [];
//   static List<SplitLeadData> splitdataaa55 = [];
//   static List<TestReportMod> leadReportTestt = [];

//   static Future<SalesInDay> getGlobalData(
//       String reportQeury, String frmDate, String toDate, String code) async {
//     try {
//       final response =
//           await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
//               headers: {
//                 'content-type': 'application/json',
//               },
//               body: json.encode({
//                 "constr":
//                     "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
//                 "query": "[$reportQeury] '$frmDate' , '$toDate' , '$code'"
//               }));
//       log('New Report query::${json.encode({
//             "constr":
//                 "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
//             "query": "[$reportQeury] '$frmDate' , '$toDate' , '$code'"
//           })}');
//       log("New Report details: ${json.decode(response.body)}");

//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         var responseBody = response.body;

//         Map<String, dynamic> parsedResponse = json.decode(responseBody);

//         splitdataaa22 = [];
//         leadReportTestt = [];

//         String xxx = '';

//         var leadListReport2 = parsedResponse['data'];
//         log('leadListReport2::${leadListReport2.toString()}');
//         // var leadListReport2 = leadListReport.toSet().toList();
//         for (var i = 0; i < leadListReport2.length; i++) {
//           // log('message keys::${leadListReport2[i].keys.toString()}');
//           if (leadListReport2[i].contains('"":')) {
//             log('message keys::${leadListReport2[i].keys}');
//             // if (leadListReport2[i].toString() != '[' ||
//             //     leadListReport2[i].toString() != '{' ||
//             //     leadListReport2[i].toString() != '}' ||
//             //     leadListReport2[i].toString() != ']') {

//             // splitdataaa.add(SplitLeadData(
//             //     leadReportData:
//             //         leadListReport2[i].keys.toString().replaceAll('(', '')));
//           }
//         }
//         // ReportController.tablercolumnzz = leadListReport2;
//         List<String> propertiesaa = [];
//         ReportController.tablerColumn = splitdataaa;
//         // log('splitdataaas reportdet:${splitdataaa.length}::::${splitdataaa[0].leadReportData.toString()}');
//         // for (var i = 0; i < splitdataaa.length; i++) {
//         //   xxx = splitdataaa[i].leadReportData!.toString().replaceAll(']', '');
//         // }
//         // String zzz = xxx.toString().replaceAll(',', '').toString();
//         // List<String> properties = zzz.split('').map((e) => e.trim()).toList();

//         // for (var i = 0; i < properties.length; i++) {
//         //   splitdataaa55
//         //       .add(SplitLeadData(leadReportData: properties[i].toString()));
//         // }
//         // log('splitdataaa55 reportdet:${splitdataaa55.length}::::${splitdataaa55[0].leadReportData.toString()}');

//         for (var i = 0; i < leadListReport2.length; i++) {
//           splitdataaa22.add(SplitLeadData(
//               leadReportData: leadListReport2[i]
//                   .values
//                   .toList()
//                   .toString()
//                   .replaceAll('[', '')));
//         }
//         propertiesaa = [];

//         for (var i = 0; i < splitdataaa22.length; i++) {
//           xxx = splitdataaa22[i].leadReportData!.toString().replaceAll(']', '');

//           String aaaa = xxx.toString();
//           propertiesaa.addAll(aaaa.split(',').map((e) => e.trim()).toList());
//         }
//         ReportController.tablerColumn55 = propertiesaa;

//         log('propertiesaa reportdet::${propertiesaa.length}::${propertiesaa[0].toString()}');

//         return SalesInDay.fromJson(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode);
//       } else {
//         return SalesInDay.fromJson(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode);
//       }
//     } catch (e) {
//       log('NewReportApi2:::$e');
//       //  throw Exception("Exception: $e");
//       return SalesInDay.error(e.toString(), 500);
//     }
//   }
// }

// class SplitLeadData {
//   var leadReportData;
//   SplitLeadData({required this.leadReportData});
// }

// class TestReportMod {
//   String title;
//   List<TestReportValues> testReportValList;
//   TestReportMod({required this.testReportValList, required this.title});
// }

// class TestReportValues {
//   int? lineid;
//   String? titleVal;
//   String? reportValues;
//   TestReportValues({
//     this.lineid,
//     this.titleVal,
//     this.reportValues,
//   });
//   // Map<String, Object?> toMap() => {
//   //       LeadTestReportDB.title: titleVal,
//   //       LeadTestReportDB.testValues: reportValues,
//   //     };
// }
