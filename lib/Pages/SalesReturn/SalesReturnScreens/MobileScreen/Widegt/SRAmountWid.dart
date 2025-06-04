import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../../../Sales Screen/Screens/MobileScreenSales/WidgetsMob/ContentcontainerMob.dart';

class SRAmountSlctWidget extends StatelessWidget {
  const SRAmountSlctWidget(
      {super.key, required this.theme, required this.salesReturnController});

  final ThemeData theme;
  final SalesReturnController salesReturnController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
      height: Screens.padingHeight(context) * 0.1,
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
      padding: EdgeInsets.symmetric(
          horizontal: Screens.width(context) * 0.02,
          vertical: Screens.padingHeight(context) * 0.01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: salesReturnController.enableModeBtn == false
                    ? null
                    : () {
                        salesReturnController.nullErrorMsg();

                        if (salesReturnController.getScanneditemData.isEmpty) {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    contentPadding: const EdgeInsets.all(0),
                                    insetPadding: EdgeInsets.all(
                                        Screens.padingHeight(context) * 0.02),
                                    content: ContentWidgetMob(
                                      theme: theme,
                                      msg: 'Choose Product..!!',
                                    ));
                              });
                        } else {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    contentPadding: const EdgeInsets.all(0),
                                    insetPadding: EdgeInsets.all(
                                        Screens.padingHeight(context) * 0.02),
                                    content: forCashConfirm(
                                        context, salesReturnController, theme));
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
                    height: Screens.padingHeight(context) * 0.06,
                    width: Screens.width(context) * 0.3,
                    decoration: BoxDecoration(
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
                              child: Text("Cash",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color:
                                          salesReturnController.enableModeBtn ==
                                                  true
                                              ? Colors.black
                                              : Colors.grey))),
                        ])),
              ),
              GestureDetector(
                  onTap: salesReturnController.enableModeBtn == false
                      ? null
                      : () {
                          salesReturnController.nullErrorMsg();
                          if (salesReturnController
                              .getScanneditemData.isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      insetPadding: EdgeInsets.all(
                                          Screens.padingHeight(context) * 0.02),
                                      content: ContentWidgetMob(
                                        theme: theme,
                                        msg: 'Choose Product..!!',
                                      ));
                                });
                          } else {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      insetPadding: EdgeInsets.all(
                                          Screens.padingHeight(context) * 0.02),
                                      content: forCheque(context,
                                          salesReturnController, theme),
                                    );
                                  });
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
                      height: Screens.padingHeight(context) * 0.06,
                      width: Screens.width(context) * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                alignment: Alignment.center,
                                height: Screens.padingHeight(context) * 0.03,
                                width: Screens.width(context) * 0.08,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 155, 65, 228),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Icon(
                                  Icons.credit_card,
                                  color: Colors.white,
                                )),
                            SizedBox(
                              width: Screens.width(context) * 0.02,
                            ),
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Cheque",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                        color: salesReturnController
                                                    .enableModeBtn ==
                                                true
                                            ? Colors.black
                                            : Colors.grey))),
                          ]))),
              GestureDetector(
                  onTap: salesReturnController.enableModeBtn == false
                      ? null
                      : () {
                          salesReturnController.nullErrorMsg();
                          if (salesReturnController
                              .getScanneditemData.isEmpty) {
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4))),
                                      contentPadding: const EdgeInsets.all(0),
                                      insetPadding: EdgeInsets.all(
                                          Screens.padingHeight(context) * 0.02),
                                      content: ContentWidgetMob(
                                        theme: theme,
                                        msg: 'Choose Product..!!',
                                      ));
                                });
                          } else {
                            salesReturnController.hintcolor = false;
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(
                                      builder: (context, st) {
                                    return AlertDialog(
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        contentPadding: const EdgeInsets.all(0),
                                        insetPadding: EdgeInsets.all(
                                            Screens.padingHeight(context) *
                                                0.02),
                                        content: forCoupons(
                                            context, salesReturnController));
                                  });
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
                      height: Screens.padingHeight(context) * 0.06,
                      width: Screens.width(context) * 0.3,
                      decoration: BoxDecoration(
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
                                  image: AssetImage(
                                      "assets/creditIcon.png"), //assets/creditIcon.png
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
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      color:
                                          salesReturnController.enableModeBtn ==
                                                  true
                                              ? Colors.black
                                              : Colors.grey)),
                            ),
                          ])))
            ],
          ),
        ],
      ),
    );
  }

  forCashConfirm(
      BuildContext context, SalesReturnController srContrl, ThemeData theme) {
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
              height: Screens.padingHeight(context) * 0.01,
            ),
            Container(
                alignment: Alignment.center,
                child: Text("Is full amount Rs. "
                    '${srContrl.totalcalculate().toStringAsFixed(2)}')),
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
                          srContrl.fullamt('Cash', context, theme);
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
                      srContrl.nullErrorMsg();
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
                                insetPadding: EdgeInsets.all(
                                    Screens.padingHeight(context) * 0.02),
                                content:
                                    forCashDialog(context, srContrl, theme),
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
      BuildContext context, SalesReturnController srContrl, ThemeData theme) {
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
                height: srContrl.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            srContrl.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    srContrl.getmsgforAmount == null
                        ? ''
                        : "${srContrl.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: srContrl.formkey[1],
              child: Container(
                alignment: Alignment.centerRight,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.grey.withOpacity(0.001),
                ),
                child: TextFormField(
                  autofocus: true,
                  controller: srContrl.mycontroller[22],
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.number,
                  onChanged: (v) {
                    log(v);
                  },
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
                      horizontal: 25,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: Screens.padingHeight(context) * 0.01),
            InkWell(
              onTap: () {
                st(() {
                  srContrl.addEnteredAmtType('Cash', context, 1, theme);
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

  forCheque(
      BuildContext context, SalesReturnController srContrl, ThemeData theme) {
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
                      width: Screens.width(context) * 0.7,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Payment Mode - Cheque",
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
                srContrl.getmsgforAmount == null
                    ? ''
                    : "${srContrl.getmsgforAmount}",
                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
              ),
              Form(
                  key: srContrl.formkey[2],
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("Cheque No"),
                            ),
                            Container(
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: srContrl.mycontroller[23],
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
                              child: const Text("Cheque Date"),
                            ),
                            Container(
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: GestureDetector(
                                child: TextFormField(
                                  autofocus: true,
                                  readOnly: true,
                                  controller: srContrl.mycontroller[24],
                                  cursorColor: Colors.grey,
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                  onChanged: (v) {},
                                  onTap: () {
                                    st(() {
                                      srContrl.getDate(context, 'Cheque');
                                    });
                                  },
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
                                          srContrl.getDate(context, 'Cheque');
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
                                    child: const Text("Amount"),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      srContrl.cpyBtnclik(25);
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
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: srContrl.mycontroller[25],
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
                        SizedBox(height: Screens.padingHeight(context) * 0.01),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text("Remarks"),
                            ),
                            Container(
                              width: Screens.width(context) * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Colors.grey.withOpacity(0.01),
                              ),
                              child: TextFormField(
                                autofocus: true,
                                controller: srContrl.mycontroller[26],
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
              SizedBox(height: Screens.padingHeight(context) * 0.01),
              InkWell(
                onTap: () {
                  st(() {
                    srContrl.addEnteredAmtType('Cheque', context, 2, theme);
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

  forCoupons(BuildContext context, SalesReturnController srContrl) {
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
                    width: Screens.width(context) * 0.7,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Mode - Coupon",
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
                height: srContrl.getmsgforAmount == null
                    ? 0
                    : Screens.padingHeight(context) * 0.01),
            srContrl.getmsgforAmount == null
                ? SizedBox(
                    height: Screens.padingHeight(context) * 0.01,
                  )
                : Text(
                    srContrl.getmsgforAmount == null
                        ? ''
                        : "${srContrl.getmsgforAmount}",
                    style:
                        theme.textTheme.bodyMedium?.copyWith(color: Colors.red),
                  ),
            Form(
              key: srContrl.formkey[7],
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
                          width: Screens.width(context) * 0.55,
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
                                'Select Coupons  Type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: srContrl.gethintcolor == false
                                      ? Colors.grey
                                      : Colors.red,
                                ),
                              ),
                              items: srContrl.getcouponlist
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
                              value: srContrl.coupon,
                              onChanged: (value) {
                                st(() {
                                  srContrl.coupon = value;
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
                          child: const Text("Coupon Code"),
                        ),
                        Container(
                          width: Screens.width(context) * 0.55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: srContrl.mycontroller[35],
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
                                child: const Text("Amount"),
                              ),
                              IconButton(
                                  onPressed: () {
                                    srContrl.cpyBtnclik(36);
                                  },
                                  icon: Icon(
                                    Icons.copy,
                                    size: Screens.padingHeight(context) * 0.03,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.grey.withOpacity(0.01),
                          ),
                          child: TextFormField(
                            controller: srContrl.mycontroller[36],
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
                          srContrl.addEnteredAmtType(
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

  forOnAcc(
      BuildContext context, ThemeData theme, SalesReturnController srContrl) {
    return Column(
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
                width: Screens.width(context) * 0.7,
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment Mode - On Account",
                  style:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
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
        Container(
          padding: EdgeInsets.only(
              top: Screens.padingHeight(context) * 0.02,
              left: Screens.padingHeight(context) * 0.01,
              right: Screens.padingHeight(context) * 0.01,
              bottom: Screens.padingHeight(context) * 0.02),
          child: Form(
            key: srContrl.formkey[8],
            child: Row(
              children: [
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
                              child: const Text("Amount"),
                            ),
                            IconButton(
                                onPressed: () {
                                  srContrl.onAcccpyBtnclik(38);
                                },
                                icon: Icon(
                                  Icons.copy,
                                  size: Screens.padingHeight(context) * 0.03,
                                )),
                          ],
                        ),
                      )
                    ]),
                Container(
                  width: Screens.width(context) * 0.55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey.withOpacity(0.01),
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: srContrl.mycontroller[38],
                    cursorColor: Colors.grey,
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
                      hintText: "Amount",
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
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.grey),
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
          ),
        ),
        InkWell(
          onTap: () {
            srContrl.addOnAccAmtType('OnAccount', context, 8, theme);
            srContrl.custAccBal();
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
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
