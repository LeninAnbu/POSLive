import 'package:flutter/material.dart';

import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesReturnController/SalesReturnController.dart';

class SRAmountCaltnWidget extends StatelessWidget {
  const SRAmountCaltnWidget({
    super.key,
    required this.theme,
    required this.salesReturnController,
  });

  final ThemeData theme;
  final SalesReturnController salesReturnController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Screens.width(context),
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
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.01,
                    left: Screens.width(context) * 0.01,
                    right: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.01),
                width: Screens.width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            salesReturnController.checkstocksetqty();
                          },
                          child: SizedBox(
                            width: Screens.width(context) * 0.3,
                            child: Text(
                              "Total Items",
                              style: theme.textTheme.bodyMedium?.copyWith(),
                            ),
                          ),
                        ),
                        Container(
                            width: Screens.width(context) * 0.6,
                            alignment: Alignment.centerRight,
                            child: salesReturnController.totalPayment == null
                                ? const Text(
                                    "0.00",
                                  )
                                : Text(
                                    salesReturnController
                                        .getScanneditemData.length
                                        .toString(),
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith())),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            salesReturnController.deletealesRet();
                          },
                          child: SizedBox(
                            width: Screens.width(context) * 0.3,
                            child: Text(
                              "Total Quantity", //deletealesRet
                              style: theme.textTheme.bodyMedium?.copyWith(),
                            ),
                          ),
                        ),
                        Container(
                            width: Screens.width(context) * 0.6,
                            alignment: Alignment.centerRight,
                            child: salesReturnController.totalPayment == null
                                ? const Text(
                                    "0.00",
                                  )
                                : Text(
                                    "${salesReturnController.totalPayment!.total}",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith()))
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Total Weight",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Container(
                            width: Screens.width(context) * 0.6,
                            alignment: Alignment.centerRight,
                            child: salesReturnController.totalPayment == null
                                ? const Text("0.00")
                                : Text("0.00",
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith()))
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Total Ltr",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                            width: Screens.width(context) * 0.6,
                            alignment: Alignment.centerRight,
                            child: salesReturnController.totalPayment == null
                                ? const Text("0.00")
                                : Text(
                                    salesReturnController.config
                                        .splitValues("0.00"),
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith()))
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                padding: EdgeInsets.only(
                    top: Screens.padingHeight(context) * 0.01,
                    left: Screens.width(context) * 0.01,
                    right: Screens.width(context) * 0.01,
                    bottom: Screens.padingHeight(context) * 0.01),
                width: Screens.width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Sub Total",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: salesReturnController.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  salesReturnController.config.splitValues(
                                      salesReturnController
                                          .totalPayment!.subtotal!
                                          .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Total Tax",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: salesReturnController.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  salesReturnController.config.splitValues(
                                      salesReturnController
                                          .totalPayment!.totalTX!
                                          .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Discount",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: salesReturnController.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  salesReturnController.config.splitValues(
                                      salesReturnController
                                          .totalPayment!.discount!
                                          .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Total Due",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: salesReturnController.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  salesReturnController.config.splitValues(
                                      salesReturnController
                                          .totalPayment!.totalDue!
                                          .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Total Paid",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: salesReturnController.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  salesReturnController.config.splitValues(
                                      salesReturnController
                                          .getSumTotalPaid2()
                                          .toStringAsFixed(2)),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Screens.width(context) * 0.3,
                          child: Text(
                            "Balance",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: Screens.width(context) * 0.6,
                          alignment: Alignment.centerRight,
                          child: Text(
                            salesReturnController.config.splitValues(
                                salesReturnController
                                    .getBalancePaid2()
                                    .toStringAsFixed(2)),
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: Screens.width(context) * 0.9,
            child: TextFormField(
              controller: salesReturnController.mycontroller[50],
              cursorColor: Colors.grey,
              style: theme.textTheme.bodyMedium?.copyWith(),
              onChanged: (v) {},
              validator: (value) {
                if (value!.isEmpty) {
                  return ' Please Enter the Remark';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                hintText: 'Remarks',
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
    );
  }
}
