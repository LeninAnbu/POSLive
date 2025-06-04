// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'package:flutter/material.dart';
// import 'package:posbillingdesign/Constant/Screen.dart';
// import 'package:posbillingdesign/Controller/SalesInvoice/SalesInvoiceController.dart';
// import 'package:posbillingdesign/Models/DataModel/StockInwardModel/StockInwardListModel.dart';
// import 'package:posbillingdesign/Pages/Sales%20Screen/Widgets/Dialog%20Box/AlertBox.dart';

// import '../../../Controller/StockInwardController/StockInwardController.dart';
// import '../../../Controller/StockOutwardController/StockOutwardController.dart';
// import '../../../Widgets/ContentContainer.dart';
// import 'AlertTapPosBox.dart';

// class StockInwardBottomBtn extends StatelessWidget {
//   StockInwardBottomBtn(
//       {Key? key,
//       required this.theme,
//       required this.btnWidth,
//       required this.btnheight,
//       required this.posController,
//       required this.data})
//       : super(key: key);

//   final ThemeData theme;
//   double btnheight;
//   double btnWidth;
//   final StockInwardController posController;

//   List<StockInwardDetails>? data;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: btnheight * 0.03,
//         left: btnheight * 0.03,
//         right: btnheight * 0.03,
//         bottom: btnheight * 0.03,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(5),
//         color: Colors.white,
//       ),
//       height: btnheight,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           GestureDetector(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     barrierDismissible: true,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                           contentPadding: EdgeInsets.all(0),
//                           content: AlertBox(
//                             payMent: 'Suspended',
//                             widget: forSuspend(),
//                             buttonName: 'Ok',
//                             callback: () {
//                               Navigator.pop(context);
//                             },
//                           ));
//                     });
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: theme.primaryColor,
//                     )),
//                 height: btnheight * 0.9,
//                 width: btnWidth * 0.25,
//                 child: Text("Suspended",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       color: theme.primaryColor,
//                     )),
//               )),
//           GestureDetector(
//               onTap: () {},
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: theme.primaryColor,
//                     )),
//                 height: btnheight * 0.9,
//                 width: btnWidth * 0.25,
//                 child: Text("Hold",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       color: theme.primaryColor,
//                     )),
//               )),
//           GestureDetector(
//               onTap: () {
//                 posController.clearTotal();
//                 posController.SubmitvalidationTabandPos(data, context, theme);
//                 if (posController.trans_Total != posController.scanned_Total&&data!.isEmpty) {
//                   showDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                             contentPadding: EdgeInsets.all(0),
//                             content: AlertBox(
//                                 payMent: 'Alert',
//                                 errormsg: true,
//                                 widget: Center(
//                                     child: ContentContainer(
//                                   content: 'Please Scan All Product..!!',
//                                   theme: theme,
//                                 )),
//                                 buttonName: null));
//                       });
//                 } else if (posController.trans_Total == posController.scanned_Total) {
//                   showDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                             contentPadding: EdgeInsets.all(0),
//                             content: AlertBox(
//                               payMent: '',
//                               errormsg: false,
//                               widget: Center(
//                                   child:StIn_TapAlertbox(
//                                 content: 'Successfully Submit',
//                                 theme: theme,
//                               )),
//                               buttonName: "Ok",
//                               callback: () {
//                                 Navigator.pop(context);
//                               },
//                             ));
//                       });
//                 }
//               },
//               child: Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(
//                   
//                     borderRadius: BorderRadius.circular(5),
//                     border: Border.all(
//                       color: theme.primaryColor,
//                     )),
//                 height: btnheight * 0.9,
//                 width: btnWidth * 0.25,
//                 child: Text("Submit",
//                     style: theme.textTheme.bodyText2?.copyWith(
//                       color: theme.primaryColor,
//                     )),
//               )),
//         ],
//       ),
//     );
//   }

//   forSuspend() {
//     return Container(
//         child: Column(
//       children: [
//         Container(
//             height: btnheight * 0.4,
//             child: Center(
//                 child: Text(
//                     "You about to suspended all information will be unsaved  "))),
//       ],
//     ));
//   }
// }
