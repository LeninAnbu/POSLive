// // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../Controller/SalesOrderController/SalesOrderController.dart';

// class SOPaymentDetails extends StatefulWidget {
//   SOPaymentDetails(
//       {Key? key,
//       required this.theme,
//       required this.paymentHeight,
//       required this.paymentWidth})
//       : super(key: key);
//   final ThemeData theme;
//   double paymentHeight;
//   double paymentWidth;

//   @override
//   State<SOPaymentDetails> createState() => _SOPaymentDetailsState();
// }

// class _SOPaymentDetailsState extends State<SOPaymentDetails> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: widget.paymentHeight,
//         width: widget.paymentWidth,
//         padding: EdgeInsets.only(
//           top: widget.paymentHeight * 0.01,
//           left: widget.paymentHeight * 0.01,
//           right: widget.paymentHeight * 0.01,
//           bottom: widget.paymentHeight * 0.01,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(5),
//         ),
//         child: Container(
//           // height: paymentHeight * 0.35,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             color: context.watch<SOCon>().getScanneditemData2.isNotEmpty
//                 ? Colors.grey[300]
//                 : Colors.grey.withOpacity(0.05),
//           ),
//           padding: EdgeInsets.only(
//             top: widget.paymentHeight * 0.01,
//             left: widget.paymentWidth * 0.01,
//             right: widget.paymentWidth * 0.02,
//             bottom: widget.paymentHeight * 0.02,
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 // color: Colors.red,
//                 width: widget.paymentWidth * 0.5,
//                 // height: paymentHeight * 0.11,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: widget.paymentWidth * 0.3,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               // GestureDetector(
//                               //   onTap: context
//                               //           .watch<SOCon>()
//                               //           .getScanneditemData2
//                               //           .isNotEmpty
//                               //       ? null
//                               //       : () {
//                               //           context
//                               //               .watch<SOCon>()
//                               //               .checkstocksetqty();
//                               //         },
//                               //   child:
//                               SizedBox(
//                                 width: widget.paymentWidth * 0.18,
//                                 child: Text(
//                                   "Total Items",
//                                   style: widget.theme.textTheme.bodyMedium
//                                       ?.copyWith(),
//                                 ),
//                               ),
//                               // ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<SOCon>()
//                                           .getScanneditemData2
//                                           .isNotEmpty
//                                       ? context.watch<SOCon>().totalPayment2 ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )
//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<SOCon>()
//                                                   .getScanneditemData2
//                                                   .length
//                                                   .toString(),
//                                               // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())
//                                       : context
//                                                   .watch<SOCon>()
//                                                   .getScanneditemData.isEmpty
//                                           ? Text(
//                                               "0",
//                                             )
//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<SOCon>()
//                                                   .getScanneditemData
//                                                   .length
//                                                   .toString(),
//                                               // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               SizedBox(
//                                 width: widget.paymentWidth * 0.18,
//                                 child: Text(
//                                   "Total Quantity",
//                                   style: widget.theme.textTheme.bodyMedium
//                                       ?.copyWith(),
//                                 ),
//                               ),
//                               Container(
//                                   width: widget.paymentWidth * 0.1,
//                                   alignment: Alignment.centerRight,
//                                   child: context
//                                           .watch<SOCon>()
//                                           .getScanneditemData2
//                                           .isNotEmpty
//                                       ? context.watch<SOCon>().totalPayment2 ==
//                                               null
//                                           ? Text(
//                                               "0",
//                                             )

//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<SOCon>()
//                                                   .totalPayment2!
//                                                   .total!
//                                                   .toString(),

//                                               // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith())
//                                       : context.watch<SOCon>().totalPayment ==
//                                                   null ||
//                                               context
//                                                       .watch<SOCon>()
//                                                       .getScanneditemData.isEmpty
//                                           ? Text(
//                                               "0",
//                                             )

//                                           // Container()
//                                           : Text(
//                                               context
//                                                   .watch<SOCon>()
//                                                   .totalPayment!
//                                                   .total!
//                                                   .toString(),

//                                               // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
//                                               style: widget
//                                                   .theme.textTheme.bodyMedium
//                                                   ?.copyWith()))
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     context.watch<SOCon>().getScanneditemData2.isNotEmpty
//                         ? Container(
//                             alignment: Alignment.center,
//                             width: widget.paymentWidth * 0.5,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,

//                               borderRadius: BorderRadius.circular(3),
//                               // color: Colors.grey.withOpacity(0.01),
//                             ),
//                             child: TextFormField(
//                               controller:
//                                   context.watch<SOCon>().mycontroller2[50],
//                               cursorColor: Colors.grey,
//                               style:
//                                   widget.theme.textTheme.bodyMedium?.copyWith(),
//                               onChanged: (v) {},
//                               readOnly: true,
//                               decoration: InputDecoration(
//                                 filled: false,
//                                 labelText: "Remarks",
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 10,
//                                 ),
//                               ),
//                             ),
//                           )
//                         : Container(
//                             alignment: Alignment.center,
//                             width: widget.paymentWidth * 0.5,
//                             decoration: BoxDecoration(
//                               // color: Colors.red,

//                               borderRadius: BorderRadius.circular(3),
//                               // color: Colors.grey.withOpacity(0.01),
//                             ),
//                             child: TextFormField(
//                               controller:
//                                   context.watch<SOCon>().remarkcontroller3,
//                               cursorColor: Colors.grey,
//                               style:
//                                   widget.theme.textTheme.bodyMedium?.copyWith(),
//                               onChanged: (v) {},
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return ' Please Enter the Remark';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               decoration: InputDecoration(
//                                 hintText: "Remarks",
//                                 filled: false,
//                                 focusedErrorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.red),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                   borderSide: BorderSide(color: Colors.grey),
//                                 ),
//                                 contentPadding: const EdgeInsets.symmetric(
//                                   vertical: 5,
//                                   horizontal: 10,
//                                 ),
//                               ),
//                             ),
//                           ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 // color: Colors.green,
//                 width: widget.paymentWidth * 0.45,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Discount",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.yellow,
//                           width: widget.paymentWidth * 0.25,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<SOCon>()
//                                   .getScanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<SOCon>().totalPayment2 == null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment2!.discount!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<SOCon>().totalPayment == null ||
//                                       context
//                                               .watch<SOCon>()
//                                               .getScanneditemData.isEmpty
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment!.discount!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Sub Total",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.yellow,
//                           width: widget.paymentWidth * 0.25,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<SOCon>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<SOCon>().totalPayment2 == null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment2!.subtotal!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<SOCon>().totalPayment == null ||
//                                       context
//                                           .watch<SOCon>()
//                                           .getScanneditemData
//                                           .isEmpty
//                                   ? Text("0.00")
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment!.subtotal!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           // color: Colors.red,
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Total Tax",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.red,
//                           // color: Colors.yellow,
//                           width: widget.paymentWidth * 0.25,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<SOCon>()
//                                   .getScanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<SOCon>().totalPayment2 == null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment2!.totalTX!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<SOCon>().totalPayment == null ||
//                                       context
//                                               .watch<SOCon>()
//                                               .getScanneditemData.isEmpty
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment!.totalTX!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           alignment: Alignment.centerLeft,
//                           width: widget.paymentWidth * 0.15,
//                           child: Text(
//                             "Total Due",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.yellow,
//                           width: widget.paymentWidth * 0.25,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<SOCon>()
//                                   .getScanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<SOCon>().totalPayment2 == null
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment2!.totalDue!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                               : context.watch<SOCon>().totalPayment == null ||
//                                       context
//                                               .watch<SOCon>()
//                                               .getScanneditemData.isEmpty
//                                   ? Container(
//                                       child: Text("0.00"),
//                                     )
//                                   : Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().totalPayment!.totalDue!.toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     ),
//                         )
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Total Paid",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(),
//                           ),
//                         ),
//                         Container(
//                           // color: Colors.yellow,
//                           width: widget.paymentWidth * 0.25,
//                           alignment: Alignment.centerRight,
//                           child: context
//                                   .watch<SOCon>()
//                                   .scanneditemData2
//                                   .isNotEmpty
//                               ? context.watch<SOCon>().totalPayment2 != null
//                                   ? Text(
//                                       "${context.watch<SOCon>().config.splitValues(context.watch<SOCon>().getSumTotalPaid2().toStringAsFixed(0))}",
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                                   : context.watch<SOCon>().tottpaid != null
//                                       ? Text(context
//                                           .watch<SOCon>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<SOCon>().tottpaid!.toStringAsFixed(0)}"))
//                                       : Text("0.00")
//                               : context.watch<SOCon>().totalPayment != null &&
//                                       context
//                                               .watch<SOCon>()
//                                               .getScanneditemData.isNotEmpty
//                                   ? Text(
//                                       context.watch<SOCon>().config.splitValues(
//                                           "${context.watch<SOCon>().getSumTotalPaid().toStringAsFixed(0)}"),
//                                       style: widget.theme.textTheme.bodyMedium
//                                           ?.copyWith(),
//                                     )
//                                   : context.watch<SOCon>().tottpaid != null
//                                       ? Text(context
//                                           .watch<SOCon>()
//                                           .config
//                                           .splitValues(
//                                               "${context.watch<SOCon>().tottpaid!.toStringAsFixed(0)}"))
//                                       : Text("0.00"),
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: widget.paymentWidth * 0.15,
//                           // height: paymentHeight * 0.03,
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             "Balance",
//                             style: widget.theme.textTheme.bodyMedium?.copyWith(
//                                 color: widget.theme.primaryColor, fontSize: 16),
//                           ),
//                         ),
//                         Container(
//                             // color: Colors.yellow,
//                             width: widget.paymentWidth * 0.25,
//                             alignment: Alignment.centerRight,
//                             child: context
//                                     .watch<SOCon>()
//                                     .getScanneditemData2
//                                     .isNotEmpty
//                                 ? context.watch<SOCon>().totalPayment2 != null
//                                     ? Text(
//                                         "${context.watch<SOCon>().totalPayment2!.balance!.toStringAsFixed(0)}",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(),
//                                       )
//                                     : context.watch<SOCon>().tottpaid != null
//                                         ? Text(context
//                                             .watch<SOCon>()
//                                             .config
//                                             .splitValues(
//                                                 "${context.watch<SOCon>().tottpaid!.toStringAsFixed(0)}"))
//                                         : Text("0.00")
//                                 : context.watch<SOCon>().totalPayment != null &&
//                                         context
//                                                 .watch<SOCon>()
//                                                 .getScanneditemData.isNotEmpty
//                                     ? Text(
//                                         context.watch<SOCon>().config.splitValues(
//                                             "${context.watch<SOCon>().getBalancePaid().toStringAsFixed(0)}"),
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(),
//                                       )
//                                     : Text("0.00")),
//                       ],
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ));
//   }
// }

// // // ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';

// // import '../../../Controller/SalesOrderController/SalesOrderController.dart';

// // class SOPaymentDetails extends StatelessWidget {
// //   SOPaymentDetails(
// //       {Key? key,
// //       required this.theme,
// //       required this.paymentHeight,
// //       required this.paymentWidth})
// //       : super(key: key);
// //   final ThemeData theme;
// //   double paymentHeight;
// //   double paymentWidth;

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //         height: paymentHeight,
// //         width: paymentWidth,
// //         padding: EdgeInsets.only(
// //           top: paymentHeight * 0.01,
// //           left: paymentHeight * 0.01,
// //           right: paymentHeight * 0.01,
// //           bottom: paymentHeight * 0.01,
// //         ),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(5),
// //         ),
// //         child: Container(
// //           // height: paymentHeight * 0.35,
// //           decoration: BoxDecoration(
// //             borderRadius: BorderRadius.circular(5),
// //             color: context.watch<SOCon>().getScanneditemData2.isNotEmpty
// //                 ? Colors.grey[300]
// //                 : Colors.grey.withOpacity(0.05),
// //           ),
// //           padding: EdgeInsets.only(
// //             top: paymentHeight * 0.01,
// //             left: paymentHeight * 0.01,
// //             right: paymentHeight * 0.02,
// //             bottom: paymentHeight * 0.02,
// //           ),
// //           child: Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               SizedBox(
// //                 width: paymentWidth * 0.6,
// //                 // height: paymentHeight * 0.11,
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     SizedBox(
// //                       width: paymentWidth * 0.3,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         crossAxisAlignment: CrossAxisAlignment.start,
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               GestureDetector(
// //                                 onTap: context
// //                                         .watch<SOCon>()
// //                                         .getScanneditemData2
// //                                         .isNotEmpty
// //                                     ? null
// //                                     : () {
// //                                         context
// //                                             .watch<SOCon>()
// //                                             .checkstocksetqty();
// //                                       },
// //                                 child: SizedBox(
// //                                   width: paymentWidth * 0.18,
// //                                   child: Text(
// //                                     "Total Items",
// //                                     style: theme.textTheme.bodyMedium
// //                                         ?.copyWith(),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Container(
// //                                   width: paymentWidth * 0.1,
// //                                   alignment: Alignment.centerRight,
// //                                   child: context
// //                                           .watch<SOCon>()
// //                                           .getScanneditemData2
// //                                           .isNotEmpty
// //                                       ? context.watch<SOCon>().totalPayment2 ==
// //                                               null
// //                                           ? Text(
// //                                               "0",
// //                                             )
// //                                           // Container()
// //                                           : Text(
// //                                               context
// //                                                   .watch<SOCon>()
// //                                                   .getScanneditemData2
// //                                                   .length
// //                                                   .toString(),
// //                                               // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith())
// //                                       : context.watch<SOCon>().totalPayment ==
// //                                               null
// //                                           ? Text(
// //                                               "0",
// //                                             )
// //                                           // Container()
// //                                           : Text(
// //                                               context
// //                                                   .watch<SOCon>()
// //                                                   .getScanneditemData
// //                                                   .length
// //                                                   .toString(),
// //                                               // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith())),
// //                             ],
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               SizedBox(
// //                                 width: paymentWidth * 0.18,
// //                                 child: GestureDetector(
// //                                   onTap: () {
// //                                     context.watch<SOCon>().viewdetails();
// //                                   },
// //                                   child: Text(
// //                                     "Total Quantity",
// //                                     style: theme.textTheme.bodyMedium
// //                                         ?.copyWith(),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Container(
// //                                   width: paymentWidth * 0.1,
// //                                   alignment: Alignment.centerRight,
// //                                   child: context
// //                                           .watch<SOCon>()
// //                                           .scanneditemData2
// //                                           .isNotEmpty
// //                                       ? context.watch<SOCon>().totalPayment2 ==
// //                                               null
// //                                           ? Text(
// //                                               "0",
// //                                             )

// //                                           // Container()
// //                                           : Text(
// //                                               context
// //                                                   .watch<SOCon>()
// //                                                   .totalPayment2!
// //                                                   .total!
// //                                                   .toString(),

// //                                               // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith())
// //                                       : context.watch<SOCon>().totalPayment ==
// //                                               null
// //                                           ? Text(
// //                                               "0",
// //                                             )

// //                                           // Container()
// //                                           : Text(
// //                                               context
// //                                                   .watch<SOCon>()
// //                                                   .totalPayment!
// //                                                   .total
// //                                                   .toString(),

// //                                               // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith()))
// //                             ],
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               SizedBox(
// //                                 width: paymentWidth * 0.18,
// //                                 child: Text(
// //                                   "Total Weight",
// //                                   style: theme.textTheme.bodyMedium,
// //                                 ),
// //                               ),
// //                               Container(
// //                                   width: paymentWidth * 0.1,
// //                                   alignment: Alignment.centerRight,
// //                                   child: context
// //                                           .watch<SOCon>()
// //                                           .scanneditemData2
// //                                           .isNotEmpty
// //                                       ? Text(
// //                                           "${context.watch<SOCon>().totwieght!.toStringAsFixed(2)}Kg",
// //                                           // prdPmt.config.splitValues(
// //                                           //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                           style: theme.textTheme.bodyMedium
// //                                               ?.copyWith())

// //                                       // Container()
// //                                       : context
// //                                               .watch<SOCon>()
// //                                               .scanneditemData
// //                                               .isNotEmpty
// //                                           ? Text(
// //                                               "${context.watch<SOCon>().totalWeight().toStringAsFixed(2)}Kg",
// //                                               // prdPmt.config.splitValues(
// //                                               //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith())
// //                                           : Text("0.00",
// //                                               // prdPmt.config.splitValues(
// //                                               //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith()))
// //                             ],
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               SizedBox(
// //                                 width: paymentWidth * 0.18,
// //                                 child: Text(
// //                                   "Total Ltr",
// //                                   style: theme.textTheme.bodyMedium
// //                                       ?.copyWith(),
// //                                 ),
// //                               ),
// //                               Container(
// //                                   width: paymentWidth * 0.1,
// //                                   alignment: Alignment.centerRight,
// //                                   child: context
// //                                           .watch<SOCon>()
// //                                           .scanneditemData2
// //                                           .isNotEmpty
// //                                       ? Text(
// //                                           "${context.watch<SOCon>().totLiter!.toStringAsFixed(2)}",
// //                                           // prdPmt.config.splitValues(
// //                                           //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                           style: theme.textTheme.bodyMedium
// //                                               ?.copyWith())

// //                                       // Container()
// //                                       : context
// //                                               .watch<SOCon>()
// //                                               .scanneditemData
// //                                               .isNotEmpty
// //                                           ? Text(
// //                                               "${context.watch<SOCon>().totalLiter().toStringAsFixed(2)}",
// //                                               // prdPmt.config.splitValues(
// //                                               //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith())
// //                                           : Text("0.00",
// //                                               // prdPmt.config.splitValues(
// //                                               //     "${prdPmt.totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                               style: theme.textTheme.bodyMedium
// //                                                   ?.copyWith()))
// //                             ],
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     context.watch<SOCon>().scanneditemData2.isNotEmpty
// //                         ? Container(
// //                             alignment: Alignment.center,
// //                             width: paymentWidth * 1,
// //                             decoration: BoxDecoration(
// //                               // color: Colors.red,

// //                               borderRadius: BorderRadius.circular(3),
// //                               // color: Colors.grey.withOpacity(0.01),
// //                             ),
// //                             child: TextFormField(
// //                               controller:
// //                                   context.watch<SOCon>().mycontroller2[50],
// //                               cursorColor: Colors.grey,
// //                               style:
// //                                   theme.textTheme.bodyMedium?.copyWith(),
// //                               onChanged: (v) {},
// //                               watchOnly: true,
// //                               decoration: InputDecoration(
// //                                 // hintText: "Remarks",
// //                                 filled: false,
// //                                 labelText: "Remarks",

// //                                 focusedErrorBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.red),
// //                                 ),
// //                                 errorBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.red),
// //                                 ),
// //                                 enabledBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.grey),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.grey),
// //                                 ),
// //                                 contentPadding: const EdgeInsets.symmetric(
// //                                   vertical: 5,
// //                                   horizontal: 10,
// //                                 ),
// //                               ),
// //                             ),
// //                           )
// //                         : Container(
// //                             alignment: Alignment.center,
// //                             width: paymentWidth * 1,
// //                             decoration: BoxDecoration(
// //                               // color: Colors.red,

// //                               borderRadius: BorderRadius.circular(3),
// //                               // color: Colors.grey.withOpacity(0.01),
// //                             ),
// //                             child: TextFormField(
// //                               controller:
// //                                   context.watch<SOCon>().mycontroller[50],
// //                               cursorColor: Colors.grey,
// //                               style:
// //                                   theme.textTheme.bodyMedium?.copyWith(),
// //                               onChanged: (v) {},
// //                               validator: (value) {
// //                                 if (value!.isEmpty) {
// //                                   return ' Please Enter the Remark';
// //                                 } else {
// //                                   return null;
// //                                 }
// //                               },
// //                               decoration: InputDecoration(
// //                                 hintText: "Remarks",
// //                                 filled: false,
// //                                 focusedErrorBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.red),
// //                                 ),
// //                                 errorBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.red),
// //                                 ),
// //                                 enabledBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.grey),
// //                                 ),
// //                                 focusedBorder: OutlineInputBorder(
// //                                   borderRadius: BorderRadius.circular(5),
// //                                   borderSide: BorderSide(color: Colors.grey),
// //                                 ),
// //                                 contentPadding: const EdgeInsets.symmetric(
// //                                   vertical: 5,
// //                                   horizontal: 10,
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                   ],
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: paymentWidth * 0.35,
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           width: paymentWidth * 0.15,
// //                           alignment: Alignment.centerLeft,
// //                           child: Text(
// //                             "Discount",
// //                             style:
// //                                 theme.textTheme.bodyMedium?.copyWith(),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: paymentWidth * 0.17,
// //                           alignment: Alignment.centerRight,
// //                           child: context
// //                                   .watch<SOCon>()
// //                                   .scanneditemData2
// //                                   .isNotEmpty
// //                               ? context.watch<SOCon>().totalPayment2 == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment2!.discount!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                               : context.watch<SOCon>().totalPayment == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment!.discount!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           width: paymentWidth * 0.15,
// //                           // height: paymentHeight * 0.03,
// //                           alignment: Alignment.centerLeft,
// //                           child: Text(
// //                             "Sub Total",
// //                             style:
// //                                 theme.textTheme.bodyMedium?.copyWith(),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: paymentWidth * 0.17,
// //                           alignment: Alignment.centerRight,
// //                           child: context
// //                                   .watch<SOCon>()
// //                                   .scanneditemData2
// //                                   .isNotEmpty
// //                               ? context.watch<SOCon>().totalPayment2 == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment2!.subtotal!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                               : context.watch<SOCon>().totalPayment == null
// //                                   ? Text("0.00")
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment!.subtotal!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           // color: Colors.red,
// //                           width: paymentWidth * 0.15,
// //                           // height: paymentHeight * 0.03,
// //                           alignment: Alignment.centerLeft,
// //                           child: Text(
// //                             "Total Tax",
// //                             style:
// //                                 theme.textTheme.bodyMedium?.copyWith(),
// //                           ),
// //                         ),
// //                         Container(
// //                           // color: Colors.red,
// //                           width: paymentWidth * 0.17,
// //                           alignment: Alignment.centerRight,
// //                           child: context
// //                                   .watch<SOCon>()
// //                                   .scanneditemData2
// //                                   .isNotEmpty
// //                               ? context.watch<SOCon>().totalPayment2 == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment2!.totalTX!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                               : context.watch<SOCon>().totalPayment == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment!.totalTX!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     ),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           alignment: Alignment.centerLeft,
// //                           width: paymentWidth * 0.15,
// //                           child: Text(
// //                             "Total Due",
// //                             style:
// //                                 theme.textTheme.bodyMedium?.copyWith(),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: paymentWidth * 0.17,
// //                           alignment: Alignment.centerRight,
// //                           child: context
// //                                   .watch<SOCon>()
// //                                   .scanneditemData2
// //                                   .isNotEmpty
// //                               ? context.watch<SOCon>().totalPayment2 == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment2!.totalDue!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                               : context.watch<SOCon>().totalPayment == null
// //                                   ? Container(
// //                                       child: Text("0.00"),
// //                                     )
// //                                   : Text(
// //                                       context.watch<SOCon>().config.splitValues(
// //                                           "${context.watch<SOCon>().totalPayment!.totalDue!.toStringAsFixed(2)}"),
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     ),
// //                         )
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           width: paymentWidth * 0.15,
// //                           // height: paymentHeight * 0.03,
// //                           alignment: Alignment.centerLeft,
// //                           child: Text(
// //                             "Total Paid",
// //                             style:
// //                                 theme.textTheme.bodyMedium?.copyWith(),
// //                           ),
// //                         ),
// //                         Container(
// //                           width: paymentWidth * 0.17,
// //                           alignment: Alignment.centerRight,
// //                           child: context
// //                                   .watch<SOCon>()
// //                                   .scanneditemData2
// //                                   .isNotEmpty
// //                               ? context.watch<SOCon>().totalPayment2 != null
// //                                   ? Text(
// //                                       "${context.watch<SOCon>().getSumTotalPaid2().toStringAsFixed(2)}",
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                                   : context.watch<SOCon>().tottpaid != null
// //                                       ? Text(context
// //                                           .watch<SOCon>()
// //                                           .config
// //                                           .splitValues(
// //                                               "${context.watch<SOCon>().tottpaid!.toStringAsFixed(2)}"))
// //                                       : Text("0.00")
// //                               : context.watch<SOCon>().totalPayment != null
// //                                   ? Text(
// //                                       "${context.watch<SOCon>().getSumTotalPaid().toStringAsFixed(2)}",
// //                                       style: theme.textTheme.bodyMedium
// //                                           ?.copyWith(),
// //                                     )
// //                                   : context.watch<SOCon>().tottpaid != null
// //                                       ? Text(context
// //                                           .watch<SOCon>()
// //                                           .config
// //                                           .splitValues(
// //                                               "${context.watch<SOCon>().tottpaid!.toStringAsFixed(2)}"))
// //                                       : Text("0.00"),
// //                         ),
// //                       ],
// //                     ),
// //                     Row(
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Container(
// //                           width: paymentWidth * 0.15,
// //                           // height: paymentHeight * 0.03,
// //                           alignment: Alignment.centerLeft,
// //                           child: Text(
// //                             "Balance",
// //                             style: theme.textTheme.bodyMedium?.copyWith(
// //                                 color: theme.primaryColor, fontSize: 16),
// //                           ),
// //                         ),
// //                         Container(
// //                             width: paymentWidth * 0.17,
// //                             alignment: Alignment.centerRight,
// //                             child: context
// //                                     .watch<SOCon>()
// //                                     .scanneditemData2
// //                                     .isNotEmpty
// //                                 ? context.watch<SOCon>().totalPayment2 != null
// //                                     ? Text(
// //                                         "${context.watch<SOCon>().totalPayment2!.balance!.toStringAsFixed(2)}",
// //                                         style: theme.textTheme.bodyMedium
// //                                             ?.copyWith(),
// //                                       )
// //                                     : context.watch<SOCon>().tottpaid != null
// //                                         ? Text(context
// //                                             .watch<SOCon>()
// //                                             .config
// //                                             .splitValues(
// //                                                 "${context.watch<SOCon>().tottpaid!.toStringAsFixed(2)}"))
// //                                         : Text("0.00")
// //                                 : context.watch<SOCon>().totalPayment != null
// //                                     ? Text(
// //                                         context.watch<SOCon>().config.splitValues(
// //                                             "${context.watch<SOCon>().getBalancePaid().toStringAsFixed(2)}"),
// //                                         style: theme.textTheme.bodyMedium
// //                                             ?.copyWith(),
// //                                       )
// //                                     : Text("0.00")
// //                             // : prdPmt.baltopay != null
// //                             //     ? Text("${prdPmt.baltopay}")
// //                             //     : Container(
// //                             //         child: Text("0.00"),
// //                             //       )
// //                             ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               )
// //             ],
// //           ),
// //         ));
// //   }
// // }
