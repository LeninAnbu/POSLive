import 'package:flutter/material.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../../Controller/SalesReturnController/SalesReturnController.dart';

class SRPaymentWidget extends StatelessWidget {
  const SRPaymentWidget({super.key, required this.salesReturnController});

  final SalesReturnController salesReturnController;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(Screens.padingHeight(context) * 0.01),
                child: Text(
                  salesReturnController.getpaymentWay.isNotEmpty
                      ? "Payment Method"
                      : '',
                  textAlign: TextAlign.start,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
              ),
              ListView.builder(
                  itemCount: salesReturnController.getpaymentWay.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 2,
                        child: Container(
                            padding: EdgeInsets.only(
                              right: Screens.width(context) * 0.03,
                              left: Screens.width(context) * 0.03,
                              bottom: Screens.padingHeight(context) * 0.01,
                              top: Screens.padingHeight(context) * 0.01,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: Screens.width(context) * 0.25,
                                  child: Text(
                                    '${salesReturnController.getpaymentWay[index].type}',
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  width: Screens.width(context) * 0.28,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${salesReturnController.getpaymentWay[index].reference}',
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    salesReturnController.config.splitValues(
                                        salesReturnController
                                            .getpaymentWay[index].amt!
                                            .toStringAsFixed(2)),
                                    style: theme.textTheme.bodyLarge
                                        ?.copyWith(color: Colors.black),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    salesReturnController.removePayment(index);
                                  },
                                  child: SizedBox(
                                    width: Screens.width(context) * 0.05,
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
            ],
          ),
        ],
      ),
    );
  }
}
