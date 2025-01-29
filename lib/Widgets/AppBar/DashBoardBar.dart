import 'package:flutter/material.dart';

AppBar dashbar(String titles, ThemeData theme, BuildContext context) {
  final theme = Theme.of(context);
  // final GlobalKey<ScaffoldState> Key = GlobalKey<ScaffoldState>();

  return AppBar(
    backgroundColor: theme.primaryColor,
    automaticallyImplyLeading: false,
    // centerTitle: true,
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    // toolbarHeight: Screens.padingHeight(context) * 0.08, // Set this height
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titles),
        // Row(
        //   children: [
        //        GestureDetector(
        //           onTap: () {
        //                   showDialog(
        //                       context: context,
        //                       barrierDismissible: true,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                             contentPadding: EdgeInsets.all(0),
        //                             content: AlertBox(
        //                               payMent: 'Draft bills',
        //                               buttonName: null,
        //                               widget: ContentContainer(
        //                                   content: "Draft bills",
        //                                   theme: theme),
        //                             ));
        //                       });
        //                 },
        //       child: Column(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //               decoration: BoxDecoration(
        //                 // color: Colors.white,
        //                 borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(8),
        //                   topLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(8),
        //                   bottomLeft: Radius.circular(8),
        //                 ),
        //               ),
        //               child: Icon(Icons.ballot_outlined)),

        //                   Text('Draft Bills',style: theme.textTheme.bodyText2?.copyWith(color:Colors.white),)
        //         ],
        //       ),
        //     ),

        //       SizedBox(width: Screens.width(context) * 0.02),
        //     GestureDetector(
        //           onTap: () {
        //                   showDialog(
        //                       context: context,
        //                       barrierDismissible: true,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                             contentPadding: EdgeInsets.all(0),
        //                             content: AlertBox(
        //                               payMent: 'Stock Refresh',
        //                               buttonName: null,
        //                               widget: ContentContainer(
        //                                   content: "Stock Refresh",
        //                                   theme: theme),
        //                             ));
        //                       });
        //                 },
        //       child: Column(
        //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(8),
        //                   topLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(8),
        //                   bottomLeft: Radius.circular(8),
        //                 ),
        //               ),
        //               child:

        //                  Icon(Icons.autorenew_outlined)),
        //                   Text("Stock Refresh",style: theme.textTheme.bodyText2?.copyWith(color:Colors.white),)
        //         ],
        //       ),
        //     ),
        //     SizedBox(width: Screens.width(context) * 0.02),
        //     GestureDetector(
        //        onTap: () {
        //                   showDialog(
        //                       context: context,
        //                       barrierDismissible: true,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                             contentPadding: EdgeInsets.all(0),
        //                             content: AlertBox(
        //                               payMent: 'Print',
        //                               buttonName: null,
        //                               widget: ContentContainer(
        //                                   content: "Print", theme: theme),
        //                             ));
        //                       });
        //                 },
        //       child: Column(
        //         children: [
        //           Container(
        //               decoration: BoxDecoration(
        //                 // color: Colors.white,
        //                 borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(8),
        //                   topLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(8),
        //                   bottomLeft: Radius.circular(8),
        //                 ),
        //               ),
        //               child: Icon(Icons.print_outlined)),
        //                   Text('Printers',style: theme.textTheme.bodyText2?.copyWith(color:Colors.white),)
        //         ],
        //       ),
        //     ),
        //     SizedBox(width: Screens.width(context) * 0.02),
        //     GestureDetector(
        //          onTap: () {
        //                   showDialog(
        //                       context: context,
        //                       barrierDismissible: true,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                             contentPadding: EdgeInsets.all(0),
        //                             content: AlertBox(
        //                               payMent: 'Access Til',
        //                               buttonName: null,
        //                               widget: ContentContainer(
        //                                   content: "Access Til", theme: theme),
        //                             ));
        //                       });
        //                 },
        //       child: Column(
        //         children: [
        //           Container(
        //               // width: Screens.width(context) * 0.18,
        //               // height: Screens.padingHeight(context) * 0.06,
        //               decoration: BoxDecoration(
        //                 // color: Colors.white,
        //                 borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(8),
        //                   topLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(8),
        //                   bottomLeft: Radius.circular(8),
        //                 ),
        //               ),
        //               child: Icon(Icons.auto_mode_outlined )),
        //                   Text('Access til',style: theme.textTheme.bodyText2?.copyWith(color:Colors.white),)
        //         ],
        //       ),
        //     ),
        //     SizedBox(width: Screens.width(context) * 0.02),
        //     GestureDetector(
        //        onTap: () {
        //                   showDialog(
        //                       context: context,
        //                       barrierDismissible: true,
        //                       builder: (BuildContext context) {
        //                         return AlertDialog(
        //                             contentPadding: EdgeInsets.all(0),
        //                             content: AlertBox(
        //                               payMent: 'Dual Screen',
        //                               buttonName: null,
        //                               widget: ContentContainer(
        //                                   content: "Dual Screen", theme: theme),
        //                             ));
        //                       });
        //                 },
        //       child: Column(
        //         children: [
        //           Container(
        //               // width: Screens.width(context) * 0.18,
        //               // height: Screens.padingHeight(context) * 0.06,
        //               decoration: BoxDecoration(
        //                 // color: Colors.white,
        //                 borderRadius: BorderRadius.only(
        //                   topRight: Radius.circular(8),
        //                   topLeft: Radius.circular(25),
        //                   bottomRight: Radius.circular(8),
        //                   bottomLeft: Radius.circular(8),
        //                 ),
        //               ),
        //               child: Icon(Icons.screenshot_outlined)),
        //                   Text('Dual Screen',style: theme.textTheme.bodyText2?.copyWith(color:Colors.white))
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
    ),
  );
}
