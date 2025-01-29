import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Pages/StockRequest/Screens/StockMobile/Widgets/M_Draftbill.dart';
import '../../../../../Controller/StockRequestController/StockRequestController.dart';
import '../../../../../Widgets/ContentContainer.dart';
import '../../../../../Widgets/AlertBox.dart';

AppBar appbarSReqMS(String titles, ThemeData theme, BuildContext context,
    {StockReqController? posController}) {
  final theme = Theme.of(context);

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
      ],
    ),

    actions: [
      //list if widget in appbar actions
      PopupMenuButton(itemBuilder: (context) {
        return [
          PopupMenuItem<int>(
            value: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Draft Bills"),
                Icon(
                  Icons.ballot_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Stock Refresh"),
                Icon(
                  Icons.autorenew_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Printers"),
                Icon(
                  Icons.print_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Access Til"),
                Icon(
                  Icons.auto_mode_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
          PopupMenuItem<int>(
            value: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Dual Screen"),
                Icon(
                  Icons.screenshot_outlined,
                  color: theme.primaryColor,
                )
              ],
            ),
          ),
        ];
      }, onSelected: (value) {
        if (value == 0) {
          if (posController!.savedraftBill.isEmpty) {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                      contentPadding: const EdgeInsets.all(0),
                      content: AlertBox(
                        payMent: 'Draft bills',
                        buttonName: null,
                        widget: ContentContainer(
                            content: "Draft bills", theme: theme),
                      ));
                });
          } else {
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      contentPadding: const EdgeInsets.all(0),
                      // backgroundColor: Colors.transparent,
                      insetPadding:
                          EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                      content: AlertBox(
                          payMent: 'Draft bills',
                          buttonName: null,
                          widget: M_StockReqDraftbill(
                              theme: theme,
                              prdsrch: posController,
                              searchHeight: Screens.bodyheight(context) * 0.5,
                              searchWidth: Screens.width(context) * 0.9,
                              stockReq: posController.savedraftBill)));
                }).then((value) => {
                  // Navigator.pop(context)
                });
          }
        } else if (value == 1) {
        } else if (value == 2) {
        } else if (value == 3) {
        } else if (value == 4) {}
      }),
    ],
  );
}


// import 'package:flutter/material.dart';
// import 'package:posproject/Controller/StockRequestController/StockRequestController.dart';
// import 'package:posproject/Pages/Sales%20Screen/Widgets/Dialog%20Box/AlertBox.dart';
// import 'package:posproject/Pages/StockRequest/Screens/StockMobile/Widgets/M_Draftbill.dart';

// import '../../../../../Constant/Screen.dart';
// import '../../../../../Widgets/ContentContainer.dart';

// AppBar StReq_appbar(String titles, ThemeData theme, BuildContext context,StockReqController posController) {
//   final theme = Theme.of(context);
//   final GlobalKey<ScaffoldState> _Key = GlobalKey<ScaffoldState>();

//   return AppBar(
//     backgroundColor: theme.primaryColor,
//     automaticallyImplyLeading: false,
//     centerTitle: true,
//     leading: Builder(
//       builder: (BuildContext context) {
//         return IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             //  _Key.currentState!.openDrawer();
//             Scaffold.of(context).openDrawer();
//           },
//           tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//         );
//       },
//     ),

//     toolbarHeight: Screens.padingHeight(context) * 0.08, // Set this height
//     title: Text(
//       titles,
//       style: theme.textTheme.subtitle1!.copyWith(color: Colors.white),
//     ),
//     actions: [
//       Container(
//         width: Screens.width(context) * 0.1,
//         height: Screens.padingHeight(context) * 0.06,
//         decoration: BoxDecoration(
//           // color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topRight: Radius.circular(8),
//             topLeft: Radius.circular(25),
//             bottomRight: Radius.circular(8),
//             bottomLeft: Radius.circular(8),
//           ),
         
//         ),
//         child: PopupMenuButton(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//           itemBuilder: (ctx) => [
//             PopupMenuItem(
//                 child: Center(
//                     child: IconButton(tooltip:"Draft Bills",
//                       onPressed: (){
//                         print(posController.savedraftBill.length);

//                   if (posController.savedraftBill.isEmpty) {
//                     showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                               contentPadding: EdgeInsets.all(0),
//                               content: AlertBox(
//                                 payMent: 'Draft bills',
//                                 buttonName: null,
//                                 widget: ContentContainer(
//                                     content: "Draft bills", theme: theme),
//                               ));
//                         });
//                   } else {
//                     showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             shape: RoundedRectangleBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(4))),
//                               contentPadding: EdgeInsets.all(0),
//                               // backgroundColor: Colors.transparent,
//                               insetPadding: EdgeInsets.all(
//                                   Screens.bodyheight(context) * 0.02),
//                                content: AlertBox(
//                                   payMent: 'Draft bills',
//                                   buttonName: null,
//                                   widget: M_StockReqDraftbill(
//                                       theme: theme,
//                                       prdsrch: posController,
//                                       searchHeight:
//                                           Screens.bodyheight(context) * 0.5,
//                                       searchWidth:
//                                           Screens.width(context) * 0.9,
//                                       StockReq:
//                                           posController.savedraftBill)));
//                         }).then((value) => {
//                           Navigator.pop(context)
//                         });
//                   }
//                       }, icon: Icon(Icons.ballot_outlined,color: theme.primaryColor,))),value: 1,),
//             PopupMenuItem(
//                 child:Center(
//                     child: IconButton(tooltip:"Stock Refresh",
//                       onPressed: (){}, icon: Icon(Icons.autorenew_outlined,color: theme.primaryColor,))),value: 2),
//             PopupMenuItem(
//                 child: Center(
//                     child: IconButton(tooltip:"Printers",
//                       onPressed: (){}, icon: Icon(Icons.print_outlined,color: theme.primaryColor,))),value: 3),
//             PopupMenuItem(
//                 child: Center(
//                     child: IconButton(tooltip:"Access Til",
//                       onPressed: (){}, icon: Icon(Icons.auto_mode_outlined,color: theme.primaryColor,))),value: 4),
//             PopupMenuItem(
//                 child: Center(
//                     child: IconButton(tooltip:"Dual Screen",
//                       onPressed: (){}, icon: Icon(Icons.screenshot_outlined,color: theme.primaryColor,))),value: 5)
//           ],
//           onSelected: (id) {
//             if (id == 1) {
//              print(posController.savedraftBill.length);

//                   if (posController.savedraftBill.isEmpty) {
//                     showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                               contentPadding: EdgeInsets.all(0),
//                               content: AlertBox(
//                                 payMent: 'Draft bills',
//                                 buttonName: null,
//                                 widget: ContentContainer(
//                                     content: "Draft bills", theme: theme),
//                               ));
//                         });
//                   } else {
//                     showDialog(
//                         context: context,
//                         barrierDismissible: true,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                               contentPadding: EdgeInsets.all(0),
//                               content: AlertBox(
//                                   payMent: 'Draft bills',
//                                   buttonName: null,
//                                   widget: M_StockReqDraftbill(
//                                       theme: theme,
//                                       prdsrch: posController,
//                                       searchHeight:
//                                           Screens.bodyheight(context) * 0.9,
//                                       searchWidth:
//                                           Screens.width(context) * 0.49,
//                                       StockReq:
//                                           posController.savedraftBill)));
//                         });
//                   }
//             }
//             if (id == 2) {
//               // Perform action on click on Upload
//             }
//             if (id == 3) {
//               // Perform action on click on Exit
//             }
//              if (id == 4) {
//               // Perform action on click on Upload
//             }
//             if (id == 5) {
//               // Perform action on click on Exit
//             }
//           },
//         ),
//       )
//     ],
//   );
// }
