import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class MobPayReceiptDetails extends StatelessWidget {
  MobPayReceiptDetails({
    super.key,
    required this.theme,
    required this.prdPmt,
  });
  final ThemeData theme;
  PayreceiptController prdPmt;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: Screens.padingHeight(context) * 0.13,
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
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey.withOpacity(0.05),
              ),
              padding: EdgeInsets.only(
                  top: Screens.padingHeight(context) * 0.01,
                  left: Screens.width(context) * 0.01,
                  right: Screens.width(context) * 0.01,
                  bottom: Screens.padingHeight(context) * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Total Document",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      Container(
                          width: Screens.width(context) * 0.1,
                          alignment: Alignment.centerRight,
                          child: prdPmt.getScanneditemData.isEmpty
                              ? const Text(
                                  "0",
                                )
                              : Text(
                                  prdPmt.getScanneditemData.length.toString(),
                                  style:
                                      theme.textTheme.bodyMedium?.copyWith())),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Total Due",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: prdPmt.getScanneditemData.isEmpty
                            ? Text(
                                "0.00",
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              )
                            : Text(
                                prdPmt.totalduepay!.toStringAsFixed(2),
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Total Paid",
                          style: theme.textTheme.bodyMedium?.copyWith(),
                        ),
                      ),
                      Container(
                        width: Screens.width(context) * 0.17,
                        alignment: Alignment.centerRight,
                        child: prdPmt.totalduepay == 0
                            ? const Text("0.00")
                            : Text(
                                prdPmt.getSumTotalPaid().toStringAsFixed(2),
                                style: theme.textTheme.bodyMedium?.copyWith(),
                              ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Balance",
                          style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.primaryColor, fontSize: 16),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: prdPmt.getScanneditemData.isEmpty
                            ? const Text("0.00")
                            : prdPmt.totalduepay == 0
                                ? Text(prdPmt.config
                                    .splitValues(prdPmt.totalduepay.toString()))
                                : Text(
                                    prdPmt.getBalancePaid().toStringAsFixed(2),
                                    style:
                                        theme.textTheme.bodyMedium?.copyWith(),
                                  ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: Screens.width(context) * 0.9,
              child: TextFormField(
                controller: prdPmt.mycontroller[50],
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
        ));
  }
}
