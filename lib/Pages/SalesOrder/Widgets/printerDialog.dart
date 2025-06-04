// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class MyDialog extends StatefulWidget {
//   @override
//   MyDialogState createState() => new MyDialogState();
// }

// class MyDialogState extends State<MyDialog> {






//   @override
//   void initState() {
//     super.initState();
//     method();
//   }

//   void method() async {
//     SharedPreferences preff = await SharedPreferences.getInstance();
//     SalesOrderinfoApi.deviceId = preff.getString("imei")!;
//     SalesOrderinfoApi.userID = preff.getString("userID")!;
//     SalesOrderinfoApi.docEntry = docEntry;
//     mycontroller[0].text = preff.getString("printerIP")!;
//   
//   
//   
//   
//   
//   
//     SalesOrderinfoApi.getApiData().then((value) {
//       if (value.data != null) {
//         setState(() => _isLoading = false);
//         printerData = value.data!;
//         setValues(printerData);
//       } else {
//         setState(() => _isLoading = false);
//         setState(() => showMSG = true);
//         message = 'Server error try again!!..';
//       }
//     });
//   }

//   setValues(List<SalesOderInfoData> data) {
//     var ab = (data.map((i) => i.lineTotal));
//     grandTotalpdf = ab.reduce((a, b) => a + b); //for adding array items
//     print("answer total: " + grandTotalpdf.toString());
//   }

//   List<TextEditingController> mycontroller = List.generate(15, (i) => TextEditingController());
//   @override









































































//   bool btnActive = true;
//   clickToPrinter() async {
//     setState(() => _isLoading = true);
//     setState(() => btnActive = false);
//     const PaperSize paper = PaperSize.mm58;
//     final profile = await CapabilityProfile.load();
//     print(profile.name);
//     final printer = NetworkPrinter(
//       paper,
//       profile,
//     );

//     final PosPrintResult res = await printer.connect(
//       mycontroller[0].text,
//       port: 9100,
//     );

//     if (res == PosPrintResult.success) {
//       testReceipt(printer);

//       setState(() {
//         _isLoading = false;
//         btnActive = true;
//         message = '${res.msg}';
//         showMSG = true;
//       });
//     } else {
//       if (res.msg == 'Success') {
//         setState(() {
//           _isLoading = false;
//         
//           message = '${res.msg}';
//           showMSG = true;
//         });
//       } else {
//         setState(() {
//           _isLoading = false;
//           btnActive = true;
//           message = '${res.msg}';
//           showMSG = true;
//         });
//       }
//     }
//   }

//   void testReceipt(NetworkPrinter printer) {
//     printer.text(
//       'JAMES AND CO',
//       styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2, bold: true),
//     );

//     printer.text('${printerData[0].block}', styles: PosStyles(align: PosAlign.center));

//     printer.text('${printerData[0].city} - ${printerData[0].pin}', styles: PosStyles(align: PosAlign.center));

//     printer.text('Mob:${printerData[0].mobile}', styles: PosStyles(align: PosAlign.center)); //, linesAfter: 1

//     printer.text('GST NO:${printerData[0].branchGst}', styles: PosStyles(align: PosAlign.center), linesAfter: 1);

//     printer.text('SO Draft - ${printerData[0].docEntry}',
//         styles: PosStyles(
//           align: PosAlign.left,
//           bold: true,
//           height: PosTextSize.size1,
//           width: PosTextSize.size1,
//         ));

//   
//   
//     printer.text('Mr./Mrs./Ms: ${printerData[0].cardName}', styles: PosStyles(align: PosAlign.left));
//     printer.text('Mobile: ${printerData[0].phone1}', styles: PosStyles(align: PosAlign.left));
//     printer.row([
//       PosColumn(
//         text: 'Date: ${printerData[0].docDate}',
//         width: 6,
//       ),
//       PosColumn(text: 'Time: ${printerData[0].docTime}', width: 7, styles: PosStyles(align: PosAlign.right)),
//     ]);
//     printer.hr();
//     printer.row([
//     
//       PosColumn(text: 'Descriprion', width: 8, styles: PosStyles(bold: true)),
//       PosColumn(text: 'Qty', width: 2, styles: PosStyles(align: PosAlign.right, bold: true)),
//       PosColumn(text: 'Price', width: 3, styles: PosStyles(align: PosAlign.right, bold: true)),
//     ]);
//     for (int i = 0; i < printerData.length; i++) {
//       printer.row([
//       
//         PosColumn(
//           text: '${printerData[i].scription.toString()}',
//           width: 8,
//         ),
//         PosColumn(text: '${printerData[i].qty.toStringAsFixed(0)}', width: 2, styles: PosStyles(align: PosAlign.right)), // styles: PosStyles(align: PosAlign.right)
//         PosColumn(text: '${printerData[i].unitPrice.toStringAsFixed(0)}', width: 3, styles: PosStyles(align: PosAlign.right)), //styles: PosStyles(align: PosAlign.right)
//       ]);
//     }

//     printer.hr();
// //  printer.text('Date: ${printerData[0].docDate}\nTime: ${printerData[0].docTime}',
//   
//     if (printerData[0].cash != 0) {
//     
//       printer.row([
//         PosColumn(
//           text: 'Cash:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].cash}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     }
//     if (printerData[0].card1Amt != 0 || printerData[0].card2Amt != 0) {
//       printer.row([
//         PosColumn(
//           text: 'Card:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].card1Amt + printerData[0].card2Amt}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     
//     }
//     if (printerData[0].exchangeAmt != 0) {
//       printer.row([
//         PosColumn(
//           text: 'Exchange:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].exchangeAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     
//     }
//     if (printerData[0].financeamt != 0) {
//       printer.row([
//         PosColumn(
//           text: 'Finance:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].financeamt}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     
//     }
//     if (printerData[0].codAmt != 0) {
//       printer.row([
//         PosColumn(
//           text: 'COD:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].codAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     
//     }
//     if (printerData[0].creditAmt != 0) {
//       printer.row([
//         PosColumn(
//           text: 'Credit:',
//           width: 5,
//         ),
//         PosColumn(text: '${printerData[0].creditAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
//       ]);
//     
//     }

//     printer.text(' ',
//         styles: PosStyles(
//           align: PosAlign.center,
//         ),
//         linesAfter: 1);

//     printer.row([
//       PosColumn(
//         text: 'Total:',
//         width: 5,
//       ),
//       PosColumn(text: '${grandTotalpdf!.toStringAsFixed(2)}', width: 8, styles: PosStyles(align: PosAlign.right)),
//     ]);

//     printer.text(' ',
//         styles: PosStyles(
//           align: PosAlign.center,
//         ),
//         linesAfter: 1);

//     printer.text('Sales Employee: ${printerData[0].slpName}', styles: PosStyles(align: PosAlign.center), linesAfter: 1);
//     printer.text('Thank you for purchasing!!',
//         styles: PosStyles(
//           align: PosAlign.center,
//           bold: true,
//           height: PosTextSize.size1,
//           width: PosTextSize.size1,
//         ));
//   
//     printer.feed(2);
//     printer.cut();
//     printer.disconnect();
//   }
// }
