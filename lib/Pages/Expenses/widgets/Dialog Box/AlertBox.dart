// // ignore_for_file: prefer_const_constructors, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:posbillingdesign/Constant/Screen.dart';

// class ExpAlertBox extends StatefulWidget {
//   ExpAlertBox(
//       {super.key,
//       required this.payMent,
//       required this.widget,
//       required this.buttonName,
//       this.errormsg,
//       this.callback});
//   String payMent;
//   Widget widget;
//   String? buttonName;
//   VoidCallback? callback;
//   bool? errormsg;

//   @override
//   State<ExpAlertBox> createState() => _ExpAlertBoxState();
// }

// class _ExpAlertBoxState extends State<ExpAlertBox> {
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SingleChildScrollView(
//       child: Container(
//          color: Colors.white,
//         
//           child: Column(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//             Container(
//               alignment: Alignment.center,
//               height: Screens.padingHeight(context) * 0.045,
//               decoration: BoxDecoration(
//                   color:
//                       widget.errormsg == true ? Colors.red : theme.primaryColor),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: Screens.padingHeight(context) * 0.02,
//                         right: Screens.padingHeight(context) * 0.02),
//                   
//                     width: Screens.width(context) * 0.4,
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       widget.payMent,
//                       style: theme.textTheme.bodyMedium
//                           ?.copyWith(color: Colors.white),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         Icons.close,
//                         size: Screens.padingHeight(context) * 0.025,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),

//             widget.widget,
//         SizedBox(height: Screens.padingHeight(context) * 0.02),
//             widget.buttonName != null
//                 ? AlertBtnSave(
//                     theme: theme,
//                     buttonName: widget.buttonName,
//                     callback: widget.callback)
//                 : Container()
//           ])),
//     );
//   }
// }

// class AlertBtnSave extends StatelessWidget {
//   AlertBtnSave(
//       {Key? key,
//       required this.theme,
//       required this.buttonName,
//       required this.callback})
//       : super(key: key);

//   final ThemeData theme;
//   String? buttonName;
//   VoidCallback? callback;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: callback,
//       child: Container(
//         alignment: Alignment.center,
//         height: Screens.padingHeight(context) * 0.045,
//         decoration: BoxDecoration(
//           color: theme.primaryColor,
//         
//         
//         ),
//         child: Center(
//           child: Container(
//             alignment: Alignment.center,
//             child: Text(
//               buttonName!,
//               textAlign: TextAlign.center,
//               style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
