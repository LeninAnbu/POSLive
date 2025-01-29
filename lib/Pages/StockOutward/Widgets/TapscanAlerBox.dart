// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:provider/provider.dart';

// import '../../../Constant/Screen.dart';
// import '../../../Controller/StockOutwardController/StockOutwardController.dart';
// import '../../../Models/DataModel/StockOutwardModel/StockOutwardListModel.dart';

// class MyDialog extends StatefulWidget {
//   MyDialog(
//       {Key? key,
//       required this.StOut_Con,
//       required this.datalist,
//       required this.ind,
//       required this.index})
//       : super(key: key);
//   StockOutwardController StOut_Con;
//   StockOutwardDetails? datalist;
//   int? ind;
//   int? index;
//   @override
//   State<MyDialog> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return  Scaffold(
//       body: Container(
//             width: Screens.width(context) * 0.5,
//             child: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: Screens.bodyheight(context) * 0.01,
//                   ),
//                   Container(
//                       alignment: Alignment.center,
//                       width: Screens.width(context) * 1.18,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                             color: Color.fromARGB(255, 207, 201, 201)),
//                         borderRadius: BorderRadius.circular(3),
//                         color: Colors.grey.withOpacity(0.01),
//                       ),
//                       child: TextFormField(
//                         style: theme.textTheme.bodyText2,
//                         cursorColor: Colors.grey,
//                         controller: widget.StOut_Con.StOutController[0],
//                         onEditingComplete: () {
//                           // setState(() {
//                           //   widget.StOut_Con.scanmethod(widget.index!,
//                           //       widget.datalist!.serialBatch!, widget.ind!);
                                
//                           //   widget.StOut_Con.disableKeyBoard(context);
//                             // widget.StOut_Con.scanmethod(widget.index, widget.datalist!.serialBatch!, ind!,);
//                             // widget.StOut_Con.scan3(widget.datalist,
//                             //     widget.StOut_Con.StOutController[0].text, Stock_i, StList_i);
//                          // });
//                         },
//                         onChanged: (v) {
//                           if (v.isNotEmpty) {
//                             setState(() {
//                               widget.StOut_Con.msg = "";
//                             });
//                           }
//                         },
//                         decoration: InputDecoration(
//                           filled: false,
//                           hintText: 'Scan Here..',
//                           hintStyle: theme.textTheme.bodyText2?.copyWith(
//                               //  color: Colors.grey
//                               //   fontWeight: FontWeight.normal
//                               ),
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           contentPadding: const EdgeInsets.symmetric(
//                             vertical: 15,
//                             horizontal: 10,
//                           ),
//                         ),
//                       )),
//                   Row(
//                     children: [
//                       Text(
//                         "  ${widget.StOut_Con.msg}",
//                         style: theme.textTheme.bodySmall!
//                             .copyWith(color: Colors.red),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: Screens.bodyheight(context) * 0.008),
//                   Container(
//                     width: Screens.width(context) * 1.18,
//                     height: Screens.bodyheight(context) * 0.6,
//                     // color: Colors.red,
//                     child: widget.datalist!.serialbatchList == null
//                         ? Center(
//                             child: Text("Scan Item.."),
//                           )
//                         : ListView.builder(
//                             itemCount: widget.datalist!.serialbatchList!.length,
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, i) {
//                               return Card(
//                                 child: Container(
//                                   padding: EdgeInsets.only(
//                                     top: Screens.bodyheight(context) * 0.01,
//                                     left: Screens.bodyheight(context) * 0.01,
//                                     right: Screens.bodyheight(context) * 0.01,
//                                     bottom: Screens.bodyheight(context) * 0.01,
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color:
//                                           //  widget.datalist.serialbatchList![i].scanbool ==
//                                           //         true
//                                           //     ? Color(0xFFebfaef)
//                                           //     :
//                                           Colors.white,
//                                       border: Border.all(
//                                           color:
//                                               // widget.datalist.serialbatchList![i].scanbool ==
//                                               //         true
//                                               //     ? Colors.green.withOpacity(0.3)
//                                               //     :
//                                               Colors.white),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 3,
//                                           blurRadius: 7,
//                                           offset: Offset(0,
//                                               3), // changes position of shadow
//                                         ),
//                                       ]),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Container(
//                                               // color: Colors.amber,

//                                               width:
//                                                   Screens.width(context) * 0.2,
//                                               child: Text(
//                                                 "${widget.datalist!.serialbatchList![i].itemcode}",
//                                                 style:
//                                                     theme.textTheme.bodyMedium,
//                                               ),
//                                             ),
//                                             // Container(
//                                             //   alignment: Alignment.center,
//                                             //   // color: Colors.amber,
//                                             //   width:  Screens.width(context) * 0.35,
//                                             //   child: Text(
//                                             //     "${widget.datalist.serialbatchList![i].docentry}",
//                                             //     style: theme.textTheme.bodyMedium,
//                                             //   ),
//                                             // ),
//                                             Container(
//                                               alignment: Alignment.centerRight,
//                                               // color: Colors.amber,
//                                               width:
//                                                   Screens.width(context) * 0.2,
//                                               child: Text(
//                                                 "${widget.datalist!.serialbatchList![i].serialbatch}",
//                                                 style:
//                                                     theme.textTheme.bodyMedium,
//                                               ),
//                                             ),
//                                           ]),
//                                       Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Container(
//                                             alignment: Alignment.centerLeft,
//                                             // color: Colors.amber,
//                                             width: Screens.width(context) * 0.2,
//                                             child: Text(
//                                               "Scanned Qty : ${widget.datalist!.Scanned_Qty}",
//                                               style: theme.textTheme.bodyMedium,
//                                             ),
//                                           ),
//                                           Container(
//                                               alignment: Alignment.center,
//                                               // color: Colors.amber,
//                                               height:
//                                                   Screens.bodyheight(context) *
//                                                       0.06,
//                                               width:
//                                                   Screens.width(context) * 0.1,
//                                               decoration: BoxDecoration(
//                                                   color: Colors.blue,
//                                                   shape: BoxShape.circle),
//                                               child: IconButton(
//                                                   color: Colors.white,
//                                                   padding: EdgeInsets.zero,
//                                                   iconSize: 18,
//                                                   onPressed: () {
//                                                     setState(() {
//                                                       widget.StOut_Con
//                                                           .scanqtyRemove(
//                                                               widget.index!,
//                                                               widget.ind!,
//                                                               i);
//                                                     });
//                                                   },
//                                                   icon: Icon(Icons.remove))),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             }),
//                   ),
//                   SizedBox(
//                     height: Screens.bodyheight(context) * 0.05,
//                   ),
//                   GestureDetector(
//                       onTap: () {
//                         // widget.StOut_Con.AcceptButton(ind!, widget.index!, context);
//                         widget.StOut_Con.stoutLineRefersh(
//                             widget.index!, widget.ind!);
//                         Navigator.pop(context);
//                         // widget.StOut_Con.AcceptButton(ind!, widget.index, context);
//                         // widget.StOut_Con.AcceptValidation(
//                         //     context, data, datatotal, widget.index, Stock_i);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.only(
//                             top: Screens.bodyheight(context) * 0.01,
//                             left: Screens.bodyheight(context) * 0.02,
//                             right: Screens.bodyheight(context) * 0.02,
//                             bottom: Screens.bodyheight(context) * 0.01),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             // color: Colors.grey[200],
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(
//                               color: theme.primaryColor,
//                             )),
//                         height: Screens.bodyheight(context) * 0.06,
//                         width: Screens.width(context) * 0.4,
//                         child: Text("Accept",
//                             style: theme.textTheme.bodyText2?.copyWith(
//                               color: theme.primaryColor,
//                             )),
//                       )),
//                   SizedBox(
//                     height: Screens.bodyheight(context) * 0.01,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//     );
//   }
// }
