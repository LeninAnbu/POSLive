import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/RefundsController/RefundController.dart';
import '../../../Widgets/ContentContainer.dart';

class RefundBillingOptions extends StatelessWidget {
  const RefundBillingOptions({
    super.key,
    required this.theme,
  });

  final ThemeData theme;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.padingHeight(context) * 0.01,
            right: Screens.padingHeight(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context) * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              height: Screens.padingHeight(context) * 0.03,
              child: Text('Billing Options',
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                                payMent: 'Draft bills',
                                buttonName: null,
                                widget:
                                    context
                                            .watch<RefundController>()
                                            .onHoldFilter!
                                            .isEmpty
                                        ? ContentContainer(
                                            content: " No Draft bills",
                                            theme: theme)
                                        : StatefulBuilder(
                                            builder: (context, st) {
                                            return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width:
                                                        Screens.width(context) *
                                                            1.1,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              240, 235, 235)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                      color: Colors.grey
                                                          .withOpacity(0.01),
                                                    ),
                                                    child: TextFormField(
                                                      controller: context
                                                          .read<
                                                              RefundController>()
                                                          .mycontroller[2],
                                                      cursorColor: Colors.grey,
                                                      onChanged: (v) {
                                                        st(() {
                                                          context
                                                              .read<
                                                                  RefundController>()
                                                              .filterListOnHold(
                                                                  v);
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Search hold bills..!!',
                                                        hintStyle: theme
                                                            .textTheme.bodyLarge
                                                            ?.copyWith(
                                                                color: Colors
                                                                    .grey),
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
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.05),
                                                  SizedBox(
                                                      height:
                                                          Screens.padingHeight(
                                                                  context) *
                                                              0.7,
                                                      width: Screens.width(
                                                              context) *
                                                          1.1,
                                                      child: ListView.builder(
                                                          itemCount: context
                                                              .watch<
                                                                  RefundController>()
                                                              .onHoldFilter!
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            log("context.watch<RefundController>().onHoldFilter!.length::${context.watch<RefundController>().onHoldFilter!.length}");

                                                            return Card(
                                                              child: Container(
                                                                padding: EdgeInsets.only(
                                                                    top: Screens.padingHeight(
                                                                            context) *
                                                                        0.01,
                                                                    left: Screens
                                                                            .width(
                                                                                context) *
                                                                        0.01,
                                                                    right: Screens.width(
                                                                            context) *
                                                                        0.01,
                                                                    bottom: Screens.padingHeight(
                                                                            context) *
                                                                        0.03),
                                                                // height: custHeight * 0.2,
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
                                                                              contentPadding: const EdgeInsets.all(0),
                                                                              content: AlertBox(
                                                                                  payMent: 'Alert',
                                                                                  widget: Container(
                                                                                    width: Screens.width(context) * 0.6,
                                                                                    padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.04, vertical: Screens.bodyheight(context) * 0.01),
                                                                                    child: Column(
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

                                                                                                    context.read<RefundController>().mapHoldValues(index, context, theme);
                                                                                                  },
                                                                                                  child: const Text("Yess")),
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
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(context
                                                                              .watch<RefundController>()
                                                                              .onHoldFilter![index]
                                                                              .cardCode!),
                                                                          Text(context
                                                                              .watch<RefundController>()
                                                                              .onHoldFilter![index]
                                                                              .invoceDate!),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(context
                                                                              .watch<RefundController>()
                                                                              .onHoldFilter![index]
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
                                                  //  SizedBox(height:  Screens.padingHeight(context) * 0.09),
                                                ]);
                                          })));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.045,
                  // width: Screens.width(context)*0.15,
                  child: Text("Draft Bills",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Storck Refresh',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Storck Refresh", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.045,
                  // width: Screens.width(context)*0.15,
                  child: Text("Store Refresh",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            contentPadding: const EdgeInsets.all(0),
                            content: AlertBox(
                              payMent: 'Print',
                              buttonName: null,
                              widget: ContentContainer(
                                  content: "Print", theme: theme),
                            ));
                      });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.045,
                  // width: Screens.width(context)*0.15,
                  child: Text("Print",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.045,
                  // width: Screens.width(context)*0.15,
                  child: Text("Access Til",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
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
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      // color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: theme.primaryColor,
                      )),

                  height: Screens.padingHeight(context) * 0.045,
                  // width: Screens.width(context)*0.15,
                  child: Text("Dual Screen",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.primaryColor,
                      )),
                )),
          ],
        ));
  }
}
