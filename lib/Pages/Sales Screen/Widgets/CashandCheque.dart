import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Widgets/ContentContainer.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class CashWidget extends StatelessWidget {
  CashWidget({
    super.key,
    required this.theme,
    required this.cashHeight,
    required this.cashWidth,
  });
  double cashHeight;
  double cashWidth;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.only(
          top: cashHeight * 0.01,
          left: cashHeight * 0.01,
          right: cashHeight * 0.01,
          bottom: cashHeight * 0.01),
      width: cashWidth,
      height: cashHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: context.read<PosController>().selectedcust != null &&
                        context
                                .read<PosController>()
                                .selectedcust!
                                .paymentGroup !=
                            null &&
                        context
                                .read<PosController>()
                                .selectedcust!
                                .paymentGroup!
                                .contains('cash') ==
                            false
                    ? null
                    : () {
                        context.read<PosController>().nullErrorMsg();

                        if (context
                            .read<PosController>()
                            .getScanneditemData
                            .isEmpty) {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(0),
                                    content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: Center(
                                            child: ContentContainer(
                                          content: 'Choose Product..!!',
                                          theme: theme,
                                        )),
                                        buttonName: null));
                              });
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Payment Mode - Cash',
                                        widget: forCashDialog(
                                          context,
                                        ),
                                        buttonName: 'OK',
                                        callback: () {
                                          st(
                                            () {
                                              context
                                                  .read<PosController>()
                                                  .addEnteredAmtType('Cash',
                                                      context, 1, theme);
                                            },
                                          );
                                        },
                                      ));
                                });
                              });
                        }
                        context.read<PosController>().disableKeyBoard(context);
                      },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        top: cashHeight * 0.01,
                        left: cashHeight * 0.01,
                        right: cashHeight * 0.01,
                        bottom: cashHeight * 0.01),
                    height: cashHeight * 0.29,
                    width: cashWidth * 0.25,
                    decoration: BoxDecoration(
                      color:
                          context.read<PosController>().selectedcust != null &&
                                  context
                                          .read<PosController>()
                                          .selectedcust!
                                          .paymentGroup !=
                                      null &&
                                  context
                                          .read<PosController>()
                                          .selectedcust!
                                          .paymentGroup!
                                          .contains('cash') ==
                                      false
                              ? Colors.grey.withOpacity(0.2)
                              : theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: cashHeight * 0.01,
                                right: cashHeight * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                image: AssetImage("assets/Cashpng.png"),
                              ),
                            ),
                            alignment: Alignment.center,
                            height: cashHeight * 0.13,
                            width: cashWidth * 0.05,
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              width: cashWidth * 0.17,
                              child: Text(
                                "Cash",
                                style: theme.textTheme.bodyMedium,
                              )),
                        ])),
              ),
              GestureDetector(
                  onTap: context.read<PosController>().selectedcust != null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup !=
                              null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup!
                                  .contains('cash') ==
                              false
                      ? null
                      : () {
                          context.read<PosController>().nullErrorMsg();
                          context.read<PosController>().selectedBankType = null;

                          if (context
                              .read<PosController>()
                              .getScanneditemData
                              .isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose Product..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(
                                                () {
                                                  context
                                                      .read<PosController>()
                                                      .addEnteredAmtType(
                                                          'Cheque',
                                                          context,
                                                          2,
                                                          theme);
                                                },
                                              );
                                            },
                                            payMent: 'Payment Mode - Cheque',
                                            widget: forCheque(
                                              context,
                                            ),
                                            buttonName: 'OK'));
                                  });
                                });
                          }
                          context
                              .read<PosController>()
                              .disableKeyBoard(context);
                        },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: context.read<PosController>().selectedcust !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup!
                                        .contains('cash') ==
                                    false
                            ? Colors.grey.withOpacity(0.2)
                            : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: cashHeight * 0.13,
                                width: cashWidth * 0.04,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 155, 65, 228),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                  size: cashHeight * 0.1,
                                )),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: cashWidth * 0.17,
                              child: Text("Cheque",
                                  style:
                                      theme.textTheme.bodyMedium?.copyWith()),
                            ),
                          ]))),
              GestureDetector(
                  onTap: context.read<PosController>().selectedcust != null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup !=
                              null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup!
                                  .contains('cash') ==
                              false
                      ? null
                      : () {
                          context.read<PosController>().nullErrorMsg();
                          if (context
                              .read<PosController>()
                              .getScanneditemData
                              .isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose Product..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                          callback: () {
                                            st(
                                              () {
                                                context
                                                    .read<PosController>()
                                                    .addEnteredAmtType('Card',
                                                        context, 3, theme);
                                              },
                                            );
                                          },
                                          payMent: 'Payment Mode - Card',
                                          widget: forCard(
                                            context,
                                            "Card",
                                          ),
                                          buttonName: 'OK',
                                        ));
                                  });
                                });
                          }
                          context
                              .read<PosController>()
                              .disableKeyBoard(context);
                        },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: context.read<PosController>().selectedcust !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup!
                                        .contains('cash') ==
                                    false
                            ? Colors.grey.withOpacity(0.2)
                            : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: cashHeight * 0.12,
                              width: cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/creditIcon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: cashWidth * 0.17,
                              child: Text("Card",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: context.read<PosController>().selectedcust != null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup !=
                              null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup!
                                  .contains('cash') ==
                              false
                      ? null
                      : () {
                          context.read<PosController>().nullErrorMsg();
                          if (context
                              .read<PosController>()
                              .getScanneditemData
                              .isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose Product..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<PosController>()
                                                    .addEnteredAmtType('Wallet',
                                                        context, 5, theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Wallet',
                                            widget: forwallet(
                                              context,
                                            ),
                                            buttonName: 'OK'));
                                  });
                                });
                          }
                          context
                              .read<PosController>()
                              .disableKeyBoard(context);
                        },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: context.read<PosController>().selectedcust !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup!
                                        .contains('cash') ==
                                    false
                            ? Colors.grey.withOpacity(0.2)
                            : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: cashHeight * 0.12,
                              width: cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/NetIcon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: cashWidth * 0.17,
                              child: Text("Wallet",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
              GestureDetector(
                  onTap: context.read<PosController>().selectedcust != null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup !=
                              null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup!
                                  .contains('cash') ==
                              false
                      ? null
                      : () {
                          context.read<PosController>().nullErrorMsg();
                          if (context
                              .read<PosController>()
                              .getScanneditemData
                              .isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose Product..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<PosController>()
                                                    .addEnteredAmtType(
                                                        'Transfer',
                                                        context,
                                                        4,
                                                        theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Transfer',
                                            widget: forTransfer(
                                              context,
                                            ),
                                            buttonName: 'OK'));
                                  });
                                });
                          }
                          context
                              .read<PosController>()
                              .disableKeyBoard(context);
                        },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: context.read<PosController>().selectedcust !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup!
                                        .contains('cash') ==
                                    false
                            ? Colors.grey.withOpacity(0.2)
                            : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: cashHeight * 0.12,
                              width: cashWidth * 0.05,
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                  image: AssetImage("assets/upiicon.png"),
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              width: cashWidth * 0.17,
                              child: Text("Transfer",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black)),
                            ),
                          ]))),
              GestureDetector(
                  onTap: () async {
                    // context.read<PosController>().nullErrorMsg();

                    // if (context.read<PosController>().selectedcust == null) {
                    //   showDialog(
                    //       context: context,
                    //       barrierDismissible: true,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //             contentPadding: const EdgeInsets.all(0),
                    //             content: AlertBox(
                    //                 payMent: 'Alert',
                    //                 errormsg: true,
                    //                 widget: Center(
                    //                     child: ContentContainer(
                    //                   content: 'Choose cusotmer..!!',
                    //                   theme: theme,
                    //                 )),
                    //                 buttonName: null));
                    //       });
                    // } else if (context
                    //     .read<PosController>()
                    //     .getScanneditemData
                    //     .isEmpty) {
                    //   showDialog(
                    //       context: context,
                    //       barrierDismissible: true,
                    //       builder: (BuildContext context) {
                    //         return AlertDialog(
                    //             contentPadding: const EdgeInsets.all(0),
                    //             content: AlertBox(
                    //                 payMent: 'Alert',
                    //                 errormsg: true,
                    //                 widget: Center(
                    //                     child: ContentContainer(
                    //                   content: 'Choose Product..!!',
                    //                   theme: theme,
                    //                 )),
                    //                 buttonName: null));
                    //       });
                    // } else {
                    //   context.read<PosController>().schemebtnclk = true;
                    //   await context
                    //       .read<PosController>()
                    //       .scehmeapiforckout(context, theme);
                    // }
                    // context.read<PosController>().disableKeyBoard(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        // context.read<PosController>().selectedcust !=
                        //             null &&
                        //         context
                        //                 .read<PosController>()
                        //                 .selectedcust!
                        //                 .paymentGroup !=
                        //             null &&
                        //         context
                        //                 .read<PosController>()
                        //                 .selectedcust!
                        //                 .paymentGroup!
                        //                 .contains('cash') ==
                        //             false
                        //     ? Colors.grey.withOpacity(0.2)
                        //     : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: cashHeight * 0.4,
                            width: cashWidth * 0.05,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage("assets/disssccimg.png"),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          SizedBox(
                            width: cashWidth * 0.17,
                            child: Text("Scheme",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black)),
                          ),
                        ],
                      ))),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: context.read<PosController>().selectedcust != null &&
                        context
                                .read<PosController>()
                                .selectedcust!
                                .paymentGroup !=
                            null &&
                        context
                                .read<PosController>()
                                .selectedcust!
                                .paymentGroup!
                                .contains('cash') ==
                            false
                    ? null
                    : () {
                        context.read<PosController>().nullErrorMsg();
                        if (context.read<PosController>().getselectedcust ==
                            null) {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: Center(
                                          child: ContentContainer(
                                        content: 'Choose customer..!!',
                                        theme: theme,
                                      )),
                                      buttonName: null,
                                    ));
                              });
                        } else if (context
                            .read<PosController>()
                            .getScanneditemData
                            .isEmpty) {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(0),
                                    content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: Center(
                                            child: ContentContainer(
                                          content: 'Choose Product..!!',
                                          theme: theme,
                                        )),
                                        buttonName: null));
                              });
                        } else {
                          context.read<PosController>().mycontroller[37].text =
                              context
                                  .read<PosController>()
                                  .getselectedcust!
                                  .point!;
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        callback: () {
                                          st(() {
                                            context
                                                .read<PosController>()
                                                .addEnteredAmtType(
                                                    'Points Redemption',
                                                    context,
                                                    8,
                                                    theme);
                                          });
                                        },
                                        buttonName: 'OK',
                                        payMent:
                                            'Payment Mode - Points Redemption',
                                        widget: forPoints(
                                          context,
                                        ),
                                      ));
                                });
                              });
                        }
                        context.read<PosController>().disableKeyBoard(context);
                      },
                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: cashHeight * 0.01, right: cashHeight * 0.01),
                    height: cashHeight * 0.29,
                    width: cashWidth * 0.25,
                    decoration: BoxDecoration(
                      color:
                          context.read<PosController>().selectedcust != null &&
                                  context
                                          .read<PosController>()
                                          .selectedcust!
                                          .paymentGroup !=
                                      null &&
                                  context
                                          .read<PosController>()
                                          .selectedcust!
                                          .paymentGroup!
                                          .contains('cash') ==
                                      false
                              ? Colors.grey.withOpacity(0.2)
                              : theme.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text("Point Redemption",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black))),
              ),
              GestureDetector(
                onTap:
                    // context.read<PosController>().selectedcust != null &&
                    //         context
                    //                 .read<PosController>()
                    //                 .selectedcust!
                    //                 .paymentGroup !=
                    //             null &&
                    //         context
                    //                 .read<PosController>()
                    //                 .selectedcust!
                    //                 .paymentGroup!
                    //                 .contains('cash') ==
                    //             true
                    //     ? null
                    //     :
                    () {
                  context.read<PosController>().nullErrorMsg();

                  if (context.read<PosController>().selectedcust == null) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: AlertBox(
                                  payMent: 'Alert',
                                  errormsg: true,
                                  widget: Center(
                                      child: ContentContainer(
                                    content: 'Choose Customer..!!',
                                    theme: theme,
                                  )),
                                  buttonName: null));
                        });
                  } else if (context
                      .read<PosController>()
                      .getScanneditemData
                      .isEmpty) {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              contentPadding: const EdgeInsets.all(0),
                              content: AlertBox(
                                  payMent: 'Alert',
                                  errormsg: true,
                                  widget: Center(
                                      child: ContentContainer(
                                    content: 'Choose Product..!!',
                                    theme: theme,
                                  )),
                                  buttonName: null));
                        });
                  } else {
                    context.read<PosController>().mycontroller[35].text =
                        context
                            .read<PosController>()
                            .selectedcust!
                            .accBalance
                            .toString();
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(builder: (context, st) {
                            return AlertDialog(
                                contentPadding: const EdgeInsets.all(0),
                                content: AlertBox(
                                    callback: () {
                                      st(() {
                                        context
                                            .read<PosController>()
                                            .adjamt(context, theme);
                                      });
                                    },
                                    payMent: 'Payment Mode - Account Balance',
                                    widget: forAccBal(context),
                                    buttonName: 'OK'));
                          });
                        });
                  }
                  context.read<PosController>().disableKeyBoard(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                      left: cashHeight * 0.01, right: cashHeight * 0.01),
                  height: cashHeight * 0.29,
                  width: cashWidth * 0.25,
                  decoration: BoxDecoration(
                    color:
                        // context.read<PosController>().selectedcust != null &&
                        //         context
                        //                 .read<PosController>()
                        //                 .selectedcust!
                        //                 .paymentGroup !=
                        //             null &&
                        //         context
                        //                 .read<PosController>()
                        //                 .selectedcust!
                        //                 .paymentGroup!
                        //                 .contains('cash') ==
                        //             true
                        //     ? Colors.grey.withOpacity(0.2)
                        //     :
                        theme.primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text("Account Balance",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.black)),
                ),
              ),
              GestureDetector(
                  onTap: context.read<PosController>().selectedcust != null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup !=
                              null &&
                          context
                                  .read<PosController>()
                                  .selectedcust!
                                  .paymentGroup!
                                  .contains('cash') ==
                              true
                      ? null
                      : () {
                          context.read<PosController>().nullErrorMsg();
                          if (context
                              .read<PosController>()
                              .getScanneditemData
                              .isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                          payMent: 'Alert',
                                          errormsg: true,
                                          widget: Center(
                                              child: ContentContainer(
                                            content: 'Choose Product..!!',
                                            theme: theme,
                                          )),
                                          buttonName: null));
                                });
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        contentPadding: const EdgeInsets.all(0),
                                        content: AlertBox(
                                            callback: () {
                                              st(() {
                                                context
                                                    .read<PosController>()
                                                    .addEnteredAmtType('Credit',
                                                        context, 10, theme);
                                              });
                                            },
                                            payMent: 'Payment Mode - Credit',
                                            widget: forCredit(
                                              context,
                                            ),
                                            buttonName: 'OK'));
                                  });
                                });
                          }
                          context
                              .read<PosController>()
                              .disableKeyBoard(context);
                        },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          left: cashHeight * 0.01, right: cashHeight * 0.01),
                      height: cashHeight * 0.29,
                      width: cashWidth * 0.25,
                      decoration: BoxDecoration(
                        color: context.read<PosController>().selectedcust !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup !=
                                    null &&
                                context
                                        .read<PosController>()
                                        .selectedcust!
                                        .paymentGroup!
                                        .contains('cash') ==
                                    true
                            ? Colors.grey.withOpacity(0.2)
                            : theme.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text("Credit",
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black))))
            ],
          ),
        ],
      ),
    );
  }

  forCashDialog(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.05,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<PosController>().formkeyy[1],
              child: Column(
                children: [
                  SizedBox(height: cashHeight * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Amount'),
                      SizedBox(width: cashWidth * 0.02),
                      IconButton(
                          onPressed: () {
                            context.read<PosController>().cpyBtnclik(22);
                          },
                          icon: const Icon(
                            Icons.copy,
                          )),
                      SizedBox(width: cashWidth * 0.03),
                      Container(
                        width: cashWidth * 0.65,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.withOpacity(0.001),
                        ),
                        child: TextFormField(
                          autofocus: true,
                          controller:
                              context.read<PosController>().mycontroller[22],
                          cursorColor: Colors.grey,
                          inputFormatters: [DecimalInputFormatter()],
                          onChanged: (v) {
                            context
                                .read<PosController>()
                                .doubleDotMethodPayTerms(22, v);
                          },
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' Please Enter the Amount';
                            } else {
                              return null;
                            }
                          },
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
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Enter the Amount',
                            hintStyle: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey),
                            filled: false,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  forCheque(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.05,
            left: cashHeight * 0.05,
            right: cashHeight * 0.05,
            bottom: cashHeight * 0.05),
        width: cashWidth * 1.1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.watch<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.watch<PosController>().formkeyy[2],
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Cheque No"),
                          ),
                          Container(
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [DecimalInputFormatter()],
                              autofocus: true,
                              controller: context
                                  .read<PosController>()
                                  .mycontroller[23],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: ((value) {
                                if (value!.isEmpty) {
                                  return " Please Enter Cheque Number";
                                } else if (value.length < 6) {
                                  return " Please Enter a 6 digit Cheque Number";
                                } else {
                                  return null;
                                }
                              }),
                              maxLength: 6,
                              decoration: InputDecoration(
                                counterText: '',
                                filled: false,
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
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Cheque Date"),
                          ),
                          Container(
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              onTap: () {
                                context
                                    .read<PosController>()
                                    .getDate(context, 'Cheque');
                              },
                              autofocus: true,
                              readOnly: true,
                              controller: context
                                  .read<PosController>()
                                  .mycontroller[24],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return '  Please Enter the Cheque Date';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      context
                                          .read<PosController>()
                                          .getDate(context, 'Cheque');
                                    },
                                    icon: const Icon(Icons.date_range)),
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Bank Name"),
                          ),
                          SizedBox(height: cashHeight * 0.05),
                          Container(
                            width: cashWidth * 0.7,
                            padding: EdgeInsets.only(
                              left: cashHeight * 0.01,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: context
                                              .read<PosController>()
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
                                                  .read<PosController>()
                                                  .getbankhintcolor ==
                                              true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: context
                                    .read<PosController>()
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
                                    .read<PosController>()
                                    .selectedBankType,
                                onChanged: (value) {
                                  st(() {
                                    context
                                        .read<PosController>()
                                        .selectedBankType = value;
                                    context
                                        .read<PosController>()
                                        .getSelectbankCode(context
                                            .read<PosController>()
                                            .selectedBankType
                                            .toString());
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: cashWidth * 0.35,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      context
                                          .read<PosController>()
                                          .cpyBtnclik(25);
                                    },
                                    icon: const Icon(
                                      Icons.copy,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: context
                                  .read<PosController>()
                                  .mycontroller[25],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              keyboardType: TextInputType.number,
                              inputFormatters: [DecimalInputFormatter()],
                              onChanged: (v) {
                                context
                                    .read<PosController>()
                                    .doubleDotMethodPayTerms(25, v);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Amount';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cashHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Remarks"),
                          ),
                          Container(
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              autofocus: true,
                              controller: context
                                  .read<PosController>()
                                  .mycontroller[26],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              decoration: InputDecoration(
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ])),
          ],
        ),
      );
    });
  }

  forCard(
    BuildContext context,
    String cardType,
  ) {
    final theme = Theme.of(context);

    return StatefulBuilder(builder: (context, st) {
      return Container(
        color: Colors.white,
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.05,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.read<PosController>().formkeyy[3],
                child: Column(
                  children: [
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Payment Terminal"),
                        ),
                        SizedBox(height: cashHeight * 0.05),
                        Container(
                          width: cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: cashHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                'Select Payment Terminal',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                                .read<PosController>()
                                                .gethintcolor ==
                                            true
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              items: context
                                  .read<PosController>()
                                  .getpayTerminal
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: context.read<PosController>().paymentterm,
                              onChanged: (value) {
                                st(() {
                                  context.read<PosController>().paymentterm =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Approval No"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[27],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Approval Number';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Card Reference"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            controller:
                                context.read<PosController>().mycontroller[28],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Card Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<PosController>()
                                        .cpyBtnclik(29);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[29],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(29, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      );
    });
  }

  forTransfer(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.watch<PosController>().formkeyy[4],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Trans Type"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: cashHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                'Select Trans Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context
                                              .read<PosController>()
                                              .gethintcolor ==
                                          false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: context
                                  .read<PosController>()
                                  .gettransType
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value:
                                  context.watch<PosController>().selectedType,
                              onChanged: (value) {
                                st(() {
                                  context.read<PosController>().selectedType =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Trans Reference"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[30],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Trans Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    st(() {
                                      context
                                          .read<PosController>()
                                          .cpyBtnclik(31);
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(width: cashWidth * 0.03),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[31],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(31, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }

  forwallet(
    BuildContext context,
  ) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
                key: context.watch<PosController>().formkeyy[5],
                child: Column(
                  children: [
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Wallet"),
                        ),
                        SizedBox(height: cashHeight * 0.05),
                        Container(
                          width: cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: cashHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                'Select Wallet Type',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: context
                                                .read<PosController>()
                                                .gethintcolor ==
                                            true
                                        ? Colors.red
                                        : Colors.grey),
                              ),
                              items: context
                                  .read<PosController>()
                                  .walletlist
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: context.watch<PosController>().wallet,
                              onChanged: (value) {
                                st(() {
                                  context.read<PosController>().wallet = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Waller ID"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[32],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Wallet ID';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Payment Reference"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[33],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Payment Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              SizedBox(width: cashWidth * 0.02),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<PosController>()
                                        .cpyBtnclik(34);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(width: cashWidth * 0.03),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[34],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(34, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ),
      );
    });
  }

  forAccBal(BuildContext context) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.watch<PosController>().formkeyy[7],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Available Balance"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                context.read<PosController>().mycontroller[35],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Account Balance';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Amount to Adjust"),
                        ),
                        IconButton(
                            onPressed: () {
                              context.read<PosController>().cpyBtnclik(36);
                            },
                            icon: Icon(Icons.copy)),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.allow(
                            //       RegExp(r"[0-9.]")),
                            // ],
                            controller:
                                context.read<PosController>().mycontroller[36],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Adjust Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: cashHeight * 0.05),
          ],
        ),
      );
    });
  }

  forPoints(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<PosController>().formkeyy[8],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Available Points"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller:
                                context.read<PosController>().mycontroller[37],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Points to Redeem"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            onEditingComplete: () {
                              st(() {
                                context.read<PosController>().pointconvert();
                              });
                              context
                                  .read<PosController>()
                                  .disableKeyBoard(context);
                            },
                            controller:
                                context.read<PosController>().mycontroller[38],
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            autofocus: true,
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Redeem points';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    InkWell(
                      onTap: () {
                        st(() {
                          context.read<PosController>().pointconvert();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: cashHeight * 0.25,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Convert points to redeem",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            onTap: () {
                              st(() {
                                context.read<PosController>().pointconvert();
                              });
                            },
                            controller:
                                context.read<PosController>().mycontroller[40],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(40, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }

  forDiscount(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.watch<PosController>().formkeyy[9],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Finance Type"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          padding: EdgeInsets.only(
                            left: cashHeight * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              focusColor: Colors.white,
                              hint: Text(
                                'Select Finance Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context
                                              .read<PosController>()
                                              .gethintcolor ==
                                          false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: context
                                  .read<PosController>()
                                  .getdiscountType
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: context.watch<PosController>().discount,
                              onChanged: (value) {
                                st(() {
                                  context.read<PosController>().discount =
                                      value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Finance Reference"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[41],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Discount Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<PosController>()
                                        .cpyBtnclik(42);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[42],
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(42, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }

  forCredit(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: cashWidth * 1.1,
        padding: EdgeInsets.only(
            top: cashHeight * 0.02,
            left: cashHeight * 0.1,
            right: cashHeight * 0.1,
            bottom: cashHeight * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.read<PosController>().getmsgforAmount == null
                  ? ''
                  : "${context.watch<PosController>().getmsgforAmount}",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
            ),
            Form(
              key: context.read<PosController>().formkeyy[10],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Credit Reference"),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[43],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Credit Reference';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Recovery Date"),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: cashWidth * 0.7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: context
                                  .read<PosController>()
                                  .mycontroller[44],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              onTap: () {
                                context
                                    .read<PosController>()
                                    .recoveryGetDate(context, 'Credit');
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Recovery Date';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: const Icon(Icons.date_range),
                                filled: false,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: cashHeight * 0.05),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: cashWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<PosController>()
                                        .cpyBtnclik(45);
                                  },
                                  icon: const Icon(
                                    Icons.copy,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: cashWidth * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller:
                                context.read<PosController>().mycontroller[45],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            inputFormatters: [DecimalInputFormatter()],
                            onChanged: (v) {
                              context
                                  .read<PosController>()
                                  .doubleDotMethodPayTerms(45, v);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Amount';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              filled: false,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      );
    });
  }
}
