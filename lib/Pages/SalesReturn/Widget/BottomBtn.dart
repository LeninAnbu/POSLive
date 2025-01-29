import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posproject/Widgets/AlertBox.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/SalesReturnController/SalesReturnController.dart';
import '../../../Widgets/ContentContainer.dart';

class BottomBtn extends StatefulWidget {
  BottomBtn({
    super.key,
    required this.theme,
    required this.btnWidth,
    required this.btnheight,
  });

  final ThemeData theme;
  double btnheight;
  double btnWidth;

  @override
  State<BottomBtn> createState() => _BottomBtnState();
}

class _BottomBtnState extends State<BottomBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.01),
      height: widget.btnheight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(widget.btnheight * 0.01),
            child: Text(
              context.read<SalesReturnController>().paymentWay.isEmpty
                  ? ""
                  : "Payment Method",
              textAlign: TextAlign.start,
              style: widget.theme.textTheme.bodyLarge?.copyWith(
                color: widget.theme.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: widget.btnheight * 0.6,
            child: context.read<SalesReturnController>().paymentWay2.isNotEmpty
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: context
                        .watch<SalesReturnController>()
                        .paymentWay2
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
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: widget.btnWidth * 0.25,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay2[index].type}',
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.28,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay2[index].reference}',
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesReturnController>()
                                              .getpaymentWay2[index]
                                              .amt!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  context
                                          .watch<SalesReturnController>()
                                          .paymentWay2
                                          .isNotEmpty
                                      ? Container(
                                          width: widget.btnWidth * 0.05,
                                        )
                                      : InkWell(
                                          onTap: () {},
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
                    itemCount: context
                        .watch<SalesReturnController>()
                        .paymentWay
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
                                      '${context.watch<SalesReturnController>().getpaymentWay[index].type}',
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: widget.btnWidth * 0.28,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${context.watch<SalesReturnController>().getpaymentWay[index].reference}',
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      context
                                          .watch<SalesReturnController>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesReturnController>()
                                              .getpaymentWay[index]
                                              .amt!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .read<SalesReturnController>()
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
          Container(
            padding: EdgeInsets.all(
              widget.btnheight * 0.01,
            ),
            child: context
                    .read<SalesReturnController>()
                    .scanneditemData2
                    .isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // GestureDetector(
                      //     onTap: () {
                      //       setState(() {
                      //         context.read<SalesReturnController>().cancelbtn =
                      //             true;
                      //         context
                      //             .read<SalesReturnController>()
                      //             .clickacancelbtn(context, widget.theme);
                      //       });
                      //     },
                      //     child: Container(
                      //       width: widget.btnWidth * 0.28,
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: widget.theme.primaryColor,
                      //         borderRadius: BorderRadius.circular(5),
                      //       ),
                      //       height: widget.btnheight * 0.2,
                      //       child: context
                      //                   .read<SalesReturnController>()
                      //                   .cancelbtn ==
                      //               false
                      //           ? Text("Cancel",
                      //               textAlign: TextAlign.center,
                      //               style: widget.theme.textTheme.bodySmall
                      //                   ?.copyWith(
                      //                 color: Colors.white,
                      //               ))
                      //           : CircularProgressIndicator(
                      //               color: widget.theme.primaryColor),
                      //     )),
                      context.read<SalesReturnController>().isApprove == true
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  context
                                      .read<SalesReturnController>()
                                      .loadingscrn = true;
                                  context
                                      .read<SalesReturnController>()
                                      .freezeScrn = true;
                                  setState(() {
                                    context
                                        .read<SalesReturnController>()
                                        .callApprovaltoDocApi(
                                            context, widget.theme);
                                  });
                                });
                              },
                              child: Container(
                                  width: widget.btnWidth * 0.28,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: widget.theme.primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  height: widget.btnheight * 0.2,
                                  child: Text("Save",
                                      textAlign: TextAlign.center,
                                      style: widget.theme.textTheme.bodySmall
                                          ?.copyWith(
                                        color: Colors.white,
                                      ))))
                          : Container(),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              context
                                  .read<SalesReturnController>()
                                  .scanneditemData2
                                  .clear();

                              context
                                  .read<SalesReturnController>()
                                  .selectedcust2 = null;
                              context
                                  .read<SalesReturnController>()
                                  .totalPayment2 = null;
                              context
                                  .read<SalesReturnController>()
                                  .paymentWay2
                                  .clear();
                              context
                                  .read<SalesReturnController>()
                                  .scanneditemData
                                  .clear();
                              context.read<SalesReturnController>().cancelbtn =
                                  false;
                              context
                                  .read<SalesReturnController>()
                                  .selectedcust = null;
                              context
                                  .read<SalesReturnController>()
                                  .totalPayment = null;
                              context
                                  .read<SalesReturnController>()
                                  .paymentWay
                                  .clear();
                              context
                                  .read<SalesReturnController>()
                                  .getdraftindex();

                              context
                                  .read<SalesReturnController>()
                                  .mycontroller2[50]
                                  .text = "";
                            });
                          },
                          child: Container(
                            width: widget.btnWidth * 0.28,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: widget.theme.primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            height: widget.btnheight * 0.2,
                            child: Text("Clear",
                                style:
                                    widget.theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white,
                                )),
                          )),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: widget.btnheight * 0.23,
                        width: widget.btnWidth * 0.2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<SalesReturnController>()
                                        .freezeScrn ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<SalesReturnController>()
                                        .freezeScrn = true;
                                    if (context
                                            .read<SalesReturnController>()
                                            .selectedcust ==
                                        null) {
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
                                                          'Choose Customer..!!',
                                                      theme: widget.theme,
                                                    )),
                                                    buttonName: null));
                                          }).then((value) {
                                        context
                                            .read<SalesReturnController>()
                                            .freezeScrn = false;
                                      });
                                    } else {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                content: AlertBox(
                                                  buttonName: null,
                                                  payMent: 'Suspended',
                                                  widget: forSuspend(
                                                      context, widget.theme),
                                                ));
                                          }).then((value) {
                                        setState(() {
                                          context
                                              .read<SalesReturnController>()
                                              .freezeScrn = false;
                                        });
                                      });
                                    }
                                    context
                                        .read<SalesReturnController>()
                                        .disableKeyBoard(context);
                                  },
                            child: Text(
                              "Clear All",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.23,
                        width: widget.btnWidth * 0.2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<SalesReturnController>()
                                        .freezeScrn ==
                                    true
                                ? null
                                : () {
                                    context
                                        .read<SalesReturnController>()
                                        .onHoldClicked(context, widget.theme);
                                  },
                            child: Text(
                              "Hold",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        height: widget.btnheight * 0.23,
                        width: widget.btnWidth * 0.2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: BorderSide(
                                  color: widget.theme.primaryColor,
                                )),
                            onPressed: context
                                        .read<SalesReturnController>()
                                        .freezeScrn ==
                                    true
                                ? null
                                : () {
                                    createUDF(context, widget.theme);
                                  },
                            child: Text(
                              "UDF",
                              style: widget.theme.textTheme.bodyMedium!
                                  .copyWith(color: widget.theme.primaryColor),
                            )),
                      ),
                      SizedBox(
                        width: widget.btnWidth * 0.24,
                        height: widget.btnheight * 0.23,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(),
                            onPressed: context
                                        .read<SalesReturnController>()
                                        .freezeScrn ==
                                    false
                                ? () {
                                    log('VV::${context.read<SalesReturnController>().freezeScrn}');

                                    setState(() {
                                      context
                                          .read<SalesReturnController>()
                                          .confirmReturn(context, widget.theme);
                                    });
                                    context
                                        .read<SalesReturnController>()
                                        .disableKeyBoard(context);
                                  }
                                : null,
                            child: Text(
                              "Confirm Request",
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

  forSuspend(BuildContext context, ThemeData theme) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: Screens.width(context) * 0.04,
            vertical: Screens.bodyheight(context) * 0.01),
        child: Column(
          children: [
            SizedBox(
                height: widget.btnheight * 0.3,
                child: const Center(
                    child: Text(
                        "You about to suspended all information will be unsaved  "))),
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
                        context.read<SalesReturnController>().freezeScrn = true;
                        context
                            .read<SalesReturnController>()
                            .clearSuspendedData(context, theme);
                      },
                      child: const Text("Yes")),
                ),
                SizedBox(
                  width: Screens.width(context) * 0.15,
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<SalesReturnController>().freezeScrn =
                            false;
                        Navigator.pop(context);
                      },
                      child: const Text("No")),
                ),
              ],
            )
          ],
        ));
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
                            key: context
                                .read<SalesReturnController>()
                                .formkey[15],
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
                                        child: const Text("Credit Note Type"),
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
                                                .watch<SalesReturnController>()
                                                .selectCreditNoteType,
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
                                                return 'Select Credit Note Type';
                                              }
                                              return null;
                                            }),
                                            onChanged: (val) {
                                              setState(() {
                                                context
                                                        .read<
                                                            SalesReturnController>()
                                                        .selectCreditNoteType =
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
                                                .read<SalesReturnController>()
                                                .getCreditNoteType
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                        value: item.name,
                                                        child: Text(
                                                          item.name!,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        )))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: widget.btnheight * 0.05),
                                  context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .selectCreditNoteType ==
                                              null &&
                                          context
                                                  .watch<
                                                      SalesReturnController>()
                                                  .isselectCredit ==
                                              true
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              left: widget.btnWidth * 0.1),
                                          child: const Text(
                                            'Please Select Credit Note Type',
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
                                    .read<SalesReturnController>()
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
}
