import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/SalesInvoice/SalesInvoiceController.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/ContentContainer.dart';
import '../../SalesQuotation/Widgets/ItemLists.dart';

class BottomButtons extends StatefulWidget {
  BottomButtons({
    super.key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  });

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<BottomButtons> createState() => BottomButtonsState();
}

class BottomButtonsState extends State<BottomButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      height: widget.btnheight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(widget.btnheight * 0.01),
                child: Text(
                  context.read<PosController>().getpaymentWay.isNotEmpty
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
                child: context.read<PosController>().getpaymentWay2.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: context
                            .watch<PosController>()
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
                                        color: Colors.grey.withOpacity(0.5),
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
                                          '${context.watch<PosController>().getpaymentWay2[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.watch<PosController>().getpaymentWay2[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .watch<PosController>()
                                              .config
                                              .splitValues(context
                                                  .watch<PosController>()
                                                  .getpaymentWay2[index]
                                                  .amt!
                                                  .toStringAsFixed(2)),
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      context
                                              .read<PosController>()
                                              .getpaymentWay2
                                              .isNotEmpty
                                          ? Container(
                                              width: widget.btnWidth * 0.05,
                                            )
                                          : InkWell(
                                              onTap: () {
                                                context
                                                    .read<PosController>()
                                                    .removePayment(index);
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
                        })
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            context.watch<PosController>().getpaymentWay.length,
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
                                        color: Colors.grey.withOpacity(0.5),
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
                                          '${context.watch<PosController>().getpaymentWay[index].type}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        width: widget.btnWidth * 0.28,
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          '${context.watch<PosController>().getpaymentWay[index].reference}',
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          context
                                              .watch<PosController>()
                                              .config
                                              .splitValues(context
                                                  .watch<PosController>()
                                                  .getpaymentWay[index]
                                                  .amt!
                                                  .toStringAsFixed(2)),
                                          style: widget
                                              .theme.textTheme.bodyLarge
                                              ?.copyWith(color: Colors.black),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          context
                                              .read<PosController>()
                                              .removePayment(index);
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
          Container(
            padding: EdgeInsets.all(
              widget.btnheight * 0.01,
            ),
            child: context.watch<PosController>().selectedcust2 != null &&
                    context.watch<PosController>().scanneditemData2.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Container(
                      //     decoration: BoxDecoration(
                      //       color: widget.theme.primaryColor,
                      //       borderRadius: BorderRadius.circular(5),
                      //     ),
                      //     padding: EdgeInsets.all(
                      //       widget.btnheight * 0.01,
                      //     ),
                      //     child: GestureDetector(
                      //         onTap: () {
                      //           setState(() {
                      //             context.read<PosController>().cancelbtn =
                      //                 true;
                      //             context
                      //                 .read<PosController>()
                      //                 .clickcancelbtn(context, widget.theme);
                      //           });
                      //         },
                      //         child: Container(
                      //           width: widget.btnWidth * 0.2,
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //             // color: Colors.grey[400],
                      //             borderRadius: BorderRadius.circular(5),
                      //           ),
                      //           height: widget.btnheight * 0.15,
                      //           child: context
                      //                       .watch<PosController>()
                      //                       .cancelbtn ==
                      //                   false
                      //               ? Text("Cancel",
                      //                   textAlign: TextAlign.center,
                      //                   style: widget.theme.textTheme.bodySmall
                      //                       ?.copyWith(
                      //                     color: Colors.white,
                      //                   ))
                      //               : CircularProgressIndicator(
                      //                   color: widget.theme.primaryColor),
                      //         ))),
                      Container(
                          decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(
                            widget.btnheight * 0.01,
                          ),
                          child: GestureDetector(
                              onTap: context
                                          .read<PosController>()
                                          .ondDisablebutton ==
                                      true
                                  ? null
                                  : () {
                                      setState(() {
                                        context
                                            .read<PosController>()
                                            .callEinvoicebtn(
                                                context, widget.theme);
                                      });
                                    },
                              child: Container(
                                width: widget.btnWidth * 0.2,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: widget.btnheight * 0.15,
                                child: Text("E-Invoice",
                                    textAlign: TextAlign.center,
                                    style: widget.theme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: Colors.white,
                                    )),
                              ))),
                      Container(
                          decoration: BoxDecoration(
                            color: widget.theme.primaryColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(
                            widget.btnheight * 0.01,
                          ),
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  context.read<PosController>().cancelbtn =
                                      false;
                                  context.read<PosController>().selectedcust2 =
                                      null;
                                  context.read<PosController>().selectedcust =
                                      null;
                                  context
                                      .read<PosController>()
                                      .scanneditemData2
                                      .clear();
                                  context
                                      .read<PosController>()
                                      .paymentWay2
                                      .clear();

                                  context
                                      .read<PosController>()
                                      .tinNoController
                                      .text = '';
                                  context
                                      .read<PosController>()
                                      .vatNoController
                                      .text = '';
                                  context
                                      .read<PosController>()
                                      .custNameController
                                      .text = '';
                                  context.read<PosController>().totalPayment2 =
                                      null;
                                  context.read<PosController>().injectToDb();
                                  context.read<PosController>().getdraftindex();
                                  context
                                      .read<PosController>()
                                      .mycontroller2[50]
                                      .text = "";
                                  context.read<PosController>().searchmapbool =
                                      false;
                                });
                              },
                              child: Container(
                                width: widget.btnWidth * 0.2,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  // color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                height: widget.btnheight * 0.15,
                                child: Text("Clear",
                                    textAlign: TextAlign.center,
                                    style: widget.theme.textTheme.bodySmall
                                        ?.copyWith(
                                      color: Colors.white,
                                    )),
                              ))),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: widget.btnheight * 0.2,
                        width: widget.btnWidth * 0.23,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(9),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PosController>()
                                        .openSalesOrd
                                        .isEmpty &&
                                    context
                                        .read<PosController>()
                                        .openOrdLine!
                                        .isEmpty
                                ? null
                                : () {
                                    context.read<PosController>().selectAll =
                                        true;
                                    context
                                        .read<PosController>()
                                        .autoselectbtndisable = false;
                                    context
                                        .read<PosController>()
                                        .batchselectbtndisable = false;
                                    context
                                        .read<PosController>()
                                        .manualselectbtndisable = false;

                                    context.read<PosController>().noMsgText =
                                        '';
                                    context
                                        .read<PosController>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<PosController>()
                                        .clearTextField();
                                    context
                                        .read<PosController>()
                                        .salesorderheader();
                                    context.read<PosController>().soScanItem =
                                        [];

                                    log(" context.watch<PosController>().soSalesmodl.length:::${context.read<PosController>().soSalesmodl.length}");
                                    context
                                        .read<PosController>()
                                        .mycontroller[79]
                                        .text = '';

                                    context.read<PosController>().textError =
                                        '';

                                    context
                                                .read<PosController>()
                                                .getselectedcust ==
                                            null
                                        ? showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Choose customer..!!',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            })
                                        : context
                                                .read<PosController>()
                                                .openSalesOrd
                                                .isNotEmpty
                                            ? setState(() {
                                                for (var i = 0;
                                                    i <
                                                        context
                                                            .read<
                                                                PosController>()
                                                            .openSalesOrd
                                                            .length;
                                                    i++) {
                                                  context
                                                      .read<PosController>()
                                                      .openSalesOrd[i]
                                                      .invoiceClr = 0;
                                                  context
                                                      .read<PosController>()
                                                      .openSalesOrd[i]
                                                      .checkBClr = false;
                                                }
                                                context
                                                    .read<PosController>()
                                                    .selectIndex = null;
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    builder:
                                                        (BuildContext context) {
                                                      return StatefulBuilder(
                                                          builder:
                                                              (context, st) {
                                                        return AlertDialog(
                                                            insetPadding:
                                                                EdgeInsets.all(
                                                                    Screens.padingHeight(
                                                                            context) *
                                                                        0.01),
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            content: AlertBox(
                                                              payMent:
                                                                  'Sales Orders',
                                                              widget:
                                                                  forClicksoBtn(
                                                                      context,
                                                                      widget
                                                                          .theme),
                                                              callback: () {
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .selectIndex = null;
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .clearsoaqty();
                                                                context
                                                                    .read<
                                                                        PosController>()
                                                                    .showopenOrderLines();

                                                                st(() {
                                                                  if (context
                                                                      .read<
                                                                          PosController>()
                                                                      .openOrdLineList!
                                                                      .isNotEmpty) {
                                                                    context
                                                                        .read<
                                                                            PosController>()
                                                                        .selectAllItem();
                                                                    Navigator.pop(
                                                                        context);
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        barrierDismissible:
                                                                            false,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return AlertDialog(
                                                                              insetPadding: EdgeInsets.all(widget.btnWidth * 0.01),
                                                                              contentPadding: EdgeInsets.zero,
                                                                              content: AlertBox(
                                                                                payMent: 'Sales Order',
                                                                                widget: forScanSoOrder(context, widget.theme),
                                                                                buttonName: null,
                                                                              ));
                                                                        });
                                                                  } else {
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
                                                                                errormsg: true,
                                                                                widget: Center(
                                                                                    child: ContentContainer(
                                                                                  content: 'Choose Sales Order..!!',
                                                                                  theme: widget.theme,
                                                                                )),
                                                                                buttonName: null,
                                                                              ));
                                                                        });
                                                                  }
                                                                });
                                                              },
                                                              buttonName: "OK",
                                                            ));
                                                      });
                                                    });
                                              })
                                            : showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      content: AlertBox(
                                                        payMent: 'Alert',
                                                        errormsg: true,
                                                        widget: Center(
                                                            child:
                                                                ContentContainer(
                                                          content:
                                                              'No sales order here',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                });
                                    context.read<PosController>().addIndex = [];
                                    context
                                        .read<PosController>()
                                        .selectionBtnLoading = false;

                                    context
                                        .read<PosController>()
                                        .disableKeyBoard(context);
                                  },
                            child: Text(
                              "Copy From S.O",
                              style: widget.theme.textTheme.bodyLarge!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.2,
                        width: widget.btnWidth * 0.15,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(9),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PosController>()
                                        .ondDisablebutton ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<PosController>()
                                        .ondDisablebutton = true;
                                    if (context
                                                .read<PosController>()
                                                .getselectedcust ==
                                            null &&
                                        context
                                            .read<PosController>()
                                            .soScanItem
                                            .isEmpty) {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                content: AlertBox(
                                                  payMent: 'Alert',
                                                  errormsg: true,
                                                  widget: Center(
                                                      child: ContentContainer(
                                                    content:
                                                        'Choose the Customer or Product',
                                                    theme: widget.theme,
                                                  )),
                                                  buttonName: null,
                                                ));
                                          }).then((value) {
                                        context
                                            .read<PosController>()
                                            .ondDisablebutton = false;
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: forSuspend(
                                                  context, widget.theme),
                                            );
                                          }).then((value) {
                                        context
                                            .read<PosController>()
                                            .ondDisablebutton = false;
                                      });
                                    }
                                    context
                                        .read<PosController>()
                                        .disableKeyBoard(context);
                                    context
                                        .read<PosController>()
                                        .ondDisablebutton = false;
                                  },
                            child: Text(
                              "Clear All",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.2,
                        width: widget.btnWidth * 0.17,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(9),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PosController>()
                                        .ondDisablebutton ==
                                    true
                                ? null
                                : () {
                                    setState(() {
                                      context
                                          .read<PosController>()
                                          .onHoldClicked(context, widget.theme);
                                      context
                                          .read<PosController>()
                                          .disableKeyBoard(context);
                                    });
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.2,
                        width: widget.btnWidth * 0.15,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(9),
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<PosController>()
                                        .ondDisablebutton ==
                                    true
                                ? null
                                : () {
                                    setState(() {
                                      createUDF(context, widget.theme);
                                    });
                                  },
                            child: Text(
                              "UDF",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: widget.btnWidth * 0.18,
                        height: widget.btnheight * 0.2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.theme.primaryColor,
                            ),
                            onPressed: context
                                        .read<PosController>()
                                        .ondDisablebutton ==
                                    false
                                ? () {
                                    setState(() {
                                      if (context
                                              .read<PosController>()
                                              .selectedcust!
                                              .paymentGroup!
                                              .contains('cash') ==
                                          true) {
                                        log('bbbbbbbb');
                                        if (context
                                            .read<PosController>()
                                            .custNameController
                                            .text
                                            .isNotEmpty) {
                                          context
                                              .read<PosController>()
                                              .changecheckout(
                                                  context, widget.theme);
                                        } else {
                                          context
                                                  .read<PosController>()
                                                  .custNameerror =
                                              'Enter customer name';

                                          Get.defaultDialog(
                                            titlePadding: EdgeInsets.all(10),
                                            title: 'Alert',
                                            middleText:
                                                '${context.read<PosController>().custNameerror}',
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                    child: const Text("Close"),
                                                    onPressed: () => Get.back(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        }
                                      } else {
                                        context
                                            .read<PosController>()
                                            .changecheckout(
                                                context, widget.theme);
                                      }
                                      context
                                          .read<PosController>()
                                          .disableKeyBoard(context);
                                    });
                                  }
                                : null,
                            child: Text(
                              "Save",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  // forSuspend(BuildContext context, ThemeData theme) {
  //   return Container(
  //       padding: EdgeInsets.symmetric(
  //           horizontal: widget.btnWidth * 0.03,
  //           vertical: widget.btnheight * 0.01),
  //       child: Column(
  //         children: [
  //           SizedBox(
  //               height: widget.btnheight * 0.4,
  //               child: Center(
  //                   child: Text(
  //                       "You about to suspended all information will be unsaved"))),
  //           SizedBox(
  //             height: widget.btnheight * 0.01,
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               SizedBox(
  //                 width: widget.btnWidth * 0.15,
  //                 child: ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.pop(context);

  //                       context
  //                           .read<PosController>()
  //                           .clearSuspendedData(context, theme);
  //                     },
  //                     child: const Text("Yes")),
  //               ),
  //               SizedBox(
  //                 width: widget.btnWidth * 0.15,
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
              alignment: Alignment.center,
              height: widget.btnheight * 0.2,
              color: theme.primaryColor,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: widget.btnWidth * 0.1),
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
              height: widget.btnheight * 0.02,
            ),
            Container(
                padding: EdgeInsets.symmetric(
                    horizontal: widget.btnWidth * 0.02,
                    vertical: widget.btnheight * 0.005),
                // height: widget.btnheight * 0.2,
                child: const Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
            SizedBox(
              height: widget.btnheight * 0.02,
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
                              .read<PosController>()
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

  forClicksoBtn(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.all(widget.btnheight * 0.02),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(widget.btnheight * 0.06),
              width: widget.btnWidth * 1.8,
              color: theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: widget.btnWidth * 0.25,
                    child: Text("S.O Number",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    width: widget.btnWidth * 0.45,
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
                    alignment: Alignment.center,
                    width: widget.btnWidth * 0.18,
                    child: Text("Date",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: widget.btnWidth * 0.25,
                    child: Text("Total",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(widget.btnheight * 0.02),
              height: widget.btnheight * 2.4,
              width: widget.btnWidth * 1.8,
              child: ListView.builder(
                  itemCount: context.watch<PosController>().openSalesOrd.length,
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.grey[200],
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: context
                                              .watch<PosController>()
                                              .openSalesOrd[index]
                                              .invoiceClr ==
                                          0 &&
                                      context
                                              .watch<PosController>()
                                              .openSalesOrd[index]
                                              .checkBClr ==
                                          false
                                  ? Colors.grey.withOpacity(0.2)
                                  : Colors.blue.withOpacity(0.35)),
                          child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (val) {
                                context.read<PosController>().selectIndex =
                                    index;
                                context
                                    .read<PosController>()
                                    .openSalesOrdItemDeSelect(index);
                              },
                              value: context
                                  .read<PosController>()
                                  .openSalesOrd[index]
                                  .checkBClr,
                              title: SizedBox(
                                width: widget.btnWidth * 0.77,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: widget.btnWidth * 0.18,
                                        child: Text(
                                          "${context.watch<PosController>().openSalesOrd[index].docNum.toString()}",
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        )),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        width: widget.btnWidth * 0.45,
                                        child: Text(
                                          context
                                              .watch<PosController>()
                                              .openSalesOrd[index]
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
                                              .watch<PosController>()
                                              .openSalesOrd[index]
                                              .comments
                                              .toString(),
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        )),
                                    Container(
                                        width: widget.btnWidth * 0.18,
                                        alignment: Alignment.center,
                                        child: Text(
                                          context
                                              .watch<PosController>()
                                              .config
                                              .alignDateT(context
                                                  .watch<PosController>()
                                                  .openSalesOrd[index]
                                                  .docDate
                                                  .toString()),
                                          style: theme.textTheme.bodyLarge!
                                              .copyWith(),
                                        )),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        width: widget.btnWidth * 0.25,
                                        child: Text(context
                                            .watch<PosController>()
                                            .config
                                            .splitValues(context
                                                .watch<PosController>()
                                                .openSalesOrd[index]
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
      );
    });
  }

  createUDF(BuildContext context, ThemeData theme) async {
    await showDialog<dynamic>(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setst) {
            final theme = Theme.of(context);
            return AlertDialog(
                insetPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.zero,
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.center,
                          width: widget.btnWidth * 0.85,
                          color: theme.primaryColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  padding: EdgeInsets.only(
                                    left: widget.btnWidth * 0.15,
                                  ),
                                  alignment: Alignment.center,
                                  width: widget.btnWidth * 0.7,
                                  height: widget.btnheight * 0.15,
                                  child: const Text(
                                    'Create UDF',
                                    style: TextStyle(color: Colors.white),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  right: widget.btnWidth * 0.02,
                                ),
                                child: IconButton(
                                    onPressed: () {
                                      setst(
                                        () {
                                          Get.back();
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          )),
                      SizedBox(
                        height: Screens.padingHeight(context) * 0.02,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Form(
                            key: context.read<PosController>().formkeyy[15],
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
                                        alignment: Alignment.center,
                                        child: const Text("Internal Truck"),
                                      ),
                                      SizedBox(width: widget.btnWidth * 0.05),
                                      Container(
                                        width: widget.btnWidth * 0.55,
                                        padding: EdgeInsets.only(
                                          left: widget.btnheight * 0.01,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField(
                                            hint: const Text(
                                              "Select",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                            value: context
                                                .watch<PosController>()
                                                .selectedTruckType,
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 30,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                            ),
                                            isExpanded: true,
                                            validator: ((value) {
                                              if (value == null) {
                                                return 'Please Select Internal Truck';
                                              }
                                              return null;
                                            }),
                                            onChanged: (val) {
                                              setState(() {
                                                context
                                                        .read<PosController>()
                                                        .selectedTruckType =
                                                    val.toString();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5,
                                                horizontal: 10,
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.red),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            items: context
                                                .watch<PosController>()
                                                .getinternalTruckType
                                                .map((e) {
                                              return DropdownMenuItem(
                                                  value: e["value"],
                                                  child: Text(
                                                      e["name"].toString(),
                                                      style: widget.theme
                                                          .textTheme.bodyMedium!
                                                          .copyWith(
                                                              color: Colors
                                                                  .black)));
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: widget.btnheight * 0.05),
                                  context
                                                  .watch<PosController>()
                                                  .selectedTruckType ==
                                              null &&
                                          context
                                                  .watch<PosController>()
                                                  .isSelectTruckType ==
                                              true
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: widget.btnWidth * 0.1),
                                          child: const Text(
                                            'Please Select Internal Truck',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 15),
                                          ))
                                      : Container(),
                                ])),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            setst(
                              () {
                                context
                                    .read<PosController>()
                                    .validateUDF(context);
                              },
                            );
                          },
                          child: Container(
                              width: widget.btnWidth * 0.8,
                              alignment: Alignment.center,
                              height: widget.btnheight * 0.18,
                              child: const Text('OK')))
                    ],
                  ),
                ));
          });
        });
  }

  forScanSoOrder(BuildContext context, ThemeData theme) {
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.all(
          widget.btnheight * 0.01,
        ),
        width: widget.btnWidth * 2.25,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: widget.btnWidth * 1.1,
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Text(' Select All '),
                        Checkbox(
                            value: context.read<PosController>().selectAll,
                            side: const BorderSide(color: Colors.grey),
                            activeColor: Colors.green,
                            onChanged: (value) {
                              st(
                                () {
                                  context.read<PosController>().selectAll =
                                      value!;
                                  context
                                      .read<PosController>()
                                      .autoselectbtndisable = false;
                                  context
                                      .read<PosController>()
                                      .batchselectbtndisable = false;

                                  log('selectAllselectAllselectAll::${context.read<PosController>().selectAll}');
                                  context.read<PosController>().selectAllItem();
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                  Container(
                    width: widget.btnWidth * 1.1,
                    padding: EdgeInsets.only(
                      top: widget.btnheight * 0.01,
                      left: widget.btnWidth * 0.01,
                      right: widget.btnWidth * 0.01,
                      bottom: widget.btnheight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: theme.primaryColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                              left: widget.btnheight * 0.01,
                            ),
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.23,
                            child: Text(
                              "Item Code",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.4,
                            child: Text(
                              "Item Name",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.15,
                            child: Text(
                              "In Stock",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.13,
                            child: Text(
                              "S.O Qty",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                        Container(
                            alignment: Alignment.center,
                            width: widget.btnWidth * 0.1,
                            child: Text(
                              "",
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    height: widget.btnheight * 3,
                    width: widget.btnWidth * 1.1,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: context
                            .watch<PosController>()
                            .openOrdLineList!
                            .length,
                        itemBuilder: (context, index) {
                          return Card(
                              margin: EdgeInsets.all(2),
                              color: Colors.grey[200],
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: context
                                                      .watch<PosController>()
                                                      .openOrdLineList![index]
                                                      .invoiceClr ==
                                                  1 &&
                                              context
                                                      .watch<PosController>()
                                                      .openOrdLineList![index]
                                                      .checkBClr ==
                                                  true
                                          ? Colors.blue.withOpacity(0.35)
                                          : Colors.grey.withOpacity(0.2)),
                                  child: CheckboxListTile(

                                      // secondary: Container(width: 0),

                                      contentPadding: EdgeInsets.zero,
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      onChanged: (val) {
                                        setState(() {
                                          context
                                              .read<PosController>()
                                              .autoselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .batchselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .manualselectbtndisable = false;
                                          context
                                              .read<PosController>()
                                              .selectAll = false;
                                          context
                                              .read<PosController>()
                                              .selectIndex = index;
                                          context
                                              .read<PosController>()
                                              .noMsgText = '';
                                          context
                                              .read<PosController>()
                                              .selectSameItemCode(context
                                                  .read<PosController>()
                                                  .openOrdLineList![index]
                                                  .itemCode);
                                        });
                                        // context
                                        //     .read<PosController>()
                                        //     .additemlistcount(
                                        //         index,
                                        //         context
                                        //             .read<PosController>()
                                        //             .openOrdLineList![index]
                                        //             .itemCode);
                                      },
                                      value: context
                                          .watch<PosController>()
                                          .openOrdLineList![index]
                                          .checkBClr,
                                      title: Transform.translate(
                                          offset: const Offset(-20, 0),
                                          child: SizedBox(
                                            height: widget.btnheight * 0.25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        widget.btnWidth * 0.18,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .itemCode
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        widget.btnWidth * 0.42,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .description
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width:
                                                        widget.btnWidth * 0.12,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .stock
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    width:
                                                        widget.btnWidth * 0.14,
                                                    child: Text(
                                                      context
                                                          .watch<
                                                              PosController>()
                                                          .openOrdLineList![
                                                              index]
                                                          .openQty
                                                          .toString(),
                                                      style: theme
                                                          .textTheme.bodyLarge!
                                                          .copyWith(),
                                                    )),
                                                SizedBox(
                                                  width: widget.btnWidth * 0.01,
                                                ),
                                                Container(
                                                    width:
                                                        widget.btnWidth * 0.12,
                                                    height:
                                                        widget.btnheight * 0.22,
                                                    alignment: Alignment.center,
                                                    child: TextFormField(
                                                      style: theme
                                                          .textTheme.bodyMedium,
                                                      onTap: () {
                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .text =
                                                            context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .text;
                                                        context
                                                                .read<
                                                                    PosController>()
                                                                .soListController[
                                                                    index]
                                                                .selection =
                                                            TextSelection(
                                                          baseOffset: 0,
                                                          extentOffset: context
                                                              .read<
                                                                  PosController>()
                                                              .soListController[
                                                                  index]
                                                              .text
                                                              .length,
                                                        );
                                                      },
                                                      // inputFormatters: [
                                                      //   context
                                                      //                   .watch<
                                                      //                       PosController>()
                                                      //                   .openOrdLineList![
                                                      //                       index]
                                                      //                   .uPackSize ==
                                                      //               null ||
                                                      //           context
                                                      //                   .watch<
                                                      //                       PosController>()
                                                      //                   .openOrdLineList![
                                                      //                       index]
                                                      //                   .uPackSize ==
                                                      //               0.000
                                                      //       ? FilteringTextInputFormatter
                                                      //           .allow(RegExp(
                                                      //               dotAll:
                                                      //                   true,
                                                      //               r'^\d*\.?\d{0,9}$'))
                                                      //       : FilteringTextInputFormatter
                                                      //           .digitsOnly
                                                      // ],
                                                      cursorColor: Colors.grey,
                                                      textAlign:
                                                          TextAlign.right,
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      inputFormatters: [
                                                        DecimalInputFormatter()
                                                      ],
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          context
                                                              .read<
                                                                  PosController>()
                                                              .soOrderListQtychange(
                                                                  index,
                                                                  context,
                                                                  theme);
                                                        });
                                                        context
                                                            .read<
                                                                PosController>()
                                                            .disableKeyBoard(
                                                                context);
                                                      },
                                                      controller: context
                                                          .read<PosController>()
                                                          .soListController[index],
                                                      decoration:
                                                          InputDecoration(
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .grey),
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
                                          )))));
                        }),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[100],
              height: widget.btnheight * 3.5,
              width: widget.btnWidth * 1.13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: widget.btnWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller:
                              context.read<PosController>().mycontroller[79],
                          style: theme.textTheme.bodyMedium!
                              .copyWith(color: Colors.black),
                          onChanged: (val) {},
                          onEditingComplete: () {
                            st(() {
                              context.read<PosController>().textError = '';

                              context.read<PosController>().soInvoiceScan(
                                    context
                                        .read<PosController>()
                                        .mycontroller[79]
                                        .text
                                        .toString()
                                        .trim()
                                        .toUpperCase(),
                                    context,
                                    theme,
                                  );
                            });
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(8),
                            hintText: "Scan Serial Batch",
                            hintStyle: theme.textTheme.bodyMedium!
                                .copyWith(color: Colors.grey[600]),
                            suffixIcon: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.search,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: widget.btnheight * 0.02,
                      ),
                      Container(
                        width: widget.btnheight * 0.7,
                        child: ElevatedButton(
                            onPressed: context
                                        .watch<PosController>()
                                        .batchselectbtndisable ==
                                    true
                                ? null
                                : () {
                                    setState(() {
                                      context
                                          .read<PosController>()
                                          .newadditemlistcount();
                                      if (context
                                              .read<PosController>()
                                              .addIndex
                                              .length >=
                                          1) {
                                        context
                                            .read<PosController>()
                                            .soScanItem = [];
                                        context
                                            .read<PosController>()
                                            .soFilterScanItem = [];

                                        context
                                            .read<PosController>()
                                            .batchselectbtndisable = true;

                                        context
                                            .read<PosController>()
                                            .callFetchFromPdaAllApi(
                                                theme, context);
                                      } else if (context
                                              .read<PosController>()
                                              .selectIndex !=
                                          null) {
                                        context
                                            .read<PosController>()
                                            .callFetchFromPdaItemApi(
                                                context
                                                    .read<PosController>()
                                                    .selectIndex!,
                                                theme,
                                                context);
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: true,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      const EdgeInsets.all(0),
                                                  content: AlertBox(
                                                    payMent: 'Alert',
                                                    errormsg: true,
                                                    widget: Center(
                                                        child: ContentContainer(
                                                      content:
                                                          'Select Item List',
                                                      theme: theme,
                                                    )),
                                                    buttonName: null,
                                                  ));
                                            });
                                      }
                                    });
                                  },
                            child: Text('Fetch Batch From PDA')),
                      ),
                      SizedBox(
                        width: widget.btnheight * 0.02,
                      ),
                      ElevatedButton(
                          onPressed: context
                                      .read<PosController>()
                                      .autoselectbtndisable ==
                                  true
                              ? null
                              : () {
                                  context
                                      .read<PosController>()
                                      .newadditemlistcount();
                                  if (context
                                          .read<PosController>()
                                          .addIndex
                                          .length >=
                                      1) {
                                    context.read<PosController>().soScanItem =
                                        [];
                                    log('selectIndexselectIndex::${context.read<PosController>().selectIndex}');

                                    setState(() {
                                      context
                                          .read<PosController>()
                                          .autoselectbtndisable = true;

                                      context
                                          .read<PosController>()
                                          .newAutoselectAllMethod(
                                            theme,
                                            context,
                                          );
                                    });
                                    // } else if (context
                                    //         .read<PosController>()
                                    //         .selectIndex !=
                                    //     null) {
                                    //   context
                                    //       .read<PosController>()
                                    //       .newAutoselectItemMethod(
                                    //           // context
                                    //           //     .read<PosController>()
                                    //           //     .selectIndex!,
                                    //           theme,
                                    //           context);
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content: 'Select Item List',
                                                  theme: theme,
                                                )),
                                                buttonName: null,
                                              ));
                                        });
                                  }
                                },
                          child: Text('Auto Select')),
                      ElevatedButton(
                          onPressed: context
                                      .read<PosController>()
                                      .manualselectbtndisable ==
                                  true
                              ? null
                              : () {
                                  log('selectIndexselectIndex::${context.read<PosController>().selectIndex}');
                                  context
                                      .read<PosController>()
                                      .newadditemlistcount();
                                  if (context
                                          .read<PosController>()
                                          .addIndex
                                          .length ==
                                      1) {
                                    context
                                        .read<PosController>()
                                        .manualselectItemMethod(
                                            context
                                                .read<PosController>()
                                                .selectIndex!,
                                            theme,
                                            context);
                                  } else if (context
                                              .read<PosController>()
                                              .addIndex
                                              .length >
                                          1 ||
                                      context.read<PosController>().selectAll ==
                                          true) {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content:
                                                      'Kindy select only one item',
                                                  theme: theme,
                                                )),
                                                buttonName: null,
                                              ));
                                        });
                                  } else {
                                    showDialog(
                                        context: context,
                                        barrierDismissible: true,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              content: AlertBox(
                                                payMent: 'Alert',
                                                errormsg: true,
                                                widget: Center(
                                                    child: ContentContainer(
                                                  content:
                                                      'Kindly Select Item List',
                                                  theme: theme,
                                                )),
                                                buttonName: null,
                                              ));
                                        });
                                  }
                                  // if (context.read<PosController>().selectAll ==
                                  //     false) {
                                  //   if (context
                                  //           .read<PosController>()
                                  //           .selectIndex !=
                                  //       null) {
                                  // context
                                  //     .read<PosController>()
                                  //     .manualselectItemMethod(
                                  //         context
                                  //             .read<PosController>()
                                  //             .selectIndex!,
                                  //         theme,
                                  //         context);
                                  //   } else {
                                  // showDialog(
                                  //     context: context,
                                  //     barrierDismissible: true,
                                  //     builder: (BuildContext context) {
                                  //       return AlertDialog(
                                  //           contentPadding:
                                  //               const EdgeInsets.all(0),
                                  //           content: AlertBox(
                                  //             payMent: 'Alert',
                                  //             errormsg: true,
                                  //             widget: Center(
                                  //                 child: ContentContainer(
                                  //               content: 'Select Item List',
                                  //               theme: theme,
                                  //             )),
                                  //             buttonName: null,
                                  //           ));
                                  //     });
                                  //   }
                                  // } else {
                                  //   showDialog(
                                  //       context: context,
                                  //       barrierDismissible: true,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //             contentPadding:
                                  //                 const EdgeInsets.all(0),
                                  //             content: AlertBox(
                                  //               payMent: 'Alert',
                                  //               errormsg: true,
                                  //               widget: Center(
                                  //                   child: ContentContainer(
                                  //                 content:
                                  //                     'Kindly deselect the all items',
                                  //                 theme: theme,
                                  //               )),
                                  //               buttonName: null,
                                  //             ));
                                  //       });
                                  // }
                                },
                          child: Text('Manual Select')),
                    ],
                  ),
                  SizedBox(
                    height: widget.btnheight * 0.01,
                  ),
                  context.watch<PosController>().noMsgText.isNotEmpty &&
                          context.watch<PosController>().selectIndex != null
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: widget.btnWidth * 0.05,
                          ),
                          child: Text(
                            context.watch<PosController>().noMsgText,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.red),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: widget.btnheight * 0.02,
                  ),
                  context.watch<PosController>().selectionBtnLoading == true
                      ? Container(
                          height: widget.btnheight * 2.7,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: theme.primaryColor,
                            ),
                          ),
                        )
                      : context.watch<PosController>().soScanItem.isNotEmpty
                          ? Container(
                              child: Column(
                                children: [
                                  Container(
                                    width: widget.btnWidth * 1.3,
                                    padding: EdgeInsets.only(
                                      top: widget.btnheight * 0.01,
                                      left: widget.btnWidth * 0.01,
                                      right: widget.btnWidth * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.primaryColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                              left: widget.btnheight * 0.01,
                                            ),
                                            alignment: Alignment.center,
                                            width: widget.btnWidth * 0.3,
                                            child: Text(
                                              "Product Information",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            )),
                                        Container(
                                            alignment: Alignment.center,
                                            width: widget.btnWidth * 0.13,
                                            child: Text(
                                              "S.O Qty",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: widget.btnheight * 0.01,
                                  ),
                                  Container(
                                    height: widget.btnheight * 2.7,
                                    width: widget.btnWidth * 1.3,
                                    child: ListView.builder(
                                        itemCount: context
                                            .watch<PosController>()
                                            .soFilterScanItem
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            margin: EdgeInsets.all(2),
                                            child: Container(
                                                padding: EdgeInsets.only(
                                                  top: widget.btnheight * 0.01,
                                                  left: widget.btnWidth * 0.01,
                                                  right: widget.btnWidth * 0.01,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: Colors.grey
                                                      .withOpacity(0.04),
                                                ),
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                          width:
                                                              widget.btnWidth *
                                                                  0.4,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${context.watch<PosController>().soFilterScanItem[index].itemName}",
                                                            maxLines: 2,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(
                                                                    color: Colors
                                                                        .black),
                                                          )),
                                                      Container(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          // color: Colors.red,
                                                          width:
                                                              widget.btnWidth *
                                                                  0.25,
                                                          height:
                                                              widget.btnheight *
                                                                  0.17,
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      widget.btnWidth *
                                                                          0.005),
                                                          child: Text(
                                                            "${context.watch<PosController>().soFilterScanItem[index].openRetQty}",
                                                          )),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        widget.btnheight * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${context.watch<PosController>().soFilterScanItem[index].serialBatch}",
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: theme
                                                                .textTheme
                                                                .bodyMedium
                                                                ?.copyWith(),
                                                          )),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          "  |  ${context.watch<PosController>().soFilterScanItem[index].itemCode}",
                                                          style: theme.textTheme
                                                              .bodyMedium
                                                              ?.copyWith(),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ])),
                                          );
                                        }),
                                  ),
                                  SizedBox(
                                    height: widget.btnheight * 0.02,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (context
                                              .read<PosController>()
                                              .soScanItem
                                              .isNotEmpty) {
                                            context
                                                .read<PosController>()
                                                .mapsodata(
                                                  context,
                                                  widget.theme,
                                                );
                                          } else {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: true,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      content: AlertBox(
                                                        payMent: 'Alert',
                                                        errormsg: true,
                                                        widget: Center(
                                                            child:
                                                                ContentContainer(
                                                          content:
                                                              'Scan the Serialbatch',
                                                          theme: widget.theme,
                                                        )),
                                                        buttonName: null,
                                                      ));
                                                });
                                          }
                                        });
                                      },
                                      child: Container(
                                          width: widget.btnWidth * 1,
                                          alignment: Alignment.center,
                                          height: widget.btnheight * 0.15,
                                          child: const Text('OK')))
                                ],
                              ),
                            )
                          : Container(),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
