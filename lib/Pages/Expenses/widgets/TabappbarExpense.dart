// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Pages/Expenses/widgets/Dialog%20Box/ExpenseApproval.dart';
import 'package:provider/provider.dart';

import '../../../Controller/ExpenseController/ExpenseController.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../../Widgets/AlertBox.dart';
import 'SearchBox.dart';

AppBar appbarTabExpense(
  String titles,
  ThemeData theme,
  BuildContext context,
) {
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
        Row(
          children: [
            GestureDetector(
              onTap: () async {
                context.read<ExpenseController>().searchInitMethod();
                await context.read<ExpenseController>().callSearchHeader();
                // context.read<ExpenseController>().getSalesDataDatewise(
                //     context.read<ExpenseController>().config.alignDate(
                //         context.read<ExpenseController>().config.currentDate()),
                //     context.read<ExpenseController>().config.alignDate(context
                //         .read<ExpenseController>()
                //         .config
                //         .currentDate()));

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Search',
                              buttonName: null,
                              widget: ExpenseSearhBox(
                                theme: theme,
                                searchHeight:
                                    Screens.bodyheight(context) * 0.76,
                                searchWidth: Screens.width(context),
                                // ExpCon: posController,
                              )));
                    });
              },
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.search)),
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
                await context.read<ExpenseController>().searchAprvlMethod();
                context.read<ExpenseController>().searchbool = false;
                context.read<ExpenseController>().clickAprList = false;
                await context.read<ExpenseController>().callAprvllDataDatewise(
                    context.read<ExpenseController>().config.alignDate2(context
                        .read<ExpenseController>()
                        .mycontroller[102]
                        .text),
                    context.read<ExpenseController>().config.alignDate2(context
                        .read<ExpenseController>()
                        .mycontroller[103]
                        .text));
                await context
                    .read<ExpenseController>()
                    .callRejectedAPi(context);

                await context
                    .read<ExpenseController>()
                    .callPendingApprovalapi(context);
                context.read<ExpenseController>().groupValueSelected = 0;

                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: const EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Approval',
                              buttonName: null,
                              widget: ExpApprovals(
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
                context.read<ExpenseController>().mycontroller[4].clear();

                // context.read<ExpenseController>().getdraftindex().then((value) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          contentPadding: EdgeInsets.all(0),
                          content: AlertBox(
                              payMent: 'Draft bills',
                              buttonName: null,
                              widget: context
                                      .watch<ExpenseController>()
                                      .onhold
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
                                                    color: Color.fromARGB(
                                                        255, 240, 235, 235)),
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.grey
                                                    .withOpacity(0.01),
                                              ),
                                              child: TextFormField(
                                                controller: context
                                                    .read<ExpenseController>()
                                                    .mycontroller[4],
                                                cursorColor: Colors.grey,
                                                onChanged: (v) {
                                                  st(() {
                                                    context
                                                        .read<
                                                            ExpenseController>()
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
                                                            ExpenseController>()
                                                        .onholdfilter
                                                        .length,
                                                    itemBuilder:
                                                        (context, index) {
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
                                                                  0.0),
                                                          // height: custHeight * 0.2,
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              context
                                                                  .read<
                                                                      ExpenseController>()
                                                                  .mapHoldValues(
                                                                      index,
                                                                      context,
                                                                      theme);

                                                              // showDialog(
                                                              //     context: context,
                                                              //     barrierDismissible: true,
                                                              //     builder: (BuildContext context) {
                                                              //       return AlertDialog(
                                                              //           contentPadding: EdgeInsets.all(0),
                                                              //           content: AlertBox(
                                                              //               payMent: 'Alert',
                                                              //               widget: Container(
                                                              //                 width: Screens.width(context) * 0.6,
                                                              //                 padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
                                                              //                 child: Column(
                                                              //                   children: [
                                                              //                     Container(alignment: Alignment.center, width: Screens.width(context) * 0.8, child: Center(child: Text('You are about to continue the sales transaction this draft will be cleared now..!!'))),
                                                              //                     SizedBox(
                                                              //                       height: Screens.bodyheight(context) * 0.01,
                                                              //                     ),
                                                              //                     Row(
                                                              //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              //                       children: [
                                                              //                         SizedBox(
                                                              //                           width: Screens.width(context) * 0.15,
                                                              //                           child: ElevatedButton(
                                                              //                               onPressed: () {
                                                              //                                 Navigator.pop(context);
                                                              //                                 context.read<ExpenseController>().mapHoldValues(index, context, theme);
                                                              //                                 Navigator.pop(context);
                                                              //                               },
                                                              //                               child: Text("Yes")),
                                                              //                         ),
                                                              //                         SizedBox(
                                                              //                           width: Screens.width(context) * 0.15,
                                                              //                           child: ElevatedButton(
                                                              //                               onPressed: () {
                                                              //                                 Navigator.pop(context);
                                                              //                               },
                                                              //                               child: Text("No")),
                                                              //                         ),
                                                              //                       ],
                                                              //                     )
                                                              //                   ],
                                                              //                 ),
                                                              //               ),
                                                              //               buttonName: null));
                                                              //     });
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
                                                                            ExpenseController>()
                                                                        .onholdfilter[
                                                                            index]
                                                                        .expensecode!),
                                                                    Text(context
                                                                        .watch<
                                                                            ExpenseController>()
                                                                        .onholdfilter[
                                                                            index]
                                                                        .rcamount!),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(context
                                                                        .watch<
                                                                            ExpenseController>()
                                                                        .onholdfilter[
                                                                            index]
                                                                        .createDate!),
                                                                    Text(""),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    })),
                                            //  SizedBox(height:  Screens.padingHeight(context) * 0.09),
                                          ]);
                                    })));
                    });
                // });
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.ballot_outlined)),
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
                          contentPadding: EdgeInsets.all(0),
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.autorenew_outlined)),
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
                          contentPadding: EdgeInsets.all(0),
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
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.print_outlined)),
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
                          contentPadding: EdgeInsets.all(0),
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
                      // width: Screens.width(context) * 0.18,
                      // height: Screens.padingHeight(context) * 0.06,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.auto_mode_outlined)),
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
                          contentPadding: EdgeInsets.all(0),
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
                      // width: Screens.width(context) * 0.18,
                      // height: Screens.padingHeight(context) * 0.06,
                      decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8),
                        ),
                      ),
                      child: Icon(Icons.screenshot_outlined)),
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
