import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../Constant/Screen.dart';
import '../../../Controller/DepositController/DepositsController.dart';
import '../../../Widgets/Drawer.dart';

class TabsetledSecondScreen extends StatefulWidget {
  TabsetledSecondScreen(
      {super.key,
      // required this.settleCon,
      required this.custHeight,
      required this.custWidth});

  double custHeight;
  double custWidth;
  @override
  State<TabsetledSecondScreen> createState() => _TabsetledSecondScreenState();
}

class _TabsetledSecondScreenState extends State<TabsetledSecondScreen>
    with TickerProviderStateMixin {
  //
  List<Tab> tabBar = [
    const Tab(
      text: 'Cash',
    ),
    const Tab(
      text: 'Card',
    ),
    const Tab(
      text: 'Cheque',
    )
  ];
  TabController? controllerTab;
  @override
  void initState() {
    super.initState();
    controllerTab = TabController(length: 3, vsync: this);
    controllerTab!.addListener(() {
      if (controllerTab!.index == 1) {
        context.read<DepositsController>().clearTxtField();
      } else if (controllerTab!.index == 2) {
        context.read<DepositsController>().clearTxtField();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerTab!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return
        // DefaultTabController(
        //   length: 3,
        //   child:
        Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text("Deposits Screen"),
              bottom: TabBar(controller: controllerTab, tabs: tabBar),
            ),
            drawer: naviDrawer(),
            body: SingleChildScrollView(
              child: SizedBox(
                width: Screens.width(context),
                height: Screens.bodyheight(context) * 0.9,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(controller: controllerTab, children: [
                        cashWidget(context, theme),
                        cardWidget(context, theme),
                        checqueWidget(context, theme),
                      ]),
                    ),
                  ],
                ),
              ),
            )
            // SafeArea(
            //     child: SingleChildScrollView(
            //   child: Container(
            //     padding: EdgeInsets.only(
            //         top: widget.custHeight * 0.01,
            //         bottom: widget.custHeight * 0.01,
            //         left: widget.custWidth * 0.01,
            //         right: widget.custWidth * 0.01),
            //     height: widget.custHeight * 1,
            //     width: double.infinity,
            //     child: Column(
            //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Container(
            //           alignment: Alignment.center,
            //           //     color: Colors.amber,
            //           width: double.maxFinite,
            //           child: TabBar(isScrollable: true, tabs: [
            //             Tab(
            //                 child: SizedBox(
            //                     width: widget.custWidth * 0.05,
            //                     child: Text("Cash",
            //                         style: theme.textTheme.bodyLarge!.copyWith()))),
            //             Tab(
            //               child: SizedBox(
            //                   width: widget.custWidth * 0.05,
            //                   child: Text("Card",
            //                       style: theme.textTheme.bodyLarge!.copyWith())),
            //             ),
            //             Tab(
            //               child: SizedBox(
            //                   width: widget.custWidth * 0.05,
            //                   child: Text("Cheque",
            //                       style: theme.textTheme.bodyLarge!.copyWith())),
            //             ),
            // Tab(
            //   child: Container(
            //       width: widget.custWidth * 0.05,
            //       child: Text("Wallet",
            //           style: theme.textTheme.bodyMedium!.copyWith())),
            // ),
            // Tab(
            //   child: Container(
            //       width: widget.custWidth * 0.05,
            //       child: Text("Coupon",
            //           style: theme.textTheme.bodyMedium!.copyWith())),
            // ),
            //   ]),
            // ),
            //         Expanded(
            //           child: TabBarView(
            //             controller: controllerTab,
            //             children: [
            //             CashWidget(context, theme),
            //             CardWidget(context, theme),
            //             ChecqueWidget(context, theme),
            //           ]),
            //         ),
            //         SizedBox(
            //           height: widget.custHeight * 0.01,
            //         ),
            //       ],
            //     ),
            //   ),
            // )),
            // ),
            );
  }

  Container cashWidget(BuildContext context, ThemeData theme) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          top: widget.custHeight * 0.03,
          bottom: widget.custHeight * 0.01,
          left: widget.custWidth * 0.01,
          right: widget.custWidth * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: context.watch<DepositsController>().cashform,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        //  color: Colors.amber,
                        width: widget.custWidth * 0.30,
                        child: const Text("Amount in Hand")),
                    SizedBox(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.55,
                        child: TextField(
                          readOnly: true,
                          controller: context
                              .watch<DepositsController>()
                              .mycontroller[4],
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "",
                              hintStyle: theme.textTheme.bodyLarge),
                        )),
                  ],
                ),
                SizedBox(
                  height: widget.custHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        // color: Colors.amber,
                        width: widget.custWidth * 0.30,
                        child: const Text("Amount to Settle off")),
                    SizedBox(
                        // height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.55,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Requierd";
                            }
                            log('valuevalue::::$value');
                            log(' mycontroller[4] .text::  ${double.parse(context.read<DepositsController>().mycontroller[4].text).ceil()}');
                            if ((double.parse(value.toString()) !=
                                    double.parse(context
                                            .read<DepositsController>()
                                            .mycontroller[4]
                                            .text)
                                        .ceil()) &&
                                (double.parse(value.toString()) !=
                                    double.parse(context
                                            .read<DepositsController>()
                                            .mycontroller[4]
                                            .text)
                                        .floor())) {
                              // print(
                              //     "aaajajaj::::${double.parse(context.watch<DepositsController>().mycontroller[4].text).floor()}");
                              // print(
                              //     "aaajajajvalue::::${value}");
                              // print("ghgjhghgjgj: " +
                              //     double.parse(context.watch<DepositsController>()
                              //             .mycontroller[4]
                              //             .text)
                              //         .ceil()
                              //         .toString());
                              return "Enter Correct Amount";
                            }
                            return null;
                          },
                          // readOnly: true,
                          controller: context
                              .read<DepositsController>()
                              .mycontroller[5],

                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(5),
                              //   borderSide:
                              //       BorderSide(color: theme.primaryColor),
                              // )
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "",
                              hintStyle: theme.textTheme.bodyLarge),
                        )),
                  ],
                ),
                SizedBox(
                  height: widget.custHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        //    color: Colors.amber,
                        width: widget.custWidth * 0.30,
                        child: const Text("Settlement Account")),
                    Container(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.55,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4)),
                        child: Center(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration.collapsed(
                                hintText: " Settlement Account",
                                hintStyle: theme.textTheme.bodyLarge),
                            value:
                                context.watch<DepositsController>().valuechoose,
                            onChanged: (newvalue) {
                              context
                                  .read<DepositsController>()
                                  .dropdownchoose(newvalue);
                            },
                            items: context
                                .watch<DepositsController>()
                                .listitems
                                .map((valueitem) {
                              return DropdownMenuItem(
                                value: valueitem,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: widget.custWidth * 0.002),
                                  child: Text(
                                    valueitem,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: widget.custHeight * 0.02,
                ),
                Row(
                  children: [
                    SizedBox(
                        //   color: Colors.amber,
                        width: widget.custWidth * 0.30,
                        child: const Text("Remarks")),
                    SizedBox(
                        height: widget.custHeight * 0.07,
                        width: widget.custWidth * 0.55,
                        child: TextField(
                          controller: context
                              .read<DepositsController>()
                              .mycontroller[6],
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "",
                              hintStyle: theme.textTheme.bodyLarge),
                        )),
                  ],
                ),
                SizedBox(
                  height: widget.custHeight * 0.05,
                ),
                //    Container(
                //     // color: Colors.amber,
                //    alignment: Alignment.centerLeft,
                //     // width: widget.custWidth*0.20,
                //    child: SizedBox(
                // height: widget.custHeight*0.07,
                // width: widget.custWidth*0.10,
                // child: ElevatedButton(onPressed: (){}, child: Text("Save"))))
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: widget.custHeight * 0.07,
                width: widget.custWidth * 0.10,
                child: ElevatedButton(
                    onPressed: () {
                      context
                          .read<DepositsController>()
                          .validateCashSave(theme, context);
                      // context
                      //     .read<DepositsController>()
                      //     .insertsettledheader("Cash", theme);
                    },
                    child: const Text("Save")),
              ),
              SizedBox(
                width: Screens.width(context) * 0.01,
              ),
              SizedBox(
                height: widget.custHeight * 0.07,
                width: widget.custWidth * 0.10,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        context.read<DepositsController>().init(context);
                        Get.back();

                        //   Get.toNamed(ConstantRoutes.settlement);
                      });
                    },
                    child: const Text("Cancel")),
              ),
            ],
          )
        ],
      ),
    );
  }

  Form cardWidget(BuildContext context, ThemeData theme) {
    return Form(
      key: context.read<DepositsController>().cardform,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(
              top: widget.custHeight * 0.03,
              bottom: widget.custHeight * 0.01,
              left: widget.custWidth * 0.01,
              right: widget.custWidth * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: widget.custWidth * 0.35,
                        // color: Colors.pink,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Payment Terminal"),
                            Container(
                              // color: Colors.blue,
                              height: widget.custHeight * 0.06,
                              width: widget.custHeight * 0.40,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: DropdownButtonFormField(
                                  validator: (value) =>
                                      value == null ? 'field required' : null,
                                  decoration: const InputDecoration.collapsed(
                                    hintText: "",
                                  ),
                                  value: context
                                      .watch<DepositsController>()
                                      .paytermvaluechoose,
                                  onChanged: (newvalue) {
                                    context
                                        .read<DepositsController>()
                                        .payTermdropdown(newvalue);
                                  },
                                  items: context
                                      .watch<DepositsController>()
                                      .cardpayTerminallist
                                      .map((valueitem) {
                                    return DropdownMenuItem(
                                      value: valueitem,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: widget.custWidth * 0.01),
                                        child: Text(
                                          valueitem,
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Screens.width(context) * 0.3,
                        // color: Colors.red,
                        child: Text(
                            "Total Settled Card Amount: ${context.read<DepositsController>().totalCardAmt}"),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              height: widget.custHeight * 0.07,
                              width: widget.custWidth * 0.15,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<DepositsController>()
                                          .selectAllCardTransaction();
                                    });
                                  },
                                  child: Text(
                                    context
                                                .watch<DepositsController>()
                                                .isSelectedAllCard ==
                                            false
                                        ? "Select All"
                                        : "Unsellect All",
                                  ))),
                          SizedBox(
                            width: Screens.width(context) * 0.01,
                          ),
                          SizedBox(
                              height: widget.custHeight * 0.07,
                              width: widget.custWidth * 0.15,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<DepositsController>()
                                          .forcardlistorder(
                                              context, "Card", theme, 1);
                                    });
                                  },
                                  child: const Text(
                                    "Load",
                                  ))),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: widget.custHeight * 0.01,
                  ),
                  SizedBox(
                    height: Screens.bodyheight(context) * 0.655,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: context
                            .watch<DepositsController>()
                            .cardData //finalcardsettled
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.grey[200],
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              // width: widget.custWidth*0.03,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.15,
                                    child: Row(
                                      children: [
                                        Text(
                                            context
                                                .watch<DepositsController>()
                                                .cardData //finalcardsettled
                                                [index]
                                                .documentno
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith()),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                      width: Screens.width(context) * 0.12,
                                      child: Row(
                                        children: [
                                          Text(
                                            context
                                                .watch<DepositsController>()
                                                .cardData //finalcardsettled
                                                [index]
                                                .doctype
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )
                                        ],
                                      )),

                                  // Container(child: Text("Card Ref:")),
                                  SizedBox(
                                      width: Screens.width(context) * 0.08,
                                      child: Row(
                                        children: [
                                          Text(
                                            context
                                                .watch<DepositsController>()
                                                .cardData //finalcardsettled
                                                [index]
                                                .cardterminal
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )
                                        ],
                                      )),

                                  SizedBox(
                                      width: Screens.width(context) * 0.2,
                                      child: Row(
                                        children: [
                                          const Text("Total : "),
                                          Text(
                                              context
                                                  .watch<DepositsController>()
                                                  .cardData //finalcardsettled
                                                  [index]
                                                  .rcamount
                                                  .toString(),
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(fontSize: 15))
                                        ],
                                      )),
                                  SizedBox(
                                      width: Screens.width(context) * 0.1,
                                      child: Row(
                                        children: [
                                          Text(
                                              context
                                                  .watch<DepositsController>()
                                                  .config
                                                  .alignDate(context
                                                      .read<
                                                          DepositsController>()
                                                      .cardData //finalcardsettled
                                                      [index]
                                                      .createdateTime
                                                      .toString()),
                                              style: theme.textTheme.bodyLarge!
                                                  .copyWith(fontSize: 15))
                                        ],
                                      )),

                                  SizedBox(
                                      width: Screens.width(context) * 0.05,
                                      child: Checkbox(
                                          value: context
                                              .read<DepositsController>()
                                              .cardData //finalcardsettled
                                              [index]
                                              .isSelected,
                                          onChanged: (v) {
                                            context
                                                .read<DepositsController>()
                                                .selectTrans(v!, index);
                                          })),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  // SizedBox(
                  //   height: widget.custHeight * 0.01,
                  // ),
                  //  Container(
                  //    alignment: Alignment.centerLeft,
                  //    child: SizedBox(
                  //      height: widget.custHeight*0.07,
                  //        width: widget.custWidth*0.10,
                  //      child: ElevatedButton(onPressed: (){}, child: Text("Save"))))
                ],
              ),
              Form(
                key: context.read<DepositsController>().cardvalidate,
                child: SizedBox(
                  width: Screens.width(context),
                  height: Screens.bodyheight(context) * 0.1,
                  //  color: Colors.amber,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: Screens.width(context) * 0.37,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Requierd";
                                  }

                                  return null;
                                },
                                // readOnly: true,
                                controller: context
                                    .read<DepositsController>()
                                    .transactionID,

                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "Transaction Id",
                                    hintStyle: theme.textTheme.bodyLarge),
                              )),
                          SizedBox(
                            width: Screens.width(context) * 0.01,
                          ),
                          SizedBox(
                              width: Screens.width(context) * 0.37,
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Requierd";
                                  }

                                  return null;
                                },
                                // readOnly: true,
                                controller: context
                                    .read<DepositsController>()
                                    .jurnelRemarks,
                                decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.red),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 5.0),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4)),
                                    hintText: "Journal Remarks",
                                    hintStyle: theme.textTheme.bodyLarge),
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: widget.custHeight * 0.07,
                            width: widget.custWidth * 0.10,
                            child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<DepositsController>()
                                      .validateCardSave(theme, context);
                                  // .insertsettledheader("Card", theme);
                                },
                                child: const Text("Save")),
                          ),
                          SizedBox(
                            width: Screens.width(context) * 0.01,
                          ),
                          SizedBox(
                              height: widget.custHeight * 0.07,
                              width: widget.custWidth * 0.10,
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      context
                                          .read<DepositsController>()
                                          .init(context);
                                      Get.back();
                                      // Get.toNamed(ConstantRoutes.settlement);
                                    });
                                  },
                                  child: const Text("Cancel"))),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container checqueWidget(BuildContext context, ThemeData theme) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(
            top: widget.custHeight * 0.03,
            bottom: widget.custHeight * 0.01,
            left: widget.custWidth * 0.01,
            right: widget.custWidth * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                            width: widget.custHeight * 0.35,
                            child: const Text("Total Settled Cheque Amount")),
                        Container(
                            child:
                                // context
                                //             .watch<DepositsController>()
                                //             .mycontroller[14]
                                //             .text ==
                                //         ''
                                context
                                            .watch<DepositsController>()
                                            .totalCheque ==
                                        0
                                    ? const Text("Rs.0.00")
                                    : Text(context
                                        .watch<DepositsController>()
                                        .totalCheque
                                        .toString())),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          // height: custHeight * 0.24,
                          width: widget.custWidth * 0.3,
                          padding: EdgeInsets.only(
                            left: widget.custHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: context
                                            .read<DepositsController>()
                                            .getbankhintcolor ==
                                        true
                                    ? Colors.red
                                    : Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                ' Select Bank Name',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                                .read<DepositsController>()
                                                .getbankhintcolor ==
                                            true
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              items: context
                                  .read<DepositsController>()
                                  .bankList
                                  .map((item) => DropdownMenuItem<String>(
                                      value: item.bankName,
                                      child: Text(
                                        item.bankName!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      )))
                                  .toList(),
                              value: context
                                  .read<DepositsController>()
                                  .selectedBankType,
                              onChanged: (value) {
                                setState(() {
                                  context
                                      .read<DepositsController>()
                                      .selectedBankType = value;
                                  context
                                      .read<DepositsController>()
                                      .getSelectbankCode(
                                          context,
                                          context
                                              .read<DepositsController>()
                                              .selectedBankType
                                              .toString());
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.01,
                        ),
                        SizedBox(
                            height: widget.custHeight * 0.07,
                            width: widget.custWidth * 0.15,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    context
                                        .read<DepositsController>()
                                        .selectionChque();
                                  });
                                },
                                child: Text(
                                  context
                                              .watch<DepositsController>()
                                              .isSelectedAllCheque ==
                                          false
                                      ? "Select All"
                                      : "Unsellect All",
                                ))),

                        // SizedBox(
                        //   height: widget.custHeight * 0.07,
                        //   width: widget.custWidth * 0.15,
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         context.read<DepositsController>().isload =
                        //             true;
                        //         setState(() {
                        //           context
                        //               .read<DepositsController>()
                        //               .forChequelistorder(
                        //                   context, "Cheque", theme, 1);
                        //           // widget.settleCon.ontapisload();
                        //         });
                        //       },
                        //       child: const Text("Load")),
                        // ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.custHeight * 0.01,
                ),
                SizedBox(
                  height: Screens.bodyheight(context) * 0.68,
                  width: double.infinity,
                  child: context.watch<DepositsController>().loadigChequeBtn ==
                              true &&
                          context
                              .watch<DepositsController>()
                              .chequeQueryData!
                              .isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          )),
                        )
                      : ListView.builder(
                          itemCount: context
                              .watch<DepositsController>()
                              .chequeQueryData!
                              .length,
                          itemBuilder: (context, index) {
                            return Card(
                                color: Colors.grey[200],
                                child: CheckboxListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  activeColor: theme.primaryColor,
                                  value: context
                                      .watch<DepositsController>()
                                      .chequeQueryData![index]
                                      .checkClr,
                                  onChanged: (val) {
                                    setState(() {
                                      context
                                          .read<DepositsController>()
                                          .chequeitemDeSelect(index, val!);
                                    });
                                  },
                                  title: SizedBox(
                                    width: Screens.width(context),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            width: Screens.width(context) * 0.2,
                                            child: Row(
                                              children: [
                                                Text(
                                                    context
                                                        .watch<
                                                            DepositsController>()
                                                        .chequeQueryData![index]
                                                        .chequeKey
                                                        .toString(),
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith())
                                              ],
                                            )),
                                        SizedBox(
                                            width: Screens.width(context) * 0.2,
                                            child: Row(
                                              children: [
                                                Text(
                                                    context
                                                        .watch<
                                                            DepositsController>()
                                                        .chequeQueryData![index]
                                                        .action
                                                        .toString(),
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(fontSize: 18))
                                              ],
                                            )),
                                        SizedBox(
                                            width:
                                                Screens.width(context) * 0.25,
                                            child: Row(
                                              children: [
                                                Text("Total: ",
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            fontSize: 18)),
                                                Container(
                                                  width:
                                                      Screens.width(context) *
                                                          0.12,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                      "${context.watch<DepositsController>().chequeQueryData![index].chequeAmt}",
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(
                                                              fontSize: 18)),
                                                )
                                              ],
                                            )),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            width:
                                                Screens.width(context) * 0.12,
                                            child: Row(
                                              children: [
                                                Text(
                                                    context
                                                        .read<
                                                            DepositsController>()
                                                        .config
                                                        .alignDate(context
                                                            .read<
                                                                DepositsController>()
                                                            .chequeQueryData![
                                                                index]
                                                            .chequeDate
                                                            .toString()),
                                                    style: theme
                                                        .textTheme.bodyLarge!
                                                        .copyWith(fontSize: 18))
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                ));
                          }),
                ),
                // SizedBox(
                //   height: widget.custHeight * 0.02,
                // ),
              ],
            ),
            Form(
              key: context.read<DepositsController>().chequevalidate,
              child: SizedBox(
                width: Screens.width(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: Screens.width(context) * 0.37,
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Requierd";
                          //   }

                          //   return null;
                          // },
                          // readOnly: true,
                          controller:
                              context.read<DepositsController>().transactionID,

                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Transaction Id",
                              hintStyle: theme.textTheme.bodyLarge),
                        )),
                    SizedBox(
                      width: Screens.width(context) * 0.01,
                    ),
                    SizedBox(
                        width: Screens.width(context) * 0.37,
                        child: TextFormField(
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Requierd";
                          //   }

                          //   return null;
                          // },
                          // readOnly: true,
                          controller:
                              context.read<DepositsController>().jurnelRemarks,
                          decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 5.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4)),
                              hintText: "Journal Remarks",
                              hintStyle: theme.textTheme.bodyLarge),
                        )),
                    Row(
                      children: [
                        SizedBox(
                          height: widget.custHeight * 0.07,
                          width: widget.custWidth * 0.10,
                          child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<DepositsController>()
                                    .validateCheque(theme, context);
                              },
                              child: const Text("Save")),
                        ),
                        SizedBox(
                          width: Screens.width(context) * 0.01,
                        ),
                        SizedBox(
                            height: widget.custHeight * 0.07,
                            width: widget.custWidth * 0.10,
                            child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<DepositsController>()
                                      .init(context);
                                  Get.back();
                                },
                                child: const Text("Cancel"))),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
