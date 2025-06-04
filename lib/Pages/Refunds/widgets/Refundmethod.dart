import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Controller/RefundsController/RefundController.dart';

class RefundPayDetails extends StatelessWidget {
  RefundPayDetails(
      {super.key,
      required this.theme,
      required this.paymentHeight,
      required this.paymentWidth});
  final ThemeData theme;

  double paymentHeight;
  double paymentWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: paymentHeight,
        width: paymentWidth,
        padding: EdgeInsets.only(
          top: paymentHeight * 0.03,
          left: paymentHeight * 0.01,
          right: paymentHeight * 0.01,
          bottom: paymentHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.withOpacity(0.05),
          ),
          padding: EdgeInsets.only(
            top: paymentHeight * 0.01,
            left: paymentHeight * 0.01,
            right: paymentHeight * 0.02,
            bottom: paymentHeight * 0.02,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: paymentWidth * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              context
                                  .read<RefundController>()
                                  .deleterefundtable();
                            },
                            child: SizedBox(
                              width: paymentWidth * 0.18,
                              child: Text(
                                "Total Document",
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              ),
                            )),
                        Container(
                            width: paymentWidth * 0.1,
                            alignment: Alignment.centerRight,
                            child: context
                                        .read<RefundController>()
                                        .getScanneditemData
                                        .length <
                                    0
                                ? const Text(
                                    "0",
                                  )
                                : Text(
                                    context
                                        .watch<RefundController>()
                                        .getScanneditemData
                                        .length
                                        .toString(),
                                    style: theme.textTheme.bodyMedium
                                        ?.copyWith())),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: paymentWidth * 0.39,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          width: paymentWidth * 0.15,
                          child: Text(
                            "Total Due",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context.read<RefundController>().totalduepay ==
                                  null
                              ? Text(
                                  "0.00",
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                )
                              : Text(
                                  context
                                      .watch<RefundController>()
                                      .totalduepay!
                                      .toStringAsFixed(2),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Paid",
                            style: theme.textTheme.bodyMedium?.copyWith(),
                          ),
                        ),
                        Container(
                          width: paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context.read<RefundController>().totalduepay ==
                                  0
                              ? const Text("0.00")
                              : Text(
                                  context
                                      .watch<RefundController>()
                                      .getSumTotalPaid()
                                      .toStringAsFixed(2),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: paymentWidth * 0.15,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Balance",
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.primaryColor, fontSize: 16),
                          ),
                        ),
                        Container(
                          width: paymentWidth * 0.17,
                          alignment: Alignment.centerRight,
                          child: context.read<RefundController>().totalduepay ==
                                  0
                              ? Text(
                                  context
                                      .watch<RefundController>()
                                      .totalduepay!
                                      .toStringAsFixed(2),
                                )
                              : Text(
                                  context
                                      .watch<RefundController>()
                                      .getBalancePaid()
                                      .toStringAsFixed(2),
                                  style: theme.textTheme.bodyMedium?.copyWith(),
                                ),
                        ),
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
