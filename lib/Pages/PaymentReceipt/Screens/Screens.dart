import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:posproject/Widgets/ContentContainer.dart';
import 'package:provider/provider.dart';
import '../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../Widgets/Drawer.dart';
import '../Widget/SearchBox.dart';
import 'PayMobile/Payment Receipt/Screens/PaymentReceipt.dart';
import 'PayTab/TabScreen.dart';

class PaymentReceiptScreens extends StatefulWidget {
  const PaymentReceiptScreens({
    super.key,
  });

  @override
  State<PaymentReceiptScreens> createState() => _PaymentReceiptScreensState();
}

class _PaymentReceiptScreensState extends State<PaymentReceiptScreens> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        context.read<PayreceiptController>().init(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 800) {
        return Scaffold(
          drawer: naviDrawer(),
          body: ChangeNotifierProvider<PayreceiptController>(
              create: (context) => PayreceiptController(),
              builder: (context, child) {
                return Consumer<PayreceiptController>(
                    builder: (BuildContext context, prdSCD, Widget? child) {
                  return SafeArea(
                    child: MobPaymentReceipt(payCD: prdSCD),
                  );
                });
              }),
        );
      } else {
        return WillPopScope(
          onWillPop: context.read<PayreceiptController>().onbackpress,
          child: Scaffold(
              // resizeToAvoidBottomInset: false,
              drawer: naviDrawer(),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                    AppBar(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Payment Receipt'),
                          Row(
                            children: [
                              StatefulBuilder(builder: (context, st) {
                                return GestureDetector(
                                  onTap: () {
                                    st(() {
                                      context
                                          .read<PayreceiptController>()
                                          .searchInitMethod();
                                      context
                                          .read<PayreceiptController>()
                                          .callSearchHeaderApi();
                                      // context
                                      //     .read<PayreceiptController>()
                                      //     .getSalesDataDatewise(
                                      //         context
                                      //             .read<PayreceiptController>()
                                      //             .config
                                      //             .alignDate(context
                                      //                 .read<PayreceiptController>()
                                      //                 .config
                                      //                 .currentDate()),
                                      //         context
                                      //             .read<PayreceiptController>()
                                      //             .config
                                      //             .alignDate(context
                                      //                 .read<PayreceiptController>()
                                      //                 .config
                                      //                 .currentDate()));
                                      // context
                                      //     .read<PayreceiptController>()
                                      //     .getSalesDataDatewise(
                                      //         context
                                      //             .read<PayreceiptController>()
                                      //             .config
                                      //             .alignDate(context
                                      //                 .read<PayreceiptController>()
                                      //                 .config
                                      //                 .currentDate()),
                                      // context
                                      //     .read<PayreceiptController>()
                                      //     .config
                                      //             .alignDate(context
                                      //                 .read<PayreceiptController>()
                                      //                 .config
                                      //                 .currentDate()));
                                    });
                                    context
                                        .read<PayreceiptController>()
                                        .loadSearch = false;
                                    showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                  payMent: 'Search',
                                                  buttonName: null,
                                                  widget:
                                                      PaymentRecieptSearhBox(
                                                    theme: theme,
                                                    searchHeight:
                                                        Screens.bodyheight(
                                                                context) *
                                                            0.76,
                                                    searchWidth:
                                                        Screens.width(context),
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
                                );
                              }),
                              SizedBox(width: Screens.width(context) * 0.02),
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                                payMent: 'Draft bills',
                                                buttonName: null,
                                                widget: context
                                                        .read<
                                                            PayreceiptController>()
                                                        .onHoldFilter!
                                                        .isEmpty
                                                    ? ContentContainer(
                                                        content:
                                                            " No Draft bills",
                                                        theme: theme)
                                                    : StatefulBuilder(
                                                        builder: (context, st) {
                                                        return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Container(
                                                                width: Screens
                                                                        .width(
                                                                            context) *
                                                                    1.1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          240,
                                                                          235,
                                                                          235)),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              3),
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.01),
                                                                ),
                                                                child:
                                                                    TextFormField(
                                                                  controller: context
                                                                      .read<
                                                                          PayreceiptController>()
                                                                      .mycontroller[2],
                                                                  cursorColor:
                                                                      Colors
                                                                          .grey,
                                                                  onChanged:
                                                                      (v) {
                                                                    st(() {
                                                                      context
                                                                          .read<
                                                                              PayreceiptController>()
                                                                          .filterListOnHold(
                                                                              v);
                                                                    });
                                                                  },
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        'Search..!!',
                                                                    hintStyle: theme
                                                                        .textTheme
                                                                        .bodyLarge
                                                                        ?.copyWith(
                                                                            color:
                                                                                Colors.grey),
                                                                    filled:
                                                                        false,
                                                                    enabledBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    focusedBorder:
                                                                        InputBorder
                                                                            .none,
                                                                    contentPadding:
                                                                        const EdgeInsets
                                                                            .symmetric(
                                                                      vertical:
                                                                          12,
                                                                      horizontal:
                                                                          25,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: Screens
                                                                          .bodyheight(
                                                                              context) *
                                                                      0.05),
                                                              SizedBox(
                                                                  height: Screens
                                                                          .bodyheight(
                                                                              context) *
                                                                      0.7,
                                                                  width: Screens
                                                                          .width(
                                                                              context) *
                                                                      1.1,
                                                                  child: ListView
                                                                      .builder(
                                                                          itemCount: context
                                                                              .watch<
                                                                                  PayreceiptController>()
                                                                              .onHoldFilter!
                                                                              .length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return Card(
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(top: Screens.bodyheight(context) * 0.01, left: Screens.width(context) * 0.01, right: Screens.width(context) * 0.01, bottom: Screens.bodyheight(context) * 0.03),
                                                                                child: ListTile(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    context.read<PayreceiptController>().mapHoldValues(index, context, theme);
                                                                                  },
                                                                                  title: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Text(context.watch<PayreceiptController>().onHoldFilter![index].cardCode ?? ''),
                                                                                          Text(context.watch<PayreceiptController>().config.aligntimeDate(context.watch<PayreceiptController>().onHoldFilter![index].createdateTime.toString())),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Text(context.watch<PayreceiptController>().onHoldFilter![index].custName ?? ''),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        child:
                                            const Icon(Icons.ballot_outlined)),
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
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Account Refresh',
                                              buttonName: null,
                                              widget: ContentContainer(
                                                  content: "Account Refresh",
                                                  theme: theme),
                                            ));
                                      });
                                },
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        child: const Icon(
                                            Icons.autorenew_outlined)),
                                    Text(
                                      "Account Refresh",
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
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Print',
                                              buttonName: null,
                                              widget: ContentContainer(
                                                  content: "Print",
                                                  theme: theme),
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
                                        child:
                                            const Icon(Icons.print_outlined)),
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
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Access Til',
                                              buttonName: null,
                                              widget: ContentContainer(
                                                  content: "Access Til",
                                                  theme: theme),
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
                                        child: const Icon(
                                            Icons.auto_mode_outlined)),
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
                                            contentPadding:
                                                const EdgeInsets.all(0),
                                            content: AlertBox(
                                              payMent: 'Dual Screen',
                                              buttonName: null,
                                              widget: ContentContainer(
                                                  content: "Dual Screen",
                                                  theme: theme),
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
                                        child: const Icon(
                                            Icons.screenshot_outlined)),
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
                    ),
                    PaymentTab(
                      theme: theme,
                    ),
                  ]),
                ),
              )),
        );
      }
    });
  }
}
