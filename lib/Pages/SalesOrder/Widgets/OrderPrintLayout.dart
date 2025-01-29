// import 'package:flutter/material.dart';
// import 'package:posbillingdesign/Controller/SalesOrderController/SalesOrderController.dart';
// import 'package:posbillingdesign/Pages/PrintPDF/invoice.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:esc_pos_printer/esc_pos_printer.dart';
// import 'package:esc_pos_utils/esc_pos_utils.dart';

// class OrderMyDialog extends StatefulWidget {
//   OrderMyDialog({
//     Key? key,
//     required this.iinvoice,
//   }) : super(key: key);
//   Invoice? iinvoice;

//   @override
//   OrderMyDialogState createState() => OrderMyDialogState();
// }

// class OrderMyDialogState extends State<OrderMyDialog> {
//   static String? docEntry;
//   bool _isLoading = true;
//   bool showMSG = false;
//   String? message;
//   double? grandTotalpdf;
//   Future<SharedPreferences> pref = SharedPreferences.getInstance();

//   @override
//   void initState() {
//     super.initState();
//     method();
//   }

//   void method() async {
//     SharedPreferences preff = await SharedPreferences.getInstance();
//     // mycontroller[0].text = preff.getString("printerIP")!;
//     // SalesOrderinfoApi.getApiData().then((value) {
//     if (widget.iinvoice != null) {
//       setState(() => _isLoading = false);
//       // printerData = value.data!;
//       // setValues(widget.iinvoice!.;
//     } else {
//       setState(() => _isLoading = false);
//       setState(() => showMSG = true);
//       message = 'Server error try again!!..';
//     }
//   }

//   // setValues(List<SalesOderInfoData> data) {
//   //   var ab = (data.map((i) => i.lineTotal));
//   //   grandTotalpdf = ab.reduce((a, b) => a + b); //for adding array items
//   //   print("answer total: " + grandTotalpdf.toString());
//   // }

//   List<TextEditingController> mycontroller = List.generate(15, (i) => TextEditingController());
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final heigth = MediaQuery.of(context).size.height;
//     final theme = Theme.of(context);
//     return AlertDialog(
//       content: Container(
//         //  color: Colors.black12,
//         //  height: heigth * 0.4,
//         width: width * 0.8,
//         child: _isLoading == true
//             ? Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Center(child: CircularProgressIndicator()),
//                 ],
//               )
//             : showMSG == true
//                 ? Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Center(
//                           child: Container(
//                         child: Text(message!),
//                       )),
//                     ],
//                   )
//                 : Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         height: heigth * 0.06,
//                         decoration: BoxDecoration(
//                           color: theme.hintColor.withOpacity(.05),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: TextField(
//                           controller: mycontroller[0],
//                           autocorrect: false,
//                           style: theme.textTheme.bodyText2,
//                           decoration: InputDecoration(
//                             hintText: 'Enter Printer IP',
//                             enabledBorder: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             contentPadding: const EdgeInsets.symmetric(
//                               vertical: 15,
//                               horizontal: 5,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//       ),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             setState(() => showMSG = false);
//           },
//           child: Text("Cancel"),
//         ),
//         TextButton(
//           onPressed: btnActive == true
//               ? () {
//                   clickToPrinter();
//                 }
//               : null,
//           child: Text("Print"),
//         ),
//       ],
//     );
//   }

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

//     // final PosPrintResult res = await printer.connect(
//     //   mycontroller[0].text,
//     //   port: 9100,
//     // );
//     final PosPrintResult res = await printer.connect('192.168.118.100', port: 9100);
//     // if (res == PosPrintResult.success) {
//     // testReceipt(printer);

//     print('Print result: ${res.msg}');
//     context.read<SOCon>().orderPDFtoPrinter(
//           pref,
//           context,
//         );

//     //   setState(() {
//     //     _isLoading = false;
//     //     btnActive = true;
//     //     message = '${res.msg}';
//     //     showMSG = true;
//     //   });
//     // } else {
//     //   if (res.msg == 'Success') {
//     //     setState(() {
//     //       _isLoading = false;
//     //       // btnActive= true;
//     //       message = '${res.msg}';
//     //       showMSG = true;
//     //     });
//     //   } else {
//     //     setState(() {
//     //       _isLoading = false;
//     //       btnActive = true;
//     //       message = '${res.msg}';
//     //       showMSG = true;
//     //     });
//     //   }
//     // }
//   }

// //   void testReceipt(NetworkPrinter printer) {
// //     printer.row([
// //       PosColumn(
// //         text: '${widget.iinvoice!.invoiceMiddle!.customerName}',
// //         width: 3,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //       PosColumn(
// //         text: 'ZAZNIBAR',
// //         width: 6,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //       PosColumn(
// //         text: 'TIN No.:',
// //         width: 3,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //       PosColumn(
// //         text: '127876479',
// //         width: 3,
// //         styles: PosStyles(align: PosAlign.center, underline: true),
// //       ),
// //     ]);
// //     // printer.text(
// //     //   'JAMES AND CO',
// //     //   styles: PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2, bold: true),
// //     // );

// //     // printer.text('${printerData[0].block}', styles: PosStyles(align: PosAlign.center));

// //     // printer.text('${printerData[0].city} - ${printerData[0].pin}', styles: PosStyles(align: PosAlign.center));

// //     // printer.text('Mob:${printerData[0].mobile}', styles: PosStyles(align: PosAlign.center)); //, linesAfter: 1

// //     // printer.text('GST NO:${printerData[0].branchGst}', styles: PosStyles(align: PosAlign.center), linesAfter: 1);

// //     // printer.text('SO Draft - ${printerData[0].docEntry}',
// //     //     styles: PosStyles(
// //     //       align: PosAlign.left,
// //     //       bold: true,
// //     //       height: PosTextSize.size1,
// //     //       width: PosTextSize.size1,
// //     //     ));

// //     // //  printer.text('Date: ${printerData[0].docDate} Time: ${printerData[0].docTime}',
// //     // //   styles: PosStyles(align: PosAlign.left));
// //     // printer.text('Mr./Mrs./Ms: ${widget.iinvoice!.invoiceMiddle!.customerName}', styles: PosStyles(align: PosAlign.left));
// //     // printer.text('Mobile: ${printerData[0].phone1}', styles: PosStyles(align: PosAlign.left));
// //     // printer.row([
// //     //   PosColumn(
// //     //     text: 'Date: ${printerData[0].docDate}',
// //     //     width: 6,
// //     //   ),
// //     //   PosColumn(text: 'Time: ${printerData[0].docTime}', width: 7, styles: PosStyles(align: PosAlign.right)),
// //     // ]);

// //     printer.hr();
// //     printer.row([
// //       //  PosColumn(text: 'S.NO', width: 1,styles: PosStyles(bold: true)),
// //       PosColumn(text: 'Descriprion', width: 8, styles: PosStyles(bold: true)),
// //       PosColumn(text: 'Qty', width: 2, styles: PosStyles(align: PosAlign.right, bold: true)),
// //       PosColumn(text: 'Unit Price', width: 3, styles: PosStyles(align: PosAlign.right, bold: true)),
// //       PosColumn(text: 'Disc %', width: 2, styles: PosStyles(align: PosAlign.right, bold: true)),
// //       PosColumn(text: 'Tax', width: 2, styles: PosStyles(align: PosAlign.right, bold: true)),

// //       PosColumn(text: 'Net Amount', width: 3, styles: PosStyles(align: PosAlign.right, bold: true)),
// //     ]);
// //     for (int i = 0; i < widget.iinvoice!.items!.length; i++) {
// //       printer.row([
// //         // PosColumn(text: '${data[i].lineNum}', width: 1,),
// //         PosColumn(
// //           text: '${widget.iinvoice!.items![i].descripton.toString()}',
// //           width: 8,
// //         ),
// //         PosColumn(text: '${widget.iinvoice!.items![i].quantity!.toStringAsFixed(0)}', width: 2, styles: PosStyles(align: PosAlign.right)), // styles: PosStyles(align: PosAlign.right)
// //         PosColumn(text: '${widget.iinvoice!.items![i].unitPrice!.toStringAsFixed(0)}', width: 3, styles: PosStyles(align: PosAlign.right)), //styles: PosStyles(align: PosAlign.right)
// //         PosColumn(text: '${widget.iinvoice!.items![i].dics!.toStringAsFixed(0)}', width: 3, styles: PosStyles(align: PosAlign.right)), //styles: PosStyles(align: PosAlign.right)
// //         PosColumn(text: '${widget.iinvoice!.items![i].vat!.toStringAsFixed(0)}', width: 3, styles: PosStyles(align: PosAlign.right)), //styles: PosStyles(align: PosAlign.right)
// //         PosColumn(text: '${widget.iinvoice!.items![i].netTotal!.toStringAsFixed(0)}', width: 3, styles: PosStyles(align: PosAlign.right)), //styles: PosStyles(align: PosAlign.right)
// //       ]);
// //     }

// //     printer.hr();
// // //  printer.text('Date: ${printerData[0].docDate}\nTime: ${printerData[0].docTime}',
// //     //       styles: PosStyles(align: PosAlign.left));
// //     // if (printerData[0].cash != 0) {
// //     //   //    printer.text('Cash:     Rs:${printerData[0].cash}',styles: PosStyles(align: PosAlign.left));
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'Cash:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].cash}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     // }
// //     // if (printerData[0].card1Amt != 0 || printerData[0].card2Amt != 0) {
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'Card:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].card1Amt + printerData[0].card2Amt}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     //   // printer.text('Card:     Rs:${printerData[0].card1Amt+printerData[0].card2Amt}',styles: PosStyles(align: PosAlign.left));
// //     // }
// //     // if (printerData[0].exchangeAmt != 0) {
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'Exchange:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].exchangeAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     //   //  printer.text('Exchange: Rs:${printerData[0].exchangeAmt}',styles: PosStyles(align: PosAlign.left));
// //     // }
// //     // if (printerData[0].financeamt != 0) {
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'Finance:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].financeamt}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     //   //   printer.text('Finance:  Rs:${printerData[0].financeamt}',styles: PosStyles(align: PosAlign.left));
// //     // }
// //     // if (printerData[0].codAmt != 0) {
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'COD:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].codAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     //   //   printer.text('COD:      Rs:${printerData[0].codAmt}',styles: PosStyles(align: PosAlign.left));
// //     // }
// //     // if (printerData[0].creditAmt != 0) {
// //     //   printer.row([
// //     //     PosColumn(
// //     //       text: 'Credit:',
// //     //       width: 5,
// //     //     ),
// //     //     PosColumn(text: '${printerData[0].creditAmt}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     //   ]);
// //     //   //   printer.text('Credit:   Rs:${printerData[0].creditAmt}',styles: PosStyles(align: PosAlign.left));
// //     // }

// //     printer.text(' ',
// //         styles: PosStyles(
// //           align: PosAlign.center,
// //         ),
// //         linesAfter: 1);

// //     printer.row([
// //       PosColumn(
// //         text: 'Total:',
// //         width: 5,
// //       ),
// //       PosColumn(text: '${grandTotalpdf!.toStringAsFixed(2)}', width: 8, styles: PosStyles(align: PosAlign.right)),
// //     ]);

// //     printer.text(' ',
// //         styles: PosStyles(
// //           align: PosAlign.center,
// //         ),
// //         linesAfter: 1);

// //     //last---
// //     printer.feed(2);
// //     printer.cut();
// //     printer.disconnect();
// //   }
// }
