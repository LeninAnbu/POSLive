import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/SalesQuotationController/SalesQuotationController.dart';

class SQuotationPayDetails extends StatefulWidget {
  SQuotationPayDetails(
      {super.key,
      required this.theme,
      required this.paymentHeight,
      required this.paymentWidth});
  final ThemeData theme;
  double paymentHeight;
  double paymentWidth;

  @override
  State<SQuotationPayDetails> createState() => _SQuotationPayDetailsState();
}

class _SQuotationPayDetailsState extends State<SQuotationPayDetails> {
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
            color: context
                    .watch<SalesQuotationCon>()
                    .getScanneditemData2
                    .isNotEmpty
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
                      width: widget.paymentWidth * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: context
                                        .watch<SalesQuotationCon>()
                                        .getScanneditemData2
                                        .isNotEmpty
                                    ? null
                                    : () {
                                        context
                                            .watch<SalesQuotationCon>()
                                            .checkstocksetqty();
                                      },
                                child: SizedBox(
                                  width: widget.paymentWidth * 0.18,
                                  child: Text(
                                    "Total Items",
                                    style: widget.theme.textTheme.bodyMedium
                                        ?.copyWith(),
                                  ),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData2
                                          .isNotEmpty
                                      ? Text(
                                          context
                                              .watch<SalesQuotationCon>()
                                              .getScanneditemData2
                                              .length
                                              .toString(),
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith())
                                      : context
                                                      .watch<
                                                          SalesQuotationCon>()
                                                      .totalPayment ==
                                                  null &&
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getScanneditemData
                                                  .isEmpty
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .getScanneditemData
                                                  .length
                                                  .toString(),
                                              style: widget
                                                  .theme.textTheme.bodyMedium
                                                  ?.copyWith())),
                            ],
                          ),
                          SizedBox(height: widget.paymentHeight * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: widget.paymentWidth * 0.18,
                                child: Text(
                                  "Total Quantity",
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                ),
                              ),
                              Container(
                                  width: widget.paymentWidth * 0.1,
                                  alignment: Alignment.centerRight,
                                  child: context
                                              .watch<SalesQuotationCon>()
                                              .getScanneditemData2
                                              .isNotEmpty &&
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2 !=
                                              null
                                      ? Text(
                                          context.watch<SalesQuotationCon>().totalPayment2 != null &&
                                                  (context.watch<SalesQuotationCon>().totalPayment2!.total != null ||
                                                      context.watch<SalesQuotationCon>().totalPayment2!.total !=
                                                          'null')
                                              ? context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2!
                                                  .total!
                                                  .toString()
                                              : '0.00',
                                          style: widget
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith())
                                      : context
                                                  .watch<SalesQuotationCon>()
                                                  .getScanneditemData
                                                  .isEmpty &&
                                              context.watch<SalesQuotationCon>().totalPayment ==
                                                  null
                                          ? const Text(
                                              "0",
                                            )
                                          : Text(
                                              context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment!
                                                  .total!
                                                  .toString(),
                                              style: widget.theme.textTheme.bodyMedium?.copyWith()))
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                    context
                            .watch<SalesQuotationCon>()
                            .getScanneditemData2
                            .isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            width: widget.paymentWidth * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: TextFormField(
                              controller: context
                                  .watch<SalesQuotationCon>()
                                  .mycontroller2[50],
                              cursorColor: Colors.grey,
                              style:
                                  widget.theme.textTheme.bodyMedium?.copyWith(),
                              onChanged: (v) {},
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: false,
                                labelText: "Remark",
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
                              controller: context
                                  .watch<SalesQuotationCon>()
                                  .remarkcontroller3,
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
                                 isDense: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10,
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
                                  .watch<SalesQuotationCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? Text(
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2 !=
                                              null &&
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2!
                                                  .subtotal !=
                                              null
                                      ? context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .subtotal!
                                              .toStringAsFixed(2))
                                      : '0.00',
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment ==
                                          null &&
                                      context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
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
                                  .watch<SalesQuotationCon>()
                                  .getScanneditemData2
                                  .isNotEmpty
                              ? Text(
                                  context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2 !=
                                              null &&
                                          context
                                                  .watch<SalesQuotationCon>()
                                                  .totalPayment2!
                                                  .discount !=
                                              null
                                      ? context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .discount!
                                              .toStringAsFixed(2))
                                      : '0.00',
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment ==
                                          null &&
                                      context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
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
                                      .watch<SalesQuotationCon>()
                                      .getScanneditemData2
                                      .isNotEmpty &&
                                  context
                                          .watch<SalesQuotationCon>()
                                          .totalPayment2 !=
                                      null
                              ? Text(
                                  context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .taxable ==
                                          null
                                      ? ''
                                      : context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .taxable!
                                              .toStringAsFixed(2)),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment ==
                                          null &&
                                      context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
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
                                      .watch<SalesQuotationCon>()
                                      .getScanneditemData2
                                      .isNotEmpty &&
                                  context
                                          .watch<SalesQuotationCon>()
                                          .totalPayment2 !=
                                      null
                              ? Text(
                                  context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .totalTX ==
                                          null
                                      ? ''
                                      : context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .totalTX!
                                              .toStringAsFixed(2)),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment ==
                                          null &&
                                      context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
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
                                      .watch<SalesQuotationCon>()
                                      .getScanneditemData2
                                      .isNotEmpty &&
                                  context
                                          .watch<SalesQuotationCon>()
                                          .totalPayment2 !=
                                      null
                              ? Text(
                                  context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .totalDue ==
                                          null
                                      ? ''
                                      : context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment2!
                                              .totalDue!
                                              .toStringAsFixed(2)),
                                  style: widget.theme.textTheme.bodyMedium
                                      ?.copyWith(),
                                )
                              : context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment ==
                                          null &&
                                      context
                                          .watch<SalesQuotationCon>()
                                          .getScanneditemData
                                          .isEmpty
                                  ? const Text("0.00")
                                  : Text(
                                      context
                                          .watch<SalesQuotationCon>()
                                          .config
                                          .splitValues(context
                                              .watch<SalesQuotationCon>()
                                              .totalPayment!
                                              .totalDue!
                                              .toStringAsFixed(2)),
                                      style: widget.theme.textTheme.bodyMedium
                                          ?.copyWith(),
                                    ),
                        )
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
