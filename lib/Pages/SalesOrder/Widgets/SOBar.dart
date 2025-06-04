import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../../Widgets/ContentContainer.dart';

import '../../../Widgets/AlertBox.dart';

import 'Dialog Box/DefaultSearch.dart';
import 'Dialog Box/SoApproval.dart';

AppBar soAppbar(String titles, ThemeData theme, BuildContext context) {
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
            InkWell(
              onTap: () {
                context.read<SOCon>().searchInitMethod();
                context.read<SOCon>().callSearchHeaderApi();
                context.read<SOCon>().scanneditemData2 = [];

                context.read<SOCon>().selectedcust2 = null;
                context.read<SOCon>().selectedcust25 = null;

                context.read<SOCon>().clickAprList = false;

                context.read<SOCon>().setstate1();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Search',
                              buttonName: null,
                              widget: SearhBoxSO(
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
                context.read<SOCon>().scanneditemData2 = [];
                context.read<SOCon>().paymentWay2 = [];
                context.read<SOCon>().selectedcust2 = null;
                await context.read<SOCon>().searchAprvlMethod();
                await context.read<SOCon>().callAprvllDataDatewise(
                    context.read<SOCon>().config.alignDate2(
                        context.read<SOCon>().mycontroller[102].text),
                    context.read<SOCon>().config.alignDate2(
                        context.read<SOCon>().mycontroller[103].text));
                await context.read<SOCon>().callRejectedAPi(context);

                await context.read<SOCon>().callPendingApprovalapi(context);

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Approval',
                              buttonName: null,
                              widget: SoApprovals(
                                theme: theme,
                                searchHeight:
                                    Screens.bodyheight(context) * 0.85,
                                searchWidth: Screens.width(context),
                              )));
                    });

                context.read<SOCon>().setstate1();
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
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: context
                                      .watch<SOCon>()
                                      .fileterHoldData
                                      .isEmpty
                                  ? ContentContainer(
                                      content: " No Draft bills", theme: theme)
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
                                                    .read<SOCon>()
                                                    .mycontroller[2],
                                                cursorColor: Colors.grey,
                                                onChanged: (v) {
                                                  st(() {
                                                    context
                                                        .read<SOCon>()
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
                                                    0.02),
                                            SizedBox(
                                                height: Screens.padingHeight(
                                                        context) *
                                                    0.7,
                                                width: Screens.width(context) *
                                                    1.1,
                                                child: ListView.builder(
                                                    itemCount: context
                                                        .watch<SOCon>()
                                                        .fileterHoldData
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Card(
                                                        child: Container(
                                                          padding: EdgeInsets.only(
                                                              left: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              right: Screens.width(
                                                                      context) *
                                                                  0.01,
                                                              bottom: Screens
                                                                      .padingHeight(
                                                                          context) *
                                                                  0.01),
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              context
                                                                  .read<SOCon>()
                                                                  .mapHoldSelectedValues(
                                                                      context
                                                                          .read<
                                                                              SOCon>()
                                                                          .fileterHoldData[index],
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
                                                                        .read<
                                                                            SOCon>()
                                                                        .fileterHoldData[
                                                                            index]
                                                                        .cardcode!),
                                                                    Text(context
                                                                        .read<
                                                                            SOCon>()
                                                                        .config
                                                                        .aligntimeDate(context
                                                                            .read<SOCon>()
                                                                            .fileterHoldData[index]
                                                                            .date!)),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(context
                                                                        .read<
                                                                            SOCon>()
                                                                        .fileterHoldData[
                                                                            index]
                                                                        .cardName!),
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
                SharedPreferences preff = await SharedPreferences.getInstance();

                if (context.read<SOCon>().scanneditemData2.isNotEmpty) {
                  context.read<SOCon>().callPrintApi(context, theme);
                  context.read<SOCon>().setstate1();
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
                    'Print',
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

class HoldedHeader {
  String? cardcode;
  String? cardName;
  String? date;
  int? docEntry;
  String? docNo;
  String? tinNo;
  String? vatNo;
  String? branch;
  String? seresid;

  HoldedHeader(
      {this.cardName,
      this.cardcode,
      this.date,
      this.docEntry,
      this.docNo,
      this.branch,
      required this.tinNo,
      required this.seresid,
      required this.vatNo});
}
