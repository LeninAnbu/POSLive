import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/Pages/StockRequest/Widget/Draftbillr.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/StockRequestController/StockRequestController.dart';
import '../../../Widgets/ContentContainer.dart';
import 'SearchBox.dart';

AppBar sReqAppbar(
  String titles,
  ThemeData theme,
  BuildContext context,
) {
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
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                context.read<StockReqController>().searchInitMethod();

                await context.read<StockReqController>().callSearchReqApi();

                context.read<StockReqController>().loadSearch = false;
                await showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Search',
                              buttonName: null,
                              widget: StRequestSearhBox(
                                theme: theme,
                                searchHeight: Screens.bodyheight(context) * 0.9,
                                searchWidth: Screens.width(context),
                              )));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.search)),
                  Text(
                    'Search',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                if (context.read<StockReqController>().savedraftBill.isEmpty) {
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
                                widget: StockReqDraftbill(
                                    theme: theme,
                                    searchHeight:
                                        Screens.bodyheight(context) * 0.9,
                                    searchWidth: Screens.width(context) * 0.49,
                                    stockReq: context
                                        .read<StockReqController>()
                                        .savedraftBill)));
                      });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.ballot_outlined)),
                  Text(
                    'Draft Bills',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Stock Refresh',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Stock Refresh", theme: theme),
                          ));
                    });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.autorenew_outlined)),
                  Text(
                    "Stock Refresh",
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () async {
                context.read<StockReqController>().onclickDisable = true;

                SharedPreferences preff = await SharedPreferences.getInstance();
                if (context
                    .read<StockReqController>()
                    .scanneditemData2
                    .isNotEmpty) {
                  context
                      .read<StockReqController>()
                      .callPrintApi(context, theme);
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Alert',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Kindly choose document",
                                  theme: theme),
                            ));
                      });
                }
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.print_outlined)),
                  Text(
                    'Printers',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Access Til',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Access Til", theme: theme),
                          ));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.auto_mode_outlined)),
                  Text(
                    'Access Til',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            SizedBox(width: Screens.width(context) * 0.02),
            GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                            payMent: 'Dual Screen',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Dual Screen", theme: theme),
                          ));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.screenshot_outlined)),
                  Text('Dual Screen',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white))
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
