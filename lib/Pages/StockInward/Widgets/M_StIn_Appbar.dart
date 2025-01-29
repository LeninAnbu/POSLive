import 'package:flutter/material.dart';

import '../../../../../Controller/StockInwardController/StockInwardContler.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import '../../../../../Constant/Screen.dart';
import '../../../Widgets/ContentContainer.dart';
import '../Screens/MobileScreen/Widgets/M_Draftbill.dart';

AppBar stInAppbar(String titles, ThemeData theme, BuildContext context,
    StockInwrdController posController) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: theme.primaryColor,
    automaticallyImplyLeading: false,
    centerTitle: true,
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
    toolbarHeight: Screens.padingHeight(context) * 0.08,
    title: Text(
      titles,
      style: theme.textTheme.titleMedium!.copyWith(color: Colors.white),
    ),
    actions: [
      Container(
        width: Screens.width(context) * 0.1,
        height: Screens.padingHeight(context) * 0.06,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
          ),
        ),
        child: PopupMenuButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          itemBuilder: (ctx) => [
            PopupMenuItem(
              value: 1,
              child: Center(
                  child: IconButton(
                      tooltip: "Draft Bills",
                      onPressed: () {
                        if (posController.savedraftBill.isEmpty) {
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    contentPadding: const EdgeInsets.all(0),
                                    insetPadding: EdgeInsets.all(
                                        Screens.bodyheight(context) * 0.02),
                                    content: AlertBox(
                                        payMent: 'Draft bills',
                                        buttonName: null,
                                        widget: M_StockInDraftbill(
                                            theme: theme,
                                            prdsrch: posController,
                                            searchHeight:
                                                Screens.bodyheight(context) *
                                                    0.5,
                                            searchWidth:
                                                Screens.width(context) * 0.9,
                                            stockIn:
                                                posController.savedraftBill)));
                              });
                        }
                      },
                      icon: Icon(
                        Icons.ballot_outlined,
                        color: theme.primaryColor,
                      ))),
            ),
            PopupMenuItem(
                value: 2,
                child: Center(
                    child: IconButton(
                        tooltip: "Stock Refresh",
                        onPressed: () {},
                        icon: Icon(
                          Icons.autorenew_outlined,
                          color: theme.primaryColor,
                        )))),
            PopupMenuItem(
                value: 3,
                child: Center(
                    child: IconButton(
                        tooltip: "Printers",
                        onPressed: () {},
                        icon: Icon(
                          Icons.print_outlined,
                          color: theme.primaryColor,
                        )))),
            PopupMenuItem(
                value: 4,
                child: Center(
                    child: IconButton(
                        tooltip: "Access Til",
                        onPressed: () {},
                        icon: Icon(
                          Icons.auto_mode_outlined,
                          color: theme.primaryColor,
                        )))),
            PopupMenuItem(
                value: 5,
                child: Center(
                    child: IconButton(
                        tooltip: "Dual Screen",
                        onPressed: () {},
                        icon: Icon(
                          Icons.screenshot_outlined,
                          color: theme.primaryColor,
                        ))))
          ],
          onSelected: (id) {
            if (id == 1) {
              if (posController.savedraftBill.isEmpty) {
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
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: M_StockInDraftbill(
                                  theme: theme,
                                  prdsrch: posController,
                                  searchHeight:
                                      Screens.bodyheight(context) * 0.5,
                                  searchWidth: Screens.width(context) * 0.9,
                                  stockIn: posController.savedraftBill)));
                    });
              }
            }
            if (id == 2) {}
            if (id == 3) {}
            if (id == 4) {}
            if (id == 5) {}
          },
        ),
      )
    ],
  );
}
