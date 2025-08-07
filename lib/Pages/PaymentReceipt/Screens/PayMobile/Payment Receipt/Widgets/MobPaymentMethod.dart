import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import '../../../../../../Controller/PaymentReceiptController/PayReceiptController.dart';

class MobPaymentMethod extends StatelessWidget {
  const MobPaymentMethod({
    super.key,
    required this.prdCD,
    required this.theme,
  });

  final PayreceiptController prdCD;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return prdCD.getpaymentWay.isEmpty
        ? Container()
        : Container(
            padding: EdgeInsets.only(
                top: Screens.padingHeight(context) * 0.01,
                left: Screens.width(context) * 0.01,
                right: Screens.width(context) * 0.01,
                bottom: Screens.padingHeight(context) * 0.01),
            width: Screens.width(context),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(Screens.padingHeight(context) * 0.01),
                  child: Text(
                    prdCD.getpaymentWay.isNotEmpty ? "Payment Method" : '',
                    textAlign: TextAlign.start,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                ListView.builder(
                    itemCount: prdCD.getpaymentWay.length,
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
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: Screens.width(context) * 0.25,
                                    child: Text(
                                      '${prdCD.getpaymentWay[index].type}',
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    width: Screens.width(context) * 0.28,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      prdCD.getpaymentWay[index].reference ==
                                              null
                                          ? '${prdCD.getpaymentWay[index].reference}'
                                          : "",
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      prdCD.config.splitValues(prdCD
                                          .getpaymentWay[index].amt!
                                          .toStringAsFixed(2)),
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      prdCD.removePayment(index);
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
          );
  }
}
