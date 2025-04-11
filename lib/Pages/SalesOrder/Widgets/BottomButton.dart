import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesOrderController/SalesOrderController.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class SOBottomButtons extends StatefulWidget {
  SOBottomButtons(
      {super.key,
      required this.theme,
      required this.btnWidth,
      required this.btnheight});

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<SOBottomButtons> createState() => SOBottomButtonsState();
}

class SOBottomButtonsState extends State<SOBottomButtons> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
        height: widget.btnheight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            context.read<SOCon>().editqty == true
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.all(widget.btnheight * 0.01),
                        child: Text(
                          context.read<SOCon>().getpaymentWay.isNotEmpty
                              ? "Payment Method"
                              : '',
                          textAlign: TextAlign.start,
                          style: widget.theme.textTheme.bodyLarge?.copyWith(
                            color: widget.theme.primaryColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.65,
                        child: context.read<SOCon>().getpaymentWay2.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: context
                                    .watch<SOCon>()
                                    .getpaymentWay2
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            right: widget.btnheight * 0.03,
                                            left: widget.btnheight * 0.03,
                                            bottom: widget.btnheight * 0.03,
                                            top: widget.btnheight * 0.03,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.grey[300],
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: widget.btnWidth * 0.25,
                                                child: Text(
                                                  '${context.watch<SOCon>().getpaymentWay2[index].type}',
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: widget.btnWidth * 0.28,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${context.watch<SOCon>().getpaymentWay2[index].reference}',
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  context
                                                      .read<SOCon>()
                                                      .config
                                                      .splitValues(context
                                                          .read<SOCon>()
                                                          .getpaymentWay2[index]
                                                          .amt!
                                                          .toStringAsFixed(2)),
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              context
                                                      .read<SOCon>()
                                                      .getpaymentWay2
                                                      .isNotEmpty
                                                  ? Container(
                                                      width: widget.btnWidth *
                                                          0.05,
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<SOCon>()
                                                            .removePayment(
                                                                index);
                                                      },
                                                      child: SizedBox(
                                                        width: widget.btnWidth *
                                                            0.05,
                                                        child: const Icon(
                                                          Icons.delete,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          )),
                                    ),
                                  );
                                })
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    context.watch<SOCon>().getpaymentWay.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Card(
                                      elevation: 2,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                            right: widget.btnheight * 0.03,
                                            left: widget.btnheight * 0.03,
                                            bottom: widget.btnheight * 0.03,
                                            top: widget.btnheight * 0.03,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 3,
                                                blurRadius: 7,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: widget.btnWidth * 0.25,
                                                child: Text(
                                                  '${context.read<SOCon>().getpaymentWay[index].type}',
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                width: widget.btnWidth * 0.28,
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${context.read<SOCon>().getpaymentWay[index].reference}',
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  context
                                                      .read<SOCon>()
                                                      .config
                                                      .splitValues(context
                                                          .read<SOCon>()
                                                          .getpaymentWay[index]
                                                          .amt!
                                                          .toStringAsFixed(2)),
                                                  style: widget
                                                      .theme.textTheme.bodyLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    context
                                                        .read<SOCon>()
                                                        .removePayment(index);
                                                  });
                                                },
                                                child: SizedBox(
                                                  width: widget.btnWidth * 0.05,
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ),
                                  );
                                }),
                      ),
                    ],
                  ),
            context.watch<SOCon>().isApprove == true
                ? Center(
                    child: SizedBox(
                    width: widget.btnWidth * 0.18,
                    height: widget.btnheight * 0.2,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.theme.primaryColor,
                        ),
                        onPressed: context.read<SOCon>().isLoading == true
                            ? null
                            : () {
                                setState(() {
                                  context.read<SOCon>().callApprovaltoDocApi(
                                      context, widget.theme);
                                });
                              },
                        child: const Text("Save")),
                  ))
                : context.watch<SOCon>().editqty == true
                    ? Center(
                        child: SizedBox(
                          width: widget.btnWidth * 0.18,
                          height: widget.btnheight * 0.2,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: widget.theme.primaryColor,
                              ),
                              onPressed:
                                  context.read<SOCon>().onDisablebutton == true
                                      ? null
                                      : () {
                                          context.read<SOCon>().onClickUpdate(
                                              context, widget.theme);
                                          context
                                              .read<SOCon>()
                                              .disableKeyBoard(context);
                                        },
                              child: Text(
                                "Update",
                                style: widget.theme.textTheme.bodyMedium!
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      )
                    : Container(
                        child: context.watch<SOCon>().selectedcust2 != null
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      padding: EdgeInsets.all(
                                        widget.btnheight * 0.01,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<SOCon>()
                                                  .onDisablebutton = true;
                                              context
                                                  .read<SOCon>()
                                                  .clickacancelbtn(
                                                      context, widget.theme);
                                              context.read<SOCon>().setstate1();
                                            });
                                          },
                                          child: Container(
                                              width: widget.btnWidth * 0.2,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: widget
                                                      .theme.primaryColor
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: widget
                                                        .theme.primaryColor,
                                                  )),
                                              height: widget.btnheight * 0.15,
                                              child:
                                                  // context
                                                  //             .watch<SOCon>()
                                                  //             .onDisablebutton ==
                                                  //         false
                                                  //     ?
                                                  Text("Cancel",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: widget.theme
                                                          .textTheme.bodySmall
                                                          ?.copyWith(
                                                        color: Colors.black,
                                                      ))
                                              // : CircularProgressIndicator(
                                              //     color: widget
                                              //         .theme.primaryColor),
                                              ))),
                                  Container(
                                      padding: EdgeInsets.all(
                                        widget.btnheight * 0.01,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<SOCon>()
                                                  .clickaEditBtn(
                                                      context, widget.theme);
                                            });
                                          },
                                          child: Container(
                                            width: widget.btnWidth * 0.2,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: widget.theme.primaryColor
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color:
                                                      widget.theme.primaryColor,
                                                )),
                                            height: widget.btnheight * 0.15,
                                            child: Text("Edit",
                                                textAlign: TextAlign.center,
                                                style: widget
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: Colors.black,
                                                )),
                                          ))),
                                  Container(
                                      padding: EdgeInsets.all(
                                        widget.btnheight * 0.01,
                                      ),
                                      child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              context
                                                  .read<SOCon>()
                                                  .callClearBtn();
                                            });
                                          },
                                          child: Container(
                                            width: widget.btnWidth * 0.2,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: widget.theme.primaryColor
                                                    .withOpacity(0.1),
                                                // color: Colors.grey[400],
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color:
                                                      widget.theme.primaryColor,
                                                )),
                                            height: widget.btnheight * 0.15,
                                            child: Text("Clear",
                                                textAlign: TextAlign.center,
                                                style: widget
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: Colors.black,
                                                )),
                                          ))),
                                ],
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height: widget.btnheight * 0.2,
                                      width: widget.btnWidth * 0.24,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              side: BorderSide(
                                                color:
                                                    widget.theme.primaryColor,
                                              )),
                                          onPressed:
                                              context
                                                      .read<SOCon>()
                                                      .openSalesQuot
                                                      .isEmpty
                                                  ? null
                                                  : () async {
                                                      context
                                                          .read<SOCon>()
                                                          .loadingSqBtn = true;

                                                      context
                                                          .read<SOCon>()
                                                          .disableKeyBoard(
                                                              context);
                                                      context
                                                          .read<SOCon>()
                                                          .clearTextField();
                                                      context
                                                          .read<SOCon>()
                                                          .openQuotLineList = [];

                                                      // log(" context.watch<SOCon>().soSalesmodl.length:::${context.read<SOCon>().soSalesmodl.length}");
                                                      context
                                                          .read<SOCon>()
                                                          .mycontroller[79]
                                                          .text = '';

                                                      context
                                                                  .read<SOCon>()
                                                                  .getselectedcust ==
                                                              null
                                                          ? showDialog(
                                                              context: context,
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
                                                                    content:
                                                                        AlertBox(
                                                                      payMent:
                                                                          'Alert',
                                                                      errormsg:
                                                                          true,
                                                                      widget: Center(
                                                                          child: ContentContainer(
                                                                        content:
                                                                            'Choose customer..!!',
                                                                        theme: widget
                                                                            .theme,
                                                                      )),
                                                                      buttonName:
                                                                          null,
                                                                    ));
                                                              }).then((value) {
                                                              context
                                                                  .read<SOCon>()
                                                                  .loadingSqBtn = false;
                                                            })
                                                          : context
                                                                  .read<SOCon>()
                                                                  .openSalesQuot
                                                                  .isNotEmpty
                                                              ? setState(() {
                                                                  for (var i =
                                                                          0;
                                                                      i <
                                                                          context
                                                                              .read<SOCon>()
                                                                              .openSalesQuot
                                                                              .length;
                                                                      i++) {
                                                                    context
                                                                        .read<
                                                                            SOCon>()
                                                                        .openSalesQuot[
                                                                            i]
                                                                        .invoiceClr = 0;
                                                                    context
                                                                        .read<
                                                                            SOCon>()
                                                                        .openSalesQuot[
                                                                            i]
                                                                        .checkBClr = false;
                                                                  }
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return StatefulBuilder(builder:
                                                                            (context,
                                                                                st) {
                                                                          return AlertDialog(
                                                                              insetPadding: EdgeInsets.all(Screens.padingHeight(context) * 0.01),
                                                                              contentPadding: EdgeInsets.zero,
                                                                              content: AlertBox(
                                                                                payMent: 'Sales Quotation',
                                                                                widget: forClickSQBtn(context, widget.theme),
                                                                                callback: () async {
                                                                                  context.read<SOCon>().clearsQaqty();
                                                                                  await context.read<SOCon>().showopenQuotLines();

                                                                                  if (context.read<SOCon>().openQuotLineList!.isNotEmpty) {
                                                                                    context.read<SOCon>().loadingSqBtn = false;
                                                                                    Navigator.pop(context);
                                                                                    showDialog(
                                                                                        context: context,
                                                                                        barrierDismissible: false,
                                                                                        builder: (BuildContext context) {
                                                                                          return AlertDialog(
                                                                                              insetPadding: EdgeInsets.all(widget.btnWidth * 0.01),
                                                                                              contentPadding: EdgeInsets.zero,
                                                                                              content: AlertBox(
                                                                                                payMent: 'Sales Order',
                                                                                                widget: forScanSQuo(context, widget.theme),
                                                                                                buttonName: "OK",
                                                                                                callback: () {
                                                                                                  setState(() {
                                                                                                    context.read<SOCon>().mapSQData(
                                                                                                          context,
                                                                                                          widget.theme,
                                                                                                        );
                                                                                                  });
                                                                                                },
                                                                                              ));
                                                                                        });
                                                                                  } else {
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
                                                                                                  content: 'Choose a Sales Quotation..!!',
                                                                                                  theme: widget.theme,
                                                                                                )),
                                                                                                buttonName: null,
                                                                                              ));
                                                                                        });
                                                                                  }
                                                                                },
                                                                                buttonName: "OK",
                                                                              ));
                                                                        });
                                                                      });
                                                                })
                                                              : showDialog(
                                                                  context:
                                                                      context,
                                                                  barrierDismissible:
                                                                      true,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                        contentPadding: const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                        content:
                                                                            AlertBox(
                                                                          payMent:
                                                                              'Alert',
                                                                          errormsg:
                                                                              true,
                                                                          widget: Center(
                                                                              child: ContentContainer(
                                                                            content:
                                                                                'No sales quotation here..!!',
                                                                            theme:
                                                                                widget.theme,
                                                                          )),
                                                                          buttonName:
                                                                              null,
                                                                        ));
                                                                  }).then((value) {
                                                                  context
                                                                      .read<
                                                                          SOCon>()
                                                                      .loadingSqBtn = false;
                                                                });

                                                      context
                                                          .read<SOCon>()
                                                          .disableKeyBoard(
                                                              context);
                                                    },
                                          child: context
                                                      .read<SOCon>()
                                                      .loadingSqBtn ==
                                                  false
                                              ? Text(
                                                  "Copy from SQ",
                                                  style: widget.theme.textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: widget.theme
                                                              .primaryColor),
                                                )
                                              : CircularProgressIndicator(
                                                  color:
                                                      widget.theme.primaryColor,
                                                ))),
                                  SizedBox(
                                    height: widget.btnheight * 0.2,
                                    width: widget.btnWidth * 0.17,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: BorderSide(
                                              color: widget.theme.primaryColor,
                                            )),
                                        onPressed: context
                                                    .read<SOCon>()
                                                    .onDisablebutton ==
                                                true
                                            ? null
                                            : () {
                                                context
                                                        .read<SOCon>()
                                                        .onDisablebutton ==
                                                    true;
                                                if (context
                                                            .read<SOCon>()
                                                            .getselectedcust ==
                                                        null &&
                                                    context
                                                        .read<SOCon>()
                                                        .getScanneditemData
                                                        .isEmpty) {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            content: AlertBox(
                                                              payMent: 'Alert',
                                                              errormsg: true,
                                                              widget: Center(
                                                                  child:
                                                                      ContentContainer(
                                                                content:
                                                                    'Choose the Customer or Product',
                                                                theme: widget
                                                                    .theme,
                                                              )),
                                                              buttonName: null,
                                                            ));
                                                      }).then((value) {
                                                    context
                                                            .read<SOCon>()
                                                            .onDisablebutton ==
                                                        false;
                                                  });
                                                } else {
                                                  showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          content: forSuspend(
                                                              context,
                                                              widget.theme),
                                                        );
                                                      }).then((value) {
                                                    context
                                                            .read<SOCon>()
                                                            .onDisablebutton ==
                                                        false;
                                                  });
                                                }
                                                context
                                                    .read<SOCon>()
                                                    .disableKeyBoard(context);
                                                context
                                                        .read<SOCon>()
                                                        .onDisablebutton ==
                                                    false;
                                              },
                                        child: Text(
                                          "Clear All",
                                          style: widget
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: widget
                                                      .theme.primaryColor),
                                        )),
                                  ),
                                  SizedBox(
                                    height: widget.btnheight * 0.2,
                                    width: widget.btnWidth * 0.17,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: BorderSide(
                                              color: widget.theme.primaryColor,
                                            )),
                                        onPressed: context
                                                    .read<SOCon>()
                                                    .onDisablebutton ==
                                                true
                                            ? null
                                            : () {
                                                context
                                                    .read<SOCon>()
                                                    .onHoldClicked(
                                                        context, widget.theme);
                                                context
                                                    .read<SOCon>()
                                                    .disableKeyBoard(context);
                                              },
                                        child: Text(
                                          "Hold",
                                          style: widget
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: widget
                                                      .theme.primaryColor),
                                        )),
                                  ),
                                  SizedBox(
                                    height: widget.btnheight * 0.2,
                                    width: widget.btnWidth * 0.14,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: BorderSide(
                                              color: widget.theme.primaryColor,
                                            )),
                                        onPressed: context
                                                    .read<SOCon>()
                                                    .onDisablebutton ==
                                                true
                                            ? null
                                            : () {
                                                createUDF(
                                                    context, widget.theme);
                                              },
                                        child: Text(
                                          "UDF",
                                          style: widget
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color: widget
                                                      .theme.primaryColor),
                                        )),
                                  ),
                                  SizedBox(
                                    width: widget.btnWidth * 0.18,
                                    height: widget.btnheight * 0.2,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              widget.theme.primaryColor,
                                        ),
                                        onPressed: context
                                                    .read<SOCon>()
                                                    .onDisablebutton ==
                                                true
                                            ? null
                                            : () {
                                                if (context
                                                            .read<SOCon>()
                                                            .selectedcust !=
                                                        null &&
                                                    context
                                                            .read<SOCon>()
                                                            .selectedcust!
                                                            .U_CashCust ==
                                                        'YES') {
                                                  log('bbbbbbbb');
                                                  if (context
                                                      .read<SOCon>()
                                                      .custNameController
                                                      .text
                                                      .isNotEmpty) {
                                                    context
                                                        .read<SOCon>()
                                                        .changecheckout(context,
                                                            widget.theme);
                                                  } else {
                                                    Get.defaultDialog(
                                                      titlePadding:
                                                          EdgeInsets.all(10),
                                                      title: 'Alert',
                                                      middleText:
                                                          'Enter Customer Name',
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            TextButton(
                                                              child: const Text(
                                                                  "Close"),
                                                              onPressed: () =>
                                                                  Get.back(),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }
                                                } else {
                                                  context
                                                      .read<SOCon>()
                                                      .changecheckout(context,
                                                          widget.theme);
                                                }
                                                // context
                                                //     .read<SOCon>()
                                                //     .changecheckout(
                                                //         context, widget.theme);
                                                context
                                                    .read<SOCon>()
                                                    .disableKeyBoard(context);
                                              },
                                        child: Text(
                                          "Save",
                                          style: widget
                                              .theme.textTheme.bodyMedium!
                                              .copyWith(color: Colors.white),
                                        )),
                                  ),
                                ],
                              ),
                      ),
          ],
        ),
      ),
    );
  }

  // forSuspend(BuildContext context, ThemeData theme) {
  //   return Container(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: Screens.width(context) * 0.04,
  //           vertical: Screens.bodyheight(context) * 0.01),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //               height: widget.btnheight * 0.4,
  //               child: const Center(
  //                   child: Text(
  //                       "You about to suspended all information will be unsaved  "))),
  //           SizedBox(
  //             height: Screens.bodyheight(context) * 0.01,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               SizedBox(
  //                 width: Screens.width(context) * 0.15,
  //                 child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                       context
  //                           .read<SOCon>()
  //                           .clearSuspendedData(context, theme);
  //                     },
  //                     child: const Text("Yes")),
  //               ),
  //               SizedBox(
  //                 width: Screens.width(context) * 0.15,
  //                 child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);
  //                     },
  //                     child: const Text("No")),
  //               ),
  //             ],
  //           )
  //         ],
  //       ));
  // }

  forSuspend(BuildContext context, ThemeData theme) {
    return Container(
        width: widget.btnWidth * 0.7,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // padding: EdgeInsets.all(5),
              height: widget.btnheight * 0.2,
              color: theme.primaryColor,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: widget.btnWidth * 0.1,
                    ),
                    alignment: Alignment.center,
                    width: widget.btnWidth * 0.6,
                    child: Text(
                      'Clear All',
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        Get.back();
                      });
                    },
                  )
                ],
              ),
            ),
            SizedBox(
              height: widget.btnheight * 0.03,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.btnWidth * 0.02,
                    vertical: widget.btnheight * 0.005),
                child: const Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            SizedBox(
              height: widget.btnheight * 0.03,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.btnWidth * 0.02,
                  vertical: widget.btnheight * 0.005),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Screens.width(context) * 0.1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          context
                              .read<SOCon>()
                              .clearSuspendedData(context, theme);
                        },
                        child: const Text("Yes")),
                  ),
                  SizedBox(
                    width: Screens.width(context) * 0.1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("No")),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  forClickSQBtn(BuildContext context, ThemeData theme) {
    context.watch<SOCon>().loadingSqBtn = false;

    return StatefulBuilder(builder: (context, st) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(widget.btnheight * 0.02),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: widget.btnWidth * 0.07,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      width: widget.btnWidth * 0.3,
                      child: Text("S.Q Number",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      width: widget.btnWidth * 0.55,
                      alignment: Alignment.center,
                      child: Text("Customer Name",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      width: widget.btnWidth * 0.45,
                      alignment: Alignment.center,
                      child: Text("Remarks",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      width: widget.btnWidth * 0.28,
                      child: Text("Date",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: widget.btnWidth * 0.17,
                      child: Text("Total",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                // padding: EdgeInsets.all(widget.btnheight * 0.02),
                height: widget.btnheight * 2.5,
                width: widget.btnWidth * 1.8,
                child: ListView.builder(
                    itemCount: context.watch<SOCon>().openSalesQuot.length,
                    itemBuilder: (context, index) {
                      log("checkBClr:: ${context.read<SOCon>().openSalesQuot[index].checkBClr}");
                      return Card(
                          color: Colors.grey[200],
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: context
                                                .read<SOCon>()
                                                .openSalesQuot[index]
                                                .invoiceClr ==
                                            1 &&
                                        context
                                                .read<SOCon>()
                                                .openSalesQuot[index]
                                                .checkBClr ==
                                            true
                                    ? Colors.blue.withOpacity(0.35)
                                    : Colors.grey.withOpacity(0.2)),
                            child: CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                onChanged: (val) {
                                  context
                                      .read<SOCon>()
                                      .openQuotItemDeSelect(index);
                                },
                                value: context
                                    .read<SOCon>()
                                    .openSalesQuot[index]
                                    .checkBClr,
                                title: Container(
                                  padding: EdgeInsets.only(
                                      // left: widget.btnWidth * 0.01,
                                      right: widget.btnWidth * 0.01),
                                  width: widget.btnWidth * 0.77,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.centerRight,
                                          // color: Colors.red,
                                          width: widget.btnWidth * 0.15,
                                          child: Text(
                                            "${context.watch<SOCon>().openSalesQuot[index].docNum.toString()}",
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.btnWidth * 0.45,
                                          child: Text(
                                            context
                                                .watch<SOCon>()
                                                .openSalesQuot[index]
                                                .cardName
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          width: widget.btnWidth * 0.45,
                                          child: Text(
                                            context
                                                .watch<SOCon>()
                                                .openSalesQuot[index]
                                                .comments
                                                .toString(),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          // color: Colors.red,
                                          width: widget.btnWidth * 0.2,
                                          alignment: Alignment.center,
                                          child: Text(
                                            context
                                                .watch<SOCon>()
                                                .config
                                                .alignDateT(context
                                                    .watch<SOCon>()
                                                    .openSalesQuot[index]
                                                    .docDate
                                                    .toString()),
                                            style: theme.textTheme.bodyLarge!
                                                .copyWith(),
                                          )),
                                      Container(
                                          alignment: Alignment.centerRight,
                                          width: widget.btnWidth * 0.2,
                                          child: Text(context
                                              .watch<SOCon>()
                                              .config
                                              .splitValues(context
                                                  .watch<SOCon>()
                                                  .openSalesQuot[index]
                                                  .docTotal
                                                  .toStringAsFixed(2)))),
                                    ],
                                  ),
                                )),
                          ));
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }

  forScanSQuo(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.all(
          widget.btnheight * 0.02,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: widget.btnheight * 0.05,
            ),
            context.watch<SOCon>().openQuotLineList!.isNotEmpty
                ? Column(
                    children: [
                      Container(
                          height: widget.btnheight * 0.19,
                          padding: EdgeInsets.only(
                            left: widget.btnWidth * 0.02,
                            right: widget.btnWidth * 0.02,
                          ),
                          color: theme.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.btnWidth * 0.15,
                                child: Text("Item Code",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: widget.btnWidth * 0.5,
                                child: Text("Item Name",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    )),
                              ),
                              Container(
                                width: widget.btnWidth * 0.1,
                                alignment: Alignment.center,
                                child: Text("S.Q Qty",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: widget.btnWidth * 0.05,
                                child: Text("Qty",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: widget.btnheight * 2.4,
                        width: widget.btnWidth * 1.5,
                        child: ListView.builder(
                            itemCount:
                                context.watch<SOCon>().openQuotLineList!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      width: widget.btnWidth * 11,
                                      height: widget.btnheight * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              width: widget.btnWidth * 0.18,
                                              child: Text(
                                                context
                                                    .watch<SOCon>()
                                                    .openQuotLineList![index]
                                                    .itemCode
                                                    .toString(),
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(),
                                              )),
                                          Container(
                                              alignment: Alignment.centerLeft,
                                              width: widget.btnWidth * 0.75,
                                              child: Text(
                                                context
                                                    .watch<SOCon>()
                                                    .openQuotLineList![index]
                                                    .description
                                                    .toString(),
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(),
                                              )),
                                          Container(
                                              alignment: Alignment.centerRight,
                                              width: widget.btnWidth * 0.15,
                                              child: Text(
                                                context
                                                    .watch<SOCon>()
                                                    .openQuotLineList![index]
                                                    .openQty
                                                    .toString(),
                                                style: theme
                                                    .textTheme.bodyLarge!
                                                    .copyWith(),
                                              )),
                                          Container(
                                              width: widget.btnWidth * 0.15,
                                              alignment: Alignment.center,
                                              child: TextFormField(
                                                autofocus: true,
                                                onChanged: (val) {
                                                  context
                                                      .read<SOCon>()
                                                      .doubleDotMethodsoqty(
                                                          index, val);
                                                },
                                                inputFormatters: [
                                                  DecimalInputFormatter()
                                                ],
                                                textAlign: TextAlign.right,
                                                style:
                                                    theme.textTheme.bodyMedium,
                                                onTap: () {
                                                  context
                                                          .read<SOCon>()
                                                          .soqtycontroller[index]
                                                          .text =
                                                      context
                                                          .read<SOCon>()
                                                          .soqtycontroller[
                                                              index]
                                                          .text;
                                                  context
                                                      .read<SOCon>()
                                                      .soqtycontroller[index]
                                                      .selection = TextSelection(
                                                    baseOffset: 0,
                                                    extentOffset: context
                                                        .read<SOCon>()
                                                        .soqtycontroller[index]
                                                        .text
                                                        .length,
                                                  );
                                                },

                                                cursorColor: Colors.grey,
                                                textDirection:
                                                    TextDirection.ltr,
                                                keyboardType:
                                                    TextInputType.number,

                                                // inputFormatters: [
                                                //   context
                                                //                   .watch<
                                                //                       SOCon>()
                                                //                   .openQuotLineList![
                                                //                       index]
                                                //                   .uPackSize ==
                                                //               null ||
                                                //           context
                                                //                   .watch<
                                                //                       SOCon>()
                                                //                   .openQuotLineList![
                                                //                       index]
                                                //                   .uPackSize ==
                                                //               0.000
                                                //       ? FilteringTextInputFormatter
                                                //           .allow(RegExp(
                                                //               dotAll: true,
                                                //               r'^\d*\.?\d{0,9}$'))
                                                //       : FilteringTextInputFormatter
                                                //           .digitsOnly
                                                // ],
                                                onEditingComplete: () {
                                                  setState(() {
                                                    context
                                                        .read<SOCon>()
                                                        .soqtychangealertbc(
                                                            index,
                                                            context,
                                                            theme);
                                                  });

                                                  context
                                                      .read<SOCon>()
                                                      .disableKeyBoard(context);
                                                },
                                                controller: context
                                                    .read<SOCon>()
                                                    .soqtycontroller[index],
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 5,
                                                    horizontal: 5,
                                                  ),
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ));
                            }),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      );
    });
  }

  createUDF(BuildContext context, ThemeData theme) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, st) {
            return AlertDialog(
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: Screens.padingHeight(context) * 0.05,
                          color: theme.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: Screens.padingHeight(context) * 0.03),
                                child: Text(
                                  'Create UDF',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  st(
                                    () {
                                      context.read<SOCon>().udfClear();
                                      Get.back();
                                    },
                                  );
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Form(
                                  key: context.read<SOCon>().formkey[15],
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child:
                                                  const Text("Customer Ref No"),
                                            ),
                                            SizedBox(
                                                width: widget.btnWidth * 0.05),
                                            Container(
                                              width: widget.btnWidth * 0.67,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.grey
                                                    .withOpacity(0.01),
                                              ),
                                              child: TextFormField(
                                                autofocus: true,
                                                controller: context
                                                    .read<SOCon>()
                                                    .udfController[0],
                                                cursorColor: Colors.grey,
                                                style: widget
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(),
                                                onChanged: (v) {},
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Customer Ref No";
                                                  }
                                                  return null;
                                                },
                                                onTap: () {},
                                                decoration: InputDecoration(
                                                  filled: false,
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 5,
                                                    horizontal: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget.btnheight * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  "Sales Order Type"),
                                            ),
                                            SizedBox(
                                                width: widget.btnWidth * 0.05),
                                            Container(
                                              width: widget.btnWidth * 0.67,
                                              padding: EdgeInsets.only(
                                                left: widget.btnheight * 0.01,
                                              ),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                  hint: const Text(
                                                    "Select Order Type",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  ),
                                                  value: context
                                                      .watch<SOCon>()
                                                      .valueSelectedOrder,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                  isExpanded: true,
                                                  validator: ((value) {
                                                    if (value == null) {
                                                      return 'Please Select Order Type';
                                                    }
                                                    return null;
                                                  }),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      context
                                                              .read<SOCon>()
                                                              .valueSelectedOrder =
                                                          val.toString();
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ),
                                                  items: context
                                                      .watch<SOCon>()
                                                      .getSalesOrderType
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                        value: e["value"],
                                                        child: Text(
                                                            e["name"]
                                                                .toString(),
                                                            style: widget
                                                                .theme
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black)));
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget.btnheight * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  "GP Approval Required"),
                                            ),
                                            SizedBox(
                                                width: widget.btnWidth * 0.05),
                                            Container(
                                              padding: EdgeInsets.only(
                                                left: widget.btnheight * 0.01,
                                              ),
                                              width: widget.btnWidth * 0.67,
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField(
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.red),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      borderSide:
                                                          const BorderSide(
                                                              color:
                                                                  Colors.grey),
                                                    ),
                                                  ),
                                                  validator: ((value) {
                                                    if (value == null) {
                                                      return 'GP Approval Required*';
                                                    }
                                                    return null;
                                                  }),
                                                  hint: const Text(
                                                      "GP Approval Required*",
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 15)),
                                                  value: context
                                                      .watch<SOCon>()
                                                      .valueSelectedGPApproval,
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 30,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16),
                                                  isExpanded: true,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      context
                                                              .read<SOCon>()
                                                              .valueSelectedGPApproval =
                                                          val.toString();
                                                    });
                                                  },
                                                  items: context
                                                      .read<SOCon>()
                                                      .getgrpApprovalRequired
                                                      .map((e) {
                                                    return DropdownMenuItem(
                                                        value: e["value"],
                                                        child: Text(
                                                          e["name"].toString(),
                                                          style: widget
                                                              .theme
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(),
                                                        ));
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget.btnheight * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  "Order Received Time"),
                                            ),
                                            SizedBox(
                                                width: widget.btnWidth * 0.05),
                                            SizedBox(
                                              width: widget.btnWidth * 0.67,
                                              child: TextFormField(
                                                readOnly: true,
                                                onTap: () {
                                                  context
                                                      .read<SOCon>()
                                                      .getSelectTime(context);
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Order Received Time";
                                                  }
                                                  return null;
                                                },
                                                controller: context
                                                    .read<SOCon>()
                                                    .udfController[1],
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      onPressed: (() {
                                                        st(
                                                          () {
                                                            context
                                                                .read<SOCon>()
                                                                .getSelectTime(
                                                                    context);
                                                          },
                                                        );
                                                      }),
                                                      icon: const Icon(
                                                        Icons.access_time,
                                                        size: 28,
                                                      )),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          vertical: 10,
                                                          horizontal: 10),
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                Colors.green),
                                                  ),
                                                ),
                                                cursorColor: theme.primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                            height: widget.btnheight * 0.05),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                  "Order Received Date"),
                                            ),
                                            SizedBox(
                                                width: widget.btnWidth * 0.05),
                                            Container(
                                              width: widget.btnWidth * 0.67,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: Colors.grey
                                                    .withOpacity(0.01),
                                              ),
                                              child: TextFormField(
                                                readOnly: true,
                                                controller: context
                                                    .read<SOCon>()
                                                    .udfController[2],
                                                cursorColor: Colors.grey,
                                                style: widget
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(),
                                                onChanged: (v) {},
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Enter Order Received Date";
                                                  }
                                                  return null;
                                                },
                                                onTap: () {
                                                  context
                                                      .read<SOCon>()
                                                      .udfType = 'UDF';
                                                  context
                                                      .read<SOCon>()
                                                      .getDate(context, 'UDF');
                                                },
                                                decoration: InputDecoration(
                                                  suffixIcon: IconButton(
                                                      onPressed: (() {
                                                        context
                                                            .read<SOCon>()
                                                            .udfType = 'UDF';
                                                        context
                                                            .read<SOCon>()
                                                            .getDate(
                                                                context, 'UDF');
                                                      }),
                                                      icon: const Icon(
                                                          Icons.date_range)),
                                                  filled: false,
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    vertical: 5,
                                                    horizontal: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ])),
                              SizedBox(
                                height: Screens.padingHeight(context) * 0.02,
                              ),
                              SizedBox(
                                  height: Screens.padingHeight(context) * 0.05,
                                  width: widget.btnWidth,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        st(
                                          () {
                                            if (context
                                                .read<SOCon>()
                                                .formkey[15]
                                                .currentState!
                                                .validate()) {
                                              Navigator.pop(context);
                                            }
                                          },
                                        );
                                      },
                                      child: const Text('OK')))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
        });
  }
}
