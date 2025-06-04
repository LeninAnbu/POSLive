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
            
            
//               width: widget.searchWidth * 1,
//             
//               child: SingleChildScrollView(
//                 child: Column(
//                 
//                   children: [
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(" Pending Inwards",
                            
                            
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
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
//                                           itemCount: context
//                                               .watch<StockInwrdController>()
//                                               .stockInward
//                                               .length,
//                                           itemBuilder: (context, index) {
//                                             return InkWell(
//                                               onTap: () {
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              
                                              
//                                               },
//                                               child: Card(
//                                                 child: Container(
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
                                                
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
