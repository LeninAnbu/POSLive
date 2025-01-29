import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesInvoice/SalesInvoiceController.dart';

class AmtCalCulationWidget extends StatelessWidget {
  const AmtCalCulationWidget({
    super.key,
    required this.theme,
    required this.prdCD,
  });

  final ThemeData theme;
  final PosController prdCD;

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
        children: [
          Column(
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
                                : Text(
                                    prdCD.getScanneditemData.length.toString(),
                                    // "${prdPmt.totalPayment!.total!.toStringAsFixed(0)}",
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
                            child: prdCD.totalPayment == null
                                ? const Text("0.00")

                                // Container()
                                : Text(("0.00"),
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
                            child: prdCD.totalPayment == null
                                ? const Text("0.00")

                                // Container()
                                : Text("0.00",
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
                                  prdCD.config.splitValues(prdCD
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
                                  prdCD.config.splitValues(prdCD
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
                                  prdCD.config.splitValues(prdCD
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
                                  prdCD.config.splitValues(prdCD
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
                                  prdCD.config.splitValues(prdCD
                                      .getSumTotalPaid()
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
                          child: prdCD.totalPayment == null
                              ? const Text("0.00")
                              : Text(
                                  prdCD.config.splitValues(prdCD
                                      .getBalancePaid()
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
          Container(
            alignment: Alignment.center,

            // height: cashHeight * 0.2,
            width: Screens.width(context) * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.grey.withOpacity(0.01),
            ),
            child: TextFormField(
              controller: prdCD.mycontroller[50],
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
