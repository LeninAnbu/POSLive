import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesOrderController/SalesOrderController.dart';

class AmtCalCulationWidget extends StatelessWidget {
  const AmtCalCulationWidget({
    super.key,
    required this.theme,
    required this.prdCD,
  });

  final ThemeData theme;
  final SOCon prdCD;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Screens.padingHeight(context) * 0.01,
          left: Screens.width(context) * 0.01,
          right: Screens.width(context) * 0.01,
          bottom: Screens.padingHeight(context) * 0.01),
      width: Screens.width(context),
      // height: Screens.padingHeight(context) * 0.4,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //           Container(
          // padding: EdgeInsets.only(

          //       left: Screens.width(context) * 0.01,
          //       right: Screens.width(context) * 0.01,
          //       bottom: Screens.padingHeight(context) * 0.01),
          // child: Text(
          //   "Payment Details",
          //   textAlign: TextAlign.start,
          //   style: theme.textTheme.bodyMedium?.copyWith(
          //     color: theme.primaryColor,
          //   ),
          // ),
          //             ),

          Container(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.01,
                right: Screens.width(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.01),
            width: Screens.width(context),
            // height: paymentHeight * 0.11,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: Screens.width(context) * 0.3,
                      child: Text(
                        "Total Items",
                        style: theme.textTheme.bodyMedium?.copyWith(),
                      ),
                    ),
                    Container(
                        width: Screens.width(context) * 0.6,
                        alignment: Alignment.centerRight,
                        child: prdCD.totalPayment == null
                            ? const Text(
                                "0.00",
                              )
                            // Container()
                            : Text(prdCD.getScanneditemData.length.toString(),
                                // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
                                style: theme.textTheme.bodyMedium?.copyWith())),
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
                        "Total Quantity",
                        style: theme.textTheme.bodyMedium?.copyWith(),
                      ),
                    ),
                    Container(
                        width: Screens.width(context) * 0.6,
                        alignment: Alignment.centerRight,
                        child: prdCD.totalPayment == null
                            ? const Text(
                                "0.00",
                              )

                            // Container()
                            : Text("${prdCD.totalPayment!.total!}",
                                // "${prdPmt.totalPayment!.discount!.toStringAsFixed(0)}",
                                style: theme.textTheme.bodyMedium?.copyWith()))
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
                        child: prdCD.totalPayment == null
                            ? const Text("0.00")

                            // Container()
                            : Text(("0.00"),
                                style: theme.textTheme.bodyMedium?.copyWith()))
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
                        child: prdCD.totalPayment == null
                            ? const Text("0.00")

                            // Container()
                            : Text("0.00",
                                style: theme.textTheme.bodyMedium?.copyWith()))
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
            // height: paymentHeight * 0.11,
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
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(prdCD
                                  .totalPayment!.subtotal!
                                  .toStringAsFixed(2)),
                              // "${prdPmt.totalPayment!.subtotal!.toStringAsFixed(2)}",
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
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(prdCD
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
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(prdCD
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
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(prdCD
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
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(
                                  prdCD.getSumTotalPaid().toStringAsFixed(2)),
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
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: theme.primaryColor, fontSize: 16),
                      ),
                    ),
                    Container(
                      width: Screens.width(context) * 0.6,
                      alignment: Alignment.centerRight,
                      child: prdCD.totalPayment == null
                          ? const Text("0.00")
                          : Text(
                              prdCD.config.slpitCurrency2(
                                  prdCD.getBalancePaid().toStringAsFixed(2)),
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
    );
  }
}
