import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../../../Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';
import '../../../../../../Widgets/ContentContainer.dart';
import '../../../../../ForgotPassword/widgets/custom_shake_transtition.dart';
import '../../../../../../Widgets/AlertBox.dart';

class PayReceipt_PayTypeWidget extends StatelessWidget {
  PayReceipt_PayTypeWidget(
      {super.key,
      required this.theme,
      required this.payHeight,
      required this.payWidth,
      required this.paycon});

  final ThemeData theme;
  double payHeight;
  double payWidth;
  PayreceiptController paycon;
  @override
  Widget build(BuildContext context) {
    return CustomShakeTransition(
      duration: const Duration(milliseconds: 1500),
      child: Container(
        height: Screens.padingHeight(context) * 0.28,
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  // behavior: HitTestBehavior.translucent,
                  onTap: () {
                    paycon.nullErrorMsg();

                    paycon.scanneditemData.isEmpty &&
                            paycon.selectedcust != null &&
                            paycon.advancetype != "Advance"
                        ? showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return StatefulBuilder(builder: (context, st) {
                                return AlertDialog(
                                    contentPadding: const EdgeInsets.all(0),
                                    content: AlertBox(
                                      payMent: 'Alert',
                                      errormsg: true,
                                      widget: ContentContainer(
                                          content: 'Choose Advance Mode',
                                          theme: theme),
                                      buttonName: null,
                                    ));
                              });
                            })
                        : paycon.getselectedcust == null
                            ? paycon.foraccselect(context, theme, "")
                            : showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      // backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(
                                          Screens.bodyheight(context) * 0.02),
                                      content: forCashDialog(
                                          context, paycon, theme));
                                  // forCashConfirm(context, paycon theme));
                                });
                    // }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(
                          top: Screens.padingHeight(context) * 0.01,
                          left: Screens.width(context) * 0.01,
                          right: Screens.width(context) * 0.01,
                          bottom: Screens.padingHeight(context) * 0.01),
                      height: Screens.padingHeight(context) * 0.08,
                      width: Screens.width(context) * 0.3,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: Screens.width(context) * 0.01,
                                  right: Screens.width(context) * 0.01),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: const DecorationImage(
                                  image: AssetImage("assets/Cashpng.png"),
                                ),
                              ),
                              alignment: Alignment.center,
                              height: Screens.padingHeight(context) * 0.13,
                              width: Screens.width(context) * 0.05,
                            ),
                            SizedBox(
                              width: Screens.width(context) * 0.02,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                width: Screens.width(context) * 0.17,
                                child: Text(
                                  "Cash",
                                  style: theme.textTheme.bodyMedium,
                                )),
                          ])),
                ),
                GestureDetector(
                    onTap: () {
                      paycon.nullErrorMsg();

                      paycon.scanneditemData.isEmpty &&
                              paycon.selectedcust != null &&
                              paycon.advancetype != "Advance"
                          ? showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: ContentContainer(
                                            content: 'Choose Advance Mode',
                                            theme: theme),
                                        buttonName: null,
                                      ));
                                });
                              })
                          : paycon.getselectedcust == null
                              ? paycon.foraccselect(context, theme, "")
                              // : paycon.totalduepay == 0
                              //     ? paycon.foracctotaldue(context, theme)
                              : showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      // backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(
                                          Screens.bodyheight(context) * 0.02),
                                      content:
                                          forCheque(context, paycon, theme),
                                    );
                                  });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01),
                        height: Screens.padingHeight(context) * 0.08,
                        width: Screens.width(context) * 0.3,
                        decoration: BoxDecoration(
                          // color: Colors.yellow,
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card,
                                color: const Color.fromARGB(255, 155, 65, 228),
                                size: Screens.padingHeight(context) * 0.035,
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.02,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Cheque",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith()),
                              ),
                            ]))),
                GestureDetector(
                    // behavior: HitTestBehavior.translucent,
                    onTap: () {
                      paycon.nullErrorMsg();

                      paycon.scanneditemData.isEmpty &&
                              paycon.selectedcust != null &&
                              paycon.advancetype != "Advance"
                          ? showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: ContentContainer(
                                            content: 'Choose Advance Mode',
                                            theme: theme),
                                        buttonName: null,
                                      ));
                                });
                              })
                          : paycon.getselectedcust == null
                              ? paycon.foraccselect(context, theme, "")
                              // : paycon.totalduepay == 0
                              // ? paycon.foracctotaldue(context, theme)
                              : showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      // backgroundColor: Colors.transparent,
                                      insetPadding: EdgeInsets.all(
                                          Screens.bodyheight(context) * 0.02),
                                      content: forCard(context, "Card", paycon),
                                      // AlertBox(
                                      //   callback: () {
                                      //     st(
                                      //       () {
                                      //         prdCD.addEnteredAmtType(
                                      //             'Card', context, 3, theme);
                                      //       },
                                      //     );
                                      //   },
                                      //   payMent: 'Payment Mode - Card',
                                      //   widget:
                                      //       forCard(context, "Card", prdCD),
                                      //   buttonName: 'OK',
                                      // )
                                    );
                                  });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01),
                        height: Screens.padingHeight(context) * 0.08,
                        width: Screens.width(context) * 0.3,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Screens.padingHeight(context) * 0.12,
                                width: Screens.width(context) * 0.05,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("assets/creditIcon.png"),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.02,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Card",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ),
                            ]))),
              ],
            ),
            //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      paycon.nullErrorMsg();

                      paycon.scanneditemData.isEmpty &&
                              paycon.selectedcust != null &&
                              paycon.advancetype != "Advance"
                          ? showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: ContentContainer(
                                            content: 'Choose Advance Mode',
                                            theme: theme),
                                        buttonName: null,
                                      ));
                                });
                              })
                          : paycon.getselectedcust == null
                              ? paycon.foraccselect(context, theme, "")
                              // : paycon.totalduepay == 0
                              //     ? paycon.foracctotaldue(context, theme)
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, st) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        contentPadding: const EdgeInsets.all(0),
                                        // backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.02),
                                        content:
                                            forwallet(context, paycon, theme),
                                        // AlertBox(
                                        //     callback: () {
                                        //       st(() {
                                        //         prdCD.addEnteredAmtType(
                                        //             'Wallet', context, 5, theme);
                                        //       });
                                        //     },
                                        //     payMent: 'Payment Mode - Wallet',
                                        //     widget: forwallet(context, prdCD,theme),
                                        //     buttonName: 'OK')
                                      );
                                    });
                                  });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01),
                        height: Screens.padingHeight(context) * 0.08,
                        width: Screens.width(context) * 0.3,
                        decoration: BoxDecoration(
                          // color: Colors.red,
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Screens.padingHeight(context) * 0.12,
                                width: Screens.width(context) * 0.05,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("assets/NetIcon.png"),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.02,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: Screens.width(context) * 0.17,
                                child: Text("Wallet",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ),
                            ]))),
                GestureDetector(
                    // behavior: HitTestBehavior.translucent,
                    onTap: () {
                      paycon.nullErrorMsg();

                      paycon.scanneditemData.isEmpty &&
                              paycon.selectedcust != null &&
                              paycon.advancetype != "Advance"
                          ? showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder: (context, st) {
                                  return AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      content: AlertBox(
                                        payMent: 'Alert',
                                        errormsg: true,
                                        widget: ContentContainer(
                                            content: 'Choose Advance Mode',
                                            theme: theme),
                                        buttonName: null,
                                      ));
                                });
                              })
                          : paycon.getselectedcust == null
                              ? paycon.foraccselect(context, theme, "")
                              // : paycon.totalduepay == 0
                              //     ? paycon.foracctotaldue(context, theme)
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, st) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        contentPadding: const EdgeInsets.all(0),
                                        // backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.02),
                                        content:
                                            forTransfer(context, paycon, theme),
                                        // AlertBox(
                                        //     callback: () {
                                        //       st(() {
                                        //         prdCD.addEnteredAmtType(
                                        //             'Transfer', context, 4, theme);
                                        //       });
                                        //     },
                                        //     payMent: 'Payment Mode - Transfer',
                                        //     widget: forTransfer(context, prdCD,theme),
                                        //     buttonName: 'OK')
                                      );
                                    });
                                  });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            top: Screens.padingHeight(context) * 0.01,
                            left: Screens.width(context) * 0.01,
                            right: Screens.width(context) * 0.01,
                            bottom: Screens.padingHeight(context) * 0.01),
                        height: Screens.padingHeight(context) * 0.08,
                        width: Screens.width(context) * 0.3,
                        decoration: BoxDecoration(
                          //  color: Colors.blue,
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height: Screens.padingHeight(context) * 0.12,
                                width: Screens.width(context) * 0.05,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                    image: AssetImage("assets/upiicon.png"),
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              SizedBox(
                                width: Screens.width(context) * 0.02,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                width: Screens.width(context) * 0.17,
                                child: Text("Transfer",
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black)),
                              ),
                            ]))),
                paycon.getScanneditemData.isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          paycon.nullErrorMsg();

                          paycon.scanneditemData.isEmpty &&
                                  paycon.selectedcust != null &&
                                  paycon.advancetype != "Advance"
                              ? showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, st) {
                                      return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          content: AlertBox(
                                            payMent: 'Alert',
                                            errormsg: true,
                                            widget: ContentContainer(
                                                content: 'Choose Advance Mode',
                                                theme: theme),
                                            buttonName: null,
                                          ));
                                    });
                                  })
                              : paycon.getselectedcust == null
                                  ? paycon.foraccselect(context, theme, "")
                                  // : paycon.totalduepay == 0
                                  //     ? paycon.foracctotaldue(context, theme)
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                            builder: (context, st) {
                                          return AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  4))),
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              // backgroundColor: Colors.transparent,
                                              insetPadding: EdgeInsets.all(
                                                  Screens.bodyheight(context) *
                                                      0.02),
                                              content:
                                                  forCoupons(context, paycon)
                                              //  AlertBox(
                                              //     callback: () {
                                              //       st(() {
                                              //         prdCD.addEnteredAmtType(
                                              //             'Coupons', context, 7, theme);
                                              //       });
                                              //     },
                                              //     payMent: 'Payment Mode - Coupons',
                                              //     widget: forCoupons(context, prdCD),
                                              //     buttonName: 'OK')
                                              );
                                        });
                                      });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01),
                            height: Screens.padingHeight(context) * 0.08,
                            width: Screens.width(context) * 0.3,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    height:
                                        Screens.padingHeight(context) * 0.13,
                                    width: Screens.width(context) * 0.05,
                                    decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: AssetImage("assets/NicePng.png"),
                                      ),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Screens.width(context) * 0.02,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text("Coupons",
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.black)),
                                  ),
                                ])))
                    : Container(
                        width: Screens.width(context) * 0.3,
                      ),
              ],
            ),
            //
            //
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [

            //   ],
            // ),
            // //
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                paycon.getScanneditemData.isNotEmpty
                    ? GestureDetector(
                        // behavior: HitTestBehavior.translucent,
                        onTap: () {
                          paycon.nullErrorMsg();

                          if (paycon.getselectedcust == null) {
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
                          } else {
                            log(" paycon.mycontroller[37].text=${paycon.getselectedcust!.point.toString().replaceAll(",", "")}");
                            paycon.mycontroller[37].text = paycon
                                .getselectedcust!.point
                                .toString()
                                .replaceAll(",", "");
                            //  posController.getselectedcust!.point!;

                            paycon.getselectedcust == null
                                ? paycon.foraccselect(context, theme, "")
                                // : paycon.totalduepay == 0
                                //     ? paycon.foracctotaldue(context, theme)
                                : showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        contentPadding: const EdgeInsets.all(0),
                                        // backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.all(
                                            Screens.bodyheight(context) * 0.02),
                                        content: forPoints(context, paycon),
                                      );
                                    });
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: Screens.padingHeight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                                bottom: Screens.padingHeight(context) * 0.01),
                            height: Screens.padingHeight(context) * 0.08,
                            width: Screens.width(context) * 0.3,
                            decoration: BoxDecoration(
                              // color: Colors.red,
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text("Point Redemption",
                                style: theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black))),
                      )
                    : Container(),
                // GestureDetector(
                //     onTap: () {
                //       paycon.nullErrorMsg();
                //       paycon.onAccPayment != 0
                //           ? paycon.mycontroller[55].text =
                //               paycon.onAccPayment.toString().replaceAll(",", "")
                //           : paycon.mycontroller[55].text = Paycon
                //               .getselectedcust!.accBalance
                //               .toString()
                //               .replaceAll(",", "");
                //       paycon.getselectedcust == null
                //           ? paycon.foraccselect(context, theme, "")
                //           // : paycon.totalduepay == 0
                //           // ? paycon.foracctotaldue(context, theme)
                //           : showDialog(
                //               context: context,
                //               builder: (BuildContext context) {
                //                 return AlertDialog(
                //                     contentPadding: EdgeInsets.all(0),
                //                     content: AlertBox(
                //                         callback: () {
                //                           paycon.addEnteredAmtType(
                //                               'Account Balance',
                //                               context,
                //                               9,
                //                               theme);
                //                         },
                //                         payMent: 'Account Balance',
                //                         widget: forAccBal(context, paycon),
                //                         buttonName: 'Accept'));
                //               });
                //       // paycon.onAccPayment != 0
                //       //     ? paycon.mycontroller[55].text =
                //       //         paycon.onAccPayment.toString()
                //       //                       .replaceAll(",", "")
                //       //     :
                //       // paycon.mycontroller[55].text = paycon.getselectedcust!.accBalance
                //       //                       .toString()
                //       //                       .replaceAll(",", "");
                //       // paycon.getselectcust!.accBalance.toString();
                //     },
                //     child: Container(
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.only(
                //             top: Screens.padingHeight(context) * 0.01,
                //             left: Screens.width(context) * 0.01,
                //             right: Screens.width(context) * 0.01,
                //             bottom: Screens.padingHeight(context) * 0.01),
                //         height: Screens.padingHeight(context) * 0.08,
                //         width: Screens.width(context) * 0.3,
                //         decoration: BoxDecoration(
                //           // color: Colors.red,
                //           color: Colors.grey[200],
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         child: Text("Account Balance",
                //             style: theme.textTheme.bodyText2
                //                 ?.copyWith(color: Colors.black)))),
                // GestureDetector(
                //     onTap: () {
                //       paycon.nullErrorMsg();

                //       paycon.getselectedcust == null
                //           ? paycon.foraccselect(context, theme, "")
                //           : showDialog(
                //               context: context,
                //               barrierDismissible: false,
                //               builder: (BuildContext context) {
                //                 return StatefulBuilder(builder: (context, st) {
                //                   return AlertDialog(
                //                       contentPadding: EdgeInsets.all(0),
                //                       content: AlertBox(
                //                         callback: () {
                //                           st(
                //                             () {
                //                               // paycon.forOnAccPaid(
                //                               //   'On Account',
                //                               //   context,
                //                               //   theme,
                //                               //   10,
                //                               // );
                //                             },
                //                           );
                //                         },
                //                         payMent: 'Payment Mode - On Account',
                //                         widget:
                //                             forOnAcc(context, theme, paycon),
                //                         buttonName: 'Accept',
                //                       ));
                //                 });
                //               });
                //     },
                //     child: Container(
                //         alignment: Alignment.center,
                //         padding: EdgeInsets.only(
                //             top: Screens.padingHeight(context) * 0.01,
                //             left: Screens.width(context) * 0.01,
                //             right: Screens.width(context) * 0.01,
                //             bottom: Screens.padingHeight(context) * 0.01),
                //         height: Screens.padingHeight(context) * 0.08,
                //         width: Screens.width(context) * 0.3,
                //         decoration: BoxDecoration(
                //           // color: Colors.red,
                //           color: Colors.grey[200],
                //           borderRadius: BorderRadius.circular(5),
                //         ),
                //         child: Text("On Account",
                //             style: theme.textTheme.bodyText2
                //                 ?.copyWith(color: Colors.black)))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  forCashConfirm(
      BuildContext context, PayreceiptController posC, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.4,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Alert",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Container(
                alignment: Alignment.center,
                child: Text(
                    "Is full amount Rs. ${posC.config.splitValues(posC.getBalancePaid().toStringAsFixed(2))}" //'${posC.getBalancePaid().toStringAsFixed(2)'}
                    )),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      st(
                        () {
                          posC.fullamt('Cash', context, theme);
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      alignment: Alignment.center,
                      width: Screens.width(context) * 0.3,
                      height: Screens.padingHeight(context) * 0.05,
                      child: Text(
                        "Yes",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      posC.nullErrorMsg();
                      showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return StatefulBuilder(builder: (context, st) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4))),
                                contentPadding: const EdgeInsets.all(0),
                                // backgroundColor: Colors.transparent,
                                insetPadding: EdgeInsets.all(
                                    Screens.bodyheight(context) * 0.02),
                                content: forCashDialog(context, posC, theme),
                              );
                            });
                          });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      alignment: Alignment.center,
                      width: Screens.width(context) * 0.3,
                      height: Screens.padingHeight(context) * 0.05,
                      child: Text(
                        "Partial Amount",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ))
              ],
            )
          ],
        ),
      );
    });
  }

  forCashDialog(
      BuildContext context, PayreceiptController posC, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Cash",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[1],
              child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.001),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: posC.mycontroller[22],
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.number,
                  // textInputAction: TextInputAction.,
                  onChanged: (v) {},
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
                    // enabledBorder: InputBorder.none,
                    // focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 25,
                    ),
                  ),
                ),
              ),
            ),
            // SizedBox(height: cashHeight * 0.1),
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //       onTap: () {
            //         st(() {
            //           posC.addEnteredAmtType('Cash', context, 1);
            //         });
            //       },
            //       child: Container(
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(5),
            //             border: Border.all(color: Colors.red)),
            //         height: cashHeight * 0.2,
            //         width: cashWidth * 0.18,
            //         child: Text("OK",
            //             style: theme.textTheme.bodyText2?.copyWith(
            //               color: Colors.red,
            //             )),
            //       )),
            // ),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            InkWell(
              onTap: () {
                st(() {
                  posC.addEnteredAmtType('Cash', context, 1, theme);
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.045,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Ok",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  forCard(BuildContext context, String cardType, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        color: Colors.white,
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.width(context) * 0.02,
                          right: Screens.width(context) * 0.02),
                      // color: Colors.red,
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Payment mode - Card",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: posC.getmsgforAmount == null
                      ? 0
                      : Screens.padingHeight(context) * 0.01),
              posC.getmsgforAmount == null
                  ? SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    )
                  : Text(
                      posC.getmsgforAmount == null
                          ? ''
                          : "${posC.getmsgforAmount}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
              Form(
                  key: posC.formkey[3],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            // height: cashHeight * 0.1,
                            width: Screens.width(context) * 0.3,
                            child: Text(
                              "Payment Terminal",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                          SizedBox(
                              height: Screens.padingHeight(context) * 0.01),
                          Container(
                            // height: cashHeight * 0.24,
                            width: Screens.width(context) * 0.6,
                            padding: EdgeInsets.only(
                              left: Screens.width(context) * 0.01,
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
                                      color: posC.gethintcolor == true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: posC.getpayTerminal
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
                                value: posC.paymentterm,
                                onChanged: (value) {
                                  st(() {
                                    posC.paymentterm = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context) * 0.3,
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: const Text("Approval No"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[27],
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
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text("Card Reference"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[28],
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
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  //width: Screens.width(context) * 0.3,
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: const Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      posC.cpyBtnclik(29);
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size:
                                          Screens.padingHeight(context) * 0.03,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[29],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {},
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
                    ],
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              InkWell(
                onTap: () {
                  st(
                    () {
                      posC.addEnteredAmtType('Card', context, 3, theme);
                    },
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Ok",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  forCheque(BuildContext context, PayreceiptController posC, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.02,
            right: Screens.width(context) * 0.02,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02,
                          right: Screens.padingHeight(context) * 0.02),
                      // color: Colors.red,
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Payment mode - cheque",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Screens.padingHeight(context) * 0.01),
              Text(
                posC.getmsgforAmount == null ? '' : "${posC.getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
              Form(
                  key: posC.formkey[2],
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // height: cashHeight * 0.1,
                              // width: Screens.width(context) * 0.18,
                              child: const Text("Cheque No"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: posC.mycontroller[23],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                validator: ((value) {
                                  if (value!.isEmpty) {
                                    return " Please Enter Cheque Number";
                                  } else {
                                    return null;
                                  }
                                }),
                                decoration: InputDecoration(
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
                        SizedBox(height: Screens.padingHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // height: cashHeight * 0.1,
                              child: const Text("Cheque Date"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  st(() {
                                    posC.getDate(context, 'Cheque');
                                  });
                                },
                                child: TextFormField(
                                  autofocus: true,
                                  readOnly: true,
                                  controller: posC.mycontroller[24],
                                  cursorColor: Colors.grey,
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                  onTap: () {
                                    st(() {
                                      posC.getDate(context, 'Cheque');
                                    });
                                  },
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
                                          posC.getDate(context, 'Cheque');
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
                            ),
                          ],
                        ),
                        SizedBox(height: Screens.padingHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: Screens.width(context) * 0.27,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    // height: cashHeight * 0.1,
                                    child: const Text("Amount"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      posC.cpyBtnclik(25);
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      size:
                                          Screens.padingHeight(context) * 0.03,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: posC.mycontroller[25],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                keyboardType: TextInputType.number,
                                onChanged: (v) {},
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return ' Please Enter the Amount';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                  // hintText: posController.boolCash == true
                                  //     ? '${posController.getBalancePaid().toStringAsFixed(2)}'
                                  //     : '',
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
                        SizedBox(height: Screens.padingHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              // height: cashHeight * 0.1,
                              child: const Text("Remarks"),
                            ),
                            Container(
                              // height: cashHeight * 0.2,
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: posC.mycontroller[26],
                                cursorColor: Colors.grey,
                                style: theme.textTheme.bodyMedium?.copyWith(),
                                onChanged: (v) {},
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return '  Please Enter the Remark';
                                //   } else {
                                //     return null;
                                //   }
                                // },
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
                                  // enabledBorder: InputBorder.none,
                                  // focusedBorder: InputBorder.none,
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
              SizedBox(height: Screens.padingHeight(context) * 0.01),
              InkWell(
                onTap: () {
                  st(() {
                    paycon.addEnteredAmtType('Cheque', context, 2, theme);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Ok",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
              // ),
            ],
          ),
        ),
      );
    });
  }

  forwallet(BuildContext context, PayreceiptController posC, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Screens.width(context),
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02,
                          right: Screens.padingHeight(context) * 0.02),
                      // color: Colors.red,
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Payment Mode - Wallet",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                  height: posC.getmsgforAmount == null
                      ? 0
                      : Screens.padingHeight(context) * 0.01),
              posC.getmsgforAmount == null
                  ? SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    )
                  : Text(
                      posC.getmsgforAmount == null
                          ? ''
                          : "${posC.getmsgforAmount}",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
              Form(
                  key: posC.formkey[5],
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: Screens.width(context) * 0.3,
                            child: const Text("Wallet"),
                          ),
                          SizedBox(
                              height: Screens.padingHeight(context) * 0.01),
                          Container(
                            width: Screens.width(context) * 0.6,
                            padding: EdgeInsets.only(
                              left: Screens.width(context) * 0.01,
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
                                      color: posC.gethintcolor == true
                                          ? Colors.red
                                          : Colors.grey),
                                ),
                                items: posC.walletlist
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
                                value: posC.wallet,
                                onChanged: (value) {
                                  st(() {
                                    posC.wallet = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: Screens.width(context) * 0.3,
                            child: const Text("Waller ID"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[32],
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
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: Screens.width(context) * 0.3,
                            alignment: Alignment.centerLeft,
                            // width: Screens.width(context) * 0.05,
                            child: const Text("Payment Reference"),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[33],
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
                      SizedBox(height: Screens.padingHeight(context) * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: Screens.width(context) * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // height: cashHeight * 0.1,
                                  child: const Text("Amount"),
                                ),
                                IconButton(
                                    onPressed: () {
                                      posC.cpyBtnclik(34);
                                    },
                                    icon: Icon(
                                      Icons.copy,
                                      size:
                                          Screens.padingHeight(context) * 0.03,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              controller: posC.mycontroller[34],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              keyboardType: TextInputType.number,
                              onChanged: (v) {},
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
                    ],
                  )),
              SizedBox(
                height: Screens.padingHeight(context) * 0.01,
              ),
              InkWell(
                onTap: () {
                  st(() {
                    paycon.addEnteredAmtType('Wallet', context, 5, theme);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Ok",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  forTransfer(
      BuildContext context, PayreceiptController posC, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Transfer",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[4],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Trans Type"),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.01,
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
                                  color: posC.gethintcolor == false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: posC.gettransType
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
                              value: posC.selectedType,
                              onChanged: (value) {
                                st(() {
                                  posC.selectedType = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Trans Reference"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[30],
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    st(() {
                                      posC.cpyBtnclik(31);
                                    });
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[31],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {},
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    InkWell(
                      onTap: () {
                        st(() {
                          paycon.addEnteredAmtType(
                              'Transfer', context, 4, theme);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Screens.padingHeight(context) * 0.045,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      );
    });
  }

  forCoupons(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select Customer",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[7],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Coupons Type"),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          // child: DropdownButtonHideUnderline(
                          // child: DropdownButton(
                          //   focusColor: Colors.white,
                          //   hint: Text(
                          //     'Select Coupons  Type',
                          //     style: TextStyle(
                          //       fontSize: 14,
                          //       color: posC.gethintcolor == false
                          //           ? Colors.grey
                          //           : Colors.red,
                          //     ),
                          //   ),
                          //   items: posC.getcouponlist
                          //       .map((item) => DropdownMenuItem<String>(
                          //             value: item,
                          //             child: Text(
                          //               item,
                          //               style: const TextStyle(
                          //                 fontSize: 14,
                          //               ),
                          //             ),
                          //           ))
                          //       .toList(),
                          //   value: posC.coupon,
                          //   onChanged: (value) {
                          //     st(() {
                          //       posC.coupon = value;
                          //     });
                          //   },
                          // ),
                          // ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Coupon Code"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[35],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ' Please Enter the Coupon Code';
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    posC.cpyBtnclik(36);
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[36],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {},
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
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    InkWell(
                      onTap: () {
                        st(() {
                          paycon.addEnteredAmtType(
                              'Coupons', context, 7, theme);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Screens.padingHeight(context) * 0.045,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Ok",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      );
    });
  }

  forPoints(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.width(context) * 0.01,
                        right: Screens.width(context) * 0.01),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.75,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Points Redemption",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[8],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Available Points"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            readOnly: true,
                            controller: posC.mycontroller[37],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return ' Please Enter the Available Points';
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            decoration: InputDecoration(
                              // hintText: posC.getselectedcust!.point,
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Points to Redeem"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: posC.mycontroller[38],
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    InkWell(
                      onTap: () {
                        st(() {
                          posC.pointconvert();
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Screens.padingHeight(context) * 0.045,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                        ),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Convert points to redem",
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            onTap: () {
                              st(() {
                                posC.pointconvert();
                              });
                            },
                            controller: posC.mycontroller[40],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {},
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
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            InkWell(
              onTap: () {
                st(() {
                  paycon.addEnteredAmtType(
                      'Points Redemption', context, 8, theme);
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.045,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Ok",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  forDiscount(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Discount",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[9],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Discount Type"),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          padding: EdgeInsets.only(
                            left: Screens.width(context) * 0.01,
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
                                'Select Discount Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: posC.gethintcolor == false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: posC.getdiscountType
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
                              value: posC.discount,
                              onChanged: (value) {
                                st(() {
                                  posC.discount = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Discount Reference"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[41],
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    posC.cpyBtnclik(42);
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[42],
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            onChanged: (v) {},
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
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            InkWell(
              onTap: () {
                st(() {
                  paycon.addEnteredAmtType('Discount', context, 9, theme);
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.045,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Ok",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  forCredit(BuildContext context, PayreceiptController posC) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        width: Screens.width(context),
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.01,
            right: Screens.width(context) * 0.01,
            bottom: Screens.padingHeight(context) * 0.01),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.05,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Screens.padingHeight(context) * 0.02,
                        right: Screens.padingHeight(context) * 0.02),
                    // color: Colors.red,
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Credit",
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: Screens.padingHeight(context) * 0.025,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
                height: posC.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            posC.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    posC.getmsgforAmount == null
                        ? ''
                        : "${posC.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: posC.formkey[10],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Credit Reference"),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[43],
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
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: Screens.width(context) * 0.3,
                          child: const Text("Recovery Date"),
                        ),
                        GestureDetector(
                          onTap: () {
                            // posC.getDate(context);
                          },
                          child: Container(
                            // height: cashHeight * 0.2,
                            width: Screens.width(context) * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey.withOpacity(0.01),
                            ),
                            child: TextFormField(
                              readOnly: true,
                              controller: posC.mycontroller[44],
                              cursorColor: Colors.grey,
                              style: theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ' Please Enter the Recovery Date';
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      posC.getDate(context, 'Credit');
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
                                  vertical: 5,
                                  horizontal: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                // height: cashHeight * 0.1,
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    posC.cpyBtnclik(45);
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          // height: cashHeight * 0.2,
                          width: Screens.width(context) * 0.6,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: posC.mycontroller[45],
                            cursorColor: Colors.grey,
                            style: theme.textTheme.bodyMedium?.copyWith(),
                            keyboardType: TextInputType.number,
                            onChanged: (v) {},
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
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            InkWell(
              onTap: () {
                st(() {
                  paycon.addEnteredAmtType('Credit', context, 10, theme);
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: Screens.padingHeight(context) * 0.045,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Ok",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
