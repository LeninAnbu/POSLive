import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/PaymentReceiptController/PayReceiptController.dart';
import 'package:posproject/Pages/Sales%20Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';

import '../../../../../../../Widgets/AlertBox.dart';

AppBar payappbarMS(String titles, ThemeData theme, BuildContext context,
    {PayreceiptController? payController}) {
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
                const Text("Account Refresh"),
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
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                log("onHoldFilter length:${payController!.onHoldFilter!.length}");
                return AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    contentPadding: const EdgeInsets.all(0),
                    insetPadding:
                        EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                    content: payController.onHoldFilter!.isEmpty
                        ? ContentWidgetMob(theme: theme, msg: "No draft bill")
                        : StatefulBuilder(builder: (context, st) {
                            return SizedBox(
                              width: Screens.width(context),
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: Screens.width(context),
                                      height:
                                          Screens.padingHeight(context) * 0.05,
                                      color: theme.primaryColor,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                left: Screens.padingHeight(
                                                        context) *
                                                    0.02,
                                                right: Screens.padingHeight(
                                                        context) *
                                                    0.02),
                                            width: Screens.width(context) * 0.7,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Draft Bills",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                size: Screens.padingHeight(
                                                        context) *
                                                    0.025,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical:
                                              Screens.padingHeight(context) *
                                                  0.01,
                                          horizontal:
                                              Screens.width(context) * 0.01),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: Screens.width(context) * 1.1,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 240, 235, 235)),
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color:
                                                  Colors.grey.withOpacity(0.01),
                                            ),
                                            child: TextFormField(
                                              controller:
                                                  payController.mycontroller[2],
                                              cursorColor: Colors.grey,
                                              onChanged: (v) {
                                                st(() {
                                                  payController
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
                                                filled: true,
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 12,
                                                  horizontal: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.01),
                                          SizedBox(
                                              height: Screens.padingHeight(
                                                      context) *
                                                  0.5,
                                              width:
                                                  Screens.width(context) * 1.1,
                                              child: ListView.builder(
                                                  itemCount: payController
                                                      .onHoldFilter!.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Card(
                                                      child: Container(
                                                        padding: EdgeInsets.only(
                                                            top: Screens
                                                                    .padingHeight(
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
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    true,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                      contentPadding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              0),
                                                                      content: AlertBox(
                                                                          payMent: 'Alert',
                                                                          widget: Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(alignment: Alignment.center, width: Screens.width(context) * 0.8, child: const Center(child: Text('You are about to continue the sales transaction this draft will be created now..!!'))),
                                                                                SizedBox(
                                                                                  height: Screens.bodyheight(context) * 0.01,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: Screens.width(context) * 0.15,
                                                                                      child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                            payController.mapHoldValues(index, context, theme);
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text("Yes")),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: Screens.width(context) * 0.15,
                                                                                      child: ElevatedButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: const Text("No")),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          buttonName: null));
                                                                });
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
                                                                  Text(payController
                                                                              .onHoldFilter![
                                                                                  index]
                                                                              .cardCode !=
                                                                          null
                                                                      ? payController
                                                                          .onHoldFilter![
                                                                              index]
                                                                          .cardCode!
                                                                      : "emptycardcode"),
                                                                  Text(
                                                                    (payController.onHoldFilter![index].invoceDate !=
                                                                            null
                                                                        ? payController
                                                                            .onHoldFilter![index]
                                                                            .invoceDate!
                                                                        : "PPPP"),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(payController
                                                                              .onHoldFilter![
                                                                                  index]
                                                                              .custName !=
                                                                          null
                                                                      ? payController
                                                                          .onHoldFilter![
                                                                              index]
                                                                          .custName!
                                                                      : "LLLL"),
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
                                        ],
                                      ),
                                    ),
                                  ]),
                            );
                          }));
              });
        } else if (value == 1) {
        } else if (value == 2) {
        } else if (value == 3) {
        } else if (value == 4) {}
      }),
    ],
  );
}
