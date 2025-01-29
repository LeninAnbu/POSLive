// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../../Controller/stockInwardController/stockInwardContler.dart';
//commanded by sharmi
// class StockInReqList extends StatefulWidget {
//   StockInReqList(
//       {super.key,
//       required this.theme,
//       required this.searchHeight,
//       required this.searchWidth});

//   final ThemeData theme;
//   double searchHeight;
//   double searchWidth;

//   @override
//   State<StockInReqList> createState() => _StockInReqListState();
// }

// class _StockInReqListState extends State<StockInReqList> {


//   @override
//   Widget build(BuildContext context) {
//     return Provider<StockInwrdController>(
//         create: (_) => StockInwrdController(),
//         builder: (context, child) {
//           return Container(
//               padding: EdgeInsets.only(
//                 top: widget.searchHeight * 0.02,
//                 left: widget.searchHeight * 0.01,
//                 right: widget.searchHeight * 0.01,
//                 bottom: widget.searchHeight * 0.01,
//               ),
              // decoration: BoxDecoration(
              //     color: Colors.white, borderRadius: BorderRadius.circular(5)),
//               width: widget.searchWidth * 1,
//               //  height:searchHeight*0.9 ,
//               child: SingleChildScrollView(
//                 child: Column(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(" Pending Inwards",
                              // style: widget.theme.textTheme.bodyMedium
                              //     ?.copyWith(fontWeight: FontWeight.bold)),
//                           IconButton(
//                               onPressed: () {
//                                 context.read<StockInwrdController>().init();
//                               },
//                               icon: const Icon(Icons.refresh))
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: widget.searchHeight * 0.01,
//                     ),

//                     SizedBox(
//                       height: widget.searchHeight,
                      // child: context
                      //         .watch<StockInwrdController>()
                      //         .stockInward2
                      //         .isNotEmpty
                      //     ? ListView.builder(
                      //         itemCount: context
                      //             .watch<StockInwrdController>()
                      //             .stockInward2
                      //             .length,
                      //         itemBuilder: (context, index) {
                      //           return InkWell(
                      //             onTap: () {},
                      //             child: Card(
                      //               child: Container(
                      //                 padding: EdgeInsets.only(
                      //                     top: widget.searchHeight * 0.01,
                      //                     left: widget.searchHeight * 0.01,
                      //                     right: widget.searchHeight * 0.01,
                      //                     bottom: widget.searchHeight * 0.01),
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.grey[300]),
                      //                 child: Column(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment.start,
                      //                   mainAxisAlignment:
                      //                       MainAxisAlignment.spaceBetween,
                      //                   children: [
                      //                     Text(
                      //                         "Inventory Transfer From ${context.watch<StockInwrdController>().stockInward2[index].reqtoWhs}",
                      //                         style: widget
                      //                             .theme.textTheme.bodyLarge),
                      //                     Row(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.spaceBetween,
                      //                       children: [
                      //                         Text(
                      //                             "# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().stockInward2[index].reqtransdate.toString())}",
                      //                             style: widget.theme.textTheme
                      //                                 .bodyLarge),
                      //                         Text(
                      //                             '${context.watch<StockInwrdController>().stockInward2[index].branch}',
                      //                             style: widget.theme.textTheme
                      //                                 .bodyLarge)
                      //                       ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //             ),
                      //           );
                      //         })
                      //     : context
                      //             .watch<StockInwrdController>()
                      //             .savedraftBill
                      //             .isNotEmpty
                      //         ? Center(
                      //             child: Text(
                      //               "Data Save as Draft Bill..!!",
                      //               style: widget.theme.textTheme.bodyMedium!
                      //                   .copyWith(color: Colors.black),
                      //             ),
                      //           )
                      //         : context
                      //                     .watch<StockInwrdController>()
                      //                     .stockInward
                      //                     .isEmpty &&
                      //                 // context
                      //                 //         .watch<StockInwrdController>()
                      //                 //         .dbDataTrue ==
                      //                 //     true &&
                      //                 context
                      //                     .watch<StockInwrdController>()
                      //                     .savedraftBill
                      //                     .isEmpty
                      //             ? Center(
                      //                 child: Text(
                      //                   "No data From Stock Request..!!",
                      //                   style: widget
                      //                       .theme.textTheme.bodyMedium!
                      //                       .copyWith(color: Colors.black),
                      //                 ),
                      //               )
                      //             : context
                      //                     .watch<StockInwrdController>()
                      //                     .stockInward
                      //                     .isEmpty
                      //                 //     &&
                      //                 // context
                      //                 //         .watch<StockInwrdController>()
                      //                 //         .dbDataTrue ==
                      //                 //     false
                      //                 ? const Center(
                      //                     child: CircularProgressIndicator(),
                      //                   )
                      //                 : ListView.builder(
//                                           itemCount: context
//                                               .watch<StockInwrdController>()
//                                               .stockInward
//                                               .length,
//                                           itemBuilder: (context, index) {
//                                             return InkWell(
//                                               onTap: () {
                                                // context
                                                //     .read<
                                                //         StockInwrdController>()
                                                //     .passData(widget.theme,
                                                //         context, index);
                                                // context
                                                //     .read<
                                                //         StockInwrdController>()
                                                //     .setstatemethod();
//                                               },
//                                               child: Card(
//                                                 child: Container(
                                                  // padding: EdgeInsets.only(
                                                  //     top: widget.searchHeight *
                                                  //         0.01,
                                                  //     left:
                                                  //         widget.searchHeight *
                                                  //             0.01,
                                                  //     right:
                                                  //         widget.searchHeight *
                                                  //             0.01,
                                                  //     bottom:
                                                  //         widget.searchHeight *
                                                  //             0.01),
                                                  // decoration: BoxDecoration(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(
                                                  //             5),
                                                  //     border: Border.all(
                                                  //         color: context
                                                  //                     .watch<
                                                  //                         StockInwrdController>()
                                                  //                     .selectIndex ==
                                                  //                 index
                                                  //             ? Colors.green
                                                  //             : Colors.white)),
//                                                   child: Column(
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment
//                                                             .start,
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                               "Inventory Transfer From ${context.watch<StockInwrdController>().stockInward[index].reqtoWhs}",
//                                                               style: widget
//                                                                   .theme
//                                                                   .textTheme
//                                                                   .bodyLarge),
//                                                           Text(
//                                                               "OutWard  Num: ${context.watch<StockInwrdController>().stockInward[index].documentno}",
//                                                               style: widget
//                                                                   .theme
//                                                                   .textTheme
//                                                                   .bodyLarge),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           Text(
//                                                               "# ${context.watch<StockInwrdController>().config.alignDate(context.watch<StockInwrdController>().stockInward[index].reqtransdate.toString())}",
//                                                               style: widget
//                                                                   .theme
//                                                                   .textTheme
//                                                                   .bodyLarge),
//                                                           Text(
//                                                               'Req Num: ${context.watch<StockInwrdController>().stockInward[index].reqdocumentno}',
//                                                               style: widget
//                                                                   .theme
//                                                                   .textTheme
//                                                                   .bodyLarge)
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           }),
//                     )

// // Container(),
//                   ],
//                 ),
//               ));
//         });
//   }
// }
