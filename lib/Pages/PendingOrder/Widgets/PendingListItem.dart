// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../Controller/PendingOrderController/PendingOrderController.dart';

// class PendingListItem extends StatefulWidget {
//   PendingListItem({
//     super.key,
//     required this.theme,
//     required this.btnWidth,
//     required this.btnheight,
//   
//   });

//   final ThemeData theme;
//   double btnheight;
//   double btnWidth;
// 

//   @override
//   State<PendingListItem> createState() => _PendingListItemState();
// }

// class _PendingListItemState extends State<PendingListItem> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Pending Order Items'),
//         centerTitle: true,
//         automaticallyImplyLeading: true,
//         backgroundColor: widget.theme.primaryColor,
//       ),
//       body: SafeArea(
//         child: Container(
//         
//           padding: EdgeInsets.all(
//             widget.btnheight * 0.02,
//           ),
//         
//         
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(
//                   width: widget.btnWidth * 1,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey[300]!),
//                     borderRadius: const BorderRadius.all(Radius.circular(5)),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.white.withOpacity(0.3), //color of shadow
//                         spreadRadius: 3, //spread radius
//                         blurRadius: 2, // blur radius
//                         offset:
//                             const Offset(0, 2), // changes position of shadow
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: context
//                         .read<PendingOrderController>()
//                         .searchcontroller[1],
//                     style: widget.theme.textTheme.bodyMedium!
//                         .copyWith(color: Colors.black),

//                     onChanged: (val) {
//                       setState(() {
//                         context
//                             .read<PendingOrderController>()
//                             .filterListItem(val);
//                       });
//                     },
//                     onEditingComplete: () {},
//                   
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.all(8),
//                       hintText: "Search here..!!",
//                       hintStyle: widget.theme.textTheme.bodyMedium!
//                           .copyWith(color: const Color(0xFF757575)),
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         icon: const Icon(
//                           Icons.search,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(color: Colors.white),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(30),
//                         borderSide: const BorderSide(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: widget.btnheight * 0.05,
//                 ),
//                 context
//                         .read<PendingOrderController>()
//                         .filterOrderdatas!
//                         .isNotEmpty
//                     ? Column(
//                         children: [
//                           Container(
//                               height: widget.btnheight * 0.19,
//                               padding: EdgeInsets.only(
//                                 left: widget.btnWidth * 0.02,
//                                 right: widget.btnWidth * 0.02,
//                               ),
//                               color: widget.theme.primaryColor,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   SizedBox(
//                                     width: widget.btnWidth * 0.15,
//                                     child: Text("Item Code",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: Colors.white,
//                                         )),
//                                   ),
//                                   Container(
//                                   
//                                     alignment: Alignment.center,
//                                     width: widget.btnWidth * 0.9,

//                                     child: Text("Item Name",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: Colors.white,
//                                         )),
//                                   ),
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
//                                   Container(
//                                     width: widget.btnWidth * 0.15,
//                                     alignment: Alignment.center,
//                                     child: Text("S.O Qty",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: Colors.white,
//                                         )),
//                                   ),
//                                   SizedBox(
//                                     width: widget.btnWidth * 0.15,
//                                     child: Text(" Balance Qty",
//                                         style: widget.theme.textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: Colors.white,
//                                         )),
//                                   ),
//                                 ],
//                               )),
//                           SizedBox(
//                           
//                             height: widget.btnheight * 3,

//                           
//                             child: ListView.builder(
//                                 itemCount: context
//                                     .watch<PendingOrderController>()
//                                     .filterOrderdatas!
//                                     .length,
//                                 itemBuilder: (context, index) {
//                                   return Card(
//                                     
//                                       child: Container(
//                                     padding: const EdgeInsets.all(6),
//                                     width: widget.btnWidth * 11,
//                                     height: widget.btnheight * 0.25,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                             width: widget.btnWidth * 0.18,
//                                           
//                                             child: Text(
//                                               context
//                                                   .watch<
//                                                       PendingOrderController>()
//                                                   .filterOrderdatas![index]
//                                                   .itemCode
//                                                   .toString(),
//                                               style: widget
//                                                   .theme.textTheme.bodyLarge!
//                                                   .copyWith(),
//                                             )),
//                                         Container(
//                                             alignment: Alignment.center,

//                                           
//                                             width: widget.btnWidth * 0.9,
//                                             child: Text(
//                                               context
//                                                   .watch<
//                                                       PendingOrderController>()
//                                                   .filterOrderdatas![index]
//                                                   .itemname
//                                                   .toString(),
//                                               style: widget
//                                                   .theme.textTheme.bodyLarge!
//                                                   .copyWith(),
//                                             )),
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
//                                       
//                                       
//                                       
//                                       
//                                         Container(
//                                             alignment: Alignment.center,
//                                           
//                                             width: widget.btnWidth * 0.15,
//                                             child: Text(
//                                               context
//                                                   .watch<
//                                                       PendingOrderController>()
//                                                   .filterOrderdatas![index]
//                                                   .totalQty
//                                                   .toString(),
//                                               style: widget
//                                                   .theme.textTheme.bodyLarge!
//                                                   .copyWith(),
//                                             )),

//                                         Container(
//                                             alignment: Alignment.center,
//                                           
//                                             width: widget.btnWidth * 0.15,
//                                             child: Text(
//                                               context
//                                                   .watch<
//                                                       PendingOrderController>()
//                                                   .filterOrderdatas![index]
//                                                   .balQty
//                                                   .toString(),
//                                               style: widget
//                                                   .theme.textTheme.bodyLarge!
//                                                   .copyWith(),
//                                             )),
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
//                                       
//                                       
//                                       
//                                       
//                                       
//                                       ],
//                                     ),
//                                   ));
//                                 }),
//                           ),
//                         ],
//                       )
//                     : Container(),
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
//               
//               
//               
//               
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
