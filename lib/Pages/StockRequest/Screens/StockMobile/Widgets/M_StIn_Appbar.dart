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
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(titles),
      ],
    ),
    actions: [
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
                }).then((value) => {});
          }
        } else if (value == 1) {
        } else if (value == 2) {
        } else if (value == 3) {
        } else if (value == 4) {}
      }),
    ],
  );
}
