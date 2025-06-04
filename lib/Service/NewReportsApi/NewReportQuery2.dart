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

      log(response.statusCode.toString());
      if (response.statusCode == 200) {
        values = [];
        var responseBody = response.body;

        Map<String, dynamic> parsedResponse = json.decode(responseBody);

        splitdataaa22 = [];
        leadReportTestt = [];
        if (parsedResponse['data'] != "No data found") {
          List<dynamic> leadListReport2 = json.decode(parsedResponse['data']);

          values.clear();
          separateKeysAndValues(
            json.decode(parsedResponse['data']).cast<Map<String, dynamic>>(),
          );
          if (leadListReport2.length > 0) {
            leadListReport2[0].keys.toList();
          }

          for (int i = 0; i < leadListReport2.length; i++) {
            values.add(newvaluedynamic(data: leadListReport2[i]));
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
        return SalesQuotStatus.fromJson(response.statusCode);
      }
    } catch (e) {
      log(e.toString());

      return SalesQuotStatus.issue(
          'Restart the app or contact the admin!!..\n', 500);
    }
  }

  static separateKeysAndValues(
    List<Map<String, dynamic>> data,
  ) {
    for (var map in data) {
      map.keys.toList();

      map.values.toList();
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
//        
//         for (var i = 0; i < leadListReport2.length; i++) {
//          
//           if (leadListReport2[i].contains('"":')) {
//             log('message keys::${leadListReport2[i].keys}');
//            
//            
//            
//            

//            
//            
//            
//           }
//         }
//        
//         List<String> propertiesaa = [];
//         ReportController.tablerColumn = splitdataaa;
//        
//        
//        
//        
//        
//        

//        
//        
//        
//        
//        

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
//      
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
//  
//  
//  
//  
// }
