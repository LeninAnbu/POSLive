// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// import '../../Constant/AppConstant.dart';
// import '../../Models/QueryUrlModel/IncomingPaymentCardCodeModel.dart';

// class IncomingPaymentCardCodeAPi {
//   static Future<IncomingPayCardCodeModel> getGlobalData(String cardCode) async {
//     try {
//       final response =
//           await http.post(Uri.parse('http://102.69.167.106:1705/api/SellerKit'),
//               headers: {
//                 'content-type': 'application/json',
//               },
//               body: json.encode({
//                 "constr":
//                     "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
//                 "query":
//                     "Select docentry, docnum, docdate, taxdate, cardcode, cardname, doctotal, paidtodate paid, doctotal-paidtodate balance from oinv where canceled ='n' and doctotal-paidtodate > 0 and cardcode = '$cardCode'"
//               }));

//       log("Quot Header Data ${json.encode({
//             "constr":
//                 "Server=INSIGNIAC03313;Database=${AppConstant.sapDB};User Id=sa; Password=Insignia@2021#;",
//             "query":
//                 "Select docentry, docnum, docdate, taxdate, cardcode, cardname, doctotal, paidtodate paid, doctotal-paidtodate balance from oinv where canceled ='n' and doctotal-paidtodate > 0 and cardcode = '$cardCode'"
//           })}");

//       log("PayReceipt Data Res: ${json.decode(response.body)}");
//       print(response.statusCode);
//       if (response.statusCode == 200) {
//         return IncomingPayCardCodeModel.fromJson(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode);
//         //24-22620
//       } else {
//         return IncomingPayCardCodeModel.fromJson(
//             json.decode(response.body) as Map<String, dynamic>,
//             response.statusCode);
//       }
//     } catch (e) {
//       log('IncomingPayCardCodeModel:::$e');
//       //  throw Exception("Exception: $e");
//       return IncomingPayCardCodeModel.error(e.toString(), 500);
//     }
//   }
// }
