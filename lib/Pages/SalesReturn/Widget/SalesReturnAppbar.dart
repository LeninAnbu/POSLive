import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesReturnController/SalesReturnController.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import 'SearchBox.dart';
import 'ReturnApproval.dart';

AppBar salesReturnappbar(
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
                context.read<SalesReturnController>().searchInitMethod();

                // context.read<SalesReturnController>().getSalesDataDatewise(
                //     context.read<SalesReturnController>().config.alignDate(
                //         context
                //             .read<SalesReturnController>()
                //             .config
                //             .currentDate()),
                //     context.read<SalesReturnController>().config.alignDate(
                //         context
                //             .read<SalesReturnController>()
                //             .config
                //             .currentDate()));
                await context
                    .read<SalesReturnController>()
                    .callSearchHeaderApi();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: AlertBox(
                              payMent: 'Search',
                              buttonName: null,
                              widget: saleReturnSearhBox(
                                theme: theme,
                                searchHeight:
                                    Screens.bodyheight(context) * 0.77,
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
            InkWell(
              onTap: () async {
                context.read<SalesReturnController>().scanneditemData2 = [];
                context.read<SalesReturnController>().selectedcust2 = null;
                context.read<SalesReturnController>().isApprove = false;
                context.read<SalesReturnController>().clickAprList = false;
                context.read<SalesReturnController>().groupValueSelected = 0;
                await context.read<SalesReturnController>().searchAprvlMethod();
                await context
                    .read<SalesReturnController>()
                    .callAprvllDataDatewise(
                        context.read<SalesReturnController>().config.alignDate2(
                            context
                                .read<SalesReturnController>()
                                .mycontroller[102]
                                .text),
                        context.read<SalesReturnController>().config.alignDate2(
                            context
                                .read<SalesReturnController>()
                                .mycontroller[103]
                                .text));
                await context
                    .read<SalesReturnController>()
                    .callRejectedAPi(context);

                await context
                    .read<SalesReturnController>()
                    .callPendingApprovalapi(context);

                await showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Approval',
                              buttonName: null,
                              widget: ReturnApprovals(
                                theme: theme,
                                searchHeight:
                                    Screens.bodyheight(context) * 0.85,
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
                      child: const Icon(Icons.approval_outlined)),
                  Text(
                    'Approval',
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
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: context
                                      .read<SalesReturnController>()
                                      .onHoldFilter!
                                      .isEmpty
                                  ? ContentContainer(
                                      content: "No Draft bills", theme: theme)
                                  : StatefulBuilder(builder: (context, st) {
                                      return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width:
                                                  Screens.width(context) * 1.1,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 240, 235, 235)),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.grey
                                                    .withOpacity(0.01),
                                              ),
                                              child: TextFormField(
                                                controller: context
                                                    .watch<
                                                        SalesReturnController>()
                                                    .mycontroller[2],
                                                cursorColor: Colors.grey,
                                                onChanged: (v) {
                                                  st(() {
                                                    context
                                                        .read<
                                                            SalesReturnController>()
                                                        .filterListOnHold(v);
                                                  });
                                                },
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Search hold bills..!!',
                                                  hintStyle: theme
                                                      .textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.grey),
                                                  filled: false,
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 12,
                                                    horizontal: 25,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.05),
                                            SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.7,
                                                width: Screens.width(context) *
                                                    1.1,
                                                child: ListView.builder(
                                                    itemCount: context
                                                        .watch<
                                                            SalesReturnController>()
                                                        .onHoldFilter!
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      log(" context.watch<  SalesReturnController>() .onHoldFilter! .length${context.watch<SalesReturnController>().onHoldFilter!.length}");
                                                      return Card(
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                              top: Screens.padingHeight(
                                                                      context) *
                                                                  0.01,
                                                              left: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              right: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              bottom: Screens
                                                                      .padingHeight(
                                                                          context) *
                                                                  0.03),
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              context
                                                                  .read<
                                                                      SalesReturnController>()
                                                                  .mapHoldValues(
                                                                      index,
                                                                      context,
                                                                      theme);
                                                            },
                                                            title: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(context
                                                                        .watch<
                                                                            SalesReturnController>()
                                                                        .onHoldFilter![
                                                                            index]
                                                                        .cardCode!),
                                                                    Text(context
                                                                        .watch<
                                                                            SalesReturnController>()
                                                                        .config
                                                                        .aligntimeDate(context
                                                                            .watch<SalesReturnController>()
                                                                            .onHoldFilter![index]
                                                                            .createdateTime!)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(context
                                                                        .watch<
                                                                            SalesReturnController>()
                                                                        .onHoldFilter![
                                                                            index]
                                                                        .custName!),
                                                                    const Text(
                                                                        ""),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })),
                                          ]);
                                    })));
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
                          contentPadding: EdgeInsets.zero,
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
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          content: AlertBox(
                            payMent: 'Print',
                            buttonName: null,
                            widget: ContentContainer(
                                content: "Print", theme: theme),
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
                      child: const Icon(Icons.print_outlined)),
                  Text(
                    'Printers',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
