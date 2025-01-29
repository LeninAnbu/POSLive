import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesOrderController/SalesOrderController.dart';

class SOPaymentDetails extends StatefulWidget {
  SOPaymentDetails(
      {super.key,
      required this.theme,
      required this.paymentHeight,
      required this.paymentWidth});
  final ThemeData theme;
  double paymentHeight;
  double paymentWidth;

  @override
  State<SOPaymentDetails> createState() => _SOPaymentDetailsState();
}

class _SOPaymentDetailsState extends State<SOPaymentDetails> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.paymentHeight,
        width: widget.paymentWidth,
        padding: EdgeInsets.only(
          top: widget.paymentHeight * 0.01,
          left: widget.paymentHeight * 0.01,
          right: widget.paymentHeight * 0.01,
          bottom: widget.paymentHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: context.watch<SOCon>().getScanneditemData2.isNotEmpty
                ? Colors.grey[300]
                : Colors.grey.withOpacity(0.05),
          ),
          padding: EdgeInsets.only(
            top: widget.paymentHeight * 0.01,
            left: widget.paymentWidth * 0.01,
            right: widget.paymentWidth * 0.02,
            bottom: widget.paymentHeight * 0.02,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: widget.paymentWidth * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: widget.paymentWidth * 0.35,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.paymentWidth * 0.18,
                                child: Text(
                                  "Total Items",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SOCon>()
                                          .getScanneditemData2
                                          .isNotEmpty
                                      ? context.watch<SOCon>().totalPayment2 ==
                                              null
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SOCon>()
                                                  .getScanneditemData2
                                                  .length
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                      : context
                                              .watch<SOCon>()
                                              .getScanneditemData
                                              .isEmpty
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SOCon>()
                                                  .getScanneditemData
                                                  .length
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: widget.paymentWidth * 0.16,
                                child: Text(
                                  "Total Quantity",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.15,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SOCon>()
                                          .getScanneditemData2
                                          .isNotEmpty
                                      ? context.watch<SOCon>().totalPayment2 ==
                                              null
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SOCon>()
                                                  .totalPayment2!
                                                  .total!
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())
                                      : context.watch<SOCon>().totalPayment ==
                                                  null ||
                                              context
                                                  .watch<SOCon>()
                                                  .getScanneditemData
                                                  .isEmpty
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SOCon>()
                                                  .totalPayment!
                                                  .total!
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith()))
                            ],
                          ),
                        ],
                      ),
                    ),
                    context.watch<SOCon>().getScanneditemData2.isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: widget.paymentWidth * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: TextFormField(
                              controller:
                                  context.watch<SOCon>().mycontroller2[50],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
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
                          )
                        : Container(
                            alignment: Alignment.center,
                            width: widget.paymentWidth * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: TextFormField(
                              controller:
                                  context.watch<SOCon>().remarkcontroller3,
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
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
              ),
              SizedBox(
                width: widget.paymentWidth * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Sub Total",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SOCon>()
                                  .scanneditemData2
                                  .isNotEmpty
                              ? context.watch<SOCon>().totalPayment2 == null
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment2!
                                              .subtotal!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                              : context.watch<SOCon>().totalPayment == null ||
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment!
                                              .subtotal!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Discount",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SOCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? context.watch<SOCon>().totalPayment2 == null
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment2!
                                              .discount!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                              : context.watch<SOCon>().totalPayment == null ||
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment!
                                              .discount!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Taxable",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SOCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? context.watch<SOCon>().totalPayment2 == null
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment2!
                                              .taxable!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                              : context.watch<SOCon>().totalPayment == null ||
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment!
                                              .taxable!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widget.paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Tax",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SOCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? context.watch<SOCon>().totalPayment2 == null
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment2!
                                              .totalTX!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                              : context.watch<SOCon>().totalPayment == null ||
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment!
                                              .totalTX!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: widget.paymentWidth * 0.15,
                          child: Text(
                            "Total Due",
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                  .watch<SOCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? context.watch<SOCon>().totalPayment2 == null
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment2!
                                              .totalDue!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                              : context.watch<SOCon>().totalPayment == null ||
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .totalPayment!
                                              .totalDue!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
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
                            style:
                                widget.theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: widget.paymentWidth * 0.25,
                          alignment: Alignment.centerRight,
                          child: context
                                      .watch<SOCon>()
                                      .scanneditemData2
                                      .isNotEmpty &&
                                  context.watch<SOCon>().totalPayment2 != null
                              ? Text(
                                  context.watch<SOCon>().config.splitValues(
                                      context
                                          .watch<SOCon>()
                                          .getSumTotalPaid2()
                                          .toStringAsFixed(2)),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              // : context.watch<SOCon>().tottpaid != null
                              //     ? Text(context
                              //         .watch<SOCon>()
                              //         .config
                              //         .splitValues(context
                              //             .watch<SOCon>()
                              //             .tottpaid!
                              //             .toStringAsFixed(2)))
                              //     : const Text("0.00")
                              : context.watch<SOCon>().totalPayment != null &&
                                      context
                                          .watch<SOCon>()
                                          .getScanneditemData
                                          .isNotEmpty
                                  ? Text(
                                      context.watch<SOCon>().config.splitValues(
                                          context
                                              .watch<SOCon>()
                                              .getSumTotalPaid()
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    )
                                  // : context.watch<SOCon>().tottpaid != null
                                  //     ? Text(context
                                  //         .watch<SOCon>()
                                  //         .config
                                  //         .splitValues(context
                                  //             .watch<SOCon>()
                                  //             .tottpaid!
                                  //             .toStringAsFixed(2)))
                                  : const Text("0.00"),
                        ),
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
                            style: widget.theme.textTheme.bodyMedium?.copyWith(
                                color: widget.theme.primaryColor, fontSize: 16),
                          ),
                        ),
                        Container(
                            width: widget.paymentWidth * 0.25,
                            alignment: Alignment.centerRight,
                            child: context
                                        .watch<SOCon>()
                                        .getScanneditemData2
                                        .isNotEmpty &&
                                    context.watch<SOCon>().totalPayment2 != null
                                ? Text(
                                    context.watch<SOCon>().config.splitValues(
                                        context
                                            .watch<SOCon>()
                                            .getBalancePaid2()
                                            .toStringAsFixed(2)),
                                  )
                                : context.watch<SOCon>().totalPayment != null &&
                                        context
                                            .watch<SOCon>()
                                            .getScanneditemData
                                            .isNotEmpty
                                    ? Text(
                                        context
                                            .watch<SOCon>()
                                            .config
                                            .splitValues(context
                                                .watch<SOCon>()
                                                .getBalancePaid()
                                                .toStringAsFixed(2)),
                                        style: widget.theme.textTheme.bodyMedium
                                            ?.copyWith(),
                                      )
                                    : const Text("0.00")),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
