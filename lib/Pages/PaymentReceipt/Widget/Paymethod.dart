import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/PaymentReceiptController/PayReceiptController.dart';
import 'package:provider/provider.dart';

class PayReceiptPayDetails extends StatefulWidget {
  PayReceiptPayDetails(
      {super.key,
      required this.theme,
      required this.paymentHeight,
      required this.paymentWidth});
  final ThemeData theme;
  double paymentHeight;
  double paymentWidth;

  @override
  State<PayReceiptPayDetails> createState() => _PayReceiptPayDetailsState();
}

class _PayReceiptPayDetailsState extends State<PayReceiptPayDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.paymentHeight,
        width: widget.paymentWidth,
        padding: EdgeInsets.only(
          top: widget.paymentHeight * 0.05,
          left: widget.paymentHeight * 0.01,
          right: widget.paymentHeight * 0.01,
          // bottom: widget.paymentHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:
                context.watch<PayreceiptController>().selectedcust2 != null ||
                        context
                            .watch<PayreceiptController>()
                            .getScanneditemData2
                            .isNotEmpty
                    ? Colors.grey[300]
                    : Colors.grey.withOpacity(0.05),
          ),
          padding: EdgeInsets.only(
            top: widget.paymentHeight * 0.01,
            left: widget.paymentHeight * 0.01,
            right: widget.paymentHeight * 0.02,
            bottom: widget.paymentHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: Screens.padingHeight(context) * 0.18,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: widget.paymentWidth * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: widget.paymentWidth * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: widget.paymentWidth * 0.18,
                                      child: Text(
                                        "Total Document",
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      ),
                                    ),
                                    Container(
                                        width: widget.paymentWidth * 0.1,
                                        alignment: Alignment.centerRight,
                                        child: context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .selectedcust2 !=
                                                    null ||
                                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getScanneditemData2
                                                    .isNotEmpty
                                            ? Text(
                                                context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getScanneditemData2
                                                    .length
                                                    .toString(),
                                                style: widget
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith())
                                            : context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getScanneditemData
                                                    .isEmpty
                                                ? const Text(
                                                    "0",
                                                  )
                                                : Text(
                                                    context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .getScanneditemData
                                                        .length
                                                        .toString(),
                                                    style: widget.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          context.watch<PayreceiptController>().selectedcust2 !=
                                  null
                              ? Container(
                                  alignment: Alignment.center,
                                  width: widget.paymentWidth * 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: TextFormField(
                                    controller: context
                                        .watch<PayreceiptController>()
                                        .referencemycontroller[3],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                    onChanged: (v) {},
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      filled: false,
                                      labelText: "Remarks",
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: widget.paymentWidth * 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: TextFormField(
                                    controller: context
                                        .watch<PayreceiptController>()
                                        .referencemycontroller[2],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                    onChanged: (v) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ' Please Enter the Remark';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Remarks",
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                          context.watch<PayreceiptController>().selectedcust2 !=
                                  null
                              ? Container(
                                  alignment: Alignment.center,
                                  width: widget.paymentWidth * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: TextFormField(
                                    controller: context
                                        .watch<PayreceiptController>()
                                        .referencemycontroller[1],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                    onChanged: (v) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ' Please Enter the Reference';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Reference",
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  alignment: Alignment.center,
                                  width: widget.paymentWidth * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                  child: TextFormField(
                                    controller: context
                                        .watch<PayreceiptController>()
                                        .referencemycontroller[0],
                                    cursorColor: Colors.grey,
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                    onChanged: (v) {},
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ' Please Enter the Reference';
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: "Reference",
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
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 10,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: widget.paymentWidth * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: widget.paymentWidth * 0.15,
                                child: Text(
                                  "Total Due",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                width: widget.paymentWidth * 0.17,
                                alignment: Alignment.centerRight,
                                child: context
                                                .watch<PayreceiptController>()
                                                .selectedcust2 !=
                                            null ||
                                        context
                                            .watch<PayreceiptController>()
                                            .scanneditemData2
                                            .isNotEmpty
                                    ? Text(
                                        context
                                            .watch<PayreceiptController>()
                                            .config
                                            .splitValues22(context
                                                .watch<PayreceiptController>()
                                                .totalpaidamt2()
                                                .toString()),
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      )
                                    : context
                                                .watch<PayreceiptController>()
                                                .totalduepay ==
                                            0
                                        ? Text(
                                            "0.00",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          )
                                        : Text(
                                            context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .totalduepay !=
                                                    null
                                                ? context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .config
                                                    .splitValues22(context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .totalduepay!
                                                        .toString())
                                                : '',
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: widget.paymentWidth * 0.15,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total Paid",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.17,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    context
                                                .watch<PayreceiptController>()
                                                .selectedcust2 !=
                                            null
                                        ? context
                                                .watch<PayreceiptController>()
                                                .paymentWay2
                                                .isEmpty
                                            ? "0.00"
                                            : context
                                                .watch<PayreceiptController>()
                                                .config
                                                .splitValues(context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getSumTotalPaid33()
                                                    .toStringAsFixed(5))
                                        : context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .advancetype ==
                                                "Advance"
                                            ? context
                                                .watch<PayreceiptController>()
                                                .config
                                                .splitValues(context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getSumTotalPaid()
                                                    .toString())
                                            : context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .paymentWay
                                                    .isEmpty
                                                ? "0.00"
                                                : context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .config
                                                    .splitValues22(context
                                                        .watch<
                                                            PayreceiptController>()
                                                        .getSumTotalPaid()
                                                        .toString()),
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                  )),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: widget.paymentWidth * 0.15,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Balance",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(
                                          color: widget.theme.primaryColor,
                                          fontSize: 16),
                                ),
                              ),
                              Container(
                                width: widget.paymentWidth * 0.17,
                                alignment: Alignment.centerRight,
                                child: context
                                        .watch<PayreceiptController>()
                                        .scanneditemData2
                                        .isNotEmpty
                                    ? context
                                                .watch<PayreceiptController>()
                                                .totalduepay2 ==
                                            0
                                        ? Text(context
                                            .watch<PayreceiptController>()
                                            .config
                                            .splitValues(context
                                                .watch<PayreceiptController>()
                                                .getBalancePaid33()
                                                .toString()))
                                        : Text(
                                            "0.00",
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          )
                                    : context
                                                .watch<PayreceiptController>()
                                                .totalduepay ==
                                            0
                                        ? Text(context
                                            .watch<PayreceiptController>()
                                            .config
                                            .splitValues(context
                                                .watch<PayreceiptController>()
                                                .totalduepay!
                                                .toString()))
                                        : Text(
                                            context
                                                .watch<PayreceiptController>()
                                                .config
                                                .splitValues22(context
                                                    .watch<
                                                        PayreceiptController>()
                                                    .getBalancePaid()
                                                    .toString()),
                                            style: widget
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(),
                                          ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
